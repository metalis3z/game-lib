--credit to prince games studio
return {
	Name = "giveunicorn",
	Description = "Adds Unicorn follower pet(s) to a player\'s Pets data",
	Group = "DefaultAdmin",
	Aliases = { "giveunicorn" },
	Args = {
		{
			Type = "players",
			Name = "Players",
			Description = "The player(s) to give the unicorn to"
		},
		{
			Type = "positiveInteger",
			Name = "Amount",
			Description = "The number of unicorns to give (default 1)",
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