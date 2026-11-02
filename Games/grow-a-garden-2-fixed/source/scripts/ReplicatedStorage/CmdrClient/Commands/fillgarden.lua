--credit to prince games studio
return {
	Name = "fillgarden",
	Description = "Clears the garden and fills it with random mature plants, then triggers the offline cutscene",
	Group = "DefaultAdmin",
	Aliases = { "fg" },
	Args = {
		{
			Type = "players",
			Name = "Players",
			Description = "The player(s) to fill",
			Default = "me"
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