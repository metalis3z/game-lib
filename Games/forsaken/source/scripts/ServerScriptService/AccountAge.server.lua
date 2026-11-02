local Players = game:GetService("Players")

local MIN_ACCOUNT_AGE = 15

local function onPlayerAdded(player)
	if player.AccountAge < MIN_ACCOUNT_AGE then
		local kickMessage = "Your account must be at least " .. MIN_ACCOUNT_AGE .. " days old to play this game."
		player:Kick(kickMessage)
	end
end

Players.PlayerAdded:Connect(onPlayerAdded)