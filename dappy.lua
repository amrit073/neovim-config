-- -- setup adapters
-- require('dap-vscode-js').setup({
--     adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' },
-- })

require('dap-python').setup("/usr/bin/python")
local dap = require('dap')


-- -- custom adapter for running tasks before starting debug
-- local custom_adapter = 'pwa-node-custom'
-- dap.adapters[custom_adapter] = function(cb, config)
--     if config.preLaunchTask then
--         local async = require('plenary.async')
--         local notify = require('notify').async
--
--         async.run(function()
--             ---@diagnostic disable-next-line: missing-parameter
--             notify('Running [' .. config.preLaunchTask .. ']').events.close()
--         end, function()
--             vim.fn.system(config.preLaunchTask)
--             config.type = 'pwa-node'
--             dap.run(config)
--         end)
--     end
-- end

-- -- language config
-- for _, language in ipairs({ 'typescript', 'javascript' }) do
--     dap.configurations[language] = {
--         {
--             name = 'Launch',
--             type = 'pwa-node',
--             request = 'launch',
--             runtimeArgs = { "--nolazy", "-r", "ts-node/register/transpile-only" },
--             program = '${file}',
--             rootPath = '${workspaceFolder}',
--             cwd = '${workspaceFolder}',
--             sourceMaps = true,
--             skipFiles = { '<node_internals>/**' },
--             protocol = 'inspector',
--             console = 'integratedTerminal',
--             env = {
--                 NODE_ENV = 'development'
--             }
--         },
--         {
--             type = "pwa-node",
--             request = "launch",
--             name = "simple",
--             -- trace = true, -- include debugger info
--             runtimeExecutable = "yarn",
--             runtimeArgs = {
--                 "start:web"
--             },
--             rootPath = "${workspaceFolder}",
--             cwd = "${workspaceFolder}",
--             console = "integratedTerminal",
--             internalConsoleOptions = "neverOpen",
--             env = {
--                 NODE_ENV = 'development'
--             }
--         },
--         {
--             type = "pwa-node",
--             request = "launch",
--             name = "Debug Mocha Tests",
--             -- trace = true, -- include debugger info
--             runtimeExecutable = "npm",
--             runtimeArgs = {
--                 "run", "test"
--             },
--             rootPath = "${workspaceFolder}",
--             cwd = "${workspaceFolder}",
--             console = "integratedTerminal",
--             internalConsoleOptions = "neverOpen",
--             env = {
--                 NODE_ENV = 'development'
--             }
--         }
--     }
-- end
--

local dapui = require('dapui')

dapui.setup({
    icons = { expanded = "▾", collapsed = "▸", current_frame = "▸" },
    mappings = {
        -- Use a table to apply multiple mappings
        expand = { "<CR>", "<2-LeftMouse>" },
        open = "o",
        remove = "d",
        edit = "e",
        repl = "r",
        toggle = "t",
    },
    -- Expand lines larger than the window
    -- Requires >= 0.7
    expand_lines = vim.fn.has("nvim-0.7"),
    -- Layouts define sections of the screen to place windows.
    -- The position can be "left", "right", "top" or "bottom".
    -- The size specifies the height/width depending on position. It can be an Int
    -- or a Float. Integer specifies height/width directly (i.e. 20 lines/columns) while
    -- Float value specifies percentage (i.e. 0.3 - 30% of available lines/columns)
    -- Elements are the elements shown in the layout (in order).
    -- Layouts are opened in order so that earlier layouts take priority in window sizing.
    layouts = {
        {
            elements = {
                -- Elements can be strings or table with id and size keys.
                "console",
                "repl"
            },
            size = 30, -- 30 columns
            position = "right",
        },
        {
            elements = {
                "watches",
            },
            size = 0.20, -- 20% of total lines
            position = "bottom",
        },
    },
    controls = {
        -- Requires Neovim nightly (or 0.8 when released)
        enabled = true,
        -- Display controls in this element
        element = "repl",
        icons = {
            pause = "",
            play = "",
            step_into = "",
            step_over = "",
            step_out = "",
            step_back = "",
            run_last = "↻",
            terminate = "□",
        },
    },
    floating = {
        max_height = nil,  -- These can be integers or a float between 0 and 1.
        max_width = nil,   -- Floats will be treated as percentage of your screen.
        border = "single", -- Border style. Can be "single", "double" or "rounded"
        mappings = {
            close = { "q", "<Esc>" },
        },
    },
    windows = { indent = 1 },
    render = {
        max_type_length = nil, -- Can be integer or nil.
        max_value_lines = 100, -- Can be integer or nil.
    }
})

vim.fn.sign_define("DapBreakpoint", { text = "⬤", texthl = "DiagnosticSignError", linehl = "", numhl = "" })
vim.fn.sign_define('DapStopped', { text = '⏭', texthl = 'DapStopped', linehl = 'DapStopped', numhl = 'DapStopped' })



require("nvim-dap-virtual-text").setup({
    -- comment = true,
    -- virt_lines = true,
    virt_text_pos = 'eol',
    display_callback = function(variable, buf, stackframe, node, options)
        local text = ""
        if options.virt_text_pos == 'inline' then
            text = ' = ' .. variable.value
        else
            text = variable.name .. ' = ' .. variable.value
        end

        -- Truncate the text to 100 characters if it exceeds that length
        if #text > 50 then
            text = text:sub(1, 50) .. ".."
        end

        return text
    end,
})

dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
end

dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
end

dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
end


vim.keymap.set('n', '<F10>', require 'dapui'.toggle)
vim.keymap.set('n', '<F9>', require('dapui').eval)
vim.keymap.set('n', '<F5>', require 'dap'.continue)
vim.keymap.set('n', '<F6>', require 'dap'.step_over)
vim.keymap.set('n', '<F4>', require 'dap'.step_into)
vim.keymap.set('n', '<F8>', require 'dap'.step_out)
vim.keymap.set('n', '<F7>', require 'dap'.toggle_breakpoint)
vim.keymap.set('n', '<F1>', require 'dap'.clear_breakpoints)
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
