return {
	Name = "xpmult",
	Aliases = { "xpmultiplier", "xpmulti" },
	Description = "Set the global XP multiplier for all players (e.g. 2 for 2x XP, 4 for 4x XP).",
	Group = "Admin",
	Args = {
		{
			Type = "number",
			Name = "multiplier",
			Description = "The XP multiplier (2 = 2x XP, 4 = 4x XP, etc.)",
		},
		{
			Type = "number",
			Name = "duration",
			Description = "Optional: duration in seconds before auto-reset (0 = permanent)",
			Default = 0,
			Optional = true,
		},
	},
}