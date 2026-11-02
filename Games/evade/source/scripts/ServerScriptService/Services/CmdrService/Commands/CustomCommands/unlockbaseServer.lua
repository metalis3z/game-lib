local Players = game:GetService("Players")
local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

local PlotService = require(ServerScriptService.Services.PlotService)
local NotificationService = require(ServerScriptService.Services.NotificationService)
local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)

return function(context, targetPlayer, floor)
	-- Validate player
	if typeof(targetPlayer) ~= "Instance" or not targetPlayer:IsA("Player") then
		return "❌ Invalid player."
	end

	-- Validate floor
	floor = tonumber(floor)
	if not floor or floor < 1 or floor > 3 then
		return "❌ Invalid floor number. Must be 1, 2, or 3."
	end

	local targetPlot = PlotService.getPlot(targetPlayer)
	if not targetPlot then
		return "❌ Target player's base not found."
	end

	local targetPlotChannel = Synchronizer:Get(targetPlot.Name)
	if not targetPlotChannel then
		return "❌ Could not access target base channel."
	end

	-- Determine block key
	local blockTimeKey = "BlockEndTimeFirstFloor"
	if floor == 2 then blockTimeKey = "BlockEndTimeSecondFloor"
	elseif floor == 3 then blockTimeKey = "BlockEndTimeThirdFloor" end

	-- Temporarily unblock
	targetPlotChannel:Set(blockTimeKey, nil)
	targetPlotChannel:Set("BlockedDelayTime", Workspace:GetServerTimeNow() + 10)

	-- Disable lasers
	if targetPlot:FindFirstChild("LaserHitbox") then
		for _, laser in pairs(targetPlot.LaserHitbox:GetChildren()) do
			if laser:GetAttribute("Floor") == floor and laser:IsA("BasePart") then
				laser.CanCollide = false
			end
		end
	end

	if targetPlot:FindFirstChild("Laser") then
		for _, laser in pairs(targetPlot.Laser:GetDescendants()) do
			if laser:GetAttribute("Floor") == floor and laser:IsA("BasePart") then
				laser.Transparency = 1
			end
		end
	end

	-- Disable unlock base visuals
	if targetPlot:FindFirstChild("Unlock") then
		for _, unlockModel in pairs(targetPlot.Unlock:GetChildren()) do
			local unlockBase = unlockModel:FindFirstChild("Main")
			if unlockBase and unlockBase:FindFirstChild("UnlockBase") then
				if unlockBase.UnlockBase:GetAttribute("Floor") == floor then
					unlockBase.UnlockBase.Enabled = false
				end
			end
		end
	end

	-- Notifications
	NotificationService.Notify(targetPlayer, string.format("%s broke into your base!", context.Executor.Name), 5, "Sounds.Sfx.Unlock")
	NotificationService.Success(context.Executor, string.format("You successfully broke into %s's base!", targetPlayer.DisplayName))

	-- Reset BlockedDelayTime after 10 seconds
	task.delay(10, function()
		if targetPlotChannel and getmetatable(targetPlotChannel) then
			targetPlotChannel:Set("BlockedDelayTime", nil)
		end
	end)

	return "✅ Successfully force-unlocked floor " .. floor .. " in " .. targetPlayer.Name .. "'s base!"
end
