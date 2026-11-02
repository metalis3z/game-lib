--script made by Willy
local StealService = require(game.ServerScriptService.Services.StealService)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
local NotificationService = require(game.ServerScriptService.Services.NotificationService)

local module = function(Conch, Config)
	Conch.register("stealprotection", {
		permissions = { Config.RequiredRole or "super-user" },

		arguments = function()
			return
				{
					kind = "argument",
					type = "player",
					name = "player",
				},
			{
				kind = "argument",
				type = "string",
				name = "On/Off",
				description = "On or Off?",
			}
		end,

		callback = function(player, state)
			if not player then
				return "Player not found"
			end

			if state == "On" or state == "on" then
				player:SetAttribute("StealProtection", true)
				return "Steal Protection enabled"
			elseif state == "Off" or state == "off" then
				player:SetAttribute("StealProtection", false)
				return "Steal Protection disabled"
			else
				return "Use On or Off only"
			end
		end,
	})

	local OriginalStartSteal = StealService.StartSteal
	StealService.StartSteal = function(self, player, victimPlotUID, podiumIndex)
		local victimPlotChannel = Synchronizer:Get(victimPlotUID)

		if victimPlotChannel then
			local victimPlayer = victimPlotChannel:Get("Owner")

			if victimPlayer and victimPlayer:GetAttribute("StealProtection") == true then
				task.defer(function()
					NotificationService.Error(player, "You can't steal from this user!")
				end)

				task.defer(function()
					if StealService.CancelHold then
						StealService:CancelHold(player, podiumIndex)
					end
				end)

				return OriginalStartSteal(self, player, victimPlotUID, podiumIndex)
			end
		end

		return OriginalStartSteal(self, player, victimPlotUID, podiumIndex)
	end
end

return module