return {
	Name = "revealroles";
	Aliases = {"rr"};
	Description = "Reveals every player's role above their head for a set amount of time.";
	Group = "DefaultAdmin";
	Args = {
		{
			Type = "number";
			Name = "Seconds";
			Description = "How long roles should stay revealed.";
		},
	};
}