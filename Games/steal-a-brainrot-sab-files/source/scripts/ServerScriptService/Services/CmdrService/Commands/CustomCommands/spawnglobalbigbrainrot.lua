return {
	Name = "spawnglobalbigbrainrot";
	Aliases = { "spawnbig" };
	Description = "Spawns a specific animal(big cuz you fat) globally across all servers with optional mutation, size, and traits.";
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
			Type = "number";
			Name = "Size";
			Description = "Size of the animal (capped at 3 in public servers for non-admins, optional).";
			Optional = true;
		},
		{
			Type = "string";
			Name = "Traits";
			Description = "list of traits (Like Fire).";
			Optional = true;
		},
	};
}