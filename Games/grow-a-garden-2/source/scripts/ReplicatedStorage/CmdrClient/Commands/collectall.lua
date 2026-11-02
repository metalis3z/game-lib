--credit to quartz games studio
return {
	Name = "collectall",
	Description = "Collects all fully-grown fruits and single-harvest plants for player(s)",
	Group = "DefaultAdmin",
	Aliases = { "collectall" },
	Args = {
		{
			Type = "players",
			Name = "Players",
			Description = "The player(s) to collect all fruits for"
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