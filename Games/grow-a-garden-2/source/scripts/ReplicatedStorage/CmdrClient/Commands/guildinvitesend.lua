--credit to leon games studio
return {
	Name = "guildinvitesend",
	Description = "Send a simulated guild invite to a player. Bypasses normal invite-permission checks (the whole point of the cmd). Source guild defaults to the admin\'s own guild membership; pass a GuildId to fabricate an invite from any guild instead. Goes through the durable InviteStore + MessagingService path so the recipient sees it identically to a real invite (mailbox tile + toast prompt).",
	Group = "DefaultAdmin",
	Aliases = { "guildinvitesend", "ginvite" },
	Args = {
		{
			Type = "player",
			Name = "Player",
			Description = "Target player to receive the invite."
		},
		{
			Type = "string",
			Name = "GuildId",
			Description = "Optional guild id to fabricate the invite from (defaults to the admin\'s own guild).",
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