--credit to leon games studio
return {
	Name = "expandgarden",
	Description = "Sets a player\'s garden expansion level (defaults to max if no level given)",
	Group = "DefaultAdmin",
	Aliases = { "expandgarden", "setgardensize", "eg" },
	Args = {
		{
			Type = "players",
			Name = "Players",
			Description = "The player(s) to expand the garden for",
			Default = "me"
		},
		{
			Type = "positiveInteger",
			Name = "Level",
			Description = "Target expansion level (1..max). Omit for max.",
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