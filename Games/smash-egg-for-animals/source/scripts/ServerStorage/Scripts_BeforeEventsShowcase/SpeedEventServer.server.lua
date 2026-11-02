-- SpeedEventServer : events "2X SPEED" et "4X SPEED" (commande admin StartSpeedEvent, ce serveur ou tous les serveurs).
-- Pendant l'event, le speed gagné sur le tapis est multiplié par 2 ou par 4 (SpeedServer lit ReplicatedStorage.SpeedEventMult).
-- Fin de chaque event : attribut SpeedX2End / SpeedX4End de ReplicatedStorage (heure serveur), affiché par EventStack.
-- Si les deux tournent en même temps, c'est le plus fort (x4) qui compte.
-- La fin est sauvegardée dans un DataStore : un event global continue dans les nouveaux serveurs.
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MessagingService = game:GetService("MessagingService")
local DataStoreService = game:GetService("DataStoreService")

local AdminConfig = require(ReplicatedStorage:WaitForChild("AdminConfig"))
local remotes = ReplicatedStorage:WaitForChild("AdminSystem"):WaitForChild("Remotes")
local startRemote = remotes:WaitForChild("StartSpeedEvent")
local announceRemote = remotes:WaitForChild("BroadcastAnnounce")
local notifyRemote = ReplicatedStorage:WaitForChild("EggSystem"):WaitForChild("Remotes"):WaitForChild("Notify")

local TOPIC = "AdminSpeedEvent"
local MIN_DURATION, MAX_DURATION = 10, 86400
local EVENTS = {[2] = "SpeedX2End", [4] = "SpeedX4End"}

local store
pcall(function() store = DataStoreService:GetDataStore("SpeedEvent_v1") end)

local function now() return workspace:GetServerTimeNow() end
local function describe(secs)
	secs = math.floor(secs)
	local h, m, s = secs // 3600, (secs % 3600) // 60, secs % 60
	if h > 0 then return string.format("%dh%02dm", h, m) end
	if m > 0 then return string.format("%dm%02ds", m, s) end
	return s .. "s"
end

-- multiplicateur actuel : le plus fort des events en cours
local function refreshMult()
	local best = 1
	for mult, attribute in EVENTS do
		local e = ReplicatedStorage:GetAttribute(attribute)
		if type(e) == "number" and e > now() and mult > best then best = mult end
	end
	ReplicatedStorage:SetAttribute("SpeedEventMult", best > 1 and best or nil)
end

local function apply(mult, endAt, announce)
	local attribute = EVENTS[mult]
	if not attribute then return end
	local was = ReplicatedStorage:GetAttribute(attribute)
	if type(endAt) == "number" and endAt > now() then
		ReplicatedStorage:SetAttribute(attribute, endAt)
		if announce then
			announceRemote:FireAllClients("EVENT", mult .. "X SPEED for " .. describe(endAt - now()) .. "! Run on your treadmill: speed gained x" .. mult .. "!", 0)
		end
	else
		ReplicatedStorage:SetAttribute(attribute, nil)
		if announce and was then
			announceRemote:FireAllClients("EVENT", "The " .. mult .. "x speed event is over!", 0)
		end
	end
	refreshMult()
end

-- nouveau serveur : on reprend les events globaux en cours
task.spawn(function()
	if not store then return end
	local ok, data = pcall(function() return store:GetAsync("State") end)
	if ok and type(data) == "table" then
		for mult in EVENTS do apply(mult, tonumber(data[tostring(mult)]), false) end
	end
end)

local function save(mult, endAt)
	if not store then return end
	task.spawn(pcall, function()
		store:UpdateAsync("State", function(old)
			old = type(old) == "table" and old or {}
			old[tostring(mult)] = endAt
			return old
		end)
	end)
end

pcall(function()
	MessagingService:SubscribeAsync(TOPIC, function(message)
		local data = message.Data
		if type(data) == "table" then apply(tonumber(data.mult), tonumber(data.endAt), true) end
	end)
end)

-- commande admin : StartSpeedEvent(2 ou 4, "start" / "stop", secondes, scope) ; scope "server" = ce serveur seulement
startRemote.OnServerEvent:Connect(function(player, mult, action, duration, scope)
	if not table.find(AdminConfig.AdminIds, player.UserId) then return end
	mult = tonumber(mult)
	if not EVENTS[mult] or (action ~= "start" and action ~= "stop") then return end
	duration = math.clamp(math.floor(tonumber(duration) or 600), MIN_DURATION, MAX_DURATION)
	local endAt = action == "start" and (now() + duration) or nil
	local ok = false
	if scope ~= "server" then
		save(mult, endAt)
		ok = pcall(function() MessagingService:PublishAsync(TOPIC, {mult = mult, endAt = endAt or 0}) end)
	end
	if not ok then apply(mult, endAt, true) end -- ce serveur seulement (ou Studio)
	notifyRemote:FireClient(player, mult .. "x SPEED " .. (endAt and ("started (" .. describe(duration) .. ")") or "stopped"))
end)

-- fin naturelle des events
while true do
	task.wait(1)
	for mult, attribute in EVENTS do
		local e = ReplicatedStorage:GetAttribute(attribute)
		if type(e) == "number" and e <= now() then apply(mult, nil, true) end
	end
end
