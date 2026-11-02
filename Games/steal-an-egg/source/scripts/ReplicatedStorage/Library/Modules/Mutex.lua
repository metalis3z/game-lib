-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Asserts = require(ReplicatedStorage.Library.Asserts)
local t = {}

t.__index = t
function t.new() --[[ new | Line: 23 | Upvalues: t (copy) ]]
	return setmetatable({
		locked = false,
		counter = 0,
		waiters = {}
	}, t)
end
function t.nextCounter(p1) --[[ nextCounter | Line: 31 ]]
	local counter = p1.counter

	p1.counter = p1.counter + 1

	return counter
end
function t.getLock(p1) --[[ getLock | Line: 38 ]]
	return p1.lockHolder
end
function t.tryLock(p1) --[[ tryLock | Line: 42 ]]
	if p1.lockHolder then
		return nil
	end

	local v1 = p1:nextCounter()

	p1.lockHolder = v1

	return v1
end
function t.lock(p1) --[[ lock | Line: 53 ]]
	local v1 = p1:tryLock()

	if v1 == nil then
		local v2 = coroutine.running()

		table.insert(p1.waiters, v2)

		return coroutine.yield()
	end

	return v1
end
function t.unlock(p1, p2) --[[ unlock | Line: 64 | Upvalues: Asserts (copy) ]]
	Asserts.number(p2)
	assert(p2 == p1.lockHolder, (("Attempt to unlock mutex with the wrong lockHolder: %*, current holder: %*"):format(p2, p1.lockHolder)))
	p1.lockHolder = nil

	local v2

	repeat
		if not (#p1.waiters > 0) then
			return
		end

		local remove = table.remove

		v2 = assert(remove(p1.waiters, 1))
	until coroutine.status(v2) == "suspended"

	local v3 = p1:nextCounter()

	p1.lockHolder = v3
	task.delay(0, v2, v3)
end
function t.wrun(p1, p2, ...) --[[ wrun | Line: 83 ]]
	local v1 = p1:lock()
	local v2 = nil
	local v3 = nil
	local v4 = table.pack(xpcall(p2, function(p1) --[[ Line: 88 | Upvalues: v2 (ref), v3 (ref) ]]
		v2 = tostring(p1)
		v3 = tostring(debug.traceback(nil, 3))
	end, ...))

	p1:unlock(v1)

	local v5 = v4[1]

	if v5 == true then
		return v5, table.unpack(v4, 2)
	end

	local v6 = v2
	local v7 = v3

	error((("[Mutex] %*\nStack Begin\n%*Stack End"):format(tostring(v6), (tostring(v7)))))
end
function t.run(p1, p2, ...) --[[ run | Line: 103 ]]
	local v1 = p1:lock()
	local v2 = nil
	local v3 = nil
	local v4 = table.pack(xpcall(p2, function(p1) --[[ Line: 108 | Upvalues: v2 (ref), v3 (ref) ]]
		v2 = tostring(p1)
		v3 = tostring(debug.traceback(nil, 3))
	end, ...))

	p1:unlock(v1)

	if v4[1] == true then
		return table.unpack(v4, 2)
	end

	local v5 = v2
	local v6 = v3

	error((("[Mutex] %*\nStack Begin\n%*Stack End"):format(tostring(v5), (tostring(v6)))))
end
function t.async(p1, p2, ...) --[[ async | Line: 121 ]]
	task.spawn(function(...) --[[ Line: 122 | Upvalues: p1 (copy), p2 (copy) ]]
		local v1 = p1:lock()
		local v2 = nil
		local v3 = nil
		local ok = xpcall(p2, function(p1) --[[ Line: 127 | Upvalues: v2 (ref), v3 (ref) ]]
			v2 = tostring(p1)
			v3 = tostring(debug.traceback(nil, 3))
		end, ...)

		p1:unlock(v1)

		if ok ~= true then
			error((("[Mutex] %*\nStack Begin\n%*Stack End"):format(tostring(v2), (tostring(v3)))))
		end
	end, ...)
end
function t.Destroy(p1) --[[ Destroy | Line: 139 ]]
	if p1.lockHolder == nil then
		table.clear(p1)
		setmetatable(p1, nil)
	end
end
t.destroy = t.Destroy

return t