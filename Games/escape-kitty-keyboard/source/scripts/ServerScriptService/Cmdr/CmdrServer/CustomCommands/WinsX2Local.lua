return {
	Name = "winsx2local",
	Aliases = { "winsmultlocal", "winsmultiplierlocal", "x2winslocal" },
	Description = "Set the Wins multiplier for a specific player only (local x2 wins event). Duration is required.",
	Group = "Admin",
	Args = {
		{
			Type = "player",
			Name = "target",
			Description = "The player to apply the wins multiplier to.",
		},
		{
			Type = "number",
			Name = "multiplier",
			Description = "The Wins multiplier (2 = 2x event, 4 = 4x event, etc.)",
		},
		{
			Type = "number",
			Name = "duration",
			Description = "Duration of the event in seconds (3600 = 1h, 7200 = 2h, etc.)",
		},
	},
}