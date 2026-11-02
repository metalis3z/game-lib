return {
	Name = "announce",
	Aliases = { "ann", "globalmsg", "shout" },
	Description = "Send an announcement to all players in this server using the event announcement interface.",
	Group = "Admin",
	Args = {
		{
			Type = "string",
			Name = "message",
			Description = "The announcement message to display to all players.",
		},
	},
}