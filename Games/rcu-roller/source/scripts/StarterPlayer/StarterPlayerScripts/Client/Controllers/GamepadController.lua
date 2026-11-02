-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:20:01
-- Luau version 6, Types version 3
-- Time taken: 0.001793 seconds

local Knit_upvr = require(game:GetService("ReplicatedStorage").Packages.Knit)
local any_CreateController_result1 = Knit_upvr.CreateController({
	Name = "GamepadController";
})
local var4_upvw
local UserInputService_upvr = game:GetService("UserInputService")
local MainUI_upvr = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("MainUI")
function any_CreateController_result1.showGamepadInstances(arg1, arg2) -- Line 29
	--[[ Upvalues[2]:
		[1]: MainUI_upvr (readonly)
		[2]: UserInputService_upvr (readonly)
	]]
	for _, v in pairs(MainUI_upvr:GetDescendants()) do
		if v:GetAttribute("isControllerIcon") then
			if v:GetAttribute("keyCodeImage") then
				v.Image = UserInputService_upvr:GetImageForKeyCode(v:GetAttribute("keyCodeImage"))
			end
			v.Visible = arg2
		end
		if v:GetAttribute("isNotControllerIcon") then
			v.Visible = not arg2
		end
	end
end
function any_CreateController_result1.gamepadConnected(arg1) -- Line 43
	--[[ Upvalues[1]:
		[1]: UserInputService_upvr (readonly)
	]]
	UserInputService_upvr.GamepadConnected:Connect(function() -- Line 44
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:showGamepadInstances(true)
	end)
end
function any_CreateController_result1.gamepasDisconnected(arg1) -- Line 49
	--[[ Upvalues[1]:
		[1]: UserInputService_upvr (readonly)
	]]
	UserInputService_upvr.GamepadDisconnected:Connect(function() -- Line 50
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:showGamepadInstances(false)
	end)
end
function any_CreateController_result1.isGamepadEnabled(arg1) -- Line 55
	--[[ Upvalues[1]:
		[1]: UserInputService_upvr (readonly)
	]]
	arg1:showGamepadInstances(UserInputService_upvr.GamepadEnabled)
end
function any_CreateController_result1.inputs(arg1) -- Line 59
	--[[ Upvalues[2]:
		[1]: UserInputService_upvr (readonly)
		[2]: var4_upvw (read and write)
	]]
	UserInputService_upvr.InputBegan:Connect(function(arg1_2, arg2) -- Line 60
		--[[ Upvalues[1]:
			[1]: var4_upvw (copied, read and write)
		]]
		if arg1_2.UserInputType == Enum.UserInputType.Gamepad1 and arg1_2.KeyCode == Enum.KeyCode.ButtonB then
			var4_upvw:closeAllFrames("None")
		end
	end)
end
function any_CreateController_result1.KnitStart(arg1) -- Line 69
	arg1:isGamepadEnabled()
	arg1:gamepadConnected()
	arg1:gamepasDisconnected()
	arg1:inputs()
end
local var15_upvw
function any_CreateController_result1.KnitInit(arg1) -- Line 77
	--[[ Upvalues[3]:
		[1]: var15_upvw (read and write)
		[2]: Knit_upvr (readonly)
		[3]: var4_upvw (read and write)
	]]
	var15_upvw = Knit_upvr.GetController("DataController")
	var4_upvw = Knit_upvr.GetController("UIController")
end
return any_CreateController_result1