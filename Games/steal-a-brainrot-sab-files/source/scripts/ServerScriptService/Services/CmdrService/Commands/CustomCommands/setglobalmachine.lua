return {
	Name = "globalmachine",
	Aliases = { "gmachine", "setglobalmachine" },
	Description = "Globally add/remove a machine override. true = add, false = restore default for that machine's group.",
	Group = "Admin",

	Args = {
		{
			Type = "string",
			Name = "machineName",
			Description = "Machine name, e.g. \"Divine Fuse\"",
		},
		{
			Type = "boolean",
			Name = "enabled",
			Description = "true = ReplaceGlobalMachine, false = RemoveGlobalMachine",
		},
	},
}