return {
	Name = "globalannounce";
	Aliases = {"globalannouce"};
	Description = "Makes a Global announcement.";
	Group = "CustomAdmin";
	Args = {
		{
			Type = "string";
			Name = "text";
			Description = "The announcement text.";
		},
		{
			Type = "string";
			Name = "JobId";
			Description = "Optional target server JobId. Omit to broadcast globally.";
			Optional = true;
		},
	};
}
