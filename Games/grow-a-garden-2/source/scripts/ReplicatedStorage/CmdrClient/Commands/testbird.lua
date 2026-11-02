--credit to leon games studio
return {
	Name = "testbird",
	Description = "Makes all birds online (placed birds + bird pets) attempt to eat fruit far more often, for testing. Pass 1 to reset.",
	Group = "DefaultAdmin",
	Aliases = { "testbird" },
	Args = {
		{
			Type = "number",
			Name = "Multiplier",
			Description = "How much more often birds try to eat (default 20, use 1 to reset).",
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