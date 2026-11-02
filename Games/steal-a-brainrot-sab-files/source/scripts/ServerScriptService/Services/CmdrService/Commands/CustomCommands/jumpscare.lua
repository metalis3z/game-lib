
return {
	Name = "jumpscare",
	Aliases = {"scare", "js"},
	Description = "Triggers a jumpscare for a player (searches all servers if needed)",
	Group = "Admin",
	Args = {
		{
			Type = "string",
			Name = "PlayerName",
			Description = "The name of the player to jumpscare"
		},
		{
			Type = "animalName",
			Name = "Brainrot",
			Description = "The name of the Brainrot (e.g., 'Tim Cheese')",
		}
	}
}