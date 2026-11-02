--credit to quartz games studio
return {
	Name = "setsheckles",
	Description = "Sets a player\'s sheckles (currency) to an exact amount",
	Group = "DefaultAdmin",
	Aliases = { "setsheckles", "setmoney" },
	Args = {
		{
			Type = "players",
			Name = "Players",
			Description = "The player(s) to set sheckles for"
		},
		{
			Type = "nonNegativeInteger",
			Name = "Amount",
			Description = "The amount of sheckles to set"
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