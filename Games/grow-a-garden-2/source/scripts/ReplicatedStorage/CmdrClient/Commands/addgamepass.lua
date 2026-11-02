--credit to leon games studio
return {
	Name = "addgamepass",
	Description = "Grants a gamepass to a player using the real purchase pipeline",
	Group = "DefaultAdmin",
	Aliases = { "addgamepass", "givegamepass" },
	Args = {
		{
			Type = "players",
			Name = "Players",
			Description = "The player(s) to grant the gamepass to"
		},
		{
			Type = "gamepassName",
			Name = "Gamepass",
			Description = "The gamepass display name"
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