--credit to prince games studio
return {
	Name = "givewateringcan",
	Description = "Gives a watering can to a player",
	Group = "DefaultAdmin",
	Aliases = { "givewateringcan", "givecan" },
	Args = {
		{
			Type = "players",
			Name = "Players",
			Description = "The player(s) to give the watering can to"
		},
		{
			Type = "wateringCanName",
			Name = "WateringCanName",
			Description = "The name of the watering can"
		},
		{
			Type = "positiveInteger",
			Name = "Amount",
			Description = "The number of watering cans to give (default 1)",
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