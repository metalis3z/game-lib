-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: GoodSignal, time of decompilation: Sun May  3 10:09:35 2026 ]]
local u1 = nil

local function acquireRunnerThreadAndCallEventHandler(p1, ...) -- line: 34
	-- upvalues: u1 (ref)
	local v7 = u1

	u1 = nil
	p1(...)
	u1 = v7
end
local function runEventHandlerInFreeThread() -- line: 45
	-- upvalues: acquireRunnerThreadAndCallEventHandler (copy)
	while true do
		acquireRunnerThreadAndCallEventHandler(coroutine.yield())
	end
end

local t1 = {}

t1.__index = t1

function t1.new(p2, p3) -- line: 60
	-- upvalues: t1 (copy)
	return (setmetatable({
		_connected = true,
		_next = false,
		_signal = p2,
		_fn = p3
	}, t1))
end
function t1.Disconnect(p4) -- line: 69
	p4._connected = false

	if p4 == p4._signal._handlerListHead then
		p4._signal._handlerListHead = p4._next

		return
	end

	local _handlerListHead = p4._signal._handlerListHead

	while _handlerListHead and p4 ~= _handlerListHead._next do
		_handlerListHead = _handlerListHead._next
	end

	if _handlerListHead then
		_handlerListHead._next = p4._next
	end
end

t1.Destroy = t1.Disconnect
setmetatable(t1, {
	__index = function(_, p6) --[[ __index ]] -- line: 92
		error(("Attempt to get Connection::%s (not a valid member)"):format((tostring(p6))), 2)
	end,
	__newindex = function(_, p8, _) --[[ __newindex ]] -- line: 95
		error(("Attempt to set Connection::%s (not a valid member)"):format((tostring(p8))), 2)
	end
})

local t2 = {}

t2.__index = t2

function t2.new() -- line: 104
	-- upvalues: t2 (copy)
	return (setmetatable({
		_handlerListHead = false
	}, t2))
end
function t2.Connect(p10, p11) -- line: 110
	-- upvalues: t1 (copy)
	local v19 = t1.new(p10, p11)

	if p10._handlerListHead then
		v19._next = p10._handlerListHead
		p10._handlerListHead = v19

		return v19
	end

	p10._handlerListHead = v19

	return v19
end
function t2.DisconnectAll(p12) -- line: 123
	p12._handlerListHead = false
end

t2.Destroy = t2.DisconnectAll

function t2.Fire(p13, ...) -- line: 132
	-- upvalues: u1 (ref), runEventHandlerInFreeThread (copy)
	local _handlerListHead = p13._handlerListHead

	while _handlerListHead do
		if _handlerListHead._connected then
			if not u1 then
				u1 = coroutine.create(runEventHandlerInFreeThread)
				coroutine.resume(u1)
			end

			task.spawn(u1, _handlerListHead._fn, ...)
		end

		_handlerListHead = _handlerListHead._next
	end
end
function t2.Wait(p14) -- line: 149
	local thread = coroutine.running()
	local connection = nil

	connection = p14:Connect(function(...) -- line: 152
		-- upvalues: connection (ref), thread (copy)
		connection:Disconnect()
		task.spawn(thread, ...)
	end)

	return coroutine.yield()
end
function t2.Once(p15, p16) -- line: 161
	local connection = nil

	connection = p15:Connect(function(...) -- line: 163
		-- upvalues: connection (ref), p16 (copy)
		if connection._connected then
			connection:Disconnect()
		end

		p16(...)
	end)

	return connection
end

setmetatable(t2, {
	__index = function(_, p18) --[[ __index ]] -- line: 174
		error(("Attempt to get Signal::%s (not a valid member)"):format((tostring(p18))), 2)
	end,
	__newindex = function(_, p20, _) --[[ __newindex ]] -- line: 177
		error(("Attempt to set Signal::%s (not a valid member)"):format((tostring(p20))), 2)
	end
})

return t2
