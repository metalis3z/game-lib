-- --This file Was Made By FaypleStudios 
--Our Discord Server , https://discord.gg/Cv4J9mEUfj
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Net = require(ReplicatedStorage.Packages.Net)
local Signal = require(ReplicatedStorage.Packages.Signal)

local RequestRemoteEvent = Net:RemoteEvent("AssetStreamService/Request")
local AckRemoteEvent = Net:RemoteEvent("AssetStreamService/Ack")
local LocalPlayer = Players.LocalPlayer

local AssetStreamService = {}

local FLUSH_DELAY = 0.05
local RETRY_DELAY = 2
local MAX_RETRIES = 20
local DESCENDANT_WAIT_TIMEOUT = 5
local DESCENDANT_CHECK_INTERVAL = 0.05

local assetCache = {}
local onAssetCachedSignal = Signal.new()
local assetCacheFolder = nil

AssetStreamService.onAssetCached = onAssetCachedSignal

local pendingRequests = {}
local requestBatch = {}
local ackBatch = {}
local isFlushScheduled = false
local isRetryLoopRunning = false
local containerReady = false

local function flushBatches()
	isFlushScheduled = false

	for category, keys in pairs(requestBatch) do
		if #keys > 0 then
			RequestRemoteEvent:FireServer(category, keys)
		end
	end

	for category, keys in pairs(ackBatch) do
		if #keys > 0 then
			AckRemoteEvent:FireServer(category, keys)
		end
	end

	table.clear(requestBatch)
	table.clear(ackBatch)
end

local function scheduleBatchFlush()
	if not isFlushScheduled then
		isFlushScheduled = true
		task.delay(FLUSH_DELAY, flushBatches)
	end
end

local function requestAsset(category, key)
	local categoryCache = assetCache[category]
	if categoryCache and categoryCache[key] then
		return
	end

	local requestId = category .. "\1" .. key
	if pendingRequests[requestId] then
		return
	end

	pendingRequests[requestId] = {
		tries = 0,
		category = category,
		key = key,
		lastRequest = os.clock()
	}

	local batch = requestBatch[category]
	if not batch then
		batch = {}
		requestBatch[category] = batch
	end
	table.insert(batch, key)

	scheduleBatchFlush()

	if not isRetryLoopRunning then
		isRetryLoopRunning = true
		task.spawn(function()
			while next(pendingRequests) ~= nil do
				task.wait(RETRY_DELAY)

				local now = os.clock()
				for reqId, request in pairs(pendingRequests) do
					if now - request.lastRequest >= RETRY_DELAY then
						request.tries = request.tries + 1

						if request.tries > MAX_RETRIES then
							warn(string.format("[AssetStreamService] Gave up on %s/%s after %d tries", 
								request.category, request.key, request.tries))
							pendingRequests[reqId] = nil
						else
							local retryBatch = requestBatch[request.category]
							if not retryBatch then
								retryBatch = {}
								requestBatch[request.category] = retryBatch
							end
							table.insert(retryBatch, request.key)
							request.lastRequest = now

							scheduleBatchFlush()
						end
					end
				end
			end

			isRetryLoopRunning = false
		end)
	end
end

local function handleAssetReceived(asset)
	local category = asset:GetAttribute("__cat")
	local key = asset:GetAttribute("__key")

	if type(category) ~= "string" or type(key) ~= "string" then
		warn("[AssetStreamService] Received asset with invalid metadata")
		return
	end

	local categoryCache = assetCache[category]
	if not categoryCache then
		categoryCache = {}
		assetCache[category] = categoryCache
	end

	if categoryCache[key] then
		return
	end

	local expectedCount = asset:GetAttribute("__count")
	if type(expectedCount) == "number" and expectedCount > 0 then
		local timeout = os.clock() + DESCENDANT_WAIT_TIMEOUT
		local currentCount = #asset:GetDescendants()

		while currentCount < expectedCount do
			if os.clock() > timeout then
				warn(string.format("[AssetStreamService] Timeout waiting for descendants on %s/%s (got %d/%d)", 
					category, key, currentCount, expectedCount))
				break
			end

			if not asset.Parent then
				warn(string.format("[AssetStreamService] Asset %s/%s removed before fully loaded", category, key))
				return
			end

			task.wait(DESCENDANT_CHECK_INTERVAL)
			currentCount = #asset:GetDescendants()
		end
	end

	if categoryCache[key] then
		return
	end

	local clonedAsset = asset:Clone()
	clonedAsset:SetAttribute("__cat", nil)
	clonedAsset:SetAttribute("__key", nil)
	clonedAsset:SetAttribute("__count", nil)
	clonedAsset.Parent = assetCacheFolder

	categoryCache[key] = clonedAsset

	pendingRequests[category .. "\1" .. key] = nil

	onAssetCachedSignal:Fire(category, key)

	local batch = ackBatch[category]
	if not batch then
		batch = {}
		ackBatch[category] = batch
	end
	table.insert(batch, key)

	scheduleBatchFlush()
end

local function setupAssetContainer(container)
	for _, child in ipairs(container:GetChildren()) do
		if child:GetAttribute("__cat") ~= nil then
			task.spawn(handleAssetReceived, child)
		end
	end

	container.ChildAdded:Connect(function(child)
		if child:GetAttribute("__cat") ~= nil then
			task.spawn(handleAssetReceived, child)
		end
	end)

	containerReady = true
end

function AssetStreamService.requestAssets(category, keys)
	for _, key in ipairs(keys) do
		requestAsset(category, key)
	end
end

function AssetStreamService.waitForAsset(category, key, timeout)
	local categoryCache = assetCache[category]
	if not categoryCache then
		categoryCache = {}
		assetCache[category] = categoryCache
	end

	if categoryCache[key] then
		return categoryCache[key]
	end

	requestAsset(category, key)

	local deadline = os.clock() + (timeout or 30)
	while os.clock() < deadline do
		if categoryCache[key] then
			return categoryCache[key]
		end
		task.wait(0.1)
	end

	warn(string.format("[AssetStreamService] Timeout waiting for asset %s/%s", category, key))
	return categoryCache[key]
end

function AssetStreamService.getAsset(category, key)
	local categoryCache = assetCache[category]
	return categoryCache and categoryCache[key]
end

function AssetStreamService.Load()
	task.spawn(function()
		local playerGui = LocalPlayer:WaitForChild("PlayerGui", 10)
		if not playerGui then
			warn("[AssetStreamService] Failed to find PlayerGui")
			return
		end

		local assetStreamGui = playerGui:WaitForChild("__AssetStream", 60)
		if not assetStreamGui then
			warn("[AssetStreamService] Failed to find __AssetStream GUI")
			return
		end

		assetCacheFolder = Instance.new("Folder")
		assetCacheFolder.Name = "AssetCache"
		assetCacheFolder.Parent = script

		setupAssetContainer(assetStreamGui)
	end)
end

return AssetStreamService