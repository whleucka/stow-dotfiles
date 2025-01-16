return {
    "nvim-neotest/neotest",
    lazy = true,
    dependencies = {
        "nvim-neotest/nvim-nio",
        "nvim-lua/plenary.nvim",
        "antoinemadec/FixCursorHold.nvim",
        "nvim-treesitter/nvim-treesitter",
        "olimorris/neotest-phpunit",
    },
    config = function()
        require("neotest").setup({
            adapters = {
                require("neotest-phpunit"),
            },
        })
        require("neotest-phpunit")({
            phpunit_cmd = function()
                return "vendor/bin/phpunit"
            end,
        })
    end,
    keys = {
        {
            "<leader>tr",
            function()
                require("neotest").run.run()
            end,
            desc = "Run the nearest test",
        },
        {
            "<leader>tS",
            function()
                require("neotest").run.stop()
            end,
            desc = "Stop the nearest test",
        },
        {
            "<leader>ta",
            function()
                require("neotest").run.attach()
            end,
            desc = "Attach the nearest test",
        },
        {
            "<leader>tf",
            function()
                require("neotest").run.run(vim.fn.expand("%"))
            end,
            desc = "Run the current file",
        },
        {
            "<leader>tt",
            function()
                require("neotest").run.run({ suite = true })
            end,
            desc = "Run the test suite",
        },
        {
            "<leader>to",
            function()
                require("neotest").output_panel.toggle()
            end,
            desc = "Toggle the output panel",
        },
        {
            "<leader>ts",
            function()
                require("neotest").summary.toggle()
            end,
            desc = "Toggle the test summary",
        },
    },
}
