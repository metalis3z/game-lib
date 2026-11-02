return {
	Name = "announce";
	Aliases = {"anounce"};
	Description = "Makes a server-wide announcement.";
	Group = "CustomAdmin";
	Args = {
		{
			Type = "string";
			Name = "text";
			Description = "The announcement text.";
		},
	};
}