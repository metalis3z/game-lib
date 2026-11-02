--credit to quartz games studio
return {
	Name = "removesheckles",
	Description = "Removes sheckles (currency) from a player",
	Group = "DefaultAdmin",
	Aliases = { "removesheckles", "removemoney" },
	Args = {
		{
			Type = "players",
			Name = "Players",
			Description = "The player(s) to remove sheckles from"
		},
		{
			Type = "positiveInteger",
			Name = "Amount",
			Description = "The amount of sheckles to remove"
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