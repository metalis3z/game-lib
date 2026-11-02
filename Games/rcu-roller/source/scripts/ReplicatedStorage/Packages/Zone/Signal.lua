-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw


-- Decompiler will be improved VERY SOON!

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)

-- Decompiled on 2025-03-27 06:15:25

-- Luau version 6, Types version 3

-- Time taken: 0.002551 seconds


local var1_upvw

local function acquireRunnerThreadAndCallEventHandler_upvr(arg1, ...) -- Line 34, Named "acquireRunnerThreadAndCallEventHandler"

	--[[ Upvalues[1]:

		[1]: var1_upvw (read and write)

	]]

	var1_upvw = nil

	arg1(...)

	var1_upvw = var1_upvw

end

local function runEventHandlerInFreeThread_upvr(...) -- Line 45, Named "runEventHandlerInFreeThread"

	--[[ Upvalues[1]:

		[1]: acquireRunnerThreadAndCallEventHandler_upvr (readonly)

	]]

	acquireRunnerThreadAndCallEventHandler_upvr(...)

	while true do

		acquireRunnerThreadAndCallEventHandler_upvr(coroutine.yield())

	end

end

local tbl_upvr = {}

tbl_upvr.__index = tbl_upvr

local function new(arg1, arg2) -- Line 56

	--[[ Upvalues[1]:

		[1]: tbl_upvr (readonly)

	]]

	local module = {

		_connected = true;

	}

	module._signal = arg1

	module._fn = arg2

	module._next = false

	return setmetatable(module, tbl_upvr)

end

tbl_upvr.new = new

function tbl_upvr.Disconnect(arg1) -- Line 65

	-- KONSTANTERROR: [0] 1. Error Block 17 start (CF ANALYSIS FAILED)

	assert(arg1._connected, "Can't disconnect a connection twice.", 2)

	arg1._connected = false

	local _signal = arg1._signal

	local var5 = _signal._handlerListHead

	if var5 == arg1 then

		var5 = arg1._next

		_signal._handlerListHead = var5

		-- KONSTANTWARNING: GOTO [37] #24

	end

	-- KONSTANTERROR: [0] 1. Error Block 17 end (CF ANALYSIS FAILED)

	-- KONSTANTERROR: [22] 15. Error Block 25 start (CF ANALYSIS FAILED)

	var5 = _signal._handlerListHead

	while var5 and var5._next ~= arg1 do

		var5 = var5._next

	end

	if var5 then

		var5._next = arg1._next

	end

	var5 = _signal.connectionsChanged

	if var5 then

		var5 = _signal.totalConnections

		var5 -= 1

		_signal.totalConnections = var5

		var5 = _signal.connectionsChanged.Fire

		var5(_signal.connectionsChanged, -1)

	end

	-- KONSTANTERROR: [22] 15. Error Block 25 end (CF ANALYSIS FAILED)

end

setmetatable(tbl_upvr, {

	__index = function(arg1, arg2) -- Line 94, Named "__index"

		error(string.format("Attempt to get Connection::%s (not a valid member)", tostring(arg2)), 2)

	end;

	__newindex = function(arg1, arg2, arg3) -- Line 97, Named "__newindex"

		error(string.format("Attempt to set Connection::%s (not a valid member)", tostring(arg2)), 2)

	end;

})

local module_2_upvr = {}

module_2_upvr.__index = module_2_upvr

function module_2_upvr.new(arg1) -- Line 106

	--[[ Upvalues[1]:

		[1]: module_2_upvr (readonly)

	]]

	local setmetatable_result1 = setmetatable({

		_handlerListHead = false;

	}, module_2_upvr)

	if arg1 then

		setmetatable_result1.totalConnections = 0

		setmetatable_result1.connectionsChanged = module_2_upvr.new()

	end

	return setmetatable_result1

end

function module_2_upvr.Connect(arg1, arg2) -- Line 117

	--[[ Upvalues[1]:

		[1]: tbl_upvr (readonly)

	]]

	local any_new_result1 = tbl_upvr.new(arg1, arg2)

	if arg1._handlerListHead then

		any_new_result1._next = arg1._handlerListHead

		arg1._handlerListHead = any_new_result1

	else

		arg1._handlerListHead = any_new_result1

	end

	if arg1.connectionsChanged then

		arg1.totalConnections += 1

		arg1.connectionsChanged:Fire(1)

	end

	return any_new_result1

end

function module_2_upvr.DisconnectAll(arg1) -- Line 135

	arg1._handlerListHead = false

	if arg1.connectionsChanged then

		arg1.connectionsChanged:Fire(-arg1.totalConnections)

		arg1.connectionsChanged:Destroy()

		arg1.connectionsChanged = nil

		arg1.totalConnections = 0

	end

end

module_2_upvr.Destroy = module_2_upvr.DisconnectAll

module_2_upvr.destroy = module_2_upvr.DisconnectAll

function module_2_upvr.Fire(arg1, ...) -- Line 152

	--[[ Upvalues[2]:

		[1]: var1_upvw (read and write)

		[2]: runEventHandlerInFreeThread_upvr (readonly)

	]]

	local _handlerListHead = arg1._handlerListHead

	while _handlerListHead do

		if _handlerListHead._connected then

			if not var1_upvw then

				var1_upvw = coroutine.create(runEventHandlerInFreeThread_upvr)

			end

			task.spawn(var1_upvw, _handlerListHead._fn, ...)

		end

	end

end

function module_2_upvr.Wait(arg1) -- Line 167

	local var13_upvw

	local current_thread_upvr = coroutine.running()

	var13_upvw = arg1:Connect(function(...) -- Line 170

		--[[ Upvalues[2]:

			[1]: var13_upvw (read and write)

			[2]: current_thread_upvr (readonly)

		]]

		var13_upvw:Disconnect()

		task.spawn(current_thread_upvr, ...)

	end)

	return coroutine.yield()

end

return module_2_upvr
