-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:19:55
-- Luau version 6, Types version 3
-- Time taken: 0.003693 seconds

local RunService_upvr = game:GetService("RunService")
local module_upvr = {}
module_upvr.__index = module_upvr
local TweenService_upvr = game:GetService("TweenService")
local TweenInfo_new_result1_upvr = TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
local TweenInfo_new_result1_upvr_3 = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local TweenInfo_new_result1_upvr_2 = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
local TweenInfo_new_result1_upvr_4 = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
function module_upvr.new(arg1) -- Line 21
	--[[ Upvalues[6]:
		[1]: module_upvr (readonly)
		[2]: TweenService_upvr (readonly)
		[3]: TweenInfo_new_result1_upvr (readonly)
		[4]: TweenInfo_new_result1_upvr_3 (readonly)
		[5]: TweenInfo_new_result1_upvr_2 (readonly)
		[6]: TweenInfo_new_result1_upvr_4 (readonly)
	]]
	local setmetatable_result1 = setmetatable({}, module_upvr)
	setmetatable_result1._itemId = arg1
	setmetatable_result1._isPlaying = false
	setmetatable_result1._hasSetFirstCFrame = false
	setmetatable_result1._isLoaded = true
	setmetatable_result1._state = false
	setmetatable_result1._latestRaycastTime = 0
	setmetatable_result1._latestRaycastResult = nil
	setmetatable_result1._rotationValue = Instance.new("NumberValue")
	setmetatable_result1._heightValue = Instance.new("NumberValue")
	setmetatable_result1._rotationTweenIn = TweenService_upvr:Create(setmetatable_result1._rotationValue, TweenInfo_new_result1_upvr, {
		Value = -25;
	})
	setmetatable_result1._rotationTweenOut = TweenService_upvr:Create(setmetatable_result1._rotationValue, TweenInfo_new_result1_upvr, {
		Value = 25;
	})
	setmetatable_result1._rotationTweenZero = TweenService_upvr:Create(setmetatable_result1._rotationValue, TweenInfo_new_result1_upvr_3, {
		Value = 0;
	})
	setmetatable_result1._heightTweenIn = TweenService_upvr:Create(setmetatable_result1._heightValue, TweenInfo_new_result1_upvr_2, {
		Value = 0;
	})
	setmetatable_result1._heightTweenOut = TweenService_upvr:Create(setmetatable_result1._heightValue, TweenInfo_new_result1_upvr_4, {
		Value = 2;
	})
	setmetatable_result1:run()
	return setmetatable_result1
end
function module_upvr.getItemId(arg1) -- Line 50
	return arg1._itemId
end
function module_upvr.setInstance(arg1, arg2) -- Line 54
	arg1._instance = arg2
end
function module_upvr.getInstance(arg1) -- Line 57
	return arg1._instance
end
function module_upvr.setOwner(arg1, arg2) -- Line 61
	arg1._owner = arg2
end
function module_upvr.getOwner(arg1) -- Line 64
	return arg1._owner
end
function module_upvr.setFlying(arg1, arg2) -- Line 68
	arg1._flying = arg2
end
function module_upvr.getFlying(arg1) -- Line 71
	return arg1._flying
end
function module_upvr.setHidden(arg1, arg2) -- Line 75
	arg1._hidden = arg2
end
function module_upvr.getHidden(arg1) -- Line 78
	return arg1._hidden
end
function module_upvr.setPlacement(arg1, arg2) -- Line 82
	arg1._placement = arg2
end
function module_upvr.getPlacement(arg1) -- Line 85
	return arg1._placement
end
function module_upvr.setHasSetFirstCFrame(arg1, arg2) -- Line 89
	arg1._hasSetFirstCFrame = arg2
end
function module_upvr.getHasSetFirstCFrame(arg1) -- Line 92
	return arg1._hasSetFirstCFrame
end
function module_upvr.getHeight(arg1) -- Line 96
	return arg1._heightValue.Value
end
function module_upvr.getRotation(arg1) -- Line 99
	return arg1._rotationValue.Value
end
function module_upvr.getPriority(arg1) -- Line 103
end
function module_upvr.loadInstance(arg1) -- Line 107
	if arg1._isLoaded then
	else
		arg1._isLoaded = true
		arg1._instance.Parent = workspace.Game.Pets
	end
end
local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
function module_upvr.unloadInstance(arg1) -- Line 116
	--[[ Upvalues[1]:
		[1]: ReplicatedStorage_upvr (readonly)
	]]
	if not arg1._isLoaded then
	else
		arg1._isLoaded = false
		arg1._instance.Parent = ReplicatedStorage_upvr
	end
end
function module_upvr.onState(arg1) -- Line 126
	if not arg1._state then
		arg1._rotationTweenZero:Play()
		arg1._isPlaying = false
	end
end
function module_upvr.setState(arg1, arg2) -- Line 133
	arg1._state = arg2
	arg1:onState()
end
function module_upvr.raycast(arg1, arg2) -- Line 138
	if time() - arg1._latestRaycastTime < 0.1 then
		return arg1._latestRaycastResult
	end
	arg1._latestRaycastTime = time()
	debug.profilebegin(`playerPet/raycast/{arg1:getItemId()}`)
	local RaycastParams_new_result1 = RaycastParams.new()
	RaycastParams_new_result1.IgnoreWater = true
	RaycastParams_new_result1.RespectCanCollide = true
	RaycastParams_new_result1.FilterType = Enum.RaycastFilterType.Exclude
	RaycastParams_new_result1.FilterDescendantsInstances = {arg1:getOwner().Character, workspace.Game.Pets, workspace.Debris}
	arg1._latestRaycastResult = workspace:Raycast(arg2 + Vector3.new(0, 10, 0), Vector3.new(0, -50, 0), RaycastParams_new_result1)
	debug.profileend()
	return arg1._latestRaycastResult
end
function module_upvr.animate(arg1) -- Line 161
	task.spawn(function() -- Line 162
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		if not arg1._isPlaying then
			arg1._isPlaying = true
			arg1._rotationTweenIn:Play()
			arg1._heightTweenOut:Play()
			task.wait(0.2)
			arg1._heightTweenIn:Play()
			arg1._rotationTweenIn.Completed:Wait()
			if not arg1._state then
				arg1._rotationTweenZero:Play()
				arg1._isPlaying = false
				return
			end
			arg1._heightTweenIn:Play()
			arg1._rotationTweenOut:Play()
			arg1._heightTweenOut:Play()
			task.wait(0.2)
			arg1._heightTweenIn:Play()
			arg1._rotationTweenOut.Completed:Wait()
			arg1._isPlaying = false
		end
	end)
end
function module_upvr.run(arg1) -- Line 192
	--[[ Upvalues[1]:
		[1]: RunService_upvr (readonly)
	]]
	RunService_upvr:BindToRenderStep(`petMovement{arg1._itemId}`, 1, function() -- Line 193
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		if not arg1._state or arg1._isPlaying then
		else
			arg1:animate()
		end
	end)
end
function module_upvr.remove(arg1) -- Line 204
	--[[ Upvalues[2]:
		[1]: RunService_upvr (readonly)
		[2]: module_upvr (readonly)
	]]
	RunService_upvr:UnbindFromRenderStep(`petMovement{arg1._itemId}`)
	arg1._rotationValue:Destroy()
	arg1._heightValue:Destroy()
	arg1._rotationTweenIn:Destroy()
	arg1._rotationTweenOut:Destroy()
	arg1._rotationTweenZero:Destroy()
	arg1._heightTweenIn:Destroy()
	arg1._heightTweenOut:Destroy()
	setmetatable(module_upvr, nil)
end
return module_upvr