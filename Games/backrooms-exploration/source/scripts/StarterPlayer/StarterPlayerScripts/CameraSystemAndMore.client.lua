local Players          = game:GetService("Players")
local RunService       = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local camera = workspace.CurrentCamera

player.CameraMode = Enum.CameraMode.LockFirstPerson

local viewmodelPrefab = ReplicatedStorage:FindFirstChild("Viewmodel")
local viewmodel = nil
local animator = nil
local anims = {}
local currentAnimTrack = nil

if viewmodelPrefab then
	viewmodel = viewmodelPrefab:Clone()
	viewmodel.Parent = camera
	animator = viewmodel:FindFirstChildOfClass("AnimationController") and viewmodel.AnimationController:FindFirstChildOfClass("Animator")

	if animator then
		if viewmodel:FindFirstChild("WalkAnim") then anims.Walk = animator:LoadAnimation(viewmodel.WalkAnim) end
		if viewmodel:FindFirstChild("RunAnim") then anims.Run = animator:LoadAnimation(viewmodel.RunAnim) end
		if viewmodel:FindFirstChild("CrouchAnim") then anims.Crouch = animator:LoadAnimation(viewmodel.CrouchAnim) end
	end
end

local soundFolder = workspace:FindFirstChild("Sounds")
local runSound = soundFolder and soundFolder:FindFirstChild("Running")

local CFN    = CFrame.new
local CFA    = CFrame.Angles
local msin   = math.sin
local mcos   = math.cos
local mnoise = math.noise
local mclamp = math.clamp
local mabs   = math.abs
local mrad   = math.rad
local mlerp  = function(a, b, t2) return a + (b - a) * t2 end

local SPEED_WALK   = 16
local SPEED_SPRINT = 24
local SPEED_CROUCH = 7

local WALK_BOB_FREQ    = 7.2
local WALK_BOB_AMP_Y   = 0.100
local WALK_BOB_AMP_X   = 0.058
local WALK_BOB_ROLL    = 1.6

local SPRINT_BOB_FREQ  = 10.2
local SPRINT_BOB_AMP_Y = 0.180
local SPRINT_BOB_AMP_X = 0.100
local SPRINT_BOB_ROLL  = 2.8

local CROUCH_BOB_FREQ  = 4.6
local CROUCH_BOB_AMP_Y = 0.032
local CROUCH_BOB_AMP_X = 0.020
local CROUCH_BOB_ROLL  = 0.75

local IDLE_BREATH_FREQ    = 0.27
local IDLE_BREATH_AMP_Y   = 0.034
local IDLE_BREATH_AMP_X   = 0.012
local IDLE_BREATH_ROLL    = 0.60
local IDLE_BREATH_SMOOTH  = 1.6

local WALK_BREATH_FREQ  = 0.34
local WALK_BREATH_AMP_Y = 0.006
local WALK_BREATH_AMP_X = 0.003

local SPRINT_BREATH_FREQ  = 0.58
local SPRINT_BREATH_AMP_Y = 0.020
local SPRINT_BREATH_AMP_X = 0.009

local CROUCH_CAM_Y  = -1.5
local CROUCH_SMOOTH = 10

local SPRINT_LEAN_DEG    = 1.3
local SPRINT_LEAN_SMOOTH = 6

local SWAY_FREQ  = 0.20
local SWAY_AMP_X = 0.007
local SWAY_AMP_Y = 0.005

local TREMOR_FREQ = 1.5
local TREMOR_AMP  = 0.0020

local LAND_DECAY = 11
local LAND_MAX   = 0.30
local LAND_FREQ  = 3.8

local STEP_AMP      = 0.026
local STEP_DECAY    = 13
local STEP_MIN_WALK = 0.28

local STRAFE_MAX_DEG = 2.5
local STRAFE_SMOOTH  = 9

local LOOK_LAG_AMP          = 0.00085
local LOOK_LAG_MAX          = 0.038
local LOOK_ROLL_AMP         = 0.0032
local LOOK_ROLL_MAX         = 2.8
local LOOK_DECAY            = 5.5
local LOOK_SETTLE_NOISE_AMP = 0.0006

local t            = 0
local idleBreathT  = 0
local breathT      = 0
local swayT        = 0
local tremorT      = 0
local lookSettleT  = 0

local landShake      = 0
local stepImpact     = 0
local strafeTilt     = 0
local sprintLean     = 0
local prevBobSign    = 1
local prevRootY      = 0
local wasAirborne    = false

local lookSwayX   = 0
local lookSwayY   = 0
local lookRollAcc = 0

local idleBreathFactor = 0
local crouchFactor     = 0
local sprintFactor     = 0

local keySprintHeld = false
local keyCrouchHeld = false

local function getHumAndRoot()
	local char = player.Character
	if not char then return nil, nil end
	return char:FindFirstChildOfClass("Humanoid"), char:FindFirstChild("HumanoidRootPart")
end

local function applySpeed()
	local hum = getHumAndRoot()
	if not hum then return end
	if keyCrouchHeld then
		hum.WalkSpeed = SPEED_CROUCH
	elseif keySprintHeld then
		hum.WalkSpeed = SPEED_SPRINT
	else
		hum.WalkSpeed = SPEED_WALK
	end
end

local function playAnim(animName)
	if not animator or not anims[animName] then return end
	if currentAnimTrack == anims[animName] then return end
	if currentAnimTrack then currentAnimTrack:Stop(0.2) end
	currentAnimTrack = anims[animName]
	currentAnimTrack:Play(0.2)
end

local function stopAllAnims()
	if currentAnimTrack then
		currentAnimTrack:Stop(0.2)
		currentAnimTrack = nil
	end
end

UserInputService.InputBegan:Connect(function(input, processed)
	if processed then return end
	local kc = input.KeyCode
	if kc == Enum.KeyCode.LeftShift or kc == Enum.KeyCode.RightShift then
		keySprintHeld = true
		keyCrouchHeld = false
		applySpeed()
	end
	if kc == Enum.KeyCode.LeftControl or kc == Enum.KeyCode.RightControl then
		keyCrouchHeld = true
		keySprintHeld = false
		applySpeed()
	end
end)

UserInputService.InputEnded:Connect(function(input, _processed)
	local kc = input.KeyCode
	if kc == Enum.KeyCode.LeftShift or kc == Enum.KeyCode.RightShift then
		keySprintHeld = false
		applySpeed()
	end
	if kc == Enum.KeyCode.LeftControl or kc == Enum.KeyCode.RightControl then
		keyCrouchHeld = false
		applySpeed()
	end
end)

player.CharacterAdded:Connect(function()
	task.wait()
	applySpeed()
end)

RunService:BindToRenderStep(
	"HorrorFirstPersonCam",
	Enum.RenderPriority.Camera.Value + 1,
	function(dt)
		local hum, root = getHumAndRoot()
		if not hum or not root then return end

		local vel      = root.AssemblyLinearVelocity
		local hSpeed   = Vector2.new(vel.X, vel.Z).Magnitude
		local grounded = hum.FloorMaterial ~= Enum.Material.Air
		local movingFactor = mclamp(hSpeed / 2, 0, 1)
		local walkFactor   = mclamp(hSpeed / SPEED_WALK, 0, 1)

		local targetSprint  = (keySprintHeld and not keyCrouchHeld and hSpeed > 1) and 1 or 0
		local targetCrouch  = keyCrouchHeld and 1 or 0
		local targetIdleBr  = walkFactor < 0.06 and 1 or 0

		if runSound then
			if targetSprint == 1 and grounded then
				if not runSound.IsPlaying then runSound:Play() end
			else
				if runSound.IsPlaying then runSound:Stop() end
			end
		end

		if hSpeed > 1 and grounded then
			if targetCrouch == 1 then
				playAnim("Crouch")
			elseif targetSprint == 1 then
				playAnim("Run")
			else
				playAnim("Walk")
			end
		else
			stopAllAnims()
		end

		idleBreathFactor = mlerp(idleBreathFactor, targetIdleBr,  mclamp(dt * IDLE_BREATH_SMOOTH,  0, 1))
		sprintFactor     = mlerp(sprintFactor,     targetSprint,  mclamp(dt * 5,                   0, 1))
		crouchFactor     = mlerp(crouchFactor,     targetCrouch,  mclamp(dt * CROUCH_SMOOTH,       0, 1))

		local bobFreq  = mlerp(mlerp(WALK_BOB_FREQ,  SPRINT_BOB_FREQ,  sprintFactor), CROUCH_BOB_FREQ,  crouchFactor)
		local bobAmpY  = mlerp(mlerp(WALK_BOB_AMP_Y, SPRINT_BOB_AMP_Y, sprintFactor), CROUCH_BOB_AMP_Y, crouchFactor)
		local bobAmpX  = mlerp(mlerp(WALK_BOB_AMP_X, SPRINT_BOB_AMP_X, sprintFactor), CROUCH_BOB_AMP_X, crouchFactor)
		local bobRollD = mlerp(mlerp(WALK_BOB_ROLL,  SPRINT_BOB_ROLL,  sprintFactor), CROUCH_BOB_ROLL,  crouchFactor)

		if grounded then
			t = t + dt * bobFreq * movingFactor + dt * 0.3 * (1 - movingFactor)
		else
			t = t + dt * 0.4
		end

		local breathFreq = mlerp(WALK_BREATH_FREQ, SPRINT_BREATH_FREQ, sprintFactor)
		breathT      = breathT     + dt * breathFreq
		idleBreathT  = idleBreathT + dt * IDLE_BREATH_FREQ
		swayT        = swayT       + dt * SWAY_FREQ
		tremorT      = tremorT     + dt * TREMOR_FREQ

		local curRootY  = root.Position.Y
		local yVelocity = (curRootY - prevRootY) / mclamp(dt, 0.001, 0.05)
		prevRootY = curRootY

		if not grounded then
			wasAirborne = true
		elseif wasAirborne then
			wasAirborne = false
			landShake = mclamp(mabs(yVelocity) * 0.014, 0, LAND_MAX)
		end
		landShake = mlerp(landShake, 0, mclamp(dt * LAND_DECAY, 0, 1))

		local rawBobY = msin(t) * bobAmpY * walkFactor
		local bobSign = rawBobY >= 0 and 1 or -1
		if bobSign ~= prevBobSign and walkFactor > STEP_MIN_WALK then
			stepImpact  = STEP_AMP * walkFactor * mlerp(1, 1.75, sprintFactor)
			prevBobSign = bobSign
		end
		stepImpact = mlerp(stepImpact, 0, mclamp(dt * STEP_DECAY, 0, 1))

		local bobY    = rawBobY
		local bobX    = mcos(t * 0.5) * bobAmpX * walkFactor
		local bobRoll = mrad(msin(t * 0.5) * bobRollD * walkFactor)

		local idleY    = msin(idleBreathT) * IDLE_BREATH_AMP_Y * idleBreathFactor
		local idleX    = mcos(idleBreathT * 0.71) * IDLE_BREATH_AMP_X * idleBreathFactor
		local idleRoll = mrad(msin(idleBreathT * 0.48) * IDLE_BREATH_ROLL * idleBreathFactor)

		local breathAmpY = mlerp(WALK_BREATH_AMP_Y, SPRINT_BREATH_AMP_Y, sprintFactor)
		local breathAmpX = mlerp(WALK_BREATH_AMP_X, SPRINT_BREATH_AMP_X, sprintFactor)
		local breathY    = msin(breathT) * breathAmpY * (1 - idleBreathFactor)
		local breathX    = mcos(breathT * 0.68) * breathAmpX * (1 - idleBreathFactor)

		local swayX = mnoise(swayT,         34.7) * SWAY_AMP_X
		local swayY = mnoise(34.7, swayT * 0.75 ) * SWAY_AMP_Y

		local tremX = mnoise(tremorT,          77.3) * TREMOR_AMP
		local tremY = mnoise(77.3, tremorT * 1.4  ) * TREMOR_AMP

		local landX = mnoise(t * LAND_FREQ, 12.6) * landShake * 0.85
		local landY = -landShake * 0.55 + mnoise(t * 1.8, 88.2) * landShake * 0.32

		local rightVec   = root.CFrame.RightVector
		local lateralDot = vel:Dot(rightVec)
		local targetTilt = mclamp(-lateralDot / 22 * STRAFE_MAX_DEG, -STRAFE_MAX_DEG, STRAFE_MAX_DEG)
		strafeTilt = mlerp(strafeTilt, targetTilt, mclamp(dt * STRAFE_SMOOTH, 0, 1))

		local targetLean = mrad(-SPRINT_LEAN_DEG) * sprintFactor * movingFactor
		sprintLean = mlerp(sprintLean, targetLean, mclamp(dt * SPRINT_LEAN_SMOOTH, 0, 1))

		local mouseDelta = UserInputService:GetMouseDelta()
		lookSwayX   = lookSwayX   - mouseDelta.X * LOOK_LAG_AMP
		lookSwayY   = lookSwayY   - mouseDelta.Y * LOOK_LAG_AMP
		lookRollAcc = lookRollAcc - mouseDelta.X * LOOK_ROLL_AMP

		lookSwayX   = mclamp(lookSwayX,   -LOOK_LAG_MAX,       LOOK_LAG_MAX)
		lookSwayY   = mclamp(lookSwayY,   -LOOK_LAG_MAX,       LOOK_LAG_MAX)
		lookRollAcc = mclamp(lookRollAcc, -mrad(LOOK_ROLL_MAX), mrad(LOOK_ROLL_MAX))

		local lookDecay = 1 - mclamp(dt * LOOK_DECAY, 0, 1)
		lookSwayX   = lookSwayX   * lookDecay
		lookSwayY   = lookSwayY   * lookDecay
		lookRollAcc = lookRollAcc * lookDecay

		lookSettleT = lookSettleT + dt * 2.1
		local settleNoise = mnoise(lookSettleT, 55.9) * LOOK_SETTLE_NOISE_AMP * (mabs(lookSwayX) + mabs(lookSwayY)) * 18

		local targetCamOffY = CROUCH_CAM_Y * crouchFactor
		local curOff = hum.CameraOffset
		hum.CameraOffset = Vector3.new(
			curOff.X,
			mlerp(curOff.Y, targetCamOffY, mclamp(dt * CROUCH_SMOOTH, 0, 1)),
			curOff.Z
		)

		local offX    = bobX + breathX + idleX + swayX + tremX + landX + lookSwayX + settleNoise
		local offY    = bobY + breathY + idleY + swayY + tremY + landY - stepImpact + lookSwayY
		local offRoll = bobRoll + idleRoll + mrad(strafeTilt) + lookRollAcc

		camera.CFrame = camera.CFrame * CFN(offX, offY, 0) * CFA(sprintLean, 0, offRoll)

		if viewmodel and viewmodel:IsA("Model") then
			local primary = viewmodel.PrimaryPart or viewmodel:FindFirstChildWhichIsA("BasePart")
			if primary then
				viewmodel:PivotTo(camera.CFrame)
			end
		end
	end
)