return {
	Name = "promptpurchase";
	Aliases = {"promptbuy", "ppurchase"};
	Description = "Prompts every player in every server to purchase a developer product or gamepass.";
	Group = "CustomAdmin";
	Args = {
		{
			Type = "string";
			Name = "type";
			Description = "What to prompt: 'product' (developer product) or 'gamepass'.";
		},
		{
			Type = "integer";
			Name = "id";
			Description = "The developer product ID or gamepass ID to prompt.";
		},
		{
			Type = "string";
			Name = "JobId";
			Description = "Optional target server JobId. Omit to prompt on all servers.";
			Optional = true;
		},
	};
}
