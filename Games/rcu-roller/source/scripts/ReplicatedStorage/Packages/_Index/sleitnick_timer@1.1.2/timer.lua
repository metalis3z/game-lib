-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:16:19
-- Luau version 6, Types version 3
-- Time taken: 0.002774 seconds

local RunService_upvr = game:GetService("RunService")
local module_upvr = {}
module_upvr.__index = module_upvr
local Signal_upvr = require(script.Parent.Signal)
function module_upvr.new(arg1) -- Line 73
	--[[ Upvalues[3]:
		[1]: module_upvr (readonly)
		[2]: RunService_upvr (readonly)
		[3]: Signal_upvr (readonly)
	]]
	local var4
	if type(arg1) ~= "number" then
		var4 = false
	else
		var4 = true
	end
	assert(var4, "Argument #1 to Timer.new must be a number; got "..type(arg1))
	if 0 > arg1 then
		var4 = false
	else
		var4 = true
	end
	assert(var4, "Argument #1 to Timer.new must be greater or equal to 0; got "..tostring(arg1))
	var4 = {}
	local setmetatable_result1 = setmetatable(var4, module_upvr)
	var4 = nil
	setmetatable_result1._runHandle = var4
	setmetatable_result1.Interval = arg1
	var4 = RunService_upvr.Heartbeat
	setmetatable_result1.UpdateSignal = var4
	var4 = time
	setmetatable_result1.TimeFunction = var4
	var4 = true
	setmetatable_result1.AllowDrift = var4
	var4 = Signal_upvr.new()
	setmetatable_result1.Tick = var4
	return setmetatable_result1
end
function module_upvr.Simple(arg1, arg2, arg3, arg4, arg5) -- Line 103
	--[[ Upvalues[1]:
		[1]: RunService_upvr (readonly)
	]]
	local var6 = arg4
	if not var6 then
		var6 = RunService_upvr.Heartbeat
	end
	local var7_upvr = arg5
	if not var7_upvr then
		var7_upvr = time
	end
	if arg3 then
		task.defer(arg2)
	end
	local var9_upvw = var7_upvr() + arg1
	return var6:Connect(function() -- Line 116
		--[[ Upvalues[4]:
			[1]: var7_upvr (readonly)
			[2]: var9_upvw (read and write)
			[3]: arg1 (readonly)
			[4]: arg2 (readonly)
		]]
		local var7_result1 = var7_upvr()
		if var9_upvw <= var7_result1 then
			var9_upvw = var7_result1 + arg1
			task.defer(arg2)
		end
	end)
end
function module_upvr.Is(arg1) -- Line 128
	--[[ Upvalues[1]:
		[1]: module_upvr (readonly)
	]]
	local var11 = false
	if type(arg1) == "table" then
		if getmetatable(arg1) ~= module_upvr then
			var11 = false
		else
			var11 = true
		end
	end
	return var11
end
function module_upvr._startTimer(arg1) -- Line 132
	local TimeFunction_upvr_2 = arg1.TimeFunction
	local var14_upvw = TimeFunction_upvr_2() + arg1.Interval
	arg1._runHandle = arg1.UpdateSignal:Connect(function() -- Line 135
		--[[ Upvalues[3]:
			[1]: TimeFunction_upvr_2 (readonly)
			[2]: var14_upvw (read and write)
			[3]: arg1 (readonly)
		]]
		local var12_result1 = TimeFunction_upvr_2()
		if var14_upvw <= var12_result1 then
			var14_upvw = var12_result1 + arg1.Interval
			arg1.Tick:Fire()
		end
	end)
end
function module_upvr._startTimerNoDrift(arg1) -- Line 144
	local var16_upvw
	if 0 >= arg1.Interval then
		var16_upvw = false
	else
		var16_upvw = true
	end
	assert(var16_upvw, "Interval must be greater than 0 when AllowDrift is set to false")
	local TimeFunction_upvr = arg1.TimeFunction
	var16_upvw = 1
	local TimeFunction_upvr_result1_upvr = TimeFunction_upvr()
	local var20_upvw = TimeFunction_upvr_result1_upvr + arg1.Interval
	arg1._runHandle = arg1.UpdateSignal:Connect(function() -- Line 150
		--[[ Upvalues[5]:
			[1]: TimeFunction_upvr (readonly)
			[2]: var20_upvw (read and write)
			[3]: var16_upvw (read and write)
			[4]: TimeFunction_upvr_result1_upvr (readonly)
			[5]: arg1 (readonly)
		]]
		while var20_upvw <= TimeFunction_upvr() do
			var16_upvw += 1
			var20_upvw = TimeFunction_upvr_result1_upvr + arg1.Interval * var16_upvw
			arg1.Tick:Fire()
		end
	end)
end
function module_upvr.Start(arg1) -- Line 167
	if arg1._runHandle then
	else
		if arg1.AllowDrift then
			arg1:_startTimer()
			return
		end
		arg1:_startTimerNoDrift()
	end
end
function module_upvr.StartNow(arg1) -- Line 186
	if arg1._runHandle then
	else
		arg1.Tick:Fire()
		arg1:Start()
	end
end
function module_upvr.Stop(arg1) -- Line 201
	if not arg1._runHandle then
	else
		arg1._runHandle:Disconnect()
		arg1._runHandle = nil
	end
end
function module_upvr.IsRunning(arg1) -- Line 218
	local var21
	if arg1._runHandle == nil then
		var21 = false
	else
		var21 = true
	end
	return var21
end
function module_upvr.Destroy(arg1) -- Line 225
	arg1.Tick:Destroy()
	arg1:Stop()
end
return module_upvr