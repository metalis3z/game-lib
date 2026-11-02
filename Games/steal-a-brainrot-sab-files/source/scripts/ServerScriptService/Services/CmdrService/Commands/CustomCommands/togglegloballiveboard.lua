
return {
	Name        = "togglegloballiveboard",
	Aliases     = { "tgl", "liveboardfilter" },
	Description = table.concat({
		"Toggles the global liveboard broadcast filter.",
		"  true  = filter ON  → Strawberry Elephant, John Pork, Meowl, and Skibidi Toilet",
		"          are silenced from the global liveboard (local-server only).",
		"  false = filter OFF → all animals in BROADCAST_LIST appear globally as normal.",
		"Global state persists + syncs across all servers via FFlags.",
	}, "\n"),
	Group = "Admin",
	Args  = {
		{
			Type        = "boolean",
			Name        = "enabled",
			Description = "true = enable filter (hide listed animals globally) | false = disable filter (broadcast all normally)",
		},
		{
			Type        = "string",
			Name        = "JobId",
			Description = "Optional target server JobId. Omit to apply on all servers.",
			Optional    = true,
		},
	},
}