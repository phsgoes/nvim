-- Use a protected call so we don't error out on first use
local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
	return
end

