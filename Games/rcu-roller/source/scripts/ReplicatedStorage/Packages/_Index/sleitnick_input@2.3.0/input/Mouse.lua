-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:15:58
-- Luau version 6, Types version 3
-- Time taken: 0.002507 seconds

local UserInputService_upvr = game:GetService("UserInputService")
local module_upvr = {}
module_upvr.__index = module_upvr
local Trove_upvr = require(script.Parent.Parent.Trove)
local Signal_upvr = require(script.Parent.Parent.Signal)
function module_upvr.new() -- Line 81
	--[[ Upvalues[4]:
		[1]: module_upvr (readonly)
		[2]: Trove_upvr (readonly)
		[3]: Signal_upvr (readonly)
		[4]: UserInputService_upvr (readonly)
	]]
	local setmetatable_result1_upvr = setmetatable({}, module_upvr)
	setmetatable_result1_upvr._trove = Trove_upvr.new()
	setmetatable_result1_upvr.LeftDown = setmetatable_result1_upvr._trove:Construct(Signal_upvr)
	setmetatable_result1_upvr.LeftUp = setmetatable_result1_upvr._trove:Construct(Signal_upvr)
	setmetatable_result1_upvr.RightDown = setmetatable_result1_upvr._trove:Construct(Signal_upvr)
	setmetatable_result1_upvr.RightUp = setmetatable_result1_upvr._trove:Construct(Signal_upvr)
	setmetatable_result1_upvr.MiddleDown = setmetatable_result1_upvr._trove:Construct(Signal_upvr)
	setmetatable_result1_upvr.MiddleUp = setmetatable_result1_upvr._trove:Construct(Signal_upvr)
	setmetatable_result1_upvr.Scrolled = setmetatable_result1_upvr._trove:Construct(Signal_upvr)
	setmetatable_result1_upvr.Moved = setmetatable_result1_upvr._trove:Construct(Signal_upvr)
	setmetatable_result1_upvr._trove:Connect(UserInputService_upvr.InputBegan, function(arg1, arg2) -- Line 95
		--[[ Upvalues[1]:
			[1]: setmetatable_result1_upvr (readonly)
		]]
		if arg2 then
		else
			if arg1.UserInputType == Enum.UserInputType.MouseButton1 then
				setmetatable_result1_upvr.LeftDown:Fire()
				return
			end
			if arg1.UserInputType == Enum.UserInputType.MouseButton2 then
				setmetatable_result1_upvr.RightDown:Fire()
				return
			end
			if arg1.UserInputType == Enum.UserInputType.MouseButton3 then
				setmetatable_result1_upvr.MiddleDown:Fire()
			end
		end
	end)
	setmetatable_result1_upvr._trove:Connect(UserInputService_upvr.InputEnded, function(arg1, arg2) -- Line 108
		--[[ Upvalues[1]:
			[1]: setmetatable_result1_upvr (readonly)
		]]
		if arg2 then
		else
			if arg1.UserInputType == Enum.UserInputType.MouseButton1 then
				setmetatable_result1_upvr.LeftUp:Fire()
				return
			end
			if arg1.UserInputType == Enum.UserInputType.MouseButton2 then
				setmetatable_result1_upvr.RightUp:Fire()
				return
			end
			if arg1.UserInputType == Enum.UserInputType.MouseButton3 then
				setmetatable_result1_upvr.MiddleUp:Fire()
			end
		end
	end)
	setmetatable_result1_upvr._trove:Connect(UserInputService_upvr.InputChanged, function(arg1, arg2) -- Line 121
		--[[ Upvalues[1]:
			[1]: setmetatable_result1_upvr (readonly)
		]]
		if arg2 then
		else
			if arg1.UserInputType == Enum.UserInputType.MouseMovement then
				local Position = arg1.Position
				setmetatable_result1_upvr.Moved:Fire(Vector2.new(Position.X, Position.Y))
				return
			end
			if arg1.UserInputType == Enum.UserInputType.MouseWheel then
				setmetatable_result1_upvr.Scrolled:Fire(arg1.Position.Z)
			end
		end
	end)
	return setmetatable_result1_upvr
end
function module_upvr.IsLeftDown(arg1) -- Line 139
	--[[ Upvalues[1]:
		[1]: UserInputService_upvr (readonly)
	]]
	return UserInputService_upvr:IsMouseButtonPressed(Enum.UserInputType.MouseButton1)
end
function module_upvr.IsRightDown(arg1) -- Line 146
	--[[ Upvalues[1]:
		[1]: UserInputService_upvr (readonly)
	]]
	return UserInputService_upvr:IsMouseButtonPressed(Enum.UserInputType.MouseButton2)
end
function module_upvr.IsMiddleDown(arg1) -- Line 153
	--[[ Upvalues[1]:
		[1]: UserInputService_upvr (readonly)
	]]
	return UserInputService_upvr:IsMouseButtonPressed(Enum.UserInputType.MouseButton3)
end
function module_upvr.GetPosition(arg1) -- Line 160
	--[[ Upvalues[1]:
		[1]: UserInputService_upvr (readonly)
	]]
	return UserInputService_upvr:GetMouseLocation()
end
function module_upvr.GetDelta(arg1) -- Line 174
	--[[ Upvalues[1]:
		[1]: UserInputService_upvr (readonly)
	]]
	return UserInputService_upvr:GetMouseDelta()
end
function module_upvr.GetRay(arg1, arg2) -- Line 182
	--[[ Upvalues[1]:
		[1]: UserInputService_upvr (readonly)
	]]
	local var10 = arg2
	if not var10 then
		var10 = UserInputService_upvr:GetMouseLocation()
	end
	return workspace.CurrentCamera:ViewportPointToRay(var10.X, var10.Y)
end
function module_upvr.Raycast(arg1, arg2, arg3, arg4) -- Line 209
	local any_GetRay_result1_2 = arg1:GetRay(arg4)
	return workspace:Raycast(any_GetRay_result1_2.Origin, any_GetRay_result1_2.Direction * (arg3 or 1000), arg2)
end
function module_upvr.Project(arg1, arg2, arg3) -- Line 241
	local any_GetRay_result1 = arg1:GetRay(arg3)
	return any_GetRay_result1.Origin + any_GetRay_result1.Direction.Unit * (arg2 or 1000)
end
function module_upvr.Lock(arg1) -- Line 255
	--[[ Upvalues[1]:
		[1]: UserInputService_upvr (readonly)
	]]
	UserInputService_upvr.MouseBehavior = Enum.MouseBehavior.LockCurrentPosition
end
function module_upvr.LockCenter(arg1) -- Line 266
	--[[ Upvalues[1]:
		[1]: UserInputService_upvr (readonly)
	]]
	UserInputService_upvr.MouseBehavior = Enum.MouseBehavior.LockCenter
end
function module_upvr.Unlock(arg1) -- Line 273
	--[[ Upvalues[1]:
		[1]: UserInputService_upvr (readonly)
	]]
	UserInputService_upvr.MouseBehavior = Enum.MouseBehavior.Default
end
function module_upvr.Destroy(arg1) -- Line 280
	arg1._trove:Destroy()
end
return module_upvr