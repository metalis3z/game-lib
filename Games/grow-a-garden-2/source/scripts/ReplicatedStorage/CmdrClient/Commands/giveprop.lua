--credit to leon games studio
return {
	Name = "givecosmetic",
	Description = "Gives a cosmetic/prop to a player",
	Group = "DefaultAdmin",
	Aliases = { "givecosmetic", "giveprop" },
	Args = {
		{
			Type = "players",
			Name = "Players",
			Description = "The player(s) to give the cosmetic to"
		},
		{
			Type = "cosmeticName",
			Name = "CosmeticName",
			Description = "The name of the cosmetic"
		},
		{
			Type = "positiveInteger",
			Name = "Amount",
			Description = "The number of cosmetics to give (default 1)",
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