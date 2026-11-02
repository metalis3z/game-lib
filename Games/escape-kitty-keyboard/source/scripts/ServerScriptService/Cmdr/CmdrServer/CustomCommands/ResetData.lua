return {
	Name = "resetdata",
	Aliases = { "resetstats", "wipeplayer" },
	Description = "Reset TOUTES les stats du joueur vise (XP, Wins, Rebirths, Trails, etc.).",
	Group = "Admin",
	Args = {
		{
			Type = "player",
			Name = "target",
			Description = "Le joueur dont on veut reset les stats",
		},
	},
}