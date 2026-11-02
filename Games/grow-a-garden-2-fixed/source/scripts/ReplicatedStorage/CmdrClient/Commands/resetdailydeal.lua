--credit to leon games studio
return {
	Name = "resetdailydeal",
	Description = "Resets a player\'s Steven daily deal cooldown so the 5x sell is available again",
	Group = "DefaultAdmin",
	Aliases = { "resetdailydeal", "cleardailydeal" },
	Args = {
		{
			Type = "players",
			Name = "Players",
			Description = "The player(s) whose daily deal should be reset"
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