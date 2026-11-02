-- Reference copy for study. Game: Brainrot Lab (brainrot-lab)
-- Original: StarterPlayer/StarterCharacterScripts/UIEffects.client.lua  (client, 573 lines)
-- Categories: ui-animation 51.7, vfx 17.5, rng-gacha 14.7, tycoon-plots 14.7, camera-cutscene 8.9
-- What it does: Auto-hooks every GuiButton with hover/press UIScale tweens + sounds, and drives CollectionService-tagged effects (sunburst spin, rotating/panning UIGradient, random shine sparkles, looping UIScale pulse).

--!strict
-- LOCATION: StarterPlayerScripts/UIEffects

local CollectionService = game:GetService("CollectionService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Debris = game:GetService("Debris")
local Workspace = game:GetService("Workspace")

print("[UIEffects] Initialized (StarterPlayerScripts)")

-- Assets
local Templates = ReplicatedStorage:WaitForChild("Templates")
local shineTemplate: ImageLabel? = Templates:FindFirstChild("ShineEffectTemplate")
local globalSounds = Workspace:WaitForChild("Sounds")
local Events = ReplicatedStorage:WaitForChild("Events")

-- Player & Camera
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local camera = Workspace.CurrentCamera

-- Script State
local sunburstObjects: {[GuiObject]: boolean} = {}
local bladeObjects: {[GuiObject]: boolean} = {} -- ## ADDED ##
local rainbowObjects: {[BasePart]: boolean} = {} 
local rotatingGradients: {[UIGradient]: number} = {} 
local panningGradients: {[UIGradient]: {Speed: number, Range: number}} = {}
local buttonConnections: {[GuiButton]: {RBXScriptConnection}} = {}
local physicalButtonDebounce: {[Instance]: boolean} = {}
local activeShineThreads: {[GuiObject]: thread} = {}
local activePulseData: {[GuiObject]: {TweenIn: Tween, TweenOut: Tween, Scale: UIScale, CreatedScale: boolean}} = {}
local spinningObjects: {[BasePart]: {FakePart: BasePart, Speed: Vector3, CurrentAngle: Vector3}} = {}

-- [ CONFIGURATION ]
local SOUND_DEBOUNCE_TIME = 0.05
local lastSoundTime = tick()

local HOVER_TWEEN_INFO = TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
local CLICK_TWEEN_INFO = TweenInfo.new(0.1, Enum.EasingStyle.Quint, Enum.EasingDirection.InOut)

local SUNBURST_ROTATION_SPEED = 20
local BLADE_ROTATION_SPEED = 500 -- ## ADDED (20 * 25 = 500) ##
local RAINBOW_SPEED = 0.5 
local DEFAULT_GRADIENT_SPEED = 90
local DEFAULT_PAN_SPEED = 1
local DEFAULT_PAN_RANGE = 0.25

-- Animation Config for Physical Buttons
local PHYSICAL_PRESS_INFO = TweenInfo.new(0.15, Enum.EasingStyle.Back, Enum.EasingDirection.Out, 0, true)
local PHYSICAL_PRESS_OFFSET = 0.4 

-- UI Constants
local HOVER_SCALE = 1.05
local CLICK_SCALE = 0.95

-- Screen Effects Config
local EFFECT_FADE_IN_INFO = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local EFFECT_FADE_OUT_INFO = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local SUCCESS_COLOR = Color3.fromRGB(85, 255, 127) -- Bright Green

local FOV_BOOST = 8 
local FOV_TWEEN_INFO_IN = TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
local FOV_TWEEN_INFO_OUT = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

--================------------------------------------------------
-- ## SOUND LOGIC ##
--================------------------------------------------------
local function playLocalSound(soundName: string)
	local now = tick()
	if now - lastSoundTime < SOUND_DEBOUNCE_TIME then return end
	lastSoundTime = now

	local soundTemplate = globalSounds:FindFirstChild(soundName)
	if soundTemplate and soundTemplate:IsA("Sound") then
		local newSound = soundTemplate:Clone()
		newSound.Parent = playerGui
		newSound:Play()
		Debris:AddItem(newSound, newSound.TimeLength + 0.1)
	end
end

--================------------------------------------------------
-- ## PHYSICAL BUTTON LOGIC (3D World) ##
--================------------------------------------------------
local function applyPhysicalButtonEffect(model: Instance)
	if not model:IsA("Model") then return end

	task.spawn(function()
		-- Wait for the Touch part and for the model to be in the Workspace
		local touchPart = model:WaitForChild("Touch", 10) :: BasePart
		if not touchPart then return end

		-- Wait until the model is actually placed in the world to get a valid Pivot
		while model.Parent == nil or model:GetPivot().Position.Magnitude < 1 do
			task.wait(0.2)
		end

		-- Capture the stationary "Home" position
		local homePivot = model:GetPivot()

		-- Setup Animation
		local animValue = Instance.new("NumberValue")
		animValue.Value = 0

		animValue.Changed:Connect(function(val)
			-- Always calculate relative to the captured Home
			model:PivotTo(homePivot * CFrame.new(0, -val, 0))
		end)

		local pressTween = TweenService:Create(animValue, PHYSICAL_PRESS_INFO, {Value = PHYSICAL_PRESS_OFFSET})

		-- Touched Interaction
		touchPart.Touched:Connect(function(hit)
			local character = hit.Parent
			if not character then return end

			local hitPlayer = Players:GetPlayerFromCharacter(character)

			if hitPlayer == player and not physicalButtonDebounce[model] then
				physicalButtonDebounce[model] = true

				-- Safety Check: If the button drifted (due to plot movement), update Home
				-- but ONLY if the current animation value is 0 (it's at rest)
				if animValue.Value == 0 then
					homePivot = model:GetPivot()
				end

				playLocalSound("Click")
				pressTween:Play()

				task.delay(0.5, function()
					physicalButtonDebounce[model] = nil
				end)
			end
		end)
	end)
end
local function cleanupPhysicalButtonEffect(model: Instance)
	physicalButtonDebounce[model] = nil
end

--================------------------------------------------------
-- ## BUTTON ANIMATION LOGIC (Universal UI) ##
--================------------------------------------------------
local function applyUniversalButtonLogic(button: GuiButton)
	if buttonConnections[button] then return end

	local useUIScale = not button:FindFirstAncestorOfClass("ScrollingFrame")
	local originalSize = button.Size
	local uiScale: UIScale?

	if useUIScale then
		uiScale = button:FindFirstChild("EffectScale") :: UIScale?
		if not uiScale then
			uiScale = Instance.new("UIScale")
			uiScale.Name = "EffectScale"
			uiScale.Parent = button
		end
		uiScale.Scale = 1
	end

	local connections = {}

	table.insert(connections, button.MouseEnter:Connect(function()
		playLocalSound("Hover")
		if uiScale then
			TweenService:Create(uiScale, HOVER_TWEEN_INFO, {Scale = HOVER_SCALE}):Play()
		else
			TweenService:Create(button, HOVER_TWEEN_INFO, {Size = UDim2.new(originalSize.X.Scale * HOVER_SCALE, originalSize.X.Offset, originalSize.Y.Scale * HOVER_SCALE, originalSize.Y.Offset)}):Play()
		end
	end))

	table.insert(connections, button.MouseLeave:Connect(function()
		if uiScale then
			TweenService:Create(uiScale, HOVER_TWEEN_INFO, {Scale = 1}):Play()
		else
			TweenService:Create(button, HOVER_TWEEN_INFO, {Size = originalSize}):Play()
		end
	end))

	table.insert(connections, button.MouseButton1Down:Connect(function()
		playLocalSound("Click")
		if uiScale then
			TweenService:Create(uiScale, CLICK_TWEEN_INFO, {Scale = CLICK_SCALE}):Play()
		else
			TweenService:Create(button, CLICK_TWEEN_INFO, {Size = UDim2.new(originalSize.X.Scale * CLICK_SCALE, originalSize.X.Offset, originalSize.Y.Scale * CLICK_SCALE, originalSize.Y.Offset)}):Play()
		end
	end))

	table.insert(connections, button.MouseButton1Up:Connect(function()
		if uiScale then
			TweenService:Create(uiScale, CLICK_TWEEN_INFO, {Scale = HOVER_SCALE}):Play()
		else
			TweenService:Create(button, CLICK_TWEEN_INFO, {Size = UDim2.new(originalSize.X.Scale * HOVER_SCALE, originalSize.X.Offset, originalSize.Y.Scale * HOVER_SCALE, originalSize.Y.Offset)}):Play()
		end
	end))

	buttonConnections[button] = connections
end

local function cleanupButtonLogic(button: GuiButton)
	if buttonConnections[button] then
		for _, conn in ipairs(buttonConnections[button]) do
			conn:Disconnect()
		end
		buttonConnections[button] = nil
	end
end

--================------------------------------------------------
-- ## VISUAL EFFECTS (Sunburst, Blade, Rainbow, Gradient, Spin, Shine, Pulse) ##
--================------------------------------------------------

-- Sunburst
local function applySunburstEffect(guiObject: Instance) if guiObject:IsA("GuiObject") then sunburstObjects[guiObject] = true end end
local function cleanupSunburstEffect(guiObject: Instance) if guiObject:IsA("GuiObject") then sunburstObjects[guiObject] = nil end end

-- Blade ## ADDED ##
local function applyBladeEffect(guiObject: Instance) if guiObject:IsA("GuiObject") then bladeObjects[guiObject] = true end end
local function cleanupBladeEffect(guiObject: Instance) if guiObject:IsA("GuiObject") then bladeObjects[guiObject] = nil end end

-- Rainbow
local function applyRainbowEffect(part: Instance) if part:IsA("BasePart") then rainbowObjects[part] = true end end
local function cleanupRainbowEffect(part: Instance) if part:IsA("BasePart") then rainbowObjects[part] = nil end end

-- Rotating Gradient
local function applyRotatingGradient(grad: Instance) if grad:IsA("UIGradient") then rotatingGradients[grad] = grad:GetAttribute("RotationSpeed") or DEFAULT_GRADIENT_SPEED end end
local function cleanupRotatingGradient(grad: Instance) if grad:IsA("UIGradient") then rotatingGradients[grad] = nil end end

-- Panning Gradient
local function applyPanningGradient(grad: Instance) if grad:IsA("UIGradient") then panningGradients[grad] = {Speed = grad:GetAttribute("PanSpeed") or DEFAULT_PAN_SPEED, Range = grad:GetAttribute("PanRange") or DEFAULT_PAN_RANGE} end end
local function cleanupPanningGradient(grad: Instance) if grad:IsA("UIGradient") then panningGradients[grad] = nil end end

-- 3D Spin Logic
local function applySpinEffect(part: Instance)
	if not part:IsDescendantOf(Workspace) then
		local ancestryConnection
		ancestryConnection = part.AncestryChanged:Connect(function()
			if part:IsDescendantOf(Workspace) then
				ancestryConnection:Disconnect()
				applySpinEffect(part) 
			end
		end)
		return
	end

	if part:IsA("BasePart") then
		if part.Name == "SpinEffectFake" then return end

		local speedX = CollectionService:HasTag(part, "SpinX") and 360 or 0
		local speedY = CollectionService:HasTag(part, "SpinY") and 360 or 0
		local speedZ = CollectionService:HasTag(part, "SpinZ") and -360 or 0
		if CollectionService:HasTag(part, "SpinEffect") then speedY = 360 end

		local defaultSpeed = Vector3.new(speedX, speedY, speedZ)
		local finalSpeed = part:GetAttribute("SpinSpeed") or defaultSpeed

		if spinningObjects[part] then
			spinningObjects[part].Speed = finalSpeed
			return
		end

		local fakePart = part:Clone()
		fakePart.Name = "SpinEffectFake"
		CollectionService:RemoveTag(fakePart, "SpinX")
		CollectionService:RemoveTag(fakePart, "SpinY")
		CollectionService:RemoveTag(fakePart, "SpinZ")
		CollectionService:RemoveTag(fakePart, "SpinEffect")

		for _, child in ipairs(fakePart:GetChildren()) do
			if not child:IsA("DataModelMesh") and not child:IsA("SurfaceAppearance") and not child:IsA("Texture") and not child:IsA("Decal") then
				child:Destroy()
			end
		end

		fakePart.Parent = Workspace.CurrentCamera 
		fakePart.Anchored = true
		fakePart.CanCollide = false
		part.Transparency = 1

		spinningObjects[part] = {
			FakePart = fakePart,
			Speed = finalSpeed,
			CurrentAngle = Vector3.new(0, 0, 0)
		}
	end
end

local function cleanupSpinEffect(part: Instance)
	if part:IsA("BasePart") then
		if part.Name == "SpinEffectFake" then return end 

		if not part.Parent then
			local data = spinningObjects[part]
			if data then
				if data.FakePart then data.FakePart:Destroy() end
				spinningObjects[part] = nil
			end
			return
		end

		local hasX = CollectionService:HasTag(part, "SpinX")
		local hasY = CollectionService:HasTag(part, "SpinY")
		local hasZ = CollectionService:HasTag(part, "SpinZ")
		local hasOld = CollectionService:HasTag(part, "SpinEffect")

		if hasX or hasY or hasZ or hasOld then
			if spinningObjects[part] then
				local speedX = hasX and 360 or 0
				local speedY = (hasY or hasOld) and 360 or 0
				local speedZ = hasZ and 360 or 0
				spinningObjects[part].Speed = part:GetAttribute("SpinSpeed") or Vector3.new(speedX, speedY, speedZ)
			end
			return
		end

		local data = spinningObjects[part]
		if data then
			if data.FakePart then data.FakePart:Destroy() end
			spinningObjects[part] = nil
		end
	end
end

-- Shine
local SHINE_MIN_DELAY = 1; local SHINE_MAX_DELAY = 4
local SHINE_FADE_IN_TIME = 0.3; local SHINE_FADE_OUT_TIME = 0.7
local SHINE_MAX_ROTATION = 45; local SHINE_MAX_SIZE_SCALE = 1.5

local function applyShineEffect(guiObject: Instance)
	if not guiObject:IsA("GuiObject") then return end
	if not shineTemplate then return end
	local shineThread = coroutine.wrap(function()
		while guiObject.Parent do
			task.wait(math.random() * (SHINE_MAX_DELAY - SHINE_MIN_DELAY) + SHINE_MIN_DELAY)
			if not guiObject.Parent then break end
			local newShine = shineTemplate:Clone()
			newShine.Position = UDim2.fromScale(math.random(), math.random())
			newShine.ImageTransparency = 1
			newShine.Rotation = math.random(-SHINE_MAX_ROTATION, SHINE_MAX_ROTATION)
			newShine.Parent = guiObject
			local originalSize = newShine.Size
			local targetSize = UDim2.fromOffset(originalSize.X.Offset * SHINE_MAX_SIZE_SCALE, originalSize.Y.Offset * SHINE_MAX_SIZE_SCALE)
			local fadeInTween = TweenService:Create(newShine, TweenInfo.new(SHINE_FADE_IN_TIME, Enum.EasingStyle.Quad), { ImageTransparency = 0, Rotation = math.random(-SHINE_MAX_ROTATION, SHINE_MAX_ROTATION), Size = targetSize })
			local fadeOutTween = TweenService:Create(newShine, TweenInfo.new(SHINE_FADE_OUT_TIME, Enum.EasingStyle.Quint, Enum.EasingDirection.In), { ImageTransparency = 1, Rotation = math.random(-SHINE_MAX_ROTATION, SHINE_MAX_ROTATION), Size = originalSize })
			fadeInTween:Play(); fadeInTween.Completed:Wait()
			if not newShine.Parent then break end
			fadeOutTween:Play(); fadeOutTween.Completed:Wait(); newShine:Destroy()
		end
	end)()
	activeShineThreads[guiObject] = shineThread
end

local function cleanupShineEffect(guiObject: Instance)
	if guiObject:IsA("GuiObject") and activeShineThreads[guiObject] then 
		task.cancel(activeShineThreads[guiObject]); activeShineThreads[guiObject] = nil 
	end
end

-- Pulse
local PULSE_SCALE = 1.1; local PULSE_DURATION = 0.8
local PULSE_INFO = TweenInfo.new(PULSE_DURATION, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true)

local function applyPulseEffect(guiObject: Instance)
	if not guiObject:IsA("GuiObject") then return end
	if activePulseData[guiObject] then return end
	local uiScale = guiObject:FindFirstChildOfClass("UIScale")
	local createdScale = false
	if not uiScale then uiScale = Instance.new("UIScale"); uiScale.Name="EffectScale"; uiScale.Parent = guiObject; createdScale = true end
	local pulseTween = TweenService:Create(uiScale, PULSE_INFO, {Scale = PULSE_SCALE})
	pulseTween:Play()
	activePulseData[guiObject] = {TweenIn = pulseTween, TweenOut = pulseTween, Scale = uiScale, CreatedScale = createdScale}
end

local function cleanupPulseEffect(guiObject: Instance)
	if not guiObject:IsA("GuiObject") then return end
	local data = activePulseData[guiObject]
	if data then
		if data.TweenIn then data.TweenIn:Cancel() end
		if data.Scale and data.Scale.Parent then data.Scale.Scale = 1 end
		if data.CreatedScale and data.Scale then data.Scale:Destroy() end
		activePulseData[guiObject] = nil
	end
end

--================------------------------------------------------
-- ## SCREEN EFFECTS (HIGHLIGHT LIGHT) ##
--================------------------------------------------------

local function HighlightLight()
	local gui = playerGui:FindFirstChild("GUI")
	if not gui then return end
	local effectFrame = gui:FindFirstChild("Effect")
	if not effectFrame then return end

	local originalFOV = 70 
	if camera then
		originalFOV = camera.FieldOfView
		local targetFOV = math.min(originalFOV + FOV_BOOST, 120) 
		TweenService:Create(camera, FOV_TWEEN_INFO_IN, {FieldOfView = targetFOV}):Play()
	end

	effectFrame.Visible = true

	for _, child in ipairs(effectFrame:GetChildren()) do
		if child:IsA("ImageLabel") then
			child.ImageColor3 = SUCCESS_COLOR
			child.ImageTransparency = 0
		end
	end

	task.wait(0.5)

	if camera then
		TweenService:Create(camera, FOV_TWEEN_INFO_OUT, {FieldOfView = originalFOV}):Play()
	end

	for _, child in ipairs(effectFrame:GetChildren()) do
		if child:IsA("ImageLabel") then
			TweenService:Create(child, EFFECT_FADE_OUT_INFO, {ImageTransparency = 1}):Play()
		end
	end

	task.wait(EFFECT_FADE_OUT_INFO.Time)
	effectFrame.Visible = false

	for _, child in ipairs(effectFrame:GetChildren()) do
		if child:IsA("ImageLabel") then
			child.ImageTransparency = 0 
		end
	end
end

--================------------------------------------------------
-- ## EFFECTS LOOP ##
--================------------------------------------------------
RunService.Heartbeat:Connect(function(dt: number)
	-- Process 2D Sunbursts
	for guiObject, _ in pairs(sunburstObjects) do
		if guiObject and guiObject.Parent then
			guiObject.Rotation += (SUNBURST_ROTATION_SPEED or 20) * dt
		else
			sunburstObjects[guiObject] = nil
		end
	end

	-- Process 2D Blades ## ADDED ##
	for guiObject, _ in pairs(bladeObjects) do
		if guiObject and guiObject.Parent then
			guiObject.Rotation += (BLADE_ROTATION_SPEED or 500) * dt
		else
			bladeObjects[guiObject] = nil
		end
	end

	-- Process Rainbow Colors
	local hue = (tick() * RAINBOW_SPEED) % 1
	local rainbowColor = Color3.fromHSV(hue, 1, 1)
	for part, _ in pairs(rainbowObjects) do
		if part and part.Parent then part.Color = rainbowColor else rainbowObjects[part] = nil end
	end

	-- Process Rotating Gradients
	for gradient, speed in pairs(rotatingGradients) do
		if gradient and gradient.Parent then
			gradient.Rotation = (gradient.Rotation + (speed or 90) * dt) % 360
		else
			rotatingGradients[gradient] = nil
		end
	end

	-- Process Panning Gradients
	for gradient, config in pairs(panningGradients) do
		if gradient and gradient.Parent then
			local offset = math.sin(tick() * config.Speed) * config.Range
			gradient.Offset = Vector2.new(offset, 0)
		else
			panningGradients[gradient] = nil
		end
	end

	-- Process 3D Spinning Objects
	for part, data in pairs(spinningObjects) do
		if part.Parent and data.FakePart.Parent then
			data.CurrentAngle += data.Speed * dt
			data.FakePart.CFrame = part.CFrame * CFrame.Angles(
				math.rad(data.CurrentAngle.X), 
				math.rad(data.CurrentAngle.Y), 
				math.rad(data.CurrentAngle.Z)
			)
		else
			cleanupSpinEffect(part)
		end
	end
end)


--================--------------------------------================
-- ## INITIALIZATION & MONITORS ##
--================------------------------------------------------
local function setupTag(tagName: string, applyFunction: (Instance) -> (), cleanupFunction: (Instance) -> ())
	for _, instance in ipairs(CollectionService:GetTagged(tagName)) do task.spawn(applyFunction, instance) end
	CollectionService:GetInstanceAddedSignal(tagName):Connect(function(instance: Instance) task.spawn(applyFunction, instance) end)
	CollectionService:GetInstanceRemovedSignal(tagName):Connect(function(instance: Instance) task.spawn(cleanupFunction, instance) end)
end

-- Wire up all CollectionService tags
setupTag("SunburstEffect", applySunburstEffect, cleanupSunburstEffect)
setupTag("BladeEffect", applyBladeEffect, cleanupBladeEffect) -- ## ADDED ##
setupTag("Rainbow", applyRainbowEffect, cleanupRainbowEffect)
setupTag("RotatingGradient", applyRotatingGradient, cleanupRotatingGradient)
setupTag("PanningGradient", applyPanningGradient, cleanupPanningGradient)
setupTag("PhysicalButton", applyPhysicalButtonEffect, cleanupPhysicalButtonEffect)

setupTag("ShineEffect", applyShineEffect, cleanupShineEffect)
setupTag("PulseEffect", applyPulseEffect, cleanupPulseEffect)

setupTag("SpinX", applySpinEffect, cleanupSpinEffect)
setupTag("SpinY", applySpinEffect, cleanupSpinEffect)
setupTag("SpinZ", applySpinEffect, cleanupSpinEffect)
setupTag("SpinEffect", applySpinEffect, cleanupSpinEffect) 

-- Dynamic UI Button Monitor
local function processGuiElement(element: Instance)
	if element:IsA("TextButton") or element:IsA("ImageButton") then
		task.defer(function()
			if element and element.Parent then
				applyUniversalButtonLogic(element)
			end
		end)
	end
end

for _, child in ipairs(playerGui:GetDescendants()) do processGuiElement(child) end
playerGui.DescendantAdded:Connect(processGuiElement)
playerGui.DescendantRemoving:Connect(function(element)
	if element:IsA("GuiButton") then cleanupButtonLogic(element) end
end)

-- Plot UI Monitor
local function monitorPlotUI()
	local plotName = "Plot_" .. player.Name
	local plot = Workspace:WaitForChild(plotName, 5)
	if not plot then return end

	local function onPlotDescendantAdded(descendant: Instance)
		if descendant:IsA("TextButton") or descendant:IsA("ImageButton") then
			task.wait() 
			applyUniversalButtonLogic(descendant)
		end
	end

	plot.DescendantAdded:Connect(onPlotDescendantAdded)
	for _, child in ipairs(plot:GetDescendants()) do
		onPlotDescendantAdded(child)
	end
end
task.spawn(monitorPlotUI)

-- Screen Event Listener
local triggerEvent = Events:WaitForChild("TriggerUIEffect", 5)
if triggerEvent then
	triggerEvent.OnClientEvent:Connect(function(effectName, ...)
		if effectName == "HighlightLight" then
			HighlightLight()
		end
	end)
end

print("[UIEffects] Systems Ready.")