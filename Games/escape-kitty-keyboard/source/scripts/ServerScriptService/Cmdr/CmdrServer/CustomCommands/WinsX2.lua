return {
	Name = "winsx2",
	Aliases = { "winsmult", "winsmultiplier", "x2wins" },
	Description = "Set the global Wins/Trophies multiplier for ALL servers (cross-server via MessagingService). Duration is required.",
	Group = "Admin",
	Args = {
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