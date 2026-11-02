--credit to quartz games studio
return {
	Name = "giveflashbang",
	Description = "Gives a flashbang to a player",
	Group = "DefaultAdmin",
	Aliases = { "giveflashbang", "givefb" },
	Args = {
		{
			Type = "players",
			Name = "Players",
			Description = "The player(s) to give the flashbang to"
		},
		{
			Type = "positiveInteger",
			Name = "Amount",
			Description = "The number of flashbangs to give (default 1)",
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