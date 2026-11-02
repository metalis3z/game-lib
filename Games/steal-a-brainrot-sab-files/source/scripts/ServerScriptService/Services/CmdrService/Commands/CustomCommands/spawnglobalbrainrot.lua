return {
	Name = "spawnglobalbrainrot";
	Aliases = { "globalroadspawn" };
	Description = "Spawns a specific animal globally across all servers with optional mutation, traits, speed, and amount.";
	Group = "CustomAdmin";
	Args = {
		{
			Type = "animalName";
			Name = "Animal";
			Description = "The animal to spawn globally.";
		},
		{
			Type = "number";
			Name = "Amount";
			Description = "How many times to spawn the animal globally (default: 1, max: 50).";
			Optional = true;
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
		},
		{
			Type = "string";
			Name = "JobId";
			Description = "Optional target server JobId. Omit to spawn on all servers.";
			Optional = true;
		},
	};
}