--credit to quartz games studio
return {
	Name = "competitionsetscore",
	Description = "Set or adjust a guild\'s score for a player in a competition (backend admin store). Note: the backend max-merges scores, so a value LOWER than the player\'s profile score is restored on their next tick; use this mainly to seed/raise. Pass the competition id, the guild\'s TAG or guild_id UUID, a numeric UserId or username, and a value: \"N\" (set), \"+N\" (add), \"-N\" (subtract).",
	Group = "DefaultAdmin",
	Aliases = { "competitionsetscore", "csetscore" },
	Args = {
		{
			Type = "string",
			Name = "Competition",
			Description = "Competition id (the *.json5 filename minus extension), e.g. most_carrots."
		},
		{
			Type = "string",
			Name = "Guild",
			Description = "Guild tag (e.g. JOE) or full guild_id UUID."
		},
		{
			Type = "string",
			Name = "Player",
			Description = "Numeric UserId or Roblox username (resolved via GetUserIdFromNameAsync)."
		},
		{
			Type = "string",
			Name = "Value",
			Description = "Value: \"N\" (set), \"+N\" (add), \"-N\" (subtract). Decimals allowed."
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