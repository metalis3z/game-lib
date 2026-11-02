return {
	Name = "InitiateShutdown",
	Description = "Forces all players to rejoin with a given shutdown reason.",
	Args = {
		{
			Type = "string";
			Name = "Reason";
			Description = "Reason for shutdown that will be shown to all players.";
		},
	},
}
