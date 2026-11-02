--credit to leon games studio
return {
	Name = "simulatepropcrates",
	Description = "Simulates crate restocks over 10,000 hours and prints average per hour",
	Group = "DefaultAdmin",
	Aliases = { "simulatepropcrates" },
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