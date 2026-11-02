--credit to prince games studio
return {
	Name = "givevinewrapper",
	Description = "Grants the Vine Wrapper equippable gear to a player",
	Group = "DefaultAdmin",
	Aliases = { "givevinewrapper", "givevw" },
	Args = {
		{
			Type = "players",
			Name = "Players",
			Description = "The player(s) to give the Vine Wrapper to"
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