--credit to quartz games studio
return {
	Name = "mailboxstats",
	Description = "Print mailbox state for online players (or a specific player) plus this server\'s flusher / cache / flag state. Reads MemoryStore MailIndex + DataStore inbox shards when a player is targeted.",
	Group = "DefaultAdmin",
	Aliases = { "mailboxstats", "mailstats", "mbstats" },
	Args = {
		{
			Type = "player",
			Name = "Player",
			Description = "Optional player. With one given, dumps profile + MailIndex + per-shard DataStore counts. Without, prints global server state and a summary line per online player.",
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