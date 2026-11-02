return {
	Name = "walkspeed";
	Aliases = {};
	Description = "set walkspeed";
	Group = "DefaultAdmin";
	Args = {
		{
			Type = "player";
			Name = "Player";
			Description = "The player.";
		},
		{
			Type = "number";
			Name = "Speed";
			Description = "Speed.";
		}
	};
}