--credit to quartz games studio
return {
	Name = "debugdevproduct",
	Description = "Look up a developer product by name in the sync DataStore",
	Group = "DefaultAdmin",
	Aliases = { "debugdevproduct" },
	Args = {
		{
			Type = "string",
			Name = "ProductName",
			Description = "Product name to search for (partial match, case-insensitive)"
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