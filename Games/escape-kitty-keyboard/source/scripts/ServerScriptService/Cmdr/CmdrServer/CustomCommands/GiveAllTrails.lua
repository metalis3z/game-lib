return {
	Name = "givealltrails",
	Aliases = { "alltrails", "givetrails" },
	Description = "Give all available trails permanently to a player.",
	Group = "Admin",
	Args = {
		{
			Type = "player",
			Name = "target",
			Description = "The player to give all trails to.",
		},
		{
			Type = "boolean",
			Name = "equipBest",
			Description = "Whether to equip the best trail (InfinityTrail). Defaults to false.",
			Default = false,
			Optional = true,
		},
	},
}