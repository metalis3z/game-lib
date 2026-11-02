--!strict
-- Pattern: Slide (ModuleScript, client)
-- Credit: ideas from backrooms-exploration (CameraSystemAndMore: crouch lowers Humanoid.CameraOffset
-- smoothly), miami-shootout / street-life (Crouch scripts: crouch animation + lower WalkSpeed) and
-- smash-egg-for-animals (NoSlideClient: drive the root's horizontal velocity yourself each frame).
--
-- What it does:
--   While moving fast on the ground, press C (or LeftControl) to slide: you keep your current
--   direction, start with a speed boost that decays with friction, the camera dips, and an optional
--   animation plays. The slide ends when you are slow, you jump, you leave the ground, or you press
--   the key again. Sets the character attribute "Sliding".
--
-- Usage (LocalScript):
--   local Slide = require(path.to.Slide)
--   Slide.Start({ boost = 1.4, friction = 2.2, minSpeed = 14, endSpeed = 8, cameraDrop = 1.6,
--       animation = ReplicatedStorage.Animations.Slide, cooldown = 0.6 })

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

export type Config = {
	boost: number?, -- multiplier applied to your speed when the slide starts
	friction: number?, -- how quickly the slide slows down (per second, exponential)
	minSpeed: number?, -- need at least this horizontal speed to start
	endSpeed: number?, -- slide stops below this speed
	maxSpeed: number?,
	cameraDrop: number?,
	animation: Animation?,
	cooldown: number?,
}

local Slide = {}

local player = Players.LocalPlayer
local cfg: Config = {}
local sliding = false
local lastSlideEnd = -math.huge
local inputConn: RBXScriptConnection? = nil
local stopCurrent: (() -> ())? = nil

local function horizontal(v: Vector3): Vector3
	return Vector3.new(v.X, 0, v.Z)
end

local function startSlide()
	local character = player.Character
	local humanoid = character and character:FindFirstChildOfClass("Humanoid")
	local root = character and character:FindFirstChild("HumanoidRootPart") :: BasePart?
	if sliding or not character or not humanoid or not root then
		return
	end
	if os.clock() - lastSlideEnd < (cfg.cooldown or 0.6) then
		return
	end
	if humanoid.FloorMaterial == Enum.Material.Air then
		return
	end
	local vel = horizontal(root.AssemblyLinearVelocity)
	if vel.Magnitude < (cfg.minSpeed or 14) then
		return
	end

	sliding = true
	character:SetAttribute("Sliding", true)
	local direction = vel.Unit
	local speed = math.min(vel.Magnitude * (cfg.boost or 1.4), cfg.maxSpeed or 60)
	local friction = cfg.friction or 2.2
	local endSpeed = cfg.endSpeed or 8
	local drop = cfg.cameraDrop or 1.6
	local savedAutoRotate = humanoid.AutoRotate
	humanoid.AutoRotate = false

	local track: AnimationTrack? = nil
	if cfg.animation then
		local animator = humanoid:FindFirstChildOfClass("Animator")
		if animator then
			track = animator:LoadAnimation(cfg.animation)
			track.Priority = Enum.AnimationPriority.Action
			track:Play(0.1)
		end
	end

	local stopRequested = false
	local jumpConn = humanoid:GetPropertyChangedSignal("Jump"):Connect(function()
		if humanoid.Jump then
			stopRequested = true
		end
	end)

	local function finish()
		sliding = false
		lastSlideEnd = os.clock()
		jumpConn:Disconnect()
		if track then
			track:Stop(0.2)
		end
		if humanoid.Parent then
			humanoid.AutoRotate = savedAutoRotate
		end
		if character.Parent then
			character:SetAttribute("Sliding", nil)
		end
	end

	stopCurrent = function()
		stopRequested = true
	end

	local conn: RBXScriptConnection
	conn = RunService.Heartbeat:Connect(function(dt)
		local airborne = humanoid.FloorMaterial == Enum.Material.Air
		speed *= math.exp(-friction * dt)
		-- ease the camera down while sliding, back up when done
		local targetY = if (stopRequested or speed < endSpeed or airborne) then 0 else -drop
		local offset = humanoid.CameraOffset
		humanoid.CameraOffset = Vector3.new(offset.X, offset.Y + (targetY - offset.Y) * math.min(1, dt * 12), offset.Z)

		if stopRequested or speed < endSpeed or airborne or humanoid.Health <= 0 or not root.Parent then
			if math.abs(humanoid.CameraOffset.Y) < 0.05 or not root.Parent then
				humanoid.CameraOffset = Vector3.new(offset.X, 0, offset.Z)
				conn:Disconnect()
			end
			if sliding then
				finish()
			end
			return
		end

		-- keep vertical velocity (slopes / gravity), replace horizontal with the slide velocity
		local current = root.AssemblyLinearVelocity
		local v = direction * speed
		root.AssemblyLinearVelocity = Vector3.new(v.X, current.Y, v.Z)
		root.CFrame = CFrame.lookAt(root.Position, root.Position + direction)
	end)
end

function Slide.IsSliding(): boolean
	return sliding
end

function Slide.Start(config: Config?)
	cfg = config or {}
	if inputConn then
		return
	end
	inputConn = UserInputService.InputBegan:Connect(function(input, processed)
		if processed then
			return
		end
		if input.KeyCode == Enum.KeyCode.C or input.KeyCode == Enum.KeyCode.LeftControl or input.KeyCode == Enum.KeyCode.ButtonR3 then
			if sliding then
				if stopCurrent then
					stopCurrent()
				end
			else
				startSlide()
			end
		end
	end)
end

function Slide.Stop()
	if inputConn then
		inputConn:Disconnect()
		inputConn = nil
	end
end

return Slide
