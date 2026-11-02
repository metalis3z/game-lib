--credit to leon games studio
-- Reconstruido: el original se perdió (decompiler timed out) y el módulo
-- vacío rompía Registry:RegisterCommand → CMDRController no cargaba.
return {
	Name = "forceweather",
	Description = "Forces the server weather (ignores cooldowns)",
	Group = "DefaultAdmin",
	Aliases = { "forceweather" },
	Args = {
		{
			Type = "weather",
			Name = "Weather",
			Description = "The Weather"
		},
		{
			Type = "number",
			Name = "Duration",
			Description = "How long the weather lasts in seconds (default: the weather's normal duration).",
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