local module = function(Conch, Config)
	Conch.register("resetalldata", {
		permissions = { Config.RequiredRole or "CustomAdmin" },

		description = "Reset ALL player data (online + offline) and clear leaderboards",

		arguments = function()
			return {}
		end,

		callback = function()
			local DataStoreService = game:GetService("DataStoreService")
			local Players = game:GetService("Players")
			local ServerScriptService = game:GetService("ServerScriptService")
			local ReplicatedStorage = game:GetService("ReplicatedStorage")

			local DataStore = DataStoreService:GetDataStore("DATA-FOR-EVERYONE")
			local DefaultStats = require(ServerScriptService.Components.DefaultStats)
			local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)

			local function DeepCopy(tbl)
				local new = {}
				for k, v in pairs(tbl) do
					if type(v) == "table" then
						new[k] = DeepCopy(v)
					else
						new[k] = v
					end
				end
				return new
			end

			-- 1. Reset joueurs online (Synchronizer = leaderstats MAJ en temps réel)
			local onlineCount = 0
			for _, player in ipairs(Players:GetPlayers()) do
				local channel = Synchronizer:Get(player)
				if channel then
					local newData = DeepCopy(DefaultStats)
					for key, value in pairs(newData) do
						channel:Set(key, value)
					end
					onlineCount += 1
				end
			end

			-- 2. Reset le DataStore pour les joueurs offline (ListKeysAsync)
			local allKeys = {}
			pcall(function()
				local cursor = nil
				repeat
					local page = DataStore:ListKeysAsync(cursor, 100)
					for _, keyInfo in ipairs(page:GetKeys()) do
						table.insert(allKeys, keyInfo.KeyName)
					end
					cursor = page.IsFinished and nil or page:GetNextCursor()
				until not cursor
			end)

			local offlineCount = 0
			for _, keyName in ipairs(allKeys) do
				local userId = tonumber(keyName)
				if userId then
					local isOnline = Players:GetPlayerByUserId(userId) ~= nil
					if not isOnline then
						local newData = DeepCopy(DefaultStats)
						pcall(function()
							DataStore:SetAsync(userId, newData)
						end)
						offlineCount += 1
					end
				end
			end

			-- 3. Vider les OrderedDataStores (leaderboards)
			local function ClearOrderedStore(storeName)
				pcall(function()
					local store = DataStoreService:GetOrderedDataStore(storeName)
					local pages = store:GetSortedAsync(false, 100)
					while true do
						local entries = pages:GetCurrentPage()
						if #entries == 0 then break end
						for _, entry in ipairs(entries) do
							local uid = tonumber(entry.key)
							if uid then
								pcall(function() store:RemoveAsync(uid) end)
							end
						end
						if pages.IsFinished then break end
							pages:AdvanceToNextPageAsync()
					end
				end)
				end

			ClearOrderedStore("GenerationLeaazeederboard_2")
			ClearOrderedStore("StealsLeaazeederboard_2")

			-- 4. Force refresh leaderboard
			local LeaderboardService = require(ServerScriptService.Services.LeaderboardService)
			LeaderboardService:ForceRefresh()

			return string.format("✅ Reset terminé! %d online reset (temps réel), %d offline reset (DataStore), leaderboards vidés", onlineCount, offlineCount)
		end
	})

	Conch.register("resetalldataall", {
		alias = "resetalldata"
	})
	Conch.register("wipeall", {
		alias = "resetalldata"
	})
end
return module