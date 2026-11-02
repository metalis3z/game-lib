return {
	Name = "globalsetserverluck";
	Aliases = {"globalluck", "gsetluck", "gserverluck"};
	Description = "Activates server luck globally across all servers.";
	Group = "CustomAdmin";
	Args = {
		{
			Type = "string";
			Name = "multiplier";
			Description = "Luck multiplier (2x, 4x, 6x, 8x, 10x, 12x)";
		},
		{
			Type = "number";
			Name = "duration";
			Description = "Duration in seconds (optional, default = 900)";
			Optional = true;
		},
	};
}
