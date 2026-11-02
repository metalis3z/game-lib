--!strict
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local DataService = require(game:GetService("ServerScriptService").DataService)
local AssetItems = require(ReplicatedStorage.Shared.Util.AssetItems)

local EarningService = {}

local tick_interval = 1

function EarningService.Init()
end

function EarningService.Start()
	task.spawn(function()
		while true do
			task.wait(tick_interval)
			for _, player in Players:GetPlayers() do
				if player.Parent then
					local profile = DataService.Get(player)
					if profile and type(profile.EquippedAssets) == "table" and #profile.EquippedAssets > 0 then
						local ok, income = pcall(function()
							return AssetItems.ProfileIncomePerSecond(player, profile)
						end)
						if ok and type(income) == "number" and income > 0 then
							DataService.AddMoney(player, income)
						end
					end
				end
			end
		end
	end)
end

return EarningService