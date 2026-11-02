--credit to prince games studio
return {
	Name = "progresstime",
	Description = "Advances plant lifecycle by the specified number of seconds for player(s)",
	Group = "DefaultAdmin",
	Aliases = { "progresstime" },
	Args = {
		{
			Type = "players",
			Name = "Players",
			Description = "The player(s) to progress time for"
		},
		{
			Type = "number",
			Name = "Seconds",
			Description = "Number of seconds to advance the plant lifecycle"
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