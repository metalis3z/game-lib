local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local SoundService = game:GetService("SoundService")
local TweenService = game:GetService("TweenService")

local HoverController = {}
local SUNBURST_SPEED = 45
local GRADIENT_SPEED = 90

local HOVER_SCALE = 0.95
local CLICK_SCALE = 0.87
local BOUNCE_SCALE = 0.98
local HOVER_ROTATE_DEG = 10
local HOVER_SOUND_VOLUME = 0.6

local TWEEN_HOVER_IN = TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local TWEEN_HOVER_OUT = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local TWEEN_CLICK_DOWN = TweenInfo.new(0.06, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local TWEEN_BOUNCE = TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
local TWEEN_ROTATE_IN = TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local TWEEN_ROTATE_OUT = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

-- Hover SFX. Built in code (not coupled to a SoundService asset) so the id is
-- the single source of truth. playPooledSound copies .SoundId / .TimeLength.
local HOVER_SOUND_ID = "rbxassetid://139295675611093"
local hoverSoundRef = Instance.new("Sound")
hoverSoundRef.Name = "_HoverSoundProto"
hoverSoundRef.SoundId = HOVER_SOUND_ID
hoverSoundRef.Volume = 1
hoverSoundRef.Parent = SoundService

local soundPool = {}
local POOL_SIZE = 6

local function initSoundPool()
	for i = 1, POOL_SIZE do
		local s = Instance.new("Sound")
		s.Volume = 1
		s.Parent = SoundService
		s.Name = "_HoverPool" .. i
		soundPool[i] = { instance = s, inUse = false }
	end
end

local function playPooledSound(soundRef, volume)
	if not soundRef then return end
	for _, entry in soundPool do
		if not entry.inUse then
			entry.inUse = true
			entry.instance.SoundId = soundRef.SoundId
			entry.instance.Volume = volume
			entry.instance:Play()
			task.delay(soundRef.TimeLength + 0.05, function()
				entry.inUse = false
			end)
			return
		end
	end
end

local buttonData = {}
local hoverGroups = {}  -- groupName -> set of buttons that hover/react together
local sunbursts = {}
local colorGradients = {}

local function cleanupButton(button)
	local data = buttonData[button]
	if not data then return end
	if data.currentTween then data.currentTween:Cancel() end
	if data.rotateTween then data.rotateTween:Cancel() end
	if data.sunburst then sunbursts[data.sunburst] = nil end
	if data.colorGradient then colorGradients[data.colorGradient] = nil end
	for _, conn in data.connections do
		conn:Disconnect()
	end
	if data.group and hoverGroups[data.group] then
		hoverGroups[data.group][button] = nil
	end
	if data.uiScale then data.uiScale:Destroy() end
	buttonData[button] = nil
end

local function animateTo(data, targetScale, tweenInfo)
	if data.currentTween then data.currentTween:Cancel() end
	data.currentTween = TweenService:Create(data.uiScale, tweenInfo, { Scale = targetScale })
	data.currentTween:Play()
end

local function animateRotateTo(data, targetRotation, tweenInfo)
	if not data.rotateIcon then return end
	if data.rotateTween then data.rotateTween:Cancel() end
	data.rotateTween = TweenService:Create(data.rotateIcon, tweenInfo, { Rotation = targetRotation })
	data.rotateTween:Play()
end

-- Buttons that share a "HoverGroup" attribute react together: hovering, pressing
-- or releasing any one drives the same animation on every member, so a cluster of
-- buttons reads as a single button.
local function groupMembers(data, button)
	if data.group and hoverGroups[data.group] then
		local list = {}
		for b in hoverGroups[data.group] do
			table.insert(list, b)
		end
		return list
	end
	return { button }
end

local function refreshGroup(button)
	local data = buttonData[button]
	if not data then return end
	local members = groupMembers(data, button)
	local anyHover, anyDown = false, false
	for _, b in members do
		local d = buttonData[b]
		if d then
			if d.isHovering then anyHover = true end
			if d.isDown then anyDown = true end
		end
	end
	local scale = anyDown and CLICK_SCALE or (anyHover and HOVER_SCALE or 1)
	local scaleTween = anyDown and TWEEN_CLICK_DOWN or (anyHover and TWEEN_HOVER_IN or TWEEN_HOVER_OUT)
	for _, b in members do
		local d = buttonData[b]
		if d then
			if not d.noScale then
				animateTo(d, scale, scaleTween)
			end
			animateRotateTo(d, anyHover and d.rotateDeg or 0, anyHover and TWEEN_ROTATE_IN or TWEEN_ROTATE_OUT)
		end
	end
end

local function setupButton(button)
	if buttonData[button] then return end
	if not button:IsA("GuiButton") then return end
	if button:GetAttribute("NoHover") then return end

	local uiScale = button:FindFirstChild("HoverScale")
	if not uiScale then
		uiScale = Instance.new("UIScale")
		uiScale.Name = "HoverScale"
		uiScale.Parent = button
	end
	uiScale.Scale = 1

	local rotateIcon = button:FindFirstChild("RotateIcon")
	if button:GetAttribute("RotateSelf") then rotateIcon = button end
	local rotateDeg = button:GetAttribute("RotateDeg") or HOVER_ROTATE_DEG
	local noScale = button:GetAttribute("NoScale") == true
	local sunburst = button:FindFirstChild("Sunburst")
	if sunburst then sunbursts[sunburst] = true end
	if button:GetAttribute("SpinSelf") then sunbursts[button] = true end
	if button:GetAttribute("RotateSelf") then sunbursts[button] = nil end

	local colorStroke = button:FindFirstChild("Color")
	local colorGradient = colorStroke and colorStroke:FindFirstChildWhichIsA("UIGradient")
	if colorGradient then colorGradients[colorGradient] = true end

	local groupName = button:GetAttribute("HoverGroup")

	local data = {
		uiScale = uiScale,
		rotateIcon = rotateIcon,
		rotateDeg = rotateDeg,
		noScale = noScale,
		sunburst = sunburst,
		colorGradient = colorGradient,
		group = groupName,
		currentTween = nil,
		rotateTween = nil,
		isHovering = false,
		isDown = false,
		connections = {},
	}
	buttonData[button] = data
	if groupName then
		hoverGroups[groupName] = hoverGroups[groupName] or {}
		hoverGroups[groupName][button] = true
	end

	data.connections[1] = button.MouseEnter:Connect(function()
		-- only play the hover SFX when the group wasn't already hovered
		local alreadyHover = false
		for _, b in groupMembers(data, button) do
			local d = buttonData[b]
			if d and d.isHovering then alreadyHover = true break end
		end
		data.isHovering = true
		if not alreadyHover then
			playPooledSound(hoverSoundRef, HOVER_SOUND_VOLUME)
		end
		refreshGroup(button)
	end)

	data.connections[2] = button.MouseLeave:Connect(function()
		data.isHovering = false
		data.isDown = false
		if groupName then
			-- brief debounce so sliding between grouped buttons doesn't flicker
			task.delay(0.03, function()
				if buttonData[button] then refreshGroup(button) end
			end)
		else
			refreshGroup(button)
		end
	end)

	data.connections[3] = button.MouseButton1Down:Connect(function()
		data.isDown = true
		refreshGroup(button)
	end)

	data.connections[4] = button.MouseButton1Up:Connect(function()
		data.isDown = false
		for _, b in groupMembers(data, button) do
			local d = buttonData[b]
			if d and not d.noScale then
				animateTo(d, BOUNCE_SCALE, TWEEN_BOUNCE)
			end
		end
		task.delay(0.25, function()
			if buttonData[button] then refreshGroup(button) end
		end)
	end)

	data.connections[5] = button.Destroying:Connect(function()
		cleanupButton(button)
	end)
end

function HoverController.Init()
	initSoundPool()

	-- 30 Hz: at 45-90 deg/s these rotations step ~1.5-3 deg per update --
	-- visually identical, but per-frame Rotation writes re-rasterized every
	-- gradient-carrying element at the full client framerate.
	local ROTATE_INTERVAL = 1 / 30
	local rotateAccum = 0
	RunService.Heartbeat:Connect(function(dt)
		rotateAccum += dt
		if rotateAccum < ROTATE_INTERVAL then return end
		dt = rotateAccum
		rotateAccum = 0
		for sunburst in sunbursts do
			sunburst.Rotation = (sunburst.Rotation + SUNBURST_SPEED * dt) % 360
		end
		for gradient in colorGradients do
			gradient.Rotation = (gradient.Rotation + GRADIENT_SPEED * dt) % 360
		end
	end)

	local player = Players.LocalPlayer
	local playerGui = player:WaitForChild("PlayerGui")

	local buttonCount = 0
	for _, desc in playerGui:GetDescendants() do
		if desc:IsA("ImageButton") or desc:IsA("TextButton") then
			buttonCount += 1
			task.spawn(setupButton, desc)
		elseif desc:GetAttribute("SpinSelf") then
			sunbursts[desc] = true
		end
	end

	playerGui.DescendantAdded:Connect(function(desc)
		if desc:IsA("ImageButton") or desc:IsA("TextButton") then
			task.defer(setupButton, desc)
		elseif desc:GetAttribute("SpinSelf") then
			sunbursts[desc] = true
		end
	end)

	playerGui.DescendantRemoving:Connect(function(desc)
		if buttonData[desc] then
			cleanupButton(desc)
		end
		if sunbursts[desc] then
			sunbursts[desc] = nil
		end
	end)
end

return HoverController