local RunService = game:GetService("RunService")
local functionCleanupMarker = newproxy()
local threadCleanupMarker = newproxy()
local cleanupMethodNames = table.freeze({
	"Destroy",
	"Disconnect",
	"destroy",
	"disconnect"
})

local function GetObjectCleanupFunction(object, customCleanupMethod)
	local objectType = typeof(object)
	if objectType == "function" then
		return functionCleanupMarker
	elseif objectType == "thread" then
		return threadCleanupMarker
	elseif customCleanupMethod then
		return customCleanupMethod
	elseif objectType == "Instance" then
		return "Destroy"
	elseif objectType == "RBXScriptConnection" then
		return "Disconnect"
	else
		if objectType == "table" then
			for _, methodName in cleanupMethodNames do
				if typeof(object[methodName]) == "function" then
					return methodName
				end
			end
		end
		error(("failed to get cleanup function for object %*: %*"):format(objectType, object), 3)
		return
	end
end

local function AssertPromiseLike(promise)
	if typeof(promise) ~= "table" or typeof(promise.getStatus) ~= "function" or typeof(promise.finally) ~= "function" or typeof(promise.cancel) ~= "function" then
		error("did not receive a promise as an argument", 3)
	end
end

local Trove = {}
Trove.__index = Trove

Trove.new = function()
	local self = setmetatable({}, Trove)
	self._objects = {}
	self._cleaning = false
	return self
end

Trove.Add = function(self, object, customCleanupMethod)
	if self._cleaning then
		error("cannot call trove:Add() while cleaning", 2)
	end
	local cleanupMethod = GetObjectCleanupFunction(object, customCleanupMethod)
	table.insert(self._objects, {
		object,
		cleanupMethod
	})
	return object
end

Trove.Clone = function(self, instance)
	if self._cleaning then
		error("cannot call trove:Clone() while cleaning", 2)
	end
	return self:Add(instance:Clone())
end

Trove.Construct = function(self, class, ...)
	if self._cleaning then
		error("Cannot call trove:Construct() while cleaning", 2)
	end
	local object = nil
	local classType = type(class)
	if classType == "table" then
		object = class.new(...)
	elseif classType == "function" then
		object = class(...)
	end
	return self:Add(object)
end

Trove.Connect = function(self, signal, callback)
	if self._cleaning then
		error("Cannot call trove:Connect() while cleaning", 2)
	end
	return self:Add(signal:Connect(callback))
end

Trove.BindToRenderStep = function(self, name, priority, callback)
	if self._cleaning then
		error("cannot call trove:BindToRenderStep() while cleaning", 2)
	end
	RunService:BindToRenderStep(name, priority, callback)
	self:Add(function()
		RunService:UnbindFromRenderStep(name)
	end)
end

Trove.AddPromise = function(self, promise)
	if self._cleaning then
		error("cannot call trove:AddPromise() while cleaning", 2)
	end
	if typeof(promise) ~= "table" or typeof(promise.getStatus) ~= "function" or typeof(promise.finally) ~= "function" or typeof(promise.cancel) ~= "function" then
		error("did not receive a promise as an argument", 3)
	end
	if promise:getStatus() == "Started" then
		promise:finally(function()
			if self._cleaning then
				return
			else
				self:_findAndRemoveFromObjects(promise, false)
				return
			end
		end)
		self:Add(promise, "cancel")
	end
	return promise
end

Trove.Remove = function(self, object)
	if self._cleaning then
		error("cannot call trove:Remove() while cleaning", 2)
	end
	return self:_findAndRemoveFromObjects(object, true)
end

Trove.Pop = function(self, object)
	if self._cleaning then
		error("cannot call trove:Pop() while cleaning", 2)
	end
	return self:_findAndRemoveFromObjects(object, false)
end

Trove.Extend = function(self)
	if self._cleaning then
		error("cannot call trove:Extend() while cleaning", 2)
	end
	return self:Construct(Trove)
end

Trove.Clean = function(self)
	if self._cleaning then
		return
	else
		self._cleaning = true
		for _, objectEntry in self._objects do
			self:_cleanupObject(objectEntry[1], objectEntry[2])
		end
		table.clear(self._objects)
		self._cleaning = false
		return
	end
end

Trove.WrapClean = function(self)
	return function()
		self:Clean()
	end
end

Trove._findAndRemoveFromObjects = function(self, object, shouldCleanup)
	local objects = self._objects
	for index, objectEntry in objects do
		if objectEntry[1] == object then
			local lastIndex = #objects
			objects[index] = objects[lastIndex]
			objects[lastIndex] = nil
			if shouldCleanup then
				self:_cleanupObject(objectEntry[1], objectEntry[2])
			end
			return true
		end
	end
	return false
end

Trove._cleanupObject = function(_, object, cleanupMethod)
	if cleanupMethod == functionCleanupMarker then
		task.spawn(object)
		return
	elseif cleanupMethod == threadCleanupMarker then
		pcall(task.cancel, object)
		return
	else
		object[cleanupMethod](object)
		return
	end
end

Trove.AttachToInstance = function(self, instance)
	if self._cleaning then
		error("cannot call trove:AttachToInstance() while cleaning", 2)
	elseif not instance:IsDescendantOf(game) then
		error("instance is not a descendant of the game hierarchy", 2)
	end
	return self:Connect(instance.Destroying, function()
		self:Destroy()
	end)
end

Trove.Destroy = function(self)
	self:Clean()
end

return {
	new = Trove.new
}