-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:19:50
-- Luau version 6, Types version 3
-- Time taken: 0.003824 seconds

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService_upvr = game:GetService("TweenService")
local Lighting_upvr = game:GetService("Lighting")
local var4_upvw
local Util_upvr = require(ReplicatedStorage.Shared.Util)
local PlayerGui = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
local MainUI_upvr = PlayerGui:WaitForChild("MainUI")
local Overlays_upvr = PlayerGui:WaitForChild("Overlays")
local CurrentCamera_upvr = workspace.CurrentCamera
local Assets_upvr = ReplicatedStorage.Assets
local function _(arg1) -- Line 34, Named "startAndEnd"
	--[[ Upvalues[3]:
		[1]: MainUI_upvr (readonly)
		[2]: Lighting_upvr (readonly)
		[3]: CurrentCamera_upvr (readonly)
	]]
	local var11 = not arg1
	MainUI_upvr.Enabled = var11
	if arg1 then
		var11 = 0
	else
		var11 = 9.7
	end
	Lighting_upvr.ClockTime = var11
	local function INLINED() -- Internal function, doesn't exist in bytecode
		var11 = Enum.CameraType.Scriptable
		return var11
	end
	if not arg1 or not INLINED() then
		var11 = Enum.CameraType.Custom
	end
	CurrentCamera_upvr.CameraType = var11
end
local function _() -- Line 40, Named "createOverlay"
	--[[ Upvalues[2]:
		[1]: Assets_upvr (readonly)
		[2]: Overlays_upvr (readonly)
	]]
	local clone_2 = Assets_upvr.UI.FX.Flash:Clone()
	clone_2.Parent = Overlays_upvr
	return clone_2
end
local function tweenCamera_upvr(arg1, arg2, arg3, arg4, arg5) -- Line 47, Named "tweenCamera"
	--[[ Upvalues[2]:
		[1]: CurrentCamera_upvr (readonly)
		[2]: TweenService_upvr (readonly)
	]]
	CurrentCamera_upvr.CFrame = arg1[`Loc_{arg2}_1`].CFrame
	local var13 = arg4
	if not var13 then
		var13 = Enum.EasingStyle.Linear
	end
	local var14 = arg5
	if not var14 then
		var14 = Enum.EasingDirection.Out
	end
	TweenService_upvr:Create(CurrentCamera_upvr, TweenInfo.new(arg3, var13, var14), {
		CFrame = arg1[`Loc_{arg2}_2`].CFrame;
	}):Play()
end
local function tweenFOV_upvr(arg1, arg2, arg3, arg4) -- Line 55, Named "tweenFOV"
	--[[ Upvalues[2]:
		[1]: TweenService_upvr (readonly)
		[2]: CurrentCamera_upvr (readonly)
	]]
	local var16 = arg3
	if not var16 then
		var16 = Enum.EasingStyle.Linear
	end
	local var17 = arg4
	if not var17 then
		var17 = Enum.EasingDirection.Out
	end
	local tbl = {}
	tbl.FieldOfView = arg1
	TweenService_upvr:Create(CurrentCamera_upvr, TweenInfo.new(arg2, var16, var17), tbl):Play()
end
local function _() -- Line 61, Named "canOverrideMute"
	--[[ Upvalues[2]:
		[1]: var4_upvw (read and write)
		[2]: Util_upvr (readonly)
	]]
	local any_getData_result1_2 = var4_upvw:getData()
	if not Util_upvr.settingUtils.getSetting(any_getData_result1_2, "muteSounds") then
		return true
	end
	local any_getSettingValue_result1_2 = Util_upvr.settingUtils.getSettingValue(any_getData_result1_2, "extraHatchingSounds")
	if not any_getSettingValue_result1_2 then return end
	if 7 < any_getSettingValue_result1_2 then return end
	return true
end
local var22_upvw
local Knit_upvr = require(game:GetService("ReplicatedStorage").Packages.Knit)
local var24_upvw
local TweenInfo_new_result1_upvr_2 = TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
local TweenInfo_new_result1_upvr = TweenInfo.new(2, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
local Functions_upvr = require(ReplicatedStorage.Shared.Functions)
return function(arg1) -- Line 80
	--[[ Upvalues[16]:
		[1]: var22_upvw (read and write)
		[2]: Knit_upvr (readonly)
		[3]: var24_upvw (read and write)
		[4]: var4_upvw (read and write)
		[5]: Assets_upvr (readonly)
		[6]: Overlays_upvr (readonly)
		[7]: TweenService_upvr (readonly)
		[8]: TweenInfo_new_result1_upvr_2 (readonly)
		[9]: TweenInfo_new_result1_upvr (readonly)
		[10]: MainUI_upvr (readonly)
		[11]: Lighting_upvr (readonly)
		[12]: CurrentCamera_upvr (readonly)
		[13]: Util_upvr (readonly)
		[14]: tweenCamera_upvr (readonly)
		[15]: Functions_upvr (readonly)
		[16]: tweenFOV_upvr (readonly)
	]]
	-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
	-- CF ANALYSIS FAILED fix: reconstructed setup and sound play sequence
	var22_upvw = Knit_upvr.GetController("SoundController")
	var24_upvw = Knit_upvr.GetController("HatchingController")
	var4_upvw = Knit_upvr.GetController("DataController")
	var22_upvw:preloadSounds({"Eternal Cutscene", "Ufo Drone", "Ufo Warble"})
	local clone = Assets_upvr.UI.FX.Flash:Clone()
	clone.Parent = Overlays_upvr
	local var30 = clone
	TweenService_upvr:Create(var30, TweenInfo_new_result1_upvr_2, {
		BackgroundTransparency = 0;
	}):Play()
	task.wait(2.5)
	TweenService_upvr:Create(var30, TweenInfo_new_result1_upvr, {
		BackgroundTransparency = 1;
	}):Play()
	MainUI_upvr.Enabled = false
	Lighting_upvr.ClockTime = 0
	local Scriptable = Enum.CameraType.Scriptable
	if not Scriptable then
		Scriptable = Enum.CameraType.Custom
	end
	CurrentCamera_upvr.CameraType = Scriptable
	local any_getData_result1 = var4_upvw:getData()
	-- CF ANALYSIS FAILED fix: if/else for overrideMute (else-branch was in separated CF block)
	local var_overrideMute
	if not Util_upvr.settingUtils.getSetting(any_getData_result1, "muteSounds") then
		var_overrideMute = true
	else
		local any_getSettingValue_result1 = Util_upvr.settingUtils.getSettingValue(any_getData_result1, "extraHatchingSounds")
		if not any_getSettingValue_result1 then
		elseif 7 < any_getSettingValue_result1 then
		else
			var_overrideMute = true
		end
	end
	-- CF ANALYSIS FAILED: sound play call with {volume=1.5, overrideMute=var_overrideMute} was lost by decompiler
end