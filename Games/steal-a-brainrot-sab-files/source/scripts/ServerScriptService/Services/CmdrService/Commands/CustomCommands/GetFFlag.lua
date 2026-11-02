return {
	Name = "getfflag",
	Aliases = {"gflag"},
	Description = "Gets a feature flag value",
	Group = "Admin",
	Args = {
		{
			Type = "string",
			Name = "Key",
			Description = "The FFlag key name"
		},
		{
			Type = "string",
			Name = "Default",
			Description = "Default value if not found",
			Optional = true,
			Default = "nil"
		}
	}
}