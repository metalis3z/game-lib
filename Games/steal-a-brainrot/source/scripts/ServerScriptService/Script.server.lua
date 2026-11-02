-- ╔══════════════════════════════════════════════════════════════╗
-- ║   BRAINROT STATS TRACKER v18 - Proxy Vercel + Open Cloud    ║
-- ╚══════════════════════════════════════════════════════════════╝

local DataStoreService = game:GetService("DataStoreService")
local HttpService      = game:GetService("HttpService")
local Players          = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local CONFIG = {
	DATASTORE_NAME         = "DATA-FOR-EVERYONESS-V2",
	JSONBIN_BIN_ID         = "69a871b943b1c97be9b369c7",
	JSONBIN_BIN_ID_DETAILS = "69a88cddae596e708f5f7ecb",
	JSONBIN_API_KEY        = "$2a$10$zYpN4lgLUxpFrEj9gmHXSe8aamA0VMSGQ3wTgZUerR181/l5cUuP2",
	JSONBIN_BIN_ID_PLAYERS = "69b99e67c3097a1dd533bdbe",
	UNIVERSE_ID            = 9953680373,
}

local PROXY_URL = "https://counter-roan-xi.vercel.app/api/roblox-datastore"

-- ═══════════════════════════════════════════════════════════════
-- 🛡️ WHITELIST
-- ═══════════════════════════════════════════════════════════════

local WHITELISTED_USERS = {
	[3349554075] = true,
}

local function notifyPlayer(player, msg, isErr)
	print("[BrainrotStats] " .. (isErr and "❌" or "✅") .. " " .. player.Name .. ": " .. msg)
	pcall(function()
		local remote = ReplicatedStorage:FindFirstChild("BrainrotNotify")
		if remote then remote:FireClient(player, msg, isErr) end
	end)
end

-- ═══════════════════════════════════════════════════════════════
-- Open Cloud via Proxy Vercel
-- ═══════════════════════════════════════════════════════════════

local function fetchAllKeysViaOpenCloud()
	local allKeys = {}

	local ok, result = pcall(function()
		return HttpService:RequestAsync({
			Url = PROXY_URL,
			Method = "POST",
			Headers = { ["Content-Type"] = "application/json" },
			Body = HttpService:JSONEncode({
				universeId = CONFIG.UNIVERSE_ID,
				dataStoreName = CONFIG.DATASTORE_NAME,
				action = "listKeys"
			})
		})
	end)

	if ok and result and result.Success then
		local data = HttpService:JSONDecode(result.Body)
		if data.keys then
			allKeys = data.keys
		end
	else
		warn("[BrainrotStats] ❌ Proxy listKeys: " .. tostring(result and result.StatusCode or "erreur"))
	end

	print("[BrainrotStats] 📋 " .. #allKeys .. " clés via proxy")
	return allKeys
end

local function fetchPlayerData(userId)
	local ok, result = pcall(function()
		return HttpService:RequestAsync({
			Url = PROXY_URL,
			Method = "POST",
			Headers = { ["Content-Type"] = "application/json" },
			Body = HttpService:JSONEncode({
				universeId = CONFIG.UNIVERSE_ID,
				dataStoreName = CONFIG.DATASTORE_NAME,
				action = "getData",
				key = tostring(userId)
			})
		})
	end)

	if ok and result and result.Success then
		local data = HttpService:JSONDecode(result.Body)
		if data.value then
			if type(data.value) == "string" then
				return HttpService:JSONDecode(data.value)
			else
				return data.value
			end
		end
	end

	return nil
end

-- ═══════════════════════════════════════════════════════════════
-- Extraction des données
-- ═══════════════════════════════════════════════════════════════

local function extractFromPodiums(playerData)
	if not playerData then return {} end
	local results = {}
	local podiums = playerData["AnimalPodiums"]
	if type(podiums) ~= "table" then return results end
	for _, entry in ipairs(podiums) do
		if type(entry) == "table" then
			local name = entry["Index"]
			if type(name) == "string" and name ~= "" then
				local traits = {}
				if type(entry["Traits"]) == "table" then
					for _, t in ipairs(entry["Traits"]) do
						if type(t) == "string" and t ~= "" then table.insert(traits, t) end
					end
				end
				local mutation = "Normal"
				if type(entry["Mutation"]) == "string" and entry["Mutation"] ~= "" then
					mutation = entry["Mutation"]
				end
				table.insert(results, { name=name, mutation=mutation, traits=traits })
			end
		end
	end
	return results
end

local function pushBin(binId, payload)
	pcall(function()
		HttpService:RequestAsync({
			Url    = "https://api.jsonbin.io/v3/b/" .. binId,
			Method = "PUT",
			Headers = {
				["Content-Type"] = "application/json",
				["X-Master-Key"] = CONFIG.JSONBIN_API_KEY,
			},
			Body = payload,
		})
	end)
end

local function getPlayerSummary(userId, username)
	local data = fetchPlayerData(userId)
	if type(data) ~= "table" then return nil end

	local brainrots  = extractFromPodiums(data)
	local counts     = {}
	local mutSummary = {}
	local traitSummary = {}

	for _, entry in ipairs(brainrots) do
		local n = entry.name
		counts[n] = (counts[n] or 0) + 1
		if not mutSummary[n] then mutSummary[n] = {} end
		mutSummary[n][entry.mutation] = (mutSummary[n][entry.mutation] or 0) + 1
		if not traitSummary[n] then traitSummary[n] = {} end
		for _, t in ipairs(entry.traits) do
			traitSummary[n][t] = (traitSummary[n][t] or 0) + 1
		end
	end

	local mutTotals = {}
	local traitTotals = {}
	for _, muts in pairs(mutSummary) do
		for m, c in pairs(muts) do mutTotals[m] = (mutTotals[m] or 0) + c end
	end
	for _, traits in pairs(traitSummary) do
		for t, c in pairs(traits) do traitTotals[t] = (traitTotals[t] or 0) + c end
	end

	return {
		username = username, userId = userId, totalInPodium = #brainrots, uniqueSpecies = 0,
		mutTotals = mutTotals, traitTotals = traitTotals, brainrotList = counts,
		rebirth = type(data["Rebirth"]) == "number" and data["Rebirth"] or 0,
		lastUpdated = os.time(),
	}
end

-- ═══════════════════════════════════════════════════════════════
-- Scan global
-- ═══════════════════════════════════════════════════════════════

local isScanning = false

local function scanAllAndPush(requestedBy)
	if isScanning then return false end
	isScanning = true

	print("[BrainrotStats] 🔍 Scan par " .. (requestedBy or "?"))

	local allKeys = fetchAllKeysViaOpenCloud()
	if #allKeys == 0 then
		print("[BrainrotStats] ❌ Aucune clé")
		isScanning = false
		return false
	end

	local counts={} local mutSummary={} local traitSummary={}
	local totalBrainrots=0 local totalPlayers=0

	for idx, key in ipairs(allKeys) do
		local data = fetchPlayerData(key)
		if type(data) == "table" then
			local brainrots = extractFromPodiums(data)
			if #brainrots > 0 then
				totalPlayers += 1
				totalBrainrots += #brainrots
				for _, entry in ipairs(brainrots) do
					local n = entry.name
					counts[n] = (counts[n] or 0) + 1
					if not mutSummary[n] then mutSummary[n]={} end
					mutSummary[n][entry.mutation] = (mutSummary[n][entry.mutation] or 0) + 1
					if not traitSummary[n] then traitSummary[n]={} end
					for _, t in ipairs(entry.traits) do
						traitSummary[n][t] = (traitSummary[n][t] or 0) + 1
					end
				end
			end
		end
		if idx % 50 == 0 then print("[BrainrotStats] ⏳ " .. idx .. "/" .. #allKeys) end
		task.wait(0.05)
	end

	print("[BrainrotStats] ✅ " .. totalBrainrots .. " brainrots | " .. totalPlayers .. " joueurs")

	pushBin(CONFIG.JSONBIN_BIN_ID, HttpService:JSONEncode({ counts=counts, totalBrainrots=totalBrainrots, totalPlayers=totalPlayers, lastUpdated=os.time() }))
	task.wait(1)
	pushBin(CONFIG.JSONBIN_BIN_ID_DETAILS, HttpService:JSONEncode({ mutSummary=mutSummary, traitSummary=traitSummary, lastUpdated=os.time() }))

	print("[BrainrotStats] ✅ Bins pushés !")
	isScanning = false
	return true
end

-- ═══════════════════════════════════════════════════════════════
-- Profils joueurs
-- ═══════════════════════════════════════════════════════════════

Players.PlayerAdded:Connect(function(player)
	task.wait(5)
	local summary = getPlayerSummary(player.UserId, player.Name)
	if summary then
		pcall(function()
			local resp = HttpService:RequestAsync({
				Url = "https://api.jsonbin.io/v3/b/" .. CONFIG.JSONBIN_BIN_ID_PLAYERS,
				Method = "GET",
				Headers = { ["X-Master-Key"] = CONFIG.JSONBIN_API_KEY, ["X-Bin-Meta"] = "false" },
			})
			local playersData = {}
			if resp.StatusCode == 200 then
				local parsed = HttpService:JSONDecode(resp.Body)
				if type(parsed) == "table" and type(parsed.players) == "table" then
					playersData = parsed.players
				end
			end
			playersData[player.Name:lower()] = summary
			pushBin(CONFIG.JSONBIN_BIN_ID_PLAYERS, HttpService:JSONEncode({ players=playersData, lastUpdated=os.time() }))
			print("[BrainrotStats] 👤 Profil: " .. player.Name)
		end)
	end
end)

-- ═══════════════════════════════════════════════════════════════
-- Commandes chat
-- ═══════════════════════════════════════════════════════════════

Players.PlayerAdded:Connect(function(player)
	player.Chatted:Connect(function(msg)
		if string.lower(msg) == "!scan" then
			if not WHITELISTED_USERS[player.UserId] then
				notifyPlayer(player, "⛔ Pas la permission", true)
				return
			end
			notifyPlayer(player, "✅ Scan lancé !", false)
			task.spawn(function()
				local ok = scanAllAndPush(player.Name)
				if ok then
					notifyPlayer(player, "✅ Scan terminé !", false)
				else
					notifyPlayer(player, "❌ Scan en cours ou erreur", true)
				end
			end)
		end
	end)
end)

print("[BrainrotStats] ✅ Chargé — Proxy Vercel | !scan")