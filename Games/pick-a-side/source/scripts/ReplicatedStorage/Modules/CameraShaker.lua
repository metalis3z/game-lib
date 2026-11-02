-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-17 20:45:09
-- Luau version 6, Types version 3
-- Time taken: 0.008235 seconds

local module_upvr = {}
module_upvr.__index = module_upvr
local zero_vector3_upvr = Vector3.new()
local CameraShakeInstance_upvr = require(script.CameraShakeInstance)
module_upvr.CameraShakeInstance = CameraShakeInstance_upvr
module_upvr.Presets = require(script.CameraShakePresets)
function module_upvr.new(arg1, arg2) -- Line 74
	--[[ Upvalues[2]:
		[1]: zero_vector3_upvr (readonly)
		[2]: module_upvr (readonly)
	]]
	local var4
	if type(arg1) ~= "number" then
		var4 = false
	else
		var4 = true
	end
	assert(var4, "RenderPriority must be a number (e.g.: Enum.RenderPriority.Camera.Value)")
	if type(arg2) ~= "function" then
		var4 = false
	else
		var4 = true
	end
	assert(var4, "Callback must be a function")
	var4 = {}
	var4._running = false
	var4._renderName = "CameraShaker"
	var4._renderPriority = arg1
	var4._posAddShake = zero_vector3_upvr
	var4._rotAddShake = zero_vector3_upvr
	var4._camShakeInstances = {}
	var4._removeInstances = {}
	var4._callback = arg2
	return setmetatable(var4, module_upvr)
end
local profilebegin_upvr = debug.profilebegin
local profileend_upvr = debug.profileend
function module_upvr.Start(arg1) -- Line 95
	--[[ Upvalues[2]:
		[1]: profilebegin_upvr (readonly)
		[2]: profileend_upvr (readonly)
	]]
	if arg1._running then
	else
		arg1._running = true
		local _callback_upvr = arg1._callback
		game:GetService("RunService"):BindToRenderStep(arg1._renderName, arg1._renderPriority, function(arg1_2) -- Line 99
			--[[ Upvalues[4]:
				[1]: profilebegin_upvr (copied, readonly)
				[2]: arg1 (readonly)
				[3]: profileend_upvr (copied, readonly)
				[4]: _callback_upvr (readonly)
			]]
			profilebegin_upvr("CameraShakerUpdate")
			profileend_upvr()
			_callback_upvr(arg1:Update(arg1_2))
		end)
	end
end
function module_upvr.Stop(arg1) -- Line 108
	if not arg1._running then
	else
		game:GetService("RunService"):UnbindFromRenderStep(arg1._renderName)
		arg1._running = false
	end
end
local CameraShakeState_upvr = CameraShakeInstance_upvr.CameraShakeState
local new_2_upvr = CFrame.new
local Angles_upvr = CFrame.Angles
local rad_upvr = math.rad
function module_upvr.Update(arg1, arg2) -- Line 115
	--[[ Upvalues[5]:
		[1]: zero_vector3_upvr (readonly)
		[2]: CameraShakeState_upvr (readonly)
		[3]: new_2_upvr (readonly)
		[4]: Angles_upvr (readonly)
		[5]: rad_upvr (readonly)
	]]
	-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
	local _camShakeInstances = arg1._camShakeInstances
	local var22
	for i = 1, #_camShakeInstances do
		local var23 = _camShakeInstances[i]
		local any_GetState_result1 = var23:GetState()
		if any_GetState_result1 == CameraShakeState_upvr.Inactive and var23.DeleteOnInactive then
			arg1._removeInstances[#arg1._removeInstances + 1] = i
		elseif any_GetState_result1 ~= CameraShakeState_upvr.Inactive then
			var22 += var23:UpdateShake(arg2) * var23.PositionInfluence
			local var25 = zero_vector3_upvr + var23:UpdateShake(arg2) * var23.RotationInfluence
		end
	end
	for i_2 = #arg1._removeInstances, 1, -1 do
		table.remove(_camShakeInstances, arg1._removeInstances[i_2])
		arg1._removeInstances[i_2] = nil
	end
	return new_2_upvr(var22) * Angles_upvr(0, rad_upvr(var25.Y), 0) * Angles_upvr(rad_upvr(var25.X), 0, rad_upvr(var25.Z))
end
function module_upvr.Shake(arg1, arg2) -- Line 151
	local var26 = false
	if type(arg2) == "table" then
		var26 = arg2._camShakeInstance
	end
	assert(var26, "ShakeInstance must be of type CameraShakeInstance")
	arg1._camShakeInstances[#arg1._camShakeInstances + 1] = arg2
	return arg2
end
function module_upvr.ShakeSustain(arg1, arg2) -- Line 158
	local var27 = false
	if type(arg2) == "table" then
		var27 = arg2._camShakeInstance
	end
	assert(var27, "ShakeInstance must be of type CameraShakeInstance")
	arg1._camShakeInstances[#arg1._camShakeInstances + 1] = arg2
	arg2:StartFadeIn(arg2.fadeInDuration)
	return arg2
end
function module_upvr.ShakeOnce(arg1, arg2, arg3, arg4, arg5, arg6, arg7) -- Line 166
	--[[ Upvalues[1]:
		[1]: CameraShakeInstance_upvr (readonly)
	]]
	local any_new_result1 = CameraShakeInstance_upvr.new(arg2, arg3, arg4, arg5)
	local var29
	local function INLINED() -- Internal function, doesn't exist in bytecode
		var29 = arg6
		return var29
	end
	if typeof(arg6) ~= "Vector3" or not INLINED() then
		var29 = Vector3.new(0.15000, 0.15000, 0.15000)
	end
	any_new_result1.PositionInfluence = var29
	local function INLINED_2() -- Internal function, doesn't exist in bytecode
		var29 = arg7
		return var29
	end
	if typeof(arg7) ~= "Vector3" or not INLINED_2() then
		var29 = Vector3.new(1, 1, 1)
	end
	any_new_result1.RotationInfluence = var29
	var29 = arg1._camShakeInstances
	var29[#arg1._camShakeInstances + 1] = any_new_result1
	return any_new_result1
end
function module_upvr.StartShake(arg1, arg2, arg3, arg4, arg5, arg6) -- Line 175
	--[[ Upvalues[1]:
		[1]: CameraShakeInstance_upvr (readonly)
	]]
	local any_new_result1_2 = CameraShakeInstance_upvr.new(arg2, arg3, arg4)
	local var31
	local function INLINED_3() -- Internal function, doesn't exist in bytecode
		var31 = arg5
		return var31
	end
	if typeof(arg5) ~= "Vector3" or not INLINED_3() then
		var31 = Vector3.new(0.15000, 0.15000, 0.15000)
	end
	any_new_result1_2.PositionInfluence = var31
	local function INLINED_4() -- Internal function, doesn't exist in bytecode
		var31 = arg6
		return var31
	end
	if typeof(arg6) ~= "Vector3" or not INLINED_4() then
		var31 = Vector3.new(1, 1, 1)
	end
	any_new_result1_2.RotationInfluence = var31
	var31 = any_new_result1_2:StartFadeIn
	var31(arg4)
	var31 = arg1._camShakeInstances
	var31[#arg1._camShakeInstances + 1] = any_new_result1_2
	return any_new_result1_2
end
return module_upvr