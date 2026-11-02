-- LuckEventServer : event "x4 LUCK SERVER" GLOBAL (tous les serveurs), commande admin StartLuckEvent
-- Pendant l'event, ReplicatedStorage.LuckMultiplier = 4 : EggZoneServer l'utilise pour tirer de meilleurs oeufs.
-- La fin est un horodatage absolu sauvegarde dans un DataStore : l'event survit aux deconnexions et aux nouveaux serveurs.
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local DataStoreService = game:GetService("DataStoreService")
local MessagingService = game:GetService("MessagingService")

local AdminConfig = require(ReplicatedStorage:WaitForChild("AdminConfig"))
local remotes = ReplicatedStorage:WaitForChild("AdminSystem"):WaitForChild("Remotes")
local startRemote = remotes:WaitForChild("StartLuckEvent")
local announceRemote = remotes:WaitForChild("BroadcastAnnounce")
local notifyRemote = ReplicatedStorage:WaitForChild("EggSystem"):WaitForChild("Remotes"):WaitForChild("Notify")

local MULTIPLIER = 4
local STORE_NAME, KEY = "LuckEvent_v1", "State"
local TOPIC = "AdminLuckEvent"
local MAX_SECONDS = 24 * 3600 -- 24 h maximum

local store
pcall(function() store = DataStoreService:GetDataStore(STORE_NAME) end)

local active = false
local lastChange = 0
local localUntil = 0 -- event lancé pour CE serveur seulement : on ne le remplace pas par l'état global

local function describe(secs)
	local h = math.floor(secs / 3600)
	local m = math.floor(secs % 3600 / 60)
	local s = secs % 60
	local parts = {}
	if h > 0 then table.insert(parts, h .. "h") end
	if m > 0 then table.insert(parts, m .. "min") end
	if s > 0 or #parts == 0 then table.insert(parts, s .. "s") end
	return table.concat(parts, " ")
end

local function applyState(endTime, announce)
	if type(endTime) == "number" and endTime > os.time() then
		active = true
		ReplicatedStorage:SetAttribute("LuckMultiplier", MULTIPLIER)
		ReplicatedStorage:SetAttribute("LuckEnd", endTime)
		if announce then
			announceRemote:FireAllClients("EVENT", MULTIPLIER .. "x server luck pendant " .. describe(endTime - os.time()) .. " !", 0)
		end
	else
		local was = active
		active = false
		ReplicatedStorage:SetAttribute("LuckMultiplier", nil)
		ReplicatedStorage:SetAttribute("LuckEnd", nil)
		if announce and was then
			announceRemote:FireAllClients("EVENT", "The " .. MULTIPLIER .. "x server luck event is over!", 0)
		end
	end
end

local function loadState()
	if not store then return end
	local ok, data = pcall(function() return store:GetAsync(KEY) end)
	if not ok then return end
	if type(data) == "table" and type(data.endTime) == "number" then
		applyState(data.endTime, false)
	else
		applyState(nil, false)
	end
end

task.spawn(loadState) -- nouveau serveur : on reprend l'event en cours

-- tous les serveurs (y compris celui de l'admin) recoivent le message
pcall(function()
	MessagingService:SubscribeAsync(TOPIC, function(message)
		local data = message.Data
		if type(data) ~= "table" or type(data.endTime) ~= "number" then return end
		lastChange = os.clock()
		applyState(data.endTime > 0 and data.endTime or nil, true)
	end)
end)

-- commande admin : StartLuckEvent(secondes) ; 0 = arreter
startRemote.OnServerEvent:Connect(function(player, seconds, scope)
	if not table.find(AdminConfig.AdminIds, player.UserId) then return end
	local secs = tonumber(seconds)
	if not secs or secs ~= secs then return end
	secs = math.floor(secs)

	local endTime
	if secs > 0 then
		secs = math.min(secs, MAX_SECONDS)
		endTime = os.time() + secs
	end
	lastChange = os.clock()
	if scope == "server" then -- ce serveur seulement : rien n'est sauvegardé ni envoyé aux autres
		localUntil = endTime or 0
		applyState(endTime, true)
		notifyRemote:FireClient(player, endTime and (MULTIPLIER .. "x luck started on THIS server: " .. describe(secs)) or "Server luck event stopped on this server")
		return
	end
	localUntil = 0

	task.spawn(function()
		if store then
			pcall(function()
				if endTime then store:SetAsync(KEY, {endTime = endTime}) else store:RemoveAsync(KEY) end
			end)
		end
	end)

	local ok = pcall(function() MessagingService:PublishAsync(TOPIC, {endTime = endTime or 0}) end)
	if not ok then applyState(endTime, true) end -- Studio : ce serveur seulement

	notifyRemote:FireClient(player, endTime and ("" .. MULTIPLIER .. "x server luck event started: " .. describe(secs)) or "Server luck event stopped")
end)

-- fin naturelle de l'event + resynchronisation avec le DataStore
task.spawn(function()
	local tick = 0
	while true do
		task.wait(1)
		tick += 1
		local e = ReplicatedStorage:GetAttribute("LuckEnd")
		if active and type(e) == "number" and os.time() >= e then
			applyState(nil, true)
		end
		if tick % 60 == 0 and os.clock() - lastChange > 15 and localUntil < os.time() then
			loadState()
		end
	end
end)
