--credit to leon games studio
return {
	Name = "givemaxpet",
	Description = "Increases the player\'s MaxEquippedPets cap (one extra pet slot per call by default).",
	Group = "DefaultAdmin",
	Aliases = { "givemaxpet", "givepetslot" },
	Args = {
		{
			Type = "players",
			Name = "Players",
			Description = "The player(s) to grant pet slots to"
		},
		{
			Type = "positiveInteger",
			Name = "Slots",
			Description = "How many extra pet slots to grant (default 1)",
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