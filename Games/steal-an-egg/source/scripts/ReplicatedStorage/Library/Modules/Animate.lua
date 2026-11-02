-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Trove = require(ReplicatedStorage.Library.Modules.Packages.Trove)
local Asserts = require(ReplicatedStorage.Library.Asserts)
local AnimationData = require(script.Private.AnimationData)
local v1 = require(ReplicatedStorage.Library.Modules.Packages.Log).new():LimitUnderLevel("Warning")
local TableUtil = require(ReplicatedStorage.Library.Modules.Packages.TableUtil)
local Types = require(script.Private.Types)
local Pipeline = require(ReplicatedStorage.Directory.Animations.Pipeline)
local Constants = require(ReplicatedStorage.Library.Globals.Constants)

require(script.Types.Interface)

local AnimationStatesMap = require(script.Private.AnimationStatesMap)
local Constants2 = require(script.Private.Constants)
local AnimNameToState = require(script.Private.AnimNameToState)
local t = {
	AnimationData = AnimationData
}

t.__index = t

local ok, result = pcall(function() --[[ Line: 35 ]]
	return UserSettings():IsUserFeatureEnabled("UserNoUpdateOnLoop")
end)
local v2 = ok and result
local ok2, result2 = pcall(function() --[[ Line: 40 ]]
	return UserSettings():IsUserFeatureEnabled("UserAnimateScaleRun")
end)
local v3 = ok2 and result2
local Assets = script:WaitForChild("Assets")
local ScaleDampeningPercent = Assets:FindFirstChild("ScaleDampeningPercent")
local v4 = newproxy()

local function DestroyAndStopAnimationTrack(p1, p2) --[[ DestroyAndStopAnimationTrack | Line: 51 | Upvalues: v1 (copy) ]]
	v1:AtDebug():Log((("Destroying animation track: \"%*\" with transition time: %*"):format(p1.Name, p2)))
	p1:Stop(p2)
	p1:Destroy()
end

function t.SafeLoadAnimation(p1, p2) --[[ SafeLoadAnimation | Line: 58 | Upvalues: Asserts (copy), v1 (copy) ]]
	Asserts.Animation(p1)
	Asserts.Animator(p2)

	local ok, result = pcall(function() --[[ Line: 62 | Upvalues: p2 (copy), p1 (copy) ]]
		return p2:LoadAnimation(p1)
	end)

	if ok and result then
		return result
	end

	v1:AtWarning():Log((("Failed to load animation \"%*\": %*"):format(p1.Name, result)))

	return nil
end
function t.ConfigureAnimationSetAndLoadAnims(p1, p2, p3) --[[ ConfigureAnimationSetAndLoadAnims | Line: 74 | Upvalues: Asserts (copy), Pipeline (copy), t (copy) ]]
	Asserts.table(p1)
	Asserts.Animator(p2)
	Asserts.optional.enum(p3)

	local t2 = {
		count = 0,
		totalWeight = 0
	}

	for i, v in ipairs(p1) do
		local t3 = {}
		local anim = v.anim
		local v1 = if anim then anim else Pipeline:GetAndSerializeAnimation(v.id)

		t2[i] = t3
		t3.anim = v1
		t3.looped = v.looped
		t3.weight = v.weight
		t3.priority = if p3 then p3 else Enum.AnimationPriority.Core

		local v3 = t.SafeLoadAnimation(v1, p2)

		if v3 then
			t3.animTrack = v3
			v3.Priority = t3.priority
		end

		t2.count = t2.count + 1
		t2.totalWeight = t2.totalWeight + v.weight
	end

	return t2
end
function t.RollFromCustomSet(p1) --[[ RollFromCustomSet | Line: 113 | Upvalues: Asserts (copy) ]]
	Asserts.table(p1)
	assert(p1.count > 0, "Cannot roll from an empty custom animation set")
	assert(p1.totalWeight > 0, "Cannot roll from an empty custom animation set with zero total weight")

	local sum = math.random(1, p1.totalWeight)
	local count = 1

	while p1[count].weight < sum do
		sum = sum - p1[count].weight
		count = count + 1
	end

	return p1[count]
end
function t.new(p1, p2, p3, p4) --[[ new | Line: 129 | Upvalues: Asserts (copy), Trove (copy), v3 (copy), AnimationData (copy), Assets (copy), Pipeline (copy), TableUtil (copy), Types (copy), Constants2 (copy), ScaleDampeningPercent (ref), v1 (copy), v2 (copy), DestroyAndStopAnimationTrack (copy), v4 (copy), AnimNameToState (copy), AnimationStatesMap (copy), Constants (copy), RunService (copy) ]]
	Asserts.Model(p1)
	Asserts.optional.table(p2)
	Asserts.optional.table(p3)
	Asserts.optional.Animator(p4)

	local t = {
		AnimationPool = {}
	}
	local v12 = Trove.new()
	local Humanoid = p1:WaitForChild("Humanoid")
	local v22 = if p4 then p4 else Humanoid:WaitForChild("Animator")
	local HumanoidRootPart = p1:WaitForChild("HumanoidRootPart")
	local v32 = v22:Clone()

	v32.Parent = v22.Parent
	v22:Destroy()

	for i, v in ipairs(v32:GetPlayingAnimationTracks()) do
		v:Stop()
		v:Destroy()
	end

	t.Animator = v32

	local function getRigScale() --[[ getRigScale | Line: 158 | Upvalues: v3 (ref), p1 (copy) ]]
		if v3 then
			return p1:GetScale()
		end

		return 1
	end

	local v42 = ""
	local v5 = nil
	local v6 = nil
	local v7 = nil
	local v8 = nil
	local v9 = 1
	local v10 = nil
	local v11 = nil
	local t2 = {}
	local t3 = {}
	local v122 = p2 or AnimationData
	local v13 = "Standing"
	local v14 = if v122.Normal then "Normal" else "Default"
	local v15 = OverlapParams.new()

	v15.FilterDescendantsInstances = { p1 }
	v15.MaxParts = 5
	math.randomseed(tick())

	local function getAnimationPoolBasedOnMaster(p1, p2) --[[ getAnimationPoolBasedOnMaster | Line: 190 | Upvalues: Asserts (ref), t3 (ref), v14 (ref) ]]
		Asserts.string(p1)
		Asserts.optional.table(p2)

		local v1 = if p2 then p2 else t3[v14]

		return if v1 then v1[p1] else v1
	end

	local function getAnimationPoolBasedOnMasterAssert(p1, p2) --[[ getAnimationPoolBasedOnMasterAssert | Line: 198 | Upvalues: Asserts (ref), t3 (ref), v14 (ref) ]]
		Asserts.string(p1)
		Asserts.optional.table(p2)

		local v1 = if p2 then p2 else t3[v14]
		local v2 = if v1 then v1[p1] else v1

		return assert(v2, (("Invalid animation \"%*\", file not found."):format(p1)))
	end

	local function isAnimationSetEmpty(p1, p2) --[[ isAnimationSetEmpty | Line: 202 | Upvalues: Asserts (ref), t3 (ref), v14 (ref) ]]
		Asserts.string(p1)
		Asserts.optional.table(p2)

		local v1 = if p2 then p2 else t3[v14]
		local v4 = assert(if v1 then v1[p1] else v1, (("Invalid animation \"%*\", file not found."):format(p1)))

		return not v4 or next(v4) == nil
	end

	local function getWrappedProtocol(p1, p2, ...) --[[ getWrappedProtocol | Line: 207 | Upvalues: Asserts (ref) ]]
		Asserts.string(p2)

		local v1 = if p1 then p1.protocol and p1.protocol[p2] else p1

		if typeof(v1) == "table" and next(v1) then
			return v1
		end

		return { ... }
	end

	local function getAndUnwrapProtocol(p1, p2, ...) --[[ getAndUnwrapProtocol | Line: 218 | Upvalues: getWrappedProtocol (copy) ]]
		return unpack((getWrappedProtocol(p1, p2, ...)))
	end

	local function configureAnimationSet(p1, p2, p3) --[[ configureAnimationSet | Line: 223 | Upvalues: Asserts (ref), t3 (ref), v12 (copy), Assets (ref), Pipeline (ref), TableUtil (ref), t2 (ref), v32 (copy) ]]
		Asserts.optional.table(p3)

		local v1 = if p3 then p3 else t3
		local v2 = v1[p1]

		if v2 ~= nil and v2.connections then
			v2.connections:Clean()
		end

		local t = {}

		v1[p1] = t
		t.count = 0
		t.totalWeight = 0
		t.connections = v12:Extend()
		Assets:FindFirstChild(p1)

		local v3

		if t.count <= 0 then
			v3 = v1

			for i, v in ipairs(p2) do
				local t4 = {}
				local v4 = if v2 then v2[i] else v2
				local anim = v.anim
				local v5 = if anim then anim else Pipeline:GetAndSerializeAnimation(v.id)

				t[i] = t4
				t4.anim = v5
				t4.protocol = v4 and v4.protocol or v.protocol and TableUtil.Copy(v.protocol, true)
				t4.looped = v.looped
				v5.Name = p1
				t4.weight = v.weight
				t.count = t.count + 1
				t.totalWeight = t.totalWeight + v.weight
			end
		else
			v3 = v1
		end

		for k, v in pairs(v3) do
			if v.count then
				for i = 1, v.count do
					local v7 = v[i]

					if v7 and (v7.anim and v7.anim.AnimationId) then
						local anim = v7.anim
						local AnimationId = anim.AnimationId

						if t2[AnimationId] == nil then
							local ok, result = pcall(function() --[[ Line: 323 | Upvalues: v32 (ref), anim (copy) ]]
								v32:LoadAnimation(anim)
							end)

							if ok then
								t2[AnimationId] = true

								continue
							end

							warn("Failed to load animation with AnimationId:", AnimationId, "-", result)
						end

						continue
					end

					warn("Animation data is missing or invalid at index:", i)
				end
			end
		end
	end

	local function isAnimationSetPattern(p1) --[[ isAnimationSetPattern | Line: 339 | Upvalues: Asserts (ref) ]]
		Asserts.table(p1)

		local v1 = select(2, next(p1))

		return if typeof(v1) == "table" then if typeof(v1.id) == "string" then true else typeof(v1.anim) == "Instance" else false
	end

	local function v16(p1, p2) --[[ deepConfigureAnimationSetUnsafe | Line: 346 | Upvalues: Types (ref), t (copy), isAnimationSetPattern (copy), v16 (copy), configureAnimationSet (copy) ]]
		assert(Types.configureAnimationSetParameters(p1, p2))

		local v1 = if typeof(p2) == "table" and p2 then p2 else t.AnimationPool[p2]

		if not v1 then
			v1 = {}
			t.AnimationPool[p2] = v1
		end

		for v2, v3 in p1 do
			if typeof(v3) == "table" then
				if isAnimationSetPattern(v3) then
					configureAnimationSet(v2, v3, v1)

					continue
				end

				local t2 = {}

				v1[v2] = t2
				v16(v3, t2)
			end
		end
	end

	local function scriptChildModified(p1) --[[ scriptChildModified | Line: 375 | Upvalues: v122 (ref), configureAnimationSet (copy) ]]
		local v1 = v122[p1.Name]

		if v1 == nil then
			return
		end

		configureAnimationSet(p1.Name, v1)
	end

	local v17 = "None"
	local v18 = 0
	local v19 = 0
	local v20 = 0.1
	local v21 = 0.2
	local v222 = false

	local function stopAllAnimations() --[[ stopAllAnimations | Line: 395 | Upvalues: v42 (ref), v222 (ref), v5 (ref), v8 (ref), v12 (copy), v6 (ref), v11 (ref), v10 (ref) ]]
		local v1 = v42

		if v222 then
			v1 = "idle"
		end

		v42 = ""
		v5 = nil

		if v8 ~= nil then
			v12:Remove(v8)
		end

		if v6 ~= nil and not v222 then
			v12:Remove(v6)
			v6 = nil
		end

		if v11 ~= nil then
			v12:Remove(v11)
		end

		if v10 == nil then
			return v1
		end

		v12:Remove(v10)
		v10 = nil

		return v1
	end

	local function getHeightScale() --[[ getHeightScale | Line: 428 | Upvalues: Humanoid (copy), getRigScale (copy), Constants2 (ref), ScaleDampeningPercent (ref), Assets (ref) ]]
		if not Humanoid then
			return getRigScale()
		end

		if not Humanoid.AutomaticScalingEnabled then
			return getRigScale()
		end

		local v1 = Humanoid.HipHeight / Constants2.HUMANOID_HIP_HEIGHT

		if ScaleDampeningPercent == nil then
			ScaleDampeningPercent = Assets:FindFirstChild("ScaleDampeningPercent")
		end

		if ScaleDampeningPercent ~= nil then
			v1 = 1 + (Humanoid.HipHeight - Constants2.HUMANOID_HIP_HEIGHT) * ScaleDampeningPercent.Value / Constants2.HUMANOID_HIP_HEIGHT
		end

		return v1
	end

	local function rootMotionCompensation(p1) --[[ rootMotionCompensation | Line: 451 | Upvalues: getHeightScale (copy) ]]
		return p1 * 1.25 / getHeightScale()
	end

	local function setRunSpeed(p1) --[[ setRunSpeed | Line: 459 | Upvalues: getHeightScale (copy), v6 (ref), v10 (ref) ]]
		local v1 = p1 * 1.25 / getHeightScale()
		local v2 = 0.0001
		local v3 = v1 / 0.5
		local v4 = v1 / 1
		local v5

		if v1 <= 0.5 then
			v2 = 1
			v5 = 0.0001
		elseif v1 < 1 then
			local v62 = (v1 - 0.5) / 0.5

			v2 = 1 - v62
			v3 = 1
			v5 = v62
			v4 = 1
		else
			v5 = 1
		end

		v6:AdjustWeight(v2)
		v6:AdjustSpeed(v3)

		if v10 then
			v10:AdjustWeight(v5)
			v10:AdjustSpeed(v4)
		end
	end

	local function setAnimationSpeed(p1) --[[ setAnimationSpeed | Line: 491 | Upvalues: v42 (ref), setRunSpeed (copy), v9 (ref), v6 (ref) ]]
		if v42 == "walk" then
			setRunSpeed(p1)

			return
		end

		if p1 == v9 then
			return
		end

		v9 = p1
		v6:AdjustSpeed(p1)
	end

	local function keyFrameReachedFunc() --[[ keyFrameReachedFunc | Line: 502 | Upvalues: v1 (ref), v222 (ref), v6 (ref), t (copy), v13 (ref) ]]
		v1:AtTrace():Log((("reseting the anima: currentlyPlayingEmote %*, Looped: %*"):format(v222, v6.Looped)))

		if not v222 then
			t.playAnimation("idle", 0.1)
			v13 = "Standing"

			return
		end

		if v6.Looped then
			return
		end

		v222 = false

		return t.switchToLatestCoreAnimation()
	end

	local function rollAnimation(p1, p2) --[[ rollAnimation | Line: 519 | Upvalues: Asserts (ref), t3 (ref), v14 (ref) ]]
		Asserts.string(p1)
		Asserts.optional.table(p2)
		Asserts.string(p1)
		Asserts.optional.table(p2)

		local v1 = if p2 then p2 else t3[v14]
		local v4 = assert(if v1 then v1[p1] else v1, (("Invalid animation \"%*\", file not found."):format(p1)))
		local sum = math.random(1, v4.totalWeight)
		local count = 1

		while v4[count].weight < sum do
			sum = sum - v4[count].weight
			count = count + 1
		end

		return v4[count]
	end

	local function switchToAnim(p1, p2, p3, p4, p5, p6, p7) --[[ switchToAnim | Line: 535 | Upvalues: v5 (ref), v6 (ref), v1 (ref), getAndUnwrapProtocol (copy), v7 (ref), v12 (copy), v10 (ref), v2 (ref), v9 (ref), v32 (copy), v8 (ref), DestroyAndStopAnimationTrack (ref), keyFrameReachedFunc (copy), v42 (ref), Asserts (ref), t3 (ref), v14 (ref), rollAnimation (copy), v11 (ref) ]]
		if p1 == v5 then
			return v6
		end

		local Core = Enum.AnimationPriority.Core

		if v6 ~= nil then
			v1:AtDebug():Log("[removing] the current animation protocol:", getAndUnwrapProtocol(v7, "Stop", p4, Core))
			v1:AtDebug():Log("[playing] the current animation protocol:", getAndUnwrapProtocol(p3, "Play", p4, p5, p6))
			v12:Remove(v6, getAndUnwrapProtocol(v7, "Stop", p4), Core, p7)
		end

		if v10 ~= nil then
			v12:Remove(v10, p4)

			if v2 == true then
				v10 = nil
			end
		end

		v9 = 1

		local ok, result = pcall(function() --[[ Line: 574 | Upvalues: v32 (ref), p1 (copy) ]]
			return v32:LoadAnimation(p1)
		end)

		if v8 ~= nil then
			v12:Remove(v8)
			v8 = nil
		end

		v1:AtDebug():Log("Is current animation looped:", p3 and p3.looped or nil, "currentAnimInstance:", v5, "currentID:", v5 and v5.AnimationId, "new anim:", p1, "new id;", p1.AnimationId, "equal:", if p1 == v5 then true else false, "traceback:", debug.traceback())

		if ok then
			v1:AtDebug():Log((("Switching from \"%*\" to \"%*\". (assetID): \"%*\""):format(v5 and v5.Name, if p1 then p1.Name else p1, p1.AnimationId)))
			v6 = v12:Add(result, DestroyAndStopAnimationTrack)
			v7 = p3

			if p3 and p3.looped ~= nil then
				v6.Looped = p3.looped
			end

			v6.Priority = Core
			v6:Play(getAndUnwrapProtocol(p3, "Play", p4, p5, p6))
			v8 = v12:Connect(v6.DidLoop, keyFrameReachedFunc)
		end

		v42 = p2
		v5 = p1

		if p2 ~= "walk" then
			return v6
		end

		Asserts.string("run")
		Asserts.optional.table(nil)

		local v16 = t3[v14]
		local v18 = assert(if v16 then v16.run else v16, "Invalid animation \"run\", file not found.")

		if not v18 or next(v18) == nil then
			return v6
		end

		local ok2, result2 = pcall(v32.LoadAnimation, v32, rollAnimation("run").anim)

		if not ok2 then
			return v6
		end

		v10 = v12:Add(result2, DestroyAndStopAnimationTrack)
		v10.Priority = Enum.AnimationPriority.Core
		v10:Play(p4)

		if v11 ~= nil then
			v12:Remove(v11)
		end

		v11 = v12:Connect(v10.DidLoop, keyFrameReachedFunc)

		return v6
	end

	function t.playAnimationNonCore(p1, p2, p3, p4, p5) --[[ playAnimationNonCore | Line: 642 | Upvalues: t (copy), rollAnimation (copy), v32 (copy), v1 (ref), getAndUnwrapProtocol (copy) ]]
		local v2 = rollAnimation(p1, typeof(p5) == "string" and t.AnimationPool[p5] or (if p5 then p5 else nil))
		local ok, result = pcall(v32.LoadAnimation, v32, v2.anim)

		if ok then
			result.Priority = Enum.AnimationPriority.Action4
			result:Play(getAndUnwrapProtocol(v2, "Play", p2, p3, p4))

			return result
		end

		return v1:AtWarning():Log((("Failed to load animation: \"%*\""):format(result)))
	end
	function t.playAnimation(p1, p2, p3, p4, p5, p6, p7, p8) --[[ playAnimation | Line: 669 | Upvalues: t (copy), rollAnimation (copy), switchToAnim (copy), v4 (ref), v222 (ref) ]]
		local v2 = rollAnimation(p1, typeof(p5) == "string" and t.AnimationPool[p5] or (if p5 then p5 else nil))

		v222 = if p6 == nil then v222 else p6

		return switchToAnim(v2.anim, (p8 or p5) and v4 or p1, v2, p2, p3, p4, p7)
	end
	function t.switchToLatestCoreAnimation(...) --[[ switchToLatestCoreAnimation | Line: 703 | Upvalues: t (copy), v42 (ref) ]]
		local t2 = { ... }

		t.playAnimation(v42, t2[1], t2[2], t2[3], t2[4], t2[5], true)
	end

	local function playEmote(p1, p2, p3, p4) --[[ playEmote | Line: 708 | Upvalues: Asserts (ref), t3 (ref), v14 (ref), switchToAnim (copy), v222 (ref) ]]
		Asserts.string(p1)
		Asserts.string(p1)
		Asserts.optional.table(nil)

		local v1 = t3[v14]
		local v4 = assert(if v1 then v1[p1] else v1, (("Invalid animation \"%*\", file not found."):format(p1)))[1]

		Asserts.table(v4)
		switchToAnim(v4.anim, p1, v4, p2, p3, p4)
		v222 = true
	end

	local function changeGlobalStateMaster(p1, p2) --[[ changeGlobalStateMaster | Line: 722 | Upvalues: Asserts (ref), t3 (ref), v14 (ref), v42 (ref), t (copy) ]]
		Asserts.string(p1)
		assert(t3[p1], (("Failed to change master animation state - Master \"%*\" not found"):format(p1)))
		v14 = p1

		if p2 then
			v42 = nil
			t.playAnimation(v42)
		end
	end

	local v23 = ""
	local v24 = nil
	local v25 = nil
	local v26 = nil

	local function toolKeyFrameReachedFunc(p1) --[[ toolKeyFrameReachedFunc | Line: 743 | Upvalues: t (copy), v23 (ref) ]]
		if p1 ~= "End" then
			return
		end

		t.playToolAnimation(v23, 0)
	end

	function t.playToolAnimation(p1, p2, p3) --[[ playToolAnimation | Line: 749 | Upvalues: rollAnimation (copy), v25 (ref), v24 (ref), v12 (copy), v32 (copy), DestroyAndStopAnimationTrack (ref), v23 (ref), v26 (ref), toolKeyFrameReachedFunc (copy) ]]
		local anim = rollAnimation(p1).anim

		if v25 == anim then
			return
		end

		if v24 ~= nil then
			v12:Remove(v24)
			p2 = 0
		end

		v24 = v12:Add(v32:LoadAnimation(anim), DestroyAndStopAnimationTrack)

		if p3 then
			v24.Priority = p3
		end

		v24:Play(p2)
		v23 = p1
		v25 = anim
		v26 = v12:Connect(v24.KeyframeReached, toolKeyFrameReachedFunc)
	end

	local function stopToolAnimations() --[[ stopToolAnimations | Line: 774 | Upvalues: v23 (ref), v26 (ref), v12 (copy), v25 (ref), v24 (ref) ]]
		local v1 = v23

		if v26 ~= nil then
			v12:Remove(v26)
		end

		v23 = ""
		v25 = nil

		if v24 == nil then
			return v1
		end

		v12:Remove(v24)
		v24 = nil

		return v1
	end

	local t4 = {
		onRunning = function() --[[ onRunning | Line: 796 | Upvalues: v13 (ref), v19 (ref), HumanoidRootPart (copy), Humanoid (copy), v15 (copy), Constants2 (ref), t (copy) ]]
			if v13 == "Jumping" and v19 > 0 then
				return
			end

			local zero = Vector2.zero
			local v1

			if HumanoidRootPart then
				local v4 = HumanoidRootPart.Position - Vector3.new(0, 1, 0) * (Humanoid.HipHeight + HumanoidRootPart.Size.Y / 2)
				local v5 = workspace:GetPartBoundsInRadius(v4, 1, v15)
				local AssemblyLinearVelocity = HumanoidRootPart.AssemblyLinearVelocity
				local t2 = {}

				for v6, v7 in v5 do
					local v9 = assert(if v7:IsA("BasePart") then v7.AssemblyRootPart else nil, "Expected part to be a BasePart with an AssemblyRootPart")

					if not t2[v9] then
						AssemblyLinearVelocity = AssemblyLinearVelocity - v9:GetVelocityAtPosition(v4)
						t2[v9] = true
					end
				end

				local v10 = HumanoidRootPart.CFrame

				v1 = Vector2.new(v10.RightVector:Dot(AssemblyLinearVelocity), (v10.LookVector:Dot(AssemblyLinearVelocity))).Magnitude
			else
				v1 = 0
			end

			if not (Constants2.LOCOMOTION_SPEED_EPSILON < v1) then
				t.playAnimation("idle", 0.2)
				v13 = "Standing"

				return
			end

			local v132 = t.playAnimation("walk", 0.2)

			if v132 then
				v132:AdjustSpeed(1)
				v132:AdjustWeight(1, 0.2)
			end

			v13 = "Running"
		end,
		onJumping = function() --[[ onJumping | Line: 849 | Upvalues: t (copy), Humanoid (copy), v19 (ref), v13 (ref), v1 (ref) ]]
			local v12 = t.playAnimation("jump", 0.1)
			local v3 = 2 * (Humanoid.JumpPower or 50) / (workspace.Gravity or 196.2)
			local v4 = if v12 then v12.Length or v3 else v3

			v19 = math.min(v4, v3)
			v13 = "Jumping"
			v1:AtDebug():Log((("jumpAnimTime set to %*, actual clip length: %*, raw airtime: %*"):format(v19, v4, v3)))
		end,
		onClimbing = function(p1) --[[ onClimbing | Line: 866 | Upvalues: v3 (ref), getHeightScale (copy), t (copy), v42 (ref), setRunSpeed (copy), v9 (ref), v6 (ref), v13 (ref) ]]
			if v3 then
				p1 = p1 / getHeightScale()
			end

			t.playAnimation("climb", 0.1)

			local v1 = p1 / 5

			if v42 == "walk" then
				setRunSpeed(v1)
			else
				if v1 == v9 then
					v13 = "Climbing"

					return
				end

				v9 = v1
				v6:AdjustSpeed(v1)
			end

			v13 = "Climbing"
		end,
		onFreeFall = function() --[[ onFreeFall | Line: 876 | Upvalues: v19 (ref), t (copy), v21 (ref), v13 (ref) ]]
			if v19 <= 0 then
				t.playAnimation("fall", v21)
			end

			v13 = "FreeFall"
		end,
		onDied = function() --[[ onDied | Line: 883 | Upvalues: v13 (ref) ]]
			v13 = "Dead"
		end,
		onGettingUp = function() --[[ onGettingUp | Line: 886 | Upvalues: v13 (ref) ]]
			v13 = "GettingUp"
		end,
		onFallingDown = function() --[[ onFallingDown | Line: 889 | Upvalues: v13 (ref) ]]
			v13 = "FallingDown"
		end,
		onSeated = function() --[[ onSeated | Line: 892 | Upvalues: v13 (ref) ]]
			v13 = "Seated"
		end,
		onPlatformStanding = function() --[[ onPlatformStanding | Line: 895 | Upvalues: v13 (ref) ]]
			v13 = "PlatformStanding"
		end,
		onSwimming = function(p1) --[[ onSwimming | Line: 899 | Upvalues: v3 (ref), getHeightScale (copy), t (copy), v42 (ref), setRunSpeed (copy), v9 (ref), v6 (ref), v13 (ref) ]]
			if v3 then
				p1 = p1 / getHeightScale()
			end

			if not (p1 > 1) then
				t.playAnimation("swimidle", 0.4)
				v13 = "Standing"

				return
			end

			t.playAnimation("swim", 0.4)

			local v1 = p1 / 10

			if v42 == "walk" then
				setRunSpeed(v1)
			elseif v1 ~= v9 then
				v9 = v1
				v6:AdjustSpeed(v1)
			end

			v13 = "Swimming"
		end
	}

	local function animateTool() --[[ animateTool | Line: 916 | Upvalues: v17 (ref), t (copy), v20 (ref) ]]
		if v17 == "None" then
			t.playToolAnimation("toolnone", v20, Enum.AnimationPriority.Idle)

			return
		end

		if v17 == "Slash" then
			t.playToolAnimation("toolslash", 0, Enum.AnimationPriority.Action)

			return
		end

		if v17 == "Lunge" then
			t.playToolAnimation("toollunge", 0, Enum.AnimationPriority.Action)
		end
	end

	local function getToolAnim(p1) --[[ getToolAnim | Line: 933 ]]
		for i, v in ipairs(p1:GetChildren()) do
			if v.Name == "toolanim" and v.className == "StringValue" then
				return v
			end
		end

		return nil
	end

	local function stepAnimate(p12) --[[ stepAnimate | Line: 942 | Upvalues: v1 (ref), v19 (ref), v13 (ref), t (copy), v21 (ref), stopAllAnimations (copy), p1 (copy), getToolAnim (copy), v17 (ref), animateTool (copy), v23 (ref), v26 (ref), v12 (copy), v25 (ref), v24 (ref), v18 (ref) ]]
		if not p12 then
			return
		end

		v1:AtDebug():Log((("stepAnimate called at, deltaTime: %*, jumpAnimTime: %*, pose: %*"):format(p12, v19, v13)))

		if v19 > 0 then
			v19 = -p12
		end

		if v13 == "FreeFall" and v19 <= 0 then
			t.playAnimation("fall", v21)
		else
			if v13 == "Seated" then
				t.playAnimation("sit", 0.5)

				return
			end

			if v13 == "Running" then
				t.playAnimation("walk", 0.2)
			elseif v13 == "Dead" or (v13 == "GettingUp" or (v13 == "FallingDown" or (v13 == "Seated" or v13 == "PlatformStanding"))) then
				stopAllAnimations()
			end
		end

		local Tool = p1:FindFirstChildOfClass("Tool")

		if Tool and Tool:FindFirstChild("Handle") then
			local v14 = getToolAnim(Tool)

			if v14 then
				v17 = v14.Value
				v14.Parent = nil
			end

			animateTool()
		else
			if v26 ~= nil then
				v12:Remove(v26)
			end

			v23 = ""
			v25 = nil

			if v24 ~= nil then
				v12:Remove(v24)
				v24 = nil
			end

			v17 = "None"
			v25 = nil
			v18 = 0
		end
	end

	t.stopAllAnimations = stopAllAnimations
	t.setAnimationSpeed = setAnimationSpeed
	t.rollAnimation = rollAnimation
	t.switchToAnim = switchToAnim
	t.configureAnimationSet = configureAnimationSet
	t.deepConfigureAnimationSetUnsafe = v16
	t.changeGlobalStateMaster = changeGlobalStateMaster
	function t.setPose(p1) --[[ setPose | Line: 1004 | Upvalues: v13 (ref) ]]
		assert(typeof(p1) == "string", "Pose must be a string.")
		v13 = p1
	end
	function t.playEmote(p1, p2, ...) --[[ playEmote | Line: 1009 | Upvalues: v13 (ref), v42 (ref), v4 (ref), Constants2 (ref), Asserts (ref), t3 (ref), v14 (ref), switchToAnim (copy), v222 (ref), v6 (ref) ]]
		if v13 ~= "Standing" or v42 == v4 then
			return
		end

		local v1 = if p2 then p2 else Constants2.EMOTE_TRANSITION_TIME
		local v2, v3 = ...

		Asserts.string(p1)
		Asserts.string(p1)
		Asserts.optional.table(nil)

		local v43 = t3[v14]
		local v7 = assert(if v43 then v43[p1] else v43, (("Invalid animation \"%*\", file not found."):format(p1)))[1]

		Asserts.table(v7)
		switchToAnim(v7.anim, p1, v7, v1, v2, v3)
		v222 = true

		return true, v6
	end
	function t.Initialize() --[[ Initialize | Line: 1019 | Upvalues: v12 (copy), v32 (copy), v122 (ref), AnimationData (ref), AnimNameToState (ref), TableUtil (ref), v16 (copy), t3 (ref), v1 (ref), t2 (ref), Assets (ref), scriptChildModified (copy), AnimationStatesMap (ref), p3 (copy), Humanoid (copy), Constants (ref), RunService (ref), t4 (copy), p1 (copy), t (copy), v13 (ref), stepAnimate (copy) ]]
		v12:Add(task.spawn(function() --[[ Line: 1020 | Upvalues: v32 (ref), v122 (ref), AnimationData (ref), AnimNameToState (ref), TableUtil (ref), v16 (ref), t3 (ref), v1 (ref), t2 (ref), v12 (ref), Assets (ref), scriptChildModified (ref), AnimationStatesMap (ref), p3 (ref), Humanoid (ref), Constants (ref), RunService (ref), t4 (ref), p1 (ref), t (ref), v13 (ref), stepAnimate (ref) ]]
			for i, v in ipairs((v32:GetPlayingAnimationTracks())) do
				v:Stop(0)
				v:Destroy()
			end

			local t5 = {}

			if v122 ~= AnimationData then
				for k, v in pairs(v122) do
					for k2, v2 in pairs(AnimNameToState) do
						if not v[k2] then
							t5[k2] = v2
						end
					end

					TableUtil.HardShallowReconcile(v, AnimationData.Default)
				end

				TableUtil.HardShallowReconcile(v122, AnimationData)
			end

			v16(v122, t3)
			v1:AtTrace():Log("deeplyConfigured animation set:", "(animNames)", v122, "(animTable)", t3, "(PreloadedAnims):", t2)
			v12:Connect(Assets.ChildAdded, scriptChildModified)
			v12:Connect(Assets.ChildRemoved, scriptChildModified)

			for v2, v3 in AnimationStatesMap do
				if not (p3 and p3[v2] or t5[v2]) then
					local v4 = Humanoid[v2]

					if v4 then
						if v2 == "Running" then
							v12:Connect(RunService.Heartbeat, t4[v3])

							continue
						end

						v12:Connect(v4, t4[v3])
					elseif Constants.IS_STUDIO then
						error((("Fatal error, invalid signal configuration for: \"%*\""):format(v2)))
					end
				end
			end

			if p1.Parent ~= nil then
				t.playAnimation("idle", 0.1)
				v13 = "Standing"
			end

			while p1.Parent ~= nil do
				stepAnimate((task.wait(0.1)))
			end

			t.Destroy()
		end))

		return t
	end
	function t.Clean() --[[ Clean | Line: 1095 | Upvalues: v12 (copy) ]]
		v12:Clean()
	end
	function t.Destroy() --[[ Destroy | Line: 1099 | Upvalues: v12 (copy), v42 (ref), v5 (ref), v6 (ref), v8 (ref), v9 (ref), v10 (ref), v11 (ref), v17 (ref), v18 (ref), v19 (ref), v20 (ref), v21 (ref), v222 (ref), t2 (ref), t3 (ref), t (copy), v122 (ref) ]]
		v12:Clean()
		setmetatable(v12, nil)
		table.clear(v12)
		v42 = nil
		v5 = nil
		v6 = nil
		v8 = nil
		v9 = nil
		v10 = nil
		v11 = nil
		v17 = nil
		v18 = nil
		v19 = nil
		v20 = nil
		v21 = nil
		v222 = nil
		table.clear(t2)
		table.clear(t3)
		table.clear(t)
		t3 = nil
		t2 = nil
		v122 = nil
	end

	return t
end

return t