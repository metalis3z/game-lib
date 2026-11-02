--credit to prince games studio
return {
	Name = "guildsetslots",
	Description = "Set a guild\'s member cap to an absolute value (QA/testing). Unlike purchases this may go BELOW the normal 20 floor -- e.g. `guildsetslots 3` caps your own guild at 3 members to test guild_full paths. Defaults to your guild; pass a player to target theirs, or a guild id directly.",
	Group = "DefaultAdmin",
	Aliases = { "guildsetslots", "gsetslots" },
	Args = {
		{
			Type = "integer",
			Name = "Slots",
			Description = "New member cap (1-50)."
		},
		{
			Type = "player",
			Name = "Player",
			Description = "Player whose guild to modify (defaults to you).",
			Optional = true
		},
		{
			Type = "string",
			Name = "GuildId",
			Description = "Guild id to modify (overrides Player if both are given).",
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