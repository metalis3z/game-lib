--!strict
-- Pattern: CinematicCutscene (ModuleScript, client only)
-- Credit: ideas taken from jujutsu-shenanigans (CameraTableAnims / CameraHandler: scriptable camera,
-- smooth hand-back to the player), smash-egg-for-animals (CutsceneLock: one cutscene at a time,
-- letterbox bars, streaming the area the camera looks at) and steal-a-brainrot (FOV / blur helpers).
--
-- What it does:
--   Plays a list of camera "shots" (CFrame + FOV + time + easing) with optional letterbox bars,
--   blocks player input while it runs, can be skipped, and always restores the camera afterwards.
--
-- Usage (LocalScript):
--   local Cutscene = require(path.to.CinematicCutscene)
--   Cutscene.Play({
--       letterbox = true,
--       skippable = true,                 -- press Space / ButtonA to skip
--       shots = {
--           { cframe = workspace.Shot1.CFrame, fov = 60, cut = true, hold = 0.5 },   -- hard cut
--           { cframe = workspace.Shot2.CFrame, fov = 45, time = 2.5, easing = Enum.EasingStyle.Sine },
--           { cframe = function() return CFrame.lookAt(Vector3.new(0, 20, 30), workspace.Boss.HumanoidRootPart.Position) end, time = 1.5 },
--       },
--       onShot = function(index) print("shot", index) end,
--   })  -- yields until finished; returns true if it played, false if another cutscene was running
--
--   Cutscene.IsPlaying()  /  Cutscene.Skip()

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local ContextActionService = game:GetService("ContextActionService")

export type Shot = {
	cframe: CFrame | (() -> CFrame),
	fov: number?,
	time: number?, -- seconds to move from the previous shot to this one (ignored when cut = true)
	easing: Enum.EasingStyle?,
	direction: Enum.EasingDirection?,
	cut: boolean?, -- jump instantly instead of blending
	hold: number?, -- seconds to stay on this shot after arriving
}

export type Options = {
	shots: { Shot },
	letterbox: boolean?,
	skippable: boolean?,
	restoreTime: number?, -- seconds to blend back to the player camera (default 0.6)
	onShot: ((index: number) -> ())?,
}

local Cutscene = {}

local player = Players.LocalPlayer
local playing = false
local skipRequested = false

local BAR_HEIGHT = 0.12
local FREEZE_ACTION = "CinematicCutsceneFreeze"
local SKIP_ACTION = "CinematicCutsceneSkip"

local function getCamera(): Camera
	local camera = workspace.CurrentCamera
	while not camera do
		task.wait()
		camera = workspace.CurrentCamera
	end
	return camera
end

local function makeBars(): (ScreenGui, Frame, Frame)
	local gui = Instance.new("ScreenGui")
	gui.Name = "CinematicBars"
	gui.IgnoreGuiInset = true
	gui.ResetOnSpawn = false
	gui.DisplayOrder = 1000

	local function bar(top: boolean): Frame
		local frame = Instance.new("Frame")
		frame.BorderSizePixel = 0
		frame.BackgroundColor3 = Color3.new(0, 0, 0)
		frame.Size = UDim2.fromScale(1, BAR_HEIGHT)
		frame.Position = if top then UDim2.fromScale(0, -BAR_HEIGHT) else UDim2.fromScale(0, 1)
		frame.Parent = gui
		return frame
	end

	local top, bottom = bar(true), bar(false)
	gui.Parent = player:WaitForChild("PlayerGui")
	return gui, top, bottom
end

local function slideBars(top: Frame, bottom: Frame, show: boolean, duration: number)
	local info = TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	TweenService:Create(top, info, { Position = if show then UDim2.fromScale(0, 0) else UDim2.fromScale(0, -BAR_HEIGHT) }):Play()
	TweenService:Create(bottom, info, { Position = if show then UDim2.fromScale(0, 1 - BAR_HEIGHT) else UDim2.fromScale(0, 1) }):Play()
end

local function resolve(cf: CFrame | (() -> CFrame)): CFrame
	if typeof(cf) == "function" then
		return (cf :: () -> CFrame)()
	end
	return cf :: CFrame
end

-- Waits `seconds`, returning early if a skip was requested.
local function waitOrSkip(seconds: number)
	local finish = os.clock() + seconds
	while os.clock() < finish and not skipRequested do
		RunService.RenderStepped:Wait()
	end
end

-- Blends camera CFrame/FOV from their current values to the target over `duration`.
local function blendTo(camera: Camera, target: CFrame, fov: number, duration: number, style: Enum.EasingStyle, dir: Enum.EasingDirection)
	local startCF, startFov = camera.CFrame, camera.FieldOfView
	local start = os.clock()
	while not skipRequested do
		local alpha = math.clamp((os.clock() - start) / duration, 0, 1)
		local eased = TweenService:GetValue(alpha, style, dir)
		camera.CFrame = startCF:Lerp(target, eased)
		camera.FieldOfView = startFov + (fov - startFov) * eased
		if alpha >= 1 then
			break
		end
		RunService.RenderStepped:Wait()
	end
end

function Cutscene.IsPlaying(): boolean
	return playing
end

function Cutscene.Skip()
	if playing then
		skipRequested = true
	end
end

function Cutscene.Play(options: Options): boolean
	if playing then
		return false
	end
	playing = true
	skipRequested = false

	local camera = getCamera()
	local savedType = camera.CameraType
	local savedSubject = camera.CameraSubject
	local savedFov = camera.FieldOfView

	-- Freeze movement / jumping while the cutscene runs.
	ContextActionService:BindActionAtPriority(FREEZE_ACTION, function()
		return Enum.ContextActionResult.Sink
	end, false, Enum.ContextActionPriority.High.Value,
		Enum.PlayerActions.CharacterForward, Enum.PlayerActions.CharacterBackward,
		Enum.PlayerActions.CharacterLeft, Enum.PlayerActions.CharacterRight, Enum.PlayerActions.CharacterJump)

	if options.skippable then
		ContextActionService:BindActionAtPriority(SKIP_ACTION, function(_, state)
			if state == Enum.UserInputState.Begin then
				Cutscene.Skip()
			end
			return Enum.ContextActionResult.Sink
		end, false, Enum.ContextActionPriority.High.Value + 1, Enum.KeyCode.Space, Enum.KeyCode.ButtonA)
	end

	local gui, top, bottom
	if options.letterbox then
		gui, top, bottom = makeBars()
		slideBars(top, bottom, true, 0.5)
	end

	camera.CameraType = Enum.CameraType.Scriptable

	local ok, err = pcall(function()
		for index, shot in options.shots do
			if skipRequested then
				break
			end
			if options.onShot then
				task.spawn(options.onShot, index)
			end
			local target = resolve(shot.cframe)
			local fov = shot.fov or camera.FieldOfView
			if shot.cut or not shot.time or shot.time <= 0 then
				camera.CFrame = target
				camera.FieldOfView = fov
			else
				blendTo(camera, target, fov, shot.time, shot.easing or Enum.EasingStyle.Sine, shot.direction or Enum.EasingDirection.InOut)
			end
			if shot.hold and shot.hold > 0 then
				waitOrSkip(shot.hold)
			end
		end
	end)
	if not ok then
		warn("[CinematicCutscene] shot failed:", err)
	end

	ContextActionService:UnbindAction(FREEZE_ACTION)
	ContextActionService:UnbindAction(SKIP_ACTION)

	-- Hand the camera back smoothly: let the default camera run again, then blend from the last
	-- cutscene frame to wherever the default camera wants to be (same trick as jujutsu-shenanigans).
	local fromCF = camera.CFrame
	camera.CameraType = savedType == Enum.CameraType.Scriptable and Enum.CameraType.Custom or savedType
	if savedSubject and savedSubject.Parent then
		camera.CameraSubject = savedSubject
	end
	local restoreTime = options.restoreTime or 0.6
	local bindName = "CinematicRestore" .. tostring(os.clock())
	local startClock = os.clock()
	RunService:BindToRenderStep(bindName, Enum.RenderPriority.Camera.Value + 1, function()
		local alpha = TweenService:GetValue(math.clamp((os.clock() - startClock) / restoreTime, 0, 1), Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)
		camera.CFrame = fromCF:Lerp(camera.CFrame, alpha)
	end)
	TweenService:Create(camera, TweenInfo.new(restoreTime, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { FieldOfView = savedFov }):Play()

	if gui then
		slideBars(top, bottom, false, 0.4)
		task.delay(0.45, function()
			gui:Destroy()
		end)
	end

	task.wait(restoreTime)
	RunService:UnbindFromRenderStep(bindName)

	playing = false
	skipRequested = false
	return true
end

return Cutscene
