return {
	Name = "addcandy",
	Aliases = {"candy"},
	Description = "Adds candies",
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