--credit to leon games studio
return {
	Name = "listdevproducts",
	Description = "Print the contents of the DevProductSync DataStore",
	Group = "DefaultAdmin",
	Aliases = { "listdevproducts" },
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