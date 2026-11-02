local module = function(Conch, Config)
	Conch.register("setrebirth", {
		permissions = { Config.RequiredRole or "limited-commands" },

		arguments = function()
			return
				{
					kind = "argument",
					type = "player",
					name = "Player",
				},
			{
				kind = "argument",
				type = "number",
				name = "Rebirth",
			}
		end,

		callback = function(targetPlayer, amount)
			if not targetPlayer then
				return ""
			end

			amount = tonumber(amount)
			if not amount or amount < 0 then
				return ""
			end

			local ReplicatedStorage = game:GetService("ReplicatedStorage")
			local ServerScriptService = game:GetService("ServerScriptService")

			local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
			local PlotService = require(ServerScriptService.Services.PlotService)
			local MoneyService = require(ServerScriptService.Services.MoneyService)
			local RebirthData = require(ReplicatedStorage.Datas.Rebirth)
			local BasesData = require(ReplicatedStorage.Datas.Bases)
			local DefaultStats = require(ServerScriptService.Components.DefaultStats)

			local rebirthInfo = RebirthData[amount]
			if not rebirthInfo then
				return ""
			end

			local playerChannel
			for i = 1, 20 do
				playerChannel = Synchronizer:Get(targetPlayer)
				if playerChannel then break end
				task.wait()
			end
			if not playerChannel then
				return ""
			end

			playerChannel:Set("Rebirth", amount)

			if amount == 0 then
				MoneyService:Set(targetPlayer, 100)

				local animalPodiums = {}
				for i = 1, 10 do
					animalPodiums[i] = "Empty"
				end
				playerChannel:Set("AnimalPodiums", animalPodiums)
			else
				if rebirthInfo.Rewards and rebirthInfo.Rewards.Cash then
					MoneyService:Set(targetPlayer, rebirthInfo.Rewards.Cash)
				end

				if rebirthInfo.Rewards and rebirthInfo.Rewards.AnimalSlot then
					local currentAnimalPodiums =
						playerChannel:Get("AnimalPodiums") or DefaultStats.AnimalPodiums

					local currentSlots = 0
					for i = 1, 100 do
						if currentAnimalPodiums[i] ~= nil then
							currentSlots = i
						else
							break
						end
					end

					for i = 1, rebirthInfo.Rewards.AnimalSlot do
						currentAnimalPodiums[currentSlots + i] = "Empty"
					end

					playerChannel:Set("AnimalPodiums", currentAnimalPodiums)
				end
			end

			local baseInfo = BasesData[amount]
			if baseInfo and baseInfo.Model then
				local newPlot = baseInfo.Model:Clone()
				if newPlot.PrimaryPart then
					newPlot.PrimaryPart.Anchored = true
				end
				pcall(function()
					PlotService.replacePlot(targetPlayer, newPlot)
				end)
			end

			return "set"
		end,
	})
end

return module