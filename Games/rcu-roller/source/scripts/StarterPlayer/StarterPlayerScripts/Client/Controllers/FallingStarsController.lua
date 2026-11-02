-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:20:14
-- Luau version 6, Types version 3
-- Time taken: 0.005373 seconds

local Knit_upvr = require(game:GetService("ReplicatedStorage").Packages.Knit)
local any_CreateController_result1 = Knit_upvr.CreateController({
	Name = "FallingStarsController";
	_stars = {};
	_debounce = {};
	_activeMapId = 0;
})
local var4_upvw
local var5_upvw
local var6_upvw
local var7_upvw
local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local TweenService_upvr = game:GetService("TweenService")
local var10_upvw
local var11_upvw
local var12_upvw
local var13_upvw
local LocalPlayer_upvr = game:GetService("Players").LocalPlayer
local CollectionService_upvr = game:GetService("CollectionService")
function any_CreateController_result1.getFolder(arg1, arg2) -- Line 45
	--[[ Upvalues[1]:
		[1]: CollectionService_upvr (readonly)
	]]
	for _, v in CollectionService_upvr:GetTagged("FallingStarsPoints") do
		if v:GetAttribute("mapId") == arg2.mapId then
			return v
		end
	end
end
function any_CreateController_result1.getSpawnPointVector(arg1, arg2) -- Line 55
	--[[ Upvalues[1]:
		[1]: var13_upvw (read and write)
	]]
	local any_new_result1_2 = var13_upvw.new(arg1:getFolder(arg2))
	local _point = any_new_result1_2:getRandomPoint()
	any_new_result1_2:destroy()
	return _point
end
local CurrentCamera_upvr = workspace.CurrentCamera
function any_CreateController_result1.shake(arg1, arg2) -- Line 66
	--[[ Upvalues[2]:
		[1]: var12_upvw (read and write)
		[2]: CurrentCamera_upvr (readonly)
	]]
	local any_new_result1 = var12_upvw.new()
	any_new_result1.FadeInTime = 0
	any_new_result1.Frequency = 0.1
	any_new_result1.Amplitude = 1.5 / math.log(arg2)
	any_new_result1.RotationInfluence = Vector3.new(0.10000, 0.10000, 0.10000)
	any_new_result1.SustainTime = 0.15
	any_new_result1:Start()
	any_new_result1:BindToRenderStep(any_new_result1.NextRenderName(), Enum.RenderPriority.Last.Value, function(arg1_2, arg2_2, arg3) -- Line 77
		--[[ Upvalues[1]:
			[1]: CurrentCamera_upvr (copied, readonly)
		]]
		local var25 = CurrentCamera_upvr
		var25.CFrame *= CFrame.new(arg1_2) * CFrame.Angles(arg2_2.X, arg2_2.Y, arg2_2.Z)
	end)
end
function any_CreateController_result1.shakeIfClose(arg1, arg2) -- Line 82
	--[[ Upvalues[2]:
		[1]: var11_upvw (read and write)
		[2]: LocalPlayer_upvr (readonly)
	]]
	local any_getHRP_result1 = var11_upvw.getHRP(LocalPlayer_upvr)
	if not any_getHRP_result1 then
	else
		local Magnitude = (any_getHRP_result1.Position - arg2).Magnitude
		if 100 < Magnitude then return end
		arg1:shake(Magnitude)
	end
end
function any_CreateController_result1.tweenStar(arg1, arg2, arg3) -- Line 96
	--[[ Upvalues[1]:
		[1]: TweenService_upvr (readonly)
	]]
	local CFrameValue_upvr = Instance.new("CFrameValue")
	CFrameValue_upvr.Value = arg2:GetPivot()
	CFrameValue_upvr.Changed:Connect(function() -- Line 100
		--[[ Upvalues[2]:
			[1]: arg2 (readonly)
			[2]: CFrameValue_upvr (readonly)
		]]
		arg2:PivotTo(CFrameValue_upvr.Value)
	end)
	TweenService_upvr:Create(CFrameValue_upvr, TweenInfo.new(5, Enum.EasingStyle.Linear), {
		Value = CFrame.new(arg3) * CFrame.new(0, arg2.PrimaryPart.Size.Y / 2, 0) * CFrame.Angles(0, math.rad(math.random(0, 360)), 0);
	}):Play()
	task.delay(5, function() -- Line 109
		--[[ Upvalues[1]:
			[1]: CFrameValue_upvr (readonly)
		]]
		CFrameValue_upvr:Destroy()
	end)
end
function any_CreateController_result1.playExplosion(arg1, arg2) -- Line 114
	--[[ Upvalues[1]:
		[1]: var5_upvw (read and write)
	]]
	var5_upvw:play("Explosion", {
		volume = 0.75;
		timePosition = 0.12;
		parent = arg2.PrimaryPart;
		rollOffMode = Enum.RollOffMode.Linear;
		rollOffMinDistance = 3;
		rollOffMaxDistance = 110;
		pitchShift = true;
		pitchOctave = 0.55;
	})
end
function any_CreateController_result1.hideParticles(arg1, arg2) -- Line 129
	for _, v_2 in arg2.PrimaryPart.hideAfterLanding:GetChildren() do
		v_2.Enabled = false
	end
end
function any_CreateController_result1.onLand(arg1, arg2, arg3) -- Line 135
	arg1:playExplosion(arg2)
	arg1:shakeIfClose(arg3)
	arg1:hideParticles(arg2)
end
function any_CreateController_result1.playAmbience(arg1, arg2) -- Line 141
	--[[ Upvalues[1]:
		[1]: var5_upvw (read and write)
	]]
	var5_upvw:play("Falling Star", {
		parent = arg2.PrimaryPart;
		looped = true;
		dontDestroy = true;
	})
end
function any_CreateController_result1.starClaimed(arg1, arg2) -- Line 149
	--[[ Upvalues[1]:
		[1]: TweenService_upvr (readonly)
	]]
	local NumberValue_upvr = Instance.new("NumberValue")
	NumberValue_upvr.Value = arg2:GetScale()
	NumberValue_upvr.Changed:Connect(function() -- Line 153
		--[[ Upvalues[2]:
			[1]: arg2 (readonly)
			[2]: NumberValue_upvr (readonly)
		]]
		arg2:ScaleTo(NumberValue_upvr.Value)
	end)
	TweenService_upvr:Create(NumberValue_upvr, TweenInfo.new(0.15, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
		Value = 0.01;
	}):Play()
	task.delay(0.15, function() -- Line 159
		--[[ Upvalues[2]:
			[1]: arg2 (readonly)
			[2]: NumberValue_upvr (readonly)
		]]
		arg2:Destroy()
		NumberValue_upvr:Destroy()
	end)
end
function any_CreateController_result1.starTouched(arg1, arg2, arg3) -- Line 165
	--[[ Upvalues[2]:
		[1]: LocalPlayer_upvr (readonly)
		[2]: var7_upvw (read and write)
	]]
	arg3.PrimaryPart.Touched:Connect(function(arg1_3) -- Line 166
		--[[ Upvalues[5]:
			[1]: LocalPlayer_upvr (copied, readonly)
			[2]: arg1 (readonly)
			[3]: arg2 (readonly)
			[4]: var7_upvw (copied, read and write)
			[5]: arg3 (readonly)
		]]
		if arg1_3.Parent ~= LocalPlayer_upvr.Character then
		else
			if tick() - (arg1._debounce[arg2] or 0) < 2 then return end
			arg1._debounce[arg2] = tick()
			if var7_upvw:claimStar(arg2) == "success" then
				arg1:starClaimed(arg3)
				arg1._stars[arg2] = nil
				arg1._debounce[arg2] = nil
			end
		end
	end)
end
local Assets_upvr = ReplicatedStorage_upvr.Assets
function any_CreateController_result1.createStar(arg1, arg2, arg3) -- Line 186
	--[[ Upvalues[2]:
		[1]: var10_upvw (read and write)
		[2]: Assets_upvr (readonly)
	]]
	local any_createItemFromData_result1 = var10_upvw.itemUtils.createItemFromData(arg2.item)
	local clone = Assets_upvr.Other.FallingStar:Clone()
	for _, v_3 in clone:GetDescendants() do
		if v_3:IsA("ParticleEmitter") then
			v_3.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, any_createItemFromData_result1:getColor()), ColorSequenceKeypoint.new(1, any_createItemFromData_result1:getColor())})
		elseif v_3:IsA("BasePart") then
			v_3.Color = any_createItemFromData_result1:getColor()
		end
	end
	clone:PivotTo(CFrame.new(arg3 + Vector3.new(math.random(-350, 350), 500, math.random(-350, 350))))
	clone.Parent = workspace.Debris
	return clone
end
function any_CreateController_result1.despawnStar(arg1, arg2) -- Line 211
	local var53 = arg1._stars[arg2]
	if not var53 then
	else
		var53:Destroy()
		arg1._stars[arg2] = nil
		arg1._debounce[arg2] = nil
	end
end
function any_CreateController_result1.spawnStar(arg1, arg2, arg3) -- Line 222
	local any_getSpawnPointVector_result1_upvr = arg1:getSpawnPointVector(arg3)
	local any_createStar_result1_upvr = arg1:createStar(arg3, any_getSpawnPointVector_result1_upvr)
	arg1._stars[arg2] = any_createStar_result1_upvr
	arg1:playAmbience(any_createStar_result1_upvr)
	arg1:tweenStar(any_createStar_result1_upvr, any_getSpawnPointVector_result1_upvr)
	task.delay(5, function() -- Line 231
		--[[ Upvalues[3]:
			[1]: arg1 (readonly)
			[2]: any_createStar_result1_upvr (readonly)
			[3]: any_getSpawnPointVector_result1_upvr (readonly)
		]]
		arg1:onLand(any_createStar_result1_upvr, any_getSpawnPointVector_result1_upvr)
	end)
	arg1:starTouched(arg2, any_createStar_result1_upvr)
end
function any_CreateController_result1.startEvent(arg1, arg2) -- Line 238
	--[[ Upvalues[1]:
		[1]: var6_upvw (read and write)
	]]
	if var6_upvw:getCurrentMap(true) == arg2 then
		var6_upvw:setClockTime(23.9)
	end
	arg1._activeMapId = arg2
end
function any_CreateController_result1.endEvent(arg1) -- Line 246
	--[[ Upvalues[1]:
		[1]: var6_upvw (read and write)
	]]
	if var6_upvw:getCurrentMap(true) == arg1._activeMapId then
		var6_upvw:setClockTime(9.7)
	end
	arg1._activeMapId = 0
end
function any_CreateController_result1.onMapChange(arg1) -- Line 254
	--[[ Upvalues[1]:
		[1]: var6_upvw (read and write)
	]]
	var6_upvw.onMapChange:Connect(function() -- Line 255
		--[[ Upvalues[2]:
			[1]: var6_upvw (copied, read and write)
			[2]: arg1 (readonly)
		]]
		if var6_upvw:getCurrentMap(true) ~= arg1._activeMapId then
		else
			task.wait()
			var6_upvw:setClockTime(23.9)
		end
	end)
end
function any_CreateController_result1.KnitStart(arg1) -- Line 265
	--[[ Upvalues[2]:
		[1]: var4_upvw (read and write)
		[2]: var7_upvw (read and write)
	]]
	task.spawn(function() -- Line 266
		--[[ Upvalues[3]:
			[1]: var4_upvw (copied, read and write)
			[2]: arg1 (readonly)
			[3]: var7_upvw (copied, read and write)
		]]
		var4_upvw:waitForData()
		arg1:onMapChange()
		var7_upvw.startEvent:Connect(function(...) -- Line 271
			--[[ Upvalues[1]:
				[1]: arg1 (copied, readonly)
			]]
			arg1:startEvent(...)
		end)
		var7_upvw.endEvent:Connect(function(...) -- Line 274
			--[[ Upvalues[1]:
				[1]: arg1 (copied, readonly)
			]]
			arg1:endEvent(...)
		end)
		var7_upvw.spawnStar:Connect(function(...) -- Line 277
			--[[ Upvalues[1]:
				[1]: arg1 (copied, readonly)
			]]
			arg1:spawnStar(...)
		end)
		var7_upvw.despawnStar:Connect(function(...) -- Line 280
			--[[ Upvalues[1]:
				[1]: arg1 (copied, readonly)
			]]
			arg1:despawnStar(...)
		end)
	end)
end
local var63_upvw
function any_CreateController_result1.KnitInit(arg1) -- Line 286
	--[[ Upvalues[11]:
		[1]: var7_upvw (read and write)
		[2]: Knit_upvr (readonly)
		[3]: var4_upvw (read and write)
		[4]: var5_upvw (read and write)
		[5]: var63_upvw (read and write)
		[6]: var6_upvw (read and write)
		[7]: var10_upvw (read and write)
		[8]: ReplicatedStorage_upvr (readonly)
		[9]: var11_upvw (read and write)
		[10]: var12_upvw (read and write)
		[11]: var13_upvw (read and write)
	]]
	var7_upvw = Knit_upvr.GetService("FallingStarsService")
	var4_upvw = Knit_upvr.GetController("DataController")
	var5_upvw = Knit_upvr.GetController("SoundController")
	var63_upvw = Knit_upvr.GetController("UIController")
	var6_upvw = Knit_upvr.GetController("MapController")
	var10_upvw = require(ReplicatedStorage_upvr.Shared.Util)
	var11_upvw = require(ReplicatedStorage_upvr.Shared.Functions)
	var12_upvw = require(ReplicatedStorage_upvr.Packages.Shake)
	var13_upvw = require(ReplicatedStorage_upvr.Packages.Zone)
end
return any_CreateController_result1