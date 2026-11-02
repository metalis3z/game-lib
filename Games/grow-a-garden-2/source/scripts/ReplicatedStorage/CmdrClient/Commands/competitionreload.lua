--credit to leon games studio
return {
	Name = "competitionreload",
	Description = "Reload guild-competition config from disk on the backend (rescans COMPETITIONS_DIR + bumps competitionsVersion so servers refetch). Pass a competition id to ALSO force an early finalize of that competition (test-only: streams its bracket rewards into the mail outbox; idempotent via the rewarded marker).",
	Group = "DefaultAdmin",
	Aliases = { "competitionreload", "creload", "competitionfinalize" },
	Args = {
		{
			Type = "string",
			Name = "Competition",
			Description = "Optional competition id to force-finalize (test). Omit to only reload config.",
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