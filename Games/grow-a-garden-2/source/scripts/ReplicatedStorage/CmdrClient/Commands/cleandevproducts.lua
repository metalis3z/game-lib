--credit to prince games studio
return {
	Name = "cleandevproducts",
	Description = "Rename old-format dev products (x1) to [OLD] prefix so they don\'t conflict with (x1) format",
	Group = "DefaultAdmin",
	Aliases = { "cleandevproducts" },
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