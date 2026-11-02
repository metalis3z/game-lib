return {
	Name        = "removeglobalcraft";
	Aliases     = {"stopglobalcraft"};
	Description = "Removes a global crafting recipe from the Cyber Craft machine across all servers.";
	Group       = "CustomAdmin";
	Args        = {
		{
			Type        = "string";
			Name        = "key";
			Description = 'The unique key used when the recipe was created, e.g. "Secret_Tralaledon".';
		},
		{
			Type        = "string";
			Name        = "JobId";
			Description = "Optional target server JobId. Omit to remove on all servers.";
			Optional    = true;
		},
	};
}