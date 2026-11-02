return {
	Name = "settrail",
	Aliases = { "givetrail", "addtrail" },
	Description = "Give a permanent trail to a player. Use 'list' as the trail name to see all available trails.",
	Group = "Admin",
	Args = {
		{
			Type = "player",
			Name = "target",
			Description = "The player to give the trail to.",
		},
		{
			Type = "string",
			Name = "trailName",
			Description = "The trail key name (e.g. GreenTrail, GalaxyTrail, InfinityTrail).",
		},
		{
			Type = "boolean",
			Name = "equip",
			Description = "Whether to equip the trail immediately (true/false).",
			Default = true,
			Optional = true,
		},
	},
}