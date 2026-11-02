--!strict
-- Pattern: FovController (ModuleScript, client only)
-- Credit: ideas from the-rake (RunScript: sprint FOV tween, JumpscareClient: FOV 120 -> 50 kick),
-- street-life (hs.lua: quick FOV dip on a headshot) and steal-a-brainrot (CameraController.Fov).
--
-- What it does:
--   One owner for Camera.FieldOfView so different systems stop fighting over it.
--     * a "base" FOV (e.g. 70 walking, 85 sprinting) that the camera eases towards
--     * any number of named offsets that add on top (zoom while aiming, ability wind-up...)
--     * spring "punches": instant kicks that wobble back to zero (hits, explosions, dashes)
--
-- Usage (LocalScript):
--   local Fov = require(path.to.FovController)
--   Fov.Start()                       -- once
--   Fov.SetBase(85)                   -- e.g. while sprinting; Fov.SetBase(70) when you stop
--   Fov.SetOffset("Aim", -25)         -- aim down sights; Fov.SetOffset("Aim", nil) to clear
--   Fov.Punch(12)                     -- quick outward kick (negative = punch inward)
--   Fov.Stop()                        -- unbinds and restores the default FOV

local RunService = game:GetService("RunService")

local FovController = {}

local DEFAULT_FOV = 70
local BASE_SPEED = 8 -- how fast the base FOV is followed (higher = snappier)
local SPRING_STIFFNESS = 180 -- spring for punches
local SPRING_DAMPING = 14
local MIN_FOV, MAX_FOV = 1, 120

local baseTarget = DEFAULT_FOV
local baseCurrent = DEFAULT_FOV
local offsets: { [string]: number } = {}
local punchPos = 0
local punchVel = 0
local running = false
local BIND_NAME = "FovController"

function FovController.SetBase(fov: number)
	baseTarget = fov
end

function FovController.GetBase(): number
	return baseTarget
end

function FovController.SetOffset(name: string, amount: number?)
	offsets[name] = amount
end

-- Adds an impulse to the spring. `strength` is roughly how many degrees the FOV jumps.
function FovController.Punch(strength: number)
	punchVel += strength * SPRING_DAMPING
end

local function step(dt: number)
	local camera = workspace.CurrentCamera
	if not camera then
		return
	end
	dt = math.min(dt, 1 / 20)

	-- frame-rate independent ease towards the base value
	baseCurrent += (baseTarget - baseCurrent) * (1 - math.exp(-BASE_SPEED * dt))

	-- damped spring back to 0 for punches
	local accel = -SPRING_STIFFNESS * punchPos - SPRING_DAMPING * punchVel
	punchVel += accel * dt
	punchPos += punchVel * dt

	local total = baseCurrent + punchPos
	for _, amount in offsets do
		total += amount
	end
	camera.FieldOfView = math.clamp(total, MIN_FOV, MAX_FOV)
end

function FovController.Start()
	if running then
		return
	end
	running = true
	local camera = workspace.CurrentCamera
	if camera then
		baseCurrent = camera.FieldOfView
	end
	-- After the default camera scripts so our value wins this frame.
	RunService:BindToRenderStep(BIND_NAME, Enum.RenderPriority.Camera.Value + 2, step)
end

function FovController.Stop()
	if not running then
		return
	end
	running = false
	RunService:UnbindFromRenderStep(BIND_NAME)
	table.clear(offsets)
	punchPos, punchVel = 0, 0
	baseTarget, baseCurrent = DEFAULT_FOV, DEFAULT_FOV
	local camera = workspace.CurrentCamera
	if camera then
		camera.FieldOfView = DEFAULT_FOV
	end
end

return FovController
