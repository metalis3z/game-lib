-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw


-- Decompiler will be improved VERY SOON!

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)

-- Decompiled on 2025-03-27 06:21:11

-- Luau version 6, Types version 3

-- Time taken: 0.003528 seconds


local var1_upvw

local function callFunction_upvr(arg1, arg2, ...) -- Line 46, Named "callFunction"

	arg1(...)

end

local function acquireRunnerThreadAndCallEventHandler_upvr(arg1, arg2, ...) -- Line 82, Named "acquireRunnerThreadAndCallEventHandler"

	--[[ Upvalues[2]:

		[1]: var1_upvw (read and write)

		[2]: callFunction_upvr (readonly)

	]]

	var1_upvw = nil

	callFunction_upvr(arg1, arg2, ...)

	var1_upvw = var1_upvw

end

local function runEventHandlerInFreeThread_upvr(...) -- Line 93, Named "runEventHandlerInFreeThread"

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

local function new(arg1, arg2) -- Line 104

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

function tbl_upvr.Disconnect(arg1) -- Line 113

	local var4

	if not var4 then

	else

		var4 = false

		arg1._connected = var4

		var4 = arg1._signal._handlerListHead

		if var4 == arg1 then

			var4 = arg1._signal

			var4._handlerListHead = arg1._next

			return

		end

		var4 = arg1._signal._handlerListHead

		while var4 and var4._next ~= arg1 do

			var4 = var4._next

		end

		if var4 then

			var4._next = arg1._next

		end

	end

end

tbl_upvr.Destroy = tbl_upvr.Disconnect

setmetatable(tbl_upvr, {

	__index = function(arg1, arg2) -- Line 139, Named "__index"

		error(string.format("Attempt to get Connection::%s (not a valid member)", tostring(arg2)), 2)

	end;

	__newindex = function(arg1, arg2, arg3) -- Line 142, Named "__newindex"

		error(string.format("Attempt to set Connection::%s (not a valid member)", tostring(arg2)), 2)

	end;

})

local module_2_upvr = {}

module_2_upvr.__index = module_2_upvr

function module_2_upvr.new() -- Line 151

	--[[ Upvalues[1]:

		[1]: module_2_upvr (readonly)

	]]

	return setmetatable({

		_handlerListHead = false;

	}, module_2_upvr)

end

function module_2_upvr.Connect(arg1, arg2) -- Line 157

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

function module_2_upvr.ConnectOnce(arg1, arg2) -- Line 168

	local var10_upvw

	var10_upvw = arg1:Connect(function(...) -- Line 170

		--[[ Upvalues[2]:

			[1]: var10_upvw (read and write)

			[2]: arg2 (readonly)

		]]

		var10_upvw:Disconnect()

		arg2(...)

	end)

	return var10_upvw

end

module_2_upvr.Once = module_2_upvr.ConnectOnce

function module_2_upvr.DisconnectAll(arg1) -- Line 181

	arg1._handlerListHead = false

end

module_2_upvr.Destroy = module_2_upvr.DisconnectAll

module_2_upvr.destroy = module_2_upvr.DisconnectAll

function module_2_upvr._FireBehaviour(arg1, arg2, ...) -- Line 191

	--[[ Upvalues[4]:

		[1]: module_2_upvr (readonly)

		[2]: var1_upvw (read and write)

		[3]: runEventHandlerInFreeThread_upvr (readonly)

		[4]: callFunction_upvr (readonly)

	]]

	local concatenated_upvr = table.concat({debug.info(3, "sl")}, ' ')

	local _handlerListHead_upvw = arg1._handlerListHead

	local var14_upvw

	if var14_upvw then

		var14_upvw = module_2_upvr.new()

	end

	local var15_upvw = 0

	if arg2 then

		local var16 = _handlerListHead_upvw

		while var16 do

			if var16._connected then

				var15_upvw += 1

			end

		end

	end

	while _handlerListHead_upvw do

		if _handlerListHead_upvw._connected then

			if not var1_upvw then

				var1_upvw = coroutine.create(runEventHandlerInFreeThread_upvr)

			end

			local var18_upvw = 0

			task.spawn(var1_upvw, function(...) -- Line 211

				--[[ Upvalues[7]:

					[1]: callFunction_upvr (copied, readonly)

					[2]: _handlerListHead_upvw (read and write)

					[3]: concatenated_upvr (readonly)

					[4]: arg2 (readonly)

					[5]: var18_upvw (read and write)

					[6]: var15_upvw (read and write)

					[7]: var14_upvw (read and write)

				]]

				callFunction_upvr(_handlerListHead_upvw._fn, concatenated_upvr, ...)

				if arg2 then

					var18_upvw += 1

					if var18_upvw == var15_upvw then

						var14_upvw:Fire()

						var14_upvw:Destroy()

						var14_upvw = false

					end

				end

			end, concatenated_upvr, ...)

		end

		_handlerListHead_upvw = _handlerListHead_upvw._next

	end

	if arg2 then

		return var14_upvw

	end

end

function module_2_upvr.Fire(arg1, ...) -- Line 231

	arg1:_FireBehaviour(false, ...)

end

function module_2_upvr.SpecialFire(arg1, ...) -- Line 235

	return arg1:_FireBehaviour(true, ...)

end

function module_2_upvr.Wait(arg1) -- Line 244

	local var20_upvw

	local current_thread_upvr = coroutine.running()

	var20_upvw = arg1:Connect(function(...) -- Line 247

		--[[ Upvalues[2]:

			[1]: var20_upvw (read and write)

			[2]: current_thread_upvr (readonly)

		]]

		var20_upvw:Disconnect()

		task.spawn(current_thread_upvr, ...)

	end)

	return coroutine.yield()

end

return module_2_upvr
