--credit to quartz games studio
return {
	Name = "giverobin",
	Description = "Gives a robin to a player",
	Group = "DefaultAdmin",
	Aliases = { "giverobin" },
	Args = {
		{
			Type = "players",
			Name = "Players",
			Description = "The player(s) to give the robin to"
		},
		{
			Type = "positiveInteger",
			Name = "Amount",
			Description = "The number of robins to give (default 1)",
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