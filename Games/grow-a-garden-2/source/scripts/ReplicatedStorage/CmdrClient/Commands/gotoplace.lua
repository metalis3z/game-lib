--credit to quartz games studio
return {
	Name = "gotoplace",
	Description = "Teleports the executor (or specified players) to a public server of the given place (Primary, FirstSession, NewUser) in this environment.",
	Group = "DefaultAdmin",
	Aliases = { "gp" },
	Args = {
		{
			Type = "place",
			Name = "Place",
			Description = "Destination place type."
		},
		{
			Type = "players",
			Name = "Players",
			Description = "Player(s) to teleport. Defaults to the executor.",
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