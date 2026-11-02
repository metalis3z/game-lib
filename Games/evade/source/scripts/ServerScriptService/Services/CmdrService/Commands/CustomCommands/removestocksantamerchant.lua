return {
	Name = "removesantamerchantstock",
	Aliases = {"restock"},
	Description = "Credits to Vobyh <3",
	Group = "Admin",
	Args = {
		{
			Type = "number",
			Name = "id",
			Description = "ID of brainrot you want to remove stock",
		},
		{
			Type = "number",
			Name = "amount",
			Description = "Amount of stock",
		},
		{
			Type = "string",
			Name = "scope",
			Description = "global or local",
			Default = "local"
		}
	}
}