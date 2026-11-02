
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players           = game:GetService("Players")

local Signal = require(script.Parent.ReplicatorClient.ReplicatorSignal)


local CMD_INIT    = utf8.char(0)
local CMD_UPDATE  = utf8.char(1)
local CMD_DESTROY = utf8.char(2)


local function getOrCreate(parent, className, name)
	local existing = parent:FindFirstChild(name)
	if existing then return existing end
	local inst = Instance.new(className)
	inst.Name   = name
	inst.Parent = parent
	return inst
end

local internalFolder = getOrCreate(ReplicatedStorage, "Folder",     "__ReplicatorInternal")
local remoteEvent    = getOrCreate(internalFolder,    "RemoteEvent", "RemoteEvent")


local Registry = {}
local nextInstanceId = 1
local playerInstanceIds = {}
local playerReady = {}


local function deepClone(t)
	local clone = table.clone(t)
	for k, v in clone do
		if type(v) == "table" then
			clone[k] = deepClone(v)
		end
	end
	return clone
end


local function buildLeaf(value)
	return { o = 0, v = type(value) == "table" and deepClone(value) or value }
end

local function buildDiff(path, value, depth)
	local key       = path[depth]
	local isNumeric = type(key) == "number"

	local node
	if depth == #path then
		node = buildLeaf(value)
	else
		node = { o = 1, v = buildDiff(path, value, depth + 1) }
	end

	if isNumeric then
		node.k = true
	end

	return { [key] = node }
end


local function makeInitPacket(instanceId, replicatorId, data)
	return { CMD_INIT, instanceId, replicatorId, data and deepClone(data) or {} }
end

local function makeUpdatePacket(instanceId, diff)
	return { CMD_UPDATE, instanceId, diff }
end

local function makeDestroyPacket(instanceId)
	return { CMD_DESTROY, instanceId }
end

local function fireToPlayer(player, packet)
	remoteEvent:FireClient(player, { packet })
end


local function applyPath(data, path, value)
	local current = data
	for i = 1, #path - 1 do
		local key = path[i]
		if type(current[key]) ~= "table" then
			current[key] = {}
		end
		current = current[key]
	end

	local lastKey = path[#path]
	current[lastKey] = type(value) == "table" and deepClone(value) or value
end


local function readPath(data, path)
	local current = data
	local len = #path
	for i = 1, len - 1 do
		if type(current) ~= "table" then return nil end
		current = current[path[i]]
	end
	if type(current) ~= "table" then return nil end
	return current[path[len]]
end

local function assertPath(path, where)
	if type(path) ~= "table" then
		error(("%s: path must be a table; got %s"):format(where, type(path)), 3)
	end
	for i, key in path do
		local kt = type(key)
		if kt ~= "string" and kt ~= "number" then
			error(("%s: path[%d] must be string or number; got %s"):format(where, i, kt), 3)
		end
	end
end


local Replicator    = {}
Replicator.__index  = Replicator

function Replicator.new(id)
	return setmetatable({
		Id           = id,
		Data         = {},
		_subscribers = {},
		_destroyed   = false,
		Destroying   = Signal.new(),
	}, Replicator)
end

function Replicator:SetData(data)
	assert(not self._destroyed, "Replicator is destroyed")
	self.Data = data and deepClone(data) or {}
	for player, instanceId in self._subscribers do
		if playerReady[player] then
			fireToPlayer(player, makeInitPacket(instanceId, self.Id, self.Data))
		end
	end
end

function Replicator:Set(path, value)
	assert(not self._destroyed, "Replicator is destroyed")
	assertPath(path, "Replicator:Set")

	if #path == 0 then
		self:SetData(value)
		return
	end

	if type(value) ~= "table" then
		local current = readPath(self.Data, path)
		if current == value then return end
	end

	applyPath(self.Data, path, value)

	local diff = buildDiff(path, value, 1)
	for player, instanceId in self._subscribers do
		if playerReady[player] then
			fireToPlayer(player, makeUpdatePacket(instanceId, diff))
		end
	end
end

function Replicator:SetKey(key, value)
	self:Set({ key }, value)
end

function Replicator:Get(path)
	if not path or #path == 0 then
		return self.Data
	end
	assertPath(path, "Replicator:Get")
	local current = self.Data
	for _, key in path do
		if type(current) ~= "table" then return nil end
		current = current[key]
	end
	return current
end

function Replicator:GetKey(key)
	return self.Data[key]
end

function Replicator:AddSubscriber(player)
	assert(not self._destroyed, "Replicator is destroyed")
	if self._subscribers[player] then return end

	if not playerInstanceIds[player] then
		playerInstanceIds[player] = {}
	end

	local instanceId = nextInstanceId
	nextInstanceId  += 1

	self._subscribers[player]          = instanceId
	playerInstanceIds[player][self.Id] = instanceId

	if playerReady[player] then
		fireToPlayer(player, makeInitPacket(instanceId, self.Id, self.Data))
	end
end

function Replicator:RemoveSubscriber(player)
	local instanceId = self._subscribers[player]
	if not instanceId then return end

	if playerReady[player] then
		fireToPlayer(player, makeDestroyPacket(instanceId))
	end

	self._subscribers[player] = nil
	if playerInstanceIds[player] then
		playerInstanceIds[player][self.Id] = nil
	end
end

function Replicator:Destroy()
	if self._destroyed then return end
	self._destroyed = true

	for player, instanceId in self._subscribers do
		if playerReady[player] then
			fireToPlayer(player, makeDestroyPacket(instanceId))
		end
		local playerMap = playerInstanceIds[player]
		if playerMap then
			playerMap[self.Id] = nil
		end
	end

	self.Destroying:Fire()
	self.Destroying:Destroy()

	table.clear(self._subscribers)
	Registry[self.Id] = nil
end


local ReplicatorServer = {}

function ReplicatorServer.get(id, initialData)
	if Registry[id] then
		return Registry[id]
	end
	local rep = Replicator.new(id)
	if initialData then
		rep.Data = deepClone(initialData)
	end
	Registry[id] = rep
	return rep
end

function ReplicatorServer.find(id)
	return Registry[id]
end

local initCalled = false

function ReplicatorServer.init()
	assert(not initCalled, "ReplicatorServer.init() must only be called once!")
	initCalled = true

	remoteEvent.OnServerEvent:Connect(function(player)
		local batch = {}
		if playerInstanceIds[player] then
			for replicatorId, instanceId in playerInstanceIds[player] do
				local rep = Registry[replicatorId]
				if rep and rep._subscribers[player] == instanceId then
					table.insert(batch, makeInitPacket(instanceId, replicatorId, rep.Data))
				end
			end
		end

		playerReady[player] = true

		if #batch > 0 then
			remoteEvent:FireClient(player, batch)
		end
	end)

	Players.PlayerRemoving:Connect(function(player)
		playerReady[player] = nil

		for _, rep in Registry do
			rep._subscribers[player] = nil
		end

		playerInstanceIds[player] = nil
	end)
end

return ReplicatorServer
