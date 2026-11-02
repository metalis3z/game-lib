	return {
	Name = "stopevent";
	Aliases = {"endevent", "cancel"};
	Description = "Stops a running event by name";
	Group = "CustomAdmin";
	Args = {
		{
			Type = "string";
			Name = "eventName";
			Description = "Name of the event to stop";
		}
	};
}
