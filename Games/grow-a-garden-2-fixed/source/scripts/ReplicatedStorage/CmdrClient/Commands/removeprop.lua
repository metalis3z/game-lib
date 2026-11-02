--credit to quartz games studio
return {
	Name = "removecosmetic",
	Description = "Removes a cosmetic/prop from a player",
	Group = "DefaultAdmin",
	Aliases = { "removecosmetic", "removeprop" },
	Args = {
		{
			Type = "players",
			Name = "Players",
			Description = "The player(s) to remove the cosmetic from"
		},
		{
			Type = "cosmeticName",
			Name = "CosmeticName",
			Description = "The name of the cosmetic"
		},
		{
			Type = "positiveInteger",
			Name = "Amount",
			Description = "The number of cosmetics to remove (default 1)",
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