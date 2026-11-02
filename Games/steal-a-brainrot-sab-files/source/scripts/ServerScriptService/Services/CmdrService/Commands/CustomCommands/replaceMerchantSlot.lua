return {
	Name = "replaceMerchantSlot";
	Aliases = {"setmerchantslot", "merchantoverride"};
	Description = "Overrides a Santa Merchant slot with a custom animal, cost, and currency. Replicated across all servers and persisted. Args: animalName cost slot [currency]";
	Group = "CustomAdmin";
	Args = {
		{
			Type = "animalName";
			Name = "animalName";
			Description = "Animal to display/sell in the slot.";
		},
		{
			Type = "number";
			Name = "cost";
			Description = "Cost of the slot in the chosen currency.";
		},
		{
			Type = "number";
			Name = "slot";
			Description = "Slot index to override (1-based).";
		},
		{
			Type = "merchantCurrency";
			Name = "currency";
			Description = "Currency for the slot: elf or brotinho. Defaults to elf.";
			Optional = true;
		},
		{
			Type = "number";
			Name = "StockCount";
			Description = "Global Stock amount";
			Optional = true;
		},
	};
}