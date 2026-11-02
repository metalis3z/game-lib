local WinsMultiplierManager = {}

local MessagingService = game:GetService("MessagingService")
local DataStoreService = game:GetService("DataStoreService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local UpdateUI = Remotes:WaitForChild("UpdateUI")
local WinsEventUpdate = Remotes:WaitForChild("WinsEventUpdate")
local AdminAnnounce = Remotes:WaitForChild("AdminAnnounce")

local TOPIC = "WinsMultiplierUpdate"
local DATASTORE_KEY = "GlobalWinsMultiplierState"
local ds = DataStoreService:GetDataStore("GlobalWinsMultiplier")

local currentMultiplier = 1
local endTime = 0 -- os.time() when event expires, 0 if no event
local expiryTask = nil -- thread renvoyé par task.delay

local function notifyAllPlayers(multiplier)
	for _, player in ipairs(Players:GetPlayers()) do
		local ok, err = pcall(function()
			UpdateUI:FireClient(player, { BonusWinsMultiplier = multiplier })
		end)
		if not ok then
			warn("⚠️ Erreur UpdateUI pour " .. player.Name .. " : " .. tostring(err))
		end
	end

	local ok, err = pcall(function()
		WinsEventUpdate:FireAllClients({
			active = multiplier > 1,
			multiplier = multiplier,
			endTime = endTime,
		})
	end)
	if not ok then
		warn("⚠️ Erreur WinsEventUpdate : " .. tostring(err))
	end
end

local function cancelExpiryTask()
	-- task.delay renvoie un thread : on l'annule avec task.cancel(), pas :Cancel()
	if expiryTask then
		local ok = pcall(function()
			task.cancel(expiryTask)
		end)
		if not ok then
			warn("⚠️ Impossible d'annuler l'ancien expiryTask (déjà terminé ?)")
		end
		expiryTask = nil
	end
end

local function applyLocally(multiplier, newEndTime, announceData)
	cancelExpiryTask()

	currentMultiplier = multiplier
	endTime = newEndTime

	if endTime > 0 then
		local remaining = endTime - os.time()
		if remaining > 0 then
			expiryTask = task.delay(remaining, function()
				currentMultiplier = 1
				endTime = 0
				expiryTask = nil
				notifyAllPlayers(1)
				pcall(function()
					ds:RemoveAsync(DATASTORE_KEY)
				end)
			end)
		else
			-- Déjà expiré au moment de l'application
			currentMultiplier = 1
			endTime = 0
		end
	end

	notifyAllPlayers(currentMultiplier)

	if announceData then
		local ok, err = pcall(function()
			AdminAnnounce:FireAllClients(announceData)
		end)
		if not ok then
			warn("⚠️ Erreur AdminAnnounce : " .. tostring(err))
		end
	end
end

function WinsMultiplierManager.Get()
	return currentMultiplier
end

function WinsMultiplierManager.GetStatus()
	return {
		active = currentMultiplier > 1,
		multiplier = currentMultiplier,
		endTime = endTime,
	}
end

function WinsMultiplierManager.Set(multiplier, duration, announceData)
	local newEndTime = 0
	if duration and duration > 0 then
		newEndTime = os.time() + duration
	end

	applyLocally(multiplier, newEndTime, announceData)

	pcall(function()
		ds:SetAsync(DATASTORE_KEY, {
			multiplier = multiplier,
			endTime = newEndTime,
		})
	end)

	pcall(function()
		MessagingService:PublishAsync(TOPIC, {
			action = "set",
			multiplier = multiplier,
			endTime = newEndTime,
			announceData = announceData,
		})
	end)
end

function WinsMultiplierManager.Reset(announceData)
	applyLocally(1, 0, announceData)

	pcall(function()
		ds:RemoveAsync(DATASTORE_KEY)
	end)

	pcall(function()
		MessagingService:PublishAsync(TOPIC, {
			action = "reset",
			announceData = announceData,
		})
	end)
end

function WinsMultiplierManager.ResetLocal(announceData)
	applyLocally(1, 0, announceData)
end

-- ============================
-- SYNCHRONISATION CROSS-SERVEUR
-- ============================
local subscribeOk, subscribeErr = pcall(function()
	MessagingService:SubscribeAsync(TOPIC, function(message)
		local data = message.Data
		if type(data) ~= "table" then return end

		if data.action == "set" then
			applyLocally(data.multiplier, data.endTime, data.announceData)
		elseif data.action == "reset" then
			applyLocally(1, 0, data.announceData)
		end
	end)
end)
if not subscribeOk then
	warn("⚠️ Erreur SubscribeAsync WinsMultiplierUpdate : " .. tostring(subscribeErr))
end

-- ============================
-- CHARGEMENT INITIAL (serveur qui join en cours d'event)
-- ============================
task.spawn(function()
	local success, result = pcall(function()
		return ds:GetAsync(DATASTORE_KEY)
	end)
	if success and result then
		if result.endTime > os.time() then
			applyLocally(result.multiplier, result.endTime)
		else
			pcall(function()
				ds:RemoveAsync(DATASTORE_KEY)
			end)
		end
	elseif not success then
		warn("⚠️ Erreur chargement initial GlobalWinsMultiplierState : " .. tostring(result))
	end
end)

return WinsMultiplierManager