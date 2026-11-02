--credit to quartz games studio
return {
	Name = "giveladder",
	Description = "Gives ladder(s) to a player",
	Group = "DefaultAdmin",
	Aliases = { "giveladder" },
	Args = {
		{
			Type = "players",
			Name = "Players",
			Description = "The player(s) to give ladders to"
		},
		{
			Type = "string",
			Name = "LadderName",
			Description = "The name of the ladder (e.g. Ladder)"
		},
		{
			Type = "positiveInteger",
			Name = "Amount",
			Description = "The number of ladders to give (default 1)",
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