
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local DataService = require(ReplicatedStorage.Packages.DataService).server

local CoinSyncService = {}

local SYNC_INTERVAL = 3  

local playerSyncTimers = {}
local playerLastCoins  = {}

local function forceSync(player)
	local data = DataService._data[player]
	if not data then return end

	local coins = data:get("coins")
	if type(coins) ~= "number" then return end

	local last = playerLastCoins[player.UserId]
	if last ~= coins then
		playerLastCoins[player.UserId] = coins
		DataService:set(player, "coins", coins)
		print("[CoinSyncService] Re-synced coins for", player.Name, "->", coins)
	end
end

function CoinSyncService:init()
	Players.PlayerAdded:Connect(function(player)
		playerSyncTimers[player.UserId] = 0
		playerLastCoins[player.UserId]  = nil

		task.spawn(function()
			local data = DataService:waitForData(player)
			if not data then return end

			local coins = data:get("coins") or 0
			playerLastCoins[player.UserId] = coins
			print("[CoinSyncService] Cached initial coins for", player.Name, ":", coins)
		end)
	end)

	Players.PlayerRemoving:Connect(function(player)
		playerSyncTimers[player.UserId] = nil
		playerLastCoins[player.UserId]  = nil
	end)

	RunService.Heartbeat:Connect(function(dt)
		for _, player in ipairs(Players:GetPlayers()) do
			local uid = player.UserId
			playerSyncTimers[uid] = (playerSyncTimers[uid] or 0) + dt
			if playerSyncTimers[uid] >= SYNC_INTERVAL then
				playerSyncTimers[uid] = 0
				task.spawn(forceSync, player)
			end
		end
	end)

	print("[CoinSyncService] Initialized — safety-net sync every", SYNC_INTERVAL, "seconds")
end

function CoinSyncService:notifyCoinsChanged(_player, _newAmount)
end

return CoinSyncService