--credit to prince games studio
return {
	Name = "guilddebug",
	Description = "Dump full state of a guild across every storage layer (DataStore, OrderedDataStore indices, reservations, in-memory caches, Auction manifest, online member presence). Pass either a player (resolves to their guild) or a guild id directly. Output goes to the server console pretty-printed; a short summary is returned here.",
	Group = "DefaultAdmin",
	Aliases = { "guilddebug", "gdebug" },
	Args = {
		{
			Type = "player",
			Name = "Player",
			Description = "Player whose guild to inspect (resolves their GuildId).",
			Optional = true
		},
		{
			Type = "string",
			Name = "GuildId",
			Description = "Guild id to inspect (overrides Player if both are given).",
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