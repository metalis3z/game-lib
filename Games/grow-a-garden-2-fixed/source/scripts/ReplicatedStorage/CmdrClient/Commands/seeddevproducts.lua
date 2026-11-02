--credit to prince games studio
return {
	Name = "seeddevproducts",
	Description = "Seed the DevProductSync DataStore with known production developer product IDs",
	Group = "DefaultAdmin",
	Aliases = { "seeddevproducts" },
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