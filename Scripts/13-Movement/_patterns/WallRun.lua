--!strict
-- Pattern: WallRun (ModuleScript, client)
-- Credit: built on the raycast-in-front checks used by jujutsu-shenanigans (MovementController:Parkour,
-- Vault.client: ray forward-and-down to find a ledge) and retro-studio (RetroClimbing: drive a
-- velocity mover while a "Climbing" state is on), plus the strafe tilt from backrooms-exploration.
--
-- What it does:
--   While in the air and moving, if there is a wall close to your left or right, you stick to it and
--   run along it for a limited time with gravity mostly cancelled. Press Space to jump off the wall
--   (pushes you away and up). The camera tilts away from the wall. Sets character attribute "WallRunning".
--
-- Usage (LocalScript):
--   local WallRun = require(path.to.WallRun)
--   WallRun.Start({ speed = 30, maxTime = 1.4, checkDistance = 3, jumpPush = 40, jumpUp = 45,
--       tilt = 12, wallTag = nil })   -- set wallTag = "Runnable" to only allow tagged walls

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local CollectionService = game:GetService("CollectionService")

export type Config = {
	speed: number?,
	maxTime: number?,
	checkDistance: number?,
	jumpPush: number?,
	jumpUp: number?,
	tilt: number?, -- camera roll in degrees
	wallTag: string?,
	cooldown: number?,
}

local WallRun = {}

local player = Players.LocalPlayer
local cfg: Config = {}
local running = false
local runStarted = 0
local wallNormal = Vector3.zero
local side = 0 -- -1 wall on the left, 1 wall on the right
local lastEnd = -math.huge
local lastWall: Instance? = nil
local cameraRoll = 0
local mover: LinearVelocity? = nil
local attachment: Attachment? = nil
local connections: { RBXScriptConnection } = {}

local params = RaycastParams.new()
params.FilterType = Enum.RaycastFilterType.Exclude

local function castSide(root: BasePart, dir: Vector3): RaycastResult?
	local result = workspace:Raycast(root.Position, dir * (cfg.checkDistance or 3), params)
	if not result then
		return nil
	end
	-- only near-vertical surfaces count as walls
	if math.abs(result.Normal.Y) > 0.3 then
		return nil
	end
	if cfg.wallTag and not CollectionService:HasTag(result.Instance, cfg.wallTag) then
		return nil
	end
	return result
end

local function stopRun()
	if not running then
		return
	end
	running = false
	lastEnd = os.clock()
	if mover then
		mover:Destroy()
		mover = nil
	end
	if attachment then
		attachment:Destroy()
		attachment = nil
	end
	local character = player.Character
	if character then
		character:SetAttribute("WallRunning", nil)
	end
end

local function startRun(root: BasePart, hit: RaycastResult, whichSide: number)
	running = true
	runStarted = os.clock()
	wallNormal = hit.Normal
	side = whichSide
	lastWall = hit.Instance

	local att = Instance.new("Attachment")
	att.Parent = root
	attachment = att
	local lv = Instance.new("LinearVelocity")
	lv.Attachment0 = att
	lv.RelativeTo = Enum.ActuatorRelativeTo.World
	lv.MaxForce = 1e6
	lv.Parent = root
	mover = lv
	;(root.Parent :: Model):SetAttribute("WallRunning", true)
end

local function step(dt: number)
	local character = player.Character
	local humanoid = character and character:FindFirstChildOfClass("Humanoid")
	local root = character and character:FindFirstChild("HumanoidRootPart") :: BasePart?
	local camera = workspace.CurrentCamera
	if not character or not humanoid or not root or not camera then
		return
	end
	params.FilterDescendantsInstances = { character }

	local airborne = humanoid.FloorMaterial == Enum.Material.Air
	local moving = humanoid.MoveDirection.Magnitude > 0.1

	if running then
		local hit = castSide(root, -wallNormal)
		local timeUp = os.clock() - runStarted > (cfg.maxTime or 1.4)
		if not airborne or not hit or timeUp or not moving or humanoid.Health <= 0 then
			stopRun()
		else
			wallNormal = hit.Normal
			-- run direction = along the wall, the way the player is facing
			local along = wallNormal:Cross(Vector3.yAxis)
			if along:Dot(root.CFrame.LookVector) < 0 then
				along = -along
			end
			local t = (os.clock() - runStarted) / (cfg.maxTime or 1.4)
			local sink = -4 * t -- slowly slide down the longer you run
			if mover then
				mover.VectorVelocity = along * (cfg.speed or 30) + Vector3.new(0, sink, 0) - wallNormal * 2
			end
			root.CFrame = CFrame.lookAt(root.Position, root.Position + along)
		end
	elseif airborne and moving and os.clock() - lastEnd > (cfg.cooldown or 0.3) then
		local right = castSide(root, root.CFrame.RightVector)
		local left = if right then nil else castSide(root, -root.CFrame.RightVector)
		local hit = right or left
		-- do not re-grab the same wall straight after jumping off it
		if hit and not (hit.Instance == lastWall and os.clock() - lastEnd < 0.6) then
			startRun(root, hit, if right then 1 else -1)
		end
	end

	-- camera roll away from the wall, eased in and out
	local targetRoll = if running then -side * math.rad(cfg.tilt or 12) else 0
	cameraRoll += (targetRoll - cameraRoll) * math.min(1, dt * 10)
	if math.abs(cameraRoll) > 0.0005 then
		camera.CFrame *= CFrame.Angles(0, 0, cameraRoll)
	end
end

local function jumpOff()
	if not running then
		return
	end
	local character = player.Character
	local root = character and character:FindFirstChild("HumanoidRootPart") :: BasePart?
	local normal = wallNormal
	stopRun()
	if root then
		root.AssemblyLinearVelocity = normal * (cfg.jumpPush or 40) + Vector3.new(0, cfg.jumpUp or 45, 0) + root.CFrame.LookVector * 10
	end
end

function WallRun.IsRunning(): boolean
	return running
end

function WallRun.Start(config: Config?)
	cfg = config or {}
	if #connections > 0 then
		return
	end
	-- after the camera update so our roll is applied on top of the default camera
	RunService:BindToRenderStep("WallRun", Enum.RenderPriority.Camera.Value + 1, step)
	table.insert(connections, UserInputService.JumpRequest:Connect(jumpOff))
	table.insert(connections, player.CharacterAdded:Connect(function()
		running = false
		mover, attachment = nil, nil
	end))
end

function WallRun.Stop()
	RunService:UnbindFromRenderStep("WallRun")
	for _, c in connections do
		c:Disconnect()
	end
	table.clear(connections)
	stopRun()
end

return WallRun
