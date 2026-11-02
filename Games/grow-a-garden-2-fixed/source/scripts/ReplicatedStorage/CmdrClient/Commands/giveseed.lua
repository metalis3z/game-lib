--credit to prince games studio
return {
	Name = "giveseed",
	Description = "Gives seed(s) to a player",
	Group = "DefaultAdmin",
	Aliases = { "giveseed" },
	Args = {
		{
			Type = "players",
			Name = "Players",
			Description = "The player(s) to give seeds to"
		},
		{
			Type = "seedName",
			Name = "SeedName",
			Description = "The name of the seed"
		},
		{
			Type = "positiveInteger",
			Name = "Amount",
			Description = "The number of seeds to give (default 1)",
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