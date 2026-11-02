return {
	Name = "brainrotgrab",
	Description = "Grab a Brainrot",
	Args = {
		{
			Type = "animalName";
			Name = "Animal";
			Description = "The animal to grab.";
		},

		-- ⭐ Added Player Argument
		{
			Type = "player";
			Name = "player";
			Description = "The target player.";
		},
	},
}
