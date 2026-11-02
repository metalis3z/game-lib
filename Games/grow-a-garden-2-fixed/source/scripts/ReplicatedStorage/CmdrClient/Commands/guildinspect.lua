--credit to prince games studio
return {
	Name = "guildinspect",
	Description = "Inspect a guild via a player or a guild id.",
	Group = "DefaultAdmin",
	Aliases = { "guildinspect", "ginspect" },
	Args = {
		{
			Type = "player",
			Name = "Player",
			Description = "Player whose guild to inspect.",
			Optional = true
		},
		{
			Type = "string",
			Name = "GuildId",
			Description = "Guild id (overrides Player).",
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