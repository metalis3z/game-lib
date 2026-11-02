return {
	Name = "stopallevents";
	Aliases = {"stopallevents", "stopall"};
	Description = "Stop all events";
	Group = "CustomAdmin";
	Args = {
		{
			Type = "number";
			Name = "Duration";
			Description = "Duration of every event (optional).";
			Optional = true;
		}
	}
}
