--credit to quartz games studio
return {
	Name = "matchmaking",
	Description = "Show matchmaking attributes for yourself, all players, and server averages",
	Group = "DefaultAdmin",
	Aliases = { "mm" },
	Args = {}
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