return {
	Name        = "removeglobalcode";
	Aliases     = {"deleteglobalcode", "rgcode"};
	Description = 'Removes a Global Code across ALL servers: clears the shared MemoryStoreService stock and '
		.. 'broadcasts the removal via MessagingService. Admin-only. Args: code';
	Group       = "CustomAdmin";
	Args        = {
		{
			Type        = "string";
			Name        = "code";
			Description = 'The code text to remove (e.g. "WINTER2025"). Auto-uppercased.';
		},
	};
}
