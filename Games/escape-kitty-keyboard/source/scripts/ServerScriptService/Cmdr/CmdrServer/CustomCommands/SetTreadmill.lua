return {
	Name = "settreadmill",
	Aliases = { "set treadmill", "settapis", "givetreadmill" },
	Description = "Grant treadmill access (Gold, Diamond, Candy, Admin) to a player without requiring the gamepass.",
	Group = "Admin",
	Args = {
		{
			Type = "player",
			Name = "target",
			Description = "The player to grant treadmill access to.",
		},
		{
			Type = "string",
			Name = "treadmillType",
			Description = "Treadmill type: gold, diamond, candy, admin, or remove (to revoke all admin access).",
		},
	},
}