--credit to quartz games studio
return {
	Name = "givepot",
	Description = "Gives pot to a player",
	Group = "DefaultAdmin",
	Aliases = { "givepot" },
	Args = {
		{
			Type = "players",
			Name = "Players",
			Description = "The player(s) to give pot to"
		},
		{
			Type = "positiveInteger",
			Name = "Amount",
			Description = "The number of pots to give (default 1)",
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