return {
	Name = "playsoundall",
	Aliases = { "psa" },
	Description = "Plays a sound on all clients in a target server via MessagingService. Omit JobId to broadcast to every server.",
	Group = "Admin",
	Args = {
		{
			Type = "string",
			Name = "SoundId",
			Description = "Roblox sound asset ID — bare number (12345678) or full rbxassetid:// URI.",
		},
		{
			Type = "string",
			Name = "JobId",
			Description = "Target server JobId. Omit to broadcast to all servers.",
			Optional = true,
		},
	},
}