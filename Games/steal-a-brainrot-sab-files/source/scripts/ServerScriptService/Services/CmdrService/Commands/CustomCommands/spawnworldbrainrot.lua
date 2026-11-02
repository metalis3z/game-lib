return {
	Name = "spawnworldbrainrot",
	Aliases = {"spawnwb", "wbspawn"},
	Description = "Spawns a world brainrot at a player's position",
	Group = "Admin",
	Args = {
		{
			Type = "player",
			Name = "Player",
			Description = "The player to spawn the brainrot at"
		},
		{
			Type = "animalName",
			Name = "BrainrotName",
			Description = "The name of the brainrot to spawn (e.g., 'Matteo', 'Noobini Pizzanini')"
		},
		{
			Type = "number",
			Name = "DespawnTimer",
			Description = "Time in seconds before despawn",
			Default = 60,
			Optional = true
		},
		{
			Type = "mutationName",
			Name = "Mutation",
			Description = "Mutation type (if any)",
			Default = "",
			Optional = true
		},
		{
			Type = "string",
			Name = "FakeMode",
			Description = "Fake mode: Grab, Purchase, or Base",
			Optional = true
		},
		{
			Type = "boolean",
			Name = "ShowTimer",
			Description = "Show despawn timer overhead",
			Default = true,
			Optional = true
		},
		{
			Type = "boolean",
			Name = "ShowDropButton",
			Description = "Show drop button when grabbing",
			Default = true,
			Optional = true
		}
	}
}
	