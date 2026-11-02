local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MessagingService = game:GetService("MessagingService")
local Players = game:GetService("Players")
local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
local Net = require(ReplicatedStorage.Packages.Net)
local NotificationEvent = Net:RemoteEvent("NotificationService/Notify")

-- Function to skip fuse timer for all players on this server
local function skipFuseForAllPlayers()
	for _, player in ipairs(Players:GetPlayers()) do
		local success, err = pcall(function()
			local Data = Synchronizer:Get(player)
			if not Data then return end

			local FuseMachine = Data:Get("FuseMachine")
			if FuseMachine and FuseMachine.StartTime and FuseMachine.StartTime ~= 0 then
				-- Skip fuse timer by setting FinishTime to now
				Data:Set("FuseMachine.FinishTime", workspace:GetServerTimeNow())
				-- Optional: decrement InstantReveals if you want to mimic original logic
				Data:Set("FuseMachine.InstantReveals", math.max((FuseMachine.InstantReveals or 0) - 1, 0))
				for _, player in pairs(Players:GetPlayers()) do
					NotificationEvent:FireClient(
						player,
						string.format(
							"Sammy skipped your <font color='#855cc6'>fuse timer!</font>"
						),
						6,
						"Sounds.Sfx.Success"
					)
				end
			end
		end)
		if not success then
			warn("Failed to skip fuse for player", player.Name, err)
		end
	end
end

-- Listen for global broadcasts from other servers
MessagingService:SubscribeAsync("GlobalFuseReveal", function(message)
	local data = message.Data
	if data.FromServer == game.JobId then return end
	if data.Reveal then
		skipFuseForAllPlayers()
	end
end)

-- Cmdr-style function
return function(context)
	-- Skip fuse locally for all players
	skipFuseForAllPlayers()

	-- Broadcast to all other servers
	local success, err = pcall(function()
		MessagingService:PublishAsync("GlobalFuseReveal", {
			FromServer = game.JobId,
			Executor = context.Executor and context.Executor.Name or "Unknown",
			Reveal = true
		})
	end)

	if not success then
		warn("Failed to broadcast global fuse reveal:", err)
		return "⚠️ Fuse skipped locally but failed to broadcast globally: " .. tostring(err)
	end

	return "✅ Fuse skipped for all players on all servers!"
end
