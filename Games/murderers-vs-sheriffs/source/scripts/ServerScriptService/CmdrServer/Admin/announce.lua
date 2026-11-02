return {
	Name = "announce";
	Aliases = {"ann", "broadcast"};
	Description = "Sends a global announcement using the existing announcement GUI.";
	Group = "DefaultAdmin";
	Args = {
		{
			Type = "string";
			Name = "Message";
			Description = "The announcement message.";
		},
	};
}