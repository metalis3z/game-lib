return {
	Name = "startallevents";
	Aliases = {"executeallevents", "startallevents", "executeall"};
	Description = "Start all events";
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
