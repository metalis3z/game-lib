--credit to prince games studio
return {
	Name = "giveallseeds",
	Description = "Gives 1 of every seed in the game to a player",
	Group = "DefaultAdmin",
	Aliases = { "giveallseeds", "allseeds" },
	Args = {
		{
			Type = "players",
			Name = "Players",
			Description = "The player(s) to give all seeds to"
		},
		{
			Type = "positiveInteger",
			Name = "Amount",
			Description = "The number of each seed to give (default 1)",
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