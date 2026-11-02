return {
	Name = "spawnrandomserverbrainrot",
	Aliases = {"spawnrandom", "randomserver", "spawnrandomserver"},
	Description = "Spawns a brainrot across all servers globally",
	Group = "Admin",
	Args = {
		{
			Type = "animalName",
			Name = "Brainrot",
			Description = "The brainrot to spawn"
		},
		{
			Type = "number",
			Name = "Amount",
			Description = "Number of servers to spawn in (1-10000)",
			Default = 1,
			Optional = true
		},
		{
			Type = "mutationName",
			Name = "Mutation",
			Description = "Mutation type (if any)",
			Default = "",
			Optional = true
		}
	}
}