return {
	Name = "teleportToReserved",
	Aliases = {"tpr", "tpreserved"},
	Description = "Teleports two players to a reserved server. Second player defaults to yourself if omitted.",
	Group = "Admin",
	Args = {
		{
			Type = "string",
			Name = "Username1",
			Description = "First player's username"
		},
		{
			Type = "strin?",
			Name = "Username2",
			Description = "Second player's username (defaults to yourself if omitted)",
			Optional = true
		}
	}
}