return {
	Name = "startshakiraglobal",
	Aliases = { "shakira", "startshakira" },
	Description = "Starts the Shakira concert event globally - spawns the concert map, plays the song, and makes the sky pink for 3min20!",
	Group = "Admin",
	Args = {
		{
			Type = "number",
			Name = "duration",
			Description = "Duration in seconds (default = 200 = 3min20)",
			Default = 200,
			Optional = true,
		},
	},
}