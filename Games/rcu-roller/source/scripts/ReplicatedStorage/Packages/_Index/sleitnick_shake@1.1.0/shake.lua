-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:16:25
-- Luau version 6, Types version 3
-- Time taken: 0.003712 seconds

local RunService_upvr = game:GetService("RunService")
local tbl_upvr = {}
tbl_upvr.__index = tbl_upvr
local random_state_upvr = Random.new()
function tbl_upvr.new() -- Line 205
	--[[ Upvalues[3]:
		[1]: tbl_upvr (readonly)
		[2]: RunService_upvr (readonly)
		[3]: random_state_upvr (readonly)
	]]
	local setmetatable_result1 = setmetatable({}, tbl_upvr)
	setmetatable_result1.Amplitude = 1
	setmetatable_result1.Frequency = 1
	setmetatable_result1.FadeInTime = 1
	setmetatable_result1.FadeOutTime = 1
	setmetatable_result1.SustainTime = 0
	setmetatable_result1.Sustain = false
	setmetatable_result1.PositionInfluence = Vector3.new(1, 1, 1)
	local var5 = Vector3.new(1, 1, 1)
	setmetatable_result1.RotationInfluence = var5
	if RunService_upvr:IsRunning() then
		var5 = time
	else
		var5 = os.clock
	end
	setmetatable_result1.TimeFunction = var5
	setmetatable_result1._timeOffset = random_state_upvr:NextNumber(-1000000, 1000000)
	setmetatable_result1._startTime = 0
	setmetatable_result1._running = false
	setmetatable_result1._signalConnections = {}
	setmetatable_result1._renderBindings = {}
	return setmetatable_result1
end
function tbl_upvr.InverseSquare(arg1, arg2) -- Line 256
	local var6
	if var6 < 1 then
		var6 = 1
	end
	return (arg1) * ((1) / (var6 * var6))
end
local var7_upvw = 0
function tbl_upvr.NextRenderName() -- Line 272
	--[[ Upvalues[1]:
		[1]: var7_upvw (read and write)
	]]
	var7_upvw += 1
	return string.format("__shake_%.4i__", var7_upvw)
end
function tbl_upvr.Start(arg1) -- Line 285
	arg1._startTime = arg1.TimeFunction()
	arg1._running = true
end
function tbl_upvr.Stop(arg1) -- Line 297
	--[[ Upvalues[1]:
		[1]: RunService_upvr (readonly)
	]]
	arg1._running = false
	for _, v in arg1._renderBindings do
		RunService_upvr:UnbindFromRenderStep(v)
	end
	table.clear(arg1._renderBindings)
	for _, v_2 in arg1._signalConnections do
		v_2:Disconnect()
	end
	table.clear(arg1._signalConnections)
end
function tbl_upvr.IsShaking(arg1) -- Line 315
	return arg1._running
end
function tbl_upvr.StopSustain(arg1) -- Line 324
	arg1.Sustain = false
	arg1.SustainTime = arg1.TimeFunction() - arg1._startTime - arg1.FadeInTime
end
function tbl_upvr.Update(arg1) -- Line 352
	-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
	local any_TimeFunction_result1 = arg1.TimeFunction()
	local var13 = any_TimeFunction_result1 - arg1._startTime
	local var14 = (any_TimeFunction_result1 + arg1._timeOffset) / arg1.Frequency % 10000
	local var15
	if var13 < arg1.FadeInTime then
		var15 = var13 / arg1.FadeInTime
	end
	local var16
	if not arg1.Sustain and arg1.FadeInTime + arg1.SustainTime < var13 then
		if arg1.FadeOutTime == 0 then
			local _ = true
		else
			var16 = 1 - (var13 - arg1.FadeInTime - arg1.SustainTime) / arg1.FadeOutTime
			if not arg1.Sustain and arg1.FadeInTime + arg1.SustainTime + arg1.FadeOutTime <= var13 then
			end
		end
	end
	local var18 = Vector3.new(math.noise(var14, 0) / 2, math.noise(0, var14) / 2, math.noise(var14, var14) / 2) * arg1.Amplitude * math.min(var15, var16)
	if true then
		arg1:Stop()
	end
	-- KONSTANTERROR: Expression was reused, decompilation is incorrect
	return arg1.PositionInfluence * var18, arg1.RotationInfluence * var18, true
end
function tbl_upvr.OnSignal(arg1, arg2, arg3) -- Line 410
	local any_Connect_result1 = arg2:Connect(function() -- Line 411
		--[[ Upvalues[2]:
			[1]: arg3 (readonly)
			[2]: arg1 (readonly)
		]]
		arg3(arg1:Update())
	end)
	table.insert(arg1._signalConnections, any_Connect_result1)
	return any_Connect_result1
end
function tbl_upvr.BindToRenderStep(arg1, arg2, arg3, arg4) -- Line 440
	--[[ Upvalues[1]:
		[1]: RunService_upvr (readonly)
	]]
	RunService_upvr:BindToRenderStep(arg2, arg3, function() -- Line 441
		--[[ Upvalues[2]:
			[1]: arg4 (readonly)
			[2]: arg1 (readonly)
		]]
		arg4(arg1:Update())
	end)
	table.insert(arg1._renderBindings, arg2)
end
function tbl_upvr.Clone(arg1) -- Line 477
	--[[ Upvalues[1]:
		[1]: tbl_upvr (readonly)
	]]
	local any_new_result1 = tbl_upvr.new()
	for _, v_3 in {"Amplitude", "Frequency", "FadeInTime", "FadeOutTime", "SustainTime", "Sustain", "PositionInfluence", "RotationInfluence", "TimeFunction"} do
		any_new_result1[v_3] = arg1[v_3]
	end
	return any_new_result1
end
function tbl_upvr.Destroy(arg1) -- Line 499
	arg1:Stop()
end
return {
	new = tbl_upvr.new;
	InverseSquare = tbl_upvr.InverseSquare;
	NextRenderName = tbl_upvr.NextRenderName;
}