--credit to leon games studio
return {
	Name = "globalnotify",
	Description = "GLOBAL: send a notification toast to EVERY player on EVERY live server. Quote multi-word messages, e.g. globalnotify \"Rainbow Moon incoming!\".",
	Group = "DefaultAdmin",
	Aliases = { "globalnotify" },
	Args = {
		{
			Type = "string",
			Name = "Message",
			Description = "The message to toast to everyone (quote multi-word messages)."
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