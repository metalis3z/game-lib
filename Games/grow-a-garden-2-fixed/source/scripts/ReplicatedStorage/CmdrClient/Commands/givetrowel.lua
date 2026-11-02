--credit to leon games studio
return {
	Name = "givetrowel",
	Description = "Gives a trowel to a player",
	Group = "DefaultAdmin",
	Aliases = { "givetrowel", "givet" },
	Args = {
		{
			Type = "players",
			Name = "Players",
			Description = "The player(s) to give the trowel to"
		},
		{
			Type = "positiveInteger",
			Name = "Amount",
			Description = "The number of trowels to give (default 1)",
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