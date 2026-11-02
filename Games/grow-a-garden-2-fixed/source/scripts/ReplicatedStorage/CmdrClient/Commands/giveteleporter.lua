--credit to leon games studio
return {
	Name = "giveteleporter",
	Description = "Gives teleporter(s) to a player",
	Group = "DefaultAdmin",
	Aliases = { "giveteleporter" },
	Args = {
		{
			Type = "players",
			Name = "Players",
			Description = "The player(s) to give teleporters to"
		},
		{
			Type = "string",
			Name = "TeleporterName",
			Description = "The name of the teleporter (e.g. Teleporter)"
		},
		{
			Type = "positiveInteger",
			Name = "Amount",
			Description = "The number of teleporters to give (default 1)",
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