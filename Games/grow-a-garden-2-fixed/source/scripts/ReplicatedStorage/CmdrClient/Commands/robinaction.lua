--credit to quartz games studio
return {
	Name = "robinaction",
	Description = "Forces every Robin pet currently just wandering the garden to immediately perform a chosen action (perch, eat, circle, or dropseed) for testing. Robins mid-action and other species are left alone.",
	Group = "DefaultAdmin",
	Aliases = { "robinaction" },
	Args = {
		{
			Type = "robinAction",
			Name = "Action",
			Description = "What the wandering Robins should do: perch, eat, circle, or dropseed."
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