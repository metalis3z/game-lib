return {
	Name = "getexistcount",
	Aliases = { "exists", "existcount" },
	Description = "Shows how many of an animal (optionally a specific mutation) currently exist across the server.",
	Group = "Admin",
	Args = {
		{
			Type = "animalName",
			Name = "Brainrot",
			Description = "The brainrot's name",
		},
	},
}