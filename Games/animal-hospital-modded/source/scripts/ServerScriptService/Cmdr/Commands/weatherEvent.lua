return {
	Name = "weatherEvent",
	Description = "Start a weather event",
	Group = "Admin",
	Args = {
		{
			Type = "weather";
			Name = "WeatherType";
			Description = "Which weather event to start";
		},
	}
}