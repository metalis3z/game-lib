
return {
	Name = "liveboardset",
	Aliases = { "lbset", "lb" },
	Description = "Forces a liveboard entry for a chosen player, animal, and optional mutation.",
	Group = "DefaultAdmin",
	Args = {
		{
			Type = "player",
			Name = "player",
			Description = "The player to show as the owner on the liveboard.",
		},
		{
			Type = "string",
			Name = "animalName",
			Description = "The BrainrotName of the animal (e.g. 'Skibidi Toilet').",
		},
		{
			Type = "string",
			Name = "mutationName",
			Description = "The mutation name (e.g. 'Golden'). Pass 'none' to leave it nil.",
			Optional = true,
		},
	},
}