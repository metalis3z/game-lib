--credit to quartz games studio
return {
	Name = "clearinventory",
	Description = "Clears all items from a player\'s inventory (seeds, tools, fruits, crates, etc.)",
	Group = "DefaultAdmin",
	Aliases = { "clearinv", "wipeinventory", "wipeinv" },
	Args = {
		{
			Type = "players",
			Name = "Players",
			Description = "The player(s) to clear inventory for"
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