-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:16:00
-- Luau version 6, Types version 3
-- Time taken: 0.001070 seconds

local UserInputService_upvr = game:GetService("UserInputService")
local module_upvr = {}
module_upvr.__index = module_upvr
local Trove_upvr = require(script.Parent.Parent.Trove)
local Signal_upvr = require(script.Parent.Parent.Signal)
function module_upvr.new() -- Line 87
	--[[ Upvalues[4]:
		[1]: module_upvr (readonly)
		[2]: Trove_upvr (readonly)
		[3]: Signal_upvr (readonly)
		[4]: UserInputService_upvr (readonly)
	]]
	local setmetatable_result1 = setmetatable({}, module_upvr)
	setmetatable_result1._trove = Trove_upvr.new()
	setmetatable_result1.TouchTap = setmetatable_result1._trove:Construct(Signal_upvr.Wrap, UserInputService_upvr.TouchTap)
	setmetatable_result1.TouchTapInWorld = setmetatable_result1._trove:Construct(Signal_upvr.Wrap, UserInputService_upvr.TouchTapInWorld)
	setmetatable_result1.TouchMoved = setmetatable_result1._trove:Construct(Signal_upvr.Wrap, UserInputService_upvr.TouchMoved)
	setmetatable_result1.TouchLongPress = setmetatable_result1._trove:Construct(Signal_upvr.Wrap, UserInputService_upvr.TouchLongPress)
	setmetatable_result1.TouchPan = setmetatable_result1._trove:Construct(Signal_upvr.Wrap, UserInputService_upvr.TouchPan)
	setmetatable_result1.TouchPinch = setmetatable_result1._trove:Construct(Signal_upvr.Wrap, UserInputService_upvr.TouchPinch)
	setmetatable_result1.TouchRotate = setmetatable_result1._trove:Construct(Signal_upvr.Wrap, UserInputService_upvr.TouchRotate)
	setmetatable_result1.TouchSwipe = setmetatable_result1._trove:Construct(Signal_upvr.Wrap, UserInputService_upvr.TouchSwipe)
	setmetatable_result1.TouchStarted = setmetatable_result1._trove:Construct(Signal_upvr.Wrap, UserInputService_upvr.TouchStarted)
	setmetatable_result1.TouchEnded = setmetatable_result1._trove:Construct(Signal_upvr.Wrap, UserInputService_upvr.TouchEnded)
	return setmetatable_result1
end
function module_upvr.IsTouchEnabled(arg1) -- Line 109
	--[[ Upvalues[1]:
		[1]: UserInputService_upvr (readonly)
	]]
	return UserInputService_upvr.TouchEnabled
end
function module_upvr.Destroy(arg1) -- Line 116
	arg1._trove:Destroy()
end
return module_upvr