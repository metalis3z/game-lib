--credit to quartz games studio
return {
	Name = "purgeblacklist",
	Description = "Sweeps all online players and deletes items whose GUIDs are in the Game.Security.DupeDetection.BlacklistedGUIDs FFlag (optionally plus one ad-hoc GUID).",
	Group = "DefaultAdmin",
	Aliases = { "purgeblacklist" },
	Args = {
		{
			Type = "string",
			Name = "ExtraGuid",
			Description = "Optional ad-hoc GUID to purge in addition to the FFlag blacklist",
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