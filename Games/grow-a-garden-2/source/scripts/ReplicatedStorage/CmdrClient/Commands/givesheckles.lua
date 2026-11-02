--credit to quartz games studio
return {
	Name = "givesheckles",
	Description = "Gives sheckles (currency) to a player",
	Group = "DefaultAdmin",
	Aliases = { "givesheckles", "givemoney" },
	Args = {
		{
			Type = "players",
			Name = "Players",
			Description = "The player(s) to give sheckles to"
		},
		{
			Type = "positiveInteger",
			Name = "Amount",
			Description = "The amount of sheckles to give"
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