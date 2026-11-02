-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-17 20:45:20
-- Luau version 6, Types version 3
-- Time taken: 0.005320 seconds

local var1_upvw
local function acquireRunnerThreadAndCallEventHandler_upvr(arg1, ...) -- Line 34, Named "acquireRunnerThreadAndCallEventHandler"
	--[[ Upvalues[1]:
		[1]: var1_upvw (read and write)
	]]
	var1_upvw = nil
	arg1(...)
	var1_upvw = var1_upvw
end
local function runEventHandlerInFreeThread_upvr() -- Line 45, Named "runEventHandlerInFreeThread"
	--[[ Upvalues[1]:
		[1]: acquireRunnerThreadAndCallEventHandler_upvr (readonly)
	]]
	while true do
		acquireRunnerThreadAndCallEventHandler_upvr(coroutine.yield())
	end
end
local tbl_upvr = {}
tbl_upvr.__index = tbl_upvr
local function new(arg1, arg2) -- Line 60
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
function tbl_upvr.Disconnect(arg1) -- Line 69
	arg1._connected = false
	local var4
	if var4 == arg1 then
		var4 = arg1._signal
		var4._handlerListHead = arg1._next
	else
		var4 = arg1._signal._handlerListHead
		while var4 and var4._next ~= arg1 do
			var4 = var4._next
		end
		if var4 then
			var4._next = arg1._next
		end
	end
end
local tbl = {}
local function __index(arg1, arg2) -- Line 91
	error("Attempt to get Connection::%s (not a valid member)":format(tostring(arg2)), 2)
end
tbl.__index = __index
local function __newindex(arg1, arg2, arg3) -- Line 94
	error("Attempt to set Connection::%s (not a valid member)":format(tostring(arg2)), 2)
end
tbl.__newindex = __newindex
setmetatable(tbl_upvr, tbl)
local module_2_upvr = {}
module_2_upvr.__index = module_2_upvr
function module_2_upvr.new() -- Line 103
	--[[ Upvalues[1]:
		[1]: module_2_upvr (readonly)
	]]
	return setmetatable({
		_handlerListHead = false;
	}, module_2_upvr)
end
function module_2_upvr.Connect(arg1, arg2) -- Line 109
	--[[ Upvalues[1]:
		[1]: tbl_upvr (readonly)
	]]
	local any_new_result1 = tbl_upvr.new(arg1, arg2)
	if arg1._handlerListHead then
		any_new_result1._next = arg1._handlerListHead
		arg1._handlerListHead = any_new_result1
		return any_new_result1
	end
	arg1._handlerListHead = any_new_result1
	return any_new_result1
end
function module_2_upvr.DisconnectAll(arg1) -- Line 122
	arg1._handlerListHead = false
end
function module_2_upvr.Fire(arg1, ...) -- Line 130
	--[[ Upvalues[2]:
		[1]: var1_upvw (read and write)
		[2]: runEventHandlerInFreeThread_upvr (readonly)
	]]
	local _handlerListHead = arg1._handlerListHead
	while _handlerListHead do
		if _handlerListHead._connected then
			if not var1_upvw then
				var1_upvw = coroutine.create(runEventHandlerInFreeThread_upvr)
				coroutine.resume(var1_upvw)
			end
			task.spawn(var1_upvw, _handlerListHead._fn, ...)
		end
	end
end
function module_2_upvr.Wait(arg1) -- Line 147
	local var11_upvw
	local current_thread_upvr = coroutine.running()
	var11_upvw = arg1:Connect(function(...) -- Line 150
		--[[ Upvalues[2]:
			[1]: var11_upvw (read and write)
			[2]: current_thread_upvr (readonly)
		]]
		var11_upvw:Disconnect()
		task.spawn(current_thread_upvr, ...)
	end)
	return coroutine.yield()
end
function module_2_upvr.Once(arg1, arg2) -- Line 159
	local var14_upvw
	var14_upvw = arg1:Connect(function(...) -- Line 161
		--[[ Upvalues[2]:
			[1]: var14_upvw (read and write)
			[2]: arg2 (readonly)
		]]
		if var14_upvw._connected then
			var14_upvw:Disconnect()
		end
		arg2(...)
	end)
	return var14_upvw
end
setmetatable(module_2_upvr, {
	__index = function(arg1, arg2) -- Line 172, Named "__index"
		error("Attempt to get Signal::%s (not a valid member)":format(tostring(arg2)), 2)
	end;
	__newindex = function(arg1, arg2, arg3) -- Line 175, Named "__newindex"
		error("Attempt to set Signal::%s (not a valid member)":format(tostring(arg2)), 2)
	end;
})
return module_2_upvr