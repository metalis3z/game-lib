--credit to prince games studio
return {
	Name = "competitionstatus",
	Description = "List the active (running + upcoming) guild competitions from the backend: id, phase, score multipliers, window, and the current competitionsVersion. Companion to /competitionsetscore and /competitionreload.",
	Group = "DefaultAdmin",
	Aliases = { "competitionstatus", "competitionlist", "cstatus" },
	Args = {}
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