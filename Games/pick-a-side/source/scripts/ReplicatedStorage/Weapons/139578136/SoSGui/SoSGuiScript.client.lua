-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-17 20:44:25
-- Luau version 6, Types version 3
-- Time taken: 0.001901 seconds

local Parent = script.Parent
local AbilityRemoteEvent_upvr = Parent.Parent:WaitForChild("SoSScript"):WaitForChild("AbilityRemoteEvent")
local Frame = Parent:WaitForChild("Frame")
Frame:WaitForChild("BtnSpin").MouseButton1Click:connect(function() -- Line 11, Named "onButtonSpin"
	--[[ Upvalues[1]:
		[1]: AbilityRemoteEvent_upvr (readonly)
	]]
	AbilityRemoteEvent_upvr:FireServer('e')
end)
Frame:WaitForChild("BtnSmash").MouseButton1Click:connect(function() -- Line 15, Named "onButtonSmash"
	--[[ Upvalues[1]:
		[1]: AbilityRemoteEvent_upvr (readonly)
	]]
	AbilityRemoteEvent_upvr:FireServer('q')
end)
local UserInputService = game:GetService("UserInputService")
if UserInputService.GamepadEnabled then
	Frame:WaitForChild("cdSmash").Text = 'Y'
	Frame:WaitForChild("cdSpin").Text = 'B'
end
UserInputService.InputBegan:Connect(function(arg1) -- Line 27
	--[[ Upvalues[1]:
		[1]: AbilityRemoteEvent_upvr (readonly)
	]]
	local KeyCode = arg1.KeyCode
	if KeyCode == Enum.KeyCode.ButtonY or KeyCode == Enum.KeyCode.ButtonL2 then
		AbilityRemoteEvent_upvr:FireServer('q')
	end
end)
UserInputService.InputBegan:Connect(function(arg1) -- Line 33
	--[[ Upvalues[1]:
		[1]: AbilityRemoteEvent_upvr (readonly)
	]]
	local KeyCode_2 = arg1.KeyCode
	if KeyCode_2 == Enum.KeyCode.ButtonR1 or KeyCode_2 == Enum.KeyCode.ButtonB then
		AbilityRemoteEvent_upvr:FireServer('e')
	end
end)