return {
	Name = "setlevel",
	Aliases = { "level" },
	Description = "Set a player's level.",
	Group = "Admin",
	Args = {
		{
			Type = "player",
			Name = "target",
			Description = "The player to set the level for.",
		},
		{
			Type = "number",
			Name = "level",
			Description = "The level to set.",
		},
	},
}