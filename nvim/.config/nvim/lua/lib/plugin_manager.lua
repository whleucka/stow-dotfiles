local log = require("lib.utils").log
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

-- Run async shell command
local function async_shell(opts)
  local uv = vim.loop
  local cmd = opts.cmd                -- e.g. "git"
  local args = opts.args or {}        -- e.g. { "clone", "url", "dir" }
  local cwd = opts.cwd or nil         -- optional working directory
  local on_exit = opts.on_exit        -- optional callback(code, signal)

  local stdout = uv.new_pipe(false)
  local stderr = uv.new_pipe(false)

  local handle
  handle = uv.spawn(cmd, {
    args = args,
    cwd = cwd,
    stdio = { nil, stdout, stderr },
  }, function(code, signal)
    stdout:close()
    stderr:close()
    handle:close()

    vim.schedule(function()
      if on_exit then
        on_exit(code, signal)
      else
        if code == 0 then
          log.success(cmd .. " finished successfully")
        else
          log.error(cmd .. " exited with code " .. code)
        end
      end
    end)
  end)

  stdout:read_start(function(err, data)
    if err then
      vim.schedule(function()
        log.error("STDOUT error: " .. err)
      end)
    elseif data then
      vim.schedule(function()
        log.package(data)
      end)
    end
  end)

  stderr:read_start(function(err, data)
    if err then
      vim.schedule(function()
        log.error("STDERR error: " .. err)
      end)
    elseif data then
      vim.schedule(function()
        log.package(data)
      end)
    end
  end)
end

-- Build plugin
local function build(plugin)
  async_shell({
    cmd = plugin.build.cmd,
    cwd = plugin.path,
    args = plugin.build.args,
    on_exit = function(code, signal)
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
    async_shell({
      cmd = "git",
      args = {
        "clone",
        "--quiet",
        plugin.url,
        plugin.path
      },
      on_exit = function(code, signal)
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
    async_shell({
      cmd = "git",
      args = {
        "-C",
        plugin.path,
        "pull",
        "--quiet"
      },
      on_exit = function(code, signal)
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
  for _,plugin in ipairs(plugins) do
    -- Install dependencies
    if plugin.dependencies then
      install(plugin.dependencies)
    end
    -- Install plugin
    clone_plugin(plugin)
  end
end

-- Run a plugin config
local function run_config(plugin)
  local ok, err = pcall(plugin.config)
  if not ok then
    log.error(string.format("Error in config for %s: %s", plugin.name, err))
    print(vim.inspect(plugin.config))
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
  for _,plugin in ipairs(plugins) do
    if plugin_exists(plugin) then
      -- Load dependencies
      if plugin.dependencies then
        load(plugin.dependencies)
      end
      -- Load plugin
      if plugin.config then
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
      vim.notify(spacer .. "└─ " .. plugin.name)
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
      vim.notify("   └─ " .. name)
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
end

-- Commands
vim.api.nvim_create_user_command("PluginInstall", cmd_install, {})
vim.api.nvim_create_user_command("PluginUpdate", cmd_update, {})
vim.api.nvim_create_user_command("PluginList", cmd_list, {})
vim.api.nvim_create_user_command("PluginClean", cmd_clean, {})
vim.api.nvim_create_user_command("PluginSync", cmd_sync, {})

return M
