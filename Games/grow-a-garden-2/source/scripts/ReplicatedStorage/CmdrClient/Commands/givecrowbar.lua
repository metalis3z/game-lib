--credit to prince games studio
return {
	Name = "givecrowbar",
	Description = "Gives a crowbar to a player",
	Group = "DefaultAdmin",
	Aliases = { "givecrowbar", "givet" },
	Args = {
		{
			Type = "players",
			Name = "Players",
			Description = "The player(s) to give the crowbar to"
		},
		{
			Type = "positiveInteger",
			Name = "Amount",
			Description = "The number of crowbars to give (default 1)",
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