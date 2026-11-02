local module = function(Conch, Config)
	Conch.register("setrebirth", {
		permissions = { Config.RequiredRole or "super-user" },
		arguments = function()
			return {
				{
					kind = "argument",
					type = "string",
					name = "Player",
				},
				{
					kind = "argument",
					type = "number",
					name = "Rebirth",
				}
			}
		end,
		argumentChoices = function()
			local RebirthData = require(game:GetService("ReplicatedStorage").Datas.Rebirth)
			local choices = {}
			for level, _ in pairs(RebirthData) do
				table.insert(choices, tostring(level))
			end
			return {
				{
					name = "Rebirth",
					choices = choices,
				}
			}
		end,
		callback = function(playerName, rebirth)
			local Players = game:GetService("Players")
			local RebirthData = require(game:GetService("ReplicatedStorage").Datas.Rebirth)
			local BasesData = require(game:GetService("ReplicatedStorage").Datas.Bases)
			local Synchronizer = require(game:GetService("ReplicatedStorage").Packages.Synchronizer)
			local PlotService = require(game:GetService("ServerScriptService").Services.PlotService)
			local player
			for _, p in pairs(Players:GetPlayers()) do
				if p.Name:lower() == playerName:lower() then
					player = p
					break
				end
			end
			if not player then
				local userId
				local success, err = pcall(function()
					userId = Players:GetUserIdFromNameAsync(playerName)
				end)
				if not success or not userId then
					return false, "Failed to find player: " .. (err or "Invalid name or API error")
				end
				player = Players:GetPlayerByUserId(userId)
				if not player then
					return false, "Player not in server: " .. playerName
				end
			end
			if type(rebirth) ~= "number" or rebirth <= 0 then
				return false, "Rebirth must be a positive number"
			end
			if not RebirthData[rebirth] then
				return false, "Rebirth level does not exist"
			end
			local playerChannel = Synchronizer:Get(player)
			if not playerChannel then
				return false, "Failed to get player data"
			end
			local base = BasesData[rebirth].Model
			if not base then
				return false, "Base model for rebirth level not found"
			end
			local newPlotClone = base:Clone()
			if newPlotClone.PrimaryPart then
				newPlotClone.PrimaryPart.Anchored = true
			end
			local plotSuccess, plotErr = pcall(function()
				PlotService.replacePlot(player, newPlotClone)
			end)
			if not plotSuccess then
				return false, "Failed to replace plot: " .. (plotErr or "Unknown error")
			end
			playerChannel:Set("Rebirth", rebirth)
			return true, string.format("Set %s's rebirth to %d", playerName, rebirth)
		end,
	})
end

return module