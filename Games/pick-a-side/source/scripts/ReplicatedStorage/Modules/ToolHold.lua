-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-17 20:45:14
-- Luau version 6, Types version 3
-- Time taken: 0.004778 seconds

local var1_upvr = require(game.ReplicatedStorage.Modules.GetPlatform)()
local ViewportSize_upvr = workspace.CurrentCamera.ViewportSize
function isInputOffScreen(arg1) -- Line 19
	--[[ Upvalues[2]:
		[1]: var1_upvr (readonly)
		[2]: ViewportSize_upvr (readonly)
	]]
	-- KONSTANTERROR: [0] 1. Error Block 1 start (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [0] 1. Error Block 1 end (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [6] 5. Error Block 2 start (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [6] 5. Error Block 2 end (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [11] 8. Error Block 3 start (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [11] 8. Error Block 3 end (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [16] 11. Error Block 37 start (CF ANALYSIS FAILED)
	if ViewportSize_upvr.Y < 563 then
		-- KONSTANTWARNING: GOTO [25] #18
	end
	-- KONSTANTERROR: [16] 11. Error Block 37 end (CF ANALYSIS FAILED)
end
local UserInputService_upvr = game:GetService("UserInputService")
local MouseButton1_upvr = Enum.UserInputType.MouseButton1
local Touch_upvr = Enum.UserInputType.Touch
local ButtonR2_upvr = Enum.KeyCode.ButtonR2
local var8_upvw
local GuiService_upvr = game:GetService("GuiService")
local CurrentCamera_upvr = workspace.CurrentCamera
local MouseMovement_upvr = Enum.UserInputType.MouseMovement
return function(arg1, arg2) -- Line 49
	--[[ Upvalues[8]:
		[1]: UserInputService_upvr (readonly)
		[2]: MouseButton1_upvr (readonly)
		[3]: Touch_upvr (readonly)
		[4]: ButtonR2_upvr (readonly)
		[5]: var8_upvw (read and write)
		[6]: GuiService_upvr (readonly)
		[7]: CurrentCamera_upvr (readonly)
		[8]: MouseMovement_upvr (readonly)
	]]
	local var12_upvw
	local function _() -- Line 53, Named "release"
		--[[ Upvalues[2]:
			[1]: var12_upvw (read and write)
			[2]: arg2 (readonly)
		]]
		if var12_upvw then
			var12_upvw:Disconnect()
		end
		arg2()
	end
	UserInputService_upvr.InputEnded:Connect(function(arg1_2) -- Line 61
		--[[ Upvalues[6]:
			[1]: MouseButton1_upvr (copied, readonly)
			[2]: Touch_upvr (copied, readonly)
			[3]: ButtonR2_upvr (copied, readonly)
			[4]: var8_upvw (copied, read and write)
			[5]: var12_upvw (read and write)
			[6]: arg2 (readonly)
		]]
		local UserInputType_3 = arg1_2.UserInputType
		if UserInputType_3 == MouseButton1_upvr or UserInputType_3 == Touch_upvr or arg1_2.KeyCode == ButtonR2_upvr then
			if UserInputType_3 == Touch_upvr and arg1_2 ~= var8_upvw then return end
			if var12_upvw then
				var12_upvw:Disconnect()
			end
			arg2()
		end
	end)
	GuiService_upvr.MenuOpened:Connect(function() -- Line 70
		--[[ Upvalues[2]:
			[1]: var12_upvw (read and write)
			[2]: arg2 (readonly)
		]]
		if var12_upvw then
			var12_upvw:Disconnect()
		end
		arg2()
	end)
	UserInputService_upvr.InputBegan:Connect(function(arg1_3, arg2_2) -- Line 75
		--[[ Upvalues[10]:
			[1]: MouseButton1_upvr (copied, readonly)
			[2]: Touch_upvr (copied, readonly)
			[3]: ButtonR2_upvr (copied, readonly)
			[4]: CurrentCamera_upvr (copied, readonly)
			[5]: var12_upvw (read and write)
			[6]: UserInputService_upvr (copied, readonly)
			[7]: MouseMovement_upvr (copied, readonly)
			[8]: arg2 (readonly)
			[9]: var8_upvw (copied, read and write)
			[10]: arg1 (readonly)
		]]
		local UserInputType_2 = arg1_3.UserInputType
		if not arg2_2 and (UserInputType_2 == MouseButton1_upvr or UserInputType_2 == Touch_upvr or arg1_3.KeyCode == ButtonR2_upvr) then
			if arg1_3.KeyCode ~= ButtonR2_upvr and isInputOffScreen(arg1_3) == true then return end
			if CurrentCamera_upvr.CameraType == Enum.CameraType.Scriptable then return end
			if UserInputType_2 == MouseButton1_upvr or UserInputType_2 == Touch_upvr then
				var12_upvw = UserInputService_upvr.InputChanged:Connect(function(arg1_4) -- Line 90
					--[[ Upvalues[5]:
						[1]: MouseMovement_upvr (copied, readonly)
						[2]: Touch_upvr (copied, readonly)
						[3]: arg1_3 (readonly)
						[4]: var12_upvw (copied, read and write)
						[5]: arg2 (copied, readonly)
					]]
					local UserInputType = arg1_4.UserInputType
					if UserInputType == MouseMovement_upvr or UserInputType == Touch_upvr and arg1_4 == arg1_3 or isInputOffScreen(arg1_4) == true then
						if var12_upvw then
							var12_upvw:Disconnect()
						end
						arg2()
					end
				end)
			end
			if UserInputType_2 == Touch_upvr then
				var8_upvw = arg1_3
			end
			arg1(arg1_3)
		end
	end)
end