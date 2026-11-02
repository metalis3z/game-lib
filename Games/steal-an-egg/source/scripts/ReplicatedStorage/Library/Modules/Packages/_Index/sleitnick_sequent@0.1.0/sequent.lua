-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {}

t.__index = t
function t.Disconnect(p1) --[[ Disconnect | Line: 60 ]]
	p1._sequent:_disconnect(p1)
end

local t2 = {}

t2.__index = t2
function t2.new(p1) --[[ new | Line: 123 | Upvalues: t2 (copy) ]]
	return setmetatable({
		_firing = false,
		_queuedDisconnect = false,
		_firingThread = nil,
		_taskThread = nil,
		_connections = {},
		_cancellable = p1 and true or false
	}, t2)
end
function t2.Fire(p1, p2) --[[ Fire | Line: 145 ]]
	assert(not p1._firing, "cannot fire while already firing")
	p1._firing = true

	local v2 = false
	local v3 = table.freeze({
		Value = p2,
		Cancellable = p1._cancellable,
		Cancel = function(p12) --[[ Cancel | Line: 153 | Upvalues: p1 (copy), v2 (ref) ]]
			if p1._cancellable then
				v2 = true
			else
				warn("attempted to cancel non-cancellable event")
			end
		end
	})
	local v4 = coroutine.running()

	p1._firingThread = v4

	for v5, v6 in p1._connections do
		if v6.Connected then
			local v7 = nil
			local v8 = nil
			local v9 = task.spawn(function() --[[ Line: 171 | Upvalues: p1 (copy), v6 (copy), v3 (copy), v4 (copy), v7 (ref), v8 (ref) ]]
				p1._taskThread = coroutine.running()

				local ok, result = pcall(function() --[[ Line: 174 | Upvalues: v6 (ref), v3 (ref) ]]
					v6._callback(v3)
				end)

				p1._taskThread = nil

				if coroutine.status(v4) == "suspended" then
					task.spawn(v4, ok, result)
				else
					v7 = ok
					v8 = result
				end
			end)

			if v7 == nil then
				local v10, v11 = coroutine.yield()

				v7 = v10
				v8 = v11
			end

			p1._firingThread = nil

			if not v7 then
				error(debug.traceback(v9, (tostring(v8))))
			end

			if v2 then
				break
			end
		end
	end

	if p1._queuedDisconnect then
		p1._queuedDisconnect = false

		for i = #p1._connections, 1, -1 do
			local v12 = p1._connections[i]

			if not v12.Connected then
				p1:_removeConnection(v12)
			end
		end
	end

	p1._firing = false
end
function t2.IsFiring(p1) --[[ IsFiring | Line: 222 ]]
	return p1._firing
end
function t2.Connect(p1, p2, p3) --[[ Connect | Line: 234 | Upvalues: t (copy) ]]
	assert(not p1._firing, "cannot connect while firing")

	local v3 = setmetatable({
		Connected = true,
		_callback = p2,
		_priority = p3,
		_sequent = p1
	}, t)
	local v4 = #p1._connections + 1

	for v5, v6 in p1._connections do
		if v6._priority < p3 then
			v4 = v5

			break
		end
	end

	table.insert(p1._connections, v4, v3)

	return v3
end
function t2.Once(p1, p2, p3) --[[ Once | Line: 262 ]]
	local v1 = nil

	v1 = p1:Connect(function(...) --[[ Line: 265 | Upvalues: v1 (ref), p2 (copy) ]]
		if v1.Connected then
			v1:Disconnect()
			p2(...)
		end
	end, p3)

	return v1
end
function t2.Cancel(p1) --[[ Cancel | Line: 279 ]]
	if not p1._firing then
		return
	end

	if p1._taskThread == coroutine.running() then
		error("cannot cancel sequent from connected task", 2)
	end

	if p1._taskThread then
		pcall(function() --[[ Line: 291 | Upvalues: p1 (copy) ]]
			task.cancel(p1._taskThread)
		end)
		p1._taskThread = nil
	end

	if not p1._firingThread then
		return
	end

	local _firingThread = p1._firingThread

	p1._firingThread = nil
	task.spawn(_firingThread, true)
end
function t2.Destroy(p1) --[[ Destroy | Line: 308 ]]
	p1:Cancel()

	for v1, v2 in p1._connections do
		v2.Connected = false
	end
end
function t2._disconnect(p1, p2) --[[ _disconnect | Line: 316 ]]
	if not p2.Connected then
		return
	end

	p2.Connected = false

	if p1._firing then
		p1._queuedDisconnect = true
	else
		p1:_removeConnection(p2)
	end
end
function t2._removeConnection(p1, p2) --[[ _removeConnection | Line: 330 ]]
	local v1 = table.find(p1._connections, p2)

	if not v1 then
		return
	end

	table.remove(p1._connections, v1)
end

return table.freeze({
	new = t2.new,
	Priority = {
		Highest = (1 / 0),
		High = 1000,
		Normal = 0,
		Low = -1000,
		Lowest = (-1 / 0)
	}
})