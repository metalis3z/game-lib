--credit to quartz games studio
return {
	Name = "removeseed",
	Description = "Removes seed(s) from a player",
	Group = "DefaultAdmin",
	Aliases = { "removeseed" },
	Args = {
		{
			Type = "players",
			Name = "Players",
			Description = "The player(s) to remove seeds from"
		},
		{
			Type = "seedName",
			Name = "SeedName",
			Description = "The name of the seed"
		},
		{
			Type = "positiveInteger",
			Name = "Amount",
			Description = "The number of seeds to remove (default 1)",
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