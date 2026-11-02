return {
	Name = "prompt";
	Aliases = {"event"};
	Description = "Makes an event prompt.";
	Group = "CustomAdmin";
	Args = {
		{
			Type = "string";
			Name = "id of event";
			Description = "The question text.";
		},
		{
			Type = "string";
			Name = "JobId";
			Description = "Optional target server JobId. Omit to prompt on all servers.";
			Optional = true;
		},
	};
}
