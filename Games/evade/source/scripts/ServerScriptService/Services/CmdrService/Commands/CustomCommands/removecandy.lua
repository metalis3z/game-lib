return {
	Name = "removecandy",
	Aliases = {"candy"},
	Description = "remove candies",
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