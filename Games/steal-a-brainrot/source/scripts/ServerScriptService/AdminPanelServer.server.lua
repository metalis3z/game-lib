--[[
	AdminPanelServer.server.lua
	Place dans: ServerScriptService

	Vérifie le UserId admin côté serveur (source de vérité).
	Toute action (spawn, event, mutation rain) passe par ici et est
	re-vérifiée, donc impossible à bypasser depuis le client.
]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local Net = require(ReplicatedStorage.Packages.Net)

print("[AdminPanelServer] Script démarré, chargement des services...")

local okAnimal, AnimalService = pcall(function()
	return require(ServerScriptService.Services.AnimalService)
end)
if not okAnimal then
	warn("[AdminPanelServer] ÉCHEC require AnimalService:", AnimalService)
end

local okEvent, EventService = pcall(function()
	return require(ServerScriptService.Services.EventService)
end)
if not okEvent then
	warn("[AdminPanelServer] ÉCHEC require EventService:", EventService)
end

local okAnimalsData, Animals = pcall(function()
	return require(ReplicatedStorage.Datas.Animals)
end)
if not okAnimalsData then
	warn("[AdminPanelServer] ÉCHEC require Datas.Animals:", Animals)
end

print("[AdminPanelServer] Services chargés -> AnimalService:", okAnimal, "EventService:", okEvent, "Animals:", okAnimalsData)

-- ============================================================
-- CONFIG ADMIN
-- ============================================================
local ADMIN_USER_IDS = {
	[11193240899] = true,
	[8270105851] = true,
}

local function isAdmin(userId: number): boolean
	return ADMIN_USER_IDS[userId] == true
end

-- ============================================================
-- REMOTES
-- ============================================================
local CheckAdminRF = Net:RemoteFunction("AdminPanel/CheckAdmin")
local GetAnimalListRF = Net:RemoteFunction("AdminPanel/GetAnimalList")
local GetEventListRF = Net:RemoteFunction("AdminPanel/GetEventList")
local GetActiveEventsRF = Net:RemoteFunction("AdminPanel/GetActiveEvents")

local SpawnAnimalRF = Net:RemoteFunction("AdminPanel/SpawnAnimal")
local ExecuteEventRF = Net:RemoteFunction("AdminPanel/ExecuteEvent")
local CancelEventRF = Net:RemoteFunction("AdminPanel/CancelEvent")
local StartMutationRainRF = Net:RemoteFunction("AdminPanel/StartMutationRain")
local StopMutationRainRF = Net:RemoteFunction("AdminPanel/StopMutationRain")

-- ============================================================
-- ANTI ABUS
-- ============================================================
local lastActionAt: { [number]: number } = {}
local ACTION_COOLDOWN = 0.15

local function throttled(userId: number): boolean
	local now = os.clock()
	local last = lastActionAt[userId]
	if last and (now - last) < ACTION_COOLDOWN then
		return true
	end
	lastActionAt[userId] = now
	return false
end

-- ============================================================
-- CHECK ADMIN
-- ============================================================
CheckAdminRF.OnServerInvoke = function(player: Player)
	local result = isAdmin(player.UserId)
	print(string.format("[AdminPanelServer] CheckAdmin pour %s (UserId %d) -> %s", player.Name, player.UserId, tostring(result)))
	return result
end

-- ============================================================
-- LISTES
-- ============================================================
GetAnimalListRF.OnServerInvoke = function(player: Player)
	if not isAdmin(player.UserId) then return {} end
	if not okAnimalsData then return {} end

	local list = {}
	for name, data in pairs(Animals) do
		table.insert(list, {
			Name = name,
			DisplayName = data.DisplayName or name,
			Rarity = data.Rarity or "Unknown",
		})
	end
	table.sort(list, function(a, b)
		if a.Rarity == b.Rarity then
			return a.DisplayName < b.DisplayName
		end
		return a.Rarity < b.Rarity
	end)
	return list
end

GetEventListRF.OnServerInvoke = function(player: Player)
	if not isAdmin(player.UserId) then return {} end
	if not okEvent then return {} end

	local list = {}
	for _, eventName in ipairs(EventService.Events) do
		table.insert(list, eventName)
	end
	table.sort(list)
	return list
end

GetActiveEventsRF.OnServerInvoke = function(player: Player)
	if not isAdmin(player.UserId) then return {} end
	if not okEvent then return {} end

	local result = {}
	local now = workspace:GetServerTimeNow()
	for eventName, data in pairs(EventService.ActiveEvents) do
		local remaining = nil
		if data.endsAt and data.endsAt ~= math.huge then
			remaining = math.max(0, math.floor(data.endsAt - now))
		end
		table.insert(result, {
			EventName = eventName,
			Remaining = remaining,
		})
	end
	table.sort(result, function(a, b) return a.EventName < b.EventName end)
	return result
end

-- ============================================================
-- SPAWN ANIMAL
-- ============================================================
SpawnAnimalRF.OnServerInvoke = function(player: Player, animalName: string, mutationName: string?, isGlobal: boolean?)
	if not isAdmin(player.UserId) then
		return false, "Accès refusé"
	end
	if not okAnimal or not okAnimalsData then
		return false, "AnimalService indisponible (voir Output serveur)"
	end
	if throttled(player.UserId) then
		return false, "Trop rapide, attends un instant"
	end
	if type(animalName) ~= "string" then
		return false, "Animal invalide"
	end

	local animalData = Animals[animalName]
	if not animalData then
		return false, "Animal introuvable: " .. tostring(animalName)
	end

	local cleanMutation = nil
	if type(mutationName) == "string" and mutationName ~= "" and mutationName ~= "Aucune" then
		cleanMutation = mutationName
	end

	local ok, err = pcall(function()
		AnimalService.spawnAnimalCustom(
			animalData,
			cleanMutation,
			{},
			nil,
			nil,
			nil,
			true, -- IsIstant
			false,
			false,
			nil,
			nil,
			nil,
			1,
			true -- SkipSpawnDelay
		)
	end)

	if not ok then
		warn("[AdminPanelServer] Erreur spawnAnimalCustom:", err)
		return false, "Erreur: " .. tostring(err)
	end

	return true, string.format("%s spawné%s", animalData.DisplayName or animalName, cleanMutation and (" (" .. cleanMutation .. ")") or "")
end

-- ============================================================
-- EVENTS
-- ============================================================
ExecuteEventRF.OnServerInvoke = function(player: Player, eventName: string, duration: number?)
	if not isAdmin(player.UserId) then
		return false, "Accès refusé"
	end
	if not okEvent then
		return false, "EventService indisponible (voir Output serveur)"
	end
	if throttled(player.UserId) then
		return false, "Trop rapide, attends un instant"
	end
	if type(eventName) ~= "string" then
		return false, "Event invalide"
	end
	if not EventService.EventConfigs[eventName] then
		return false, "Event non enregistré: " .. eventName
	end

	local ok, err = pcall(function()
		EventService:ExecuteEvent(eventName, duration)
	end)
	if not ok then
		return false, "Erreur: " .. tostring(err)
	end

	return true, string.format("Event '%s' lancé", eventName)
end

CancelEventRF.OnServerInvoke = function(player: Player, eventName: string)
	if not isAdmin(player.UserId) then
		return false, "Accès refusé"
	end
	if not okEvent then
		return false, "EventService indisponible"
	end
	if type(eventName) ~= "string" then
		return false, "Event invalide"
	end

	local ok, err = pcall(function()
		EventService:CancelEvent(eventName)
	end)
	if not ok then
		return false, "Erreur: " .. tostring(err)
	end

	return true, string.format("Event '%s' annulé", eventName)
end

-- ============================================================
-- MUTATION RAIN
-- ============================================================
StartMutationRainRF.OnServerInvoke = function(player: Player, mutationName: string?, amount: number, isGlobal: boolean?)
	if not isAdmin(player.UserId) then
		return false, "Accès refusé"
	end
	if not okAnimal then
		return false, "AnimalService indisponible"
	end
	if throttled(player.UserId) then
		return false, "Trop rapide, attends un instant"
	end

	amount = tonumber(amount)
	if not amount or amount <= 0 then
		return false, "Quantité invalide"
	end

	local success, resolved
	if isGlobal then
		success, resolved = AnimalService:StartGlobalMutationRain(mutationName, amount, player.UserId)
	else
		success, resolved = AnimalService:StartMutationRain(mutationName, amount)
	end

	if not success then
		return false, tostring(resolved or "Échec")
	end

	return true, string.format("Pluie de mutation '%s' x%d démarrée", resolved or mutationName or "Cycle", amount)
end

StopMutationRainRF.OnServerInvoke = function(player: Player, mutationName: string?, isGlobal: boolean?)
	if not isAdmin(player.UserId) then
		return false, "Accès refusé"
	end
	if not okAnimal then
		return false, "AnimalService indisponible"
	end

	if isGlobal then
		AnimalService:StopGlobalMutationRain(mutationName, player.UserId)
	else
		AnimalService:StopMutationRain(mutationName)
	end

	return true, "Pluie de mutation arrêtée"
end

print("[AdminPanelServer] Initialisation terminée. Remotes prêtes.")