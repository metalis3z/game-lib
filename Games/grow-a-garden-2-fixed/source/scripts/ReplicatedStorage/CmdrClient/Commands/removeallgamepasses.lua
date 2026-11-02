--credit to prince games studio
return {
	Name = "removeallgamepasses",
	Description = "Removes ALL gamepasses from a player and kicks them so they relog",
	Group = "DefaultAdmin",
	Aliases = { "removeallgamepasses" },
	Args = {
		{
			Type = "players",
			Name = "Players",
			Description = "The player(s) to remove all gamepasses from"
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