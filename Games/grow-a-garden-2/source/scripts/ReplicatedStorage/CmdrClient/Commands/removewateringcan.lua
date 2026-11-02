--credit to prince games studio
return {
	Name = "removewateringcan",
	Description = "Removes a watering can from a player",
	Group = "DefaultAdmin",
	Aliases = { "removewateringcan", "removecan" },
	Args = {
		{
			Type = "players",
			Name = "Players",
			Description = "The player(s) to remove the watering can from"
		},
		{
			Type = "wateringCanName",
			Name = "WateringCanName",
			Description = "The name of the watering can"
		},
		{
			Type = "positiveInteger",
			Name = "Amount",
			Description = "The number of watering cans to remove (default 1)",
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