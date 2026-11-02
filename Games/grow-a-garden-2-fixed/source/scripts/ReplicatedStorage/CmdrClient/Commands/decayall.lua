--credit to prince games studio
return {
	Name = "decayall",
	Description = "Forces all plants in a player\'s garden into the fully decayed (worst) state",
	Group = "DefaultAdmin",
	Aliases = { "decayall" },
	Args = {
		{
			Type = "players",
			Name = "Players",
			Description = "The player(s) whose plants should be fully decayed"
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