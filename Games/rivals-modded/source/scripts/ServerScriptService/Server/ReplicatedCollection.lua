-- Server side of the client's Modules.ReplicatedController: a set of ReplicatedClass objects
-- of one kind (Fighter, Duel, QueuePad, Enemy), kept in sync over Remotes.Replication.<Name>.
--
--   Replicate(<enum ReplicationAdded>,   object:Serialize())
--   Replicate(<enum ReplicationChanged>, objectID, <enum changeType>, ...)   from the object's
--            ReplicateToClient signal (ReplicateUnreliable for ReplicateToClientUnreliable)
--   Replicate(<enum ReplicationRemoved>, objectID)
--
-- RequestReplication:FireServer() from a client gets it every object that exists. Objects
-- are shared ReplicatedClass instances, so Serialize() compresses field names through
-- EnumLibrary exactly the way the client decodes them; every field set on one has to be a
-- name EnumBuilder knows, or ToEnum asserts.

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Modules = ReplicatedStorage:WaitForChild("Modules")
local EnumLibrary = require(Modules:WaitForChild("EnumLibrary"))

local ReplicatedCollection = {}
ReplicatedCollection.__index = ReplicatedCollection

local function enum(name: string): string
	EnumLibrary:WaitForEnumBuilder()
	return EnumLibrary:ToEnum(name)
end

function ReplicatedCollection.new(className: string)
	local self = setmetatable({}, ReplicatedCollection)
	self.ClassName = className
	self.Objects = {}
	self._connections = {}

	local folder = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Replication"):WaitForChild(className)
	self._replicate = folder:WaitForChild("Replicate")
	self._replicateUnreliable = folder:FindFirstChild("ReplicateUnreliable")
	self.RequestRemote = folder:WaitForChild("RequestReplication")

	self.RequestRemote.OnServerEvent:Connect(function(player: Player)
		for _, object in self.Objects do
			self._replicate:FireClient(player, enum("ReplicationAdded"), object:Serialize())
		end
	end)

	return self
end

function ReplicatedCollection.Add(self, object)
	local objectID = object:Get("ObjectID")
	self.Objects[objectID] = object

	local function forward(remote, changeType: string, ...)
		if remote and self.Objects[objectID] == object then
			remote:FireAllClients(enum("ReplicationChanged"), objectID, enum(changeType), ...)
		end
	end

	self._connections[objectID] = {
		object.ReplicateToClient:Connect(function(changeType: string, ...)
			forward(self._replicate, changeType, ...)
		end),
		object.ReplicateToClientUnreliable:Connect(function(changeType: string, ...)
			forward(self._replicateUnreliable or self._replicate, changeType, ...)
		end),
	}

	self._replicate:FireAllClients(enum("ReplicationAdded"), object:Serialize())
	return object
end

function ReplicatedCollection.Remove(self, object)
	local objectID = object:Get("ObjectID")
	if self.Objects[objectID] ~= object then
		return
	end

	self.Objects[objectID] = nil
	for _, connection in self._connections[objectID] or {} do
		connection:Disconnect()
	end
	self._connections[objectID] = nil

	self._replicate:FireAllClients(enum("ReplicationRemoved"), objectID)
end

function ReplicatedCollection.Find(self, predicate: (any) -> boolean)
	for _, object in self.Objects do
		if predicate(object) then
			return object
		end
	end
	return nil
end

return ReplicatedCollection
