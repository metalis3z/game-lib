return {
	Name = "setrebirths",
	Aliases = { "rebirths" },
	Description = "Set a player's rebirth count (and their multiplier).",
	Group = "Admin",
	Args = {
		{
			Type = "player",
			Name = "target",
			Description = "The player to set rebirths for.",
		},
		{
			Type = "number",
			Name = "count",
			Description = "The number of rebirths to set.",
		},
	},
}