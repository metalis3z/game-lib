--!strict
-- Pattern: DeathCam (ModuleScript, client only)
-- Credit: ideas from bite-by-night (kill cams / outro cams as data), the-rake (JumpscareClient: on death,
-- snap the camera to a scare camera with an FOV kick), jujutsu-shenanigans (Client.client: keep the camera
-- offset alive on death) and needoh-escape (SpectateClient: lerp-follow a target and restore everything).
--
-- What it does:
--   When the local player's Humanoid dies, the camera slowly orbits the body (or looks at the killer
--   if one is given), the screen desaturates and darkens, and everything is restored on respawn.
--
-- Usage (LocalScript in StarterPlayerScripts):
--   local DeathCam = require(path.to.DeathCam)
--   DeathCam.Enable({
--       orbitRadius = 12, orbitHeight = 6, orbitSpeed = 0.35,  -- radians per second
--       getKiller = function() return workspace:FindFirstChild("KillerModel") end, -- optional
--   })
--   -- Or show it manually (for example from a RemoteEvent that tells you who killed you):
--   DeathCam.Show(characterModel, killerModel)
--   DeathCam.Hide()

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")

export type Options = {
	orbitRadius: number?,
	orbitHeight: number?,
	orbitSpeed: number?,
	getKiller: (() -> Model?)?,
}

local DeathCam = {}

local player = Players.LocalPlayer
local options: Options = {}
local renderName = "DeathCamOrbit"
local active = false
local colorFx: ColorCorrectionEffect? = nil
local connections: { RBXScriptConnection } = {}

local function rootOf(model: Model?): BasePart?
	if not model then
		return nil
	end
	return (model:FindFirstChild("HumanoidRootPart") or model:FindFirstChild("Head") or model.PrimaryPart) :: BasePart?
end

function DeathCam.Hide()
	if not active then
		return
	end
	active = false
	RunService:UnbindFromRenderStep(renderName)
	local camera = workspace.CurrentCamera
	if camera then
		camera.CameraType = Enum.CameraType.Custom
		local character = player.Character
		local humanoid = character and character:FindFirstChildOfClass("Humanoid")
		if humanoid then
			camera.CameraSubject = humanoid
		end
		TweenService:Create(camera, TweenInfo.new(0.4), { FieldOfView = 70 }):Play()
	end
	local fx = colorFx
	colorFx = nil
	if fx then
		local tween = TweenService:Create(fx, TweenInfo.new(0.5), { Saturation = 0, Brightness = 0, Contrast = 0 })
		tween.Completed:Once(function()
			fx:Destroy()
		end)
		tween:Play()
	end
end

function DeathCam.Show(body: Model, killer: Model?)
	local camera = workspace.CurrentCamera
	local bodyRoot = rootOf(body)
	if not camera or not bodyRoot then
		return
	end
	DeathCam.Hide()
	active = true

	local radius = options.orbitRadius or 12
	local height = options.orbitHeight or 6
	local speed = options.orbitSpeed or 0.35

	-- start the orbit at the angle the camera is already at, so there is no jump
	local flat = (camera.CFrame.Position - bodyRoot.Position) * Vector3.new(1, 0, 1)
	local angle = if flat.Magnitude > 0.01 then math.atan2(flat.Z, flat.X) else 0

	camera.CameraType = Enum.CameraType.Scriptable
	TweenService:Create(camera, TweenInfo.new(1.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { FieldOfView = 55 }):Play()

	local fx = Instance.new("ColorCorrectionEffect")
	fx.Name = "DeathCamColor"
	fx.Parent = Lighting
	colorFx = fx
	TweenService:Create(fx, TweenInfo.new(1.5), { Saturation = -0.85, Brightness = -0.08, Contrast = 0.15 }):Play()

	-- keep a last known position: the body may be destroyed (BreakJointsOnDeath / despawn)
	local focus = bodyRoot.Position
	RunService:BindToRenderStep(renderName, Enum.RenderPriority.Camera.Value + 1, function(dt)
		if bodyRoot.Parent then
			focus = bodyRoot.Position
		end
		local killerRoot = rootOf(killer)
		local camPos: Vector3
		local lookAt: Vector3
		if killerRoot and killerRoot.Parent then
			-- over-the-shoulder of the body, looking at the killer
			local toKiller = (killerRoot.Position - focus) * Vector3.new(1, 0, 1)
			local dir = if toKiller.Magnitude > 0.01 then toKiller.Unit else Vector3.zAxis
			camPos = focus - dir * (radius * 0.6) + Vector3.new(0, height * 0.6, 0)
			lookAt = killerRoot.Position
		else
			angle += speed * dt
			camPos = focus + Vector3.new(math.cos(angle) * radius, height, math.sin(angle) * radius)
			lookAt = focus
		end
		local target = CFrame.lookAt(camPos, lookAt)
		camera.CFrame = camera.CFrame:Lerp(target, 1 - math.exp(-6 * dt))
	end)
end

local function hookCharacter(character: Model)
	DeathCam.Hide()
	local humanoid = character:WaitForChild("Humanoid", 10) :: Humanoid?
	if not humanoid then
		return
	end
	table.insert(connections, humanoid.Died:Connect(function()
		local killer = if options.getKiller then options.getKiller() else nil
		DeathCam.Show(character, killer)
	end))
end

function DeathCam.Enable(newOptions: Options?)
	options = newOptions or {}
	for _, c in connections do
		c:Disconnect()
	end
	table.clear(connections)
	table.insert(connections, player.CharacterAdded:Connect(hookCharacter))
	if player.Character then
		task.spawn(hookCharacter, player.Character)
	end
end

function DeathCam.Disable()
	for _, c in connections do
		c:Disconnect()
	end
	table.clear(connections)
	DeathCam.Hide()
end

return DeathCam
