return {
	Name = "giveitem";
	Aliases = {"gi"};
	Description = "Gives a weapon inventory item to a player.";
	Group = "DefaultAdmin";
	Args = {
		{
			Type = "player";
			Name = "Player";
			Description = "The player to give the item to.";
		},
		{
			Type = "string";
			Name = "Item";
			Description = "The item key or item display name.";
		},
	};
}