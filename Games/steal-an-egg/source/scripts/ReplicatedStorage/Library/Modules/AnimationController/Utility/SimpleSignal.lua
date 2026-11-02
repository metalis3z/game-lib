-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
require(script.Types)

local v1 = nil

local function acquireRunnerThreadAndCallEventHandler(p1, ...) --[[ acquireRunnerThreadAndCallEventHandler | Line: 14 | Upvalues: v1 (ref) ]]
	local v12 = v1

	v1 = nil
	p1(...)
	v1 = v12
end

local function runEventHandlerInFreeThread() --[[ runEventHandlerInFreeThread | Line: 21 | Upvalues: acquireRunnerThreadAndCallEventHandler (copy) ]]
	while true do
		acquireRunnerThreadAndCallEventHandler(coroutine.yield())
	end
end

local t = {}
local t2 = {
	__index = t
}

function t.Disconnect(p1) --[[ Disconnect | Line: 30 ]]
	local _signal = p1._signal

	_signal._connections[p1] = nil
	_signal._connectionCount = _signal._connectionCount - 1
	setmetatable(p1, nil)
	table.clear(p1)
	p1.Connected = false
end

local function connection_new(p1, p2) --[[ connection_new | Line: 42 | Upvalues: t2 (copy) ]]
	return setmetatable({
		Connected = true,
		_signal = p1,
		_fn = p2
	}, t2)
end

local t3 = {}
local t4 = {
	__index = t3
}

function t3.Destroy(p1) --[[ Destroy | Line: 54 ]]
	p1:DisconnectAll()
	setmetatable(p1, nil)
	table.clear(p1)
end
function t3.Connect(p1, p2) --[[ Connect | Line: 61 | Upvalues: t2 (copy) ]]
	local v2 = setmetatable({
		Connected = true,
		_signal = p1,
		_fn = p2
	}, t2)

	p1._connections[v2] = true
	p1._connectionCount = p1._connectionCount + 1

	return v2
end
function t3.Once(p1, p2) --[[ Once | Line: 70 ]]
	local v1 = nil

	v1 = p1:Connect(function(...) --[[ Line: 72 | Upvalues: v1 (ref), p2 (copy) ]]
		v1:Disconnect()
		p2(...)
	end)

	return v1
end
function t3.DisconnectAll(p1) --[[ DisconnectAll | Line: 81 ]]
	for v1 in p1._connections do
		v1:Disconnect()
	end
end
function t3.Fire(p1, ...) --[[ Fire | Line: 88 | Upvalues: v1 (ref), runEventHandlerInFreeThread (copy) ]]
	for v12 in p1._connections do
		if not v1 then
			v1 = coroutine.create(runEventHandlerInFreeThread)
			coroutine.resume(v1)
		end

		task.spawn(v1, v12._fn, ...)
	end
end
function t3.Wait(p1) --[[ Wait | Line: 99 ]]
	local v1 = coroutine.running()
	local v2 = nil

	v2 = p1:Connect(function(...) --[[ Line: 103 | Upvalues: v2 (ref), v1 (copy) ]]
		v2:Disconnect()

		if coroutine.status(v1) == "suspended" then
			task.spawn(v1, ...)
		end
	end)

	return coroutine.yield()
end

return {
	new = function() --[[ signal_new | Line: 117 | Upvalues: t4 (copy) ]]
		return setmetatable({
			_connectionCount = 0,
			_connections = {}
		}, t4)
	end
}