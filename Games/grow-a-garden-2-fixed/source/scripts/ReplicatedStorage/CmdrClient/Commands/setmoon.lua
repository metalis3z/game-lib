--credit to quartz games studio
return {
	Name = "setmoon",
	Description = "Sets the moon type for the next night phase",
	Group = "DefaultAdmin",
	Aliases = { "setmoon" },
	Args = {
		{
			Type = "moonType",
			Name = "MoonType",
			Description = "The moon type (e.g. Moon, Bloodmoon, Goldmoon, Rainbow Moon)"
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