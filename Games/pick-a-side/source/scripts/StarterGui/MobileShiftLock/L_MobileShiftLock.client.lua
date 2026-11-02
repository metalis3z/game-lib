-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-17 20:45:47
-- Luau version 6, Types version 3
-- Time taken: 0.002410 seconds

local var1_upvw = false
local Button_upvr = script.Parent.Button
if not game:GetService("UserInputService").TouchEnabled then
else
	Button_upvr.Visible = true
	local mouse_upvr = game.Players.LocalPlayer:GetMouse()
	Button_upvr.Activated:Connect(function() -- Line 38, Named "Toggle"
		--[[ Upvalues[3]:
			[1]: var1_upvw (read and write)
			[2]: Button_upvr (readonly)
			[3]: mouse_upvr (readonly)
		]]
		var1_upvw = not var1_upvw
		if var1_upvw then
			Button_upvr.Image = "rbxasset://textures/ui/mouseLock_on.png"
			mouse_upvr.Icon = "rbxasset://textures/MouseLockedCursor.png"
		else
			Button_upvr.Image = "rbxasset://textures/ui/mouseLock_off.png"
			mouse_upvr.Icon = ""
		end
	end)
	local LocalPlayer_upvr = game.Players.LocalPlayer
	local CurrentCamera_upvr = workspace.CurrentCamera
	local new_upvr = CFrame.new
	local Angles_upvr = CFrame.Angles
	local atan2_upvr = math.atan2
	game:GetService("RunService"):BindToRenderStep("MobileShiftLock", Enum.RenderPriority.Camera.Value + 1, function() -- Line 52, Named "CameraStep"
		--[[ Upvalues[6]:
			[1]: var1_upvw (read and write)
			[2]: LocalPlayer_upvr (readonly)
			[3]: CurrentCamera_upvr (readonly)
			[4]: new_upvr (readonly)
			[5]: Angles_upvr (readonly)
			[6]: atan2_upvr (readonly)
		]]
		if not var1_upvw then
		else
			local Character = LocalPlayer_upvr.Character
			if not Character then return end
			local Humanoid = Character:FindFirstChild("Humanoid")
			local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
			if HumanoidRootPart and Humanoid and 0 < Humanoid.Health then
				local LookVector = CurrentCamera_upvr.CFrame.LookVector
				HumanoidRootPart.CFrame = new_upvr(HumanoidRootPart.Position) * Angles_upvr(0, atan2_upvr(-LookVector.X, -LookVector.Z), 0)
			end
			if 1 <= (Character:FindFirstChild("Head").Position - CurrentCamera_upvr.CFrame.Position).Magnitude then
				CurrentCamera_upvr.CFrame *= new_upvr(1.75, 0, 0)
			end
		end
	end)
end