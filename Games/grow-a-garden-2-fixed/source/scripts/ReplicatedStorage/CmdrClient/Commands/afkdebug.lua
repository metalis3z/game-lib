--credit to prince games studio
return {
	Name = "afkdebug",
	Description = "Override your anti-AFK idle threshold (seconds) for this session. Use 0 to clear.",
	Group = "DefaultAdmin",
	Aliases = { "afkdebug" },
	Args = {
		{
			Type = "number",
			Name = "Seconds",
			Description = "Idle seconds before the anti-AFK hop triggers (0 = clear override, back to default)."
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