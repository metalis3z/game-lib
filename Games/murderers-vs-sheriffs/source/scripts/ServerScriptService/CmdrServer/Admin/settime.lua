return {
	Name = "settime";
	Aliases = {"st"};
	Description = "Adds seconds to the current round timer.";
	Group = "DefaultAdmin";
	Args = {
		{
			Type = "number";
			Name = "Seconds";
			Description = "Seconds to add to the active round.";
		},
	};
}