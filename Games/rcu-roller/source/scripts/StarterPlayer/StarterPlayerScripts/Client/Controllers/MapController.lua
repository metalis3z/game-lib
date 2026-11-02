-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:20:05
-- Luau version 6, Types version 3
-- Time taken: 0.003219 seconds

local Knit_upvr = require(game:GetService("ReplicatedStorage").Packages.Knit)
local any_CreateController_result1 = Knit_upvr.CreateController({
	Name = "MapController";
	onMapChange = Knit_upvr.signal.new();
	_visitedMaps = {};
})
local var4_upvw
local var5_upvw
local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local TweenService_upvr = game:GetService("TweenService")
local var8_upvw
local var9_upvw
local CurrentCamera_upvr = workspace.CurrentCamera
function any_CreateController_result1.setCurrentMap(arg1, arg2) -- Line 45
	arg1._currentMapId = arg2
	arg1.onMapChange:Fire(arg2)
	if not table.find(arg1._visitedMaps, arg2) then
		table.insert(arg1._visitedMaps, arg2)
	end
	arg1:currentMapChanged(arg2)
end
function any_CreateController_result1.getCurrentMap(arg1, arg2) -- Line 56
	--[[ Upvalues[1]:
		[1]: var8_upvw (read and write)
	]]
	if not arg1._currentMapId then return nil end
	if not arg2 then
		return var8_upvw[arg1._currentMapId].name
	end
	return arg1._currentMapId
end
function any_CreateController_result1.hasVisitedMap(arg1, arg2) -- Line 64
	return table.find(arg1._visitedMaps, arg2)
end
local ClockTime_upvr = game:GetService("Lighting").ClockTime
function any_CreateController_result1.currentMapChanged(arg1, arg2) -- Line 68
	--[[ Upvalues[3]:
		[1]: var8_upvw (read and write)
		[2]: var4_upvw (read and write)
		[3]: ClockTime_upvr (readonly)
	]]
	local var13 = var8_upvw[arg2]
	var4_upvw:playAmbience(var13.ambience)
	if var13.night then
		arg1:setClockTime(23.9)
	else
		arg1:setClockTime(ClockTime_upvr)
	end
end
function any_CreateController_result1.setClockTime(arg1, arg2) -- Line 80
	--[[ Upvalues[1]:
		[1]: TweenService_upvr (readonly)
	]]
	local tbl = {}
	tbl.ClockTime = arg2
	TweenService_upvr:Create(game.Lighting, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), tbl):Play()
end
function any_CreateController_result1.setCameraAtShake(arg1, arg2) -- Line 84
	--[[ Upvalues[1]:
		[1]: CurrentCamera_upvr (readonly)
	]]
	arg2:BindToRenderStep(arg2.NextRenderName(), Enum.RenderPriority.Last.Value, function(arg1_2, arg2_2, arg3) -- Line 85
		--[[ Upvalues[1]:
			[1]: CurrentCamera_upvr (copied, readonly)
		]]
		local var16 = CurrentCamera_upvr
		var16.CFrame *= CFrame.new(arg1_2) * CFrame.Angles(arg2_2.X, arg2_2.Y, arg2_2.Z)
	end)
end
function any_CreateController_result1.buildUpShake(arg1) -- Line 90
	--[[ Upvalues[1]:
		[1]: var9_upvw (read and write)
	]]
	local any_new_result1_2 = var9_upvw.new()
	any_new_result1_2.FadeInTime = 1.5
	any_new_result1_2.Frequency = 0.04
	any_new_result1_2.Amplitude = 0.15
	any_new_result1_2.RotationInfluence = Vector3.new(0.10000, 0.10000, 0.10000)
	any_new_result1_2.SustainTime = 0.25
	any_new_result1_2:Start()
	arg1:setCameraAtShake(any_new_result1_2)
end
function any_CreateController_result1.openedShake(arg1) -- Line 103
	--[[ Upvalues[1]:
		[1]: var9_upvw (read and write)
	]]
	local any_new_result1 = var9_upvw.new()
	any_new_result1.FadeInTime = 0
	any_new_result1.Frequency = 0.1
	any_new_result1.Amplitude = 0.5
	any_new_result1.RotationInfluence = Vector3.new(0.10000, 0.10000, 0.10000)
	any_new_result1.SustainTime = 0.15
	any_new_result1:Start()
	arg1:setCameraAtShake(any_new_result1)
end
function any_CreateController_result1.tweenCamera(arg1, arg2, arg3) -- Line 116
	--[[ Upvalues[2]:
		[1]: TweenService_upvr (readonly)
		[2]: CurrentCamera_upvr (readonly)
	]]
	local tbl_2 = {}
	tbl_2.FieldOfView = arg3
	TweenService_upvr:Create(CurrentCamera_upvr, TweenInfo.new(arg2), tbl_2):Play()
end
function any_CreateController_result1.unlockAnimation(arg1, arg2, arg3) -- Line 120
	--[[ Upvalues[5]:
		[1]: var8_upvw (read and write)
		[2]: CurrentCamera_upvr (readonly)
		[3]: var4_upvw (read and write)
		[4]: TweenService_upvr (readonly)
		[5]: var5_upvw (read and write)
	]]
	local var21_upvr = var8_upvw[arg3]
	task.spawn(function() -- Line 123
		--[[ Upvalues[7]:
			[1]: arg2 (readonly)
			[2]: CurrentCamera_upvr (copied, readonly)
			[3]: arg1 (readonly)
			[4]: var4_upvw (copied, read and write)
			[5]: TweenService_upvr (copied, readonly)
			[6]: var21_upvr (readonly)
			[7]: var5_upvw (copied, read and write)
		]]
		local Sparkles_upvr = arg2:FindFirstChild("Sparkles")
		arg2:FindFirstChild("UnlockGui").Enabled = false
		arg1:tweenCamera(2, 85)
		arg1:buildUpShake()
		var4_upvw:play("Drum Roll")
		Sparkles_upvr.Enabled = true
		arg2.Transparency = 0
		TweenService_upvr:Create(arg2, TweenInfo.new(2), {
			Color = Color3.fromRGB(255, 255, 255);
		}):Play()
		task.wait(2)
		arg1:tweenCamera(0.025, CurrentCamera_upvr.FieldOfView)
		arg1:openedShake()
		var4_upvw:play("Map Unlocked")
		var4_upvw:play("Explosion", {
			timePosition = 0.12;
		})
		task.delay(2.5, function() -- Line 147
			--[[ Upvalues[1]:
				[1]: Sparkles_upvr (readonly)
			]]
			Sparkles_upvr.Enabled = false
		end)
		arg1:hideWall(arg2)
		var5_upvw:createNotification("Custom", `<font color="#ffffff"><stroke color="#000000" thickness="3">Congratulations! You unlocked </stroke></font><font color="#{var21_upvr.color:ToHex()}"><stroke color="#000000" thickness="3">{var21_upvr.name}</stroke></font>`, 5)
	end)
end
function any_CreateController_result1.hideWall(arg1, arg2) -- Line 157
	--[[ Upvalues[1]:
		[1]: TweenService_upvr (readonly)
	]]
	arg2:FindFirstChild("UnlockGui").Enabled = false
	arg2.CanCollide = false
	TweenService_upvr:Create(arg2, TweenInfo.new(0.15), {
		Transparency = 1;
	}):Play()
end
function any_CreateController_result1.KnitStart(arg1) -- Line 165
end
local var27_upvw
local var28_upvw
local var29_upvw
function any_CreateController_result1.KnitInit(arg1) -- Line 169
	--[[ Upvalues[9]:
		[1]: var27_upvw (read and write)
		[2]: Knit_upvr (readonly)
		[3]: var4_upvw (read and write)
		[4]: var5_upvw (read and write)
		[5]: var28_upvw (read and write)
		[6]: ReplicatedStorage_upvr (readonly)
		[7]: var29_upvw (read and write)
		[8]: var8_upvw (read and write)
		[9]: var9_upvw (read and write)
	]]
	var27_upvw = Knit_upvr.GetController("DataController")
	var4_upvw = Knit_upvr.GetController("SoundController")
	var5_upvw = Knit_upvr.GetController("UIController")
	var28_upvw = require(ReplicatedStorage_upvr.Shared.Util)
	var29_upvw = require(ReplicatedStorage_upvr.Shared.Functions)
	var8_upvw = require(ReplicatedStorage_upvr.Shared.List.Maps)
	var9_upvw = require(ReplicatedStorage_upvr.Packages.Shake)
end
return any_CreateController_result1