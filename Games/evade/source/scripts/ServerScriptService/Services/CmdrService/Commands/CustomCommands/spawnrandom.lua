return {
	Name = "spawnrandom";
	Aliases = {"spawnrandom"};
	Description = "Spawns a chance of a rare brainrot in every server.";
	Group = "CustomAdmin";
	Args = {
		{
			Type = "animalName"; -- Use string for animal name
			Name = "Animal";
			Description = "The brainrot to spawn";
		},
		{
			Type = "string"; -- Use number for percent chance
			Name = "percent";
			Description = "The percent chance for the animal to spawn (1-100)";
		}
	};
}
