-- entrypoint for Neovim configuration
-- this file now loads modular components instead of inlining everything

-- general options and settings
require("core.options")

-- key mappings
require("core.keymaps")

-- autocommands
require("core.autocmds")

-- plugin manager and plugin specifications
require("core.lazy")

-- plugin-specific configuration now handled in `lua/core/plugins/*` modules
