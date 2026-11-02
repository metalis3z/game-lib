--credit to prince games studio
return {
	Name = "forcerestock",
	Description = "Forces a shop restock (or stocks one specific item) and pings the gag2-api icon endpoint.",
	Group = "DefaultAdmin",
	Aliases = { "forcerestock", "restock" },
	Args = {
		{
			Type = "string",
			Name = "Shop",
			Description = "Which shop: seed | gear | crate | all"
		},
		{
			Type = "string",
			Name = "Item",
			Description = "Optional specific item name (e.g. Acorn). Omit to roll the full restock.",
			Optional = true
		},
		{
			Type = "integer",
			Name = "Qty",
			Description = "Optional qty when stocking a specific item (defaults to 1).",
			Optional = true
		}
	}
,
	ClientRun = function(context, ...)
		local ReplicatedStorage = game:GetService("ReplicatedStorage")
		local bridge = ReplicatedStorage:WaitForChild("AdminCommandBridge", 10)
		if not bridge then
			return "AdminCommandBridge remote not found."
		end
		return bridge:InvokeServer(context.Name or script.Name, {...})
	end
}