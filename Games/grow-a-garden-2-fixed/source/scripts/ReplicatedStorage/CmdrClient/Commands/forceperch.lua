--credit to leon games studio
return {
	Name = "forceperch",
	Description = "Forces every bird pet currently just wandering the garden to immediately fly to a fence pole and perch. Birds eating, orbiting, hovering, already perching, or species that never perch are left alone.",
	Group = "DefaultAdmin",
	Aliases = { "forceperch" },
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