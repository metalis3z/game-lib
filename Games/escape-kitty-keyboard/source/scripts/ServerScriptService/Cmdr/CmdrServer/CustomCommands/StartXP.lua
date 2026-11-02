return {
	Name = "startxp",
	Aliases = { "startxpboost", "xpboost" },
	Description = "Active un multiplicateur d'XP global (ex: startxp 2 = 2x XP).",
	Group = "Admin",
	Args = {
		{
			Type = "number",
			Name = "multiplier",
			Description = "Le multiplicateur d'XP (2 = 2x, 3 = 3x, etc.)",
		},
		{
			Type = "number",
			Name = "duration",
			Description = "Duree en secondes avant reset auto (0 = permanent)",
			Default = 0,
			Optional = true,
		},
	},
}