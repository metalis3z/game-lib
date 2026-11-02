local version = "v4.0"

return {
	Name = "version",
	Args = {},
	Description = "Shows the current version of Conch",
	Group = "DefaultDebug",

	Run = function()
		return ("Conch Version %s"):format(version)
	end,
}
