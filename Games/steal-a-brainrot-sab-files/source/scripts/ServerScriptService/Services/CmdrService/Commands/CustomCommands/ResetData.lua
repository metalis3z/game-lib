return {
	Name = "resetdata",
	Aliases = {"wipedata", "cleardata", "wipe"},
	Description = "Completely wipes a player's data from all datastores",
	Group = "Admin",
	Args = {
		{
			Type = "players",
			Name = "Target",
			Description = "The player(s) whose data to reset"
		},
		{
			Type = "string",
			Name = "Confirmation",
			Description = "Type 'CONFIRM' to proceed",
			Optional = false
		}
	}
}