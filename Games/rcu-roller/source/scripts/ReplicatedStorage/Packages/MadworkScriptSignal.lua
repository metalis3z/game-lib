-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:15:12
-- Luau version 6, Types version 3
-- Time taken: 0.002612 seconds

local module = {}
local var2_upvw
local function AcquireRunnerThreadAndCallEventHandler_upvr(arg1, ...) -- Line 60, Named "AcquireRunnerThreadAndCallEventHandler"
	--[[ Upvalues[1]:
		[1]: var2_upvw (read and write)
	]]
	var2_upvw = nil
	arg1(...)
	var2_upvw = var2_upvw
end
local function RunEventHandlerInFreeThread_upvr(...) -- Line 68, Named "RunEventHandlerInFreeThread"
	--[[ Upvalues[1]:
		[1]: AcquireRunnerThreadAndCallEventHandler_upvr (readonly)
	]]
	AcquireRunnerThreadAndCallEventHandler_upvr(...)
	while true do
		AcquireRunnerThreadAndCallEventHandler_upvr(coroutine.yield())
	end
end
local tbl_upvr_2 = {}
local function Disconnect(arg1) -- Line 88
	--[[ Upvalues[2]:
		[1]: var2_upvw (read and write)
		[2]: RunEventHandlerInFreeThread_upvr (readonly)
	]]
	local _listener = arg1._listener
	if _listener ~= nil then
		local _listener_table = arg1._listener_table
		local table_find_result1 = table.find(_listener_table, _listener)
		if table_find_result1 ~= nil then
			table.remove(_listener_table, table_find_result1)
		end
		arg1._listener = nil
	end
	if arg1._disconnect_listener ~= nil then
		if not var2_upvw then
			var2_upvw = coroutine.create(RunEventHandlerInFreeThread_upvr)
		end
		task.spawn(var2_upvw, arg1._disconnect_listener, arg1._disconnect_param)
		arg1._disconnect_listener = nil
	end
end
tbl_upvr_2.Disconnect = Disconnect
function module.NewArrayScriptConnection(arg1, arg2, arg3, arg4) -- Line 107
	--[[ Upvalues[1]:
		[1]: tbl_upvr_2 (readonly)
	]]
	local module_3 = {}
	module_3._listener = arg2
	module_3._listener_table = arg1
	module_3._disconnect_listener = arg3
	module_3._disconnect_param = arg4
	module_3.Disconnect = tbl_upvr_2.Disconnect
	return module_3
end
local tbl_upvr = {}
tbl_upvr.__index = tbl_upvr
function tbl_upvr.Disconnect(arg1) -- Line 132
	--[[ Upvalues[2]:
		[1]: var2_upvw (read and write)
		[2]: RunEventHandlerInFreeThread_upvr (readonly)
	]]
	-- KONSTANTERROR: [0] 1. Error Block 27 start (CF ANALYSIS FAILED)
	local var9
	if var9 == false then
	else
		var9 = false
		arg1._is_connected = var9
		var9 = arg1._script_signal
		var9._listener_count -= 1
		var9 = arg1._script_signal._head
		if var9 == arg1 then
			var9 = arg1._script_signal
			var9._head = arg1._next
			-- KONSTANTWARNING: GOTO [47] #27
		end
		-- KONSTANTERROR: [0] 1. Error Block 27 end (CF ANALYSIS FAILED)
		-- KONSTANTERROR: [28] 17. Error Block 19 start (CF ANALYSIS FAILED)
		var9 = arg1._script_signal._head
		while var9 ~= nil and var9._next ~= arg1 do
			var9 = var9._next
		end
		if var9 ~= nil then
			var9._next = arg1._next
		end
		var9 = arg1._disconnect_listener
		if var9 ~= nil then
			var9 = var2_upvw
			if not var9 then
				var9 = coroutine.create(RunEventHandlerInFreeThread_upvr)
				var2_upvw = var9
			end
			var9 = task.spawn
			var9(var2_upvw, arg1._disconnect_listener, arg1._disconnect_param)
			var9 = nil
			arg1._disconnect_listener = var9
		end
		-- KONSTANTERROR: [28] 17. Error Block 19 end (CF ANALYSIS FAILED)
	end
end
local tbl_upvr_3 = {}
tbl_upvr_3.__index = tbl_upvr_3
function tbl_upvr_3.Connect(arg1, arg2, arg3, arg4) -- Line 173
	--[[ Upvalues[1]:
		[1]: tbl_upvr (readonly)
	]]
	local module_2 = {}
	module_2._listener = arg2
	module_2._script_signal = arg1
	module_2._disconnect_listener = arg3
	module_2._disconnect_param = arg4
	module_2._next = arg1._head
	module_2._is_connected = true
	setmetatable(module_2, tbl_upvr)
	arg1._head = module_2
	arg1._listener_count += 1
	return module_2
end
function tbl_upvr_3.GetListenerCount(arg1) -- Line 193
	return arg1._listener_count
end
function tbl_upvr_3.Fire(arg1, ...) -- Line 197
	--[[ Upvalues[2]:
		[1]: var2_upvw (read and write)
		[2]: RunEventHandlerInFreeThread_upvr (readonly)
	]]
	local _head_2 = arg1._head
	while _head_2 ~= nil do
		if _head_2._is_connected == true then
			if not var2_upvw then
				var2_upvw = coroutine.create(RunEventHandlerInFreeThread_upvr)
			end
			task.spawn(var2_upvw, _head_2._listener, ...)
		end
	end
end
function tbl_upvr_3.FireUntil(arg1, arg2, ...) -- Line 210
	local _head_3 = arg1._head
	while _head_3 ~= nil do
		if _head_3._is_connected == true then
			_head_3._listener(...)
			if arg2() ~= true then return end
		end
	end
end
function module.NewScriptSignal() -- Line 223
	--[[ Upvalues[1]:
		[1]: tbl_upvr_3 (readonly)
	]]
	return {
		_head = nil;
		_listener_count = 0;
		Connect = tbl_upvr_3.Connect;
		GetListenerCount = tbl_upvr_3.GetListenerCount;
		Fire = tbl_upvr_3.Fire;
		FireUntil = tbl_upvr_3.FireUntil;
	}
end
return module