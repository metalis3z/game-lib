-- Client side of a replicated collection (Fighter, Duel, QueuePad, Enemy).
--
-- The original was obfuscated (the untouched copy is in ServerStorage.ObfuscatedOriginals)
-- and did not compile once decompiled. This one is written against what its four users read
-- from it: FighterController, DuelController, QueuePadController and EnemyController each do
-- setmetatable(ReplicatedController.new("<Name>"), their own class) and then use
--
--   .ClassName              the name given to new()
--   .Objects                [ObjectID] = client object
--   .ObjectAdded(object)    / .ObjectRemoved(object)
--
-- Objects arrive on Remotes.Replication.<Name>.Replicate / ReplicateUnreliable:
--
--   (<enum ReplicationAdded>,   serial)            serial = ReplicatedClass:Serialize()
--   (<enum ReplicationChanged>, objectID, changeType, ...)  -> object:ReplicateFromServer(changeType, ...)
--   (<enum ReplicationRemoved>, objectID)
--
-- and the full set is asked for once with RequestReplication:FireServer(), deferred so the
-- subclass has connected its signals before the first object comes in.
--
-- A subclass may set ._reject_object_added_serial_callback(data) to skip an object; it gets
-- the serial's Data table as sent (FighterController drops fighters of players who left).

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Modules = ReplicatedStorage:WaitForChild("Modules")
local EnumLibrary = require(Modules:WaitForChild("EnumLibrary"))
local ReplicatedClass = require(Modules:WaitForChild("ReplicatedClass"))
local Signal = require(Modules:WaitForChild("Signal"))

local ReplicatedController = {}
ReplicatedController.__index = ReplicatedController

-- Keys and values in a serial may be compressed to enums, or not.
local function decode(value)
	if type(value) == "string" then
		return EnumLibrary:FromEnum(value, true) or value
	end
	return value
end

local function field(serial, name: string)
	if type(serial) ~= "table" then
		return nil
	end
	local value = serial[name]
	if value == nil then
		local key = EnumLibrary:ToEnum(name, true)
		value = key and serial[key]
	end
	return value
end

function ReplicatedController.new(className: string)
	local self = setmetatable({}, ReplicatedController)
	self.ClassName = className
	self.Objects = {}
	self.ObjectAdded = Signal.new()
	self.ObjectRemoved = Signal.new()
	self._remotes = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Replication"):WaitForChild(className)
	self:_Listen()
	return self
end

function ReplicatedController.GetObject(self, objectID)
	return self.Objects[objectID]
end

function ReplicatedController._Add(self, serial)
	local data = field(serial, "Data")
	local objectID = field(data, "ObjectID")
	if objectID == nil then
		warn(string.format("[ReplicatedController] %s: object without an ObjectID", self.ClassName))
		return
	end

	if self._reject_object_added_serial_callback and self._reject_object_added_serial_callback(data) then
		return
	end

	-- The same object can be announced twice (once when the server creates it, once more in
	-- the answer to RequestReplication). Controllers hold on to the first one they were
	-- given, so a repeat must not replace it.
	if self.Objects[objectID] then
		return
	end

	local classType = decode(field(serial, "ClientReplicatedClassType")) or ("Client" .. self.ClassName)
	local class = ReplicatedClass:GetReplicatedClass(classType)
	local object = class.new(serial)

	self.Objects[objectID] = object
	self.ObjectAdded:Fire(object)
end

function ReplicatedController._Remove(self, objectID)
	local object = self.Objects[objectID]
	if not object then
		return
	end

	self.Objects[objectID] = nil
	self.ObjectRemoved:Fire(object)

	if object.Destroy then
		object:Destroy()
	end
end

function ReplicatedController._Change(self, objectID, changeType, ...)
	local object = self.Objects[objectID]
	if object and object.ReplicateFromServer then
		object:ReplicateFromServer(decode(changeType), ...)
	end
end

function ReplicatedController._OnReplicate(self, kind, ...)
	EnumLibrary:WaitForEnumBuilder()
	kind = decode(kind)

	if kind == "ReplicationAdded" then
		self:_Add(...)
	elseif kind == "ReplicationChanged" then
		self:_Change(...)
	elseif kind == "ReplicationRemoved" then
		self:_Remove(...)
	end
end

function ReplicatedController._Listen(self)
	for _, name in { "Replicate", "ReplicateUnreliable" } do
		local remote = self._remotes:FindFirstChild(name)
		if remote then
			remote.OnClientEvent:Connect(function(...)
				local ok, err = pcall(self._OnReplicate, self, ...)
				if not ok then
					warn(string.format("[ReplicatedController] %s: %s", self.ClassName, tostring(err)))
				end
			end)
		end
	end

	task.defer(function()
		local request = self._remotes:FindFirstChild("RequestReplication")
		if request then
			request:FireServer()
		end
	end)
end

return ReplicatedController
