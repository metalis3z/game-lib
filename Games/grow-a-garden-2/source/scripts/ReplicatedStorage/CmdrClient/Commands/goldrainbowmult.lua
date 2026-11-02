--credit to leon games studio
return {
	Name = "goldrainbowmult",
	Description = "Multiplies the server-wide Gold (Golden Dragonfly) and Rainbow (Unicorn) mutation chance for everyone. Pass 1 to reset.",
	Group = "DefaultAdmin",
	Aliases = { "goldrainbowmult" },
	Args = {
		{
			Type = "number",
			Name = "Multiplier",
			Description = "How much more often Gold/Rainbow mutations roll (default 50, use 1 to reset).",
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