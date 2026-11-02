return {
	Name = "removeelf",
	Aliases = {"elfremove"},
	Description = "remove elf",
	Args = {
		{
			Type = "players",
			Name = "player",
			Description = "Target",
		},
		{
			Type = "number",
			Name = "amount",
			Description = "Amount",
		}
	}
}