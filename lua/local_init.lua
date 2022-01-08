-- checks project directory for file containing custom settings
local scan = require("plenary.scandir")

local files = scan.scan_dir(".", { depth = 0 })

for _, v in pairs(files) do
	if v == "./linit.lua" then
		vim.cmd(":luafile ./linit.lua")
	end
end
