--credit to quartz games studio
return {
	Name = "playcutscene",
	Description = "Plays a cutscene",
	Group = "DefaultAdmin",
	Aliases = { "playcutscene" },
	Args = {
		{
			Type = "players",
			Name = "Players",
			Description = "The player(s) to play for"
		},
		{
			Type = "cutscene",
			Name = "Cutscene",
			Description = "The Cutscene"
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