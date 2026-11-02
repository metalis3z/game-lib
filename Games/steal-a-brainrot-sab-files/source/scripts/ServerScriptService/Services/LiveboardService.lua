
local ReplicatedStorage   = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local HttpService         = game:GetService("HttpService")
local MemoryStoreService  = game:GetService("MemoryStoreService")

local MessagingService = require(ServerScriptService.Services.MessagingService)

local Net = require(ReplicatedStorage.Packages.Net)


local DISPLAY_DURATION = 300


local SPAWN_WEBHOOK = "https://discord.com/api/webhooks/REDACTED"
local SPAWN_COLOR   = 0x2ECC71
local CLAIM_COLOR   = 0x5865F2
local MAX_RETRIES   = 3

local WEBHOOK_EXCLUDED = {
	["Skibidi Toilet"]      = true,
	["Meowl"]               = true,
	["Strawberry Elephant"] = true,
	["John Pork"] = true,
}

local LIVEBOARD_TOPIC = "Liveboard_Broadcast"


local NewEntry   = Net:RemoteEvent("Liveboard/NewEntry")
local ClaimEntry = Net:RemoteEvent("Liveboard/ClaimEntry")
local GetEntries = Net:RemoteFunction("Liveboard/GetEntries")


local LIVEBOARD_STORE_MAP = "LiveboardEntries_v1"
local STORE_PAGE_SIZE     = 100

local function getStoreMap()
	return MemoryStoreService:GetSortedMap(LIVEBOARD_STORE_MAP)
end


local MutationData = require(
	game:GetService("ReplicatedStorage"):WaitForChild("Datas"):WaitForChild("Mutations")
)

local mutationByName: { [string]: any } = {}
for _, entry in MutationData do
	if type(entry) == "table" and entry.DisplayText then
		mutationByName[entry.DisplayText] = entry
	end
end


local activeEntries: { any } = {}
local originatedUIDs: { [string]: boolean } = {}

local function removeExpiredEntries()
	local now = workspace:GetServerTimeNow()
	for i = #activeEntries, 1, -1 do
		if activeEntries[i].ExpiresAt <= now then
			originatedUIDs[activeEntries[i].UID] = nil
			table.remove(activeEntries, i)
		end
	end
end

local function persistEntry(entry: { [string]: any })
	if entry.IsLocalServer then return end

	task.spawn(function()
		local now = workspace:GetServerTimeNow()
		local ttl = math.max(1, math.ceil(entry.ExpiresAt - now))
		local stored = {
			UID              = entry.UID,
			BrainrotName     = entry.BrainrotName,
			Mutation         = entry.Mutation,
			Timestamp        = entry.Timestamp,
			DisplayDuration  = entry.DisplayDuration,
			ExpiresAt        = entry.ExpiresAt,
			OwnerUserId      = entry.OwnerUserId,
			OwnerDisplayName = entry.OwnerDisplayName,
		}
		local ok, err = pcall(function()
			getStoreMap():SetAsync(entry.UID, stored, ttl)
		end)
		if not ok then
			warn("[Liveboard] Failed to persist entry to MemoryStore:", err)
		end
	end)
end

local function persistClaim(uid: string, userId: number, displayName: string, ttl: number)
	task.spawn(function()
		local ok, err = pcall(function()
			getStoreMap():UpdateAsync(uid, function(old)
				if type(old) ~= "table" then
					return nil
				end
				old.OwnerUserId      = userId
				old.OwnerDisplayName = displayName
				return old
			end, math.max(1, math.ceil(ttl)))
		end)
		if not ok then
			warn("[Liveboard] Failed to persist claim to MemoryStore:", err)
		end
	end)
end

local function loadPersistedEntries()
	local map         = getStoreMap()
	local now         = workspace:GetServerTimeNow()
	local lowerBound  = nil
	local loaded      = 0

	while true do
		local ok, items = pcall(function()
			return map:GetRangeAsync(Enum.SortDirection.Ascending, STORE_PAGE_SIZE, lowerBound)
		end)
		if not ok then
			warn("[Liveboard] Failed to load entries from MemoryStore:", items)
			return
		end
		if type(items) ~= "table" or #items == 0 then
			break
		end

		for _, kv in ipairs(items) do
			local v = kv.value
			if type(v) == "table"
				and type(v.UID) == "string"
				and type(v.ExpiresAt) == "number"
				and v.ExpiresAt > now
			then
				local dup = false
				for _, existing in activeEntries do
					if existing.UID == v.UID then
						dup = true
						break
					end
				end
				if not dup then
					table.insert(activeEntries, {
						UID              = v.UID,
						BrainrotName     = v.BrainrotName,
						Mutation         = v.Mutation,
						IsLocalServer    = false,
						IsOriginServer   = false,
						Timestamp        = v.Timestamp,
						DisplayDuration  = v.DisplayDuration or DISPLAY_DURATION,
						ExpiresAt        = v.ExpiresAt,
						OwnerUserId      = v.OwnerUserId,
						OwnerDisplayName = v.OwnerDisplayName,
					})
					loaded += 1
				end
			end
		end

		if #items < STORE_PAGE_SIZE then
			break
		end
		lowerBound = items[#items].key
	end

	if loaded > 0 then
		warn(string.format(
			"[Liveboard] Restored %d active entr%s from MemoryStore",
			loaded, loaded == 1 and "y" or "ies"
			))
	end
end


local function color3ToInt(c: Color3): number
	return math.clamp(math.round(c.R * 255), 0, 255) * 65536
		+ math.clamp(math.round(c.G * 255), 0, 255) * 256
		+ math.clamp(math.round(c.B * 255), 0, 255)
end

local function getMutationColor(mutation: string?, baseColor: number): number
	if not mutation or mutation == "" or mutation == "None" then return baseColor end
	local entry = mutationByName[mutation]
	return (entry and entry.MainColor) and color3ToInt(entry.MainColor) or baseColor
end

local MODIFIER_TIERS = {
	{ min = 9,    emoji = "👑", label = "Legendary",      titleSpawn = "👑  Legendary Spawn!",     titleClaim = "👑  Legendary Animal Claimed!" },
	{ min = 7,    emoji = "💀", label = "Extremely Rare", titleSpawn = "💀  Extremely Rare Spawn!", titleClaim = "💀  Extremely Rare Claim!"     },
	{ min = 5,    emoji = "🌌", label = "Very Rare",      titleSpawn = "🌌  Rare Spawn Detected!",  titleClaim = "🌌  Rare Claim!"               },
	{ min = 3,    emoji = "🍬", label = "Rare",           titleSpawn = "✨  Mutated Spawn!",        titleClaim = "✨  Mutated Animal Claimed!"    },
	{ min = 1,    emoji = "🩸", label = "Uncommon",       titleSpawn = "✨  Mutated Spawn!",        titleClaim = "✨  Mutated Animal Claimed!"    },
	{ min = 0.5,  emoji = "💎", label = "Uncommon",       titleSpawn = "✨  Mutated Spawn!",        titleClaim = "✨  Mutated Animal Claimed!"    },
	{ min = 0.25, emoji = "🥇", label = "Uncommon",       titleSpawn = "✨  Mutated Spawn!",        titleClaim = "✨  Mutated Animal Claimed!"    },
	{ min = 0,    emoji = "🔹", label = "",               titleSpawn = "✨  Mutated Spawn!",        titleClaim = "✨  Mutated Animal Claimed!"    },
}

local function getMutationTier(mutation: string?)
	if not mutation or mutation == "" or mutation == "None" then return nil end
	local entry = mutationByName[mutation]
	if not entry then return nil end
	local modifier = entry.Modifier or 0
	for _, tier in MODIFIER_TIERS do
		if modifier >= tier.min then
			return tier, entry
		end
	end
	return nil, entry
end

local function formatMutation(mutation: string?): string
	if not mutation or mutation == "" or mutation == "None" then return "`None`" end
	local tier, entry = getMutationTier(mutation)
	if not tier then return "🔹 " .. mutation end
	return tier.emoji .. " **" .. entry.DisplayText .. "**"
end

local function isoTimestamp(): string
	return os.date("!%Y-%m-%dT%H:%M:%SZ") :: string
end


local function sendWebhook(payload: { [string]: any })
	task.spawn(function()
		for attempt = 1, MAX_RETRIES do
			local ok, err = pcall(function()
				warn("[Liveboard] Attempting webhook, attempt " .. attempt .. " to: " .. SPAWN_WEBHOOK)
				local response = HttpService:RequestAsync({
					Url     = SPAWN_WEBHOOK,
					Method  = "POST",
					Headers = { ["Content-Type"] = "application/json" },
					Body    = HttpService:JSONEncode(payload),
				})
				warn("[Liveboard] Response status: " .. tostring(response.StatusCode))

				if response.StatusCode == 429 then
					local retryAfter = 2
					pcall(function()
						retryAfter = tonumber(HttpService:JSONDecode(response.Body).retry_after) or 2
					end)
					task.wait(retryAfter + 0.5)
					error("RATE_LIMITED")
				elseif response.StatusCode >= 400 then
					warn(string.format("[Liveboard] HTTP %d on attempt %d: %s",
						response.StatusCode, attempt, response.Body or ""))
					error("HTTP_ERROR_" .. response.StatusCode)
				end
			end)

			if ok then
				warn("[Liveboard] Webhook sent successfully on attempt " .. attempt)
				return
			end
			warn("[Liveboard] Webhook attempt " .. attempt .. " failed: " .. tostring(err))
			if attempt < MAX_RETRIES then task.wait(attempt * 2) end
		end
		warn("[Liveboard] Webhook failed after", MAX_RETRIES, "attempts")
	end)
end

local function logSpawn(entry: { [string]: any })
	if WEBHOOK_EXCLUDED[entry.BrainrotName] then return end
	if entry.IsLocalServer then return end

	local mutation = entry.Mutation or "None"
	local tier, _  = getMutationTier(mutation)
	local color    = getMutationColor(mutation, SPAWN_COLOR)
	local ts       = isoTimestamp()
	local title    = (tier and tier.titleSpawn) or "🐾  New Animal Spawned"
	local footer   = (tier and tier.label ~= "") and (tier.label .. "  •  Liveboard Tracker") or "Liveboard Tracker"

	sendWebhook({
		embeds = {{
			title       = title,
			description = "A wild **" .. entry.BrainrotName .. "** has appeared in the world!",
			color       = color,
			fields      = {
				{ name = "🦴 Animal",    value = "`" .. entry.BrainrotName .. "`",         inline = true  },
				{ name = "🧬 Mutation",  value = formatMutation(mutation),                  inline = true  },
				{ name = "🕐 Spawned At",value = "📅 " .. ts,                               inline = true  },
				{ name = "🏷️ Spawn ID", value = "```\n" .. tostring(entry.UID) .. "\n```", inline = false },
			},
			footer    = { text = footer },
			timestamp = ts,
		}},
	})
end

local function logClaim(entry: { [string]: any }, userId: number, displayName: string)
	if WEBHOOK_EXCLUDED[entry.BrainrotName] then return end
	if entry.IsLocalServer then return end

	local mutation    = 	entry.Mutation or "None"
	local tier, _     = getMutationTier(mutation)
	local color       = getMutationColor(mutation, CLAIM_COLOR)
	local ts          = isoTimestamp()
	local title       = (tier and tier.titleClaim) or "✅  Animal Claimed"
	local footer      = (tier and tier.label ~= "") and (tier.label .. "  •  Animal Claim Tracker") or "Animal Claim Tracker"
	local profileLink = "[View Profile](https://www.roblox.com/users/" .. tostring(userId) .. "/profile)"

	sendWebhook({
		embeds = {{
			title       = title,
			description = "**" .. displayName .. "** just claimed a **" .. entry.BrainrotName .. "**!",
			color       = color,
			fields      = {
				{ name = "🦴 Animal",    value = "`" .. entry.BrainrotName .. "`",         inline = true  },
				{ name = "🧬 Mutation",  value = formatMutation(mutation),                  inline = true  },
				{ name = "🕐 Claimed At",value = "📅 " .. ts,                               inline = true  },
				{ name = "👤 Player",    value = "**" .. displayName .. "**",               inline = true  },
				{ name = "🔗 Profile",   value = profileLink,                               inline = true  },
				{ name = "🆔 User ID",   value = "`" .. tostring(userId) .. "`",            inline = true  },
				{ name = "🏷️ Spawn ID", value = "```\n" .. tostring(entry.UID) .. "\n```", inline = false },
			},
			footer    = { text = footer },
			timestamp = ts,
		}},
	})
end


local LiveboardService = {}

function LiveboardService:RecordSpawn(uid: string, animalName: string, mutation: string?, isLocalServer: boolean)
	removeExpiredEntries()

	for _, existing in activeEntries do
		if existing.UID == uid then return end
	end

	local now = workspace:GetServerTimeNow()
	local entry = {
		UID              = uid,
		BrainrotName     = animalName,
		Mutation         = mutation,
		IsLocalServer    = isLocalServer,
		IsOriginServer   = true,
		Timestamp        = now,
		DisplayDuration  = DISPLAY_DURATION,
		ExpiresAt        = now + DISPLAY_DURATION,
		OwnerUserId      = nil,
		OwnerDisplayName = nil,
	}

	originatedUIDs[uid] = true
	table.insert(activeEntries, entry)
	NewEntry:FireAllClients(entry)
	logSpawn(entry)
	persistEntry(entry)
end

function LiveboardService:RecordClaim(uid: string, userId: number, displayName: string)
	for _, e in activeEntries do
		if e.UID == uid then
			e.OwnerUserId      = userId
			e.OwnerDisplayName = displayName
			ClaimEntry:FireAllClients(uid, userId, displayName)
			logClaim(e, userId, displayName)
			local remaining = e.ExpiresAt - workspace:GetServerTimeNow()
			persistClaim(uid, userId, displayName, remaining)
			return
		end		
	end
	ClaimEntry:FireAllClients(uid, userId, displayName)
end


GetEntries.OnServerInvoke = function(_player)
	removeExpiredEntries()
	local snapshot = {}
	for _, e in activeEntries do
		table.insert(snapshot, {
			UID              = e.UID,
			BrainrotName     = e.BrainrotName,
			Mutation         = e.Mutation,
			IsLocalServer    = e.IsLocalServer,
			IsOriginServer   = e.IsOriginServer,
			Timestamp        = e.Timestamp,
			DisplayDuration  = e.DisplayDuration,
			OwnerUserId      = e.OwnerUserId,
			OwnerDisplayName = e.OwnerDisplayName,
		})
	end
	return snapshot
end


function LiveboardService:Start()
	if SPAWN_WEBHOOK == "YOUR_WEBHOOK_URL" then
		warn("[Liveboard] Webhook URL is a placeholder — Discord logging disabled.")
	end

	task.spawn(function()
		local loadOk, loadErr = pcall(loadPersistedEntries)
		if not loadOk then
			warn("[Liveboard] MemoryStore restore failed:", loadErr)
		end

		local subOk, subErr = pcall(function()
			MessagingService:SubscribeAsync(LIVEBOARD_TOPIC, function(data)
				if type(data) ~= "table" then return end

				if data.originJobId == game.JobId then return end

				local now = workspace:GetServerTimeNow()
				if data.type == "spawn"
					and type(data.uid) == "string"
					and type(data.animal) == "string"
				then
					removeExpiredEntries()
					for _, existing in activeEntries do
						if existing.UID == data.uid then return end
					end

					local entry = {
						UID              = data.uid,
						BrainrotName     = data.animal,
						Mutation         = data.mutation,
						IsLocalServer    = false,
						IsOriginServer   = false,
						Timestamp        = now,
						DisplayDuration  = DISPLAY_DURATION,
						ExpiresAt        = now + DISPLAY_DURATION,
						OwnerUserId      = nil,
						OwnerDisplayName = nil,
					}
					table.insert(activeEntries, entry)
					NewEntry:FireAllClients(entry)

				elseif data.type == "claim"
					and type(data.uid) == "string"
					and type(data.userId) == "number"
					and type(data.playerName) == "string"
				then
					local found = false
					for _, e in activeEntries do
						if e.UID == data.uid then
							e.OwnerUserId      = data.userId
							e.OwnerDisplayName = data.playerName
							found = true
							break
						end
					end
					if found then
						ClaimEntry:FireAllClients(data.uid, data.userId, data.playerName)
					end
				end
			end)
		end)

		if not subOk then
			warn("[Liveboard] MessagingService subscribe failed:", subErr)
		end
	end)
end

return LiveboardService