return {
	Name = "startPoll",
	Description = "Start a global poll across all servers",
	Group = "Admin",
	Args = {
		{
			Type = "number";
			Name = "Duration";
			Description = "Duration in seconds";
		},
		{
			Type = "string";
			Name = "Option1";
			Description = "Left option (use quotes for multiple words)";
		},
		{
			Type = "string";
			Name = "Option2";
			Description = "Right option (use quotes for multiple words)";
		},
		{
			Type = "string";
			Name = "Question";
			Description = "The question to poll on";
			Default = "";
		},
	}
}