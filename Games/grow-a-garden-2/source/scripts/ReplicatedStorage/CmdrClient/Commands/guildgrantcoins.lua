--credit to quartz games studio
return {
	Name = "guildgrantcoins",
	Description = "Grant Guild Coins to a guild\'s leader balance (testing only).",
	Group = "DefaultAdmin",
	Aliases = { "guildgrantcoins", "ggrant" },
	Args = {
		{
			Type = "string",
			Name = "GuildId",
			Description = "Guild id."
		},
		{
			Type = "integer",
			Name = "Amount",
			Description = "Amount of Guild Coins to grant (negative to deduct)."
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