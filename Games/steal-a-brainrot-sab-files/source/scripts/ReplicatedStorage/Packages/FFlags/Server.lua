local MemoryStoreService = game:GetService("MemoryStoreService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local DataStoreService = game:GetService("DataStoreService")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local Replion = require(ReplicatedStorage.Packages.Replion)
local Signal = require(ReplicatedStorage.Packages.Signal)

require(script.Parent.Types)

local Environments = require(script.Parent.Environments)
local Overrides = require(script.Parent.Overrides)
local MessagingService = require(game:GetService("ServerScriptService").Services.MessagingService)

local MEMORY_STORE_COUNT = 100
local DATA_STORE_COUNT = 25
local random = Random.new()
local currentEnvironment = nil
local replionInstance = nil

local FFlags = {
	_loaded = false,
	_loadedSignal = Signal.new(),
	_updatedSignal = Signal.new()
}

local function waitForBudget(requestType, timeout)
	local maxWait = timeout or 10
	local startTime = os.clock()
	local currentTime = startTime

	while DataStoreService:GetRequestBudgetForRequestType(requestType) < 1 and maxWait > currentTime - startTime do
		task.wait()
		currentTime = os.clock()
	end

	return maxWait > currentTime - startTime
end

local DATASTORE_RETRY_CODES = {
	301, 302, 303, 304, 305, 306,
	500, 501, 502, 503, 504, 505
}

local function dsRetry(callback)
	local lastError = nil

	for attempt = 1, 6 do
		local result = table.pack(pcall(callback))

		if result[1] then
			return table.unpack(result, 2, result.n)
		end

		lastError = result[2]

		local errorCode = tonumber(string.match(lastError, "^(%d+)"))

		if errorCode and table.find(DATASTORE_RETRY_CODES, errorCode) then
			task.wait(2 ^ (attempt - 1))
		else
			error(lastError)
		end
	end

	if lastError then
		error(`Too many retries.\n{lastError}`)
	end
end

local HASHMAP_RETRY_ERRORS = {
	"TotalRequestsOverLimit",
	"InternalError",
	"RequestThrottled",
	"PartitionRequestsOverLimit",
	"Throttled",
	"Timeout"
}

local function hashMapRetry(callback)
	local errorMessage = nil

	for attempt = 1, 6 do
		local result = table.pack(pcall(callback))

		if result[1] then
			return table.unpack(result, 2, result.n)
		end

		errorMessage = tostring(result[2])

		local shouldRetry = false

		for _, errorName in HASHMAP_RETRY_ERRORS do
			if string.find(errorMessage, errorName, 1, true) then
				shouldRetry = true
				break
			end
		end

		if shouldRetry then
			task.wait(2 ^ (attempt - 1))
		else
			error(errorMessage)
		end
	end

	if errorMessage then
		error(`Too many retries.\n{errorMessage}`)
	end
end

function FFlags.IsLoaded(self)
	return self._loaded
end

function FFlags.OnLoad(self, callback)
	return self._loadedSignal:Connect(callback)
end

function FFlags.OnUpdate(self, callback)
	return self._updatedSignal:Connect(callback)
end

function FFlags.OnChange(_, key, callback)
	return replionInstance:OnChange({"Values", key}, callback)
end

function FFlags.Get(self, key, defaultValue)
	if not self:IsLoaded() then
		self._loadedSignal:Wait()
	end

	local value = replionInstance:Get({"Values", key})

	if value == nil then
		return defaultValue
	end

	return value
end

function FFlags.GetInstant(_, key, defaultValue)
	local value = replionInstance:Get({"Values", key})

	if value == nil then
		return defaultValue
	end

	return value
end

function FFlags.Set(self, key, value, environment)
	if environment == currentEnvironment or (environment == "all" or environment == "local") then
		replionInstance:Set({"Values", key}, value)
		replionInstance:Set("LastChange", workspace:GetServerTimeNow())
	end

	if environment == "local" then
		if not Overrides[currentEnvironment] then
			Overrides[currentEnvironment] = {}
		end

		Overrides[currentEnvironment][key] = value

		return true
	end

	if not self:GetInstant("FFlagUpdateMessageDisabled", false) then
		local success, result = pcall(function()
			return MessagingService:PublishAsync("FFlagUpdate", {
				Key = key,
				Value = value,
				Environment = environment
			})
		end)

		if not success then
			warn(`Failed to send message for FFlag update: {result}`)
		end
	end

	local function transformData(data)
		local unixTimestamp = DateTime.now().UnixTimestamp
		local processedData = if not data or (typeof(data) ~= "table" or typeof(data.Values) ~= "table") then {
			Values = {},
			LastUpdate = unixTimestamp
		} else data

		if value == nil then
			for i = #processedData.Values, 1, -1 do
				local entry = processedData.Values[i]
				local entryKey = entry[1]
				local entryEnvironment = entry[3]

				if entryKey == key and entryEnvironment == environment then
					table.remove(processedData.Values, i)
					break
				end
			end

			processedData.LastUpdate = unixTimestamp

			return processedData
		end

		local found = false

		for _, entry in processedData.Values do
			local entryKey = entry[1]
			local entryEnvironment = entry[3]

			if entryKey == key and entryEnvironment == environment then
				found = true
				entry[2] = value

				if environment == nil then
					table.remove(entry, 3)
				else
					entry[3] = environment
				end
			end
		end

		if not found then
			local newEntry = {key, value}

			if environment ~= nil then
				table.insert(newEntry, environment)
			end

			table.insert(processedData.Values, newEntry)
		end

		processedData.LastUpdate = DateTime.now().UnixTimestamp

		return processedData
	end

	local taskQueue = {}
	local runningTasks = 0
	local currentThread = coroutine.running()
	local isComplete = false

	local function runNext()
		while runningTasks < 10 and #taskQueue > 0 do
			local currentTask = assert(table.remove(taskQueue, 1))

			runningTasks += 1
			task.spawn(function()
				local success, result = pcall(currentTask)

				runningTasks -= 1

				if not success then
					warn("Queue task failed:", result)
				end

				runNext()

				if #taskQueue == 0 and runningTasks == 0 then
					isComplete = true

					if coroutine.status(currentThread) == "suspended" then
						task.spawn(currentThread)
					end
				end
			end)
		end
	end

	for i = 1, MEMORY_STORE_COUNT do
		table.insert(taskQueue, function()
			local success, result = pcall(hashMapRetry, function()
				return MemoryStoreService:GetHashMap(`FFlags-{i}`):UpdateAsync("FFlags", transformData, 3888000)
			end)

			if not success then
				warn(`Failed to update HashMap FFlags-{i}/FFlags: {result}`)
			end
		end)
		runNext()
	end

	if not isComplete then
		coroutine.yield()
	end

	isComplete = false
	table.clear(taskQueue)
	runningTasks = 0

	for i = 1, DATA_STORE_COUNT do
		table.insert(taskQueue, function()
			local success, result = pcall(dsRetry, function()
				return DataStoreService:GetDataStore(`FFlags-{i}`):UpdateAsync("FFlags", transformData)
			end)

			if not success then
				warn(`Failed to update DataStore FFlags-{i}/FFlags: {result}`)
			end
		end)
		runNext()
	end

	if not isComplete then
		coroutine.yield()
	end

	return true
end

function FFlags._loadMemoryStore(_, index)
	local selectedIndex = index or random:NextInteger(1, MEMORY_STORE_COUNT)
	local success, hashMap = pcall(function()
		return MemoryStoreService:GetHashMap(`FFlags-{selectedIndex}`)
	end)

	if not success then
		warn(`MemoryStoreService:GetHashMap() failed on 'FFlags-{selectedIndex}': {hashMap}`)
		return false
	end

	local getSuccess, data = pcall(function()
		return hashMap:GetAsync("FFlags")
	end)

	if not getSuccess then
		warn(`Failed to load HashMap FFlags-{selectedIndex}/FFlags: {data}`)
		return false
	end

	if typeof(data) ~= "table" or typeof(data.Values) ~= "table" then
		warn(`Invalid data format in HashMap FFlags-{selectedIndex}/FFlags: {data}`)
		return false
	end

	return true, data
end

function FFlags._loadDataStore(_, index)
	local selectedIndex = index or random:NextInteger(1, DATA_STORE_COUNT)
	local success, dataStore = pcall(function()
		return DataStoreService:GetDataStore(`FFlags-{selectedIndex}`)
	end)

	if not success then
		warn(`DataStoreService:GetDataStore() failed on 'FFlags-{selectedIndex}': {dataStore}`)
		return false
	end

	local options = Instance.new("DataStoreGetOptions")
	options.UseCache = false

	if not waitForBudget(Enum.DataStoreRequestType.GetAsync) then
		warn("No DataStore:GetAsync() request budget available")
		return false
	end

	local getSuccess, data = pcall(function()
		return dataStore:GetAsync("FFlags", options)
	end)

	if not getSuccess then
		warn(`Failed to load DataStore FFlags-{selectedIndex}/FFlags: {data}`)
		return false
	end

	if typeof(data) ~= "table" or typeof(data.Values) ~= "table" then
		warn(`Invalid data format in DataStore FFlags-{selectedIndex}/FFlags: {data}`)
		data = {
			LastUpdate = 0,
			Values = {}
		}
	end

	return true, data
end

function FFlags.Load(self)
	local loadSuccess, loadedData

	if RunService:IsStudio() then
		loadSuccess, loadedData = self:_loadDataStore()
	else
		loadSuccess, loadedData = self:_loadMemoryStore()
	end

	if not loadSuccess then
		local retryCount = 0

		while retryCount < 3 and not loadSuccess do
			warn(`Failed to load FFlags {not RunService:IsStudio() and "MemoryStore HashMap" or "DataStore"}, retrying...`)
			retryCount += 1
			task.wait(retryCount * 1)
			loadSuccess, loadedData = self:_loadMemoryStore()
		end

		if not loadSuccess then
			warn("All attempts to load FFlags MemoryStore HashMaps failed, loading DataStore instead")
			loadSuccess, loadedData = self:_loadDataStore()
		end
	end

	if not loadSuccess or not loadedData then
		warn("Failed to load FFlags: both MemoryStore and DataStore requests failed!")
		return false
	end

	local processedValues = {}

	for _, entry in loadedData.Values do
		local entryKey = entry[1]
		local entryValue = entry[2]
		local entryEnvironment = entry[3] or "all"

		if entryKey and (entryEnvironment ~= "all" or not processedValues[entryKey]) and (entryEnvironment == currentEnvironment or entryEnvironment == "all") then
			processedValues[entryKey] = entryValue
		end
	end

	for existingKey, _ in replionInstance.Data.Values do
		if processedValues[existingKey] == nil then
			processedValues[existingKey] = Replion.None
		end
	end

	if Overrides[currentEnvironment] then
		for overrideKey, overrideValue in Overrides[currentEnvironment] do
			processedValues[overrideKey] = overrideValue
		end
	end

	local serverTime = workspace:GetServerTimeNow()

	replionInstance:Update({
		Loaded = true,
		LastUpdate = serverTime,
		LastChange = serverTime,
		Values = processedValues
	})

	if not self._loaded then
		self._loaded = true
		self._loadedSignal:Fire(replionInstance.Data)
	end

	self._updatedSignal:Fire(replionInstance.Data)

	return true
end

function FFlags.Start(self)
	for environmentName, environmentData in Environments do
		if environmentData.UniverseIds and table.find(environmentData.UniverseIds, game.GameId) then
			currentEnvironment = if not RunService:IsStudio() or not environmentData.StudioEnvironment
				then environmentName
				else environmentData.StudioEnvironment
			break
		end

		if not environmentData.UniverseIds or #environmentData.UniverseIds == 0 and not currentEnvironment then
			currentEnvironment = environmentName
		end
	end

	task.spawn(function()
		MessagingService:SubscribeAsync("FFlagUpdate", function(payload)
			if typeof(payload) ~= "table" or not payload.Key then
				warn(`Invalid FFlagUpdate payload:`, payload)
				return
			end

			print(`FFlag update received - updating: {payload.Key} to`, payload.Value, `({typeof(payload.Value)})`)

			if payload.Key and (
				payload.Environment == nil
					or payload.Environment == currentEnvironment
					or payload.Environment == "all"
				) then
				replionInstance:Set({"Values", payload.Key}, payload.Value)
				replionInstance:Set("LastChange", workspace:GetServerTimeNow())
				self._updatedSignal:Fire(replionInstance.Data)
			end
		end)
	end)

	local nextUpdateTime = 0

	while true do
		local serverTime = workspace:GetServerTimeNow()

		if nextUpdateTime < serverTime then
			nextUpdateTime = serverTime + 600 * random:NextNumber(0.7, 1.3)
			self:Load()
		end

		task.wait(1)
	end
end

replionInstance = Replion.Server.new({
	Channel = "FFlags",
	ReplicateTo = "All",
	Data = {
		Loaded = false,
		LastUpdate = 0,
		LastChange = 0,
		Values = {}
	}
})

task.spawn(FFlags.Start, FFlags)

return FFlags