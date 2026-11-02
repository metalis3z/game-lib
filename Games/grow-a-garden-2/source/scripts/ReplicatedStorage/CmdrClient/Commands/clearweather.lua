--credit to quartz games studio
return {
	Name = "clearweather",
	Description = "Clears the server weather",
	Group = "DefaultAdmin",
	Aliases = { "clearweather" },
	Args = {
		{
			Type = "weather",
			Name = "Weather",
			Description = "The Weather"
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