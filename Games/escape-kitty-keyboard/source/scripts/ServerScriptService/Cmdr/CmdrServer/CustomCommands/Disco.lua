return {
	Name = "disco",
	Aliases = { "discolights", "party" },
	Description = "Active un event disco pour tous les joueurs (effet lumineux colore).",
	Group = "Admin",
	Args = {
		{
			Type = "integer",
			Name = "duration",
			Description = "Duree du disco en secondes (par defaut: 15)",
			Optional = true,
		},
	},
}