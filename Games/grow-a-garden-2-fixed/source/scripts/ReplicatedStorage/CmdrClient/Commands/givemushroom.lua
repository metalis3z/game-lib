--credit to leon games studio
return {
	Name = "givemushroom",
	Description = "Gives mushroom(s) to a player",
	Group = "DefaultAdmin",
	Aliases = { "givemushroom" },
	Args = {
		{
			Type = "players",
			Name = "Players",
			Description = "The player(s) to give mushrooms to"
		},
		{
			Type = "mushroomName",
			Name = "MushroomName",
			Description = "The name of the mushroom"
		},
		{
			Type = "positiveInteger",
			Name = "Amount",
			Description = "The number of mushrooms to give (default 1)",
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