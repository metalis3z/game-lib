--credit to quartz games studio
return {
	Name = "guildseticon",
	Description = "Set a guild\'s icon image asset id (admin).",
	Group = "DefaultAdmin",
	Aliases = { "guildseticon", "gseticon" },
	Args = {
		{
			Type = "string",
			Name = "GuildId",
			Description = "Guild id."
		},
		{
			Type = "integer",
			Name = "IconId",
			Description = "Image asset id to set as the guild icon (positive integer)."
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