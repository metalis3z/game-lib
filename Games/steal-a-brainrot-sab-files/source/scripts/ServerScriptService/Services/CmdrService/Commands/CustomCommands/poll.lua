return {
	Name = "poll";
	Aliases = {"Vote"};
	Description = "Makes a server-Poll announcement.";
	Group = "CustomAdmin";
	Args = {
		{
			Type = "string";
			Name = "question";
			Description = "The question text.";
		},
		{
			Type = "string";
			Name = "option1";
			Description = "The first option text.";
		},
		{
			Type = "string";
			Name = "option2";
			Description = "The second option text.";
		},
		{
			Type = "string";
			Name = "color1";
			Description = "Color for option 1.";
			Optional = true;
		},
		{
			Type = "string";
			Name = "color2";
			Description = "Color for option 2.";
			Optional = true;
		},
		{
			Type = "number";
			Name = "Duration";
			Description = "The poll's Duration";
			Optional = true;
		},
		{
			Type = "boolean";
			Name = "IsGlobal";
			Description = "If the poll is global.";
			Optional = true;
		},
		{
			Type = "boolean";
			Name = "isFake";
			Description = "Whether this is a fake poll.";
			Optional = true;
		},
		{
			Type = "number";
			Name = "FakeVotesA";
			Description = "Amount of fake votes for A.";
			Optional = true;
		},
		{
			Type = "number";
			Name = "FakeVotesB";
			Description = "Amount of fake votes for B.";
			Optional = true;
		},
	};
}