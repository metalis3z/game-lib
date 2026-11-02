return {
	Name = "luckyblockrain";
	Aliases = { "luckyrain" };
	Description = "Triggers a global snap event with an optional offline target and optional snap type.";
	Group = "CustomAdmin";

	Args = {
		{
			Type = "number";
			Name = "amount";
			Description = "The amount of lucky blocks each.";
			Optional = true;
		},
		{
			Type = "boolean";
			Name = "IsGlobal";
			Description = "If spawns globally.";
			Optional = true;
		},
		{
			Type = "string";
			Name = "JobId";
			Description = "Optional target server JobId. Omit to rain on all servers.";
			Optional = true;
		},
	};
}