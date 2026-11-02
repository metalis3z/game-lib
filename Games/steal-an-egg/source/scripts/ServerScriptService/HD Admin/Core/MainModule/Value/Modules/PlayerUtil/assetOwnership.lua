--!strict

--[[

	This helps answer the question: "Does userId own assetId?" and works
	whether the user is in this server or not
	

--]]


-- CONFIG
local CACHE_TTL = 60
local MAX_ENTRIES = 200


-- LOCAL
local Players = game:GetService("Players")
local MarketplaceService = game:GetService("MarketplaceService")
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local Serializer = require(modules.Serializer)
local DataStores = require(modules.DataStores)
local User = require(modules.Objects.User)
local AssetOwnership = {}
local sessionCache: {[string]: {owned: boolean, fetchedAt: number}} = {}


-- LOCAL FUNCTIONS
local function cacheKey(userId: number, assetId: number): string
	return string.format("%d_%d", userId, assetId)
end

local function readCache(userId: number, assetId: number): boolean?
	local key = cacheKey(userId, assetId)
	local entry = sessionCache[key]
	if not entry then return nil end
	if os.clock() - entry.fetchedAt > CACHE_TTL then
		sessionCache[key] = nil
		return nil
	end
	return entry.owned
end

local function writeCache(userId: number, assetId: number, owned: boolean)
	sessionCache[cacheKey(userId, assetId)] = {owned = owned, fetchedAt = os.clock()}
end

local function decodeBlob(raw: any): any?
	if typeof(raw) == "string" then
		raw = Serializer.decompress(raw)
	end
	if typeof(raw) ~= "table" then return nil end
	if raw._isSerialized == true then
		raw._isSerialized = nil
		raw = Serializer.deserialize(raw)
	end
	return raw
end

local function writeToOnlinePlayer(player: Player, assetIdStr: string, owned: boolean)
	local user: any = User.getUser(player)
	if not user or not user.perm then return end
	local existing = user.perm:get("AssetOwnership")
	if typeof(existing) ~= "table" then existing = {} end
	if not existing[assetIdStr] then
		local count = 0
		for _ in existing do count += 1 end
		if count >= MAX_ENTRIES then
			local oldestKey: string? = nil
			local oldestSavedAt = math.huge
			for existingAssetIdStr, existingEntry in existing do
				local saved = if typeof(existingEntry) == "table" then (existingEntry :: any).savedAt else nil
				if typeof(saved) == "number" and saved < oldestSavedAt then
					oldestSavedAt = saved
					oldestKey = existingAssetIdStr
				end
			end
			if oldestKey then
				user.perm:set("AssetOwnership", oldestKey, nil)
			end
		end
	end
	user.perm:set("AssetOwnership", assetIdStr, {owned = owned, savedAt = os.time()})
end


-- FUNCTIONS
function AssetOwnership.check(userId: number, assetId: number): boolean
	if typeof(userId) ~= "number" or userId <= 0 then return false end
	if typeof(assetId) ~= "number" or assetId <= 0 then return false end

	local cached = readCache(userId, assetId)
	if cached ~= nil then return cached end

	local assetIdStr = tostring(assetId)

	local player = Players:GetPlayerByUserId(userId)
	if player then
		local ok, owned = pcall(MarketplaceService.PlayerOwnsAsset, MarketplaceService, player, assetId)
		local result = ok and owned == true
		writeCache(userId, assetId, result)
		if ok then
			writeToOnlinePlayer(player, assetIdStr, result)
		end
		return result
	end

	local ok, raw = DataStores.getAsync("PlayerStore", tostring(userId))
	if not ok then
		writeCache(userId, assetId, false)
		return false
	end
	local blob = decodeBlob(raw)
	local perm = if typeof(blob) == "table" then (blob :: any).perm else nil
	local assetOwnership = if typeof(perm) == "table" then (perm :: any).AssetOwnership else nil
	local entry = if typeof(assetOwnership) == "table" then (assetOwnership :: any)[assetIdStr] else nil
	local owned = typeof(entry) == "table" and (entry :: any).owned == true
	writeCache(userId, assetId, owned)
	return owned
end

function AssetOwnership.record(player: Player, assetId: number, owned: boolean)
	if typeof(player) ~= "Instance" or not player:IsA("Player") then return end
	if typeof(assetId) ~= "number" or assetId <= 0 then return end
	writeToOnlinePlayer(player, tostring(assetId), owned)
	writeCache(player.UserId, assetId, owned)
end


return AssetOwnership

