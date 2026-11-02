-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-17 20:44:46
-- Luau version 6, Types version 3
-- Time taken: 0.002794 seconds

local Parent_upvr_2 = script.Parent
local Parent_upvr = Parent_upvr_2.Parent
local Debris_upvr = game:GetService("Debris")
Parent_upvr.Equipped:connect(function() -- Line 4
	--[[ Upvalues[2]:
		[1]: Parent_upvr_2 (readonly)
		[2]: Debris_upvr (readonly)
	]]
	local LocalPlayer_2 = game.Players.LocalPlayer
	if LocalPlayer_2 then
		local PlayerGui = LocalPlayer_2:FindFirstChild("PlayerGui")
		if PlayerGui then
			Parent_upvr_2.Parent = PlayerGui
			Debris_upvr:AddItem(Parent_upvr_2, 60)
		end
	end
end)
Parent_upvr.Unequipped:connect(function() -- Line 14
	--[[ Upvalues[2]:
		[1]: Parent_upvr_2 (readonly)
		[2]: Parent_upvr (readonly)
	]]
	Parent_upvr_2.Parent = Parent_upvr
end)
local Button = Parent_upvr_2:WaitForChild("Frame"):WaitForChild("Button")
function Fire(arg1) -- Line 25
end
Button.MouseButton1Down:Connect(function() -- Line 29
	Fire(true)
end)
Button.MouseButton1Up:Connect(function() -- Line 33
	Fire(false)
end)
local UserInputService = game:GetService("UserInputService")
if UserInputService.GamepadEnabled then
	Button.Text = 'Y'
end
UserInputService.InputBegan:Connect(function(arg1) -- Line 42
	local KeyCode_2 = arg1.KeyCode
	if KeyCode_2 == Enum.KeyCode.ButtonR1 or KeyCode_2 == Enum.KeyCode.ButtonY or KeyCode_2 == Enum.KeyCode.ButtonL2 then
		Fire(true)
	end
end)
UserInputService.InputEnded:Connect(function(arg1) -- Line 49
	local KeyCode = arg1.KeyCode
	if KeyCode == Enum.KeyCode.ButtonR1 or KeyCode == Enum.KeyCode.ButtonY or KeyCode == Enum.KeyCode.ButtonL2 then
		Fire(false)
	end
end)