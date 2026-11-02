local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local ADMIN_USER_IDS = {
	7719529089,
}

local function isOwner(player: Player): boolean
	local ok, result = pcall(function()
		local info = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId)
		return info and info.Creator and info.Creator.Id == player.UserId
	end)
	return ok and result == true
end

local function isAdmin(player: Player): boolean
	for _, uid in ipairs(ADMIN_USER_IDS) do
		if player.UserId == uid then return true end
	end
	return isOwner(player)
end

local DataService = require(ReplicatedStorage.Packages.DataService).server
local InventoryServiceUtils = require(ReplicatedStorage.Source.Features.Inventory.InventoryServiceUtils)
local Slimes = require(ReplicatedStorage.Source.Game.Items.Slimes)

local _adminLuckService = nil
local function getAdminLuckService()
	if _adminLuckService then return _adminLuckService end
	local ok, svc = pcall(function()
		local SSS = game:GetService("ServerScriptService")
		local services = SSS:FindFirstChild("Services")
		local mod = services and services:FindFirstChild("AdminLuckService")
		return mod and require(mod)
	end)
	if ok and svc then _adminLuckService = svc end
	return _adminLuckService
end

local countdownState = nil
local remoteEvent = nil

local function broadcastCountdown()
	if not remoteEvent then return end
	remoteEvent:FireAllClients("countdownUpdated", countdownState)
end

local function fireCountdownToPlayer(player: Player)
	if not remoteEvent then return end
	remoteEvent:FireClient(player, "countdownUpdated", countdownState)
end

local function handleMiscAction(player: Player, action)
	if type(action) ~= "table" or type(action.kind) ~= "string" then
		return false, "Invalid action"
	end

	local kind = action.kind

	if kind == "setServerLuck" then
		local mult = tonumber(action.multiplier)
		if not mult or mult < 1 then
			return false, "Invalid multiplier"
		end
		local dur = (type(action.durationSeconds) == "number" and action.durationSeconds > 0)
			and action.durationSeconds or 900
		local als = getAdminLuckService()
		if not als then
			return false, "AdminLuckService not available"
		end
		als:setState(mult, dur, player.Name)
		return true, string.format("Server luck set to x%s for %d minutes.", mult, math.floor(dur / 60))

	elseif kind == "clearServerLuck" then
		local als = getAdminLuckService()
		if not als then return false, "AdminLuckService not available" end
		als:clearState()
		return true, "Server luck cleared."

		-- ── Admin Luck (same underlying system, different label in UI) ────────
	elseif kind == "setAdminLuck" then
		local mult = tonumber(action.multiplier)
		if not mult or mult < 1 then
			return false, "Invalid multiplier"
		end
		local dur = (type(action.durationSeconds) == "number" and action.durationSeconds > 0)
			and action.durationSeconds or 900
		local als = getAdminLuckService()
		if not als then return false, "AdminLuckService not available" end
		als:setState(mult, dur, player.Name)
		return true, string.format("Admin luck set to x%s for %d minutes.", mult, math.floor(dur / 60))

	elseif kind == "clearAdminLuck" then
		local als = getAdminLuckService()
		if not als then return false, "AdminLuckService not available" end
		als:clearState()
		return true, "Admin luck cleared."

	elseif kind == "startGlobalUpdateCountdown" then
		local title   = type(action.title)   == "string" and action.title   or "GLOBAL UPDATE"
		local message = type(action.message) == "string" and action.message or "An update is on the way."
		local dur = (type(action.durationSeconds) == "number" and action.durationSeconds > 0)
			and action.durationSeconds or 600
		local endsAt = math.floor(workspace:GetServerTimeNow()) + dur

		countdownState = {
			title   = title,
			message = message,
			endsAt  = endsAt,
		}
		broadcastCountdown()
		print(string.format(
			"[AdminService] Countdown started by %s | title: %s | ends in %ds",
			player.Name, title, dur
			))
		return true, string.format("Countdown started. Ends in %d minutes.", math.floor(dur / 60))

	elseif kind == "cancelGlobalUpdateCountdown" then
		countdownState = nil
		broadcastCountdown()
		print("[AdminService] Countdown cancelled by", player.Name)
		return true, "Countdown cancelled."

	elseif kind == "sendGlobalAnnouncement" then
		local message = type(action.message) == "string" and action.message or ""
		if message == "" then
			return false, "Message cannot be empty."
		end
		-- Broadcast to all clients
		if remoteEvent then
			remoteEvent:FireAllClients("globalAnnouncement", message)
		end
		print(string.format("[AdminService] Announcement sent by %s: %s", player.Name, message))
		return true, "Announcement sent to all players."

	elseif kind == "giveCoins" then
		local targetName = type(action.targetPlayer) == "string" and action.targetPlayer or ""
		local amount = tonumber(action.amount)
		if targetName == "" or not amount or amount <= 0 then
			return false, "Invalid player name or amount."
		end
		local targetPlayer = Players:FindFirstChild(targetName)
		if not targetPlayer then
			return false, "Player not found: " .. targetName
		end
		local data = DataService._data[targetPlayer]
		if not data then
			return false, "Player data not loaded."
		end
		local currentCoins = data:get("coins") or 0
		local newCoins = currentCoins + amount
		DataService:set(targetPlayer, "coins", newCoins)
		print(string.format("[AdminService] %s gave %d coins to %s (was %d, now %d)", player.Name, amount, targetName, currentCoins, newCoins))
		return true, string.format("Gave %d coins to %s. New total: %d", amount, targetName, newCoins)

	elseif kind == "setCoins" then
		local targetName = type(action.targetPlayer) == "string" and action.targetPlayer or ""
		local amount = tonumber(action.amount)
		if targetName == "" or not amount or amount < 0 then
			return false, "Invalid player name or amount."
		end
		local targetPlayer = Players:FindFirstChild(targetName)
		if not targetPlayer then
			return false, "Player not found: " .. targetName
		end
		local data = DataService._data[targetPlayer]
		if not data then
			return false, "Player data not loaded."
		end
		DataService:set(targetPlayer, "coins", amount)
		print(string.format("[AdminService] %s set %s's coins to %d", player.Name, targetName, amount))
		return true, string.format("Set %s's coins to %d.", targetName, amount)

	elseif kind == "globalSetCoins" then
		local amount = tonumber(action.amount)
		if not amount or amount < 0 then
			return false, "Invalid amount."
		end
		local count = 0
		for _, targetPlayer in ipairs(Players:GetPlayers()) do
			local data = DataService._data[targetPlayer]
			if data then
				DataService:set(targetPlayer, "coins", amount)
				count = count + 1
			end
		end
		print(string.format("[AdminService] %s set all players' coins to %d (%d players)", player.Name, amount, count))
		return true, string.format("Set coins to %d for %d players.", amount, count)

	elseif kind == "giveSlime" then
		local targetName = type(action.targetPlayer) == "string" and action.targetPlayer or ""
		local slimeId = type(action.slimeId) == "string" and action.slimeId or ""
		local level = tonumber(action.level) or 1
		if targetName == "" then
			return false, "Invalid player name."
		end
		if slimeId == "" then
			return false, "Invalid slime ID."
		end
		-- Validate slime exists
		local ok, slimeDef = pcall(Slimes.getSlime, slimeId)
		if not ok or not slimeDef then
			return false, "Unknown slime ID: " .. slimeId
		end
		local targetPlayer = Players:FindFirstChild(targetName)
		if not targetPlayer then
			return false, "Player not found: " .. targetName
		end
		local data = DataService._data[targetPlayer]
		if not data then
			return false, "Player data not loaded."
		end
		-- Create slime data
		local slimeData = {
			id = slimeId,
			level = math.max(1, math.floor(level)),
			xp = 0,
			mutations = {}
		}
		local uniqueKey = InventoryServiceUtils.genKey(slimeData)
		local inventory = data:get("inventory") or {}
		local newInventory = table.clone(inventory)
		newInventory[uniqueKey] = slimeData
		DataService:set(targetPlayer, "inventory", newInventory)
		print(string.format("[AdminService] %s gave slime %s (level %d) to %s", player.Name, slimeId, slimeData.level, targetName))
		return true, string.format("Gave %s (level %d) to %s.", slimeDef.name or slimeId, slimeData.level, targetName)

	elseif kind == "globalGiveSlime" then
		local slimeId = type(action.slimeId) == "string" and action.slimeId or ""
		local level = tonumber(action.level) or 1
		if slimeId == "" then
			return false, "Invalid slime ID."
		end
		-- Validate slime exists
		local ok, slimeDef = pcall(Slimes.getSlime, slimeId)
		if not ok or not slimeDef then
			return false, "Unknown slime ID: " .. slimeId
		end
		local count = 0
		for _, targetPlayer in ipairs(Players:GetPlayers()) do
			local data = DataService._data[targetPlayer]
			if data then
				local slimeData = {
					id = slimeId,
					level = math.max(1, math.floor(level)),
					xp = 0,
					mutations = {}
				}
				local uniqueKey = InventoryServiceUtils.genKey(slimeData)
				local inventory = data:get("inventory") or {}
				local newInventory = table.clone(inventory)
				newInventory[uniqueKey] = slimeData
				DataService:set(targetPlayer, "inventory", newInventory)
				count = count + 1
			end
		end
		print(string.format("[AdminService] %s gave slime %s (level %d) to all players (%d players)", player.Name, slimeId, level, count))
		return true, string.format("Gave %s (level %d) to %d players.", slimeDef.name or slimeId, level, count)

	else
		warn("[AdminService] Unknown action kind:", kind)
		return false, "Unknown action: " .. kind
	end
end

local AdminService = {}

function AdminService:init()
	local networker031 = ReplicatedStorage.Packages._Index["leifstout_networker@0.3.1"].networker
	local remotes = networker031:WaitForChild("_remotes", 10)
	if not remotes then
		warn("[AdminService] _remotes not found")
		return
	end

	local svcRemotes = remotes:WaitForChild("AdminService", 10)
	if not svcRemotes then
		warn("[AdminService] AdminService remotes not found")
		return
	end

	local rf = svcRemotes:FindFirstChild("RemoteFunction")
	if rf then
		rf.OnServerInvoke = function(player, method, ...)
			print("[AdminService] Invoked:", method, "| player:", player.Name)

			if method == "getClientState" then
				return {
					isAdmin       = isAdmin(player),
					countdownState = countdownState,
				}

			elseif method == "executeMiscAction" then
				if not isAdmin(player) then
					warn("[AdminService] Unauthorized executeMiscAction from", player.Name)
					return false, "You are not authorized to use admin tools."
				end
				local action = ...
				local ok, msg = handleMiscAction(player, action)
				return ok, msg
			end

			warn("[AdminService] Unknown method:", method)
			return false, "unknown"
		end
		print("[AdminService] OnServerInvoke set")
	else
		warn("[AdminService] RemoteFunction not found")
	end

	remoteEvent = svcRemotes:FindFirstChild("RemoteEvent")
	if not remoteEvent then
		warn("[AdminService] RemoteEvent not found — countdown broadcasts won't work")
	end

	Players.PlayerAdded:Connect(function(player)
		task.wait(2)
		fireCountdownToPlayer(player)
	end)

	task.spawn(function()
		while true do
			task.wait(5)
			if countdownState and type(countdownState.endsAt) == "number" then
				local now = math.floor(workspace:GetServerTimeNow())
				if now >= countdownState.endsAt then
					countdownState = nil
					broadcastCountdown()
					print("[AdminService] Countdown expired and cleared")
				end
			end
		end
	end)

	print("[AdminService] Initialized")
end

return AdminService