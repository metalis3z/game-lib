--credit to leon games studio
return {
	Name = "monkeygrabmult",
	Description = "Multiplies the server-wide Monkey grab-fruit chance for everyone. Pass 1 to reset.",
	Group = "DefaultAdmin",
	Aliases = { "monkeygrabmult" },
	Args = {
		{
			Type = "number",
			Name = "Multiplier",
			Description = "How much more often Monkeys grab a ripe fruit (default 50, use 1 to reset).",
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