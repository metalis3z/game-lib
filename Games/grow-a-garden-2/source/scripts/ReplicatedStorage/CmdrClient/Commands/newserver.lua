--credit to leon games studio
return {
	Name = "newserver",
	Description = "Reserves a fresh private server in the current place and teleports the executor (or specified players) to it.",
	Group = "DefaultAdmin",
	Aliases = { "newserver", "newprivateserver", "ps" },
	Args = {
		{
			Type = "players",
			Name = "Players",
			Description = "Player(s) to send to the new private server. Defaults to the executor.",
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