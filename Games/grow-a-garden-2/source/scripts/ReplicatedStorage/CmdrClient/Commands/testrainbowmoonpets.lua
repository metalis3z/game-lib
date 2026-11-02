--credit to prince games studio
return {
	Name = "testrainbowmoonpets",
	Description = "Bumps the chance that wild pets spawning during a Rainbow Moon roll the Rainbow PetType. Defaults to 50%. Pass false to reset to the normal 2%.",
	Group = "DefaultAdmin",
	Aliases = { "testrainbowmoonpets" },
	Args = {
		{
			Type = "boolean",
			Name = "Enabled",
			Description = "true (default) bumps the odds to 50%; false resets to the default 2%.",
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