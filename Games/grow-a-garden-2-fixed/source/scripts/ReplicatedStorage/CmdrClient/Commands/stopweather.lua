--credit to prince games studio
return {
	Name = "stopweather",
	Description = "Stops a currently active weather",
	Group = "DefaultAdmin",
	Aliases = { "stopweather" },
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