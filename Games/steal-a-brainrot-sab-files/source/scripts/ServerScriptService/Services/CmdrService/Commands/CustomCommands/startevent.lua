return {
	Name = "startevent";
	Aliases = {"startevent"};
	Description = "Start an event by name or random event";
	Group = "CustomAdmin";
	Args = {
		{
			Type = "eventName";
			Name = "EventName";
			Description = "Name of the event to start or 'random' to start random event";
		},
		{
			Type = "number";
			Name = "Duration";
			Description = "Duration in seconds (optional)";
			Optional = true;
			
		},
		{
			Type = "number";
			Name = "Delay";
			Description = "Delay in seconds (optional)";
			Optional = true;

		}
	};
}
