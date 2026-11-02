return {
	Name = "resetwinsx2local",
	Aliases = { "rwinsx2local", "resetwinsmultlocal" },
	Description = "Reset a specific player's local Wins multiplier back to 1x.",
	Group = "Admin",
	Args = {
		{
			Type = "player",
			Name = "target",
			Description = "The player to reset the wins multiplier for.",
		},
	},
}