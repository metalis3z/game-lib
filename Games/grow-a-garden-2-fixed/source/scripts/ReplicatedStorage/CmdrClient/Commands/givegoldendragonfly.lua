--credit to leon games studio
return {
	Name = "givegoldendragonfly",
	Description = "Adds Golden Dragonfly follower pet(s) to a player\'s Pets data",
	Group = "DefaultAdmin",
	Aliases = { "givegoldendragonfly" },
	Args = {
		{
			Type = "players",
			Name = "Players",
			Description = "The player(s) to give the golden dragonfly to"
		},
		{
			Type = "positiveInteger",
			Name = "Amount",
			Description = "The number of golden dragonflies to give (default 1)",
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