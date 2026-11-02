return {
	Name = "sammysnapglobal";
	Aliases = {"sammysnapglobal"};
	Description = "Triggers Phase 5: Sammy Snap, waits 11s, then runs a location event globally. Then runs N random non-location events globally.";
	Group = "CustomAdmin";

	Args = {
		{
			Type = "string";
			Name = "location";
			Description = "Location after snap (Concert, Brazil, Rap Concert, Mexico, Indonesia)";
		},
		{
			Type = "boolean";
			Name = "startRandomEvents";
			Description = "Starts random events after the location event, true or false (optional)";
			Optional = true;
		},
		{
			Type = "integer";
			Name = "amount";
			Description = "How many random events to run (optional, default = 10)";
			Optional = true;
		}
	};
}
