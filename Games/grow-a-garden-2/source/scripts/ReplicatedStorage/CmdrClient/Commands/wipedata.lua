--credit to quartz games studio
return {
	Name = "wipedata",
	Description = "Wipes a player\'s data and kicks them",
	Group = "DefaultAdmin",
	Aliases = { "wipedata" },
	Args = {
		{
			Type = "players",
			Name = "Players",
			Description = "The player(s) to wipe data for"
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