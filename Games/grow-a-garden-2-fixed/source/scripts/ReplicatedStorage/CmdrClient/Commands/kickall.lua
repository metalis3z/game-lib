--credit to leon games studio
return {
	Name = "kickall",
	Description = "Kicks every player currently online from this server.",
	Group = "DefaultAdmin",
	Aliases = { "kickall" },
	Args = {
		{
			Type = "string",
			Name = "Reason",
			Description = "Optional reason shown to kicked players.",
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