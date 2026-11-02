-- Give item for cmdr made by "Kaiz" :D

return {
	Name = "giveitem";
	Aliases = {"giveitem", "itemadd"};
	Description = "Give an item of your choice to the user.";
	Group = "CustomAdmin";
	Args = {
		{
			Type = "string";
			Name = "Item";
			Description = "The item the player will get.";
		},
		{
			Type = "player";
			Name = "User";
			Description = "The user who will get the item.";
		},
	};
}
