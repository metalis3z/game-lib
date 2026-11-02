return {
	Name = "givewins",
	Aliases = { "addwins", "wins" },
	Description = "Give wins to a player.",
	Group = "Admin",
	Args = {
		{
			Type = "player",
			Name = "target",
			Description = "The player to give wins to.",
		},
		{
			Type = "number",
			Name = "amount",
			Description = "The amount of wins to give.",
		},
	},
}