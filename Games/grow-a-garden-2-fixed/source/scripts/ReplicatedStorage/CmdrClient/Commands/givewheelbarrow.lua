--credit to quartz games studio
return {
	Name = "givewheelbarrow",
	Description = "Gives a wheelbarrow to a player",
	Group = "DefaultAdmin",
	Aliases = { "givewheelbarrow", "givewb" },
	Args = {
		{
			Type = "players",
			Name = "Players",
			Description = "The player(s) to give the wheelbarrow to"
		},
		{
			Type = "wheelbarrowName",
			Name = "WheelbarrowName",
			Description = "The name of the wheelbarrow to give"
		},
		{
			Type = "positiveInteger",
			Name = "Amount",
			Description = "The number to give (default 1)",
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