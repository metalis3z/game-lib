return {
	Name = "globalsnap";
	Aliases = { "snap" };
	Description = "Triggers a global snap event with an optional offline target and optional snap type.";
	Group = "CustomAdmin";

	Args = {
		{
			Type = "eventName";
			Name = "Event";
			Description = "The event/location to play after the snap (e.g. 'Concert').";
		},
		{
			Type = "string";
			Name = "Username";
			Description = "Optional username or userId to use for the snap appearance. Does not need to be online.";
			Optional = true;
		},
		{
			Type = "string";
			Name = "Type";
			Description = "Optional snap type. Defaults to 'sammysnap'.";
			Optional = true;
		},
		{
			Type = "string";
			Name = "JobId";
			Description = "Optional target server JobId. Omit to snap on all servers.";
			Optional = true;
		},
	};
}