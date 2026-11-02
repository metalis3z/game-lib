--credit to quartz games studio
return {
	Name = "removesprinkler",
	Description = "Removes a sprinkler from a player",
	Group = "DefaultAdmin",
	Aliases = { "removesprinkler" },
	Args = {
		{
			Type = "players",
			Name = "Players",
			Description = "The player(s) to remove the sprinkler from"
		},
		{
			Type = "sprinklerName",
			Name = "SprinklerName",
			Description = "The name of the sprinkler"
		},
		{
			Type = "positiveInteger",
			Name = "Amount",
			Description = "The number of sprinklers to remove (default 1)",
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