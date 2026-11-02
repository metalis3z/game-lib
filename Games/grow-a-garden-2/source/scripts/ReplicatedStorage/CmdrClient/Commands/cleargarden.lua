--credit to leon games studio
return {
	Name = "cleargarden",
	Description = "Clears all plants, sprinklers, gnomes, raccoons, and props from a player\'s garden",
	Group = "DefaultAdmin",
	Aliases = { "cg", "wipegarden" },
	Args = {
		{
			Type = "players",
			Name = "Players",
			Description = "The player(s) to clear garden for"
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