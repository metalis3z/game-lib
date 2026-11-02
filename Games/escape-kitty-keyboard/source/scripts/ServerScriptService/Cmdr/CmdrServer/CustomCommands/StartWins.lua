return {
	Name = "startwins",
	Aliases = { "startwinsboost", "winsboost" },
	Description = "Active un multiplicateur de Wins global (ex: startwins 2 = 2x Wins).",
	Group = "Admin",
	Args = {
		{
			Type = "number",
			Name = "multiplier",
			Description = "Le multiplicateur de Wins (2 = 2x, 3 = 3x, etc.)",
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