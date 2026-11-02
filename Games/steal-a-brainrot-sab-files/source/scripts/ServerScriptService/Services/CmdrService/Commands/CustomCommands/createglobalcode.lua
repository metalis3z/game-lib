return {
	Name        = "globalcreatecode";
	Aliases     = {"globalcode", "gcode"};
	Description = 'Creates a Global Code redeemable across all servers, with stock shared globally via MemoryStoreService '
		.. 'and the announcement broadcast via MessagingService. Args: code brainrot [mutation] [quantity]';
	Group       = "CustomAdmin";
	Args        = {
		{
			Type        = "string";
			Name        = "code";
			Description = 'Code text players will type to redeem (e.g. "WINTER2025"). Auto-uppercased.';
		},
		{
			Type        = "animalName";
			Name        = "brainrot";
			Description = "Brainrot to spawn when the code is redeemed (must exist in AnimalsDB).";
		},
		{
			Type        = "mutationName";
			Name        = "mutation";
			Description = "Optional mutation to apply to the spawned brainrot.";
			Optional    = true;
		},
		{
			Type        = "number";
			Name        = "quantity";
			Description = "Total stock across ALL servers combined. Omit for unlimited.";
			Optional    = true;
		},
	};
}