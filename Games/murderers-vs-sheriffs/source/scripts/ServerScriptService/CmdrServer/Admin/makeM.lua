return {
	Name = "makeM";
	Aliases = {"makem", "makeMurderer", "setmurderer"};
	Description = "Makes a player Murderer next round.";
	Group = "DefaultAdmin";
	Args = {
		{
			Type = "player";
			Name = "Player";
			Description = "The player to make Murderer.";
		},
	};
}