--Hi! , This Code Was Made by FaypleStudios , by owner @fayple1
--pls do not steal my code , good luck with using it
--pushserverluck script was obsusfucated bc this script is so op
--dm me to buy this command script [200-250 robux , if im in a good mood 100-150]

local module = function(Conch, Config)

	local Players = game:GetService("Players")
	local ServerScriptService = game:GetService("ServerScriptService")
	local ReplicatedStorage = game:GetService("ReplicatedStorage")
	local Workspace = game:GetService("Workspace")

	local PlotService = require(ServerScriptService.Services.PlotService)
	local NotificationService = require(ServerScriptService.Services.NotificationService)
	local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)

	Conch.register("unlockbase", {
		permissions = { Config.RequiredRole or "super-user" },

		arguments = function()
			return
				{
					kind = "argument",
					type = "player",
					name = "Player"
				},
			{
				kind = "argument",
				type = "number",
				name = "Floor"
			}
		end,
		callback = function(targetPlayer, floor)

			if typeof(targetPlayer) ~= "Instance" or not targetPlayer:IsA("Player") then
				return false, "Invalid player."
			end

			floor = tonumber(floor)
			if not floor or floor < 1 or floor > 3 then
				return false, "Floor must be 1, 2 or 3."
			end

			local targetPlot = PlotService.getPlot(targetPlayer)
			if not targetPlot then
				return false, "Target player's base not found."
			end

			local plotChannel = Synchronizer:Get(targetPlot.Name)
			if not plotChannel then
				return false, "Could not access target base channel."
			end

			local blockKey = "BlockEndTimeFirstFloor"
			if floor == 2 then
				blockKey = "BlockEndTimeSecondFloor"
			elseif floor == 3 then
				blockKey = "BlockEndTimeThirdFloor"
			end
			plotChannel:Set(blockKey, nil)
			plotChannel:Set("BlockedDelayTime", Workspace:GetServerTimeNow() + 10)

			if targetPlot:FindFirstChild("LaserHitbox") then
				for _, laser in ipairs(targetPlot.LaserHitbox:GetChildren()) do
					if laser:IsA("BasePart") and laser:GetAttribute("Floor") == floor then
						laser.CanCollide = false
					end
				end
			end

			if targetPlot:FindFirstChild("Laser") then
				for _, laser in ipairs(targetPlot.Laser:GetDescendants()) do
					if laser:IsA("BasePart") and laser:GetAttribute("Floor") == floor then
						laser.Transparency = 1
					end
				end
			end
			if targetPlot:FindFirstChild("Unlock") then
				for _, model in ipairs(targetPlot.Unlock:GetChildren()) do
					local main = model:FindFirstChild("Main")
					if main and main:FindFirstChild("UnlockBase") then
						if main.UnlockBase:GetAttribute("Floor") == floor then
							main.UnlockBase.Enabled = false
						end
					end
				end
			end

			NotificationService.Notify(
				targetPlayer,
				"Admin broke into your base!",
				5,
				"Sounds.Sfx.Unlock"
			)

			return "Unlocked floor " .. floor .. " in " .. targetPlayer.Name .. "'s base."
		end
	})

end

return module
