return {
	Name = "spawnspecial";
	Aliases = { "spawnspecial"};
	Description = "Spawns a specific animal on the specified road by name.";
	Group = "CustomAdmin";
	Args = {
		{
			Type = "animalName";
			Name = "Animal";
			Description = "The name of the animal to spawn on the road.";
			Optional = false;
		},
		{
			Type = "string";
			Name = "Road";
			Description = "The name of the road to spawn the animal on (e.g., '2', '3').";
			Optional = false;
		}
	};
}
