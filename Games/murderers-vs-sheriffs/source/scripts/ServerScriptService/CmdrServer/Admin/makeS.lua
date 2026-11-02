return {
	Name = "makeS";
	Aliases = {"makes", "makeSheriff", "setsheriff"};
	Description = "Makes a player Sheriff next round.";
	Group = "DefaultAdmin";
	Args = {
		{
			Type = "player";
			Name = "Player";
			Description = "The player to make Sheriff.";
		},
	};
}