-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:20:09
-- Luau version 6, Types version 3
-- Time taken: 0.011417 seconds

local Knit_upvr = require(game:GetService("ReplicatedStorage").Packages.Knit)
local any_CreateController_result1 = Knit_upvr.CreateController({
	Name = "AuraController";
	_exist = {};
	_debounce = {};
})
local var4_upvw
local var5_upvw
local var6_upvw
local var7_upvw
local var8_upvw
local var9_upvw
local var10_upvw
local var11_upvw
local var12_upvw
local Players_upvr = game:GetService("Players")
local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local TweenService_upvr = game:GetService("TweenService")
local Debris_upvr = game:GetService("Debris")
local var17_upvw
local var18_upvw
local var19_upvw
local var20_upvw
local var21_upvw
local LocalPlayer_upvr = Players_upvr.LocalPlayer
local PlayerGui = LocalPlayer_upvr:WaitForChild("PlayerGui")
local MainUI_upvr = PlayerGui:WaitForChild("MainUI")
local StopAutoRoll_upvr = MainUI_upvr:WaitForChild("HUD"):WaitForChild("Bars"):WaitForChild("Actions"):WaitForChild("StopAutoRoll")
local CurrentCamera_upvr = workspace.CurrentCamera
local Aura_upvr = workspace.Game.Cutscenes.Aura
local Assets_upvr = ReplicatedStorage_upvr.Assets
function any_CreateController_result1.setIsAutoRolling(arg1, arg2) -- Line 67
	arg1._isAutoRolling = arg2
end
function any_CreateController_result1.getIsAutoRolling(arg1) -- Line 70
	return arg1._isAutoRolling
end
function any_CreateController_result1.setIsRolling(arg1, arg2) -- Line 74
	arg1._isRolling = arg2
end
function any_CreateController_result1.getIsRolling(arg1) -- Line 77
	return arg1._isRolling
end
function any_CreateController_result1.equipAura(arg1, arg2, arg3) -- Line 81
	--[[ Upvalues[3]:
		[1]: var4_upvw (read and write)
		[2]: var18_upvw (read and write)
		[3]: Assets_upvr (readonly)
	]]
	local any_getHRP_result1_2 = var18_upvw.getHRP(arg2)
	if not any_getHRP_result1_2 then
	else
		arg1:removeAura(arg2)
		local var38 = Assets_upvr.Auras[var18_upvw.toPascal(arg3)]
		if var38:FindFirstChildWhichIsA("BasePart") then
			local clone_4 = var38:FindFirstChildWhichIsA("BasePart"):Clone()
			clone_4.Anchored = false
			clone_4.CanCollide = false
			clone_4.CFrame = any_getHRP_result1_2.CFrame * CFrame.Angles(0, (-math.pi/2), 0)
			clone_4.Parent = any_getHRP_result1_2
			local WeldConstraint_2 = Instance.new("WeldConstraint", any_getHRP_result1_2)
			WeldConstraint_2.Part0 = clone_4
			WeldConstraint_2.Part1 = any_getHRP_result1_2
			WeldConstraint_2:SetAttribute("isAura", true)
			clone_4:SetAttribute("isAura", true)
			for i_4, v_4 in clone_4:GetDescendants() do
				if v_4:IsA("ParticleEmitter") or v_4:IsA("Beam") then
					v_4:SetAttribute("isAura", true)
				end
			end
		else
			for _, child in var38:GetChildren() do
				local cloned = child:Clone()
				cloned:SetAttribute("isAura", true)
				cloned.Parent = any_getHRP_result1_2
			end
		end
		if var4_upvw:getData().settings.hideAuras then
			arg1:toggleAllAuras(false)
		end
	end
end
function any_CreateController_result1.removeAura(arg1, arg2) -- Line 125
	--[[ Upvalues[1]:
		[1]: var18_upvw (read and write)
	]]
	local any_getHRP_result1_3 = var18_upvw.getHRP(arg2)
	if not any_getHRP_result1_3 then
	else
		for _, v_6 in any_getHRP_result1_3:GetDescendants() do
			if v_6:GetAttribute("isAura") then
				v_6:Destroy()
			end
		end
	end
end
function any_CreateController_result1.toggleAllAuras(arg1, arg2) -- Line 140
	--[[ Upvalues[2]:
		[1]: Players_upvr (readonly)
		[2]: var18_upvw (read and write)
	]]
	for _, v in Players_upvr:GetPlayers() do
		local any_getHRP_result1 = var18_upvw.getHRP(v)
		if any_getHRP_result1 then
			for _, v_2 in any_getHRP_result1:GetDescendants() do
				if v_2:GetAttribute("isAura") and (v_2:IsA("ParticleEmitter") or v_2:IsA("Beam")) then
					v_2.Enabled = arg2
				end
			end
		end
	end
end
function any_CreateController_result1.showAuraInfo(arg1, arg2, arg3, arg4) -- Line 157
	--[[ Upvalues[8]:
		[1]: var4_upvw (read and write)
		[2]: var20_upvw (read and write)
		[3]: LocalPlayer_upvr (readonly)
		[4]: Assets_upvr (readonly)
		[5]: var17_upvw (read and write)
		[6]: TweenService_upvr (readonly)
		[7]: var18_upvw (read and write)
		[8]: MainUI_upvr (readonly)
	]]
	local any_auraRollSpeed_result1_upvr = var20_upvw.auraRollSpeed(LocalPlayer_upvr, var4_upvw:getData())
	local var66 = arg3 / any_auraRollSpeed_result1_upvr
	local clone_upvr = Assets_upvr.UI.AuraInfo:Clone()
	local Icon = clone_upvr.Icon
	clone_upvr.Aura.Text = arg2.name
	Icon.Image = arg2.icon
	local Scale_2 = Icon.Size.X.Scale
	local Scale = Icon.Size.Y.Scale
	local scaleBigX
	if not arg4 then
		scaleBigX = Scale_2 * 1.1
		Icon.Size = UDim2.fromScale(scaleBigX, Scale * 1.1)
		TweenService_upvr:Create(Icon, TweenInfo.new(var66), {
			Size = UDim2.fromScale(Scale_2, Scale);
		}):Play()
	end
	local rarityGradient = var17_upvw.itemUtils.getRarityData(var17_upvw.itemUtils.getRarityId(arg2.rarity)).gradient
	local Chance = clone_upvr.Chance
	Chance.TextColor3 = var18_upvw.evalColorSequence(rarityGradient, 0.25)
	Chance.Text = `1 in {var18_upvw.comma(math.floor(var18_upvw.floatingPoint(1 / arg2.chance) * 100))}`
	clone_upvr.Visible = true
	clone_upvr.Parent = MainUI_upvr
	local destroyDelay
	if arg4 then
		destroyDelay = 1.5 / any_auraRollSpeed_result1_upvr
	else
		destroyDelay = 0
	end
	if arg4 then
		TweenService_upvr:Create(clone_upvr, TweenInfo.new(0.25 / any_auraRollSpeed_result1_upvr, Enum.EasingStyle.Back), {
			Size = UDim2.fromScale(0.33125000000000004, 0.74125);
		}):Play()
		task.delay(var66 + 1 / any_auraRollSpeed_result1_upvr, function() -- Line 191
			--[[ Upvalues[3]:
				[1]: TweenService_upvr (copied, readonly)
				[2]: clone_upvr (readonly)
				[3]: any_auraRollSpeed_result1_upvr (readonly)
			]]
			TweenService_upvr:Create(clone_upvr, TweenInfo.new(0.5 / any_auraRollSpeed_result1_upvr, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
				Position = UDim2.fromScale(0.5, 1.35);
			}):Play()
		end)
	end
	task.delay(var66 + destroyDelay, function() -- Line 196
		--[[ Upvalues[1]:
			[1]: clone_upvr (readonly)
		]]
		clone_upvr:Destroy()
	end)
end
local SoundService_upvr = game:GetService("SoundService")
function any_CreateController_result1.auraRollAnimation(arg1, arg2, arg3, arg4, arg5) -- Line 201
	--[[ Upvalues[5]:
		[1]: var4_upvw (read and write)
		[2]: var5_upvw (read and write)
		[3]: SoundService_upvr (readonly)
		[4]: var20_upvw (read and write)
		[5]: LocalPlayer_upvr (readonly)
	]]
	arg1:showAuraInfo(arg2, arg3, arg4)
	var5_upvw:play("Aura Roll", {
		volume = 0.35;
	})
	local var79
	if arg4 then
		var79 = 1.5
	else
		var79 = 0
	end
	if arg4 then
		local formatted = `{arg5} Reveal`
		if SoundService_upvr:FindFirstChild(formatted, true) then
			var5_upvw:play(formatted)
		else
			var5_upvw:play("Aura Normal", {
				volume = 0.6;
			})
		end
	end
	task.wait((arg3 + var79) / var20_upvw.auraRollSpeed(LocalPlayer_upvr, var4_upvw:getData()))
end
function any_CreateController_result1.createCharacter(arg1) -- Line 225
	--[[ Upvalues[2]:
		[1]: Players_upvr (readonly)
		[2]: LocalPlayer_upvr (readonly)
	]]
	local var82_upvw
	local _, _ = pcall(function() -- Line 227
		--[[ Upvalues[3]:
			[1]: var82_upvw (read and write)
			[2]: Players_upvr (copied, readonly)
			[3]: LocalPlayer_upvr (copied, readonly)
		]]
		var82_upvw = Players_upvr:CreateHumanoidModelFromUserId(LocalPlayer_upvr.UserId)
	end)
	if var82_upvw then
		var82_upvw.Name = ""
		var82_upvw.Parent = workspace
	end
	return var82_upvw
end
function any_CreateController_result1.loadAnimation(arg1, arg2) -- Line 239
	--[[ Upvalues[1]:
		[1]: Debris_upvr (readonly)
	]]
	local Animation = Instance.new("Animation")
	Animation.AnimationId = "rbxassetid://73387308507719"
	arg2:WaitForChild("Humanoid"):WaitForChild("Animator"):LoadAnimation(Animation):Play()
	Debris_upvr:AddItem(Animation, 10)
end
function any_CreateController_result1.tweenCharacter(arg1, arg2) -- Line 253
	--[[ Upvalues[2]:
		[1]: Aura_upvr (readonly)
		[2]: TweenService_upvr (readonly)
	]]
	local HumanoidRootPart = arg2:WaitForChild("HumanoidRootPart")
	HumanoidRootPart.Anchored = true
	arg2:PivotTo(Aura_upvr.CharStart.CFrame)
	TweenService_upvr:Create(HumanoidRootPart, TweenInfo.new(5), {
		CFrame = Aura_upvr.CharEnd.CFrame + Vector3.new(0, HumanoidRootPart.Size.Y / 2, 0) + Vector3.new(0, arg2:WaitForChild("Humanoid").HipHeight, 0);
	}):Play()
end
local Overlays_upvr = PlayerGui:WaitForChild("Overlays")
function any_CreateController_result1.createOverlay(arg1) -- Line 268
	--[[ Upvalues[2]:
		[1]: Assets_upvr (readonly)
		[2]: Overlays_upvr (readonly)
	]]
	local clone = Assets_upvr.UI.FX.Flash:Clone()
	clone.Parent = Overlays_upvr
	return clone
end
function any_CreateController_result1.setCamera(arg1) -- Line 275
	--[[ Upvalues[2]:
		[1]: CurrentCamera_upvr (readonly)
		[2]: Aura_upvr (readonly)
	]]
	CurrentCamera_upvr.CameraType = Enum.CameraType.Scriptable
	CurrentCamera_upvr.CFrame = Aura_upvr:WaitForChild("Cam").CFrame
end
local TweenInfo_new_result1_upvr_3 = TweenInfo.new(4, Enum.EasingStyle.Linear)
function any_CreateController_result1.tweenCamera(arg1, arg2) -- Line 280
	--[[ Upvalues[4]:
		[1]: Aura_upvr (readonly)
		[2]: CurrentCamera_upvr (readonly)
		[3]: TweenService_upvr (readonly)
		[4]: TweenInfo_new_result1_upvr_3 (readonly)
	]]
	CurrentCamera_upvr.CFrame = Aura_upvr:WaitForChild(`Loc_{arg2}_1`).CFrame
	TweenService_upvr:Create(CurrentCamera_upvr, TweenInfo_new_result1_upvr_3, {
		CFrame = Aura_upvr:WaitForChild(`Loc_{arg2}_2`).CFrame;
	}):Play()
end
local TweenInfo_new_result1_upvr_4 = TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
local TweenInfo_new_result1_upvr = TweenInfo.new(2, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
local TweenInfo_new_result1_upvr_2 = TweenInfo.new(4, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
function any_CreateController_result1.startAuraCutscene(arg1, arg2) -- Line 288
	--[[ Upvalues[17]:
		[1]: var4_upvw (read and write)
		[2]: var18_upvw (read and write)
		[3]: LocalPlayer_upvr (readonly)
		[4]: MainUI_upvr (readonly)
		[5]: TweenService_upvr (readonly)
		[6]: TweenInfo_new_result1_upvr_4 (readonly)
		[7]: var10_upvw (read and write)
		[8]: var21_upvw (read and write)
		[9]: var8_upvw (read and write)
		[10]: var11_upvw (read and write)
		[11]: var9_upvw (read and write)
		[12]: var5_upvw (read and write)
		[13]: TweenInfo_new_result1_upvr (readonly)
		[14]: CurrentCamera_upvr (readonly)
		[15]: TweenInfo_new_result1_upvr_2 (readonly)
		[16]: Assets_upvr (readonly)
		[17]: Debris_upvr (readonly)
	]]
	local any_getData_result1 = var4_upvw:getData()
	local any_getHRP_result1_4 = var18_upvw.getHRP(LocalPlayer_upvr)
	MainUI_upvr.Enabled = false
	local any_createOverlay_result1 = arg1:createOverlay()
	TweenService_upvr:Create(any_createOverlay_result1, TweenInfo_new_result1_upvr_4, {
		BackgroundTransparency = 0;
	}):Play()
	task.wait(0.5)
	local var100 = false
	if var10_upvw:getCurrentMap() ~= "Atlantis" then
		var18_upvw.print("\xC4r inte i Atlantis, k\xF6r RequestStreamAroundAsync")
		LocalPlayer_upvr:RequestStreamAroundAsync(var21_upvw[5].cframe.Position)
		any_getHRP_result1_4.CFrame = var21_upvw[5].cframe
		var100 = true
	end
	var8_upvw:hideCharacters(true, true)
	var11_upvw:hideMounts(true)
	var9_upvw:togglePets(true, false)
	arg1:setCamera()
	task.wait(2)
	var5_upvw:play("Aura Ambience")
	TweenService_upvr:Create(any_createOverlay_result1, TweenInfo_new_result1_upvr, {
		BackgroundTransparency = 1;
	}):Play()
	TweenService_upvr:Create(CurrentCamera_upvr, TweenInfo_new_result1_upvr_2, {
		FieldOfView = 50;
	}):Play()
	task.spawn(function() -- Line 323
		--[[ Upvalues[5]:
			[1]: arg1 (readonly)
			[2]: Assets_upvr (copied, readonly)
			[3]: var18_upvw (copied, read and write)
			[4]: arg2 (readonly)
			[5]: Debris_upvr (copied, readonly)
		]]
		local any_createCharacter_result1 = arg1:createCharacter()
		if any_createCharacter_result1 then
			local clone_3 = Assets_upvr.Auras[var18_upvw.toPascal(arg2)]:FindFirstChildWhichIsA("Part"):Clone()
			clone_3.Anchored = false
			clone_3.CanCollide = false
			clone_3.CFrame = any_createCharacter_result1.HumanoidRootPart.CFrame * CFrame.Angles(0, (-math.pi/2), 0)
			clone_3.Parent = any_createCharacter_result1.HumanoidRootPart
			local WeldConstraint = Instance.new("WeldConstraint", any_createCharacter_result1.HumanoidRootPart)
			WeldConstraint.Part0 = clone_3
			WeldConstraint.Part1 = any_createCharacter_result1.HumanoidRootPart
			arg1:loadAnimation(any_createCharacter_result1)
			arg1:tweenCharacter(any_createCharacter_result1)
			Debris_upvr:AddItem(any_createCharacter_result1, 16)
		end
	end)
	task.wait(4)
	CurrentCamera_upvr.FieldOfView = 70
	arg1:tweenCamera(1)
	task.wait(4)
	arg1:tweenCamera(2)
	task.wait(4)
	arg1:tweenCamera(3)
	task.wait(2)
	TweenService_upvr:Create(any_createOverlay_result1, TweenInfo_new_result1_upvr, {
		BackgroundTransparency = 0;
	}):Play()
	task.wait(2)
	CurrentCamera_upvr.CameraType = Enum.CameraType.Custom
	var8_upvw:hideCharacters(false, true)
	var11_upvw:hideMounts(false)
	if not any_getData_result1.settings.hideYourPets then
		var9_upvw:togglePets(true, true)
	end
	if not any_getData_result1.settings.hideOtherPets then
		var9_upvw:togglePets(false, true)
	end
	task.wait(2)
	TweenService_upvr:Create(any_createOverlay_result1, TweenInfo_new_result1_upvr, {
		BackgroundTransparency = 1;
	}):Play()
	if var100 then
		any_getHRP_result1_4.CFrame = any_getHRP_result1_4.CFrame
	end
	task.wait(2)
	MainUI_upvr.Enabled = true
	any_createOverlay_result1:Destroy()
end
local RunService_upvr = game:GetService("RunService")
function any_CreateController_result1.specialRollAnimation(arg1, arg2) -- Line 384
	--[[ Upvalues[6]:
		[1]: Assets_upvr (readonly)
		[2]: MainUI_upvr (readonly)
		[3]: TweenService_upvr (readonly)
		[4]: RunService_upvr (readonly)
		[5]: CurrentCamera_upvr (readonly)
		[6]: var5_upvw (read and write)
	]]
	local clone_upvr_2 = Assets_upvr.UI.FX.Flash:Clone()
	clone_upvr_2.Parent = MainUI_upvr
	TweenService_upvr:Create(clone_upvr_2, TweenInfo.new(5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, -1, false, 5), {
		BackgroundTransparency = 0.55;
	}):Play()
	local clone_2_upvr = Assets_upvr.Other.Question:Clone()
	clone_2_upvr.Parent = workspace
	local NumberValue_upvr_2 = Instance.new("NumberValue")
	TweenService_upvr:Create(NumberValue_upvr_2, TweenInfo.new(5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
		Value = 4776;
	}):Play()
	local NumberValue_upvr = Instance.new("NumberValue")
	NumberValue_upvr.Value = 0.05
	TweenService_upvr:Create(NumberValue_upvr, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		Value = 1;
	}):Play()
	task.delay(4.5, function() -- Line 399
		--[[ Upvalues[2]:
			[1]: TweenService_upvr (copied, readonly)
			[2]: NumberValue_upvr (readonly)
		]]
		TweenService_upvr:Create(NumberValue_upvr, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
			Value = 0.01;
		}):Play()
	end)
	RunService_upvr:BindToRenderStep("rngSpecialPosition", Enum.RenderPriority.Camera.Value + 1, function() -- Line 403
		--[[ Upvalues[4]:
			[1]: clone_2_upvr (readonly)
			[2]: NumberValue_upvr (readonly)
			[3]: CurrentCamera_upvr (copied, readonly)
			[4]: NumberValue_upvr_2 (readonly)
		]]
		clone_2_upvr:ScaleTo(NumberValue_upvr.Value)
		clone_2_upvr:PivotTo(CurrentCamera_upvr.CFrame * CFrame.new(0, 0, -5) * CFrame.Angles(0, math.rad(NumberValue_upvr_2.Value), 0))
	end)
	task.delay(0.915, function() -- Line 408
		--[[ Upvalues[1]:
			[1]: var5_upvw (copied, read and write)
		]]
		var5_upvw:play("Aura Riser", {
			volume = 1;
		})
	end)
	task.delay(5, function() -- Line 414
		--[[ Upvalues[5]:
			[1]: RunService_upvr (copied, readonly)
			[2]: clone_2_upvr (readonly)
			[3]: clone_upvr_2 (readonly)
			[4]: NumberValue_upvr_2 (readonly)
			[5]: NumberValue_upvr (readonly)
		]]
		RunService_upvr:UnbindFromRenderStep("rngSpecialPosition")
		clone_2_upvr:Destroy()
		clone_upvr_2:Destroy()
		NumberValue_upvr_2:Destroy()
		NumberValue_upvr:Destroy()
	end)
	TweenService_upvr:Create(CurrentCamera_upvr, TweenInfo.new(5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
		FieldOfView = 120;
	}):Play()
	task.wait(5)
	TweenService_upvr:Create(CurrentCamera_upvr, TweenInfo.new(0.05), {
		FieldOfView = 70;
	}):Play()
end
function any_CreateController_result1.rollAnimations(arg1, arg2) -- Line 429
	--[[ Upvalues[4]:
		[1]: var6_upvw (read and write)
		[2]: StopAutoRoll_upvr (readonly)
		[3]: var19_upvw (read and write)
		[4]: var5_upvw (read and write)
	]]
	var6_upvw:closeAllFrames()
	var6_upvw:hideHUD(true)
	StopAutoRoll_upvr.Visible = arg1:getIsAutoRolling()
	for i_3, v_3 in arg2 do
		local var130 = var19_upvw
		local var131 = var130[v_3]
		local var132
		if i_3 ~= var132 then
			var130 = false
		else
			var130 = true
		end
		var132 = var131.rarity
		local function INLINED_2() -- Internal function, doesn't exist in bytecode
			var132 = var131.rarity
			return var132 == "Supreme"
		end
		local function INLINED_3() -- Internal function, doesn't exist in bytecode
			var132 = var131.rarity
			return var132 == "Ultimate"
		end
		if var132 == "Secret" or INLINED_2() or INLINED_3() or var130 then
			var132 = var5_upvw.toggleMusic
			var132(var5_upvw, false)
			var132 = arg1.specialRollAnimation
			var132(arg1, var131)
			var132 = arg1.startAuraCutscene
			var132(arg1, v_3)
			var132 = var5_upvw.toggleMusic
			var132(var5_upvw, true)
		end
		var132 = arg1.auraRollAnimation
		var132(arg1, var131, 0.05, var130, var131.rarity)
		if #var131 - 2 <= i_3 then
			var132 = 1.25
		else
			var132 = 1.135
		end
	end
end
function any_CreateController_result1.roll(arg1, arg2) -- Line 458
	--[[ Upvalues[6]:
		[1]: var4_upvw (read and write)
		[2]: var17_upvw (read and write)
		[3]: var7_upvw (read and write)
		[4]: var12_upvw (read and write)
		[5]: StopAutoRoll_upvr (readonly)
		[6]: var6_upvw (read and write)
	]]
	local any_getItemFromName_result1, _ = var17_upvw.itemUtils.getItemFromName(var4_upvw.data, arg2)
	if not any_getItemFromName_result1 then
	else
		arg1:setIsRolling(true)
		var7_upvw:setCanOverrideDisplay(false)
		repeat
			local any_roll_result1, any_roll_result2 = var12_upvw:roll(arg2)
			if any_roll_result1 == "success" then
				arg1:rollAnimations(any_roll_result2)
			elseif any_roll_result1 == "notEnoughDice" then
				break
			end
			arg1:setIsRolling(false)
			var7_upvw:setCanOverrideDisplay(true)
		until not arg1:getIsAutoRolling()
		StopAutoRoll_upvr.Visible = false
		var6_upvw:openFrame("AurasMachineFrame")
		var6_upvw:hideHUD(false)
		var7_upvw:setCanOverrideDisplay(true)
		arg1:setIsAutoRolling(false)
		arg1:setIsRolling(false)
	end
end
function any_CreateController_result1.getExist(arg1, arg2) -- Line 491
	--[[ Upvalues[3]:
		[1]: var4_upvw (read and write)
		[2]: var17_upvw (read and write)
		[3]: var12_upvw (read and write)
	]]
	if not var17_upvw.auraUtils.getItemFromDescriptor(arg2) then return end
	if not arg1._exist[arg2] then
		if arg1._debounce[arg2] then
		else
			arg1._debounce[arg2] = true
			task.delay(1, function() -- Line 502
				--[[ Upvalues[2]:
					[1]: arg1 (readonly)
					[2]: arg2 (readonly)
				]]
				arg1._debounce[arg2] = nil
			end)
			var12_upvw.getExist:Fire(arg2)
		end
	end
	if 30 < os.time() - arg1._exist[arg2].updated then
		var12_upvw.getExist:Fire(arg2)
	end
	return arg1._exist[arg2].exist
end
function any_CreateController_result1.existUpdated(arg1, arg2, arg3) -- Line 517
	arg1._exist[arg2] = arg3
end
function any_CreateController_result1.KnitStart(arg1) -- Line 521
	--[[ Upvalues[2]:
		[1]: var4_upvw (read and write)
		[2]: var12_upvw (read and write)
	]]
	task.spawn(function() -- Line 522
		--[[ Upvalues[1]:
			[1]: var4_upvw (copied, read and write)
		]]
		repeat
			task.wait()
		until var4_upvw.data
	end)
	var12_upvw.equipAura:Connect(function(...) -- Line 527
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:equipAura(...)
	end)
	var12_upvw.removeAura:Connect(function(...) -- Line 530
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:removeAura(...)
	end)
	var12_upvw.existUpdated:Connect(function(...) -- Line 534
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:existUpdated(...)
	end)
end
local var142_upvw
function any_CreateController_result1.KnitInit(arg1) -- Line 539
	--[[ Upvalues[17]:
		[1]: var12_upvw (read and write)
		[2]: Knit_upvr (readonly)
		[3]: var4_upvw (read and write)
		[4]: var5_upvw (read and write)
		[5]: var6_upvw (read and write)
		[6]: var7_upvw (read and write)
		[7]: var8_upvw (read and write)
		[8]: var9_upvw (read and write)
		[9]: var10_upvw (read and write)
		[10]: var11_upvw (read and write)
		[11]: var17_upvw (read and write)
		[12]: ReplicatedStorage_upvr (readonly)
		[13]: var18_upvw (read and write)
		[14]: var19_upvw (read and write)
		[15]: var142_upvw (read and write)
		[16]: var20_upvw (read and write)
		[17]: var21_upvw (read and write)
	]]
	var12_upvw = Knit_upvr.GetService("AuraService")
	var4_upvw = Knit_upvr.GetController("DataController")
	var5_upvw = Knit_upvr.GetController("SoundController")
	var6_upvw = Knit_upvr.GetController("UIController")
	var7_upvw = Knit_upvr.GetController("ItemController")
	var8_upvw = Knit_upvr.GetController("PlayerController")
	var9_upvw = Knit_upvr.GetController("PetController")
	var10_upvw = Knit_upvr.GetController("MapController")
	var11_upvw = Knit_upvr.GetController("MountController")
	var17_upvw = require(ReplicatedStorage_upvr.Shared.Util)
	var18_upvw = require(ReplicatedStorage_upvr.Shared.Functions)
	var19_upvw = require(ReplicatedStorage_upvr.Shared.List.Items.Auras)
	var142_upvw = require(ReplicatedStorage_upvr.Shared.List.Items.Rarities)
	var20_upvw = require(ReplicatedStorage_upvr.Shared.Values)
	var21_upvw = require(ReplicatedStorage_upvr.Shared.List.Maps)
end
return any_CreateController_result1