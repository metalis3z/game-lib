return {
	Name = "startpinataevent";
	Aliases = {"pinataevent", "spawnpinata"};
	Description = "Start the Pinata event";
	Group = "CustomAdmin";
	Args = {
		{
			Type = "integer";
			Name = "duration";
			Description = "Duration in seconds (default: 300)";
			Optional = true;
		}
	};
}