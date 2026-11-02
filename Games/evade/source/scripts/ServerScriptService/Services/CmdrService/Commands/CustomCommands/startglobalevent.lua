return {
	Name = "startglobalevent";
	Aliases = {"startglobalevent"};
	Description = "Start an event by name or random event (happens in every server)";
	Group = "CustomAdmin";
	Args = {
		{
			Type = "string";
			Name = "eventName";
			Description = "Name of the event to start or 'random' to start random event";
		},
		{
			Type = "integer";
			Name = "duration";
			Description = "Duration in seconds (optional)";
			Optional = true;
		}
	};
}
