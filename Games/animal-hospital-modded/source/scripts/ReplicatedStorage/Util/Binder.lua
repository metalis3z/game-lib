local RunService = game:GetService("RunService")
local CollectionService = game:GetService("CollectionService")
local Maid = require(script.Parent.Maid)
local Signal = require(script.Parent.Signal)
local t = {}

t.__index = t
t.ClassName = "Binder"

local function doNothing() --[[ doNothing | Line: 16 ]] end

function t.newInactive(p1, p2) --[[ newInactive | Line: 18 | Upvalues: t (copy), Maid (copy), doNothing (copy) ]]
	local v2 = setmetatable({}, t)

	v2._maid = Maid.new()
	v2._tagName = if p1 then p1 else error("Bad argument \'tagName\', expected string")
	v2._constructor = if p2 then p2 else error("Bad argument \'constructor\', expected table or function")
	v2._instToClass = {}
	v2._allClassSet = {}
	v2._pendingInstSet = {}
	v2._listeners = {}

	if p2.Destroy then
		delay(5, function() --[[ Line: 32 | Upvalues: v2 (copy) ]]
			if v2._loaded then
				return
			end

			warn("Binder is not loaded. Call :Init() on it!")
		end)
		v2:Init()

		return v2
	end

	p2.Destroy = doNothing
	delay(5, function() --[[ Line: 32 | Upvalues: v2 (copy) ]]
		if v2._loaded then
			return
		end

		warn("Binder is not loaded. Call :Init() on it!")
	end)
	v2:Init()

	return v2
end
function t.new(p1, p2) --[[ new | Line: 43 | Upvalues: t (copy) ]]
	local v1 = t.newInactive(p1, p2)

	v1:Init()

	return v1
end
function t.isBinder(p1) --[[ isBinder | Line: 50 ]]
	return if type(p1) == "table" then p1.ClassName == "Binder" else false
end
function t.Init(p1) --[[ Init | Line: 54 | Upvalues: CollectionService (copy) ]]
	if p1._loaded then
		return
	end

	p1._loaded = true

	local v1 = Instance.new("BindableEvent")

	for k, v in pairs(CollectionService:GetTagged(p1._tagName)) do
		local v2 = v1.Event:Connect(function() --[[ Line: 63 | Upvalues: p1 (copy), v (copy) ]]
			p1:_add(v)
		end)

		v1:Fire()
		v2:Disconnect()
	end

	v1:Destroy()
	p1._maid:GiveTask(CollectionService:GetInstanceAddedSignal(p1._tagName):Connect(function(p12) --[[ Line: 73 | Upvalues: p1 (copy) ]]
		p1:_add(p12)
	end))
	p1._maid:GiveTask(CollectionService:GetInstanceRemovedSignal(p1._tagName):Connect(function(p12) --[[ Line: 76 | Upvalues: p1 (copy) ]]
		p1:_remove(p12)
	end))
end
function t.GetConstructor(p1) --[[ GetConstructor | Line: 81 ]]
	return p1._constructor
end
function t.ObserveInstance(p1, p2, p3) --[[ ObserveInstance | Line: 86 ]]
	p1._listeners[p2] = p1._listeners[p2] or {}
	p1._listeners[p2][p3] = true

	return function() --[[ Line: 90 | Upvalues: p1 (copy), p2 (copy), p3 (copy) ]]
		if not p1._listeners[p2] then
			return
		end

		p1._listeners[p2][p3] = nil

		if next(p1._listeners[p2]) then
			return
		end

		p1._listeners[p2] = nil
	end
end
function t.GetClassAddedSignal(p1) --[[ GetClassAddedSignal | Line: 102 | Upvalues: Signal (copy) ]]
	if not p1._classAddedSignal then
		p1._classAddedSignal = Signal.new()
		p1._maid:GiveTask(p1._classAddedSignal)
	end

	return p1._classAddedSignal
end
function t.GetClassRemovingSignal(p1) --[[ GetClassRemovingSignal | Line: 112 | Upvalues: Signal (copy) ]]
	if not p1._classRemovingSignal then
		p1._classRemovingSignal = Signal.new()
		p1._maid:GiveTask(p1._classRemovingSignal)
	end

	return p1._classRemovingSignal
end
function t.GetTag(p1) --[[ GetTag | Line: 123 ]]
	return p1._tagName
end
function t.GetAll(p1) --[[ GetAll | Line: 127 ]]
	local t = {}

	for k, v in pairs(p1._allClassSet) do
		t[#t + 1] = k
	end

	return t
end
function t.GetTagged(p1, p2) --[[ GetTagged | Line: 135 | Upvalues: CollectionService (copy) ]]
	local t = {}

	for k, v in pairs(CollectionService:GetTagged(p2)) do
		t[#t + 1] = p1:Get(v)
	end

	return t
end
function t.GetAllSet(p1) --[[ GetAllSet | Line: 145 ]]
	return p1._allClassSet
end
function t.BindClient(p1, p2) --[[ BindClient | Line: 151 | Upvalues: RunService (copy), CollectionService (copy) ]]
	if not RunService:IsClient() then
		warn(("[Binder.BindClient] - Bindings \'%s\' done on the server! Will be replicated!"):format(p1._tagName))
	end

	CollectionService:AddTag(p2, p1._tagName)

	return p1:Get(p2)
end
function t.Bind(p1, p2) --[[ Bind | Line: 161 | Upvalues: RunService (copy), CollectionService (copy) ]]
	if RunService:IsClient() then
		warn(("[Binder.Bind] - Bindings \'%s\' done on the client! Will be disrupted upon server replication!"):format(p1._tagName))
	end

	CollectionService:AddTag(p2, p1._tagName)

	return p1:Get(p2)
end
function t.Unbind(p1, p2) --[[ Unbind | Line: 171 | Upvalues: RunService (copy), CollectionService (copy) ]]
	assert(if typeof(p2) == "Instance" then true else false)

	if RunService:IsClient() then
		warn(("[Binder.Bind] - Unbinding \'%s\' done on the client! Might be disrupted upon server replication!"):format(p1._tagName))
	end

	CollectionService:RemoveTag(p2, p1._tagName)
end
function t.UnbindClient(p1, p2) --[[ UnbindClient | Line: 182 | Upvalues: CollectionService (copy) ]]
	assert(if typeof(p2) == "Instance" then true else false)
	CollectionService:RemoveTag(p2, p1._tagName)
end
function t.Get(p1, p2) --[[ Get | Line: 187 ]]
	assert(if typeof(p2) == "Instance" then true else false, "Argument \'inst\' is not an Instance")

	return p1._instToClass[p2]
end
function t._add(p1, p2) --[[ _add | Line: 192 ]]
	assert(if typeof(p2) == "Instance" then true else false, "Argument \'inst\' is not an Instance")

	if p1._instToClass[p2] then
		return
	end

	if p1._pendingInstSet[p2] == true then
		warn("[Binder._add] - Respawned add. Still loading, probably caused by error in constructor.")

		return
	end

	p1._pendingInstSet[p2] = true

	local v2 = if type(p1._constructor) == "function" then p1._constructor(p2) elseif p1._constructor.Create then p1._constructor:Create(p2) else p1._constructor.new(p2)

	if p1._pendingInstSet[p2] == true then
		p1._pendingInstSet[p2] = nil

		if type(v2) == "table" then
			if type(v2.Destroy) ~= "function" then
				warn("[Binder._add] - Bad class constructed")
			end
		else
			warn("[Binder._add] - Bad class constructed")
		end

		assert(if p1._instToClass[p2] == nil then true else false, "Overwrote")
		p1._allClassSet[v2] = true
		p1._instToClass[p2] = v2

		local v4 = p1._listeners[p2]

		if v4 then
			local v5 = Instance.new("BindableEvent")

			for k, v in pairs(v4) do
				local v6 = v5.Event:Connect(function() --[[ Line: 245 | Upvalues: k (copy), v2 (ref) ]]
					k(v2)
				end)

				v5:Fire()
				v6:Disconnect()
			end

			v5:Destroy()
		end

		if not p1._classAddedSignal then
			return
		end

		p1._classAddedSignal:Fire(v2, p2)
	else
		warn(("[Binder._add] - Failed to load instance %q of %q, removed while loading!"):format(p2:GetFullName(), (tostring(type(p1._constructor) == "table" and p1._constructor.ClassName or p1._constructor))))
	end
end
function t._remove(p1, p2) --[[ _remove | Line: 261 ]]
	p1._pendingInstSet[p2] = nil

	local v1 = p1._instToClass[p2]

	if v1 == nil then
		return
	end

	if p1._classRemovingSignal then
		p1._classRemovingSignal:Fire(v1, p2)
	end

	p1._instToClass[p2] = nil
	p1._allClassSet[v1] = nil

	local v2 = p1._listeners[p2]

	if v2 then
		local v3 = Instance.new("BindableEvent")

		for k, v in pairs(v2) do
			local v4 = v3.Event:Connect(function() --[[ Line: 284 | Upvalues: k (copy) ]]
				k(nil)
			end)

			v3:Fire()
			v4:Disconnect()
		end

		v3:Destroy()
	end

	if v1.Destroy then
		v1:Destroy()
	else
		local v5 = warn

		v5(("[Binder._remove] - Class %q no longer has destroy, something destroyed it!"):format((tostring(p1._tagName))))
	end
end
function t.Destroy(p1) --[[ Destroy | Line: 304 ]]
	local v1, v2 = next(p1._instToClass)

	while v2 ~= nil do
		p1:_remove(v2)
		assert(p1._instToClass[v1] == nil)
	end

	p1._maid:DoCleaning()
end

return t