-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {}

t.__index = t
t.Errors = {
	Stopped = "Stopped",
	Timeout = "Timeout"
}
function t._new(p1, p2, ...) --[[ _new | Line: 54 | Upvalues: t (copy) ]]
	local v2 = setmetatable({
		_completed = false,
		_res = nil,
		_err = nil,
		_thread = nil,
		_awaitingThreads = {}
	}, t)

	v2._thread = p2(function(...) --[[ Line: 63 | Upvalues: p1 (copy), v2 (copy) ]]
		local v1 = table.pack(pcall(p1, ...))

		v2._completed = true
		v2._err = if v1[1] then nil else v1[2]

		if v2._err == nil then
			local v4 = table.move(v1, 2, #v1, 1, table.create(#v1 - 1))

			v2._res = v4

			for i, v in ipairs(v2._awaitingThreads) do
				local v5 = task.spawn

				v5(v, nil, table.unpack(v4, 1, v4.n))
			end
		else
			for i, v in ipairs(v2._awaitingThreads) do
				task.spawn(v, v2._err)
			end
		end
	end, ...)

	return v2
end
function t.spawn(p1, ...) --[[ spawn | Line: 100 | Upvalues: t (copy) ]]
	if type(p1) ~= "function" then
		error("Concur.spawn argument must be a function; got " .. type(p1), 2)
	end

	return t._new(p1, task.spawn, ...)
end
function t.defer(p1, ...) --[[ defer | Line: 110 | Upvalues: t (copy) ]]
	if type(p1) ~= "function" then
		error("Concur.defer argument must be a function; got " .. type(p1), 2)
	end

	return t._new(p1, task.defer, ...)
end
function t.delay(p1, p2, ...) --[[ delay | Line: 120 | Upvalues: t (copy) ]]
	if type(p2) ~= "function" then
		error("Concur.delay argument must be a function; got " .. type(p2), 2)
	end

	return t._new(p2, function(...) --[[ Line: 124 | Upvalues: p1 (copy) ]]
		return task.delay(p1, ...)
	end, ...)
end
function t.value(p1) --[[ value | Line: 139 | Upvalues: t (copy) ]]
	return t.spawn(function() --[[ Line: 140 | Upvalues: p1 (copy) ]]
		return p1
	end)
end
function t.event(p1, p2) --[[ event | Line: 163 | Upvalues: t (copy) ]]
	local v1 = nil
	local v2 = nil

	v1 = p1:Connect(function(...) --[[ Line: 166 | Upvalues: v2 (ref), p2 (copy), v1 (ref) ]]
		if not v2 then
			return
		end

		if p2 ~= nil and not p2(...) then
			return
		end

		v1:Disconnect()
		task.spawn(v2, ...)
	end)

	local v3 = t.spawn(function() --[[ Line: 176 | Upvalues: v2 (ref) ]]
		v2 = coroutine.running()

		return coroutine.yield()
	end)

	v3:OnCompleted(function(p1) --[[ Line: 181 | Upvalues: v1 (ref), v2 (ref) ]]
		v1:Disconnect()

		if coroutine.status(v2) ~= "suspended" then
			return
		end

		task.spawn(v2, p1)
	end)

	return v3
end
function t.all(p1) --[[ all | Line: 215 | Upvalues: t (copy) ]]
	if #p1 == 0 then
		return t.value(nil)
	end

	return t.spawn(function() --[[ Line: 220 | Upvalues: p1 (copy) ]]
		local v1 = #p1
		local v2 = coroutine.running()
		local v3 = table.create(v1)
		local v4 = 0

		for i, v in ipairs(p1) do
			v:OnCompleted(function(...) --[[ Line: 226 | Upvalues: v3 (copy), i (copy), v4 (ref), v1 (copy), v2 (copy) ]]
				v3[i] = table.pack(...)
				v4 = v4 + 1

				if not (v1 <= v4) or coroutine.status(v2) ~= "suspended" then
					return
				end

				task.spawn(v2)
			end)
		end

		if not (v4 < v1) then
			return v3
		end

		coroutine.yield()

		return v3
	end)
end
function t.first(p1) --[[ first | Line: 259 | Upvalues: t (copy) ]]
	if #p1 == 0 then
		return t.value(nil)
	end

	return t.spawn(function() --[[ Line: 264 | Upvalues: p1 (copy) ]]
		local v1 = coroutine.running()
		local v2 = nil
		local v3 = nil

		for i, v in ipairs(p1) do
			v:OnCompleted(function(p1, ...) --[[ Line: 269 | Upvalues: v2 (ref), v3 (ref), v (copy), v1 (copy) ]]
				if v2 or p1 ~= nil then
					return
				end

				v3 = v
				v2 = table.pack(...)

				if coroutine.status(v1) ~= "suspended" then
					return
				end

				task.spawn(v1)
			end)
		end

		if v2 == nil then
			coroutine.yield()
		end

		for i, v in ipairs(p1) do
			if v ~= v3 then
				v:Stop()
			end
		end

		local n = v2.n

		return table.unpack(v2, 1, n)
	end)
end
function t.Stop(p1) --[[ Stop | Line: 310 | Upvalues: t (copy) ]]
	if p1._completed then
		return
	end

	p1._completed = true
	p1._err = t.Errors.Stopped
	task.cancel(p1._thread)

	for i, v in ipairs(p1._awaitingThreads) do
		task.spawn(v, t.Errors.Stopped)
	end
end
function t.IsCompleted(p1) --[[ IsCompleted | Line: 325 ]]
	return p1._completed
end
function t.Await(p1, p2) --[[ Await | Line: 402 | Upvalues: t (copy) ]]
	if p1._completed then
		if p1._err ~= nil then
			return p1._err
		end

		local v1 = nil

		if p1._res == nil then
			return v1, nil
		end

		return v1, table.unpack(p1._res, 1, p1._res.n)
	end

	local v2 = coroutine.running()

	table.insert(p1._awaitingThreads, v2)

	if not p2 then
		return coroutine.yield()
	end

	local v3 = task.delay(p2, function() --[[ Line: 415 | Upvalues: p1 (copy), v2 (copy), t (ref) ]]
		local v1 = table.find(p1._awaitingThreads, v2)

		if not v1 then
			return
		end

		table.remove(p1._awaitingThreads, v1)
		task.spawn(v2, t.Errors.Timeout)
	end)
	local v4 = table.pack(coroutine.yield())
	local v5

	if coroutine.status(v3) == "normal" then
		v5 = v4.n

		return table.unpack(v4, 1, v5)
	end

	task.cancel(v3)
	v5 = v4.n

	return table.unpack(v4, 1, v5)
end
function t.OnCompleted(p1, p2, p3) --[[ OnCompleted | Line: 517 ]]
	local v1 = task.spawn(function() --[[ Line: 518 | Upvalues: p2 (copy), p1 (copy), p3 (copy) ]]
		p2(p1:Await(p3))
	end)

	return function() --[[ Line: 523 | Upvalues: v1 (copy), p1 (copy) ]]
		task.cancel(v1)

		local v12 = table.find(p1._awaitingThreads, v1)

		if not v12 then
			return
		end

		table.remove(p1._awaitingThreads, v12)
	end
end

return t