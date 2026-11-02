--credit to prince games studio
return {
	Name = "giveskillpoints",
	Description = "Gives skillpoints (currency) to a player",
	Group = "DefaultAdmin",
	Aliases = { "giveskillpoints", "givemoney" },
	Args = {
		{
			Type = "players",
			Name = "Players",
			Description = "The player(s) to give skillpoints to"
		},
		{
			Type = "positiveInteger",
			Name = "Amount",
			Description = "The amount of skillpoints to give"
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