--credit to leon games studio
return {
	Name = "helpsearch",
	Description = "Lists every command whose name, alias, group, or description contains the given string.",
	Group = "DefaultAdmin",
	Aliases = { "helpsearch", "findcmd", "searchcmd" },
	Args = {
		{
			Type = "string",
			Name = "Query",
			Description = "Substring to search for across all registered commands."
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