
local u1 = nil

local function acquireRunnerThreadAndCallEventHandler(p1, ...)
	local v7 = u1

	u1 = nil
	p1(...)
	u1 = v7
end
local function runEventHandlerInFreeThread(...)
	acquireRunnerThreadAndCallEventHandler(...)

	while true do
		acquireRunnerThreadAndCallEventHandler(coroutine.yield())
	end
end

local t1 = {}

t1.__index = t1

function t1.Disconnect(p2)
	if not p2.Connected then
		return
	end

	p2.Connected = false

	if p2 == p2._signal._handlerListHead then
		p2._signal._handlerListHead = p2._next

		return
	end

	local _handlerListHead = p2._signal._handlerListHead

	while _handlerListHead and p2 ~= _handlerListHead._next do
		_handlerListHead = _handlerListHead._next
	end

	if _handlerListHead then
		_handlerListHead._next = p2._next
	end
end

t1.Destroy = t1.Disconnect
setmetatable(t1, {
	__index = function(_, p4)
		error(("Attempt to get Connection::%s (not a valid member)"):format((tostring(p4))), 2)
	end,
	__newindex = function(_, p6, _)
		error(("Attempt to set Connection::%s (not a valid member)"):format((tostring(p6))), 2)
	end
})

local t2 = {}

t2.__index = t2

function t2.new()
	return (setmetatable({
		_handlerListHead = false,
		_proxyHandler = nil,
		_yieldedThreads = nil
	}, t2))
end
function t2.Wrap(p8)
	assert(typeof(p8) == "RBXScriptSignal", "Argument #1 to Signal.Wrap must be a RBXScriptSignal; got " .. typeof(p8))

	local v16 = t2.new()

	v16._proxyHandler = p8:Connect(function(...)
		v16:Fire(...)
	end)

	return v16
end
function t2.Is(p9)
	return type(p9) == "table" and getmetatable(p9) == t2
end
function t2.Connect(p10, p11)
	local v20 = setmetatable({
		Connected = true,
		_next = false,
		_signal = p10,
		_fn = p11
	}, t1)

	if p10._handlerListHead then
		v20._next = p10._handlerListHead
		p10._handlerListHead = v20

		return v20
	end

	p10._handlerListHead = v20

	return v20
end
function t2.ConnectOnce(p12, p13)
	return p12:Once(p13)
end
function t2.Once(p14, p15)
	local connection = nil
	local u26 = false

	connection = p14:Connect(function(...)
		if u26 then
			return
		end

		u26 = true
		connection:Disconnect()
		p15(...)
	end)

	return connection
end
function t2.GetConnections(p16)
	local t3 = {}
	local _handlerListHead = p16._handlerListHead

	while _handlerListHead do
		table.insert(t3, _handlerListHead)
		_handlerListHead = _handlerListHead._next
	end

	return t3
end
function t2.DisconnectAll(p17)
	local _handlerListHead = p17._handlerListHead

	while _handlerListHead do
		_handlerListHead.Connected = false
		_handlerListHead = _handlerListHead._next
	end

	p17._handlerListHead = false

	local v32 = rawget(p17, "_yieldedThreads")

	if v32 then
		for v33 in v32 do
			if coroutine.status(v33) == "suspended" then
				warn(debug.traceback(v33, "signal disconnected; yielded thread cancelled", 2))
				task.cancel(v33)
			end
		end

		table.clear(p17._yieldedThreads)
	end
end
function t2.Fire(p18, ...)
	local _handlerListHead = p18._handlerListHead

	while _handlerListHead do
		if _handlerListHead.Connected then
			if not u1 then
				u1 = coroutine.create(runEventHandlerInFreeThread)
			end

			task.spawn(u1, _handlerListHead._fn, ...)
		end

		_handlerListHead = _handlerListHead._next
	end
end
function t2.FireDeferred(p19, ...)
	local _handlerListHead = p19._handlerListHead

	while _handlerListHead do
		local v38 = _handlerListHead

		task.defer(function(...)
			if v38.Connected then
				v38._fn(...)
			end
		end, ...)
		_handlerListHead = _handlerListHead._next
	end
end
function t2.Wait(p20)
	local u40 = rawget(p20, "_yieldedThreads")

	if not u40 then
		u40 = {}
		rawset(p20, "_yieldedThreads", u40)
	end

	local thread = coroutine.running()

	u40[thread] = true
	p20:Once(function(...)
		u40[thread] = nil

		if coroutine.status(thread) == "suspended" then
			task.spawn(thread, ...)
		end
	end)

	return coroutine.yield()
end
function t2.Destroy(p21)
	p21:DisconnectAll()

	local v43 = rawget(p21, "_proxyHandler")

	if v43 then
		v43:Disconnect()
	end
end

setmetatable(t2, {
	__index = function(_, p23)
		error(("Attempt to get Signal::%s (not a valid member)"):format((tostring(p23))), 2)
	end,
	__newindex = function(_, p25, _)
		error(("Attempt to set Signal::%s (not a valid member)"):format((tostring(p25))), 2)
	end
})

return table.freeze({
	new = t2.new,
	Wrap = t2.Wrap,
	Is = t2.Is
})
