return {
	Name = "stopflashsale";
	Aliases = {"cancelflash", "endflash"};
	Description = "Stops an active flash sale by productId.";
	Group = "CustomAdmin";
	Args = {
		{
			Type = "number";
			Name = "productId";
			Description = "The Developer Product ID of the flash sale to stop.";
		},
	};
}