--credit to quartz games studio
return {
	Name = "giveguildcrate",
	Description = "Gives guild crate(s) to a player",
	Group = "DefaultAdmin",
	Aliases = { "giveguildcrate" },
	Args = {
		{
			Type = "players",
			Name = "Players",
			Description = "The player(s) to give guild crates to"
		},
		{
			Type = "guildCrateName",
			Name = "GuildCrateName",
			Description = "The name of the guild crate"
		},
		{
			Type = "positiveInteger",
			Name = "Amount",
			Description = "The number of guild crates to give (default 1)",
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