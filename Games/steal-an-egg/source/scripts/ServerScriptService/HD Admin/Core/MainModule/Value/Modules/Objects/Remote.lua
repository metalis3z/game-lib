--!strict
-- LOCAL
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local createConnection = require(modules.AssetUtil.createConnection)
local Janitor = require(modules.Objects.Janitor)
local Serializer = require(modules.Serializer)
local Remote = {}
local remotesContainerSaved = nil
local remotes = {}
Remote.__index = Remote


-- RATE LIMITING
local DEFAULT_INTENSITY: RateLimitIntensity = "Medium"
local RATE_LIMIT_PRESETS = {
	None = nil, -- no rate limiting
	Low = { capacity = 60, refillRate = 10 },
	Medium = { capacity = 20, refillRate = 6 },
	High = { capacity = 8, refillRate = 2 },
	Once = { capacity = 1, refillRate = 0 },
}

type RateLimitIntensity = "None" | "Low" | "Medium" | "High" | "Once"

type Bucket = {
	tokens: number,
	lastRefill: number,
}
local function consumeToken(bucket: Bucket, preset: { capacity: number, refillRate: number }): boolean
	local now = os.clock()
	local elapsed = now - bucket.lastRefill
	bucket.lastRefill = now
	bucket.tokens = math.min(preset.capacity, bucket.tokens + elapsed * preset.refillRate)
	-- Try to consume
	if bucket.tokens >= 1 then
		bucket.tokens -= 1
		return true
	end
	return false
end

local playerRemovingConnected = false
local function ensurePlayerRemovingCleanup()
	if playerRemovingConnected then return end
	playerRemovingConnected = true
	Players.PlayerRemoving:Connect(function(player: Player)
		local userId = player.UserId
		for _, remote in remotes do
			if remote._buckets then
				remote._buckets[userId] = nil
			end
			if remote._rateLimitWarned then
				remote._rateLimitWarned[userId] = nil
			end
		end
	end)
end

-- Check rate limit for a player on this remote. Returns true if allowed
local function checkRateLimit(self: any, player: Player): boolean
	local preset = RATE_LIMIT_PRESETS[self._rateLimitIntensity]
	if not preset then
		return true
	end
	local userId = player.UserId
	local buckets = self._buckets
	if not buckets then
		buckets = {}
		self._buckets = buckets
	end
	local bucket = buckets[userId]
	if not bucket then
		bucket = { tokens = preset.capacity, lastRefill = os.clock() }
		buckets[userId] = bucket
	end
	if consumeToken(bucket, preset) then
		return true
	end
	-- Rate limited, warn once per player per remote
	local warned = self._rateLimitWarned
	if not warned then
		warned = {}
		self._rateLimitWarned = warned
	end
	if not warned[userId] then
		warned[userId] = true
	end
	return false
end


-- CONSTRUCTOR
function Remote.new(uniqueName: string, remoteType: RemoteType, rateLimitIntensity: RateLimitIntensity?)

	-- Create remote instance if on server (else wait for it on client behind scenes)
	local janitor = Janitor.new()
	local remoteInstanceType = "RemoteEvent"
	local remoteInstance = nil

	-- Define properties
	local self = {
		janitor = janitor,
		uniqueName = uniqueName,
		permitInvokeCallback = true,
		remoteInstance = nil :: Instance?,
		isActive = true,
		_rateLimitIntensity = rateLimitIntensity or DEFAULT_INTENSITY,
		_buckets = nil :: { [number]: Bucket }?,
		_rateLimitWarned = nil :: { [number]: boolean }?,
	}
	setmetatable(self, Remote)
	
	-- We create the remote instance on the server if it hasn't been created before
	if RunService:IsServer() then
		if remoteType == "Function" then
			remoteInstanceType = "RemoteFunction"
		elseif remoteType ~= "Event" and remoteType ~= nil then
			error("Invalid remoteType")
		end
		local remotesContainer = self:_getContainer() :: any
		if remotesContainer then
			if remotesContainer:FindFirstChild(uniqueName) then
				error(`Remote with name '{uniqueName}' already exists`)
			end
			remoteInstance = janitor:add(Instance.new(remoteInstanceType))
			remoteInstance.Name = uniqueName
			remoteInstance.Parent = remotesContainer
			self.remoteInstance = remoteInstance
		end
	end

	-- Register
	remotes[uniqueName] = self
	janitor:add(function()
		remotes[uniqueName] = nil
	end)

	if RunService:IsServer() then
		ensurePlayerRemovingCleanup()
	end

	
	return self
end

function Remote.get(uniqueName: string)
	-- The client alternative for .new
	-- It's preferable to do this on the client to account for server and client remotes
	-- evolving differently in the future
	-- The remoteType is ignored on the client, so we just fill it in with "Event"
	-- to pass type checking
	return Remote.new(uniqueName, "Event")
end

function Remote.find(existingRemoteName: string)
	return remotes[existingRemoteName]
end


-- CLASS
export type Class = typeof(Remote.new(...))
export type RemoteType = "Event" | "Function"
export type Intensity = RateLimitIntensity
type Disconnect = createConnection.Disconnect


-- METHODS
function Remote._getContainer(self: Class): Instance?
	if remotesContainerSaved then
		return remotesContainerSaved
	end
	local remotesContainerToGet = modules.Parent:FindFirstChild("Remotes")
	if RunService:IsServer() then
		if not remotesContainerToGet then
			remotesContainerToGet = Instance.new("Folder")
			remotesContainerToGet.Name = "Remotes"
			remotesContainerToGet.Parent = modules.Parent
		end
	else
		while self.isActive do
			remotesContainerToGet = modules.Parent:FindFirstChild("Remotes")
			if remotesContainerToGet then
				break
			end
			task.wait()
		end
	end
	if remotesContainerToGet then
		remotesContainerSaved = remotesContainerToGet :: any
	end
	return remotesContainerToGet
end

function Remote._waitForInstance(self: Class): Instance?
	local remotesContainer = self:_getContainer()
	if not remotesContainer then
		return nil
	end
	while self.isActive do
		local instance = self.remoteInstance
		if instance == nil then
			instance = remotesContainer:FindFirstChild(self.uniqueName)
		end
		if instance then
			self.remoteInstance = instance
			return instance
		end
		task.wait()
	end
	return nil
end

function Remote._onInstanceLoaded(self: Class, callback)
	local remoteInstance = self.remoteInstance
	if remoteInstance then
		callback(remoteInstance)
		return
	end
	task.spawn(function()
		local remotesContainer = self:_getContainer()
		while remotesContainer and self.remoteInstance == nil and self.isActive do
			local instance = remotesContainer:FindFirstChild(self.uniqueName)
			if instance then
				self.remoteInstance = instance :: any
				break
			else
				task.wait()
			end
		end
		if self.remoteInstance then
			callback(self.remoteInstance)
		end
	end)
	return
end

function Remote.fireClient(self: Class, player: Player, ...)
	local remoteInstance = self.remoteInstance
	if not remoteInstance or not remoteInstance:IsA("RemoteEvent") then
		error("Can only call fireClient for remoteType 'Event'")
	elseif RunService:IsClient() then
		error("Can only call fireClient on server")
	elseif not player:IsA("Player") then
		error("Player must be a valid Player instance")
	end
	local packedData = table.pack(...)
	local compressedData = Serializer.processForNetwork(packedData)
	remoteInstance:FireClient(player, compressedData)
end

function Remote.fireAllClients(self: Class, ...)
	for _, player in Players:GetPlayers() do
		self:fireClient(player, ...)
	end
end

function Remote.fireNearbyClients(self: Class, origin: Vector3, radius: number, ...)
	for _, player in Players:GetPlayers() do
		if player:DistanceFromCharacter(origin) <= radius then
			self:fireClient(player, ...)
		end
	end
end

function Remote.fireServer(self: Class, ...)
	if RunService:IsServer() then
		error("Can only call fireServer on client")
	end
	local packedArgs = table.pack(...)
	self:_onInstanceLoaded(function(remoteInstance)
		if not remoteInstance:IsA("RemoteEvent") then
			error("Can only call fireServer for remoteType 'Event'")
		end
		remoteInstance:FireServer(table.unpack(packedArgs))
	end)
end

function Remote.invokeServerAsync(self: Class, ...): (boolean, ...any)
	if RunService:IsServer() then
		error("Can only call invokeServer on client")
	end
	local remoteInstance = self:_waitForInstance()
	if not remoteInstance then
		return false, "Remote was destroyed"
	elseif not remoteInstance:IsA("RemoteFunction") then
		return false, "Can only call invokeServer for remoteType 'Function'"
	end
	local packedArgs = table.pack(...)
	local success, returnedData = pcall(function()
		return remoteInstance:InvokeServer(table.unpack(packedArgs))
	end)
	if not success then
		return false, returnedData
	end
	local decompressedData = Serializer.processForNetwork(returnedData)
	if typeof(decompressedData[1]) ~= "boolean" then
		return true, table.unpack(decompressedData)
	end
	return table.unpack(decompressedData)
end

function Remote.onClientEvent(self: Class, callback: (...any) -> ...any)
	if RunService:IsServer() then
		error("Can only call onClientEvent on client")
	end
	local realConnection = nil :: any
	self:_onInstanceLoaded(function(remoteInstance)
		if not remoteInstance:IsA("RemoteEvent") then
			error("Can only call onClientEvent for remoteType 'Event'")
		end
		if realConnection == false then
			return
		end
		realConnection = self.janitor:add(remoteInstance.OnClientEvent:Connect(function(compressedData)
			local decompressedData = Serializer.processForNetwork(compressedData)
			callback(table.unpack(decompressedData))
		end))
	end)
	return createConnection(function()
		if realConnection then
			realConnection = realConnection :: any
			realConnection:Disconnect()
			realConnection = false
		end
	end)
end

function Remote.onServerEvent(self: Class, callback: (Player, ...any) -> ...any)
	local remoteInstance = self.remoteInstance
	if not remoteInstance or not remoteInstance:IsA("RemoteEvent") then
		error("Can only call onServerEvent for remoteType 'Event'")
	elseif RunService:IsClient() then
		error("Can only call onServerEvent on server")
	end
	local realConnection = self.janitor:add(remoteInstance.OnServerEvent:Connect(function(player: Player, ...)
		if not checkRateLimit(self, player) then
			return
		end
		callback(player, ...)
	end))
	return createConnection(function()
		if realConnection then
			realConnection:Disconnect()
		end
	end)
end

function Remote.onServerInvoke(self: Class, callback: (Player, ...any) -> ...any)
	local remoteInstance = self.remoteInstance
	if not remoteInstance or not remoteInstance:IsA("RemoteFunction") then
		error("Can only call onServerInvoke for remoteType 'Function'")
	elseif RunService:IsClient() then
		error("Can only call onServerInvoke on server")
	elseif self.permitInvokeCallback ~= true then
		error("Can only have one onServerInvoke callback per remote")
	else
		self.permitInvokeCallback = false :: any
	end
	remoteInstance.OnServerInvoke = function(player: Player, ...)
		if not checkRateLimit(self, player) then
			local packedData = table.pack(false, "Rate limited")
			local compressedData = Serializer.processForNetwork(packedData)
			return compressedData
		end
		local packedData = table.pack(callback(player, ...))
		local compressedData = Serializer.processForNetwork(packedData)
		return compressedData
	end
	self = self :: any
	return createConnection(function()
		remoteInstance.OnServerInvoke = nil :: any
	end)
end

function Remote.destroy(self: Class)
	if self.isActive == false then
		return
	end
	self.isActive = false :: any
	self.janitor:destroy()
end


return Remote