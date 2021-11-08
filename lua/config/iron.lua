local iron = require("iron")
iron.core.set_config({
	preferred = {
		python = "ipython3",
	},
	repl_open_cmd = "vertical 30 split",
})
