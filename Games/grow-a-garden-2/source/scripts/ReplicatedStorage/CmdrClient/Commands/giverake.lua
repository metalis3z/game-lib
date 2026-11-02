--credit to quartz games studio
return {
	Name = "giverake",
	Description = "Gives a rake to a player",
	Group = "DefaultAdmin",
	Aliases = { "giverake" },
	Args = {
		{
			Type = "players",
			Name = "Players",
			Description = "The player(s) to give the rake to"
		},
		{
			Type = "rakeName",
			Name = "RakeName",
			Description = "The name of the rake"
		},
		{
			Type = "positiveInteger",
			Name = "Amount",
			Description = "The number of rakes to give (default 1)",
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