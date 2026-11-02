return {
	Name        = "setglobalcraft";
	Aliases     = {"addglobalcraft"};
	Description = 'Adds a global crafting recipe to the Cyber Craft machine across all servers. '
		.. 'Args: key rarity output recipe [cost] [craftTime]';
	Group       = "CustomAdmin";
	Args        = {
		{
			Type        = "string";
			Name        = "key";
			Description = 'Unique identifier for this global recipe, e.g. "Secret_Tralaledon. Used to remove it later.';
		},
		{
			Type        = "string";
			Name        = "rarity";
			Description = 'Rarity slot, e.g. "Secret", "Legendary", "Mythic".';
		},
		{
			Type        = "animalName";
			Name        = "output";
			Description = "Output brainrot name (must exist in AnimalsDB).";
		},
		{
			Type        = "string";
			Name        = "recipe";
			Description = "Comma-separated ingredient names, e.g. 'Noobini Pizzanini,Bombardino Crocodilo'.";
		},
		{
			Type        = "number";
			Name        = "cost";
			Description = "Coin cost (optional, default 1000000000).";
			Optional    = true;
		},
		{
			Type        = "number";
			Name        = "craftTime";
			Description = "Craft time in seconds (optional, default uses rarity default).";
			Optional    = true;
		},
		{
			Type        = "number";
			Name        = "Stock";
			Description = "Number of stock.";
			Optional    = true;
		},
		{
			Type        = "string";
			Name        = "JobId";
			Description = "Optional target server JobId. Omit to set on all servers.";
			Optional    = true;
		}
	};
}