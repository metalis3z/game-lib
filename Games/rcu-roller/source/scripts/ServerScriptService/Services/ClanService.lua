--[[
	ClanService — Full clan/guild system with DataStore persistence
	Handles clan creation, membership, ranks, buildings, donations, wheel spins, and weekly rewards.
]]

local Players = game:GetService("Players")
local DataStoreService = game:GetService("DataStoreService")
local TextService = game:GetService("TextService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Knit = require(ReplicatedStorage.Packages.Knit)

local IS_STUDIO = RunService:IsStudio()
local CLAN_STORE_NAME = "Clans"
local MAX_MEMBERS = 20
local CLAN_COST = 1000 -- gems
local SAVE_INTERVAL = 300 -- seconds
local DEBOUNCE_TIME = 3 -- seconds
local TAG_PATTERN = "^%u%u%u%u?%u?%u?$" -- 3-6 uppercase alphanumeric (Lua: %u matches uppercase, extend as needed)
local TAG_PATTERN_FULL = "^[A-Z0-9][A-Z0-9][A-Z0-9][A-Z0-9]?[A-Z0-9]?[A-Z0-9]?$" -- 3-6 uppercase letters/digits

local WHEEL_REWARDS = {
	{ key = "gems_100",    weight = 40 },
	{ key = "gems_500",    weight = 20 },
	{ key = "gems_1000",   weight = 10 },
	{ key = "spin_x1",     weight = 30 },
	{ key = "spin_x3",     weight = 15 },
	{ key = "boost_2x",    weight = 8  },
	{ key = "boost_3x",    weight = 4  },
	{ key = "rare_pet",    weight = 3  },
}

local WHEEL_TOTAL_WEIGHT = 0
for _, r in WHEEL_REWARDS do
	WHEEL_TOTAL_WEIGHT += r.weight
end

------------------------------------------------------------------------
-- Service definition
------------------------------------------------------------------------
local ClanService = Knit.CreateService({
	Name = "ClanService",
	Client = {
		weeklyReward = Knit.CreateSignal(),
	},

	_clanStore    = nil,
	_clanCache    = {}, -- [clanId] = clanData
	_dirty        = {}, -- [clanId] = true when cache needs saving
	_debounces    = {}, -- [player.UserId] = lastActionTime
	_DataService  = nil,
})

------------------------------------------------------------------------
-- Internal helpers
------------------------------------------------------------------------
local function getPlayerCount(clan)
	local count = 0
	for _ in clan.members do
		count += 1
	end
	return count
end

local function isDebounced(self, player)
	local uid = tostring(player.UserId)
	local last = self._debounces[uid] or 0
	if (os.clock() - last) < DEBOUNCE_TIME then
		return true
	end
	self._debounces[uid] = os.clock()
	return false
end

local function markDirty(self, clanId)
	self._dirty[clanId] = true
end

local function weightedRandom()
	local roll = math.random(1, WHEEL_TOTAL_WEIGHT)
	local cumulative = 0
	for _, r in WHEEL_REWARDS do
		cumulative += r.weight
		if roll <= cumulative then
			return r.key
		end
	end
	return WHEEL_REWARDS[1].key
end

local function recalcTotalRebirths(clan)
	local total = 0
	for _, member in clan.members do
		total += (member.rebirths or 0)
	end
	clan.totalRebirths = total
end

------------------------------------------------------------------------
-- DataStore load/save
------------------------------------------------------------------------
function ClanService:_loadClan(clanId)
	if self._clanCache[clanId] then
		return self._clanCache[clanId]
	end

	if IS_STUDIO then
		return nil
	end

	local data
	local ok, err = pcall(function()
		data = self._clanStore:GetAsync(clanId)
	end)

	if not ok then
		warn("[ClanService] Failed to load clan", clanId, ":", err)
		return nil
	end

	if data then
		self._clanCache[clanId] = data
	end

	return data
end

function ClanService:_saveClan(clanId)
	if IS_STUDIO then return end

	local data = self._clanCache[clanId]
	if not data then return end

	local ok, err = pcall(function()
		self._clanStore:SetAsync(clanId, data)
	end)

	if not ok then
		warn("[ClanService] Failed to save clan", clanId, ":", err)
	else
		self._dirty[clanId] = nil
	end
end

function ClanService:_deleteClan(clanId)
	self._clanCache[clanId] = nil
	self._dirty[clanId] = nil

	if IS_STUDIO then return end

	local ok, err = pcall(function()
		self._clanStore:RemoveAsync(clanId)
	end)

	if not ok then
		warn("[ClanService] Failed to delete clan", clanId, ":", err)
	end
end

------------------------------------------------------------------------
-- Player clan helpers
------------------------------------------------------------------------
function ClanService:_getPlayerClan(player)
	local data = self._DataService:GetData(player)
	if not data then return nil end
	local clanId = data.clanId
	if not clanId or clanId == "" then return nil end
	return self._clanCache[clanId], clanId
end

function ClanService:_getPlayerMember(player)
	local clan, clanId = self:_getPlayerClan(player)
	if not clan then return nil, nil, nil end
	local uid = tostring(player.UserId)
	return clan.members[uid], clan, clanId
end

function ClanService:_syncPlayerRebirths(player)
	local member, clan, clanId = self:_getPlayerMember(player)
	if not member or not clan then return end
	local data = self._DataService:GetData(player)
	if not data then return end
	member.rebirths = data.rebirths or 0
	recalcTotalRebirths(clan)
	markDirty(self, clanId)
end

------------------------------------------------------------------------
-- Public server-side API
------------------------------------------------------------------------
function ClanService:GetClanByPlayer(player)
	return self:_getPlayerClan(player)
end

-- Called by external services (e.g. RebirthService) when rebirths change
function ClanService:OnPlayerRebirth(player)
	self:_syncPlayerRebirths(player)
end

-- Fire weekly rewards to all online clan members
function ClanService:FireWeeklyRewards()
	for clanId, clan in self._clanCache do
		for uidStr, member in clan.members do
			local uid = tonumber(uidStr)
			local player = Players:GetPlayerByUserId(uid)
			if player then
				-- Client iterates arg2 as 2D array: for _, row in arg2 do for _, item in row do
				-- Wrap the bonus item inside {{itemData}} so each level of iteration works
				local rewardPayload = {
					{ { id = "weeklyBonus", class = "event", clanId = clanId, tag = clan.tag } },
				}
				self.Client.weeklyReward:Fire(player, rewardPayload)
			end
		end
	end
end

------------------------------------------------------------------------
-- Client: getClanData
------------------------------------------------------------------------
function ClanService.Client:getClanData(player, clanId)
	if not clanId or clanId == "" then return nil end
	return self.Server:_loadClan(clanId)
end

------------------------------------------------------------------------
-- Client: getTopClans
------------------------------------------------------------------------
function ClanService.Client:getTopClans(player)
	local list = {}
	for clanId, clan in self.Server._clanCache do
		table.insert(list, {
			id           = clan.id,
			tag          = clan.tag,
			ownerName    = clan.ownerName,
			description  = clan.description,
			imageId      = clan.imageId,
			totalRebirths = clan.totalRebirths or 0,
			memberCount  = getPlayerCount(clan),
		})
	end
	table.sort(list, function(a, b)
		return (a.totalRebirths or 0) > (b.totalRebirths or 0)
	end)
	-- Return top 100
	local result = {}
	for i = 1, math.min(100, #list) do
		result[i] = list[i]
	end
	return result
end

------------------------------------------------------------------------
-- Client: getMultiClanData
------------------------------------------------------------------------
function ClanService.Client:getMultiClanData(player, clanIdList)
	local result = {}
	for _, clanId in clanIdList do
		result[clanId] = self.Server:_loadClan(clanId)
	end
	return result
end

------------------------------------------------------------------------
-- Client: getTagAvailability
------------------------------------------------------------------------
function ClanService.Client:getTagAvailability(player, tag)
	if type(tag) ~= "string" then return false, nil end
	local upper = tag:upper()

	-- Format check
	if not upper:match(TAG_PATTERN_FULL) then
		return false, nil
	end

	-- Filter check
	local ok, filtered = pcall(function()
		local result = TextService:FilterStringAsync(upper, player.UserId)
		return result:GetNonChatStringForBroadcastAsync()
	end)
	if ok and filtered ~= upper then
		return false, "tagFiltered"
	end

	-- Uniqueness check
	if self.Server._clanCache[upper] then
		return false, nil
	end

	return true, nil
end

------------------------------------------------------------------------
-- Client: createClan
------------------------------------------------------------------------
function ClanService.Client:createClan(player, tag, imageId)
	if self.Server:isDebounced(player) then return "debounce" end

	local playerData = self.Server._DataService:GetData(player)
	if not playerData then return "debounce" end

	-- Already in clan?
	if playerData.clanId and playerData.clanId ~= "" then
		return "alreadyInClan"
	end

	-- Validate tag
	if type(tag) ~= "string" then return "invalidTag" end
	local upper = tag:upper()
	if not upper:match(TAG_PATTERN_FULL) then return "invalidTag" end

	-- Filter check
	local filterOk, filtered = pcall(function()
		local result = TextService:FilterStringAsync(upper, player.UserId)
		return result:GetNonChatStringForBroadcastAsync()
	end)
	if filterOk and filtered ~= upper then return "invalidTag" end

	-- Already exists?
	if self.Server._clanCache[upper] then return "invalidTag" end

	-- Gems check
	if (playerData.gems or 0) < CLAN_COST then
		return "notEnoughGems"
	end

	-- Deduct gems
	local newGems = (playerData.gems or 0) - CLAN_COST
	self.Server._DataService:Set(player, {"gems"}, newGems)

	-- Build clan data
	local uid = tostring(player.UserId)
	local now = os.time()
	local clan = {
		id               = upper,
		tag              = upper,
		ownerId          = player.UserId,
		ownerName        = player.Name,
		description      = "",
		imageId          = imageId or 16987069167,
		rebirthRequirement = 0,
		question1        = "",
		question2        = "",
		members          = {
			[uid] = {
				name        = player.Name,
				rank        = 1,
				joinedAt    = now,
				rebirths    = playerData.rebirths or 0,
				totalDonated = 0,
			},
		},
		invites          = {},
		requests         = {},
		buildings        = {},
		inventory        = {},
		totalRebirths    = playerData.rebirths or 0,
		weeklyBoosts     = {},
		spins            = 0,
		createdAt        = now,
	}

	self.Server._clanCache[upper] = clan
	markDirty(self.Server, upper)
	self.Server._DataService:Set(player, {"clanId"}, upper)

	return "success"
end

------------------------------------------------------------------------
-- Client: updateClan
------------------------------------------------------------------------
function ClanService.Client:updateClan(player, description, imageId, rebirthReq, question1, question2)
	if self.Server:isDebounced(player) then return "debounce" end

	local member, clan, clanId = self.Server:_getPlayerMember(player)
	if not member or not clan then return "notLeader" end
	if member.rank ~= 1 then return "notLeader" end

	-- Filter description and questions
	local function filterText(text)
		if not text or text == "" then return text end
		local ok, result = pcall(function()
			local fr = TextService:FilterStringAsync(text, player.UserId)
			return fr:GetNonChatStringForBroadcastAsync()
		end)
		if not ok then return nil end
		return result
	end

	local filteredDesc  = filterText(description or "")
	local filteredQ1    = filterText(question1 or "")
	local filteredQ2    = filterText(question2 or "")

	if filteredDesc == nil or filteredQ1 == nil or filteredQ2 == nil then
		return "filtered"
	end

	clan.description        = filteredDesc
	clan.imageId            = imageId or clan.imageId
	clan.rebirthRequirement = rebirthReq or 0
	clan.question1          = filteredQ1
	clan.question2          = filteredQ2
	markDirty(self.Server, clanId)

	return "success"
end

------------------------------------------------------------------------
-- Client: requestToJoin
------------------------------------------------------------------------
function ClanService.Client:requestToJoin(player, clanId, answer1, answer2)
	if self.Server:isDebounced(player) then return "debounce" end

	local playerData = self.Server._DataService:GetData(player)
	if not playerData then return "debounce" end
	if playerData.clanId and playerData.clanId ~= "" then return "alreadyInClan" end

	local clan = self.Server._clanCache[clanId]
	if not clan then return "debounce" end

	-- Filter answers
	local function filterText(text)
		if not text or text == "" then return text end
		local ok, result = pcall(function()
			local fr = TextService:FilterStringAsync(text, player.UserId)
			return fr:GetNonChatStringForBroadcastAsync()
		end)
		if not ok then return nil end
		return result
	end

	local fa1 = filterText(answer1 or "")
	local fa2 = filterText(answer2 or "")
	if fa1 == nil or fa2 == nil then return "filtered" end

	local uid = tostring(player.UserId)
	clan.requests[uid] = {
		name    = player.Name,
		answer1 = fa1,
		answer2 = fa2,
		sentAt  = os.time(),
	}
	markDirty(self.Server, clanId)

	return "success"
end

------------------------------------------------------------------------
-- Client: acceptInvite
------------------------------------------------------------------------
function ClanService.Client:acceptInvite(player, clanId)
	if self.Server:isDebounced(player) then return "debounce" end

	local playerData = self.Server._DataService:GetData(player)
	if not playerData then return "debounce" end
	if playerData.clanId and playerData.clanId ~= "" then return "alreadyInClan" end

	local clan = self.Server._clanCache[clanId]
	if not clan then return "inviteNoLongerAvailable" end

	local uid = tostring(player.UserId)
	if not clan.invites[uid] then return "inviteNoLongerAvailable" end
	if getPlayerCount(clan) >= MAX_MEMBERS then return "maxMembers" end

	clan.invites[uid] = nil
	clan.members[uid] = {
		name        = player.Name,
		rank        = 4,
		joinedAt    = os.time(),
		rebirths    = playerData.rebirths or 0,
		totalDonated = 0,
	}
	recalcTotalRebirths(clan)
	markDirty(self.Server, clanId)
	self.Server._DataService:Set(player, {"clanId"}, clanId)

	return "success"
end

------------------------------------------------------------------------
-- Client: declineInvite
------------------------------------------------------------------------
function ClanService.Client:declineInvite(player, clanId)
	local clan = self.Server._clanCache[clanId]
	if clan then
		local uid = tostring(player.UserId)
		if clan.invites[uid] then
			clan.invites[uid] = nil
			markDirty(self.Server, clanId)
		end
	end
	return "success"
end

------------------------------------------------------------------------
-- Client: invitePlayer
------------------------------------------------------------------------
function ClanService.Client:invitePlayer(player, username)
	if self.Server:isDebounced(player) then return "debounce" end

	local member, clan, clanId = self.Server:_getPlayerMember(player)
	if not member or not clan then return "notUnlocked" end
	if member.rank > 2 then return "notUnlocked" end

	if getPlayerCount(clan) >= MAX_MEMBERS then return "maxMembers" end

	-- Find target player
	local target = Players:FindFirstChild(username)
	if not target then return "playerNotFound" end

	local targetUid = tostring(target.UserId)

	-- Already in this clan?
	if clan.members[targetUid] then return "alreadyInClan" end

	-- Check target not already in any clan
	local targetData = self.Server._DataService:GetData(target)
	if targetData and targetData.clanId and targetData.clanId ~= "" then
		return "alreadyInClan"
	end

	-- Already invited?
	if clan.invites[targetUid] then return "alreadyInvited" end

	clan.invites[targetUid] = {
		name   = target.Name,
		sentAt = os.time(),
		sentBy = player.Name,
	}
	markDirty(self.Server, clanId)

	return "success"
end

------------------------------------------------------------------------
-- Client: leaveClan
------------------------------------------------------------------------
function ClanService.Client:leaveClan(player)
	local member, clan, clanId = self.Server:_getPlayerMember(player)
	if not member or not clan then return "success" end
	if member.rank == 1 then return "isLeader" end

	local uid = tostring(player.UserId)
	clan.members[uid] = nil
	recalcTotalRebirths(clan)
	markDirty(self.Server, clanId)
	self.Server._DataService:Set(player, {"clanId"}, "")

	return "success"
end

------------------------------------------------------------------------
-- Client: kickPlayer
------------------------------------------------------------------------
function ClanService.Client:kickPlayer(player, targetUserId)
	if self.Server:isDebounced(player) then return "debounce" end

	local member, clan, clanId = self.Server:_getPlayerMember(player)
	if not member or not clan then return "notAuthorized" end
	if member.rank > 2 then return "notAuthorized" end

	local targetUidStr = tostring(targetUserId)
	local targetMember = clan.members[targetUidStr]
	if not targetMember then return "notAuthorized" end
	-- Cannot kick equal or higher rank
	if targetMember.rank <= member.rank then return "notAuthorized" end

	clan.members[targetUidStr] = nil
	recalcTotalRebirths(clan)
	markDirty(self.Server, clanId)

	-- If target is online, clear their clanId
	local targetPlayer = Players:GetPlayerByUserId(targetUserId)
	if targetPlayer then
		self.Server._DataService:Set(targetPlayer, {"clanId"}, "")
	end

	return "success"
end

------------------------------------------------------------------------
-- Client: updateRank
-- Cycles: 4 → 3 → 2 → 4 (only leader can promote to 2)
------------------------------------------------------------------------
function ClanService.Client:updateRank(player, targetUserId)
	local member, clan, clanId = self.Server:_getPlayerMember(player)
	if not member or not clan then return "notAuthorized", nil end
	if member.rank ~= 1 then return "notAuthorized", nil end

	local targetUidStr = tostring(targetUserId)
	local targetMember = clan.members[targetUidStr]
	if not targetMember then return "notAuthorized", nil end
	if targetMember.rank == 1 then return "notAuthorized", nil end

	-- Cycle: 4 → 3 → 2 → 4
	local current = targetMember.rank
	local newRank
	if current == 4 then
		newRank = 3
	elseif current == 3 then
		newRank = 2
	else -- 2
		newRank = 4
	end

	targetMember.rank = newRank
	markDirty(self.Server, clanId)

	return "success", newRank
end

------------------------------------------------------------------------
-- Client: cancelInvite
------------------------------------------------------------------------
function ClanService.Client:cancelInvite(player, targetUserId)
	if self.Server:isDebounced(player) then return "debounce" end

	local member, clan, clanId = self.Server:_getPlayerMember(player)
	if not member or not clan then return "success" end
	if member.rank > 2 then return "success" end

	local uid = tostring(targetUserId)
	if clan.invites[uid] then
		clan.invites[uid] = nil
		markDirty(self.Server, clanId)
	end

	return "success"
end

------------------------------------------------------------------------
-- Client: acceptRequest
------------------------------------------------------------------------
function ClanService.Client:acceptRequest(player, targetUserId)
	if self.Server:isDebounced(player) then return "debounce" end

	local member, clan, clanId = self.Server:_getPlayerMember(player)
	if not member or not clan then return "notUnlocked" end
	if member.rank > 2 then return "notUnlocked" end

	if getPlayerCount(clan) >= MAX_MEMBERS then return "maxMembers" end

	local targetUidStr = tostring(targetUserId)
	local request = clan.requests[targetUidStr]
	if not request then return "debounce" end

	-- Check target not in another clan
	local targetPlayer = Players:GetPlayerByUserId(targetUserId)
	if targetPlayer then
		local targetData = self.Server._DataService:GetData(targetPlayer)
		if targetData and targetData.clanId and targetData.clanId ~= "" then
			clan.requests[targetUidStr] = nil
			markDirty(self.Server, clanId)
			return "alreadyInClan"
		end
	end

	-- Already in invites?
	if clan.invites[targetUidStr] then return "alreadyInvited" end

	clan.requests[targetUidStr] = nil
	clan.members[targetUidStr] = {
		name        = request.name,
		rank        = 4,
		joinedAt    = os.time(),
		rebirths    = 0,
		totalDonated = 0,
	}

	-- Sync rebirths if player is online
	if targetPlayer then
		local targetData = self.Server._DataService:GetData(targetPlayer)
		if targetData then
			clan.members[targetUidStr].rebirths = targetData.rebirths or 0
			self.Server._DataService:Set(targetPlayer, {"clanId"}, clanId)
		end
	end

	recalcTotalRebirths(clan)
	markDirty(self.Server, clanId)

	return "success"
end

------------------------------------------------------------------------
-- Client: declineRequest
------------------------------------------------------------------------
function ClanService.Client:declineRequest(player, targetUserId)
	local member, clan, clanId = self.Server:_getPlayerMember(player)
	if not member or not clan then return "success" end

	local uid = tostring(targetUserId)
	if clan.requests[uid] then
		clan.requests[uid] = nil
		markDirty(self.Server, clanId)
	end

	return "success"
end

------------------------------------------------------------------------
-- Client: donateItem
------------------------------------------------------------------------
function ClanService.Client:donateItem(player, itemId, amount)
	if self.Server:isDebounced(player) then return "debounce" end

	local member, clan, clanId = self.Server:_getPlayerMember(player)
	if not member or not clan then return "notEnoughItems" end

	local playerData = self.Server._DataService:GetData(player)
	if not playerData then return "debounce" end

	-- We store donateable items in inventory.upgrade (generic approach — itemId is a flat string)
	-- Walk all inventory categories to find the item
	local foundCategory = nil
	local foundCount = 0
	for category, items in playerData.inventory do
		if type(items) == "table" and items[itemId] and items[itemId] > 0 then
			foundCategory = category
			foundCount = items[itemId]
			break
		end
	end

	if not foundCategory then return "notEnoughItems" end
	local donateAmount = math.min(amount or 1, foundCount)
	if donateAmount <= 0 then return "notEnoughItems" end

	-- Deduct from player
	local newPlayerCount = foundCount - donateAmount
	local newPath = {"inventory", foundCategory, itemId}
	self.Server._DataService:Set(player, newPath, newPlayerCount > 0 and newPlayerCount or nil)

	-- Add to clan inventory
	clan.inventory[itemId] = (clan.inventory[itemId] or 0) + donateAmount

	-- Track total donated
	member.totalDonated = (member.totalDonated or 0) + donateAmount
	markDirty(self.Server, clanId)

	return "success"
end

------------------------------------------------------------------------
-- Client: build
------------------------------------------------------------------------
function ClanService.Client:build(player, buildingId)
	if self.Server:isDebounced(player) then return "debounce" end

	local member, clan, clanId = self.Server:_getPlayerMember(player)
	if not member or not clan then return "notAuthorized" end
	if member.rank > 2 then return "notAuthorized" end

	-- Building costs are defined per buildingId — we check clan inventory generically.
	-- Cost key assumed to be the buildingId itself in clan.inventory
	local currentLevel = (clan.buildings[buildingId] or 0)
	local costKey = buildingId .. "_material"
	local costAmount = (currentLevel + 1) * 10 -- 10 items per level, scaled

	if (clan.inventory[costKey] or 0) < costAmount then
		return "notEnoughItems"
	end

	clan.inventory[costKey] = clan.inventory[costKey] - costAmount
	clan.buildings[buildingId] = currentLevel + 1
	markDirty(self.Server, clanId)

	return "success"
end

------------------------------------------------------------------------
-- Client: clanWheelSpin
------------------------------------------------------------------------
function ClanService.Client:clanWheelSpin(player)
	if self.Server:isDebounced(player) then return "debounce", nil end

	local member, clan, clanId = self.Server:_getPlayerMember(player)
	if not member or not clan then return "noSpins", nil end

	if (clan.spins or 0) <= 0 then
		return "noSpins", nil
	end

	clan.spins = clan.spins - 1
	local rewardKey = weightedRandom()
	markDirty(self.Server, clanId)

	return "success", rewardKey
end

------------------------------------------------------------------------
-- Client: filter
------------------------------------------------------------------------
function ClanService.Client:filter(player, text)
	if not text or text == "" then return "" end
	local ok, result = pcall(function()
		local fr = TextService:FilterStringAsync(text, player.UserId)
		return fr:GetNonChatStringForBroadcastAsync()
	end)
	if ok then return result end
	return ""
end

------------------------------------------------------------------------
-- Client: getRequestsData
------------------------------------------------------------------------
function ClanService.Client:getRequestsData(player)
	local member, clan, clanId = self.Server:_getPlayerMember(player)
	if not member or not clan then return {} end
	if member.rank > 2 then return {} end

	local result = {}
	for uid, request in clan.requests do
		result[uid] = {
			name    = request.name,
			answer1 = request.answer1,
			answer2 = request.answer2,
			sentAt  = request.sentAt,
		}
	end
	return result
end

------------------------------------------------------------------------
-- isDebounced (public for Client methods to call via self.Server)
------------------------------------------------------------------------
function ClanService:isDebounced(player)
	return isDebounced(self, player)
end

------------------------------------------------------------------------
-- Player join: load their clan into cache
------------------------------------------------------------------------
function ClanService:_onPlayerAdded(player)
	-- Wait for DataService to load player data
	local playerData = self._DataService:WaitForData(player)
	if not playerData then return end

	local clanId = playerData.clanId
	if not clanId or clanId == "" then return end

	-- Load clan into cache if not already there
	if not self._clanCache[clanId] then
		self:_loadClan(clanId)
	end

	-- Sync rebirths into member record
	local clan = self._clanCache[clanId]
	if clan then
		local uid = tostring(player.UserId)
		local member = clan.members[uid]
		if member then
			member.rebirths = playerData.rebirths or 0
			recalcTotalRebirths(clan)
			markDirty(self, clanId)
		else
			-- Player listed as being in clan but not in members — data inconsistency, clear it
			warn("[ClanService] Player", player.Name, "has clanId", clanId, "but is not in members list — clearing")
			self._DataService:Set(player, {"clanId"}, "")
		end
	end
end

------------------------------------------------------------------------
-- Periodic autosave
------------------------------------------------------------------------
function ClanService:_startAutosave()
	task.spawn(function()
		while true do
			task.wait(SAVE_INTERVAL)
			for clanId, isDirty in self._dirty do
				if isDirty then
					self:_saveClan(clanId)
				end
			end
		end
	end)
end

------------------------------------------------------------------------
-- KnitInit / KnitStart
------------------------------------------------------------------------
function ClanService:KnitInit()
	if not IS_STUDIO then
		self._clanStore = DataStoreService:GetDataStore(CLAN_STORE_NAME)
	end
end

function ClanService:KnitStart()
	self._DataService = Knit.GetService("DataService")

	-- Hook player join
	Players.PlayerAdded:Connect(function(player)
		self:_onPlayerAdded(player)
	end)

	-- Handle players who joined before KnitStart
	for _, player in Players:GetPlayers() do
		task.spawn(function()
			self:_onPlayerAdded(player)
		end)
	end

	-- Player leave: save their clan
	Players.PlayerRemoving:Connect(function(player)
		local _, clanId = self:_getPlayerClan(player)
		if clanId and self._dirty[clanId] then
			self:_saveClan(clanId)
		end
	end)

	-- Start periodic autosave
	self:_startAutosave()

	print("[ClanService] Started")
end

return ClanService
