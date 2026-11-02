return {
	Name = "kickid";
	Aliases = {"kickuserid", "gkickid"};
	Description = "Kicks a UserId globally with a reason.";
	Group = "DefaultAdmin";
	Args = {
		{
			Type = "string";
			Name = "targetId";
			Description = "The UserId of the player to kick.";
		},
		{
			Type = "string";
			Name = "reason";
			Description = "The reason for the kick.";
			Default = "Kicked by admin.";
		}
	};
}