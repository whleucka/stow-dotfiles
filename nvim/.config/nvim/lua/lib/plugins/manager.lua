local log = require("lib.plugins.utils").log
local cmd = require("lib.plugins.utils").command
local M = {}

-- Get plugins from config
local function get_plugins()
  return require("core.plugins").config.plugins
end

-- Get the plugin path
local function get_plugin_path(data_path, name)
  return string.format("%s/%s", data_path, name)
end

-- Is the plugin installed?
local function plugin_exists(plugin)
  return vim.fn.isdirectory(plugin.path) == 1
end

-- Build plugin
local function build(plugin)
  cmd.async({
    cmd = plugin.build.cmd,
    cwd = plugin.path,
    args = plugin.build.args,
    -- Output build in log
    on_stdout = function(data, err)
      if err then
        log.error(string.format("[%s] build error: %s", plugin.name, err))
      elseif data then
        log.package(string.format("[%s] %s", plugin.name, data))
      end
    end,
    -- Cargo output will be stderr, for eg.
    on_stderr = function(data, err)
      if err then
        log.error(string.format("[%s] build error: %s", plugin.name, err))
      elseif data then
        log.package(string.format("[%s] %s", plugin.name, data))
      end
    end,
    on_exit = function(code)
      if code == 0 then
        log.success(string.format("[%s] Successfully built %s", plugin.name, plugin.path))
      else
        log.error("Build exited with code " .. code)
      end
    end
  })
end

-- Git clone plugin
local function clone_plugin(plugin)
  if not plugin_exists(plugin) then
    cmd.async({
      cmd = "git",
      args = {
        "clone",
        "--quiet",
        plugin.url,
        plugin.path
      },
      on_exit = function(code)
        if code == 0 then
          log.success(string.format("[%s] Successfully installed %s", plugin.name, plugin.path))
          if plugin.build then
            build(plugin)
          end
        else
          log.error("Git clone exited with code " .. code)
        end
      end,
    })
  else
    log.info(plugin.name .. " is already installed")
  end
end

-- Get plugin SHA hash
local function get_current_sha(plugin)
  local handle = io.popen(string.format("git -C %s rev-parse HEAD", plugin.path))
  if handle ~= nil then
    local sha = handle:read("*l")
    handle:close()
    return sha
  end
end

-- Git pull plugin
local function pull_plugin(plugin)
  if plugin_exists(plugin) then
    local old_sha = get_current_sha(plugin)
    cmd.async({
      cmd = "git",
      args = {
        "-C",
        plugin.path,
        "pull",
        "--quiet"
      },
      on_exit = function(code)
        if code == 0 then
          local new_sha = get_current_sha(plugin)
          if old_sha ~= new_sha then
            log.success(string.format("[%s] Successfully updated %s", plugin.name, plugin.path))
            if plugin.build then
              build(plugin)
            end
          else
            log.info(string.format("[%s] Already up to date", plugin.name))
          end
        else
          log.error("Git pull exited with code " .. code)
        end
      end,
    })
  else
    log.info(plugin.name .. " is not installed")
  end
end

-- Install plugins recursively
local function install(plugins)
  for _, plugin in ipairs(plugins) do
    -- Install dependencies
    if plugin.dependencies then
      install(plugin.dependencies)
    end
    -- Install plugin
    clone_plugin(plugin)
  end
end

-- Load a plugin and run config
local function run_config(plugin)
  local ok, err = pcall(plugin.config)
  if not ok then
    log.error(string.format("Error in config for %s: %s", plugin.name, err))
    print(vim.inspect(plugin.config))
  end
end

-- Load plugin on event
local function run_event(plugin)
  for _, event in ipairs(type(plugin.event) == "table" and plugin.event or { plugin.event }) do
    local group = vim.api.nvim_create_augroup("plugin_event_" .. plugin.name, { clear = true })
    vim.api.nvim_create_autocmd(event, {
      group = group,
      once = true,
      callback = function()
        vim.opt.runtimepath:append(plugin.path)
        if plugin.config then
          run_config(plugin)
        end
      end,
    })
  end
end

-- Load plugins recursively
local function load(plugins)
  -- Sort the plugins by priority (higher priority loads first)
  table.sort(plugins, function(a, b)
    local a_p = a.priority or 0
    local b_p = b.priority or 0
    return a_p > b_p
  end)
  for _, plugin in ipairs(plugins) do
    if plugin_exists(plugin) then
      -- Load dependencies
      if plugin.dependencies then
        load(plugin.dependencies)
      end
      if plugin.event then
        -- Load plugin on event
        run_event(plugin)
      elseif plugin.config then
        -- Load plugin immediately
        run_config(plugin)
      end
    end
  end
end

-- Display plugins recursively
local function list(plugins, depth)
  local spacer = string.rep(" ", depth)
  for _, plugin in ipairs(plugins or {}) do
    if plugin_exists(plugin) then
      log.notify(spacer .. "└─ " .. plugin.name)
    end
    if plugin.dependencies then
      list(plugin.dependencies, depth + 3)
    end
  end
end

-- Recursively build list of expected plugins
local function get_expected(plugins, expected)
  for _, plugin in ipairs(plugins or {}) do
    if plugin.dependencies then
      expected = get_expected(plugin.dependencies, expected)
    end
    -- Insert into expected
    local key = plugin.name
    expected[key] = true
  end
  return expected
end

-- Update plugins recursively
local function update(plugins)
  for _, plugin in ipairs(plugins or {}) do
    -- Update dependencies
    if plugin.dependencies then
      update(plugin.dependencies)
    end
    -- Update plugin
    pull_plugin(plugin)
  end
end


-- Command functions

-- Install plugins command
local function cmd_install()
  log.info("Installing plugins. Please wait...")
  local plugins = get_plugins()
  install(plugins)
end

-- Update plugins command
local function cmd_update()
  log.info("Updating plugins. Please wait...")
  local plugins = get_plugins()
  update(plugins)
end

-- List plugins command
local function cmd_list()
  log.info("Plugins")
  local plugins = get_plugins()
  list(plugins, 2)
end

-- Remove unused plugins command
local function cmd_clean()
  local removed = {}
  local plugins = get_plugins()
  local expected = get_expected(plugins, {})
  local data_path = require("core.plugins").config.data_path
  for _, name in ipairs(vim.fn.readdir(data_path)) do
    local key = name
    if not expected[key] then
      local plugin_path = get_plugin_path(data_path, name)
      vim.fn.delete(plugin_path, "rf")
      table.insert(removed, key)
    end
  end

  if #removed > 0 then
    log.info("Removed unused plugins:")
    for _, name in ipairs(removed) do
      log.notify("   └─ " .. name)
    end
  else
    log.success("No unused plugins to clean.")
  end
end

-- Clean, Install, Update plugins command
local function cmd_sync()
  cmd_clean()
  cmd_install()
  cmd_update()
end

-- Load plugins
function M.load_plugins()
  local plugins = get_plugins()
  load(plugins)
  --log.system("Loaded " .. #plugins .. " plugins")
end

-- Commands
vim.api.nvim_create_user_command("PluginInstall", cmd_install, {})
vim.api.nvim_create_user_command("PluginUpdate", cmd_update, {})
vim.api.nvim_create_user_command("PluginList", cmd_list, {})
vim.api.nvim_create_user_command("PluginClean", cmd_clean, {})
vim.api.nvim_create_user_command("PluginSync", cmd_sync, {})

return M
