return {
	Name = "setcoins";
	Aliases = { "coin" };
	Description = "Sets the coins of a specific player!";
	Group = "CustomAdmin";
	Args = {
		{
			Type = "player";
			Name = "Player";
			Description = "The player to give coins to";
		},
		{
			Type = "integer";
			Name = "amount";
			Description = "The number to set player coins (must be positive)";
		}
	};
}
