return {
	Name = "SpawnspecialAll";
	Aliases = { "SpawnspecialAll" };
	Description = "Spawns a specific animal on all 3 roads by name.";
	Group = "CustomAdmin";
	Args = {
		{
			Type = "animalName";
			Name = "Animal";
			Description = "The name of the animal to spawn on all roads.";
			Optional = false;
		}
	};
}
