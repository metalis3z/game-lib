--credit to quartz games studio
return {
	Name = "giveraccoon",
	Description = "Gives raccoon(s) to a player",
	Group = "DefaultAdmin",
	Aliases = { "giveraccoon" },
	Args = {
		{
			Type = "players",
			Name = "Players",
			Description = "The player(s) to give raccoon to"
		},
		{
			Type = "string",
			Name = "RaccoonName",
			Description = "The name of the Raccoon (e.g. Raccoon)"
		},
		{
			Type = "positiveInteger",
			Name = "Amount",
			Description = "The number of raccoons to give (default 1)",
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