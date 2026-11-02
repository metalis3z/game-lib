--credit to leon games studio
return {
	Name = "guildjoin",
	Description = "Force a player to join a guild (admin override; bypasses invite checks).",
	Group = "DefaultAdmin",
	Aliases = { "guildjoin" },
	Args = {
		{
			Type = "player",
			Name = "Player",
			Description = "Target player."
		},
		{
			Type = "string",
			Name = "GuildId",
			Description = "Guild id."
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