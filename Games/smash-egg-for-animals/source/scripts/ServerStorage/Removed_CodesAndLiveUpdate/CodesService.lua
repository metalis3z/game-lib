-- CodesService : tous les codes du jeu
--  * codes fixes (CodesConfig) : illimités, 1 utilisation par joueur
--  * codes admin (panneau F2) : stock limité PARTAGÉ entre tous les serveurs (DataStore) -> SOLD OUT quand le stock est épuisé
-- Messages (en anglais) renvoyés au joueur :
--  "Invalid code!" / "This code is sold out!" / "You already used this code!" / "<Pet> spawned in the Common Egg Zone!"
local DataStoreService = game:GetService("DataStoreService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")
local RunService = game:GetService("RunService")

local StaticCodes = require(script.Parent:WaitForChild("CodesConfig"))
local EggConfig = require(ReplicatedStorage:WaitForChild("EggSystem"):WaitForChild("EggConfig"))

local gameBindables = ServerStorage:WaitForChild("GameBindables")
local spawnCodePet = gameBindables:WaitForChild("SpawnCodePet", 10)
if not spawnCodePet then
	spawnCodePet = Instance.new("BindableEvent")
	spawnCodePet.Name = "SpawnCodePet"
	spawnCodePet.Parent = gameBindables
end

local CodesService = {}

local CODES_KEY = "Codes"
local IS_STUDIO = RunService:IsStudio()
local okStore, store = pcall(function() return DataStoreService:GetDataStore("AdminCodes_v1") end)
if not okStore then store = nil end

local memoryData = {}   -- secours (Studio sans accès aux DataStores)
local cache = {}        -- dernière liste de codes connue
local usedCache = {}    -- [userId] = {[CODE] = true}
local busy = {}

---------------------------------------------------------------- accès au stockage
local function read(key)
	if store then
		for attempt = 1, 3 do
			local ok, value = pcall(store.GetAsync, store, key)
			if ok then return true, value end
			task.wait(0.5 * attempt)
		end
		warn("[CodesService] lecture DataStore impossible : " .. key)
	end
	if IS_STUDIO or not store then return true, memoryData[key] end
	return false, nil
end

-- fn(old) -> new (ne doit pas yield) ; retourne ok
local function update(key, fn)
	if store then
		for attempt = 1, 3 do
			local ok = pcall(store.UpdateAsync, store, key, fn)
			if ok then return true end
			task.wait(0.5 * attempt)
		end
		warn("[CodesService] écriture DataStore impossible : " .. key)
	end
	if IS_STUDIO or not store then
		local new = fn(memoryData[key])
		if new ~= nil then memoryData[key] = new end
		return true
	end
	return false
end

---------------------------------------------------------------- utilitaires
local function normalize(code)
	return string.upper((string.gsub(code, "^%s*(.-)%s*$", "%1")))
end

local function formatNumber(n)
	local s = tostring(math.floor(n))
	return (string.gsub(string.reverse((string.gsub(string.reverse(s), "(%d%d%d)", "%1,"))), "^,", ""))
end

local function copyRewards(r)
	local pets = {}
	if type(r.Pets) == "table" then
		for _, p in r.Pets do
			if type(p) == "string" then table.insert(pets, p) end
		end
	end
	if type(r.Pet) == "string" then table.insert(pets, r.Pet) end
	return {Money = tonumber(r.Money) or 0, Eggs = {}, Pets = pets}
end

local function loadUsed(player)
	local used = usedCache[player.UserId]
	if used then return used end
	local ok, data = read("Used_" .. player.UserId)
	if not ok then return nil end
	used = type(data) == "table" and data or {}
	usedCache[player.UserId] = used
	return used
end

---------------------------------------------------------------- liste (panneau admin)
function CodesService.List()
	local ok, data = read(CODES_KEY)
	if ok and type(data) == "table" then cache = data end
	local copy = {}
	for code, entry in cache do
		copy[code] = {
			Uses = entry.Uses or 0,
			MaxUses = entry.MaxUses or 1,
			Rewards = {
				Money = entry.Rewards and entry.Rewards.Money or 0,
				Eggs = {},
				Pets = entry.Rewards and entry.Rewards.Pets or {},
			},
		}
	end
	return copy
end

---------------------------------------------------------------- création (panneau admin)
function CodesService.Create(rawCode, maxUses, money, pets)
	if type(rawCode) ~= "string" then return false, "invalid code name" end
	local code = normalize(rawCode)
	if code == "" or #code > 30 or string.find(code, "[^%w_%-]") then
		return false, "use 1-30 letters, numbers, - or _"
	end
	if StaticCodes[code] then return false, "this code already exists" end

	maxUses = math.clamp(math.floor(tonumber(maxUses) or 1), 1, 1000000)
	money = math.max(math.floor(tonumber(money) or 0), 0)
	local petList = {}
	if type(pets) == "table" then
		for _, p in pets do
			if type(p) == "string" and EggConfig.Pets[p] then table.insert(petList, p) end
		end
	end
	if money <= 0 and #petList == 0 then return false, "add at least one reward (money or pet)" end

	local outcome
	local ok = update(CODES_KEY, function(old)
		old = type(old) == "table" and old or {}
		if old[code] then outcome = "exists" return nil end
		old[code] = {Uses = 0, MaxUses = maxUses, Rewards = {Money = money, Pets = petList}}
		outcome = "ok"
		return old
	end)
	if not ok then return false, "service unavailable" end
	if outcome ~= "ok" then return false, "this code already exists" end
	return true, code
end

---------------------------------------------------------------- utilisation d'un code
local function redeemInner(player, code)
	local rewards
	local isAdminCode = false
	if StaticCodes[code] then
		rewards = copyRewards(StaticCodes[code])
	else
		isAdminCode = true
		local ok, data = read(CODES_KEY)
		if not ok then return false, "Service unavailable, try again later." end
		if type(data) ~= "table" or not data[code] then return false, "Invalid code!" end
	end

	local used = loadUsed(player)
	if not used then return false, "Service unavailable, try again later." end
	if used[code] then return false, "You already used this code!" end

	if isAdminCode then
		-- on réserve une utilisation de façon atomique (même stock pour tous les serveurs)
		local outcome
		local ok = update(CODES_KEY, function(old)
			local entry = type(old) == "table" and old[code]
			if not entry then outcome = "invalid" return nil end
			if (entry.Uses or 0) >= (entry.MaxUses or 1) then outcome = "soldout" return nil end
			entry.Uses = (entry.Uses or 0) + 1
			rewards = copyRewards(entry.Rewards or {})
			outcome = "ok"
			return old
		end)
		if not ok then return false, "Service unavailable, try again later." end
		if outcome == "invalid" then return false, "Invalid code!" end
		if outcome == "soldout" then return false, "This code is sold out!" end
	end

	-- le joueur ne pourra plus réutiliser ce code
	used[code] = true
	local savedOk = update("Used_" .. player.UserId, function(old)
		old = type(old) == "table" and old or {}
		old[code] = true
		return old
	end)
	if not savedOk then warn("[CodesService] impossible d'enregistrer le code utilisé pour " .. player.Name) end

	-- récompenses
	local parts = {}
	if rewards.Money > 0 then
		player:SetAttribute("Money", (player:GetAttribute("Money") or 0) + rewards.Money)
		table.insert(parts, "You received $" .. formatNumber(rewards.Money) .. "!")
	end
	local petNames = {}
	for _, petName in rewards.Pets do
		local info = EggConfig.Pets[petName]
		if info then
			-- l'animal va directement dans l'inventaire
			pcall(function() gameBindables:WaitForChild("GiveZonePet"):Invoke(player, petName, (info.Kg or 1) * (0.9 + math.random() * 0.2)) end)
			table.insert(petNames, info.Name or petName)
		end
	end
	if #petNames > 0 then
		table.insert(parts, table.concat(petNames, ", ") .. " added to your inventory!")
	end
	if #parts == 0 then return true, "Code redeemed!" end
	return true, table.concat(parts, " ")
end

function CodesService.Redeem(player, rawCode)
	if type(rawCode) ~= "string" then return false, "Invalid code!" end
	local code = normalize(rawCode)
	if code == "" or #code > 60 then return false, "Invalid code!" end
	if busy[player] then return false, "Please wait..." end
	busy[player] = true
	local ok, success, message = pcall(redeemInner, player, code)
	busy[player] = nil
	if not ok then
		warn("[CodesService] erreur : " .. tostring(success))
		return false, "Something went wrong, try again."
	end
	return success, message
end

Players.PlayerRemoving:Connect(function(player)
	busy[player] = nil
	usedCache[player.UserId] = nil
end)

return CodesService
