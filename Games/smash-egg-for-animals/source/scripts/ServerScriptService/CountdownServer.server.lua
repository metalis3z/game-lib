-- CountdownServer : compte a rebours GLOBAL (GUI "Countdown"), commande admin UpdateTimer
-- La fin est un horodatage absolu (os.time) sauvegarde dans un DataStore : le compte a rebours continue
-- meme si les joueurs quittent le jeu, et il est le meme dans tous les serveurs.
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local DataStoreService = game:GetService("DataStoreService")
local MessagingService = require(game:GetService("ServerScriptService"):WaitForChild("GlobalBus")) -- (un seul abonnement pour tout le jeu : voir GlobalBus)

local AdminConfig = require(ReplicatedStorage:WaitForChild("AdminConfig"))
local updateRemote = ReplicatedStorage:WaitForChild("AdminSystem"):WaitForChild("Remotes"):WaitForChild("UpdateTimer")
local notifyRemote = ReplicatedStorage:WaitForChild("EggSystem"):WaitForChild("Remotes"):WaitForChild("Notify")

local STORE_NAME = "Countdown_v1"
local KEY = "State"
local TOPIC = "AdminCountdown"
local MAX_SECONDS = 30 * 24 * 3600 -- 30 jours maximum

local store
pcall(function() store = DataStoreService:GetDataStore(STORE_NAME) end)

local lastChange = 0
local localUntil = 0 -- compte à rebours lancé pour CE serveur seulement

local function applyState(endTime, label)
	if type(endTime) == "number" and endTime > os.time() then
		ReplicatedStorage:SetAttribute("CountdownLabel", label or "")
		ReplicatedStorage:SetAttribute("CountdownEnd", endTime)
	else
		ReplicatedStorage:SetAttribute("CountdownEnd", nil)
		ReplicatedStorage:SetAttribute("CountdownLabel", nil)
	end
end

local function loadState()
	if not store then return end
	local ok, data = pcall(function() return store:GetAsync(KEY) end)
	if not ok then return end
	if type(data) == "table" and type(data.endTime) == "number" then
		applyState(data.endTime, data.label)
	else
		applyState(nil)
	end
end

local function describe(secs)
	local d = math.floor(secs / 86400)
	local h = math.floor(secs % 86400 / 3600)
	local m = math.floor(secs % 3600 / 60)
	local s = secs % 60
	local parts = {}
	if d > 0 then table.insert(parts, d .. "j") end
	if h > 0 then table.insert(parts, h .. "h") end
	if m > 0 then table.insert(parts, m .. "min") end
	if s > 0 or #parts == 0 then table.insert(parts, s .. "s") end
	return table.concat(parts, " ")
end

-- au demarrage du serveur : on reprend le compte a rebours en cours
task.spawn(loadState)

-- les autres serveurs sont prevenus par message
pcall(function()
	MessagingService:SubscribeAsync(TOPIC, function(message)
		local data = message.Data
		if type(data) ~= "table" or type(data.endTime) ~= "number" then return end
		lastChange = os.clock()
		applyState(data.endTime > 0 and data.endTime or nil, data.label)
	end)
end)

-- commande admin : UpdateTimer(secondes, texte) ; 0 seconde = arreter
updateRemote.OnServerEvent:Connect(function(player, seconds, label, scope)
	if not table.find(AdminConfig.AdminIds, player.UserId) then return end
	local secs = tonumber(seconds)
	if not secs or secs ~= secs then return end
	secs = math.floor(secs)
	if type(label) ~= "string" then label = "" end
	label = string.sub(label, 1, 40)

	local endTime
	if secs > 0 then
		secs = math.min(secs, MAX_SECONDS)
		endTime = os.time() + secs
	end

	lastChange = os.clock()
	applyState(endTime, label)
	if scope == "server" then -- ce serveur seulement
		localUntil = endTime or 0
		notifyRemote:FireClient(player, endTime and ("Countdown started on THIS server: " .. describe(secs)) or "Countdown stopped on this server")
		return
	end
	localUntil = 0

	task.spawn(function()
		if store then
			pcall(function()
				if endTime then
					store:SetAsync(KEY, {endTime = endTime, label = label})
				else
					store:RemoveAsync(KEY)
				end
			end)
		end
	end)
	pcall(function() MessagingService:PublishAsync(TOPIC, {endTime = endTime or 0, label = label}) end)

	notifyRemote:FireClient(player, endTime and ("Countdown started: " .. describe(secs)) or "Countdown stopped")
end)

-- fin du compte a rebours : on le retire ; et on resynchronise avec le DataStore de temps en temps
task.spawn(function()
	local tick = 0
	while true do
		task.wait(1)
		tick += 1
		local e = ReplicatedStorage:GetAttribute("CountdownEnd")
		if type(e) == "number" and os.time() >= e then
			applyState(nil)
		end
		if tick % 60 == 0 and os.clock() - lastChange > 15 and localUntil < os.time() then
			loadState()
		end
	end
end)
