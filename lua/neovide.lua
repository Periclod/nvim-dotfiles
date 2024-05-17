if vim.g.neovide then
	vim.o.guifont = "JetBrainsMono Nerd Font Mono"
	vim.g.neovide_scroll_animation_length = 0.2
	vim.g.neovide_scroll_animation_far_lines = 10

	vim.g.neovide_cursor_animation_length = 0.05
	vim.g.neovide_cursor_trail_size = 0.2
	vim.g.neovide_cursor_animate_in_insert_mode = false

	vim.g.neovide_hide_mouse_when_typing = true

	vim.g.neovide_refresh_rate = 120
	vim.g.neovide_refresh_rate_idle = 5
end
