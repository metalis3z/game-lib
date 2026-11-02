return {
	Name = "stopglobalevent";
	Aliases = {"endglobalevent", "cancelglobal"};
	Description = "Stops an event by name across all servers.";
	Group = "CustomAdmin";
	Args = {
		{
			Type = "string";
			Name = "eventName";
			Description = "Name of the event to stop";
		}
	};
}
