return {
	Name = "spawnroadbrainrotglobal";
	Aliases = { "spawnroadglobal", "roadspawnglobal" };
	Description = "Spawns a specific animal on the road with optional mutation, traits, and speed.";
	Group = "CustomAdmin";
	Args = {
		{
			Type = "animalName";
			Name = "Animal";
			Description = "The animal to spawn on the road.";
		},
		{
			Type = "mutationName";
			Name = "Mutation";
			Description = "The mutation for the animal (optional).";
			Optional = true;
		},
		{
			Type = "string";
			Name = "Traits";
			Description = "Comma-separated list of traits (e.g., Fire).";
			Optional = true;
		},
		{
			Type = "number";
			Name = "Speed";
			Description = "Speed of the animal (must be >2 and <100000, optional).";
			Optional = true;
		}
	};
}
