
return {
	Name = "startglobalevent",
	Aliases = { "tge", "globalevent" },
	Description = "Triggers a global event.",
	Group = "CustomAdmin",
	Args = {
		{
			Type = "eventName",
			Name = "eventName",
			Description = "The name of the event to trigger",
		},
		{
			Type = "number",
			Name = "duration",
			Description = "Duration in seconds (optional)",
			Optional = true,
		},
		{
			Type = "string",
			Name = "arguments",
			Description = "Comma-separated custom arguments e.g. BurgerKing,Coffin (optional)",
			Optional = true,
		},
	},
}