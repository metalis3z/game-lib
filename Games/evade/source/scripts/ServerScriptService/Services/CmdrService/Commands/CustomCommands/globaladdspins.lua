return {
	Name = "globaladdspins";
	Aliases = {"allspins", "globalspins"};
	Description = "Add YinYang spins to ALL players across ALL servers";
	Group = "Admin";
	Args = {
		{
			Type = "number";
			Name = "Amount";
			Description = "Number of spins to add to everyone";
		},
	};
}