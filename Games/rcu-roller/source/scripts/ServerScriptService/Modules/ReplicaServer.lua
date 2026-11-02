--[[
	ReplicaServer — Server-side data replication to clients
	Matches protocol expected by Client.Modules.ReplicaClient
	
	Uses RemoteEvents in ReplicatedStorage.Shared.ReplicaEvents:
	- ReplicaRequestData (client→server: request initial data)
	- ReplicaCreate (server→client: create replica)
	- ReplicaSet (server→client: set value at path)
	- ReplicaSetValues (server→client: set multiple values)
	- ReplicaTableInsert (server→client: insert into array)
	- ReplicaTableRemove (server→client: remove from array)
	- ReplicaWrite (server→client: custom write operation)
	- ReplicaSignal (bidirectional: custom signals)
	- ReplicaSignalUnreliable (bidirectional: unreliable signals)
	- ReplicaBind (server→client: bind to instance)
	- ReplicaParent (server→client: reparent replica)
	- ReplicaDestroy (server→client: destroy replica)
]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")

-- Create or find ReplicaEvents container
local Shared = ReplicatedStorage:FindFirstChild("Shared")
if not Shared then
	Shared = Instance.new("Folder")
	Shared.Name = "Shared"
	Shared.Parent = ReplicatedStorage
end

local ReplicaEvents = Shared:FindFirstChild("ReplicaEvents")
if not ReplicaEvents then
	ReplicaEvents = Instance.new("Folder")
	ReplicaEvents.Name = "ReplicaEvents"
	ReplicaEvents.Parent = Shared
end

-- Create all RemoteEvents needed by the Replica protocol
local REMOTE_NAMES = {
	"ReplicaRequestData", "ReplicaCreate", "ReplicaSet", "ReplicaSetValues",
	"ReplicaTableInsert", "ReplicaTableRemove", "ReplicaWrite",
	"ReplicaSignal", "ReplicaBind", "ReplicaParent", "ReplicaDestroy",
}
local UNRELIABLE_REMOTES = { "ReplicaSignalUnreliable" }

for _, name in REMOTE_NAMES do
	if not ReplicaEvents:FindFirstChild(name) then
		local re = Instance.new("RemoteEvent")
		re.Name = name
		re.Parent = ReplicaEvents
	end
end
for _, name in UNRELIABLE_REMOTES do
	if not ReplicaEvents:FindFirstChild(name) then
		local re = Instance.new("UnreliableRemoteEvent")
		re.Name = name
		re.Parent = ReplicaEvents
	end
end

-- Remote references
local Remotes = {
	RequestData = ReplicaEvents.ReplicaRequestData,
	Create = ReplicaEvents.ReplicaCreate,
	Set = ReplicaEvents.ReplicaSet,
	SetValues = ReplicaEvents.ReplicaSetValues,
	TableInsert = ReplicaEvents.ReplicaTableInsert,
	TableRemove = ReplicaEvents.ReplicaTableRemove,
	Write = ReplicaEvents.ReplicaWrite,
	Signal = ReplicaEvents.ReplicaSignal,
	SignalUnreliable = ReplicaEvents.ReplicaSignalUnreliable,
	Bind = ReplicaEvents.ReplicaBind,
	Parent = ReplicaEvents.ReplicaParent,
	Destroy = ReplicaEvents.ReplicaDestroy,
}

-- Internal state
local NextReplicaId = 1
local AllReplicas = {} -- [id] = replica
local PlayerReplicas = {} -- [player] = {replica, ...}
local ReadyPlayers = {} -- [player] = true (players who requested data)

-- WriteLibs registry (custom write functions)
local WriteLibs = {}

------------------------------------------------------------------------
-- Replica class
------------------------------------------------------------------------
local Replica = {}
Replica.__index = Replica

function Replica.new(config)
	local self = setmetatable({}, Replica)
	self.Id = NextReplicaId
	NextReplicaId += 1
	self.Token = config.Token -- string identifier (e.g. "playerData")
	self.Tags = config.Tags or {} -- {key=value}
	self.Data = config.Data or {}
	self.Parent = config.Parent or nil -- parent Replica or nil
	self.Children = {} -- {childReplica = true}
	self.Replication = config.Replication or "All" -- "All" or player instance
	self.BoundInstance = nil
	self._destroyed = false
	
	AllReplicas[self.Id] = self
	
	-- Track under player if player-scoped
	if typeof(self.Replication) == "Instance" and self.Replication:IsA("Player") then
		local player = self.Replication
		if not PlayerReplicas[player] then
			PlayerReplicas[player] = {}
		end
		table.insert(PlayerReplicas[player], self)
	end
	
	-- Register as child of parent
	if self.Parent then
		self.Parent.Children[self] = true
	end
	
	return self
end

-- Get the serialized creation packet for a replica
function Replica:_getCreatePacket()
	return {
		self.Id,
		self.Token,
		self.Tags,
		self.Data,
		self.Parent and self.Parent.Id or 0,
	}
end

-- Fire to appropriate clients based on Replication scope
function Replica:_fireClient(remote, ...)
	if self._destroyed then return end
	if typeof(self.Replication) == "Instance" and self.Replication:IsA("Player") then
		if self.Replication.Parent then -- still in game
			remote:FireClient(self.Replication, ...)
		end
	else
		remote:FireAllClients(...)
	end
end

------------------------------------------------------------------------
-- Replica data mutation methods (fire to clients)
------------------------------------------------------------------------

function Replica:Set(path, value)
	-- path is a table of keys, e.g. {"inventory", "gems"}
	-- Navigate to parent and set final key
	local current = self.Data
	for i = 1, #path - 1 do
		current = current[path[i]]
		if current == nil then
			warn("[ReplicaServer] Set: invalid path", table.concat(path, "."))
			return
		end
	end
	local key = path[#path]
	current[key] = value
	
	-- Fire to client: replicaId, path, value
	self:_fireClient(Remotes.Set, self.Id, path, value)
end

function Replica:SetValues(path, values)
	-- Set multiple values at a path
	local current = self.Data
	for i = 1, #path do
		current = current[path[i]]
		if current == nil then
			warn("[ReplicaServer] SetValues: invalid path", table.concat(path, "."))
			return
		end
	end
	for k, v in values do
		current[k] = v
	end
	self:_fireClient(Remotes.SetValues, self.Id, path, values)
end

function Replica:TableInsert(path, value, index)
	local current = self.Data
	for i = 1, #path do
		current = current[path[i]]
		if current == nil then
			warn("[ReplicaServer] TableInsert: invalid path", table.concat(path, "."))
			return
		end
	end
	if index then
		table.insert(current, index, value)
	else
		table.insert(current, value)
		index = #current
	end
	self:_fireClient(Remotes.TableInsert, self.Id, path, value, index)
	return index
end

function Replica:TableRemove(path, index)
	local current = self.Data
	for i = 1, #path do
		current = current[path[i]]
		if current == nil then
			warn("[ReplicaServer] TableRemove: invalid path", table.concat(path, "."))
			return
		end
	end
	local removed = table.remove(current, index)
	self:_fireClient(Remotes.TableRemove, self.Id, path, index)
	return removed
end

function Replica:Write(writeLibName, ...)
	-- Execute a registered write function and replicate
	local lib = WriteLibs[writeLibName]
	if not lib then
		warn("[ReplicaServer] Write: unknown WriteLib:", writeLibName)
		return
	end
	local result = lib(self, ...)
	self:_fireClient(Remotes.Write, self.Id, writeLibName, ...)
	return result
end

function Replica:FireClient(player, ...)
	Remotes.Signal:FireClient(player, self.Id, ...)
end

function Replica:FireAllClients(...)
	Remotes.Signal:FireAllClients(self.Id, ...)
end

function Replica:ConnectOnServerEvent(callback)
	return Remotes.Signal.OnServerEvent:Connect(function(player, replicaId, ...)
		if replicaId == self.Id then
			callback(player, ...)
		end
	end)
end

function Replica:BindToInstance(instance)
	self.BoundInstance = instance
	-- Tag the instance for CollectionService detection on client
	local tag = Instance.new("NumberValue")
	tag.Name = "ReplicaId"
	tag.Value = self.Id
	tag.Parent = instance
	CollectionService:AddTag(instance, "REPLICA")
	
	self:_fireClient(Remotes.Bind, self.Id, instance)
end

function Replica:SetParent(newParent)
	if self.Parent then
		self.Parent.Children[self] = nil
	end
	self.Parent = newParent
	if newParent then
		newParent.Children[self] = true
	end
	self:_fireClient(Remotes.Parent, self.Id, newParent and newParent.Id or 0)
end

function Replica:Destroy()
	if self._destroyed then return end
	self._destroyed = true
	
	-- Destroy children first
	for child in self.Children do
		child:Destroy()
	end
	
	-- Remove from parent
	if self.Parent then
		self.Parent.Children[self] = nil
	end
	
	-- Fire destroy to clients
	self:_fireClient(Remotes.Destroy, self.Id)
	
	-- Clean up bound instance
	if self.BoundInstance then
		local tag = self.BoundInstance:FindFirstChild("ReplicaId")
		if tag then tag:Destroy() end
		CollectionService:RemoveTag(self.BoundInstance, "REPLICA")
	end
	
	-- Remove from registries
	AllReplicas[self.Id] = nil
	if typeof(self.Replication) == "Instance" and self.Replication:IsA("Player") then
		local list = PlayerReplicas[self.Replication]
		if list then
			for i, r in list do
				if r == self then
					table.remove(list, i)
					break
				end
			end
		end
	end
end

------------------------------------------------------------------------
-- Module API
------------------------------------------------------------------------
local ReplicaServer = {}

function ReplicaServer.NewReplica(config)
	-- config = { Token, Tags?, Data?, Replication?, Parent? }
	local replica = Replica.new(config)
	
	-- Send creation to already-ready clients
	local packet = replica:_getCreatePacket()
	if typeof(replica.Replication) == "Instance" and replica.Replication:IsA("Player") then
		local player = replica.Replication
		if ReadyPlayers[player] then
			Remotes.Create:FireClient(player, {packet})
		end
	else
		for player in ReadyPlayers do
			Remotes.Create:FireClient(player, {packet})
		end
	end
	
	return replica
end

function ReplicaServer.RegisterWriteLib(name, func)
	WriteLibs[name] = func
end

function ReplicaServer.GetReplicasForPlayer(player)
	return PlayerReplicas[player] or {}
end

function ReplicaServer.DestroyPlayerReplicas(player)
	local list = PlayerReplicas[player]
	if list then
		-- Iterate copy since Destroy modifies the list
		local copy = table.clone(list)
		for _, replica in copy do
			replica:Destroy()
		end
		PlayerReplicas[player] = nil
	end
	ReadyPlayers[player] = nil
end

------------------------------------------------------------------------
-- Listen for client data requests
------------------------------------------------------------------------
Remotes.RequestData.OnServerEvent:Connect(function(player)
	if ReadyPlayers[player] then return end -- already sent
	ReadyPlayers[player] = true
	
	-- Collect all replicas this player should receive
	local packets = {}
	for _, replica in AllReplicas do
		if replica._destroyed then continue end
		if typeof(replica.Replication) == "Instance" and replica.Replication:IsA("Player") then
			if replica.Replication == player then
				table.insert(packets, replica:_getCreatePacket())
			end
		else
			-- "All" replication — send to everyone
			table.insert(packets, replica:_getCreatePacket())
		end
	end
	
	-- Sort by ID to ensure parents come before children
	table.sort(packets, function(a, b) return a[1] < b[1] end)
	
	-- Send initial data
	if #packets > 0 then
		Remotes.Create:FireClient(player, packets)
	end
	
	-- Signal the client that initial data is complete
	Remotes.RequestData:FireClient(player)
end)

-- Clean up on player leave
Players.PlayerRemoving:Connect(function(player)
	task.defer(function()
		ReplicaServer.DestroyPlayerReplicas(player)
	end)
end)

return ReplicaServer
