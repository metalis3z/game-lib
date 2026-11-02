-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:17:07
-- Luau version 6, Types version 3
-- Time taken: 0.001882 seconds

local var1_upvw
local function acquireRunnerThreadAndCallEventHandler_upvr(arg1, ...) -- Line 3, Named "acquireRunnerThreadAndCallEventHandler"
	--[[ Upvalues[1]:
		[1]: var1_upvw (read and write)
	]]
	var1_upvw = nil
	arg1(...)
	var1_upvw = var1_upvw
end
local tbl_upvr = {}
tbl_upvr.__index = tbl_upvr
local function new(arg1, arg2) -- Line 15
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
function tbl_upvr.Disconnect(arg1) -- Line 24
	assert(arg1._connected, "Connection already disconnected.")
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
local module_upvr = {}
module_upvr.__index = module_upvr
function module_upvr.new() -- Line 46
	--[[ Upvalues[1]:
		[1]: module_upvr (readonly)
	]]
	return setmetatable({
		_handlerListHead = false;
	}, module_upvr)
end
function module_upvr.Connect(arg1, arg2) -- Line 50
	--[[ Upvalues[1]:
		[1]: tbl_upvr (readonly)
	]]
	local any_new_result1 = tbl_upvr.new(arg1, arg2)
	local var8
	local function INLINED() -- Internal function, doesn't exist in bytecode
		var8 = arg1._handlerListHead
		return var8
	end
	if not arg1._handlerListHead or not INLINED() then
		var8 = any_new_result1._next
	end
	any_new_result1._next = var8
	arg1._handlerListHead = any_new_result1
	return any_new_result1
end
function module_upvr.Fire(arg1, ...) -- Line 57
	--[[ Upvalues[2]:
		[1]: var1_upvw (read and write)
		[2]: acquireRunnerThreadAndCallEventHandler_upvr (readonly)
	]]
	local _handlerListHead = arg1._handlerListHead
	while _handlerListHead do
		if _handlerListHead._connected then
			if not var1_upvw then
				var1_upvw = coroutine.create(function(...) -- Line 62
					--[[ Upvalues[1]:
						[1]: acquireRunnerThreadAndCallEventHandler_upvr (copied, readonly)
					]]
					acquireRunnerThreadAndCallEventHandler_upvr(...)
					while true do
						acquireRunnerThreadAndCallEventHandler_upvr(coroutine.yield())
					end
				end)
			end
			task.spawn(var1_upvw, _handlerListHead._fn, ...)
		end
	end
end
function module_upvr.Wait(arg1) -- Line 75
	local var12_upvw
	local current_thread_upvr = coroutine.running()
	var12_upvw = arg1:Connect(function(...) -- Line 78
		--[[ Upvalues[2]:
			[1]: var12_upvw (read and write)
			[2]: current_thread_upvr (readonly)
		]]
		var12_upvw:Disconnect()
		task.spawn(current_thread_upvr, ...)
	end)
	return coroutine.yield()
end
return module_upvr