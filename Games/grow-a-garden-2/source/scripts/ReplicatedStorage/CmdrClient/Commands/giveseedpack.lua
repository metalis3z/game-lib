--credit to prince games studio
return {
	Name = "giveseedpack",
	Description = "Gives seed pack(s) to a player",
	Group = "DefaultAdmin",
	Aliases = { "giveseedpack" },
	Args = {
		{
			Type = "players",
			Name = "Players",
			Description = "The player(s) to give seed packs to"
		},
		{
			Type = "seedPackName",
			Name = "PackName",
			Description = "The name of the seed pack"
		},
		{
			Type = "positiveInteger",
			Name = "Amount",
			Description = "The number of seed packs to give (default 1)",
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