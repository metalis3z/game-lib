-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
require(script.Types)

local v1 = nil

local function table_swapremove(p1, p2) --[[ table_swapremove | Line: 14 ]]
	local _ = p1[p2]
	local v1 = p1[#p1]

	p1[p2] = v1
	p1[#p1] = nil

	return v1
end

local function acquireRunnerThreadAndCallEventHandler(p1, ...) --[[ acquireRunnerThreadAndCallEventHandler | Line: 24 | Upvalues: v1 (ref) ]]
	local v12 = v1

	v1 = nil
	p1(...)
	v1 = v12
end

local function runEventHandlerInFreeThread() --[[ runEventHandlerInFreeThread | Line: 31 | Upvalues: acquireRunnerThreadAndCallEventHandler (copy) ]]
	while true do
		acquireRunnerThreadAndCallEventHandler(coroutine.yield())
	end
end

local t = {}

t.__index = t
function t.Disconnect(p1) --[[ Disconnect | Line: 40 ]]
	if p1.Connected then
		local _connections = p1._connections
		local _pos = p1._pos
		local _ = _connections[_pos]
		local v1 = _connections[#_connections]

		_connections[_pos] = v1
		_connections[#_connections] = nil
		v1._pos = p1._pos
		p1.Connected = false
	end
end

local t2 = {}

t2.__index = t2
function t2.Destroy(p1) --[[ Destroy | Line: 54 ]]
	p1:DisconnectAll()
	setmetatable(p1, nil)
	table.clear(p1)
end
function t2.Connect(p1, p2) --[[ Connect | Line: 61 | Upvalues: t (copy) ]]
	assert(if p2 == nil then false else true, (("Function expected, got %*"):format(p2)))

	local Connections = p1.Connections
	local v4 = setmetatable({
		Connected = true,
		_fn = p2,
		_pos = #Connections + 1,
		_connections = Connections
	}, t)

	table.insert(Connections, v4)

	return v4
end
function t2.Once(p1, p2) --[[ Once | Line: 79 ]]
	assert(if p2 == nil then false else true, (("Function expected, got %*"):format(p2)))

	local v3 = nil

	v3 = p1:Connect(function(...) --[[ Line: 83 | Upvalues: v3 (ref), p2 (copy) ]]
		v3:Disconnect()
		p2(...)
	end)

	return v3
end
function t2.DisconnectAll(p1) --[[ DisconnectAll | Line: 92 ]]
	for v1, v2 in p1.Connections do
		v2.Connected = false
	end

	table.clear(p1.Connections)
end
function t2.Fire(p1, ...) --[[ Fire | Line: 99 | Upvalues: v1 (ref), runEventHandlerInFreeThread (copy) ]]
	if #p1.Connections == 0 then
		return
	end

	for v12, v2 in p1.Connections do
		if not v1 then
			v1 = task.spawn(runEventHandlerInFreeThread)
		end

		task.spawn(v1, v2._fn, ...)
	end
end
function t2.Wait(p1) --[[ Wait | Line: 112 ]]
	local v1 = coroutine.running()
	local v2 = nil

	v2 = p1:Connect(function(...) --[[ Line: 116 | Upvalues: v2 (ref), v1 (copy) ]]
		v2:Disconnect()

		if coroutine.status(v1) == "suspended" then
			task.spawn(v1, ...)
		end
	end)

	return coroutine.yield()
end

return {
	new = function() --[[ signal_new | Line: 130 | Upvalues: t2 (copy) ]]
		return setmetatable({
			Connections = {}
		}, t2)
	end
}