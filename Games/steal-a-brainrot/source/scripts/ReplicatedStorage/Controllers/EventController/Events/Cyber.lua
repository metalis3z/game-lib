-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:21:34
-- Luau version 6, Types version 3
-- Time taken: 0.010838 seconds

local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
require(ReplicatedStorage_upvr.Shared.EventTypes)
local module = {}
local any_new_result1_upvr = require(ReplicatedStorage_upvr.Packages.Trove).new()
local EventController_upvr = require(ReplicatedStorage_upvr.Controllers.EventController)
local Name_upvr = script.Name
local EffectController_upvr = require(ReplicatedStorage_upvr.Controllers.EffectController)
local ServerData_upvr = require(ReplicatedStorage_upvr.Datas.ServerData)
local Net_upvr = require(ReplicatedStorage_upvr.Packages.Net)
local SoundController_upvr = require(ReplicatedStorage_upvr.Controllers.SoundController)
local VFX_upvr = require(ReplicatedStorage_upvr.Shared.VFX)
local var11_upvw
local Color3_fromRGB_result1_upvr = Color3.fromRGB(70, 210, 255)
local CreateTween_upvr = require(ReplicatedStorage_upvr.Packages.CreateTween)
local Lighting_upvr = game:GetService("Lighting")
local Observers_upvr = require(ReplicatedStorage_upvr.Packages.Observers)
local CycleController_upvr = require(ReplicatedStorage_upvr.Controllers.CycleController)
function module.OnStart(arg1) -- Line 22
	--[[ Upvalues[15]:
		[1]: EventController_upvr (readonly)
		[2]: Name_upvr (readonly)
		[3]: EffectController_upvr (readonly)
		[4]: any_new_result1_upvr (readonly)
		[5]: ServerData_upvr (readonly)
		[6]: Net_upvr (readonly)
		[7]: SoundController_upvr (readonly)
		[8]: ReplicatedStorage_upvr (readonly)
		[9]: VFX_upvr (readonly)
		[10]: var11_upvw (read and write)
		[11]: Color3_fromRGB_result1_upvr (readonly)
		[12]: CreateTween_upvr (readonly)
		[13]: Lighting_upvr (readonly)
		[14]: Observers_upvr (readonly)
		[15]: CycleController_upvr (readonly)
	]]
	assert(EventController_upvr:GetActiveEventData(Name_upvr))
	EffectController_upvr:Activate("Blink")
	any_new_result1_upvr:Add(function() -- Line 27
		--[[ Upvalues[1]:
			[1]: EffectController_upvr (copied, readonly)
		]]
		EffectController_upvr:Activate("Blink")
	end)
	EffectController_upvr:Run("CyberEvent", "GrassRecolor")
	any_new_result1_upvr:Add(function() -- Line 32
		--[[ Upvalues[1]:
			[1]: EffectController_upvr (copied, readonly)
		]]
		EffectController_upvr:Stop("CyberEvent", "GrassRecolor")
	end)
	EffectController_upvr:Run("CyberEvent", "WallRecolor")
	any_new_result1_upvr:Add(function() -- Line 37
		--[[ Upvalues[1]:
			[1]: EffectController_upvr (copied, readonly)
		]]
		EffectController_upvr:Stop("CyberEvent", "WallRecolor")
	end)
	EffectController_upvr:Run("CyberEvent", "WallBottomRecolor")
	any_new_result1_upvr:Add(function() -- Line 42
		--[[ Upvalues[1]:
			[1]: EffectController_upvr (copied, readonly)
		]]
		EffectController_upvr:Stop("CyberEvent", "WallBottomRecolor")
	end)
	local var21_upvw
	if ServerData_upvr.IsBiggerServer() then
		var21_upvw = any_new_result1_upvr:Clone(script.BiggerCyberMap)
		var21_upvw.Parent = workspace
	else
		var21_upvw = any_new_result1_upvr:Clone(script.CyberMap)
		var21_upvw.Parent = workspace
	end
	local Animator_upvr = var21_upvw.Beacon.AnimationController.Animator
	local any_LoadAnimation_result1_upvr = Animator_upvr:LoadAnimation(script.BeaconAnimation)
	any_new_result1_upvr:Add(function() -- Line 57
		--[[ Upvalues[1]:
			[1]: any_LoadAnimation_result1_upvr (readonly)
		]]
		any_LoadAnimation_result1_upvr:Stop()
		any_LoadAnimation_result1_upvr:Destroy()
	end)
	local var26_upvw = 0
	any_new_result1_upvr:Add(Net_upvr:RemoteEvent("GameService/CyberBeaconAnimation").OnClientEvent:Connect(function(arg1_2, arg2, arg3) -- Line 63
		--[[ Upvalues[10]:
			[1]: Animator_upvr (readonly)
			[2]: any_LoadAnimation_result1_upvr (readonly)
			[3]: SoundController_upvr (copied, readonly)
			[4]: ReplicatedStorage_upvr (copied, readonly)
			[5]: var21_upvw (read and write)
			[6]: VFX_upvr (copied, readonly)
			[7]: var26_upvw (read and write)
			[8]: var11_upvw (copied, read and write)
			[9]: Color3_fromRGB_result1_upvr (copied, readonly)
			[10]: CreateTween_upvr (copied, readonly)
		]]
		if not arg3 and Animator_upvr:IsDescendantOf(workspace) then
			any_LoadAnimation_result1_upvr:Stop(0)
			any_LoadAnimation_result1_upvr:Play()
			SoundController_upvr:PlaySound(ReplicatedStorage_upvr.Sounds.Sfx.CyberSpawn, var21_upvw.Beacon:GetPivot().Position, false)
			VFX_upvr.emit(var21_upvw.Beacon)
		end
		var26_upvw += 1
		task.spawn(function() -- Line 73
			--[[ Upvalues[5]:
				[1]: var11_upvw (copied, read and write)
				[2]: Color3_fromRGB_result1_upvr (copied, readonly)
				[3]: CreateTween_upvr (copied, readonly)
				[4]: var26_upvw (readonly)
				[5]: var26_upvw (copied, read and write)
			]]
			-- KONSTANTERROR: [0] 1. Error Block 1 start (CF ANALYSIS FAILED)
			local Map = workspace:FindFirstChild("Map")
			-- KONSTANTERROR: [0] 1. Error Block 1 end (CF ANALYSIS FAILED)
			-- KONSTANTERROR: [7] 6. Error Block 2 start (CF ANALYSIS FAILED)
			-- KONSTANTERROR: [7] 6. Error Block 2 end (CF ANALYSIS FAILED)
			-- KONSTANTERROR: [12] 10. Error Block 3 start (CF ANALYSIS FAILED)
			-- KONSTANTERROR: [12] 10. Error Block 3 end (CF ANALYSIS FAILED)
		end)
	end))
	local Atmosphere_upvr = Lighting_upvr:FindFirstChild("Atmosphere")
	if Atmosphere_upvr then
		Atmosphere_upvr.Parent = script
		any_new_result1_upvr:Add(function() -- Line 139
			--[[ Upvalues[2]:
				[1]: Atmosphere_upvr (readonly)
				[2]: Lighting_upvr (copied, readonly)
			]]
			Atmosphere_upvr.Parent = Lighting_upvr
		end)
	end
	any_new_result1_upvr:Clone(script.AtmosphereCyber).Parent = Lighting_upvr
	local Cartoon_upvr = Lighting_upvr:FindFirstChild("Cartoon")
	if Cartoon_upvr then
		Cartoon_upvr.Parent = script
		any_new_result1_upvr:Add(function() -- Line 148
			--[[ Upvalues[2]:
				[1]: Cartoon_upvr (readonly)
				[2]: Lighting_upvr (copied, readonly)
			]]
			Cartoon_upvr.Parent = Lighting_upvr
		end)
	end
	any_new_result1_upvr:Clone(script.SkyCyber).Parent = Lighting_upvr
	any_new_result1_upvr:Add(Observers_upvr.observeTag("HideInCyber", function(arg1_3) -- Line 154
		arg1_3.Parent = script
		local Parent_upvr = arg1_3.Parent
		return function() -- Line 157
			--[[ Upvalues[2]:
				[1]: arg1_3 (readonly)
				[2]: Parent_upvr (readonly)
			]]
			pcall(function() -- Line 159
				--[[ Upvalues[2]:
					[1]: arg1_3 (copied, readonly)
					[2]: Parent_upvr (copied, readonly)
				]]
				arg1_3.Parent = Parent_upvr
			end)
		end
	end, {workspace, script}))
	any_new_result1_upvr:Add(Observers_upvr.observeTag("ShowInCyber", function(arg1_4) -- Line 165
		local Parent_upvr_2 = arg1_4.Parent
		local var40_upvw = false
		arg1_4.Parent = script
		local any_Once_result1_upvr = Parent_upvr_2.Destroying:Once(function() -- Line 168
			--[[ Upvalues[2]:
				[1]: var40_upvw (read and write)
				[2]: arg1_4 (readonly)
			]]
			var40_upvw = true
			arg1_4:Destroy()
		end)
		return function() -- Line 174
			--[[ Upvalues[4]:
				[1]: any_Once_result1_upvr (readonly)
				[2]: var40_upvw (read and write)
				[3]: arg1_4 (readonly)
				[4]: Parent_upvr_2 (readonly)
			]]
			any_Once_result1_upvr:Disconnect()
			if not var40_upvw then
				pcall(function() -- Line 178
					--[[ Upvalues[2]:
						[1]: arg1_4 (copied, readonly)
						[2]: Parent_upvr_2 (copied, readonly)
					]]
					arg1_4.Parent = Parent_upvr_2
				end)
			end
		end
	end, {workspace, script}))
	CycleController_upvr:Update()
	SoundController_upvr:UpdateOST()
end
function module.OnStop(arg1) -- Line 188
	--[[ Upvalues[1]:
		[1]: any_new_result1_upvr (readonly)
	]]
	any_new_result1_upvr:Destroy()
end
function module.OnLoad(arg1) -- Line 192
end
return module