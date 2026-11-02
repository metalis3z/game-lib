--credit to leon games studio
return {
	Name = "testofflinecutscene",
	Description = "Simulates the offline growth cutscene with max growth (no data mutation)",
	Group = "DefaultAdmin",
	Aliases = { "tocs" },
	Args = {
		{
			Type = "players",
			Name = "Players",
			Description = "The player(s) to test"
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