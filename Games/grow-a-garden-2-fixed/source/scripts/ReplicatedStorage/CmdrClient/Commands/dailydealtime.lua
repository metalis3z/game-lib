--credit to leon games studio
return {
	Name = "dailydealtime",
	Description = "Shows whether Steven\'s daily deal is available and the time remaining until it resets",
	Group = "DefaultAdmin",
	Aliases = { "dailydealtime", "checkdailydeal", "dailydealstatus" },
	Args = {
		{
			Type = "players",
			Name = "Players",
			Description = "The player(s) to check"
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