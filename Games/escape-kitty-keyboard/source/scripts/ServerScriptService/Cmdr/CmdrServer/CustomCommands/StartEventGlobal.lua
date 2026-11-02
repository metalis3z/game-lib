return {
	Name = "starteventglobal",
	Aliases = { "chocolateevent", "startchocolate" },
	Description = "Activates the Chocolate Keycap event globally - every 2s a keycap turns chocolate, step on it to earn x2 your last win amount!",
	Group = "Admin",
	Args = {
		{
			Type = "number",
			Name = "duration",
			Description = "Duration in seconds (0 = permanent until stop)",
			Default = 0,
			Optional = true,
		},
	},
}