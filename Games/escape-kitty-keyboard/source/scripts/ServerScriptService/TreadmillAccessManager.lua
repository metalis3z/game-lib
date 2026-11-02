local DataStoreService = game:GetService("DataStoreService")
local permanentStore = DataStoreService:GetDataStore("TreadmillPermanentAccess_v1")

local TreadmillAccessManager = {}

-- Temporary in-memory overrides (reset on server restart)
local accessOverrides = {}

-- Permanent overrides (loaded from DataStore on player join, persists across restarts)
local permanentOverrides = {}

-- ==================== TEMPORARY ACCESS (existing, unchanged) ====================

function TreadmillAccessManager.Grant(userId, treadmillType)
	if not accessOverrides[userId] then
		accessOverrides[userId] = {}
	end
	accessOverrides[userId][treadmillType] = true
end

function TreadmillAccessManager.Revoke(userId, treadmillType)
	if accessOverrides[userId] then
		accessOverrides[userId][treadmillType] = nil
	end
end

function TreadmillAccessManager.RevokeAll(userId)
	accessOverrides[userId] = nil
end

-- ==================== PERMANENT ACCESS (DataStore-backed) ====================

function TreadmillAccessManager.GrantPermanent(userId, treadmillType)
	if not permanentOverrides[userId] then
		permanentOverrides[userId] = {}
	end
	permanentOverrides[userId][treadmillType] = true

	-- Save to DataStore
	local key = "user_" .. userId
	pcall(function()
		permanentStore:SetAsync(key, permanentOverrides[userId])
	end)
end

function TreadmillAccessManager.RevokePermanent(userId, treadmillType)
	if permanentOverrides[userId] then
		permanentOverrides[userId][treadmillType] = nil
	end

	local key = "user_" .. userId
	pcall(function()
		if permanentOverrides[userId] and next(permanentOverrides[userId]) then
			permanentStore:SetAsync(key, permanentOverrides[userId])
		else
			permanentStore:RemoveAsync(key)
		end
	end)
end

function TreadmillAccessManager.RevokeAllPermanent(userId)
	permanentOverrides[userId] = nil

	local key = "user_" .. userId
	pcall(function()
		permanentStore:RemoveAsync(key)
	end)
end

function TreadmillAccessManager.LoadPermanentAccess(userId)
	local key = "user_" .. userId
	local success, data = pcall(function()
		return permanentStore:GetAsync(key)
	end)
	if success and data then
		permanentOverrides[userId] = data
	else
		permanentOverrides[userId] = permanentOverrides[userId] or {}
	end
end

-- ==================== SHARED ACCESS CHECKS ====================

-- HasAccess checks both temporary and permanent overrides
function TreadmillAccessManager.HasAccess(userId, treadmillType)
	local temp = accessOverrides[userId] and accessOverrides[userId][treadmillType] == true or false
	local perm = permanentOverrides[userId] and permanentOverrides[userId][treadmillType] == true or false
	return temp or perm
end

function TreadmillAccessManager.GetAccess(userId)
	local result = {}
	local overrides = accessOverrides[userId] or {}
	for k, v in pairs(overrides) do
		if v then
			result[k] = true
		end
	end
	local perms = permanentOverrides[userId] or {}
	for k, v in pairs(perms) do
		if v then
			result[k] = true
		end
	end
	return result
end

return TreadmillAccessManager