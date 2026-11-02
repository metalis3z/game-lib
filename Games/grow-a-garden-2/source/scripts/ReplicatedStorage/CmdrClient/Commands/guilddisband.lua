--credit to quartz games studio
return {
	Name = "guilddisband",
	Description = "Admin-forced disband of a guild by id. Releases reservations.",
	Group = "DefaultAdmin",
	Aliases = { "guilddisband", "gdisband" },
	Args = {
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