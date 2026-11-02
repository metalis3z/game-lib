--!strict
-- Pattern: SprintStamina (ModuleScript, client)
-- Credit: rules taken from bite-by-night (StaminaManager: drain only while really moving forward,
-- regen delay, exhaustion lockout, everything stored as character attributes), the-rake
-- (RunScript: sprint FOV tween) and backrooms-exploration (shift to sprint / ctrl to crouch speeds).
--
-- What it does:
--   Hold Shift (or the gamepad left stick button) to sprint. Stamina drains while you are actually
--   moving forward, regenerates after a short delay, and if it hits 0 you are "exhausted" and cannot
--   sprint again until it refills to a threshold. Stamina is written to the character attribute
--   "Stamina" (and "MaxStamina", "Sprinting", "Exhausted") so any UI can read it.
--
--   This is client-side for responsiveness. For a competitive game, run the same drain rules on the
--   server (see 13-Movement/StaminaManager__bite-by-night.lua) and have the server own WalkSpeed.
--
-- Usage (LocalScript in StarterPlayerScripts):
--   local Sprint = require(path.to.SprintStamina)
--   Sprint.Start({ walkSpeed = 16, sprintSpeed = 26, maxStamina = 100, drainPerSecond = 20,
--       regenPerSecond = 25, regenDelay = 1, recoverAt = 30, sprintFov = 80, walkFov = 70 })
--   -- UI: character:GetAttributeChangedSignal("Stamina"):Connect(...)

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local ContextActionService = game:GetService("ContextActionService")

export type Config = {
	walkSpeed: number?,
	sprintSpeed: number?,
	maxStamina: number?,
	drainPerSecond: number?,
	regenPerSecond: number?,
	regenDelay: number?, -- seconds after sprinting stops before regen starts
	recoverAt: number?, -- stamina needed to sprint again after exhaustion
	sprintFov: number?,
	walkFov: number?,
}

local SprintStamina = {}

local player = Players.LocalPlayer
local ACTION = "SprintStaminaAction"

local cfg: Config = {}
local wantsSprint = false
local exhausted = false
local regenAt = 0
local heartbeat: RBXScriptConnection? = nil
local fovTween: Tween? = nil
local lastFovState: boolean? = nil

local function setFov(sprinting: boolean)
	if lastFovState == sprinting then
		return
	end
	lastFovState = sprinting
	local camera = workspace.CurrentCamera
	if not camera then
		return
	end
	if fovTween then
		fovTween:Cancel()
	end
	local goal = if sprinting then (cfg.sprintFov or 80) else (cfg.walkFov or 70)
	fovTween = TweenService:Create(camera, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { FieldOfView = goal })
	fovTween:Play()
end

local function isMovingForward(humanoid: Humanoid, root: BasePart): boolean
	local move = humanoid.MoveDirection
	if move.Magnitude < 0.1 then
		return false
	end
	local vel = root.AssemblyLinearVelocity * Vector3.new(1, 0, 1)
	if vel.Magnitude < 2 then
		return false
	end
	local look = root.CFrame.LookVector * Vector3.new(1, 0, 1)
	-- same 0.45 dot rule as bite-by-night: strafing / backpedalling does not count as sprinting
	return look.Unit:Dot(vel.Unit) >= 0.45
end

local function step(dt: number)
	local character = player.Character
	local humanoid = character and character:FindFirstChildOfClass("Humanoid")
	local root = character and character:FindFirstChild("HumanoidRootPart") :: BasePart?
	if not character or not humanoid or not root or humanoid.Health <= 0 then
		return
	end

	local maxStamina = cfg.maxStamina or 100
	local stamina = (character:GetAttribute("Stamina") :: number?) or maxStamina
	character:SetAttribute("MaxStamina", maxStamina)

	local now = os.clock()
	local sprinting = wantsSprint and not exhausted and stamina > 0 and isMovingForward(humanoid, root)

	if sprinting then
		stamina = math.max(0, stamina - (cfg.drainPerSecond or 20) * dt)
		regenAt = now + (cfg.regenDelay or 1)
		if stamina <= 0 then
			exhausted = true
			sprinting = false
		end
	elseif now >= regenAt then
		stamina = math.min(maxStamina, stamina + (cfg.regenPerSecond or 25) * dt)
		if exhausted and stamina >= (cfg.recoverAt or maxStamina * 0.3) then
			exhausted = false
		end
	end

	humanoid.WalkSpeed = if sprinting then (cfg.sprintSpeed or 26) else (cfg.walkSpeed or 16)
	character:SetAttribute("Stamina", stamina)
	character:SetAttribute("Sprinting", sprinting)
	character:SetAttribute("Exhausted", exhausted)
	setFov(sprinting)
end

function SprintStamina.Start(config: Config?)
	cfg = config or {}
	if heartbeat then
		return
	end
	ContextActionService:BindAction(ACTION, function(_, state)
		if state == Enum.UserInputState.Begin then
			wantsSprint = true
		elseif state == Enum.UserInputState.End or state == Enum.UserInputState.Cancel then
			wantsSprint = false
		end
		return Enum.ContextActionResult.Pass
	end, true, Enum.KeyCode.LeftShift, Enum.KeyCode.ButtonL3)
	ContextActionService:SetTitle(ACTION, "Sprint")

	heartbeat = RunService.Heartbeat:Connect(step)
	player.CharacterAdded:Connect(function()
		exhausted = false
		regenAt = 0
		lastFovState = nil
	end)
end

function SprintStamina.Stop()
	ContextActionService:UnbindAction(ACTION)
	if heartbeat then
		heartbeat:Disconnect()
		heartbeat = nil
	end
	wantsSprint = false
	setFov(false)
end

return SprintStamina
