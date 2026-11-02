--credit to leon games studio
return {
	Name = "removegamepass",
	Description = "Removes a gamepass from a player and kicks them so they relog",
	Group = "DefaultAdmin",
	Aliases = { "removegamepass" },
	Args = {
		{
			Type = "players",
			Name = "Players",
			Description = "The player(s) to remove the gamepass from"
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