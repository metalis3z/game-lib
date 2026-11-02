-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:19:48
-- Luau version 6, Types version 3
-- Time taken: 0.003028 seconds

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local var2_upvw
local Util_upvr = require(ReplicatedStorage.Shared.Util)
local CurrentCamera_upvr = workspace.CurrentCamera
local Assets_upvr = ReplicatedStorage.Assets
local Debris_upvr = game:GetService("Debris")
local function addLighting_upvr(arg1) -- Line 21, Named "addLighting"
	--[[ Upvalues[2]:
		[1]: Assets_upvr (readonly)
		[2]: Debris_upvr (readonly)
	]]
	for _, v in arg1.eggData.eggs do
		local Attachment = Instance.new("Attachment", v.instance.PrimaryPart)
		for _, v_2 in Assets_upvr.VFX.MythicalHatch.Lighting:GetChildren() do
			local clone = v_2:Clone()
			clone.Parent = Attachment
			clone:Emit(1)
			Debris_upvr:AddItem(clone, 1)
		end
	end
end
local function addAura_upvr(arg1) -- Line 34, Named "addAura"
	--[[ Upvalues[1]:
		[1]: Assets_upvr (readonly)
	]]
	for _, v_3 in arg1.eggData.eggs do
		local Attachment_2 = Instance.new("Attachment", v_3.instance.PrimaryPart)
		for _, v_4 in Assets_upvr.VFX.MythicalHatch.Aura:GetChildren() do
			local clone_2 = v_4:Clone()
			clone_2.Parent = Attachment_2
			clone_2.Enabled = true
		end
	end
end
local Shake_upvr = require(ReplicatedStorage.Packages.Shake)
local function shakeCamera_upvr(arg1, arg2, arg3) -- Line 45, Named "shakeCamera"
	--[[ Upvalues[2]:
		[1]: Shake_upvr (readonly)
		[2]: CurrentCamera_upvr (readonly)
	]]
	local any_new_result1 = Shake_upvr.new()
	any_new_result1.FadeInTime = 0
	any_new_result1.Frequency = arg1 or 0.2
	any_new_result1.Amplitude = arg2 or 0.4
	any_new_result1.RotationInfluence = Vector3.new(0.07500, 0.07500, 0.07500)
	any_new_result1.SustainTime = arg3 or 0.15
	any_new_result1:Start()
	any_new_result1:BindToRenderStep(any_new_result1.NextRenderName(), Enum.RenderPriority.Last.Value, function(arg1_2, arg2_2, arg3_2) -- Line 54
		--[[ Upvalues[1]:
			[1]: CurrentCamera_upvr (copied, readonly)
		]]
		local var36 = CurrentCamera_upvr
		var36.CFrame *= CFrame.new(arg1_2) * CFrame.Angles(arg2_2.X, arg2_2.Y, arg2_2.Z)
	end)
end
local TweenService_upvr = game:GetService("TweenService")
local function tweenFOV_upvr(arg1, arg2) -- Line 59, Named "tweenFOV"
	--[[ Upvalues[2]:
		[1]: TweenService_upvr (readonly)
		[2]: CurrentCamera_upvr (readonly)
	]]
	local tbl_2 = {}
	tbl_2.FieldOfView = arg1
	TweenService_upvr:Create(CurrentCamera_upvr, TweenInfo.new(arg2, Enum.EasingStyle.Linear), tbl_2):Play()
end
local function _() -- Line 65, Named "canOverrideMute"
	--[[ Upvalues[2]:
		[1]: var2_upvw (read and write)
		[2]: Util_upvr (readonly)
	]]
	local any_getData_result1_3 = var2_upvw:getData()
	if not Util_upvr.settingUtils.getSetting(any_getData_result1_3, "muteSounds") then
		return true
	end
	local any_getSettingValue_result1_3 = Util_upvr.settingUtils.getSettingValue(any_getData_result1_3, "extraHatchingSounds")
	if not any_getSettingValue_result1_3 then return end
	if any_getSettingValue_result1_3 ~= 6 then return end
	return true
end
local var42_upvw
local Knit_upvr = require(game:GetService("ReplicatedStorage").Packages.Knit)
return function(arg1) -- Line 84
	--[[ Upvalues[9]:
		[1]: var42_upvw (read and write)
		[2]: Knit_upvr (readonly)
		[3]: var2_upvw (read and write)
		[4]: addLighting_upvr (readonly)
		[5]: shakeCamera_upvr (readonly)
		[6]: Util_upvr (readonly)
		[7]: addAura_upvr (readonly)
		[8]: CurrentCamera_upvr (readonly)
		[9]: tweenFOV_upvr (readonly)
	]]
	-- CF ANALYSIS FAILED fix: reconstructed if/else structure for overrideMute checks
	var42_upvw = Knit_upvr.GetController("SoundController")
	var2_upvw = Knit_upvr.GetController("DataController")
	addLighting_upvr(arg1)
	shakeCamera_upvr(0.15, 0.3)
	local tbl = {}
	local any_getData_result1_2 = var2_upvw:getData()
	local var46
	if not Util_upvr.settingUtils.getSetting(any_getData_result1_2, "muteSounds") then
		var46 = true
	else
		local any_getSettingValue_result1 = Util_upvr.settingUtils.getSettingValue(any_getData_result1_2, "extraHatchingSounds")
		if not any_getSettingValue_result1 then
			var46 = nil
		elseif any_getSettingValue_result1 ~= 6 then
			var46 = nil
		else
			var46 = true
		end
	end
	tbl.overrideMute = var46
	var42_upvw:play("Lightning Hit", tbl)
	task.wait(1.5)
	addLighting_upvr(arg1)
	shakeCamera_upvr(0.15, 0.3)
	local tbl_3 = {}
	local any_getData_result1 = var2_upvw:getData()
	if not Util_upvr.settingUtils.getSetting(any_getData_result1, "muteSounds") then
		var46 = true
	else
		-- CF ANALYSIS FAILED fix: else-branch was in separated CF block
		local any_getSettingValue_result1_2 = Util_upvr.settingUtils.getSettingValue(any_getData_result1, "extraHatchingSounds")
		if not any_getSettingValue_result1_2 then
			var46 = nil
		elseif any_getSettingValue_result1_2 ~= 6 then
			var46 = nil
		else
			var46 = true
		end
	end
	tbl_3.overrideMute = var46
	var42_upvw:play("Lightning Hit", tbl_3)
	task.wait(1.5)
	addLighting_upvr(arg1)
	shakeCamera_upvr(0.15, 0.3)
	-- CF ANALYSIS FAILED: third sound play call (with playbackSpeed=1.15) was lost by decompiler
end