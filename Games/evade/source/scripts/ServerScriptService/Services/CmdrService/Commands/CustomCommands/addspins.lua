return {
	Name = "addspins";
	Aliases = {"spins", "givespins"};
	Description = "Add YinYang spins to a player";
	Group = "Admin";
	Args = {
		{
			Type = "players";
			Name = "TargetPlayer";
			Description = "Target player(s)";
		},
		{
			Type = "number";
			Name = "Amount";
			Description = "Number of spins to add";
		},
	};
}