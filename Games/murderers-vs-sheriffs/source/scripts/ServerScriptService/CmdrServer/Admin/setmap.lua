return {
	Name = "setmap";
	Aliases = {"map"};
	Description = "Sets the map for the next Classic round.";
	Group = "DefaultAdmin";
	Args = {
		{
			Type = "string";
			Name = "Map";
			Description = "The map name. Partial names work, for example milbase.";
		},
	};
}