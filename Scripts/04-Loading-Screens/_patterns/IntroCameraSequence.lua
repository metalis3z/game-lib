--!strict
-- IntroCameraSequence (ModuleScript) - clean pattern, written for this reference library.
--
-- Plays a skippable cinematic: letterbox bars, a list of camera shots (tweened CFrames),
-- optional title/subtitle per shot, fade to black between shots, and a Skip button.
-- Restores the camera, core GUI and any GUIs you hid when it ends (also when skipped).
--
-- Ideas taken from:
--   smash-egg-for-animals IntroClient (letterbox, titles, square SKIP, hold() that aborts once skipped,
--     "IntroState" attribute so the tutorial waits), street-life / miami-shootout Intro (hide game GUIs,
--     tween camera between set pieces, restore after), big-paintball Intro (pop-in tweens, skip button).
--
-- Usage (LocalScript):
--   local Intro = require(path.to.IntroCameraSequence)
--   local finishedNormally = Intro.play({
--       shots = {
--           { from = workspace.IntroCams.A1.CFrame, to = workspace.IntroCams.A2.CFrame, time = 4,
--             title = "WELCOME", subtitle = "to My Game" },
--           { from = workspace.IntroCams.B1.CFrame, to = workspace.IntroCams.B2.CFrame, time = 3,
--             easing = Enum.EasingStyle.Quad },
--       },
--       hideGuis = { "MainHUD", "Shop" },   -- ScreenGui names in PlayerGui to hide during the intro
--       skippable = true,
--       letterbox = true,
--       onShot = function(index) end,       -- optional: spawn effects / play sounds per shot
--   })
--   -- player:GetAttribute("IntroState") is "playing" during the intro and "done" after.

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local StarterGui = game:GetService("StarterGui")

export type Shot = {
	from: CFrame,
	to: CFrame?,
	time: number,
	easing: Enum.EasingStyle?,
	fov: number?,
	title: string?,
	subtitle: string?,
}

export type Options = {
	shots: { Shot },
	hideGuis: { string }?,
	skippable: boolean?,
	letterbox: boolean?,
	fadeTime: number?,
	onShot: ((index: number, shot: Shot) -> ())?,
}

local IntroCameraSequence = {}

local playing = false

local function new(className: string, props: { [string]: any }, parent: Instance?): any
	local inst = Instance.new(className)
	for key, value in props do
		(inst :: any)[key] = value
	end
	inst.Parent = parent
	return inst
end

local function buildGui(playerGui: PlayerGui, skippable: boolean, letterbox: boolean)
	local gui = new("ScreenGui", {
		Name = "IntroSequence", IgnoreGuiInset = true, ResetOnSpawn = false, DisplayOrder = 900,
	}, playerGui)
	local barTop = new("Frame", {
		Size = UDim2.fromScale(1, 0), BackgroundColor3 = Color3.new(0, 0, 0), BorderSizePixel = 0, Visible = letterbox,
	}, gui)
	local barBottom = new("Frame", {
		AnchorPoint = Vector2.new(0, 1), Position = UDim2.fromScale(0, 1), Size = UDim2.fromScale(1, 0),
		BackgroundColor3 = Color3.new(0, 0, 0), BorderSizePixel = 0, Visible = letterbox,
	}, gui)
	local fade = new("Frame", {
		Size = UDim2.fromScale(1, 1), BackgroundColor3 = Color3.new(0, 0, 0), BorderSizePixel = 0,
		BackgroundTransparency = 0, ZIndex = 5,
	}, gui)
	local title = new("TextLabel", {
		AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.72), Size = UDim2.fromScale(0.7, 0.09),
		BackgroundTransparency = 1, TextScaled = true, Font = Enum.Font.GothamBlack, TextColor3 = Color3.new(1, 1, 1),
		TextTransparency = 1, Text = "", ZIndex = 3,
	}, gui)
	new("UIStroke", { Thickness = 3 }, title)
	local subtitle = new("TextLabel", {
		AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.fromScale(0.5, 0.77), Size = UDim2.fromScale(0.6, 0.045),
		BackgroundTransparency = 1, TextScaled = true, Font = Enum.Font.GothamBold, TextColor3 = Color3.new(1, 1, 1),
		TextTransparency = 1, Text = "", ZIndex = 3,
	}, gui)
	local skip = new("TextButton", {
		AnchorPoint = Vector2.new(1, 1), Position = UDim2.new(1, -20, 1, -20), Size = UDim2.fromOffset(110, 42),
		BackgroundColor3 = Color3.new(1, 1, 1), Text = "SKIP", Font = Enum.Font.GothamBlack, TextSize = 20,
		TextColor3 = Color3.new(0, 0, 0), Visible = skippable, ZIndex = 10,
	}, gui)
	new("UICorner", { CornerRadius = UDim.new(0, 8) }, skip)
	return gui, barTop, barBottom, fade, title, subtitle, skip
end

-- Plays the sequence. Yields until it ends. Returns true if it ran to the end, false if skipped.
function IntroCameraSequence.play(options: Options): boolean
	if playing then
		return false
	end
	playing = true

	local player = Players.LocalPlayer
	local playerGui = player:WaitForChild("PlayerGui") :: PlayerGui
	local camera = workspace.CurrentCamera
	local fadeTime = options.fadeTime or 0.5
	local skipped = false

	player:SetAttribute("IntroState", "playing")

	-- Remember what we change so we can put it back.
	local oldType, oldFov = camera.CameraType, camera.FieldOfView
	local hidden: { ScreenGui } = {}
	for _, name in options.hideGuis or {} do
		local g = playerGui:FindFirstChild(name)
		if g and g:IsA("ScreenGui") and g.Enabled then
			g.Enabled = false
			table.insert(hidden, g)
		end
	end
	pcall(StarterGui.SetCoreGuiEnabled, StarterGui, Enum.CoreGuiType.All, false)

	local gui, barTop, barBottom, fade, title, subtitle, skip =
		buildGui(playerGui, options.skippable ~= false, options.letterbox ~= false)
	skip.Activated:Connect(function()
		skipped = true
	end)

	local function tween(inst: Instance, time: number, props: { [string]: any }, style: Enum.EasingStyle?)
		local t = TweenService:Create(inst, TweenInfo.new(time, style or Enum.EasingStyle.Quad, Enum.EasingDirection.Out), props)
		t:Play()
		return t
	end

	-- Waits `seconds`, but returns false immediately once skipped (pattern from smash-egg's hold()).
	local function hold(seconds: number): boolean
		local untilTime = os.clock() + seconds
		while os.clock() < untilTime do
			if skipped then
				return false
			end
			task.wait()
		end
		return not skipped
	end

	camera.CameraType = Enum.CameraType.Scriptable
	tween(barTop, 0.6, { Size = UDim2.fromScale(1, 0.1) })
	tween(barBottom, 0.6, { Size = UDim2.fromScale(1, 0.1) })

	for index, shot in options.shots do
		if skipped then
			break
		end
		camera.CFrame = shot.from
		if shot.fov then
			camera.FieldOfView = shot.fov
		end
		tween(fade, fadeTime, { BackgroundTransparency = 1 })
		if options.onShot then
			task.spawn(options.onShot, index, shot)
		end

		local camTween
		if shot.to then
			camTween = tween(camera, shot.time, { CFrame = shot.to }, shot.easing or Enum.EasingStyle.Sine)
		end

		if shot.title then
			title.Text = shot.title
			subtitle.Text = shot.subtitle or ""
			tween(title, 0.4, { TextTransparency = 0 })
			tween(subtitle, 0.4, { TextTransparency = 0 })
		end

		local ok = hold(math.max(0, shot.time - fadeTime))
		if shot.title then
			tween(title, 0.3, { TextTransparency = 1 })
			tween(subtitle, 0.3, { TextTransparency = 1 })
		end
		if not ok then
			if camTween then
				camTween:Cancel()
			end
			break
		end
		if index < #options.shots then
			tween(fade, fadeTime, { BackgroundTransparency = 0 })
			hold(fadeTime)
		end
	end

	-- Exit: quick fade to black, restore everything, fade back in on the normal camera.
	skip.Visible = false
	tween(fade, 0.3, { BackgroundTransparency = 0 }).Completed:Wait()
	camera.CameraType = oldType == Enum.CameraType.Scriptable and Enum.CameraType.Custom or oldType
	camera.FieldOfView = oldFov
	local character = player.Character
	local humanoid = character and character:FindFirstChildOfClass("Humanoid")
	if humanoid then
		camera.CameraSubject = humanoid
	end
	barTop.Visible, barBottom.Visible = false, false
	for _, g in hidden do
		g.Enabled = true
	end
	pcall(StarterGui.SetCoreGuiEnabled, StarterGui, Enum.CoreGuiType.All, true)
	tween(fade, 0.6, { BackgroundTransparency = 1 }).Completed:Wait()
	gui:Destroy()

	player:SetAttribute("IntroState", "done")
	playing = false
	return not skipped
end

function IntroCameraSequence.isPlaying(): boolean
	return playing
end

return IntroCameraSequence
