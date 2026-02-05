return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"williamboman/mason.nvim",
		},
		lazy = true,
		init = function()
			-- keymaps
			local prefix = "<leader>d"
			vim.keymap.set("n", prefix .. "r", function()
				require("dap").continue()
			end, { desc = "DAP Run" })
			vim.keymap.set("n", prefix .. "c", function()
				require("dap").run_to_cursor()
			end, { desc = "DAP Run to cursor" })
			vim.keymap.set("n", prefix .. "t", function()
				require("dap").terminate()
			end, { desc = "DAP Close session" })

			vim.keymap.set("n", prefix .. "n", function()
				require("dap").step_over()
			end, { desc = "DAP Step Into" })
			vim.keymap.set("n", prefix .. "i", function()
				require("dap").step_into()
			end, { desc = "DAP Step Into" })
			vim.keymap.set("n", prefix .. "p", function()
				require("dap").step_out()
			end, { desc = "DAP Step Over" })

			-- <leader>dt is already taken plus bt for breakpoint toggle is nice
			vim.keymap.set("n", "<leader>bt", function()
				require("dap").toggle_breakpoint()
			end, { desc = "DAP Toggle Breakpoint" })
			vim.keymap.set("n", "<leader>bT", function()
				require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
			end, { desc = "DAP Set Conditional Breakpoint" })
			vim.keymap.set("n", "<leader>bc", function()
				require("dap").clear_breakpoints()
			end, { desc = "DAP Clear All Breakpoints" })
			vim.keymap.set("n", "<leader>bl", function()
				require("telescope").extensions.dap.list_breakpoints({})
			end, { desc = "List all breakpoints" })

			vim.keymap.set("n", prefix .. "f", function()
				local widgets = require("dap.ui.widgets")
				local my_sidebar = widgets.sidebar(widgets.frames, { width = 60 })
				my_sidebar.toggle()
			end, { desc = "DAP Frames Sidebar" })

			vim.keymap.set({ "n", "v" }, "<leader>dh", function()
				require("dapui").eval()
			end, { desc = "DAP Hover Variables" })
			vim.keymap.set("i", "<C-O>", "<C-X><C-O>")

			vim.api.nvim_create_autocmd("FileType", {
				pattern = "dap-repl",
				callback = function(args)
					vim.keymap.set("i", "<C-O>", "<C-X><C-O>", { buffer = args.buf })
				end,
			})
		end,
		config = function()
			local dap = require("dap")

			-- plugin setups via event listerns
			dap.listeners.after.attach.dapui_config = function()
				require("nvim-dap-virtual-text")
				require("dapui").open()
			end
			dap.listeners.after.launch.dapui_config = function()
				require("nvim-dap-virtual-text")
				require("dapui").open()
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				require("dapui").close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				require("dapui").close()
			end

			-- adapter configs
			dap.adapters["pwa-node"] = {
				type = "server",
				host = "localhost",
				port = "${port}",
				executable = {
					command = vim.fn.expand("$MASON/packages/js-debug-adapter/js-debug-adapter"),
					args = {
						"${port}",
					},
				},
			}
			-- dap.defaults["pwa-node"].exception_breakpoints = { "all" }
			require("dap").defaults.fallback.switchbuf = "usevisible,usetab,uselast"
			dap.adapters.php = {
				type = "executable",
				command = vim.fn.expand("$MASON/packages/php-debug-adapter/php-debug-adapter"),
			}

			-- Generic JS Configs
			local jsConfig = {
				{
					type = "pwa-node",
					request = "launch",
					name = "Launch file",
					program = "${file}",
					cwd = "${workspaceFolder}",
				},
				{
					-- log = true,
					type = "pwa-node",
					request = "attach",
					name = "Attach to Node app",
					address = "localhost",
					port = 9229,
					cwd = "${workspaceFolder}",
					restart = true,
				},
				{
					type = "pwa-node",
					request = "launch",
					name = "Launch Nuxt Dev Server",
					outputCapture = "std",
					program = "${workspaceFolder}/node_modules/nuxt/bin/nuxt.mjs",
					args = {
						"dev",
						"--dotenv",
						".env.dev",
					},
					cwd = "${workspaceFolder}",
				},
			}
			dap.configurations.javascript = jsConfig
			dap.configurations.typescript = jsConfig

			-- Php configs with iserv-specific file maps
			local iservPathMappings = {}
			-- iterate over folders in ~/Developer/iserv and ~/Developer/poweb and map them to /root/git/{name}
			local base_paths = {
				vim.fn.expand("~/Developer/iserv"),
				vim.fn.expand("~/Developer/poweb"),
			}

			for _, base_path in ipairs(base_paths) do
				local folders = vim.fn.glob(base_path .. "/*", false, true)
				for _, folder in ipairs(folders) do
					if vim.fn.isdirectory(folder) == 1 then
						local folder_name = vim.fn.fnamemodify(folder, ":t")
						-- Map /root/git/{folder_name}/app for projects with app subdirectory
						if vim.fn.isdirectory(folder .. "/app") == 1 then
							iservPathMappings["/root/git/" .. folder_name .. "/app"] = folder .. "/app"
						else
							-- Otherwise map /root/git/{folder_name} to the local path
							iservPathMappings["/root/git/" .. folder_name] = folder
						end
					end
				end
			end

			dap.configurations.php = {
				{
					-- log = true,
					type = "php",
					request = "launch",
					name = "Listen for XDebug",
					port = 9003,
					stopOnEntry = false,
					pathMappings = iservPathMappings,
					breakpoints = {
						exception = {
							Notice = false,
							Warning = false,
							Error = true,
							Exception = true,
						},
					},
				},
			}

			require("nvim-dap-virtual-text").setup({})
		end,
		cmd = { "DapToggleBreakpoint" },
	},
	{
		"rcarriga/nvim-dap-ui",
		dependencies = {
			"mfussenegger/nvim-dap",
			"nvim-neotest/nvim-nio",
		},
		lazy = true,
		opts = {
			controls = {
				element = "repl",
				enabled = true,
				icons = {
					disconnect = "",
					pause = "",
					play = "",
					run_last = "",
					step_back = "",
					step_into = "",
					step_out = "",
					step_over = "",
					terminate = "",
				},
			},
			element_mappings = {},
			expand_lines = true,
			floating = {
				border = "single",
				mappings = {
					close = { "q", "<Esc>" },
				},
			},
			force_buffers = true,
			icons = {
				collapsed = "",
				current_frame = "",
				expanded = "",
			},
			layouts = {
				{
					elements = {
						{
							id = "repl",
							size = 0.5,
						},
						{
							id = "scopes",
							size = 0.5,
						},
					},
					position = "bottom",
					size = 25,
				},
			},
			mappings = {
				edit = "e",
				expand = { "<CR>", "<2-LeftMouse>" },
				open = "o",
				remove = "d",
				repl = "r",
				toggle = "t",
			},
			render = {
				indent = 1,
				max_value_lines = 100,
			},
		},
		keys = {
			{
				"<leader>duq",
				function()
					require("dapui").toggle()
				end,
				{ desc = "DAP UI Toggle" },
			},
			{
				"<leader>dus",
				function()
					require("dapui").float_element("stacks")
				end,
				{ desc = "DAP UI Toggle" },
			},
		},
	},
	{
		"theHamsta/nvim-dap-virtual-text",
		dependencies = {
			"mfussenegger/nvim-dap",
		},
		lazy = true,
	},
}
