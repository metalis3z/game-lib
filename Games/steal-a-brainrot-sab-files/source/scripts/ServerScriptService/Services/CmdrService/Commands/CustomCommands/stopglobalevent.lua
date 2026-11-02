return {
	Name = "stopglobalevent";
	Aliases = { "sgstop", "globaleventstop" };
	Description = "Stops a specific event globally across all servers.";
	Group = "CustomAdmin";
	Args = {
		{
			Type = "eventName";
			Name = "EventName";
			Description = "The name of the event to stop globally.";
		},
	};
}