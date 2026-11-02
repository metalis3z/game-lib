return {
	Name = "resetofflinedata",
	Aliases = {"wipeoffline"},
	Description = "Resets data for an offline player by UserId",
	Group = "Admin",
	Args = {
		{
			Type = "number",
			Name = "UserId",
			Description = "The UserId of the player to reset"
		},
		{
			Type = "string",
			Name = "Confirmation",
			Description = "Type 'CONFIRM' to proceed",
			Optional = false
		}
	}
}