return {
	Name = "setserverluck";
	Aliases = {"serverluck", "luck", "setluck"};
	Description = "Sets the global server luck multiplier.";
	Group = "CustomAdmin";
	Args = {
		{
			Type = "string";
			Name = "multiplier";
			Description = "Luck amount to activate (2x, 4x, 6x, 8x, 10x, 12x)";
		},
		{
			Type = "number";
			Name = "duration";
			Description = "Duration in seconds (optional, default = 900)";
			Optional = true;
		},
	};
}
