return {
	Name = "setfflag",
	Aliases = {"fflag", "flag"},
	Description = "Sets a feature flag value",
	Group = "Admin",
	Args = {
		{
			Type = "string",
			Name = "Key",
			Description = "The FFlag key name"
		},
		{
			Type = "string",
			Name = "Value",
			Description = "The value (true/false/number/string/nil)",
			Optional = false
		},
	}
}