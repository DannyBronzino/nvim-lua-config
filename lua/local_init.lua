local scan = require("plenary.scandir")

local files = scan.scan_dir(".", { depth = 0 })

for _, v in pairs(files) do
	if v == "./init.lua" then
		vim.cmd(":luafile ./init.lua")
	end
end
