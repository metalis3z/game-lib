-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local v1 = nil

local function acquireRunnerThreadAndCallEventHandler(p1, ...) --[[ acquireRunnerThreadAndCallEventHandler | Line: 53 | Upvalues: v1 (ref) ]]
	local v12 = v1

	v1 = nil
	p1(...)
	v1 = v12
end

local function runEventHandlerInFreeThread(...) --[[ runEventHandlerInFreeThread | Line: 64 | Upvalues: acquireRunnerThreadAndCallEventHandler (copy) ]]
	acquireRunnerThreadAndCallEventHandler(...)

	while true do
		acquireRunnerThreadAndCallEventHandler(coroutine.yield())
	end
end

local t = {}

t.__index = t
function t.new(p1, p2) --[[ new | Line: 90 | Upvalues: t (copy) ]]
	return setmetatable({
		Connected = true,
		_next = false,
		_signal = p1,
		_fn = p2
	}, t)
end
function t.Disconnect(p1) --[[ Disconnect | Line: 99 ]]
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
	__index = function(p1, p2) --[[ __index | Line: 126 ]]
		error(("Attempt to get Connection::%s (not a valid member)"):format((tostring(p2))), 2)
	end,
	__newindex = function(p1, p2, p3) --[[ __newindex | Line: 129 ]]
		error(("Attempt to set Connection::%s (not a valid member)"):format((tostring(p2))), 2)
	end
})

local t3 = {}

t3.__index = t3
function t3.new() --[[ new | Line: 165 | Upvalues: t3 (copy) ]]
	return setmetatable({
		_handlerListHead = false,
		_proxyHandler = nil
	}, t3)
end
function t3.Wrap(p1) --[[ Wrap | Line: 186 | Upvalues: t3 (copy) ]]
	local v1 = typeof(p1) == "RBXScriptSignal"

	assert(v1, "Argument #1 to Signal.Wrap must be a RBXScriptSignal; got " .. typeof(p1))

	local v3 = t3.new()

	v3._proxyHandler = p1:Connect(function(...) --[[ Line: 192 | Upvalues: v3 (copy) ]]
		v3:Fire(...)
	end)

	return v3
end
function t3.Is(p1) --[[ Is | Line: 204 | Upvalues: t3 (copy) ]]
	return if type(p1) == "table" then getmetatable(p1) == t3 else false
end
function t3.Connect(p1, p2) --[[ Connect | Line: 221 | Upvalues: t (copy) ]]
	local v1 = t.new(p1, p2)

	if p1._handlerListHead then
		v1._next = p1._handlerListHead
	end

	p1._handlerListHead = v1

	return v1
end
function t3.ConnectOnce(p1, p2) --[[ ConnectOnce | Line: 237 ]]
	return p1:Once(p2)
end
function t3.Once(p1, p2) --[[ Once | Line: 256 ]]
	local v1 = nil
	local v2 = false

	v1 = p1:Connect(function(...) --[[ Line: 259 | Upvalues: v2 (ref), v1 (ref), p2 (copy) ]]
		if not v2 then
			v2 = true
			v1:Disconnect()
			p2(...)
		end
	end)

	return v1
end
function t3.GetConnections(p1) --[[ GetConnections | Line: 270 ]]
	local _handlerListHead = p1._handlerListHead
	local t = {}

	while _handlerListHead do
		table.insert(t, _handlerListHead)
		_handlerListHead = _handlerListHead._next
	end

	return t
end
function t3.DisconnectAll(p1) --[[ DisconnectAll | Line: 288 ]]
	local _handlerListHead = p1._handlerListHead

	while _handlerListHead do
		_handlerListHead.Connected = false
		_handlerListHead = _handlerListHead._next
	end

	p1._handlerListHead = false
end
function t3.Fire(p1, ...) --[[ Fire | Line: 312 | Upvalues: v1 (ref), runEventHandlerInFreeThread (copy) ]]
	local _handlerListHead = p1._handlerListHead

	while _handlerListHead do
		if _handlerListHead.Connected then
			if not v1 then
				v1 = coroutine.create(runEventHandlerInFreeThread)
			end

			task.spawn(v1, _handlerListHead._fn, ...)
		end

		_handlerListHead = _handlerListHead._next
	end
end
function t3.FireDeferred(p1, ...) --[[ FireDeferred | Line: 333 ]]
	local _handlerListHead = p1._handlerListHead

	while _handlerListHead do
		task.defer(_handlerListHead._fn, ...)
		_handlerListHead = _handlerListHead._next
	end
end
function t3.Wait(p1) --[[ Wait | Line: 356 ]]
	local v1 = coroutine.running()
	local v2 = nil
	local v3 = false

	v2 = p1:Connect(function(...) --[[ Line: 360 | Upvalues: v3 (ref), v2 (ref), v1 (copy) ]]
		if not v3 then
			v3 = true
			v2:Disconnect()
			task.spawn(v1, ...)
		end
	end)

	return coroutine.yield()
end
function t3.Destroy(p1) --[[ Destroy | Line: 383 ]]
	p1:DisconnectAll()

	local v1 = rawget(p1, "_proxyHandler")

	if not v1 then
		return
	end

	v1:Disconnect()
end
setmetatable(t3, {
	__index = function(p1, p2) --[[ __index | Line: 393 ]]
		error(("Attempt to get Signal::%s (not a valid member)"):format((tostring(p2))), 2)
	end,
	__newindex = function(p1, p2, p3) --[[ __newindex | Line: 396 ]]
		error(("Attempt to set Signal::%s (not a valid member)"):format((tostring(p2))), 2)
	end
})

return {
	new = t3.new,
	Wrap = t3.Wrap,
	Is = t3.Is
}