return {
	Name = "unlockbase";
	Aliases = {"forceunlock", "breakin"};
	Description = "Forces unlock a floor in the target player's base.";
	Group = "CustomAdmin";
	Args = {
		{
			Type = "player";
			Name = "player";
			Description = "The target player whose base will be unlocked.";
		},
		{
			Type = "integer";
			Name = "floor";
			Description = "The floor number to unlock (1, 2, or 3).";
		}
	};
}
