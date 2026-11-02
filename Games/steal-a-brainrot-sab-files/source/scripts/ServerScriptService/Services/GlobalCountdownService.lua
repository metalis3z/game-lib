local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MemoryStoreService = game:GetService("MemoryStoreService")
local ServerScriptService = game:GetService("ServerScriptService")
local TextService = game:GetService("TextService")
local Players = game:GetService("Players")
local Net = require(ReplicatedStorage.Packages.Net)

local MessagingService = require(ServerScriptService.Services.MessagingService)

local globalcountdownservice = {}

local countdownMap = MemoryStoreService:GetSortedMap("GlobalCountdown")
local GLOBAL_KEY = "CurrentCountdown"

local COUNTDOWN_TOPIC = "GlobalCountdown"
local WHITELISTED_USER_IDS = { [9834833917,4515418871] = true }

local countdownSettings = {
	timestamp = 0,
	title = "LOADING...",
	color = "#ffffff",
	isGlobal = false,
	creatorId = 0
}

local lastSyncTime = 0
local SYNC_INTERVAL = 120
local lastMemoryStoreWrite = 0
local WRITE_COOLDOWN = 3

local countdownRemote = Net:RemoteFunction("UpdateCountdown")
local onUpdateEvent = Net:RemoteEvent("OnUpdate")


local function filterText(text, fromUserId)
	if WHITELISTED_USER_IDS[fromUserId] then return text end
	local success, result = pcall(function()
		local filterResult = TextService:FilterStringAsync(text, fromUserId)
		return filterResult:GetNonChatStringForBroadcastAsync()
	end)
	return success and result or "###"
end

local function broadcast()
	onUpdateEvent:FireAllClients(countdownSettings)
end

local function saveToMemoryStore()
	local now = os.time()
	if now - lastMemoryStoreWrite < WRITE_COOLDOWN then
		return
	end
	local success = pcall(function()
		countdownMap:SetAsync(GLOBAL_KEY, countdownSettings, 86400)
	end)
	if success then
		lastMemoryStoreWrite = now
	else
		warn("[GlobalCountdown] Failed to write to MemoryStore")
	end
end

local function publishUpdate()
	pcall(function()
		MessagingService:PublishAsync(COUNTDOWN_TOPIC, {
			timestamp = countdownSettings.timestamp,
			title = countdownSettings.title,
			color = countdownSettings.color,
			isGlobal = countdownSettings.isGlobal,
			creatorId = countdownSettings.creatorId
		})
	end)
end


function globalcountdownservice.UpdateEvent(newTimestamp, newTitle, newColor, isGlobal, creatorId)
	local authorId = creatorId or 0
	if WHITELISTED_USER_IDS[countdownSettings.creatorId] and not WHITELISTED_USER_IDS[authorId] then
		if os.time() < countdownSettings.timestamp then
			return false, "A priority countdown is currently active."
		end
	end

	local finalTimestamp = newTimestamp or 0
	if finalTimestamp > 0 and finalTimestamp < 10^9 then
		finalTimestamp = os.time() + finalTimestamp
	end

	countdownSettings.timestamp = finalTimestamp
	countdownSettings.title = filterText(newTitle or countdownSettings.title, authorId)
	countdownSettings.color = newColor or countdownSettings.color
	countdownSettings.isGlobal = isGlobal or false
	countdownSettings.creatorId = authorId

	if countdownSettings.isGlobal then
		saveToMemoryStore()
		publishUpdate()
	end

	broadcast()
	return true, "Updated!"
end

function globalcountdownservice.StopCountdown(requestorId)
	if WHITELISTED_USER_IDS[countdownSettings.creatorId] and not WHITELISTED_USER_IDS[requestorId] then
		if os.time() < countdownSettings.timestamp then
			return false, "Cannot stop a priority countdown."
		end
	end

	local wasGlobal = countdownSettings.isGlobal
	if countdownSettings.isGlobal then
		pcall(function()
			countdownMap:RemoveAsync(GLOBAL_KEY)
		end)
	end

	countdownSettings.isGlobal = false
	countdownSettings.timestamp = 0
	countdownSettings.title = "FINISHED"
	countdownSettings.creatorId = 0

	if wasGlobal then
		publishUpdate()
	end

	broadcast()
	return true
end

function globalcountdownservice.StopAllTimers(requestorId)
	local memSuccess, memErr = pcall(function()
		countdownMap:RemoveAsync(GLOBAL_KEY)
	end)
	if not memSuccess then
		warn("[GlobalCountdown] StopAllTimers: MemoryStore remove failed —", memErr)
	end

	countdownSettings = {
		timestamp  = 0,
		title      = "FINISHED",
		color      = "#ffffff",
		isGlobal   = false,
		creatorId  = 0,
	}
	lastMemoryStoreWrite = 0
	publishUpdate()
	broadcast()

	local who = requestorId or 0
	print(string.format("[GlobalCountdown] StopAllTimers called by UserId %d", who))
	return true, "All timers have been forcefully stopped."
end


local function onCountdownMessage(payload)
	if type(payload) ~= "table" then return end

	if type(payload.timestamp) ~= "number" then return end
	if type(payload.title) ~= "string" then return end
	if type(payload.color) ~= "string" then return end
	if type(payload.creatorId) ~= "number" then return end

	if WHITELISTED_USER_IDS[countdownSettings.creatorId] and not WHITELISTED_USER_IDS[payload.creatorId] then
		if os.time() < countdownSettings.timestamp then
			return
		end
	end

	if payload.timestamp == countdownSettings.timestamp 
		and payload.title == countdownSettings.title
		and payload.creatorId == countdownSettings.creatorId then
		return
	end

	countdownSettings.timestamp = payload.timestamp
	countdownSettings.title = payload.title
	countdownSettings.color = payload.color
	countdownSettings.isGlobal = payload.isGlobal or false
	countdownSettings.creatorId = payload.creatorId

	broadcast()
	print("[GlobalCountdown] ⚡ Received instant update from MessagingService")
end

function globalcountdownservice:Start()
	countdownRemote.OnServerInvoke = function(player, action, data)
		if action == "Get" then
			return countdownSettings
		end
		if action == "Update" and data then
			local isExpired = os.time() >= countdownSettings.timestamp
			if not data.isGlobal and countdownSettings.isGlobal and not isExpired then
				return false, "Global countdown is currently active."
			end
			return globalcountdownservice.UpdateEvent(
				data.timestamp,
				data.title,
				data.color,
				data.isGlobal,
				player.UserId
			)
		end
		if action == "Stop" then
			return globalcountdownservice.StopCountdown(player.UserId)
		end
	end

	task.spawn(function()
		pcall(function()
			MessagingService:SubscribeAsync(COUNTDOWN_TOPIC, onCountdownMessage)
		end)
	end)

	task.spawn(function()
		task.wait(2)
		while true do
			local now = os.time()

			if countdownSettings.timestamp > 0 and now > (countdownSettings.timestamp + 2) then
				if countdownSettings.isGlobal then
					globalcountdownservice.StopCountdown(0)
				else
					countdownSettings.timestamp = 0
					countdownSettings.title     = "FINISHED"
					countdownSettings.creatorId = 0
					broadcast()
				end
			end

			if now - lastSyncTime >= SYNC_INTERVAL then
				lastSyncTime = now
				local success, remoteData = pcall(function()
					return countdownMap:GetAsync(GLOBAL_KEY)
				end)
				if success then
					if remoteData then
						if  remoteData.timestamp  ~= countdownSettings.timestamp
							or  remoteData.creatorId  ~= countdownSettings.creatorId
							or  remoteData.title      ~= countdownSettings.title     then
							countdownSettings = remoteData
							broadcast()
							print("[GlobalCountdown] Reconciled from MemoryStore")
						end
					elseif countdownSettings.isGlobal then
						globalcountdownservice.StopCountdown(0)
					end
				else
					warn("[GlobalCountdown] Sync failed, will retry")
				end
			end
			task.wait(1)
		end
	end)

	Players.PlayerAdded:Connect(function(player)
		onUpdateEvent:FireClient(player, countdownSettings)
	end)

	for _, player in ipairs(Players:GetPlayers()) do
		onUpdateEvent:FireClient(player, countdownSettings)
	end
end

return globalcountdownservice