--credit to quartz games studio
return {
	Name = "giveowl",
	Description = "Adds Owl follower pet(s) to a player\'s Pets data",
	Group = "DefaultAdmin",
	Aliases = { "giveowl" },
	Args = {
		{
			Type = "players",
			Name = "Players",
			Description = "The player(s) to give the owl to"
		},
		{
			Type = "positiveInteger",
			Name = "Amount",
			Description = "The number of owls to give (default 1)",
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