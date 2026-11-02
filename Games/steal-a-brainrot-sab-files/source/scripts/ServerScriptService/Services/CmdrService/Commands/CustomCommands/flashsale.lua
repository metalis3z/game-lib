return {
	Name = "flashsale";
	Aliases = {"createflash", "flash"};
	Description = "Creates a flash sale for a limited item. Args: productId amount durationSeconds [displayName] [animalName]";
	Group = "CustomAdmin";
	Args = {
		{
			Type = "number";
			Name = "productId";
			Description = "The Developer Product ID for the flash sale.";
		},
		{
			Type = "number";
			Name = "amount";
			Description = "Number of units available in the flash sale.";
		},
		{
			Type = "number";
			Name = "duration";
			Description = "Duration of the flash sale in seconds.";
		},
		{
			Type = "string";
			Name = "displayName";
			Description = "Display name shown in the shop UI.";
			Optional = true;
		},
		{
			Type = "animalName";
			Name = "animalName";
			Description = "Animal to spawn when purchased.";
			Optional = true;
		},
	};
}