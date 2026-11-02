--credit to quartz games studio
return {
	Name = "forceraccoonsteal",
	Description = "Forces equipped Raccoons to immediately attempt a steal run, skipping the random roll and per-pet cooldown. Normal steal rules still apply (night + an eligible empty garden with ripe fruit). Omit the player arg to force everyone\'s raccoons.",
	Group = "DefaultAdmin",
	Aliases = { "forceraccoonsteal" },
	Args = {
		{
			Type = "players",
			Name = "Players",
			Description = "The player(s) whose Raccoons should steal (default: everyone).",
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