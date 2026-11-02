-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local AssetItem = require(ReplicatedStorage.Library.Types.AssetItem)
local Personalities = require(ReplicatedStorage.Directory.Assets.Personalities)

require(ReplicatedStorage.Directory.Assets.Types.Personality)

local Log = require(ReplicatedStorage.Library.Modules.Packages.Log)
local Asserts = require(ReplicatedStorage.Library.Asserts)
local AssetMutationWalkSpeed = require(script.Parent.AssetMutationWalkSpeed)
local AssetPersonalityMotion = require(script.Parent.AssetPersonalityMotion)
local AssetWanderArea = require(script.Parent.AssetWanderArea)
local AssetWanderMotion = require(script.Parent.AssetWanderMotion)
local AssetRetreatMotion = require(script.Parent.AssetRetreatMotion)
local v1 = Log.new()
local t = {}

t.__index = t
t.__class = "AssetWanderSimulator"
function t.new(p1, p2, p3, p4, p5, p6, p7) --[[ new | Line: 114 | Upvalues: Asserts (copy), AssetItem (copy), Players (copy), Personalities (copy), t (copy), AssetPersonalityMotion (copy), v1 (copy) ]]
	Asserts.number(p1)
	Asserts.Player(p2)
	Asserts.BasePart(p3)
	assert(AssetItem.AssetItemData(p4), "Invalid asset item data")
	Asserts.boolean(p5)
	Asserts.number(p6)
	Asserts.number(p7)

	local v2 = Random.new(p1)
	local LocalPlayer = Players.LocalPlayer

	assert(LocalPlayer ~= nil, "Asset wander simulator requires a local player")

	local v4 = Personalities.GetConfig(p4.Personality)
	local v6 = setmetatable({}, t)

	v6._random = v2
	v6._owner = p2
	v6._localPlayer = LocalPlayer
	v6._assetArea = p3
	v6._itemData = p4
	v6._config = v4
	v6._greetingOrbitRadius = math.max(p6, 2.5)
	v6._jumpHeight = math.min(math.max(p7, 1) * 2, 20)
	v6._destination = p3.Position
	v6._idleRemaining = 0
	v6._idleAnchorCFrame = nil
	v6._idleElapsed = 0
	v6._walkSpeed = v6:_rollWalkSpeed()
	v6._mode = "Destination"
	v6._phase = "Normal"
	v6._greetRemaining = 0
	v6._randomOrbitInsideSeconds = 0
	v6._farSeconds = 0
	v6._farRequiredSeconds = v2:NextNumber(105, 180)
	v6._joinGreetingPending = true
	v6._finishJumpsRemaining = 0
	v6._finishJumpCooldown = 0
	v6._returnGreetingHoldRemaining = 0
	v6._returnGreetingJumpsRemaining = 0
	v6._returnGreetingJumpCooldown = 0
	v6._returnGreetingOwnerOffset = nil
	v6._affectionInsideSeconds = 0
	v6._affectionHoldRemaining = 0
	v6._affectionJumpsRemaining = 0
	v6._affectionJumpCooldown = 0
	v6._affectionOwnerOffset = nil
	v6._loyalOwnerOffset = AssetPersonalityMotion.RandomOwnerOffset(p3, v2, v6._greetingOrbitRadius)
	v6._pendingBubbleText = nil
	v6._jumpRemaining = 0
	v6._jumpElapsed = 0
	v6._spinYaw = 0
	v6._spinAppliedYaw = 0
	v6._curveAngle = v2:NextNumber(-3.141592653589793, math.pi)
	v6._curveRotationSpeed = v2:NextNumber(-0.8, 0.8)
	v6._nextCurveChangeSeconds = v2:NextNumber(5, 10)
	v6._curveChangeElapsed = 0
	v6._retreatOwnerWasClose = false
	v6._retreatActive = false
	v6._lastOwnerPosition = nil
	v6:_chooseNextDestination()

	if p5 then
		v6:_tryStartFirstPlacementGreeting()
	end

	v1:AtDebug():Log((("Created asset wander simulator with seed %*"):format(p1)))

	return v6
end
function t._rollWalkSpeed(p1) --[[ _rollWalkSpeed | Line: 197 | Upvalues: AssetMutationWalkSpeed (copy) ]]
	local Movement = p1._config.Movement
	local v1 = p1._random:NextNumber(Movement.WalkSpeedMin, Movement.WalkSpeedMax)

	return math.max(v1, 4.5) * AssetMutationWalkSpeed.GetMultiplier(p1._itemData)
end
function t._ownerRootPosition(p1) --[[ _ownerRootPosition | Line: 204 | Upvalues: AssetPersonalityMotion (copy) ]]
	return AssetPersonalityMotion.OwnerRootPosition(p1._owner)
end
function t._distanceFromLocalPlayerToAreaCenter(p1) --[[ _distanceFromLocalPlayerToAreaCenter | Line: 208 | Upvalues: AssetPersonalityMotion (copy) ]]
	return AssetPersonalityMotion.DistanceFromPlayerToAreaCenter(p1._localPlayer, p1._assetArea)
end
function t._chooseNextDestination(p1) --[[ _chooseNextDestination | Line: 212 | Upvalues: AssetPersonalityMotion (copy) ]]
	local v1 = p1:_ownerRootPosition()
	local Movement = p1._config.Movement

	p1._walkSpeed = p1:_rollWalkSpeed()
	p1._destination = AssetPersonalityMotion.ChooseDestination(p1._assetArea, p1._random, Movement, v1)
	p1._mode = if p1._random:NextNumber() < Movement.CurvedWanderChance then "Curve" else "Destination"
end
function t._tryRetreatFromOwner(p1, p2, p3) --[[ _tryRetreatFromOwner | Line: 222 | Upvalues: AssetRetreatMotion (copy), AssetPersonalityMotion (copy) ]]
	local Retreat = p1._config.Movement.Retreat

	if Retreat == nil then
		p1._retreatOwnerWasClose = false
		p1._retreatActive = false

		return false
	end

	if not (Vector3.new(p2.X - p3.X, 0, p2.Z - p3.Z).Magnitude <= Retreat.TriggerDistance) then
		p1._retreatOwnerWasClose = false
		p1._retreatActive = false

		return false
	end

	if p1._retreatActive then
		p1._destination = AssetRetreatMotion.Destination(p1._assetArea, p1._random, Retreat, p3, p2)
		p1._mode = "Destination"
		p1._idleRemaining = 0
		p1._idleAnchorCFrame = nil

		return true
	end

	if p1._retreatOwnerWasClose then
		return false
	end

	p1._retreatOwnerWasClose = true

	if AssetPersonalityMotion.RollChance(p1._random, Retreat.Chance) then
		p1._retreatActive = true
		p1._destination = AssetRetreatMotion.Destination(p1._assetArea, p1._random, Retreat, p3, p2)
		p1._mode = "Destination"
		p1._idleRemaining = 0
		p1._idleAnchorCFrame = nil
		p1._walkSpeed = p1:_rollWalkSpeed()

		return true
	end

	return false
end
function t._beginIdle(p1, p2) --[[ _beginIdle | Line: 269 ]]
	local Movement = p1._config.Movement

	p1._idleRemaining = p1._random:NextNumber(Movement.IdleSecondsMin, Movement.IdleSecondsMax)
	p1._idleAnchorCFrame = p2
	p1._idleElapsed = 0
end
function t._stepIdle(p1, p2) --[[ _stepIdle | Line: 276 | Upvalues: AssetPersonalityMotion (copy) ]]
	local _idleAnchorCFrame = p1._idleAnchorCFrame

	assert(if _idleAnchorCFrame == nil then false else true, "Idle phase requires a stable anchor CFrame")

	local v2, v3, v4, v5 = AssetPersonalityMotion.StepIdle(p2, p1._idleRemaining, p1._idleElapsed, _idleAnchorCFrame, p1._config.Movement.IdleTremble)

	p1._idleRemaining = v3
	p1._idleElapsed = v4

	if v5 then
		p1._idleAnchorCFrame = nil
		p1._idleElapsed = 0
	end

	return p1:_applyJump(p2, v2)
end
function t._tryAmbientJump(p1, p2) --[[ _tryAmbientJump | Line: 296 | Upvalues: AssetPersonalityMotion (copy) ]]
	local Movement = p1._config.Movement

	if not AssetPersonalityMotion.ShouldStartAmbientJump(p1._random, Movement.AmbientJumpRatePerSecond, p2, p1._jumpRemaining > 0) then
		return
	end

	p1:_startJump(Movement.AmbientSpinJumpChance)
end
function t._startJump(p1, p2) --[[ _startJump | Line: 310 ]]
	if p1._jumpRemaining > 0 then
		return
	end

	local v1 = if p2 == nil then p1._config.Greeting.SpinJumpChance else p2

	p1._jumpRemaining = 0.45
	p1._jumpElapsed = 0
	p1._spinAppliedYaw = 0

	local v2 = if p1._random:NextNumber() < 0.5 then -1 else 1

	p1._spinYaw = if p1._random:NextNumber() < v1 then 6.283185307179586 * v2 else 0
end
function t._resetGreetingFinish(p1) --[[ _resetGreetingFinish | Line: 323 ]]
	p1._finishJumpsRemaining = 0
	p1._finishJumpCooldown = 0
end
function t._resetReturnGreeting(p1) --[[ _resetReturnGreeting | Line: 328 ]]
	p1._returnGreetingHoldRemaining = 0
	p1._returnGreetingJumpsRemaining = 0
	p1._returnGreetingJumpCooldown = 0
	p1._returnGreetingOwnerOffset = nil
end
function t._resetAffection(p1) --[[ _resetAffection | Line: 335 ]]
	p1._affectionHoldRemaining = 0
	p1._affectionJumpsRemaining = 0
	p1._affectionJumpCooldown = 0
	p1._affectionOwnerOffset = nil
	p1._pendingBubbleText = nil
end
function t._popBubbleText(p1) --[[ _popBubbleText | Line: 343 ]]
	local _pendingBubbleText = p1._pendingBubbleText

	p1._pendingBubbleText = nil

	return _pendingBubbleText
end
function t._beginGreetingFinish(p1) --[[ _beginGreetingFinish | Line: 350 ]]
	p1._phase = "GreetingFinish"
	p1._greetRemaining = 1.2
	p1._finishJumpsRemaining = 2
	p1._finishJumpCooldown = 0
	p1._lastOwnerPosition = nil
end
function t._beginGreetingOrbit(p1, p2) --[[ _beginGreetingOrbit | Line: 358 | Upvalues: Asserts (copy), AssetPersonalityMotion (copy) ]]
	Asserts.boolean(p2)

	local Greeting = p1._config.Greeting

	p1._phase = "GreetingOrbit"
	p1._greetRemaining = math.min(Greeting.DurationSeconds, 3)
	p1._randomOrbitInsideSeconds = 0
	p1._idleRemaining = 0
	p1._lastOwnerPosition = nil
	p1:_resetGreetingFinish()
	p1:_resetReturnGreeting()
	p1:_resetAffection()

	if not p2 then
		return
	end

	p1._pendingBubbleText = AssetPersonalityMotion.RandomConfiguredText(p1._random, Greeting.Texts, p1._config._id, "greeting")
end
function t._tryStartGreetingOrbit(p1, p2, p3) --[[ _tryStartGreetingOrbit | Line: 376 | Upvalues: Asserts (copy), AssetPersonalityMotion (copy) ]]
	Asserts.boolean(p3)

	if p2 <= 0 or p1._config.Greeting.DurationSeconds <= 0 then
		return false
	end

	if AssetPersonalityMotion.RollChance(p1._random, p2) then
		p1:_beginGreetingOrbit(p3)

		return true
	end

	return false
end
function t._beginNormalGreeting(p1, p2, p3, p4, p5) --[[ _beginNormalGreeting | Line: 393 | Upvalues: Asserts (copy), AssetPersonalityMotion (copy), AssetWanderArea (copy) ]]
	Asserts.boolean(p5)

	local v1 = AssetPersonalityMotion.RandomOwnerOffset(p1._assetArea, p1._random, p1._greetingOrbitRadius)

	p1._phase = "ReturnGreetingApproach"
	p1._returnGreetingOwnerOffset = v1
	p1._returnGreetingHoldRemaining = math.min(p4, 20)
	p1._returnGreetingJumpsRemaining = p3
	p1._returnGreetingJumpCooldown = 0
	p1._destination = AssetWanderArea.PointNearOwner(p1._assetArea, p2, v1)
	p1._idleRemaining = 0
	p1._walkSpeed = p1:_rollWalkSpeed()
	p1._lastOwnerPosition = nil
	p1:_resetGreetingFinish()
	p1:_resetAffection()

	if not p5 then
		return
	end

	p1._pendingBubbleText = AssetPersonalityMotion.RandomConfiguredText(p1._random, p1._config.Greeting.Texts, p1._config._id, "greeting")
end
function t._tryStartFirstPlacementGreeting(p1) --[[ _tryStartFirstPlacementGreeting | Line: 426 | Upvalues: AssetPersonalityMotion (copy) ]]
	p1._joinGreetingPending = false

	local Greeting = p1._config.Greeting

	if p1:_tryStartGreetingOrbit(Greeting.FirstPlacementChance, true) then
		return
	end

	local FirstPlacementBubbleChance = Greeting.FirstPlacementBubbleChance

	if FirstPlacementBubbleChance ~= nil and (FirstPlacementBubbleChance > 0 and AssetPersonalityMotion.RollChance(p1._random, FirstPlacementBubbleChance)) then
		p1._pendingBubbleText = AssetPersonalityMotion.RandomConfiguredText(p1._random, Greeting.Texts, p1._config._id, "greeting")

		return
	end

	local v1 = p1:_ownerRootPosition()

	if v1 == nil or not AssetPersonalityMotion.RollChance(p1._random, Greeting.FirstPlacementNormalChance) then
		return
	end

	local FirstPlacementNormalJumpCount = Greeting.FirstPlacementNormalJumpCount

	if not (FirstPlacementNormalJumpCount <= 0) then
		p1:_beginNormalGreeting(v1, FirstPlacementNormalJumpCount, 0.6 * FirstPlacementNormalJumpCount, true)
	end
end
function t._tryStartReturnGreeting(p1, p2, p3) --[[ _tryStartReturnGreeting | Line: 454 | Upvalues: Asserts (copy), AssetPersonalityMotion (copy) ]]
	Asserts.boolean(p3)

	local Greeting = p1._config.Greeting

	if Greeting.Chance <= 0 or Greeting.DurationSeconds <= 0 then
		return
	end

	if not AssetPersonalityMotion.RollChance(p1._random, Greeting.Chance) then
		return
	end

	if p3 and p1:_tryStartGreetingOrbit(Greeting.ReturnOrbitChance, false) then
		return
	end

	p1:_beginNormalGreeting(p2, Greeting.ReturnNormalJumpCount, math.min(Greeting.DurationSeconds, 20), false)
end
function t._beginAffection(p1, p2) --[[ _beginAffection | Line: 479 | Upvalues: AssetPersonalityMotion (copy), AssetWanderArea (copy) ]]
	local Affection = p1._config.Affection
	local v1 = AssetPersonalityMotion.RandomOwnerOffset(p1._assetArea, p1._random, p1._greetingOrbitRadius)

	p1._phase = "AffectionApproach"
	p1._affectionOwnerOffset = v1
	p1._destination = AssetWanderArea.PointNearOwner(p1._assetArea, p2, v1)
	p1._idleRemaining = 0
	p1._walkSpeed = p1:_rollWalkSpeed()
	p1._affectionHoldRemaining = Affection.DurationSeconds
	p1._affectionJumpsRemaining = Affection.JumpCount
	p1._affectionJumpCooldown = 0
	p1._pendingBubbleText = nil
	p1._lastOwnerPosition = nil
	p1:_resetGreetingFinish()
end
function t._updateAffectionTrigger(p1, p2, p3) --[[ _updateAffectionTrigger | Line: 497 | Upvalues: AssetWanderArea (copy), AssetPersonalityMotion (copy) ]]
	if p1._phase ~= "Normal" then
		return
	end

	local Affection = p1._config.Affection

	if not Affection.Enabled or (Affection.IntervalSeconds <= 0 or p3 == nil) then
		p1._affectionInsideSeconds = 0

		return
	end

	if not AssetWanderArea.IsPositionInside(p1._assetArea, p3) then
		p1._affectionInsideSeconds = 0

		return
	end

	p1._affectionInsideSeconds = p1._affectionInsideSeconds + p2

	if p1._affectionInsideSeconds < Affection.IntervalSeconds then
		return
	end

	p1._affectionInsideSeconds = 0

	if not AssetPersonalityMotion.RollChance(p1._random, Affection.Chance) then
		return
	end

	p1:_beginAffection(p3)
end
function t._updateOrbitGreetingTrigger(p1, p2, p3) --[[ _updateOrbitGreetingTrigger | Line: 528 | Upvalues: AssetWanderArea (copy) ]]
	if p1._phase ~= "Normal" then
		return
	end

	local Greeting = p1._config.Greeting

	if Greeting.RandomOrbitChance <= 0 or (Greeting.RandomOrbitIntervalSeconds <= 0 or (Greeting.DurationSeconds <= 0 or p3 == nil)) then
		p1._randomOrbitInsideSeconds = 0

		return
	end

	if not AssetWanderArea.IsPositionInside(p1._assetArea, p3) then
		p1._randomOrbitInsideSeconds = 0

		return
	end

	p1._randomOrbitInsideSeconds = p1._randomOrbitInsideSeconds + p2

	if not (p1._randomOrbitInsideSeconds < Greeting.RandomOrbitIntervalSeconds) then
		p1._randomOrbitInsideSeconds = 0
		p1:_tryStartGreetingOrbit(Greeting.RandomOrbitChance, false)
	end
end
function t._updateReturnGreeting(p1, p2) --[[ _updateReturnGreeting | Line: 562 | Upvalues: AssetWanderArea (copy) ]]
	if p1._phase ~= "Normal" then
		return
	end

	if p1._joinGreetingPending then
		local v1 = p1:_ownerRootPosition()

		if v1 ~= nil then
			p1._joinGreetingPending = false
			p1._farSeconds = 0
			p1._farRequiredSeconds = p1._random:NextNumber(105, 180)
			p1:_tryStartReturnGreeting(v1, AssetWanderArea.IsPositionInside(p1._assetArea, v1))
		end
	else
		local v2 = p1:_distanceFromLocalPlayerToAreaCenter()

		if v2 == nil then
			return
		end

		if v2 >= 200 then
			p1._farSeconds = p1._farSeconds + p2

			return
		end

		if p1._farSeconds >= p1._farRequiredSeconds and v2 <= 200 then
			p1._farSeconds = 0
			p1._farRequiredSeconds = p1._random:NextNumber(105, 180)

			local v3 = p1:_ownerRootPosition()

			if v3 ~= nil and AssetWanderArea.IsPositionInside(p1._assetArea, v3) then
				p1:_tryStartReturnGreeting(v3, true)
			end
		else
			p1._farSeconds = 0
		end
	end
end
function t._updateGreeting(p1, p2) --[[ _updateGreeting | Line: 598 ]]
	if p1._phase ~= "GreetingOrbit" and p1._phase ~= "GreetingFinish" then
		return
	end

	local v1 = p1:_distanceFromLocalPlayerToAreaCenter()

	if v1 ~= nil and v1 > 300 then
		p1._phase = "Normal"
		p1._greetRemaining = 0
		p1:_resetGreetingFinish()
		p1:_resetReturnGreeting()
		p1:_resetAffection()
		p1:_chooseNextDestination()

		return
	end

	p1._greetRemaining = math.max(p1._greetRemaining - p2, 0)

	if p1._phase == "GreetingOrbit" then
		if p1._greetRemaining <= 0 then
			p1:_beginGreetingFinish()

			return
		end

		if not (p1._random:NextNumber() < p1._config.Greeting.JumpChancePerSecond * p2) then
			return
		end

		p1:_startJump()
	else
		p1._finishJumpCooldown = math.max(p1._finishJumpCooldown - p2, 0)

		if p1._finishJumpsRemaining > 0 and p1._finishJumpCooldown <= 0 then
			p1:_startJump(0)
			p1._finishJumpsRemaining = p1._finishJumpsRemaining - 1
			p1._finishJumpCooldown = 0.6
		end

		if not (p1._finishJumpsRemaining <= 0 and (p1._jumpRemaining <= 0 and p1._greetRemaining <= 0)) then
			return
		end

		p1._phase = "Normal"
		p1:_resetGreetingFinish()
		p1:_resetReturnGreeting()
		p1:_resetAffection()
		p1:_chooseNextDestination()
	end
end
function t._stepReturnGreeting(p1, p2, p3, p4) --[[ _stepReturnGreeting | Line: 642 | Upvalues: AssetWanderArea (copy), AssetWanderMotion (copy) ]]
	if p1._phase == "ReturnGreetingApproach" then
		local _returnGreetingOwnerOffset = p1._returnGreetingOwnerOffset

		assert(_returnGreetingOwnerOffset ~= nil, "Return greeting approach requires a stable owner offset")
		p1._destination = AssetWanderArea.PointNearOwner(p1._assetArea, p4, _returnGreetingOwnerOffset)

		local v2, v3, v4 = AssetWanderMotion.StepMoveToward(p2, p3, p1._destination, p1._walkSpeed)

		if Vector3.new(p1._destination.X - v2.Position.X, 0, p1._destination.Z - v2.Position.Z).Magnitude > 2.25 then
			local v7, v8 = p1:_applyJump(p2, v2)

			return v7, if v3 then v3 else p1._jumpRemaining > 0, v8, v4
		end

		p1._phase = "ReturnGreetingHold"
		p1._returnGreetingJumpCooldown = 0

		if p1._returnGreetingJumpsRemaining > 0 then
			p1:_startJump(0)
			p1._returnGreetingJumpsRemaining = p1._returnGreetingJumpsRemaining - 1
			p1._returnGreetingJumpCooldown = 0.6
		end

		local v10, v11 = p1:_applyJump(p2, (AssetWanderMotion.FaceOwnerCFrame(v2, p4, p2, true)))

		return v10, if v3 then v3 else p1._jumpRemaining > 0, v11, v4
	end

	p1._returnGreetingHoldRemaining = math.max(p1._returnGreetingHoldRemaining - p2, 0)
	p1._returnGreetingJumpCooldown = math.max(p1._returnGreetingJumpCooldown - p2, 0)

	if p1._returnGreetingJumpsRemaining > 0 and p1._returnGreetingJumpCooldown <= 0 then
		p1:_startJump(0)
		p1._returnGreetingJumpsRemaining = p1._returnGreetingJumpsRemaining - 1
		p1._returnGreetingJumpCooldown = 0.6
	end

	local v15, v16 = p1:_applyJump(p2, (AssetWanderMotion.FaceOwnerCFrame(p3, p4, p2)))

	if p1._returnGreetingHoldRemaining <= 0 and (p1._returnGreetingJumpsRemaining <= 0 and p1._jumpRemaining <= 0) then
		p1._phase = "Normal"
		p1:_resetReturnGreeting()
		p1:_chooseNextDestination()
	end

	return v15, if p1._jumpRemaining > 0 then true else false, v16, p1._walkSpeed
end
function t._stepAffection(p1, p2, p3, p4) --[[ _stepAffection | Line: 699 | Upvalues: AssetWanderArea (copy), AssetWanderMotion (copy), AssetPersonalityMotion (copy) ]]
	if p1._phase == "AffectionApproach" then
		local _affectionOwnerOffset = p1._affectionOwnerOffset

		assert(_affectionOwnerOffset ~= nil, "Affection approach requires a stable owner offset")
		p1._destination = AssetWanderArea.PointNearOwner(p1._assetArea, p4, _affectionOwnerOffset)

		local v2, v3, v4 = AssetWanderMotion.StepMoveToward(p2, p3, p1._destination, p1._walkSpeed)

		if Vector3.new(p1._destination.X - v2.Position.X, 0, p1._destination.Z - v2.Position.Z).Magnitude > 2.25 then
			local v7, v8 = p1:_applyJump(p2, v2)

			return v7, if v3 then v3 else p1._jumpRemaining > 0, v8, v4
		end

		p1._phase = "AffectionHold"
		p1._affectionJumpCooldown = 0.6
		p1._pendingBubbleText = AssetPersonalityMotion.RandomConfiguredText(p1._random, p1._config.Affection.Texts, p1._config._id, "affection")

		if p1._affectionJumpsRemaining > 0 then
			p1:_startJump(0)
			p1._affectionJumpsRemaining = p1._affectionJumpsRemaining - 1
		end

		local v10, v11 = p1:_applyJump(p2, (AssetWanderMotion.FaceOwnerCFrame(v2, p4, p2, true)))

		return v10, if v3 then v3 else p1._jumpRemaining > 0, v11, v4
	end

	p1._affectionHoldRemaining = math.max(p1._affectionHoldRemaining - p2, 0)
	p1._affectionJumpCooldown = math.max(p1._affectionJumpCooldown - p2, 0)

	if p1._affectionJumpsRemaining > 0 and p1._affectionJumpCooldown <= 0 then
		p1:_startJump(0)
		p1._affectionJumpsRemaining = p1._affectionJumpsRemaining - 1
		p1._affectionJumpCooldown = 0.6
	end

	local v15, v16 = p1:_applyJump(p2, (AssetWanderMotion.FaceOwnerCFrame(p3, p4, p2)))

	if p1._affectionHoldRemaining <= 0 and (p1._affectionJumpsRemaining <= 0 and p1._jumpRemaining <= 0) then
		p1._phase = "Normal"
		p1:_resetAffection()
		p1:_chooseNextDestination()
	end

	return v15, if p1._jumpRemaining > 0 then true else false, v16, p1._walkSpeed
end
function t._updateCurve(p1, p2, p3) --[[ _updateCurve | Line: 755 | Upvalues: AssetWanderArea (copy) ]]
	p1._curveChangeElapsed = p1._curveChangeElapsed + p2

	if p1._curveChangeElapsed >= p1._nextCurveChangeSeconds then
		p1._curveChangeElapsed = 0
		p1._nextCurveChangeSeconds = p1._random:NextNumber(5, 10)
		p1._curveAngle = p1._random:NextNumber(-3.141592653589793, math.pi)
		p1._curveRotationSpeed = p1._random:NextNumber(-0.8, 0.8)
	end

	p1._curveAngle = p1._curveAngle + p1._curveRotationSpeed * p2
	p1._destination = AssetWanderArea.ClampedPointToward(p1._assetArea, p3 + Vector3.new(math.cos(p1._curveAngle), 0, (math.sin(p1._curveAngle))) * 9)
end
function t._orbitGreetingCFrame(p1, p2, p3, p4) --[[ _orbitGreetingCFrame | Line: 770 | Upvalues: AssetWanderMotion (copy) ]]
	local v1, v2 = AssetWanderMotion.OwnerMoveVector(p2, p4, p1._lastOwnerPosition)

	p1._lastOwnerPosition = v2

	return AssetWanderMotion.OrbitGreetingCFrame(p1._assetArea, p2, p3, p4, v1, p1._greetingOrbitRadius, 22, 0.75)
end
function t._applyJump(p1, p2, p3) --[[ _applyJump | Line: 791 ]]
	if p1._jumpRemaining <= 0 then
		return p3, true
	end

	p1._jumpRemaining = math.max(p1._jumpRemaining - p2, 0)
	p1._jumpElapsed = math.min(p1._jumpElapsed + p2, 0.45)

	local v3 = p1._jumpElapsed / 0.45
	local v4 = math.sin(v3 * math.pi) * p1._jumpHeight
	local v5 = if p1._spinYaw == 0 then 0 else p1._spinYaw * v3
	local v6 = v5 - p1._spinAppliedYaw

	p1._spinAppliedYaw = v5

	local v7 = CFrame.new(p3.Position + Vector3.new(0, v4, 0)) * p3.Rotation

	if v6 ~= 0 then
		v7 = v7 * CFrame.Angles(0, v6, 0)
	end

	if p1._jumpRemaining <= 0 then
		p1._spinAppliedYaw = 0
	end

	return v7, p1._jumpRemaining <= 0
end
function t.SetAssetArea(p1, p2) --[[ SetAssetArea | Line: 818 | Upvalues: Asserts (copy), AssetPersonalityMotion (copy) ]]
	Asserts.BasePart(p2)

	local isNot_assetArea = p1._assetArea ~= p2

	p1._assetArea = p2

	if isNot_assetArea then
		p1._loyalOwnerOffset = AssetPersonalityMotion.RandomOwnerOffset(p2, p1._random, p1._greetingOrbitRadius)
		p1._returnGreetingOwnerOffset = if p1._returnGreetingOwnerOffset == nil then nil else AssetPersonalityMotion.RandomOwnerOffset(p2, p1._random, p1._greetingOrbitRadius)
		p1._affectionOwnerOffset = if p1._affectionOwnerOffset == nil then nil else AssetPersonalityMotion.RandomOwnerOffset(p2, p1._random, p1._greetingOrbitRadius)
	end

	p1:_chooseNextDestination()
end
function t.SetItemData(p1, p2, p3) --[[ SetItemData | Line: 836 | Upvalues: AssetItem (copy), Asserts (copy), Personalities (copy) ]]
	assert(AssetItem.AssetItemData(p2), "Invalid asset item data")
	Asserts.boolean(p3)
	p1._itemData = p2
	p1._config = Personalities.GetConfig(p2.Personality)

	if not p3 then
		return
	end

	p1:_tryStartFirstPlacementGreeting()
end
function t.Step(p1, p2, p3) --[[ Step | Line: 851 | Upvalues: Asserts (copy), AssetWanderMotion (copy), AssetWanderArea (copy), AssetMutationWalkSpeed (copy) ]]
	Asserts.number(p2)
	Asserts.CFrame(p3)
	p1:_updateReturnGreeting(p2)
	p1:_updateGreeting(p2)

	local Position = p3.Position
	local v1 = p1:_ownerRootPosition()

	if p1._phase ~= "Normal" and v1 == nil then
		p1._phase = "Normal"
		p1._greetRemaining = 0
		p1:_resetGreetingFinish()
		p1:_resetReturnGreeting()
		p1:_resetAffection()
		p1:_chooseNextDestination()
	end

	p1:_updateAffectionTrigger(p2, v1)
	p1:_updateOrbitGreetingTrigger(p2, v1)

	local v2 = if p1._phase == "Normal" and v1 ~= nil then p1:_tryRetreatFromOwner(Position, v1) else false

	if p1._phase == "Normal" then
		p1:_tryAmbientJump(p2)
	end

	if p1._idleRemaining > 0 and p1._phase == "Normal" then
		local v4, v5 = p1:_stepIdle(p2)

		return v4, p1._jumpRemaining > 0, v5, 0, false, p1:_popBubbleText()
	end

	if p1._phase == "GreetingOrbit" and v1 ~= nil then
		local v7, v8, v9 = p1:_orbitGreetingCFrame(p2, p3, v1)
		local v10, v11 = p1:_applyJump(p2, v7)

		return v10, if v8 then v8 elseif p1._jumpRemaining > 0 then true else false, v11, v9, true, p1:_popBubbleText()
	end

	if p1._phase == "GreetingFinish" and v1 ~= nil then
		local v13, v14 = p1:_applyJump(p2, (AssetWanderMotion.FaceOwnerCFrame(p3, v1, p2)))

		return v13, p1._jumpRemaining > 0, v14, p1._walkSpeed, true, p1:_popBubbleText()
	end

	if (p1._phase == "ReturnGreetingApproach" or p1._phase == "ReturnGreetingHold") and v1 ~= nil then
		local v16, v17, v18, v19 = p1:_stepReturnGreeting(p2, p3, v1)

		return v16, v17, v18, v19, false, p1:_popBubbleText()
	end

	if (p1._phase == "AffectionApproach" or p1._phase == "AffectionHold") and v1 ~= nil then
		local v20, v21, v22, v23 = p1:_stepAffection(p2, p3, v1)

		return v20, v21, v22, v23, false, p1:_popBubbleText()
	end

	if p1._config.Movement.FollowOwnerInPen and (v1 ~= nil and AssetWanderArea.IsPositionInside(p1._assetArea, v1)) then
		local v24, v25, v26 = AssetWanderMotion.StepFollowOwner(p1._assetArea, p2, p3, v1, p1._loyalOwnerOffset, p1._walkSpeed, 2.25)
		local v27, v28 = p1:_applyJump(p2, v24)

		return v27, if v25 then v25 elseif p1._jumpRemaining > 0 then true else false, v28, v26, false, p1:_popBubbleText()
	end

	if p1._mode == "Curve" then
		p1:_updateCurve(p2, p3.Position)
	end

	local _destination = p1._destination
	local v30 = _destination - Position

	if Vector3.new(v30.X, 0, v30.Z).Magnitude <= 0.35 and not v2 then
		p1:_beginIdle(p3)
		p1:_chooseNextDestination()

		local v31, v32 = p1:_applyJump(p2, p3)

		return v31, p1._jumpRemaining > 0, v32, p1._walkSpeed, false, p1:_popBubbleText()
	end

	local _walkSpeed = p1._walkSpeed

	if p1._random:NextNumber() < p1._config.Movement.BurstChance * p2 then
		_walkSpeed = p1._config.Movement.WalkSpeedMax * 1.25 * AssetMutationWalkSpeed.GetMultiplier(p1._itemData)
		p1:_startJump()
	end

	local v34, v35, v36 = AssetWanderMotion.StepMoveToward(p2, p3, _destination, _walkSpeed)
	local v37, v38 = p1:_applyJump(p2, v34)

	return v37, if v35 then v35 elseif p1._jumpRemaining > 0 then true else false, v38, v36, false, p1:_popBubbleText()
end

return t