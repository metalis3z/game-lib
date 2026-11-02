--credit to leon games studio
return {
	Name = "shovelragdoll",
	Description = "Force the shovel-hit ragdoll A/B variant for this server. Run with no argument to clear the override (back to A/B test control).",
	Group = "DefaultAdmin",
	Aliases = { "shovelragdoll" },
	Args = {
		{
			Type = "boolean",
			Name = "Ragdoll",
			Description = "true = ragdoll knockback, false = current knockback. Omit to clear the override.",
			Optional = true
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