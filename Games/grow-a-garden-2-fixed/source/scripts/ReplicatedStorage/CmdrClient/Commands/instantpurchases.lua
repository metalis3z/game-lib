--credit to leon games studio
return {
	Name = "instantpurchases",
	Description = "Toggle instant dev-product / gamepass purchases for this server. Turning ON requires the place to allow it in Environment.config.",
	Group = "DefaultAdmin",
	Aliases = { "instantpurchases" },
	Args = {
		{
			Type = "boolean",
			Name = "Enabled",
			Description = "true to enable instant purchases, false to disable"
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