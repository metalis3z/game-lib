--credit to leon games studio
return {
	Name = "guildwipeall",
	Description = "DESTRUCTIVE admin reset: enumerate every guild in the GuildIndex_ByCreatedAt OrderedDataStore and force-disband each via GuildService:DisbandById. Releases all name/tag reservations, kicks every online member, deletes every guild row. Requires literal confirmation token CONFIRM.",
	Group = "DefaultAdmin",
	Aliases = { "guildwipeall", "gwipeall" },
	Args = {
		{
			Type = "string",
			Name = "Confirm",
			Description = "Type CONFIRM (uppercase) to authorize the wipe."
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