return {
	Name = "givexp",
	Aliases = { "addxp", "xp" },
	Description = "Give XP to a player.",
	Group = "Admin",
	Args = {
		{
			Type = "player",
			Name = "target",
			Description = "The player to give XP to.",
		},
		{
			Type = "number",
			Name = "amount",
			Description = "The amount of XP to give.",
		},
	},
}