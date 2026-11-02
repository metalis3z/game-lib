--!strict
local DATA_STORE_NAME = "HDAdmin"
local DataStoreService = game:GetService("DataStoreService")
local RunService = game:GetService("RunService")
local DataStores = {}
local _dataStore: DataStore? = nil
local _studioApiBlocked = false
local _studioApiBlockedLogged = false
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local config = modules.Parent.Services.Config
local configSettings = require(config.Settings)
local IsolatedServer = require(modules.IsolatedServer)
local deepCopyTable = require(modules.TableUtil.deepCopyTable)
local _overlay: {[string]: {value: any}} = {}


-- PUBLIC
DataStores.dataStoreName = DATA_STORE_NAME
DataStores.dataGroupName = configSettings.SystemSettings.DataGroupName


-- LOCAL FUNCTIONS
local function isStudioApiError(message: any): boolean
	if typeof(message) ~= "string" then return false end
	return message:find("Studio access to APIs is not allowed", 1, true) ~= nil
		or message:find("Cannot write to DataStore from studio", 1, true) ~= nil
		or message:find("StudioAccessToApisNotAllowed", 1, true) ~= nil
		or message:find("publish this place to the web", 1, true) ~= nil
end

local function markStudioBlockedIfNeeded(message: any)
	if _studioApiBlocked then return end
	if not RunService:IsStudio() then return end
	if not isStudioApiError(message) then return end
	_studioApiBlocked = true
	if not _studioApiBlockedLogged then
		_studioApiBlockedLogged = true
		warn("HD Admin: DataStore API access is disabled in this Studio session. Falling back to defaults. Enable 'Studio Access to API Services' in Game Settings to test against live data")
	end
end

function DataStores.isStudioApiBlocked(): boolean
	return _studioApiBlocked
end

local function copyStoredValue(value: any): any
	if type(value) == "table" then
		return deepCopyTable(value)
	end
	return value
end

local function readRealValue(dataKey: string): (boolean, any)
	if _studioApiBlocked then
		return false, "Studio API access disabled"
	end
	local dataStore, warning = DataStores.getDataStore()
	if not dataStore then
		return false, warning
	end
	local success, result = pcall(function()
		return dataStore:GetAsync(dataKey)
	end)
	if not success then
		markStudioBlockedIfNeeded(result)
	end
	return success, result
end


-- FUNCTIONS
function DataStores.pickPartitionKey(prefix: string, partitionCount: number): string
	return prefix .. tostring(math.random(1, partitionCount))
end

function DataStores.isSessionLockActive(loadedData: any): (boolean, string?)
	if IsolatedServer.isIsolated() then return false, nil end
	if typeof(loadedData) ~= "table" then return false, nil end
	local lock = loadedData._sessionLock
	if lock == nil then return false, nil end
	-- A lock with no timestamp can't be aged, so treat it as expired rather than
	-- locked forever (the load transform used to write locks without one)
	local lastSavedTime = loadedData._lastSavedTime
	if typeof(lastSavedTime) ~= "number" then return false, nil end
	if (os.time() - lastSavedTime) > 150 then return false, nil end
	return true, lock
end

function DataStores.getDataStore(): (DataStore?, string?)
	if not _dataStore then
		local success, result = pcall(function()
			return DataStoreService:GetDataStore(DATA_STORE_NAME)
		end)
		if typeof(result) == "string" then
			return nil, result
		end
		if not success then
			return nil, "Experience must be published to access DataStores"
		end
		_dataStore = result
	end
	return _dataStore, nil
end

function DataStores.getDataKey(storeName: string, key: string): string
	local store = script:FindFirstChild(storeName)
	if not store then
		error("Invalid data store name: " .. storeName)
	end
	local Store = require(store) :: any
	local dataKeyFormatter = Store.dataKeyFormatter
	local dataKey = dataKeyFormatter:format(key) :: string
	return dataKey
end

function DataStores.getAsync(storeName: string, key: string, options: DataStoreGetOptions?): (boolean, string? | any)
	local dataKey = DataStores.getDataKey(storeName, key)
	if IsolatedServer.isIsolated() then
		local entry = _overlay[dataKey]
		if entry then
			return true, copyStoredValue(entry.value)
		end
		return readRealValue(dataKey)
	end
	if _studioApiBlocked then
		return false, "Studio API access disabled"
	end
	local dataStore, warning = DataStores.getDataStore()
	if not dataStore then
		return false, warning
	end
	local success, result = pcall(function()
		return dataStore:GetAsync(dataKey, options)
	end)
	if not success then
		markStudioBlockedIfNeeded(result)
	end
	return success, result
end

function DataStores.setAsync(storeName: string, key: string, value: any, gdprUserIds: {number}, options: DataStoreSetOptions?): (boolean, string? | any)
	local dataKey = DataStores.getDataKey(storeName, key)
	if IsolatedServer.isIsolated() then
		_overlay[dataKey] = {value = copyStoredValue(value)}
		return true, nil
	end
	if _studioApiBlocked then
		return false, "Studio API access disabled"
	end
	local dataStore, warning = DataStores.getDataStore()
	if not dataStore then
		return false, warning
	end
	local success, result = pcall(function()
		return dataStore:SetAsync(dataKey, value, gdprUserIds, options)
	end)
	if not success then
		markStudioBlockedIfNeeded(result)
	end
	return success, result
end

function DataStores.updateAsync(storeName: string, key: string, transformFunction): (boolean, string? | any)
	if IsolatedServer.isIsolated() then
		local dataKey = DataStores.getDataKey(storeName, key)
		local entry = _overlay[dataKey]
		local current: any = nil
		if entry then
			current = copyStoredValue(entry.value)
		elseif _studioApiBlocked then
			current = nil
		else
			local readOk, readResult = readRealValue(dataKey)
			if not readOk then
				-- Failing like the real path does lets callers keep their retry loops,
				-- so a throttled read never silently loads someone a fresh profile
				return false, readResult
			end
			current = readResult
		end
		local transformOk, transformed = pcall(transformFunction, current)
		if not transformOk then
			return false, transformed
		end
		if transformed ~= nil then
			_overlay[dataKey] = {value = copyStoredValue(transformed)}
		end
		return true, transformed
	end
	return DataStores._updateRealAsync(storeName, key, transformFunction)
end

function DataStores._updateRealAsync(storeName: string, key: string, transformFunction): (boolean, string? | any)
	if _studioApiBlocked then
		return false, "Studio API access disabled"
	end
	local dataStore, warning = DataStores.getDataStore()
	if not dataStore then
		return false, warning
	end
	local dataKey = DataStores.getDataKey(storeName, key)
	local success, result = pcall(function()
		return dataStore:UpdateAsync(dataKey, transformFunction)
	end)
	if not success then
		markStudioBlockedIfNeeded(result)
	end
	return success, result
end

function DataStores._clearIsolatedOverlayForTesting()
	table.clear(_overlay)
end


-- SETUP
-- GameId is 0 if the place is published, so we set to defaults instead of retrying DataStore calls
-- that will never load
if RunService:IsStudio() and game.GameId == 0 then
	_studioApiBlocked = true
	_studioApiBlockedLogged = true
	warn("HD Admin: this place isn't published, so data can't load or save. Running on default settings. Publish the place to test against live data")
end


return DataStores