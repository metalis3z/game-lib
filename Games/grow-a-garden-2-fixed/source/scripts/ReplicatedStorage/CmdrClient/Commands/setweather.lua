--credit to leon games studio
return {
	Name = "setweather",
	Description = "Sets the server weather",
	Group = "DefaultAdmin",
	Aliases = { "setweather" },
	Args = {
		{
			Type = "weather",
			Name = "Weather",
			Description = "The Weather"
		},
		{
			Type = "number",
			Name = "Duration",
			Description = "How long the weather lasts in seconds (default: the weather\'s normal duration).",
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