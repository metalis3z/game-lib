return {
	Name = "setstockamount";
	Aliases = {"setstock"};
	Description = "Sets the stock amount for a limited product.";
	Group = "CustomAdmin";
	Args = {
		{
			Name = "ProductId";
			Type = "number";
			Description = "The product ID to set stock for.";
		},
		{
			Name = "StockAmount";
			Type = "number";
			Description = "The new stock amount (must be >= 0).";
		},
	};
}