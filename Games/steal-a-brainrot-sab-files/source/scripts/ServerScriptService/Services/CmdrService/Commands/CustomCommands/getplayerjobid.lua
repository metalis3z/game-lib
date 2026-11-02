return {
	Name = "getplayerjobid";
	Aliases = { "findplayer", "playerjobid" };
	Description = "Look up the JobId of the server a player is in (across all running servers).";
	Group = "CustomAdmin";
	Args = {
		{
			Type = "string";
			Name = "Username";
			Description = "Exact username (case-insensitive).";
		},
	};
}