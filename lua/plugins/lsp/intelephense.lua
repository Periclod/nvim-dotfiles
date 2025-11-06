local stubs = {
	"gmagick",
	"imagick",
	"ds",
	"apache",
	"bcmath",
	"bz2",
	"calendar",
	"com_dotnet",
	"Core",
	"ctype",
	"curl",
	"date",
	"dba",
	"dom",
	"enchant",
	"exif",
	"FFI",
	"fileinfo",
	"filter",
	"fpm",
	"ftp",
	"gd",
	"gettext",
	"gmp",
	"hash",
	"iconv",
	"imap",
	"intl",
	"json",
	"ldap",
	"libxml",
	"mbstring",
	"meta",
	"mysqli",
	"oci8",
	"odbc",
	"openssl",
	"pcntl",
	"pcre",
	"PDO",
	"pdo_ibm",
	"pdo_mysql",
	"pdo_pgsql",
	"pdo_sqlite",
	"pgsql",
	"Phar",
	"posix",
	"pspell",
	"readline",
	"Reflection",
	"session",
	"shmop",
	"SimpleXML",
	"snmp",
	"soap",
	"sockets",
	"sodium",
	"SPL",
	"sqlite3",
	"standard",
	"superglobals",
	"sysvmsg",
	"sysvsem",
	"sysvshm",
	"tidy",
	"tokenizer",
	"xml",
	"xmlreader",
	"xmlrpc",
	"xmlwriter",
	"xsl",
	"Zend OPcache",
	"zip",
	"zlib",
}

local config = {
	--- @param bufnr integer
	--- @param on_dir fun(root_dir?:string)
	root_dir = function(bufnr, on_dir)
		local path = vim.api.nvim_buf_get_name(bufnr)
		local root_dir = vim.fn.getcwd()

		local composer_root = require("lspconfig").util.root_pattern("composer.json")(path)
		if composer_root then
			root_dir = composer_root
		else
			local repo_root = require("lspconfig").util.root_pattern(".git")(path)
			if vim.fn.filereadable(vim.fs.joinpath(repo_root, "app", "composer.json")) == 1 then
				root_dir = vim.fs.joinpath(repo_root, "app")
			else
				root_dir = repo_root
			end
		end

		on_dir(root_dir)
	end,
	settings = {
		intelephense = {
			stubs = stubs,
			environment = {
				phpVersion = "8.2",
			},
		},
	},
}
return config
