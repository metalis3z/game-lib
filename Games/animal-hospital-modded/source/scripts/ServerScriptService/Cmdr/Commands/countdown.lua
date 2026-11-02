return {
	Name = "countdown",
	Description = "Start a global countdown for all players",
	Group = "Admin",
	Args = {
		{
			Type = "number";
			Name = "Time";
			Description = "Countdown duration in seconds";
		},
	}
}