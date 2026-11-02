--!strict
-- Pattern: Dash (ModuleScript, client)
-- Credit: ideas from jujutsu-shenanigans (MovementController:Dash: short burst + face the dash direction,
-- Combat.server DashGetFunctions: side / back / front dashes gated by tags and separate cooldowns)
-- and bite-by-night (AbilityUtil.DashTowardMouse: speed + duration + max distance).
--
-- What it does:
--   Q to dash in the direction you are moving (relative to the camera), or forward if standing still.
--   Uses a LinearVelocity on the root (the modern replacement for BodyVelocity), keeps gravity working
--   (horizontal only), fades the speed out at the end, and has a cooldown. Sets the character attribute
--   "Dashing" while active so combat code can give i-frames or block attacks.
--
-- Usage (LocalScript):
--   local Dash = require(path.to.Dash)
--   Dash.Start({ speed = 70, duration = 0.22, cooldown = 1.2, key = Enum.KeyCode.Q })
--   Dash.Perform()                -- trigger from your own input / mobile button
--   Dash.OnDash = function(direction) --[[ play animation / VFX here ]] end

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

export type Config = {
	speed: number?,
	duration: number?,
	cooldown: number?,
	key: Enum.KeyCode?,
	allowInAir: boolean?,
}

local Dash = {}
Dash.OnDash = nil :: ((direction: Vector3) -> ())?

local player = Players.LocalPlayer
local cfg: Config = {}
local lastDash = -math.huge
local dashing = false
local inputConn: RBXScriptConnection? = nil

local function flat(v: Vector3): Vector3
	local f = Vector3.new(v.X, 0, v.Z)
	return if f.Magnitude > 0.001 then f.Unit else Vector3.zero
end

function Dash.CanDash(): boolean
	local character = player.Character
	local humanoid = character and character:FindFirstChildOfClass("Humanoid")
	if not character or not humanoid or humanoid.Health <= 0 or dashing then
		return false
	end
	if os.clock() - lastDash < (cfg.cooldown or 1.2) then
		return false
	end
	if not cfg.allowInAir and humanoid.FloorMaterial == Enum.Material.Air then
		return false
	end
	-- let other systems block dashing (stuns, ragdoll, cutscenes)
	if character:GetAttribute("Stunned") or character:GetAttribute("Ragdoll") or character:HasTag("CantDash") then
		return false
	end
	return true
end

function Dash.Perform(): boolean
	if not Dash.CanDash() then
		return false
	end
	local character = player.Character :: Model
	local humanoid = character:FindFirstChildOfClass("Humanoid") :: Humanoid
	local root = character:FindFirstChild("HumanoidRootPart") :: BasePart?
	local camera = workspace.CurrentCamera
	if not root or not camera then
		return false
	end

	local direction = flat(humanoid.MoveDirection)
	if direction == Vector3.zero then
		direction = flat(camera.CFrame.LookVector)
	end
	if direction == Vector3.zero then
		return false
	end

	dashing = true
	lastDash = os.clock()
	character:SetAttribute("Dashing", true)

	local attachment = Instance.new("Attachment")
	attachment.Name = "DashAttachment"
	attachment.Parent = root

	local mover = Instance.new("LinearVelocity")
	mover.Name = "DashVelocity"
	mover.Attachment0 = attachment
	mover.RelativeTo = Enum.ActuatorRelativeTo.World
	mover.VelocityConstraintMode = Enum.VelocityConstraintMode.Plane -- X/Z only: gravity still pulls you down
	mover.PrimaryTangentAxis = Vector3.xAxis
	mover.SecondaryTangentAxis = Vector3.zAxis
	mover.MaxForce = math.huge
	mover.Parent = root

	local speed = cfg.speed or 70
	local duration = cfg.duration or 0.22
	local started = os.clock()

	if Dash.OnDash then
		task.spawn(Dash.OnDash, direction)
	end

	local conn: RBXScriptConnection
	conn = RunService.Heartbeat:Connect(function()
		local t = (os.clock() - started) / duration
		if t >= 1 or not root.Parent or humanoid.Health <= 0 then
			conn:Disconnect()
			mover:Destroy()
			attachment:Destroy()
			dashing = false
			if character.Parent then
				character:SetAttribute("Dashing", nil)
			end
			return
		end
		-- full speed for the first 60%, then ease out so the stop does not feel like hitting a wall
		local k = if t < 0.6 then 1 else 1 - ((t - 0.6) / 0.4) ^ 2
		local v = direction * speed * k
		mover.PlaneVelocity = Vector2.new(v.X, v.Z)
	end)
	return true
end

function Dash.Start(config: Config?)
	cfg = config or {}
	if inputConn then
		return
	end
	inputConn = UserInputService.InputBegan:Connect(function(input, processed)
		if processed then
			return
		end
		if input.KeyCode == (cfg.key or Enum.KeyCode.Q) or input.KeyCode == Enum.KeyCode.ButtonB then
			Dash.Perform()
		end
	end)
end

function Dash.Stop()
	if inputConn then
		inputConn:Disconnect()
		inputConn = nil
	end
end

return Dash
