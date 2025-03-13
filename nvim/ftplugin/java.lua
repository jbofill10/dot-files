-- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
local function get_workspace_dir()
	local cwd = vim.fn.getcwd()
	local project_name = vim.fn.fnamemodify(cwd, ':p:h:t')
	local workspace_dir = vim.fn.expand('~/.local/share/eclipse') .. '/workspace-' .. project_name

	-- Create the directory if it doesn't exist
	vim.fn.mkdir(vim.fn.expand('~/.local/share/eclipse'), 'p')
	return workspace_dir
end

-- Setup Testing and Debugging
local mason_path = vim.fn.stdpath("data") .. "/mason/"

-- Setup Testing and Debugging
local bundles = {}
local mason_path = vim.fn.glob(vim.fn.stdpath "data" .. "/mason/")
vim.list_extend(bundles, vim.split(vim.fn.glob(mason_path .. "packages/java-test/extension/server/*.jar"), "\n"))
vim.list_extend(
	bundles,
	vim.split(
		vim.fn.glob(mason_path ..
		"packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar"),
		"\n"
	)
)

local jdtls_path = vim.fn.glob(vim.fn.expand("~/jdtls/plugins/org.eclipse.equinox.launcher_*.jar"))
local config = {
	-- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
	cmd = {

		-- 💀
		'java', -- or '/path/to/java21_or_newer/bin/java'
		-- depends on if `java` is in your $PATH env variable and if it points to the right version.

		'-Declipse.application=org.eclipse.jdt.ls.core.id1',
		'-Dosgi.bundles.defaultStartLevel=4',
		'-Declipse.product=org.eclipse.jdt.ls.core.product',
		'-Dlog.protocol=true',
		'-Dlog.level=ALL',
		'-Xmx12G',
		'--add-modules=ALL-SYSTEM',
		'--add-opens', 'java.base/java.util=ALL-UNNAMED',
		'--add-opens', 'java.base/java.lang=ALL-UNNAMED',
		'-javaagent:' ..
		vim.fn.expand('~') .. '/.m2/repository/org/projectlombok/lombok/1.18.36/lombok-1.18.36.jar',          -- Add this line


		-- 💀
		'-jar',
		jdtls_path,
		-- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^                                       ^^^^^^^^^^^^^^
		-- Must point to the                                                     Change this to
		-- eclipse.jdt.ls installation                                           the actual version


		-- 💀
		'-configuration', '/home/development/jdt-language-server-1.44.0/config_linux',
		-- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^        ^^^^^^
		-- Must point to the                      Change to one of `linux`, `win` or `mac`
		-- eclipse.jdt.ls installation            Depending on your system.


		-- 💀
		-- See `data directory configuration` section in the README
		'-data', get_workspace_dir()
	},

	-- 💀
	-- This is the default if not provided, you can remove it. Or adjust as needed.
	-- One dedicated LSP server & client will be started per unique root_dir
	--
	-- vim.fs.root requires Neovim 0.10.
	-- If you're using an earlier version, use: require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew'}),
	root_dir = vim.fs.root(0, { ".git", "mvnw", "gradlew" }),

	-- Here you can configure eclipse.jdt.ls specific settings
	-- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
	-- for a list of options
	settings = {
		java = {
			format = {
				settings = {
					profile = 'EIDS', -- Replace with your formatter profile name
					url = 'file://' .. vim.fn.expand('~') .. '/java_formatting.xml',
				}
			},
			codeGeneration = {
				toString = {
					template =
					"${object.className}{${member.name()}=${member.value}, ${otherMembers}}"
				},
				useBlocks = true,
				generateComments = true,
				generateFinalModifiers = true, -- For addFinalModifier
			},
			cleanup = {
				actionsOnSave = {
					"lambdaExpressionFromAnonymousClass", -- For lambdaExpression
					"organizeImports", -- For organizeImports
				}
			},
			sources = {
				organizeImports = {
					starThreshold = 999,
					staticStarThreshold = 999
				}
			},
			imports = {
				gradle = {
					enabled = true
				},
				maven = {
					enabled = true
				},
				exclusions = {
					"*/test/**"
				}
			}
		}
	},

	-- Language server `initializationOptions`
	-- You need to extend the `bundles` with paths to jar files
	-- if you want to use additional eclipse.jdt.ls plugins.
	--
	-- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
	--
	-- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
	init_options = {
		bundles = bundles
	},
}
-- This starts a new client & server,
-- or attaches to an existing client & server depending on the `root_dir`.
require('jdtls').start_or_attach(config)

-- This will register commands for testing
local jdtls = require('jdtls')
local jdtls_setup = require('jdtls.setup')
-- Register java test commands
local java_test_path = vim.fn.glob(mason_path .. "packages/java-test/extension/server/*.jar")
if java_test_path ~= "" then
	jdtls.setup_dap({ hotcodereplace = 'auto' })

	vim.api.nvim_create_user_command('JavaTestRunCurrentClass', function()
		require('jdtls').test_class()
	end, {})

	vim.api.nvim_create_user_command('JavaTestDebugCurrentClass', function()
		require('jdtls').test_class({ debug = true })
	end, {})

	vim.api.nvim_create_user_command('JavaTestRunCurrentMethod', function()
		require('jdtls').test_nearest_method()
	end, {})

	vim.api.nvim_create_user_command('JavaTestDebugCurrentMethod', function()
		require('jdtls').test_nearest_method({ debug = true })
	end, {})
end
