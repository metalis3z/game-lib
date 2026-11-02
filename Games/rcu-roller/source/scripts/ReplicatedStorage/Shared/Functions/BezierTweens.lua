-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:17:04
-- Luau version 6, Types version 3
-- Time taken: 0.004340 seconds

local module_upvr = {}
module_upvr.__index = module_upvr
module_upvr.Waypoints = require(script.Waypoints)
local function factorial_upvr(arg1) -- Line 31, Named "factorial"
	--[[ Upvalues[1]:
		[1]: factorial_upvr (readonly)
	]]
	if arg1 == 0 then
		return 1
	end
	return arg1 * factorial_upvr(arg1 - 1)
end
local function _(arg1, arg2) -- Line 36, Named "binomial"
	--[[ Upvalues[1]:
		[1]: factorial_upvr (readonly)
	]]
	-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
	local var2
	if arg1 == 0 then
	else
		var2 = arg1 - 1
	end
	local var3 = arg1 - arg2
	if var3 == 0 then
		var2 = 1
	else
		var2 = var3 * factorial_upvr(var3 - 1)
	end
	if arg2 == 0 then
	else
	end
	return (arg1 * factorial_upvr(var2)) / ((var2) * (arg2 * factorial_upvr(arg2 - 1)))
end
local function graphPoint_upvr(arg1, ...) -- Line 45, Named "graphPoint"
	--[[ Upvalues[1]:
		[1]: factorial_upvr (readonly)
	]]
	-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
	local var8 = false
	local var9
	if var9 <= arg1 then
		var9 = 1
		if arg1 > var9 then
			var8 = false
		else
			var8 = true
		end
	end
	var9 = arg1.."t is not between 0 and 1."
	assert(var8, var9)
	local args_list = {...}
	var9 = #args_list
	local var11 = var9 - 1
	var9 = nil
	for i = 0, var11 do
		local var12
		if var11 == 0 then
		else
			var12 = var11 - 1
		end
		local var13 = var11 - i
		if var13 == 0 then
			var12 = 1
		else
			var12 = var13 * factorial_upvr(var13 - 1)
		end
		if i == 0 then
		else
		end
		local var14 = (var11 * factorial_upvr(var12)) / ((var12) * (i * factorial_upvr(i - 1))) * (1 - arg1) ^ (var11 - i) * arg1 ^ i * args_list[i + 1]
		if not var9 or not (var9 + var14) then
		end
		var9 = var14
	end
	return var9
end
local Signal_upvr = require(script.Signal)
function module_upvr.Create(arg1, arg2) -- Line 59
	--[[ Upvalues[2]:
		[1]: module_upvr (readonly)
		[2]: Signal_upvr (readonly)
	]]
	-- KONSTANTERROR: [0] 1. Error Block 27 start (CF ANALYSIS FAILED)
	local var16 = module_upvr
	local setmetatable_result1 = setmetatable({}, var16)
	if 1 >= #arg2.Waypoints then
		var16 = false
	else
		var16 = true
	end
	assert(var16, "Bezier curve must have atleast 2 waypoints.")
	if arg2.EasingStyle == Enum.EasingStyle.Elastic then
		var16 = false
		-- KONSTANTWARNING: GOTO [30] #21
	end
	-- KONSTANTERROR: [0] 1. Error Block 27 end (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [29] 20. Error Block 29 start (CF ANALYSIS FAILED)
	var16 = true
	assert(var16, "Elastic easing style not supported.")
	if arg2.EasingStyle == Enum.EasingStyle.Back then
		var16 = false
	else
		var16 = true
	end
	assert(var16, "Back easing style not supported.")
	setmetatable_result1.Instance = arg1
	setmetatable_result1.PlaybackState = Enum.PlaybackState.Begin
	setmetatable_result1.TweenInfo = arg2
	var16 = Signal_upvr
	setmetatable_result1.Played = var16.new()
	var16 = Signal_upvr
	setmetatable_result1.Completed = var16.new()
	var16 = Signal_upvr
	setmetatable_result1.Cancelled = var16.new()
	var16 = Signal_upvr
	setmetatable_result1.Ended = var16.new()
	var16 = Signal_upvr
	setmetatable_result1.Paused = var16.new()
	var16 = Signal_upvr
	setmetatable_result1.Resumed = var16.new()
	setmetatable_result1._time = 0
	local EasingStyle = arg2.EasingStyle
	if not EasingStyle then
		EasingStyle = Enum.EasingStyle.Linear
	end
	setmetatable_result1._style = EasingStyle
	EasingStyle = arg2.EasingDirection
	local var19 = EasingStyle
	if not var19 then
		var19 = Enum.EasingDirection.In
	end
	setmetatable_result1._direction = var19
	do
		return setmetatable_result1
	end
	-- KONSTANTERROR: [29] 20. Error Block 29 end (CF ANALYSIS FAILED)
end
local TweenService_upvr = game:GetService("TweenService")
local RunService_upvr = game:GetService("RunService")
function module_upvr.Play(arg1) -- Line 87
	--[[ Upvalues[3]:
		[1]: TweenService_upvr (readonly)
		[2]: graphPoint_upvr (readonly)
		[3]: RunService_upvr (readonly)
	]]
	local var22
	if arg1.PlaybackState ~= Enum.PlaybackState.Playing then
		var22 = false
	else
		var22 = true
	end
	var22 = "Tween is already playing."
	assert(not var22, var22)
	if arg1.PlaybackState ~= Enum.PlaybackState.Cancelled then
		var22 = false
	else
		var22 = true
	end
	var22 = "Tween is cancelled."
	assert(not var22, var22)
	arg1.Played:Fire()
	arg1.PlaybackState = Enum.PlaybackState.Playing
	task.spawn(function() -- Line 93
		--[[ Upvalues[4]:
			[1]: arg1 (readonly)
			[2]: TweenService_upvr (copied, readonly)
			[3]: graphPoint_upvr (copied, readonly)
			[4]: RunService_upvr (copied, readonly)
		]]
		while arg1._time < 1 do
			if arg1.PlaybackState ~= Enum.PlaybackState.Playing then return end
			if arg1.Instance:IsA("BasePart") then
				arg1.Instance.Position = graphPoint_upvr(TweenService_upvr:GetValue(arg1._time, arg1._style, arg1._direction), unpack(arg1.TweenInfo.Waypoints))
			else
				-- KONSTANTERROR: Expression was reused, decompilation is incorrect
				arg1.Instance:PivotTo(CFrame.new(graphPoint_upvr(TweenService_upvr:GetValue(arg1._time, arg1._style, arg1._direction), unpack(arg1.TweenInfo.Waypoints))))
			end
			local var24 = arg1
			var24._time += RunService_upvr.Heartbeat:Wait() / arg1.TweenInfo.Time
		end
		arg1.PlaybackState = Enum.PlaybackState.Completed
		arg1.Completed:Fire()
		arg1.Ended:Fire()
		return "Completed"
	end)
end
function module_upvr.Pause(arg1) -- Line 118
	if arg1.PlaybackState ~= Enum.PlaybackState.Paused then
		arg1.PlaybackState = Enum.PlaybackState.Paused
		arg1.Paused:Fire()
	end
end
function module_upvr.Resume(arg1) -- Line 125
	if arg1.PlaybackState == Enum.PlaybackState.Paused then
		arg1:Play()
		arg1.Resumed:Fire()
	end
end
function module_upvr.Cancel(arg1) -- Line 132
	if arg1.PlaybackState ~= Enum.PlaybackState.Cancelled then
		arg1.PlaybackState = Enum.PlaybackState.Cancelled
		arg1.Cancelled:Fire()
		arg1.Ended:Fire()
	end
end
return module_upvr