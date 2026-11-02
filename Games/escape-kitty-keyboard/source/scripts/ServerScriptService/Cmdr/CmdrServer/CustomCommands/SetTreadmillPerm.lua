return {
	Name = "settreadmillperm",
	Aliases = { "set treadmill perm", "settapisperm", "givetreadmillperm" },
	Description = "Permanently grant treadmill access (Gold, Diamond, Candy, Admin) to a player. Persists across server restarts.",
	Group = "Admin",
	Args = {
		{
			Type = "player",
			Name = "target",
			Description = "The player to grant permanent treadmill access to.",
		},
		{
			Type = "string",
			Name = "treadmillType",
			Description = "Treadmill type: gold, diamond, candy, admin, or remove (to revoke all permanent access).",
		},
	},
}