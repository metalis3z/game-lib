--credit to leon games studio
local RunService = game:GetService("RunService")
local v1 = newproxy()
local v2 = newproxy()
local v3 = table.freeze({ "Destroy", "Disconnect", "destroy", "disconnect" })

local function GetObjectCleanupFunction(p1, p2) --[[ GetObjectCleanupFunction | Line: 124 | Upvalues: v1 (copy), v2 (copy), v3 (copy) ]]
	local v12 = typeof(p1)

	if v12 == "function" then
		return v1
	end

	if v12 == "thread" then
		return v2
	end

	if p2 then
		return p2
	end

	if v12 == "Instance" then
		return "Destroy"
	end

	if v12 == "RBXScriptConnection" then
		return "Disconnect"
	end

	if v12 == "table" then
		for v22, v32 in v3 do
			if typeof(p1[v32]) == "function" then
				return v32
			end
		end
	end

	error(("failed to get cleanup function for object %*: %*"):format(v12, p1), 3)
end

local function AssertPromiseLike(p1) --[[ AssertPromiseLike | Line: 152 ]]
	if typeof(p1) == "table" and (typeof(p1.getStatus) == "function" and (typeof(p1.finally) == "function" and typeof(p1.cancel) == "function")) then
		return
	end

	error("did not receive a promise as an argument", 3)
end

local t = {}

t.__index = t
function t.new() --[[ new | Line: 179 | Upvalues: t (copy) ]]
	local v2 = setmetatable({}, t)

	v2._objects = {}
	v2._cleaning = false

	return v2
end
function t.Add(p1, p2, p3) --[[ Add | Line: 188 | Upvalues: GetObjectCleanupFunction (copy) ]]
	if not p1._cleaning then
		local v1, v2

		v1 = GetObjectCleanupFunction(p2, p3)
		v2 = p1._objects
		table.insert(v2, { p2, v1 })

		return p2
	end

	error("cannot call trove:Add() while cleaning", 2)
end
function t.Clone(p1, p2) --[[ Clone | Line: 210 ]]
	if not p1._cleaning then
		return p1:Add(p2:Clone())
	end

	error("cannot call trove:Clone() while cleaning", 2)
end
function t.Construct(p1, p2, ...) --[[ Construct | Line: 253 ]]
	if p1._cleaning then
		error("Cannot call trove:Construct() while cleaning", 2)
	end

	local v1 = nil
	local v2 = type(p2)

	if v2 == "table" then
		v1 = p2.new(...)
	elseif v2 == "function" then
		v1 = p2(...)
	end

	return p1:Add(v1)
end
function t.Connect(p1, p2, p3) --[[ Connect | Line: 269 ]]
	if not p1._cleaning then
		return p1:Add(p2:Connect(p3))
	end

	error("Cannot call trove:Connect() while cleaning", 2)
end
function t.BindToRenderStep(p1, p2, p3, p4) --[[ BindToRenderStep | Line: 292 | Upvalues: RunService (copy) ]]
	if p1._cleaning then
		error("cannot call trove:BindToRenderStep() while cleaning", 2)
	end

	RunService:BindToRenderStep(p2, p3, p4)
	p1:Add(function() --[[ Line: 299 | Upvalues: RunService (ref), p2 (copy) ]]
		RunService:UnbindFromRenderStep(p2)
	end)
end
function t.AddPromise(p1, p2) --[[ AddPromise | Line: 304 ]]
	if p1._cleaning then
		error("cannot call trove:AddPromise() while cleaning", 2)
	end

	if typeof(p2) == "table" and (typeof(p2.getStatus) == "function" and typeof(p2.finally) == "function") then
		if typeof(p2.cancel) ~= "function" then
			error("did not receive a promise as an argument", 3)
		end
	else
		error("did not receive a promise as an argument", 3)
	end

	if p2:getStatus() == "Started" then
		p2:finally(function() --[[ Line: 311 | Upvalues: p1 (copy), p2 (copy) ]]
			if not p1._cleaning then
				p1:_findAndRemoveFromObjects(p2, false)
			end
		end)
		p1:Add(p2, "cancel")
	end

	return p2
end
function t.Remove(p1, p2) --[[ Remove | Line: 336 ]]
	if not p1._cleaning then
		return p1:_findAndRemoveFromObjects(p2, true)
	end

	error("cannot call trove:Remove() while cleaning", 2)
end
function t.Extend(p1) --[[ Extend | Line: 365 | Upvalues: t (copy) ]]
	if not p1._cleaning then
		return p1:Construct(t)
	end

	error("cannot call trove:Extend() while cleaning", 2)
end
function t.Clean(p1) --[[ Clean | Line: 385 ]]
	if p1._cleaning then
		return
	end

	p1._cleaning = true

	for v1, v2 in p1._objects do
		p1:_cleanupObject(v2[1], v2[2])
	end

	table.clear(p1._objects)
	p1._cleaning = false
end
function t.WrapClean(p1) --[[ WrapClean | Line: 427 ]]
	return function() --[[ Line: 428 | Upvalues: p1 (copy) ]]
		p1:Clean()
	end
end
function t._findAndRemoveFromObjects(p1, p2, p3) --[[ _findAndRemoveFromObjects | Line: 433 ]]
	local _objects = p1._objects

	for v1, v2 in _objects do
		if v2[1] == p2 then
			local v3 = #_objects

			_objects[v1] = _objects[v3]
			_objects[v3] = nil

			if not p3 then
				return true
			end

			p1:_cleanupObject(v2[1], v2[2])

			return true
		end
	end

	return false
end
function t._cleanupObject(p1, p2, p3) --[[ _cleanupObject | Line: 453 | Upvalues: v1 (copy), v2 (copy) ]]
	if p3 == v1 then
		p2()

		return
	end

	if p3 == v2 then
		pcall(task.cancel, p2)
	else
		p2[p3](p2)
	end
end
function t.AttachToInstance(p1, p2) --[[ AttachToInstance | Line: 463 ]]
	if p1._cleaning then
		error("cannot call trove:AttachToInstance() while cleaning", 2)
	elseif not p2:IsDescendantOf(game) then
		error("instance is not a descendant of the game hierarchy", 2)
	end

	return p1:Connect(p2.Destroying, function() --[[ Line: 470 | Upvalues: p1 (copy) ]]
		p1:Destroy()
	end)
end
function t.Destroy(p1) --[[ Destroy | Line: 484 ]]
	p1:Clean()
end

return {
	new = t.new
}