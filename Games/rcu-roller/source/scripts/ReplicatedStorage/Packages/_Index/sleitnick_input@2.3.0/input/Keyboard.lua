-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:15:57
-- Luau version 6, Types version 3
-- Time taken: 0.001477 seconds

local UserInputService_upvr = game:GetService("UserInputService")
local module_upvr = {}
module_upvr.__index = module_upvr
local Trove_upvr = require(script.Parent.Parent.Trove)
local Signal_upvr = require(script.Parent.Parent.Signal)
function module_upvr.new() -- Line 55
	--[[ Upvalues[3]:
		[1]: module_upvr (readonly)
		[2]: Trove_upvr (readonly)
		[3]: Signal_upvr (readonly)
	]]
	local setmetatable_result1 = setmetatable({}, module_upvr)
	setmetatable_result1._trove = Trove_upvr.new()
	setmetatable_result1.KeyDown = setmetatable_result1._trove:Construct(Signal_upvr)
	setmetatable_result1.KeyUp = setmetatable_result1._trove:Construct(Signal_upvr)
	setmetatable_result1:_setup()
	return setmetatable_result1
end
function module_upvr.IsKeyDown(arg1, arg2) -- Line 72
	--[[ Upvalues[1]:
		[1]: UserInputService_upvr (readonly)
	]]
	return UserInputService_upvr:IsKeyDown(arg2)
end
function module_upvr.AreKeysDown(arg1, arg2, arg3) -- Line 84
	local any_IsKeyDown_result1 = arg1:IsKeyDown(arg2)
	if any_IsKeyDown_result1 then
		any_IsKeyDown_result1 = arg1:IsKeyDown(arg3)
	end
	return any_IsKeyDown_result1
end
function module_upvr.AreEitherKeysDown(arg1, arg2, arg3) -- Line 99
	local any_IsKeyDown_result1_2 = arg1:IsKeyDown(arg2)
	if not any_IsKeyDown_result1_2 then
		any_IsKeyDown_result1_2 = arg1:IsKeyDown(arg3)
	end
	return any_IsKeyDown_result1_2
end
function module_upvr._setup(arg1) -- Line 103
	--[[ Upvalues[1]:
		[1]: UserInputService_upvr (readonly)
	]]
	arg1._trove:Connect(UserInputService_upvr.InputBegan, function(arg1_2, arg2) -- Line 104
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		if arg2 then
		elseif arg1_2.UserInputType == Enum.UserInputType.Keyboard then
			arg1.KeyDown:Fire(arg1_2.KeyCode)
		end
	end)
	arg1._trove:Connect(UserInputService_upvr.InputEnded, function(arg1_3, arg2) -- Line 113
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		if arg2 then
		elseif arg1_3.UserInputType == Enum.UserInputType.Keyboard then
			arg1.KeyUp:Fire(arg1_3.KeyCode)
		end
	end)
end
function module_upvr.Destroy(arg1) -- Line 126
	arg1._trove:Destroy()
end
return module_upvr