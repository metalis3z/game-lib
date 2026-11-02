-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:20:16
-- Luau version 6, Types version 3
-- Time taken: 0.007764 seconds

local Players_upvr = game:GetService("Players")
local RunService_upvr = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Functions_upvr = require(ReplicatedStorage.Shared.Functions)
local var5_upvw
local var6_upvw
local Assets_upvr = ReplicatedStorage.Assets
local module_2_upvr = {}
module_2_upvr.__index = module_2_upvr
local Trove_upvr = require(ReplicatedStorage.Packages.Trove)
function module_2_upvr.new() -- Line 24
	--[[ Upvalues[2]:
		[1]: module_2_upvr (readonly)
		[2]: Trove_upvr (readonly)
	]]
	local setmetatable_result1 = setmetatable({}, module_2_upvr)
	setmetatable_result1._trove = Trove_upvr.new()
	return setmetatable_result1
end
function module_2_upvr.getTrove(arg1) -- Line 32
	return arg1._trove
end
function module_2_upvr.setOwner(arg1, ...) -- Line 36
	arg1._owner = ...
end
function module_2_upvr.getOwner(arg1) -- Line 39
	return arg1._owner
end
function module_2_upvr.setItem(arg1, ...) -- Line 43
	arg1._item = ...
end
function module_2_upvr.getItem(arg1) -- Line 46
	return arg1._item
end
function module_2_upvr.setModel(arg1, ...) -- Line 50
	arg1._model = ...
end
function module_2_upvr.getModel(arg1) -- Line 53
	return arg1._model
end
function module_2_upvr.setTimeSpawnedAt(arg1) -- Line 57
	arg1._spawnedAt = tick()
end
function module_2_upvr.getTimeSpawnedAt(arg1) -- Line 60
	return arg1._spawnedAt
end
function module_2_upvr.setTimeSinceLand(arg1, arg2) -- Line 64
	local var11 = arg2
	if not var11 then
		var11 = tick()
	end
	arg1._timeSinceLand = var11
end
function module_2_upvr.getTimeSinceLand(arg1) -- Line 67
	return arg1._timeSinceLand
end
function module_2_upvr.setTimeSinceLastJump(arg1, arg2) -- Line 71
	local var12 = arg2
	if not var12 then
		var12 = tick()
	end
	arg1._timeSinceLastJump = var12
end
function module_2_upvr.getTimeSinceLastJump(arg1) -- Line 74
	return arg1._timeSinceLastJump
end
function module_2_upvr.setIsOnGround(arg1, arg2) -- Line 78
	arg1._isOnGround = arg2
end
function module_2_upvr.isOnGround(arg1) -- Line 81
	return arg1._isOnGround
end
function module_2_upvr.getLinearVelocity(arg1) -- Line 85
	return arg1._linearVelocity
end
function module_2_upvr.isSelf(arg1) -- Line 89
	--[[ Upvalues[1]:
		[1]: Players_upvr (readonly)
	]]
	local var13
	if arg1:getOwner() ~= Players_upvr.LocalPlayer then
		var13 = false
	else
		var13 = true
	end
	return var13
end
function module_2_upvr.setPlatformStand(arg1, arg2) -- Line 93
	--[[ Upvalues[1]:
		[1]: Functions_upvr (readonly)
	]]
	local any_getHumanoid_result1_4 = Functions_upvr.getHumanoid(arg1:getOwner())
	if not any_getHumanoid_result1_4 then
	else
		any_getHumanoid_result1_4.PlatformStand = arg2
	end
end
function module_2_upvr.setMassles(arg1, arg2) -- Line 102
	--[[ Upvalues[1]:
		[1]: Players_upvr (readonly)
	]]
	if arg1:getOwner() ~= Players_upvr.LocalPlayer then
	else
		for _, v_2 in arg1:getOwner().Character:GetDescendants() do
			if v_2:IsA("BasePart") then
				v_2.Massless = arg2
			end
		end
	end
end
function module_2_upvr.setDefaultSounds(arg1, arg2) -- Line 116
	--[[ Upvalues[1]:
		[1]: Functions_upvr (readonly)
	]]
	local any_getHRP_result1_3 = Functions_upvr.getHRP(arg1:getOwner())
	local var21
	if not any_getHRP_result1_3 then
	else
		if arg2 then
			var21 = 0.65
		else
			var21 = 0
		end
		any_getHRP_result1_3.Running.Volume = var21
	end
end
function module_2_upvr.createInstances(arg1) -- Line 125
	--[[ Upvalues[1]:
		[1]: Functions_upvr (readonly)
	]]
	local any_getHumanoid_result1_2 = Functions_upvr.getHumanoid(arg1:getOwner())
	if not any_getHumanoid_result1_2 then
	else
		local any_getHRP_result1_2 = Functions_upvr.getHRP(arg1:getOwner())
		if not any_getHRP_result1_2 then return end
		any_getHRP_result1_2.RootPriority = 1
		local any_getModel_result1 = arg1:getModel()
		if arg1:isSelf() then
			arg1:setPlatformStand(true)
			arg1:setMassles(true)
		end
		local cframe_2 = CFrame.new(0, -(any_getHRP_result1_2.Size.Y * 0.5 + any_getHumanoid_result1_2.HipHeight), 0)
		local cframe = CFrame.new(0, -any_getModel_result1.PrimaryPart.Size.Y / 2, 0)
		local Attachment = Instance.new("Attachment")
		Attachment.Name = "HoverboardAttachment"
		Attachment.CFrame = cframe_2 * cframe
		Attachment.Parent = any_getHRP_result1_2
		arg1._hoverboardAtt = Attachment
		any_getModel_result1:PivotTo(any_getHRP_result1_2.CFrame * cframe_2 * cframe)
		local AlignOrientation = Instance.new("AlignOrientation", any_getModel_result1.PrimaryPart)
		AlignOrientation.Mode = Enum.OrientationAlignmentMode.OneAttachment
		AlignOrientation.Attachment0 = Attachment
		AlignOrientation.MaxTorque = 25000000
		AlignOrientation.Responsiveness = 15
		AlignOrientation.CFrame = any_getHRP_result1_2.CFrame
		if arg1:isSelf() then
			local LinearVelocity = Instance.new("LinearVelocity", any_getHRP_result1_2)
			LinearVelocity.VelocityConstraintMode = Enum.VelocityConstraintMode.Line
			LinearVelocity.LineDirection = Vector3.new(0, 1, 0)
			LinearVelocity.LineVelocity = 0
			LinearVelocity.MaxForce = any_getHRP_result1_2:GetMass() * 5000
			LinearVelocity.RelativeTo = Enum.ActuatorRelativeTo.World
			LinearVelocity.Attachment0 = Attachment
			local LinearVelocity_2 = Instance.new("LinearVelocity")
			LinearVelocity_2.Name = "Move"
			LinearVelocity_2.MaxForce = 350
			LinearVelocity_2.Attachment0 = Attachment
			LinearVelocity_2.VelocityConstraintMode = Enum.VelocityConstraintMode.Plane
			LinearVelocity_2.SecondaryTangentAxis = Vector3.new(0, 0, 1)
			LinearVelocity_2.Parent = any_getHRP_result1_2
			local VectorForce = Instance.new("VectorForce")
			VectorForce.Attachment0 = Attachment
			VectorForce.Force = Vector3.new(0, any_getHRP_result1_2:GetMass() * 60, 0)
			VectorForce.Parent = any_getHRP_result1_2
			arg1._linearVelocity = LinearVelocity
			arg1._moveLinearVelocity = LinearVelocity_2
			arg1:getTrove():Add(LinearVelocity)
			arg1:getTrove():Add(LinearVelocity_2)
			arg1:getTrove():Add(VectorForce)
		end
		local WeldConstraint = Instance.new("WeldConstraint")
		WeldConstraint.Part0 = any_getHRP_result1_2
		WeldConstraint.Part1 = any_getModel_result1.PrimaryPart
		WeldConstraint.Parent = any_getModel_result1.PrimaryPart
		arg1:getTrove():Add(WeldConstraint)
		arg1:getTrove():Add(Attachment)
	end
end
function module_2_upvr.createVariables(arg1) -- Line 214
	--[[ Upvalues[1]:
		[1]: Players_upvr (readonly)
	]]
	arg1._speed = 0
	arg1:setTimeSpawnedAt()
	if arg1:getOwner() ~= Players_upvr.LocalPlayer then
	else
		arg1:setIsOnGround(true)
		arg1:setTimeSinceLand(0)
		arg1:setTimeSinceLastJump(0)
		arg1._tiltCFrame = CFrame.new(0, 0, 0)
	end
end
function module_2_upvr.createSound(arg1) -- Line 229
	--[[ Upvalues[1]:
		[1]: var5_upvw (read and write)
	]]
	local any_getSound_result1 = arg1:getItem():getSound()
	if not any_getSound_result1 then
	else
		var5_upvw:preloadSounds({"Equip Mount", "Mount Jump"})
		local any_play_result1 = var5_upvw:play(any_getSound_result1, {
			parent = arg1:getModel().PrimaryPart;
			looped = true;
			dontDestroy = true;
			rollOffMinDistance = 15;
			rollOffMaxDistance = 50;
			rollOffMode = Enum.RollOffMode.LinearSquare;
			overrideMute = true;
		})
		if not any_play_result1 then return end
		arg1._sound = any_play_result1
		arg1:getTrove():Add(any_play_result1)
	end
end
function module_2_upvr.createAnimation(arg1) -- Line 259
	--[[ Upvalues[2]:
		[1]: Functions_upvr (readonly)
		[2]: Assets_upvr (readonly)
	]]
	local any_getHumanoid_result1_5 = Functions_upvr.getHumanoid(arg1:getOwner())
	if not any_getHumanoid_result1_5 then
	else
		any_getHumanoid_result1_5.Animator:LoadAnimation(Assets_upvr.Animations[`Mount {Functions_upvr.toPascal(arg1:getItem():getAnimation())}`]):Play()
	end
end
function module_2_upvr.stopAnimation(arg1) -- Line 269
	--[[ Upvalues[1]:
		[1]: Functions_upvr (readonly)
	]]
	local any_getHumanoid_result1_3 = Functions_upvr.getHumanoid(arg1:getOwner())
	if not any_getHumanoid_result1_3 then
	else
		for _, v_3 in any_getHumanoid_result1_3:GetPlayingAnimationTracks() do
			if v_3.Name:find("Mount") then
				v_3:Stop()
				v_3:Destroy()
			end
		end
	end
end
local Knit_upvr = require(game:GetService("ReplicatedStorage").Packages.Knit)
function module_2_upvr.setup(arg1) -- Line 285
	--[[ Upvalues[4]:
		[1]: Assets_upvr (readonly)
		[2]: var5_upvw (read and write)
		[3]: Knit_upvr (readonly)
		[4]: var6_upvw (read and write)
	]]
	local clone = Assets_upvr.Mounts[arg1:getItem():getRealName()]:Clone()
	clone.Parent = workspace.Debris
	var5_upvw = Knit_upvr.GetController("SoundController")
	var6_upvw = Knit_upvr.GetController("DataController")
	arg1:setModel(clone)
	arg1:setDefaultSounds(false)
	arg1:createInstances()
	arg1:createVariables()
	arg1:createAnimation()
	arg1:createSound()
	arg1:getTrove():Add(clone)
end
function module_2_upvr.runOther(arg1) -- Line 305
	--[[ Upvalues[3]:
		[1]: RunService_upvr (readonly)
		[2]: var6_upvw (read and write)
		[3]: Functions_upvr (readonly)
	]]
	arg1:getTrove():Add(RunService_upvr.RenderStepped:Connect(function(arg1_2) -- Line 306
		--[[ Upvalues[3]:
			[1]: var6_upvw (copied, read and write)
			[2]: Functions_upvr (copied, readonly)
			[3]: arg1 (readonly)
		]]
		local any_getData_result1 = var6_upvw:getData()
		if not any_getData_result1 then
		else
			local any_getHRP_result1 = Functions_upvr.getHRP(arg1:getOwner())
			if not any_getHRP_result1 then return end
			arg1._speed = Functions_upvr.lerp(arg1._speed, math.max(any_getHRP_result1.AssemblyLinearVelocity.Magnitude / 70, 0.001), arg1_2 * 100)
			local var49
			if arg1._sound then
				var49 = arg1
				var49 = 2
				arg1._sound.PlaybackSpeed = math.clamp(var49._speed * 2, 1.25, var49)
				var49 = arg1
				local _speed = var49._speed
				var49 = any_getData_result1.settings.muteSounds
				if var49 then
					_speed = 0
				else
					_speed = 0.1
				end
				if any_getData_result1.settings.muteSounds then
					var49 = 0
				else
					var49 = 0.4
				end
				arg1._sound.Volume = math.clamp(_speed / 2.5, _speed, var49)
			end
		end
	end))
end
function module_2_upvr.getRaycastFilter(arg1) -- Line 328
	--[[ Upvalues[1]:
		[1]: Players_upvr (readonly)
	]]
	local module = {arg1:getModel(), workspace.Game.Pets, workspace.Debris}
	for _, v in Players_upvr:GetPlayers() do
		if v.Character then
			module[#module + 1] = v.Character
		end
	end
	return module
end
function module_2_upvr.getRaycastParams(arg1) -- Line 346
	local RaycastParams_new_result1 = RaycastParams.new()
	RaycastParams_new_result1.IgnoreWater = true
	RaycastParams_new_result1.FilterType = Enum.RaycastFilterType.Exclude
	RaycastParams_new_result1.FilterDescendantsInstances = arg1:getRaycastFilter()
	RaycastParams_new_result1.RespectCanCollide = true
	return RaycastParams_new_result1
end
function module_2_upvr.isAllowedToJump(arg1, arg2) -- Line 356
	if not arg2 then return end
	if 0 < arg1:getLinearVelocity().LineVelocity then return end
	if tick() - arg1:getTimeSpawnedAt() < 0.1 then return end
	if tick() - arg1:getTimeSinceLastJump() < 0.5 then return end
	if tick() - arg1:getTimeSinceLand() < 0.075 then return end
	return true
end
function module_2_upvr.runSelf(arg1) -- Line 381
	--[[ Upvalues[4]:
		[1]: RunService_upvr (readonly)
		[2]: var6_upvw (read and write)
		[3]: Functions_upvr (readonly)
		[4]: var5_upvw (read and write)
	]]
	arg1:getTrove():Add(RunService_upvr.RenderStepped:Connect(function(arg1_3) -- Line 382
		--[[ Upvalues[4]:
			[1]: var6_upvw (copied, read and write)
			[2]: Functions_upvr (copied, readonly)
			[3]: arg1 (readonly)
			[4]: var5_upvw (copied, read and write)
		]]
		-- KONSTANTERROR: [0] 1. Error Block 1 start (CF ANALYSIS FAILED)
		-- KONSTANTERROR: [0] 1. Error Block 1 end (CF ANALYSIS FAILED)
		-- KONSTANTERROR: [5] 5. Error Block 2 start (CF ANALYSIS FAILED)
		do
			return
		end
		-- KONSTANTERROR: [5] 5. Error Block 2 end (CF ANALYSIS FAILED)
		-- KONSTANTERROR: [6] 6. Error Block 3 start (CF ANALYSIS FAILED)
		-- KONSTANTERROR: [6] 6. Error Block 3 end (CF ANALYSIS FAILED)
	end))
end
function module_2_upvr.run(arg1) -- Line 491
	--[[ Upvalues[1]:
		[1]: var5_upvw (read and write)
	]]
	var5_upvw:play("Equip Mount", {
		volume = 0.3;
		parent = arg1:getModel().PrimaryPart;
		rollOffMinDistance = 15;
		rollOffMaxDistance = 40;
		rollOffMode = Enum.RollOffMode.LinearSquare;
	})
	if arg1:isSelf() then
		arg1:runSelf()
	else
		arg1:runOther()
	end
end
function module_2_upvr.remove(arg1) -- Line 507
	--[[ Upvalues[1]:
		[1]: Functions_upvr (readonly)
	]]
	if arg1:isSelf() then
		local any_getHumanoid_result1 = Functions_upvr.getHumanoid(arg1:getOwner())
		if not any_getHumanoid_result1 then return end
		any_getHumanoid_result1:SetStateEnabled(Enum.HumanoidStateType.Jumping, true)
	end
	arg1:setPlatformStand(false)
	arg1:setMassles(false)
	arg1:setDefaultSounds(true)
	arg1:stopAnimation()
	arg1:getTrove():Destroy()
end
return module_2_upvr