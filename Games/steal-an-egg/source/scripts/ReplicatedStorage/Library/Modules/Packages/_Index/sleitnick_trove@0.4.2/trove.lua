-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local v1 = newproxy()
local v2 = newproxy()
local RunService = game:GetService("RunService")

local function GetObjectCleanupFunction(p1, p2) --[[ GetObjectCleanupFunction | Line: 10 | Upvalues: v1 (copy), v2 (copy) ]]
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
		if typeof(p1.Destroy) == "function" then
			return "Destroy"
		end

		if typeof(p1.Disconnect) == "function" then
			return "Disconnect"
		end
	end

	error("Failed to get cleanup function for object " .. v12 .. ": " .. tostring(p1), 3)
end

local function AssertPromiseLike(p1) --[[ AssertPromiseLike | Line: 34 ]]
	if type(p1) == "table" and (type(p1.getStatus) == "function" and (type(p1.finally) == "function" and type(p1.cancel) == "function")) then
		return
	end

	error("Did not receive a Promise as an argument", 3)
end

local t = {}

t.__index = t
function t.new() --[[ new | Line: 57 | Upvalues: t (copy) ]]
	local v2 = setmetatable({}, t)

	v2._objects = {}

	return v2
end
function t.Extend(p1) --[[ Extend | Line: 82 | Upvalues: t (copy) ]]
	return p1:Construct(t)
end
function t.Clone(p1, p2) --[[ Clone | Line: 90 ]]
	return p1:Add(p2:Clone())
end
function t.Construct(p1, p2, ...) --[[ Construct | Line: 127 ]]
	local v1 = nil
	local v2 = type(p2)

	if v2 == "table" then
		v1 = p2.new(...)
	elseif v2 == "function" then
		v1 = p2(...)
	end

	return p1:Add(v1)
end
function t.Connect(p1, p2, p3) --[[ Connect | Line: 153 ]]
	return p1:Add(p2:Connect(p3))
end
function t.BindToRenderStep(p1, p2, p3, p4) --[[ BindToRenderStep | Line: 170 | Upvalues: RunService (copy) ]]
	RunService:BindToRenderStep(p2, p3, p4)
	p1:Add(function() --[[ Line: 172 | Upvalues: RunService (ref), p2 (copy) ]]
		RunService:UnbindFromRenderStep(p2)
	end)
end
function t.AddPromise(p1, p2) --[[ AddPromise | Line: 200 ]]
	if type(p2) == "table" and (type(p2.getStatus) == "function" and type(p2.finally) == "function") then
		if type(p2.cancel) ~= "function" then
			error("Did not receive a Promise as an argument", 3)
		end
	else
		error("Did not receive a Promise as an argument", 3)
	end

	if p2:getStatus() == "Started" then
		p2:finally(function() --[[ Line: 203 | Upvalues: p1 (copy), p2 (copy) ]]
			return p1:_findAndRemoveFromObjects(p2, false)
		end)
		p1:Add(p2, "cancel")
	end

	return p2
end
function t.Add(p1, p2, p3) --[[ Add | Line: 259 | Upvalues: GetObjectCleanupFunction (copy) ]]
	local v1 = GetObjectCleanupFunction(p2, p3)

	table.insert(p1._objects, { p2, v1 })

	return p2
end
function t.Remove(p1, p2, ...) --[[ Remove | Line: 275 ]]
	return p1:_findAndRemoveFromObjects(p2, true, ...)
end
function t.Clean(p1) --[[ Clean | Line: 284 ]]
	for i, v in ipairs(p1._objects) do
		p1:_cleanupObject(v[1], v[2])
	end

	table.clear(p1._objects)
end
function t._findAndRemoveFromObjects(p1, p2, p3, ...) --[[ _findAndRemoveFromObjects | Line: 291 ]]
	local _objects = p1._objects

	for i, v in ipairs(_objects) do
		if v[1] == p2 then
			local v1 = #_objects

			_objects[i] = _objects[v1]
			_objects[v1] = nil

			if not p3 then
				return true
			end

			p1:_cleanupObject(v[1], v[2], ...)

			return true
		end
	end

	return false
end
function t._cleanupObject(p1, p2, p3, ...) --[[ _cleanupObject | Line: 307 | Upvalues: v1 (copy), v2 (copy) ]]
	if p3 == v1 then
		p2()

		return
	end

	if p3 == v2 then
		coroutine.close(p2)

		return
	end

	if typeof(p3) == "function" then
		p3(p2, ...)
	else
		p2[p3](p2)
	end
end
function t.AttachToInstance(p1, p2) --[[ AttachToInstance | Line: 332 ]]
	assert(p2:IsDescendantOf(game), "Instance is not a descendant of the game hierarchy")

	return p1:Connect(p2.Destroying, function() --[[ Line: 334 | Upvalues: p1 (copy) ]]
		p1:Destroy()
	end)
end
function t.Destroy(p1) --[[ Destroy | Line: 342 ]]
	p1:Clean()
end

return t