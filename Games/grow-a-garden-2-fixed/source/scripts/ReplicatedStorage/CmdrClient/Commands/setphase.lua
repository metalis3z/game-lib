--credit to quartz games studio
return {
	Name = "setphase",
	Description = "Sets the server phase",
	Group = "DefaultAdmin",
	Aliases = { "setphase" },
	Args = {
		{
			Type = "phase",
			Name = "Phase",
			Description = "The Phase"
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