--credit to quartz games studio
return {
	Name = "guildkick",
	Description = "Force-eject a player from their guild (admin override).",
	Group = "DefaultAdmin",
	Aliases = { "guildkick" },
	Args = {
		{
			Type = "player",
			Name = "Player",
			Description = "Target player to remove."
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