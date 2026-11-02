-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local v1 = nil
local Asserts = require(game:GetService("ReplicatedStorage").Library.Asserts)

local function acquireRunnerThreadAndCallEventHandler(p1, ...) --[[ acquireRunnerThreadAndCallEventHandler | Line: 47 | Upvalues: v1 (ref) ]]
	local v12 = v1

	v1 = nil
	p1(...)
	v1 = v12
end

local function runEventHandlerInFreeThread(...) --[[ runEventHandlerInFreeThread | Line: 58 | Upvalues: acquireRunnerThreadAndCallEventHandler (copy) ]]
	acquireRunnerThreadAndCallEventHandler(...)

	while true do
		acquireRunnerThreadAndCallEventHandler(coroutine.yield())
	end
end

local function getOrCreateReusableRunnerThread(...) --[[ getOrCreateReusableRunnerThread | Line: 65 | Upvalues: v1 (ref), runEventHandlerInFreeThread (copy) ]]
	if not v1 then
		v1 = coroutine.create(runEventHandlerInFreeThread)
	end

	task.spawn(v1, ...)
end

local t = {}

t.__index = t
function t.Disconnect(p1) --[[ Disconnect | Line: 91 ]]
	if not p1.Connected then
		return
	end

	p1.Connected = false

	if p1._signal._handlerListHead == p1 then
		p1._signal._handlerListHead = p1._next

		return
	end

	local _handlerListHead = p1._signal._handlerListHead

	while _handlerListHead and _handlerListHead._next ~= p1 do
		_handlerListHead = _handlerListHead._next
	end

	if not _handlerListHead then
		return
	end

	_handlerListHead._next = p1._next
end
t.Destroy = t.Disconnect
setmetatable(t, {
	__index = function(p1, p2) --[[ __index | Line: 118 ]]
		error(("Attempt to get Connection::%s (not a valid member)"):format((tostring(p2))), 2)
	end,
	__newindex = function(p1, p2, p3) --[[ __newindex | Line: 121 ]]
		error(("Attempt to set Connection::%s (not a valid member)"):format((tostring(p2))), 2)
	end
})

local t3 = {}

t3.__index = t3
function t3._deployStickyBehavior(p1, p2) --[[ _deployStickyBehavior | Line: 158 | Upvalues: getOrCreateReusableRunnerThread (copy) ]]
	local v1 = rawget(p1, "_stickyBehavior")

	if v1 then
		getOrCreateReusableRunnerThread(v1, p2)
	end
end
function t3.new(p1) --[[ new | Line: 172 | Upvalues: Asserts (copy), t3 (copy) ]]
	Asserts.optional.func(p1)

	return setmetatable({
		_handlerListHead = false,
		_proxyHandler = nil,
		_yieldedThreads = nil,
		_stickyBehavior = p1
	}, t3)
end
function t3.Wrap(p1) --[[ Wrap | Line: 198 | Upvalues: t3 (copy) ]]
	local v1 = typeof(p1) == "RBXScriptSignal"

	assert(v1, "Argument #1 to Signal.Wrap must be a RBXScriptSignal; got " .. typeof(p1))

	local v3 = t3.new()

	v3._proxyHandler = p1:Connect(function(...) --[[ Line: 205 | Upvalues: v3 (copy) ]]
		v3:Fire(...)
	end)

	return v3
end
function t3.Is(p1) --[[ Is | Line: 218 | Upvalues: t3 (copy) ]]
	return if type(p1) == "table" then getmetatable(p1) == t3 else false
end
function t3.Connect(p1, p2) --[[ Connect | Line: 235 | Upvalues: t (copy) ]]
	local v2 = setmetatable({
		Connected = true,
		_next = false,
		_signal = p1,
		_fn = p2
	}, t)

	if p1._handlerListHead then
		v2._next = p1._handlerListHead
	end

	p1._handlerListHead = v2
	p1:_deployStickyBehavior(p2)

	return v2
end
function t3.ConnectOnce(p1, p2) --[[ ConnectOnce | Line: 259 ]]
	return p1:Once(p2)
end
function t3.Once(p1, p2) --[[ Once | Line: 278 ]]
	local v1 = nil
	local v2 = false

	v1 = p1:Connect(function(...) --[[ Line: 282 | Upvalues: v2 (ref), v1 (ref), p2 (copy) ]]
		if not v2 then
			v2 = true
			v1:Disconnect()
			p2(...)
		end
	end)

	return v1
end
function t3.GetConnections(p1) --[[ GetConnections | Line: 295 ]]
	local _handlerListHead = p1._handlerListHead
	local t = {}

	while _handlerListHead do
		table.insert(t, _handlerListHead)
		_handlerListHead = _handlerListHead._next
	end

	return t
end
function t3.DisconnectAll(p1) --[[ DisconnectAll | Line: 315 ]]
	local _handlerListHead = p1._handlerListHead

	while _handlerListHead do
		_handlerListHead.Connected = false
		_handlerListHead = _handlerListHead._next
	end

	p1._handlerListHead = false

	local v1 = rawget(p1, "_yieldedThreads")

	if not v1 then
		return
	end

	for v2 in v1 do
		if coroutine.status(v2) == "suspended" then
			warn(debug.traceback(v2, "signal disconnected; yielded thread cancelled", 2))
			task.cancel(v2)
		end
	end

	table.clear(p1._yieldedThreads)
end
function t3.Fire(p1, ...) --[[ Fire | Line: 350 | Upvalues: getOrCreateReusableRunnerThread (copy) ]]
	local _handlerListHead = p1._handlerListHead

	while _handlerListHead do
		if _handlerListHead.Connected then
			getOrCreateReusableRunnerThread(_handlerListHead._fn, ...)
		end

		_handlerListHead = _handlerListHead._next
	end
end
function t3.FireDeferred(p1, ...) --[[ FireDeferred | Line: 368 ]]
	local _handlerListHead = p1._handlerListHead

	while _handlerListHead do
		local v1 = _handlerListHead

		task.defer(function(...) --[[ Line: 372 | Upvalues: v1 (copy) ]]
			if not v1.Connected then
				return
			end

			v1._fn(...)
		end, ...)
		_handlerListHead = _handlerListHead._next
	end
end
function t3.Wait(p1) --[[ Wait | Line: 396 ]]
	local v1 = rawget(p1, "_yieldedThreads")

	if not v1 then
		v1 = {}
		rawset(p1, "_yieldedThreads", v1)
	end

	local v2 = coroutine.running()

	v1[v2] = true
	p1:Once(function(...) --[[ Line: 406 | Upvalues: v1 (ref), v2 (copy) ]]
		v1[v2] = nil

		if coroutine.status(v2) ~= "suspended" then
			return
		end

		task.spawn(v2, ...)
	end)

	return coroutine.yield()
end
function t3.Destroy(p1, p2) --[[ Destroy | Line: 429 ]]
	p1:DisconnectAll()

	local v1 = rawget(p1, "_proxyHandler")

	if v1 then
		v1:Disconnect()
	end

	if p2 then
		setmetatable(p1, nil)
		table.clear(p1)
	end
end
setmetatable(t3, {
	__index = function(p1, p2) --[[ __index | Line: 446 ]]
		error(("Attempt to get Signal::%s (not a valid member)"):format((tostring(p2))), 2)
	end,
	__newindex = function(p1, p2, p3) --[[ __newindex | Line: 449 ]]
		error(("Attempt to set Signal::%s (not a valid member)"):format((tostring(p2))), 2)
	end
})

return table.freeze({
	new = t3.new,
	Wrap = t3.Wrap,
	Is = t3.Is
})