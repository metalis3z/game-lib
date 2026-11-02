-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:19:46
-- Luau version 6, Types version 3
-- Time taken: 0.013493 seconds

local Knit_upvr = require(game:GetService("ReplicatedStorage").Packages.Knit)
local any_CreateController_result1 = Knit_upvr.CreateController({
	Name = "HatchingController";
	_hasRenderStep = false;
	_isHatching = false;
	_pets = {};
})
local var4_upvw
local var5_upvw
local var6_upvw
local var7_upvw
local var8_upvw
local var9_upvw
local var10_upvw
local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local TweenService_upvr = game:GetService("TweenService")
local RunService_upvr = game:GetService("RunService")
local var14_upvw
local var15_upvw
local var16_upvw
local var17_upvw
local LocalPlayer_upvr = game:GetService("Players").LocalPlayer
local CurrentCamera_upvr = workspace.CurrentCamera
local Assets_upvr = ReplicatedStorage_upvr.Assets
function any_CreateController_result1.isHatching(arg1) -- Line 50
	return arg1._isHatching
end
local SoundService_upvr = game:GetService("SoundService")
function any_CreateController_result1.getRevealSound(arg1, arg2) -- Line 54
	--[[ Upvalues[3]:
		[1]: var4_upvw (read and write)
		[2]: var15_upvw (read and write)
		[3]: SoundService_upvr (readonly)
	]]
	local any_getData_result1 = var4_upvw:getData()
	local any_getRarityId_result1 = var15_upvw.petUtils.getRarityId(arg2:getRarity())
	local formatted = `{var15_upvw.petUtils.getRarityData(any_getRarityId_result1).name} Reveal`
	if not SoundService_upvr:FindFirstChild(formatted, true) then return end
	local any_getSettingValue_result1 = var15_upvw.settingUtils.getSettingValue(any_getData_result1, "extraHatchingSounds")
	if not any_getSettingValue_result1 and not any_getData_result1.settings.muteSounds then
		return formatted
	end
	if not any_getSettingValue_result1 then return end
	if any_getRarityId_result1 < any_getSettingValue_result1 and any_getData_result1.settings.muteSounds then return end
	return formatted
end
function any_CreateController_result1.getPositions(arg1, arg2) -- Line 84
	local module_4 = {}
	local var31
	if 9 <= arg2 then
		var31 = 5
	elseif arg2 % 3 == 0 or arg2 % 5 == 0 then
		var31 = 3
	else
		var31 = 4
	end
	for i = 1, arg2 do
		local floored = math.floor((i - 1) / var31)
		table.insert(module_4, Vector3.new(-(math.min(var31, arg2 - floored * var31) - 1) * 3.5 / 2 + (i - 1) % var31 * 3.5, -(math.ceil(arg2 / var31) - 1) * 4 / 2 + floored * 4, -6))
		local _
	end
	do
		return module_4
	end
end
function any_CreateController_result1.cleanData(arg1, arg2) -- Line 115
	for _, v in arg2 do
		if typeof(v) == "Instance" then
			v:Destroy()
		end
	end
end
function any_CreateController_result1.getEggData(arg1, arg2, arg3) -- Line 124
	local NumberValue_2 = Instance.new("NumberValue")
	NumberValue_2.Value = 8
	local NumberValue = Instance.new("NumberValue")
	NumberValue.Value = 0.25
	local module_5 = {}
	module_5.eggName = arg2
	module_5.positions = arg1:getPositions(arg3)
	module_5.amount = arg3
	module_5.eggs = arg1:createEggs(arg2, arg3)
	module_5.scale = NumberValue
	module_5.y = NumberValue_2
	module_5.rotation = Instance.new("NumberValue")
	return module_5
end
function any_CreateController_result1.createEggs(arg1, arg2, arg3) -- Line 148
	--[[ Upvalues[1]:
		[1]: Assets_upvr (readonly)
	]]
	local module_3 = {}
	for _ = 1, arg3 do
		local clone_3 = Assets_upvr.Eggs:FindFirstChild(arg2):Clone()
		clone_3.Parent = workspace.Debris
		clone_3:ScaleTo(clone_3:GetScale() * 0.66)
		module_3[#module_3 + 1] = {
			instance = clone_3;
			scale = clone_3:GetScale();
		}
	end
	return module_3
end
function any_CreateController_result1.bindEggsPosition(arg1, arg2) -- Line 166
	--[[ Upvalues[2]:
		[1]: RunService_upvr (readonly)
		[2]: CurrentCamera_upvr (readonly)
	]]
	local amount_upvr = arg2.amount
	local eggs_upvr = arg2.eggs
	local positions_upvr = arg2.positions
	local scale_upvr = arg2.scale
	local y_upvr = arg2.y
	local rotation_2_upvr = arg2.rotation
	RunService_upvr:BindToRenderStep("eggPositions", Enum.RenderPriority.Camera.Value + 1, function() -- Line 175
		--[[ Upvalues[7]:
			[1]: amount_upvr (readonly)
			[2]: eggs_upvr (readonly)
			[3]: positions_upvr (readonly)
			[4]: scale_upvr (readonly)
			[5]: CurrentCamera_upvr (copied, readonly)
			[6]: y_upvr (readonly)
			[7]: rotation_2_upvr (readonly)
		]]
		for i_4 = 1, amount_upvr do
			local var52 = eggs_upvr[i_4]
			local instance = var52.instance
			instance:ScaleTo(var52.scale * scale_upvr.Value)
			instance:PivotTo(CurrentCamera_upvr.CFrame * CFrame.new(positions_upvr[i_4].X, positions_upvr[i_4].Y + y_upvr.Value, positions_upvr[i_4].Z) * CFrame.Angles(0, 0, math.rad(rotation_2_upvr.Value)))
		end
	end)
end
function any_CreateController_result1.getAmountOfHatchAnimations(arg1, arg2) -- Line 192
	--[[ Upvalues[1]:
		[1]: var15_upvw (read and write)
	]]
	local var58 = 0
	for _, v_2 in arg2 do
		v_2 = var15_upvw.itemUtils.createItemFromData(v_2)
		if var15_upvw.petUtils.getRarityData(var15_upvw.petUtils.getRarityId(v_2:getRarity())).hatchAnimation then
			var58 += 1
		end
	end
	return var58
end
function any_CreateController_result1.playRevealSounds(arg1, arg2) -- Line 211
	--[[ Upvalues[2]:
		[1]: var4_upvw (read and write)
		[2]: var5_upvw (read and write)
	]]
	local tbl_2 = {}
	for _, _ in arg2 do
		local var64
		if not var64 and not var4_upvw:getData().settings.muteSounds then
			var64 = "Pet Reveal"
		end
		if var64 and not tbl_2[var64] then
			var5_upvw:play(var64, {
				overrideMute = var64;
			})
			tbl_2[var64] = true
		end
	end
end
function any_CreateController_result1.playHatchingAnimation(arg1, arg2, arg3) -- Line 238
	--[[ Upvalues[2]:
		[1]: var17_upvw (read and write)
		[2]: var14_upvw (read and write)
	]]
	local tbl_4 = {}
	tbl_4.item = arg2
	var17_upvw[var14_upvw.toCamel(arg3)](tbl_4)
end
function any_CreateController_result1.eggAnimation(arg1, arg2, arg3, arg4, arg5) -- Line 244
	--[[ Upvalues[10]:
		[1]: var4_upvw (read and write)
		[2]: var16_upvw (read and write)
		[3]: LocalPlayer_upvr (readonly)
		[4]: var6_upvw (read and write)
		[5]: var8_upvw (read and write)
		[6]: var9_upvw (read and write)
		[7]: var7_upvw (read and write)
		[8]: var15_upvw (read and write)
		[9]: var5_upvw (read and write)
		[10]: var17_upvw (read and write)
	]]
	local var83 = arg5
	if not var83 then
		var83 = {}
	end
	local data = var4_upvw.data
	local any_hatchSpeed_result1_6 = var16_upvw.hatchSpeed(LocalPlayer_upvr, data)
	local any_getAmountOfHatchAnimations_result1 = arg1:getAmountOfHatchAnimations(arg3)
	if var83.waitForUIClose then
		while var6_upvw:isFrameOpen() do
			task.wait(0.1)
		end
	end
	var6_upvw:closeAllFrames()
	var6_upvw:hideHUD(true)
	var8_upvw:toggleTopPlayer(false)
	var9_upvw:togglePetInfos(false)
	var7_upvw:setCanOverrideDisplay(false)
	arg1._isHatching = true
	if 0 < arg4 - any_getAmountOfHatchAnimations_result1 then
		local any_getEggData_result1 = arg1:getEggData(arg2, arg4 - any_getAmountOfHatchAnimations_result1)
		arg1:bindEggsPosition(any_getEggData_result1)
		arg1:dropEggs(any_getEggData_result1)
		task.wait(0.75 / any_hatchSpeed_result1_6)
		arg1:shakeEggs(any_getEggData_result1)
		arg1:scaleAndRemoveEggs(any_getEggData_result1)
		task.wait(0.05 / any_hatchSpeed_result1_6)
		arg1:cleanData(any_getEggData_result1)
		local tbl_5 = {}
		for _, v_4 in arg3 do
			local any_createItemFromData_result1_2 = var15_upvw.itemUtils.createItemFromData(v_4)
			if not var15_upvw.petUtils.getRarityData(var15_upvw.petUtils.getRarityId(any_createItemFromData_result1_2:getRarity())).hatchAnimation then
				tbl_5[#tbl_5 + 1] = any_createItemFromData_result1_2
			end
		end
		arg1:playRevealSounds(tbl_5)
		for _, v_5 in tbl_5 do
			arg1:addPet(v_5)
		end
		task.wait(2 / any_hatchSpeed_result1_6)
	end
	if 0 < any_getAmountOfHatchAnimations_result1 then
		var5_upvw:toggleMusic(false)
		var5_upvw:preloadSounds({"Aura Riser"})
		local any_getEggData_result1_2 = arg1:getEggData(arg2, any_getAmountOfHatchAnimations_result1)
		arg1:bindEggsPosition(any_getEggData_result1_2)
		arg1:dropEggs(any_getEggData_result1_2)
		task.wait(0.75 / any_hatchSpeed_result1_6)
		local tbl = {}
		for _, v_6 in arg3 do
			local any_createItemFromData_result1 = var15_upvw.itemUtils.createItemFromData(v_6)
			if var15_upvw.petUtils.getRarityData(var15_upvw.petUtils.getRarityId(any_createItemFromData_result1:getRarity())).hatchAnimation then
				tbl[#tbl + 1] = any_createItemFromData_result1
			end
		end
		if tbl[1]:getRarity() == "Mythical" then
			var17_upvw.mythical({
				eggData = any_getEggData_result1_2;
				hatchSpeed = any_hatchSpeed_result1_6;
			})
		else
			var17_upvw.question({
				eggData = any_getEggData_result1_2;
			})
			if tbl[1]:getRarity() == "Eternal" then
				var17_upvw.eternal({
					eggData = any_getEggData_result1_2;
					item = tbl[1];
				})
			elseif tbl[1]:getRarity() == "Secret" then
				var17_upvw.secret({
					eggData = any_getEggData_result1_2;
					item = tbl[1];
				})
			end
		end
		arg1:cleanData(any_getEggData_result1_2)
		arg1:scaleAndRemoveEggs(any_getEggData_result1_2)
		arg1:playRevealSounds(tbl)
		for _, v_7 in tbl do
			arg1:addPet(v_7)
		end
		task.wait(2 / any_hatchSpeed_result1_6)
		var5_upvw:toggleMusic(true)
	end
	var6_upvw:hideHUD(false)
	var7_upvw:setCanOverrideDisplay(true)
	local var98 = true
	var8_upvw:toggleTopPlayer(var98)
	if not data.settings.hidePetsInfo then
		var98 = true
	else
		var98 = false
	end
	var9_upvw:togglePetInfos(var98)
	arg1._isHatching = false
end
function any_CreateController_result1.dropEggs(arg1, arg2) -- Line 367
	--[[ Upvalues[5]:
		[1]: var4_upvw (read and write)
		[2]: var16_upvw (read and write)
		[3]: LocalPlayer_upvr (readonly)
		[4]: TweenService_upvr (readonly)
		[5]: var5_upvw (read and write)
	]]
	local any_hatchSpeed_result1_4 = var16_upvw.hatchSpeed(LocalPlayer_upvr, var4_upvw.data)
	TweenService_upvr:Create(arg2.y, TweenInfo.new(0.75 / any_hatchSpeed_result1_4, Enum.EasingStyle.Bounce), {
		Value = 0;
	}):Play()
	TweenService_upvr:Create(arg2.scale, TweenInfo.new(0.75 / any_hatchSpeed_result1_4, Enum.EasingStyle.Quad), {
		Value = 1;
	}):Play()
	task.delay(0.1, function() -- Line 377
		--[[ Upvalues[1]:
			[1]: var5_upvw (copied, read and write)
		]]
		var5_upvw:play("Woosh")
	end)
end
function any_CreateController_result1.shakeEggs(arg1, arg2) -- Line 382
	--[[ Upvalues[5]:
		[1]: var4_upvw (read and write)
		[2]: var16_upvw (read and write)
		[3]: LocalPlayer_upvr (readonly)
		[4]: TweenService_upvr (readonly)
		[5]: var5_upvw (read and write)
	]]
	local any_hatchSpeed_result1_5 = var16_upvw.hatchSpeed(LocalPlayer_upvr, var4_upvw.data)
	local scale = arg2.scale
	local rotation = arg2.rotation
	for i_11 = 1, 5 do
		local var108
		if i_11 % 2 == 1 then
			var108 = -35
		else
			var108 = 35
		end
		TweenService_upvr:Create(scale, TweenInfo.new(0.02 / any_hatchSpeed_result1_5, Enum.EasingStyle.Quad), {
			Value = 0.7;
		}):Play()
		TweenService_upvr:Create(rotation, TweenInfo.new(0.02 / any_hatchSpeed_result1_5, Enum.EasingStyle.Quad), {
			Value = var108;
		}):Play()
		task.wait(0.05 / any_hatchSpeed_result1_5)
		TweenService_upvr:Create(scale, TweenInfo.new(0.15 / any_hatchSpeed_result1_5, Enum.EasingStyle.Quad), {
			Value = 1;
		}):Play()
		TweenService_upvr:Create(rotation, TweenInfo.new(0.15 / any_hatchSpeed_result1_5, Enum.EasingStyle.Quad), {
			Value = 0;
		}):Play()
		var5_upvw:play("Pop", {
			playbackSpeed = 1 * 1.2 ^ i_11;
		})
		task.wait(0.15 / any_hatchSpeed_result1_5)
	end
end
function any_CreateController_result1.scaleAndRemoveEggs(arg1, arg2) -- Line 408
	--[[ Upvalues[5]:
		[1]: var4_upvw (read and write)
		[2]: var16_upvw (read and write)
		[3]: LocalPlayer_upvr (readonly)
		[4]: TweenService_upvr (readonly)
		[5]: RunService_upvr (readonly)
	]]
	local any_hatchSpeed_result1_3 = var16_upvw.hatchSpeed(LocalPlayer_upvr, var4_upvw.data)
	local scale_2 = arg2.scale
	local eggs_upvr_2 = arg2.eggs
	TweenService_upvr:Create(scale_2, TweenInfo.new(0.25 / any_hatchSpeed_result1_3, Enum.EasingStyle.Quad), {
		Value = 0.2;
	}):Play()
	task.wait(0.25 / any_hatchSpeed_result1_3)
	TweenService_upvr:Create(scale_2, TweenInfo.new(0.15 / any_hatchSpeed_result1_3, Enum.EasingStyle.Quad), {
		Value = 3;
	}):Play()
	for _, v_8 in eggs_upvr_2 do
		for _, v_9 in v_8.instance:GetDescendants() do
			if v_9:IsA("Texture") then
				v_9:Destroy()
			end
			if v_9:IsA("BasePart") then
				v_9.Color = Color3.fromRGB(255, 255, 255)
				TweenService_upvr:Create(v_9, TweenInfo.new(0.15 / any_hatchSpeed_result1_3), {
					Transparency = 1;
				}):Play()
			end
		end
	end
	task.delay(0.25 / any_hatchSpeed_result1_3, function() -- Line 432
		--[[ Upvalues[2]:
			[1]: eggs_upvr_2 (readonly)
			[2]: RunService_upvr (copied, readonly)
		]]
		for _, v_10 in eggs_upvr_2 do
			v_10.instance:Destroy()
		end
		RunService_upvr:UnbindFromRenderStep("eggPositions")
	end)
end
function any_CreateController_result1.getSortedPets(arg1) -- Line 442
	local module_2 = {}
	for _, v_11 in arg1._pets do
		module_2[#module_2 + 1] = {
			petData = v_11;
		}
	end
	table.sort(module_2, function(arg1_2, arg2) -- Line 451
		local var137
		if arg1_2.petData.createdAt >= arg2.petData.createdAt then
			var137 = false
		else
			var137 = true
		end
		return var137
	end)
	return module_2
end
function any_CreateController_result1.bindPetPositions(arg1) -- Line 458
	--[[ Upvalues[3]:
		[1]: RunService_upvr (readonly)
		[2]: var14_upvw (read and write)
		[3]: CurrentCamera_upvr (readonly)
	]]
	arg1._hasRenderStep = true
	local tbl_3_upvr = {}
	RunService_upvr:BindToRenderStep("petPositions", Enum.RenderPriority.Camera.Value + 100, function() -- Line 463
		--[[ Upvalues[5]:
			[1]: var14_upvw (copied, read and write)
			[2]: arg1 (readonly)
			[3]: RunService_upvr (copied, readonly)
			[4]: tbl_3_upvr (readonly)
			[5]: CurrentCamera_upvr (copied, readonly)
		]]
		local any_getAmountInTable_result1 = var14_upvw.getAmountInTable(arg1._pets)
		if any_getAmountInTable_result1 == 0 then
			RunService_upvr:UnbindFromRenderStep("petPositions")
			arg1._hasRenderStep = false
		else
			local any_getPositions_result1 = arg1:getPositions(any_getAmountInTable_result1)
			for i_16, v_12 in ipairs(arg1:getSortedPets()) do
				local petData = v_12.petData
				local instance_2 = petData.instance
				if instance_2 then
					local ui_2 = petData.ui
					local X = any_getPositions_result1[i_16].X
					local Y = any_getPositions_result1[i_16].Y
					local Z = any_getPositions_result1[i_16].Z
					if not tbl_3_upvr[instance_2] then
						tbl_3_upvr[instance_2] = CFrame.new(X, Y, Z)
					end
					tbl_3_upvr[instance_2] = tbl_3_upvr[instance_2]:Lerp(CFrame.new(X, Y, Z), 0.075)
					instance_2:ScaleTo(petData.scale.Value)
					instance_2:PivotTo(CurrentCamera_upvr.CFrame * CFrame.new(X * petData.x.Value, petData.y.Value, petData.z.Value) * tbl_3_upvr[instance_2] * CFrame.Angles(math.rad(Y), math.rad(180 - X * 6.5), 0))
					local any_WorldToViewportPoint_result1, _ = CurrentCamera_upvr:WorldToViewportPoint((instance_2.PrimaryPart.CFrame * CFrame.new(0, -instance_2.PrimaryPart.Size.Y / 2, -instance_2.PrimaryPart.Size.Z / 2)).Position)
					local udim2 = UDim2.fromScale(var14_upvw.floatingPoint(any_WorldToViewportPoint_result1.X / CurrentCamera_upvr.ViewportSize.X + 0.00001, 3), var14_upvw.floatingPoint(any_WorldToViewportPoint_result1.Y / CurrentCamera_upvr.ViewportSize.Y + 0.00001, 3))
					if not ui_2:GetAttribute("pos") then
						ui_2:SetAttribute("pos", true)
						ui_2.Position = udim2
					end
					ui_2:TweenPosition(udim2, Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.025, true)
				end
			end
		end
	end)
end
function any_CreateController_result1.getPetData(arg1, arg2, arg3) -- Line 516
	--[[ Upvalues[1]:
		[1]: var14_upvw (read and write)
	]]
	local module = {
		id = var14_upvw.id();
	}
	module.item = arg2
	module.instance = arg3
	module.createdAt = tick()
	module.scale = Instance.new("NumberValue")
	module.x = Instance.new("NumberValue")
	module.y = Instance.new("NumberValue")
	module.z = Instance.new("NumberValue")
	module.originalScale = arg3:GetScale()
	module.ui = arg1:createPetUI(arg2)
	return module
end
local MainUI_upvr = LocalPlayer_upvr:WaitForChild("PlayerGui"):WaitForChild("MainUI")
function any_CreateController_result1.createPetUI(arg1, arg2) -- Line 542
	--[[ Upvalues[4]:
		[1]: var4_upvw (read and write)
		[2]: Assets_upvr (readonly)
		[3]: var15_upvw (read and write)
		[4]: MainUI_upvr (readonly)
	]]
	local clone_2 = Assets_upvr.UI.Hatch:Clone()
	local State = clone_2.State
	local any_getRarityData_result1 = var15_upvw.petUtils.getRarityData(var15_upvw.petUtils.getRarityId(arg2:getRarity()))
	local any_getTierData_result1 = var15_upvw.petUtils.getTierData(arg2:getTier())
	clone_2.Rarity.Text = any_getRarityData_result1.name
	clone_2.Rarity.UIGradient.Color = any_getRarityData_result1.textColor.gradient
	clone_2.Rarity.UIGradient.Rotation = any_getRarityData_result1.textColor.gradientRotation
	clone_2.Rarity.UIStroke.Color = any_getRarityData_result1.textColor.stroke
	clone_2.Rarity.UIStroke.UIGradient.Enabled = any_getRarityData_result1.textColor.strokeGradient
	if any_getRarityData_result1.textColor.strokeGradient then
		clone_2.Rarity.UIStroke.UIGradient.Color = any_getRarityData_result1.textColor.gradient
		clone_2.Rarity.UIStroke.UIGradient.Rotation = any_getRarityData_result1.textColor.gradientRotation
	end
	if 1 < arg2:getTier() then
		State.Craft.UIGradient.Color = any_getTierData_result1.gradient
		State.Craft.UIStroke.Color = any_getTierData_result1.stroke
		if any_getTierData_result1.strokeGradient then
			State.Craft.UIStroke.UIGradient.Color = any_getRarityData_result1.gradient
		end
		State.Craft.Text = any_getTierData_result1.name
		State.Craft.Visible = true
	end
	State.Shiny.Visible = arg2:isShiny()
	clone_2.Archived.Visible = var4_upvw:getData().autoArchive[arg2:getName()]
	clone_2.Pet.Text = arg2:getName()
	clone_2.Parent = MainUI_upvr
	return clone_2
end
function any_CreateController_result1.animatePetIn(arg1, arg2) -- Line 585
	--[[ Upvalues[4]:
		[1]: var4_upvw (read and write)
		[2]: var16_upvw (read and write)
		[3]: LocalPlayer_upvr (readonly)
		[4]: TweenService_upvr (readonly)
	]]
	local any_hatchSpeed_result1 = var16_upvw.hatchSpeed(LocalPlayer_upvr, var4_upvw.data)
	local scale_3 = arg2.scale
	local originalScale = arg2.originalScale
	local ui = arg2.ui
	local originalUISize = ui.Size
	ui.Size = UDim2.fromScale()
	TweenService_upvr:Create(ui, TweenInfo.new(0.2 / any_hatchSpeed_result1, Enum.EasingStyle.Back), {
		Size = originalUISize;
	}):Play()
	scale_3.Value = originalScale / 1.5
	TweenService_upvr:Create(scale_3, TweenInfo.new(0.2 / any_hatchSpeed_result1, Enum.EasingStyle.Back), {
		Value = originalScale;
	}):Play()
	task.wait(1.5 / any_hatchSpeed_result1)
end
function any_CreateController_result1.animatePetOut(arg1, arg2) -- Line 602
	--[[ Upvalues[4]:
		[1]: var4_upvw (read and write)
		[2]: var16_upvw (read and write)
		[3]: LocalPlayer_upvr (readonly)
		[4]: TweenService_upvr (readonly)
	]]
	local any_hatchSpeed_result1_2 = var16_upvw.hatchSpeed(LocalPlayer_upvr, var4_upvw.data)
	TweenService_upvr:Create(arg2.ui, TweenInfo.new(0.25 / any_hatchSpeed_result1_2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0.25), {
		Size = UDim2.fromScale();
	}):Play()
	TweenService_upvr:Create(arg2.x, TweenInfo.new(0.5 / any_hatchSpeed_result1_2, Enum.EasingStyle.Linear), {
		Value = 1.25;
	}):Play()
	TweenService_upvr:Create(arg2.y, TweenInfo.new(0.5 / any_hatchSpeed_result1_2, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
		Value = -20;
	}):Play()
	TweenService_upvr:Create(arg2.z, TweenInfo.new(0.5 / any_hatchSpeed_result1_2, Enum.EasingStyle.Linear), {
		Value = -7;
	}):Play()
	TweenService_upvr:Create(arg2.scale, TweenInfo.new(0.25 / any_hatchSpeed_result1_2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0.25), {
		Value = 0.01;
	}):Play()
	task.wait(0.5 / any_hatchSpeed_result1_2)
end
function any_CreateController_result1.getPetInstance(arg1, arg2) -- Line 622
	--[[ Upvalues[4]:
		[1]: Assets_upvr (readonly)
		[2]: var14_upvw (read and write)
		[3]: LocalPlayer_upvr (readonly)
		[4]: var9_upvw (read and write)
	]]
	local clone = Assets_upvr.Pets:FindFirstChild(arg2:getName()):Clone()
	clone:PivotTo(var14_upvw.getHRP(LocalPlayer_upvr):GetPivot())
	clone.Parent = workspace.Debris
	var9_upvw:setPetColor(clone, arg2:getTier())
	return clone
end
function any_CreateController_result1.addPet(arg1, arg2) -- Line 632
	if not arg1._hasRenderStep then
		arg1:bindPetPositions()
	end
	local any_getPetData_result1_upvr = arg1:getPetData(arg2, arg1:getPetInstance(arg2))
	local id_upvr = any_getPetData_result1_upvr.id
	arg1._pets[id_upvr] = any_getPetData_result1_upvr
	task.spawn(function() -- Line 644
		--[[ Upvalues[3]:
			[1]: arg1 (readonly)
			[2]: any_getPetData_result1_upvr (readonly)
			[3]: id_upvr (readonly)
		]]
		arg1:animatePetIn(any_getPetData_result1_upvr)
		arg1:animatePetOut(any_getPetData_result1_upvr)
		arg1:cleanData(arg1._pets[any_getPetData_result1_upvr.id])
		arg1._pets[id_upvr] = nil
	end)
end
function any_CreateController_result1.KnitStart(arg1) -- Line 654
	local _hatchQueue = nil
	local eggCtrl = Knit_upvr.GetController("EggController")
	var10_upvw.openEgg:Connect(function(...)
		if eggCtrl then eggCtrl._pendingEgg = false end
		if arg1._isHatching then
			_hatchQueue = {...}
			return
		end
		arg1:eggAnimation(...)
		while _hatchQueue ~= nil do
			local queued = _hatchQueue
			_hatchQueue = nil
			arg1:eggAnimation(table.unpack(queued))
		end
	end)
end
local var177_upvw
local var178_upvw
function any_CreateController_result1.KnitInit(arg1) -- Line 660
	--[[ Upvalues[15]:
		[1]: var10_upvw (read and write)
		[2]: Knit_upvr (readonly)
		[3]: var4_upvw (read and write)
		[4]: var5_upvw (read and write)
		[5]: var6_upvw (read and write)
		[6]: var7_upvw (read and write)
		[7]: var8_upvw (read and write)
		[8]: var9_upvw (read and write)
		[9]: var14_upvw (read and write)
		[10]: ReplicatedStorage_upvr (readonly)
		[11]: var15_upvw (read and write)
		[12]: var177_upvw (read and write)
		[13]: var178_upvw (read and write)
		[14]: var16_upvw (read and write)
		[15]: var17_upvw (read and write)
	]]
	var10_upvw = Knit_upvr.GetService("EggService")
	var4_upvw = Knit_upvr.GetController("DataController")
	var5_upvw = Knit_upvr.GetController("SoundController")
	var6_upvw = Knit_upvr.GetController("UIController")
	var7_upvw = Knit_upvr.GetController("ItemController")
	var8_upvw = Knit_upvr.GetController("LeaderboardController")
	var9_upvw = Knit_upvr.GetController("PetController")
	var14_upvw = require(ReplicatedStorage_upvr.Shared.Functions)
	var15_upvw = require(ReplicatedStorage_upvr.Shared.Util)
	var177_upvw = require(ReplicatedStorage_upvr.Packages.Shake)
	var178_upvw = require(ReplicatedStorage_upvr.Shared.Items)
	var16_upvw = require(ReplicatedStorage_upvr.Shared.Values)
	var17_upvw = require(script.Animations)
end
return any_CreateController_result1