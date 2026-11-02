--credit to leon games studio
return {
	Name = "mailrandom",
	Description = "Send a fabricated mailbox gift from a randomly selected sender to the target player. Useful for visually validating mailbox UI without setting up a real Send/Claim flow. Bypasses sender-inventory debit and SEND_COOLDOWN.",
	Group = "DefaultAdmin",
	Aliases = { "mailrandom", "randmail" },
	Args = {
		{
			Type = "player",
			Name = "Player",
			Description = "Target player to receive the random mail."
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