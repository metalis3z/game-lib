--credit to leon games studio
return {
	Name = "bargainab",
	Description = "Force-enables/disables the A/B-gated Bargain option at Steven (the daily deal lives inside it)",
	Group = "DefaultAdmin",
	Aliases = { "bargainab", "setbargain" },
	Args = {
		{
			Type = "players",
			Name = "Players",
			Description = "The player(s) to override"
		},
		{
			Type = "boolean",
			Name = "Enabled",
			Description = "true = show Bargain!, false = hide it"
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