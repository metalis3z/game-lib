--credit to quartz games studio
return {
	Name = "givegnome",
	Description = "Gives gnome(s) to a player",
	Group = "DefaultAdmin",
	Aliases = { "givegnome" },
	Args = {
		{
			Type = "players",
			Name = "Players",
			Description = "The player(s) to give gnomes to"
		},
		{
			Type = "gnomeName",
			Name = "GnomeName",
			Description = "The name of the gnome"
		},
		{
			Type = "positiveInteger",
			Name = "Amount",
			Description = "The number of gnomes to give (default 1)",
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