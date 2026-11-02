--credit to leon games studio
return {
	Name = "growall",
	Description = "Grows a player\'s garden",
	Group = "DefaultAdmin",
	Aliases = { "growall" },
	Args = {
		{
			Type = "players",
			Name = "Players",
			Description = "The player(s) to grow all"
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