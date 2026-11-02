--credit to prince games studio
return {
	Name = "guildforcetick",
	Description = "Trigger the gag2 tick job immediately (icon + guild slices).",
	Group = "DefaultAdmin",
	Aliases = { "guildforcetick", "gtick" },
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