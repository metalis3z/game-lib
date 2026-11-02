return {
	Name = "addbrainrot";
	Aliases = {"givebrainrot", "brainrotadd"};
	Description = "Spawns a brainrot in the target player's base with optional mutation and traits.";
	Group = "CustomAdmin";
	Args = {
		{
			Type = "player";
			Name = "player";
			Description = "The player to receive the brainrot.";
		},
		{
			Type = "animalName";
			Name = "Animal";
			Description = "The name of the brainrot (animal).";
		},
		{
			Type = "mutationName";
			Name = "Mutaiton";
			Description = "Optional mutation name.";
			Optional = true;
		},
		{
			Type = "string";
			Name = "Traits";
			Description = "Optional traits (comma-separated, e.g., 'Fire, Lightning')";
			Optional = true;
		}
	};
}
