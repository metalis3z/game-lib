-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:19:52
-- Luau version 6, Types version 3
-- Time taken: 0.011045 seconds

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players_upvr = game:GetService("Players")
local TweenService_upvr = game:GetService("TweenService")
local var4_upvw
local Util_upvr = require(ReplicatedStorage.Shared.Util)
local LocalPlayer_upvr = Players_upvr.LocalPlayer
local PlayerGui = LocalPlayer_upvr:WaitForChild("PlayerGui")
local MainUI_upvr = PlayerGui:WaitForChild("MainUI")
local Overlays_upvr = PlayerGui:WaitForChild("Overlays")
local CurrentCamera_upvr = workspace.CurrentCamera
local Assets_upvr = ReplicatedStorage.Assets
local function _(arg1) -- Line 34, Named "startAndEnd"
	--[[ Upvalues[2]:
		[1]: MainUI_upvr (readonly)
		[2]: CurrentCamera_upvr (readonly)
	]]
	MainUI_upvr.Enabled = not arg1
	local var12
	local function INLINED() -- Internal function, doesn't exist in bytecode
		var12 = Enum.CameraType.Scriptable
		return var12
	end
	if not arg1 or not INLINED() then
		var12 = Enum.CameraType.Custom
	end
	CurrentCamera_upvr.CameraType = var12
end
local function _() -- Line 39, Named "createCharacter"
	--[[ Upvalues[2]:
		[1]: Players_upvr (readonly)
		[2]: LocalPlayer_upvr (readonly)
	]]
	local var13_upvw
	local _, _ = pcall(function() -- Line 41
		--[[ Upvalues[3]:
			[1]: var13_upvw (read and write)
			[2]: Players_upvr (copied, readonly)
			[3]: LocalPlayer_upvr (copied, readonly)
		]]
		var13_upvw = Players_upvr:CreateHumanoidModelFromUserId(LocalPlayer_upvr.UserId)
	end)
	if var13_upvw then
		var13_upvw.Name = ""
		var13_upvw.Parent = workspace.Debris
	end
	return var13_upvw
end
local function _() -- Line 53, Named "createOverlay"
	--[[ Upvalues[2]:
		[1]: Assets_upvr (readonly)
		[2]: Overlays_upvr (readonly)
	]]
	local clone = Assets_upvr.UI.FX.Flash:Clone()
	clone.Parent = Overlays_upvr
	return clone
end
local function tweenCamera_upvr(arg1, arg2, arg3, arg4, arg5) -- Line 60, Named "tweenCamera"
	--[[ Upvalues[2]:
		[1]: CurrentCamera_upvr (readonly)
		[2]: TweenService_upvr (readonly)
	]]
	CurrentCamera_upvr.CFrame = arg1[`Loc_{arg2}_1`].CFrame
	local var18 = arg4
	if not var18 then
		var18 = Enum.EasingStyle.Linear
	end
	local var19 = arg5
	if not var19 then
		var19 = Enum.EasingDirection.Out
	end
	TweenService_upvr:Create(CurrentCamera_upvr, TweenInfo.new(arg3, var18, var19), {
		CFrame = arg1[`Loc_{arg2}_2`].CFrame;
	}):Play()
end
local function tweenFOV_upvr(arg1, arg2, arg3, arg4) -- Line 68, Named "tweenFOV"
	--[[ Upvalues[2]:
		[1]: TweenService_upvr (readonly)
		[2]: CurrentCamera_upvr (readonly)
	]]
	local var21 = arg3
	if not var21 then
		var21 = Enum.EasingStyle.Linear
	end
	local var22 = arg4
	if not var22 then
		var22 = Enum.EasingDirection.Out
	end
	local tbl_3 = {}
	tbl_3.FieldOfView = arg1
	TweenService_upvr:Create(CurrentCamera_upvr, TweenInfo.new(arg2, var21, var22), tbl_3):Play()
end
local function _() -- Line 74, Named "canOverrideMute"
	--[[ Upvalues[2]:
		[1]: var4_upvw (read and write)
		[2]: Util_upvr (readonly)
	]]
	local any_getData_result1_4 = var4_upvw:getData()
	if not Util_upvr.settingUtils.getSetting(any_getData_result1_4, "muteSounds") then
		return true
	end
	local any_getSettingValue_result1_4 = Util_upvr.settingUtils.getSettingValue(any_getData_result1_4, "extraHatchingSounds")
	if not any_getSettingValue_result1_4 then return end
	if 8 < any_getSettingValue_result1_4 then return end
	return true
end
local var27_upvw
local Knit_upvr = require(game:GetService("ReplicatedStorage").Packages.Knit)
local var29_upvw
local TweenInfo_new_result1_upvr_2 = TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
local TweenInfo_new_result1_upvr = TweenInfo.new(2, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
local Shake_upvr = require(ReplicatedStorage.Packages.Shake)
local Functions_upvr = require(ReplicatedStorage.Shared.Functions)
return function(arg1) -- Line 93
	--[[ Upvalues[18]:
		[1]: var27_upvw (read and write)
		[2]: Knit_upvr (readonly)
		[3]: var29_upvw (read and write)
		[4]: var4_upvw (read and write)
		[5]: Assets_upvr (readonly)
		[6]: Overlays_upvr (readonly)
		[7]: TweenService_upvr (readonly)
		[8]: TweenInfo_new_result1_upvr_2 (readonly)
		[9]: Players_upvr (readonly)
		[10]: LocalPlayer_upvr (readonly)
		[11]: Util_upvr (readonly)
		[12]: TweenInfo_new_result1_upvr (readonly)
		[13]: MainUI_upvr (readonly)
		[14]: CurrentCamera_upvr (readonly)
		[15]: tweenCamera_upvr (readonly)
		[16]: tweenFOV_upvr (readonly)
		[17]: Shake_upvr (readonly)
		[18]: Functions_upvr (readonly)
	]]
	-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
	-- KONSTANTERROR: [0] 1. Error Block 89 start (CF ANALYSIS FAILED)
	var27_upvw = Knit_upvr.GetController("SoundController")
	var29_upvw = Knit_upvr.GetController("HatchingController")
	var4_upvw = Knit_upvr.GetController("DataController")
	var27_upvw:preloadSounds({"Secret Cutscene", "Cauldron Bubble", "Secret Pet Grow"})
	local clone_2 = Assets_upvr.UI.FX.Flash:Clone()
	clone_2.Parent = Overlays_upvr
	local var44 = clone_2
	TweenService_upvr:Create(var44, TweenInfo_new_result1_upvr_2, {
		BackgroundTransparency = 0;
	}):Play()
	local var46_upvw
	local _, _ = pcall(function() -- Line 41
		--[[ Upvalues[3]:
			[1]: var46_upvw (read and write)
			[2]: Players_upvr (copied, readonly)
			[3]: LocalPlayer_upvr (copied, readonly)
		]]
		var46_upvw = Players_upvr:CreateHumanoidModelFromUserId(LocalPlayer_upvr.UserId)
	end)
	local var50
	if var46_upvw then
		var46_upvw.Name = ""
		var46_upvw.Parent = workspace.Debris
	end
	local var51_upvr = var46_upvw
	task.wait(1)
	var50 = "Secret Cutscene"
	local tbl_4 = {}
	local var53 = 0.45
	tbl_4.volume = var53
	local any_getData_result1_3 = var4_upvw:getData()
	if not Util_upvr.settingUtils.getSetting(any_getData_result1_3, "muteSounds") then
		var53 = true
	else
		local any_getSettingValue_result1_5 = Util_upvr.settingUtils.getSettingValue(any_getData_result1_3, "extraHatchingSounds")
		if not any_getSettingValue_result1_5 then
			var53 = nil
		elseif 8 < any_getSettingValue_result1_5 then
			var53 = nil
		else
			var53 = true
		end
	end
	tbl_4.overrideMute = var53
	var50 = 1.5
	task.wait(var50)
	TweenService_upvr:Create(var44, TweenInfo_new_result1_upvr, {
		BackgroundTransparency = 1;
	}):Play()
	var50 = false
	MainUI_upvr.Enabled = var50
	var50 = Enum.CameraType.Scriptable
	if not var50 then
		var50 = Enum.CameraType.Custom
	end
	CurrentCamera_upvr.CameraType = var50
	var50 = CurrentCamera_upvr
	var50 = var51_upvr:WaitForChild("HumanoidRootPart")
	local Humanoid = var51_upvr:WaitForChild("Humanoid")
	local any_LoadAnimation_result1 = Humanoid.Animator:LoadAnimation(Assets_upvr.Animations["Secret Stir"])
	var50.Anchored = true
	local clone_upvr = Assets_upvr.Cutscenes.Secret:Clone()
	clone_upvr.Parent = workspace.Game.Cutscenes
	var51_upvr:PivotTo(clone_upvr.Positions.CharWait.CFrame)
	tweenCamera_upvr(clone_upvr.Cameras, 1, 5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	CurrentCamera_upvr.FieldOfView = 90
	tweenFOV_upvr(70, 5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
	task.wait(5)
	var51_upvr:PivotTo(clone_upvr.Positions.CharEnd.CFrame + Vector3.new(0, var50.Size.Y / 2, 0) + Vector3.new(0, Humanoid.HipHeight, 0))
	tweenCamera_upvr(clone_upvr.Cameras, 2, 4, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
	CurrentCamera_upvr.FieldOfView = 60
	tweenFOV_upvr(70, 4, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
	local tbl_2 = {}
	local var61 = 0.3
	tbl_2.volume = var61
	local any_getData_result1 = var4_upvw:getData()
	if not Util_upvr.settingUtils.getSetting(any_getData_result1, "muteSounds") then
		var61 = true
	else
		local any_getSettingValue_result1 = Util_upvr.settingUtils.getSettingValue(any_getData_result1, "extraHatchingSounds")
		if not any_getSettingValue_result1 then
			var61 = nil
		elseif 8 < any_getSettingValue_result1 then
			var61 = nil
		else
			var61 = true
		end
	end
	tbl_2.overrideMute = var61
	task.wait(1)
	any_LoadAnimation_result1:Play()
	local var64_upvw
	any_LoadAnimation_result1:GetMarkerReachedSignal("skapaFlaska"):Connect(function() -- Line 160
		--[[ Upvalues[4]:
			[1]: var64_upvw (read and write)
			[2]: Assets_upvr (copied, readonly)
			[3]: clone_upvr (readonly)
			[4]: var51_upvr (readonly)
		]]
		var64_upvw = Assets_upvr.Cutscenes.Assets.Flaska:Clone()
		var64_upvw.Front.Attachment.ParticleEmitter.Enabled = false
		var64_upvw.Parent = clone_upvr
		var64_upvw.PrimaryPart.CFrame = var51_upvr.RightHand.CFrame * CFrame.new(-0.25, -0.2, 0) * CFrame.Angles(0, (-math.pi/2), (math.pi/2))
		local WeldConstraint_2 = Instance.new("WeldConstraint", var64_upvw.PrimaryPart)
		WeldConstraint_2.Part0 = var64_upvw.PrimaryPart
		WeldConstraint_2.Part1 = var51_upvr.RightHand
	end)
	any_LoadAnimation_result1:GetMarkerReachedSignal("taBortFlaska"):Connect(function() -- Line 171
		--[[ Upvalues[1]:
			[1]: var64_upvw (read and write)
		]]
		print("TA BORT FLASKFAN")
		var64_upvw:Destroy()
	end)
	any_LoadAnimation_result1:GetMarkerReachedSignal("h\xE4ll"):Connect(function() -- Line 176
		--[[ Upvalues[1]:
			[1]: var64_upvw (read and write)
		]]
		var64_upvw.Front.Attachment.ParticleEmitter.Enabled = true
	end)
	any_LoadAnimation_result1:GetMarkerReachedSignal("h\xE4llInte"):Connect(function() -- Line 179
		--[[ Upvalues[1]:
			[1]: var64_upvw (read and write)
		]]
		var64_upvw.Front.Attachment.ParticleEmitter.Enabled = false
	end)
	local var70_upvw
	any_LoadAnimation_result1:GetMarkerReachedSignal("skapaSked"):Connect(function() -- Line 184
		--[[ Upvalues[4]:
			[1]: var70_upvw (read and write)
			[2]: Assets_upvr (copied, readonly)
			[3]: clone_upvr (readonly)
			[4]: var51_upvr (readonly)
		]]
		var70_upvw = Assets_upvr.Cutscenes.Assets.Sked:Clone()
		var70_upvw.Parent = clone_upvr
		var70_upvw.CFrame = var51_upvr.RightHand.CFrame * CFrame.new(-0.25, -0.2, 0) * CFrame.Angles(0, (-math.pi/2), (math.pi/2))
		local WeldConstraint = Instance.new("WeldConstraint", var70_upvw)
		WeldConstraint.Part0 = var70_upvw
		WeldConstraint.Part1 = var51_upvr.RightHand
	end)
	any_LoadAnimation_result1:GetMarkerReachedSignal("taBortSked"):Connect(function() -- Line 193
		--[[ Upvalues[1]:
			[1]: var70_upvw (read and write)
		]]
		var70_upvw:Destroy()
	end)
	task.wait(3)
	tweenCamera_upvr(clone_upvr.Cameras, 3, 8, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
	task.wait(8)
	tweenCamera_upvr(clone_upvr.Cameras, 4, 4, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
	tweenFOV_upvr(60, 4, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
	task.wait(2)
	clone_upvr.Assets.Smoke.Flames.Enabled = true
	clone_upvr.Assets.Smoke.BA1.B1.Enabled = true
	task.wait(2)
	local any_new_result1 = Shake_upvr.new()
	any_new_result1.FadeInTime = 3
	any_new_result1.FadeOutTime = 0.5
	any_new_result1.Frequency = 0.07
	any_new_result1.Amplitude = 0.15
	any_new_result1.RotationInfluence = Vector3.new(0, 0, 0)
	any_new_result1.SustainTime = 7
	any_new_result1:Start()
	any_new_result1:BindToRenderStep(any_new_result1.NextRenderName(), Enum.RenderPriority.Last.Value, function(arg1_2, arg2, arg3) -- Line 222
		--[[ Upvalues[1]:
			[1]: CurrentCamera_upvr (copied, readonly)
		]]
		local var76 = CurrentCamera_upvr
		var76.CFrame *= CFrame.new(arg1_2) * CFrame.Angles(arg2.X, arg2.Y, arg2.Z)
	end)
	local tbl = {
		volume = 0;
	}
	local any_getData_result1_5 = var4_upvw:getData()
	if not Util_upvr.settingUtils.getSetting(any_getData_result1_5, "muteSounds") then
		-- KONSTANTWARNING: GOTO [531] #391
	end
	-- KONSTANTERROR: [0] 1. Error Block 89 end (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [514] 377. Error Block 90 start (CF ANALYSIS FAILED)
	local any_getSettingValue_result1_3 = Util_upvr.settingUtils.getSettingValue(any_getData_result1_5, "extraHatchingSounds")
	if not any_getSettingValue_result1_3 then
	elseif 8 < any_getSettingValue_result1_3 then
	else
	end
	tbl.overrideMute = true
	local any_play_result1 = var27_upvw:play("Secret Pet Grow", tbl)
	if any_play_result1 then
		TweenService_upvr:Create(any_play_result1, TweenInfo.new(1, Enum.EasingStyle.Linear), {
			Volume = 0.75;
		}):Play()
	end
	task.wait(3)
	local any_getPetInstance_result1 = var29_upvw:getPetInstance(arg1.item)
	for _, v in any_getPetInstance_result1:GetChildren() do
		if v:IsA("BasePart") then
			v.Anchored = true
		end
	end
	any_getPetInstance_result1:ScaleTo(0.01)
	any_getPetInstance_result1:PivotTo(clone_upvr.Positions.PetStart.CFrame)
	Functions_upvr.tweens.scale(any_getPetInstance_result1, {
		time = 5;
		initialValue = 0.01;
		finalValue = any_getPetInstance_result1:GetScale() * 0.5;
	})
	Functions_upvr.tweens.cframe(any_getPetInstance_result1, {
		time = 5;
		initialCFrame = any_getPetInstance_result1:GetPivot();
		finalCFrame = clone_upvr.Positions.PetEnd.CFrame * CFrame.new(0, any_getPetInstance_result1.PrimaryPart.Size.Y / 2 * 0.5, 0);
	})
	task.wait(3)
	clone_upvr.Assets.Smoke.Flames.Enabled = false
	clone_upvr.Assets.Smoke.BA1.B1.Enabled = false
	task.wait(1)
	local any_getData_result1_2 = var4_upvw:getData()
	if not Util_upvr.settingUtils.getSetting(any_getData_result1_2, "muteSounds") then
	else
		local any_getSettingValue_result1_2 = Util_upvr.settingUtils.getSettingValue(any_getData_result1_2, "extraHatchingSounds")
		if not any_getSettingValue_result1_2 then
		elseif 8 < any_getSettingValue_result1_2 then
		else
		end
	end
	if true then
		TweenService_upvr:Create(var27_upvw:play(var50, tbl_4), TweenInfo.new(3, Enum.EasingStyle.Linear), {
			Volume = 0;
		}):Play()
		TweenService_upvr:Create(any_play_result1, TweenInfo.new(3, Enum.EasingStyle.Linear), {
			Volume = 0;
		}):Play()
		TweenService_upvr:Create(var27_upvw:play("Cauldron Bubble", tbl_2), TweenInfo.new(3, Enum.EasingStyle.Linear), {
			Volume = 0;
		}):Play()
	end
	TweenService_upvr:Create(var44, TweenInfo_new_result1_upvr, {
		BackgroundTransparency = 0;
	}):Play()
	task.wait(4)
	CurrentCamera_upvr.FieldOfView = var50.FieldOfView
	TweenService_upvr:Create(var44, TweenInfo_new_result1_upvr, {
		BackgroundTransparency = 1;
	}):Play()
	MainUI_upvr.Enabled = true
	CurrentCamera_upvr.CameraType = Enum.CameraType.Custom
	task.wait(2)
	var44:Destroy()
	any_getPetInstance_result1:Destroy()
	var51_upvr:Destroy()
	clone_upvr:Destroy()
	-- KONSTANTERROR: [514] 377. Error Block 90 end (CF ANALYSIS FAILED)
end