--credit to prince games studio
return {
	Name = "competitiontop",
	Description = "Print the top 10 guilds for a competition, ranked by score. Reads the cached tick standings (the active competition). Pass a competition id to assert which one you expect; omit it to use the active competition. Companion to /competitionstatus.",
	Group = "DefaultAdmin",
	Aliases = { "competitiontop", "ctop", "topguilds" },
	Args = {
		{
			Type = "string",
			Name = "Competition",
			Description = "Competition id to print. Optional; defaults to the active competition.",
			Optional = true
		},
		{
			Type = "integer",
			Name = "Count",
			Description = "How many guilds to print (default 10).",
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