return {
	Name = "announce";
	Aliases = {"m"};
	Description = "Makes a server-wide announcement.";
	Group = "CustomAdmin";
	Args = {
		{
			Type = "string";
			Name = "text";
			Description = "The announcement text.";
		},
		{
			Type = "gradientTag";
			Name = "text";
			Description = "The Gradient.";
			Optional = true;
		}
	};
}
