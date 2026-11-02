return {
	Name        = "soccerscore",
	Aliases     = { "goalscore", "scoresoccer" },
	Description = "Makes the specified team score a goal in their current LIVE match.",
	Group       = "Admin",
	Args        = {
		{
			Type        = "soccerTeamName",
			Name        = "team",
			Description = "The team that should score a goal.",
		},
	},
}