return {
	Name = "setluckyblockanimal",
	Aliases = {},
	Description = "Define which animal will come from a specific Lucky Block",
	Group = "Admin",
	Args = {
		{
			Type = "string",
			Name = "LuckyBlock",
			Description = "Choose which Lucky Block to edit",
		},
		{
			Type = "string",
			Name = "Animal",
			Description = "Brainrot Name",
		},
		{
			Type = "string",
			Name = "Player",
			Description = "Player nickname",
			Optional = true,
		},
	}
}