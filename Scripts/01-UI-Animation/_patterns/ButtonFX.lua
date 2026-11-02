--[[
	ButtonFX  (ModuleScript)
	Hover / press / release feedback for GuiButtons, driven by a UIScale so layouts never shift.

	Derived from techniques in:
	  - brainrot-lab   UIEffects.client          (hover 1.05 / click 0.95, Quint easing, auto-bind every button)
	  - drill-and-mine HoverController           (cancel previous tween, Back "bounce" on release, icon tilt)
	  - smash-egg-for-animals UIEffects.client   (pitch-randomised sounds, mobile tap fallback via Activated)

	Usage (LocalScript):
		local ButtonFX = require(game.ReplicatedStorage.UI.ButtonFX)

		-- a single button
		local cleanup = ButtonFX.attach(script.Parent.PlayButton, {
			hoverScale = 1.06,
			pressScale = 0.92,
			hoverSound = game.SoundService.UI.Hover,  -- optional Sound
			clickSound = game.SoundService.UI.Click,  -- optional Sound
			tiltTarget = script.Parent.PlayButton.Icon, -- optional: an icon that tilts on hover
		})

		-- every button under PlayerGui, including buttons created later
		ButtonFX.autoBind(game.Players.LocalPlayer:WaitForChild("PlayerGui"))

	Opt-out: set attribute NoFx = true on a button (or pass ignoreAttribute = "SomethingElse").
	If the button already has a UIScale (e.g. for screen scaling) it is reused and its current
	Scale is treated as the resting value, so the two never fight.
]]

local TweenService = game:GetService("TweenService")
local SoundService = game:GetService("SoundService")

local ButtonFX = {}

local DEFAULTS = {
	hoverScale = 1.05,
	pressScale = 0.92,
	hoverInfo = TweenInfo.new(0.15, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
	pressInfo = TweenInfo.new(0.08, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
	releaseInfo = TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
	tiltDegrees = 10,
	pitchJitter = 0.04, -- +/- PlaybackSpeed variation so repeated clicks never sound identical
	soundDebounce = 0.05,
	ignoreAttribute = "NoFx",
}

local bound = setmetatable({}, { __mode = "k" }) -- [GuiButton] = cleanup function
local lastSoundAt = 0

local function merge(opts)
	local o = {}
	for k, v in pairs(DEFAULTS) do
		o[k] = v
	end
	if opts then
		for k, v in pairs(opts) do
			o[k] = v
		end
	end
	return o
end

local function playSound(sound, jitter, debounce)
	if not sound then
		return
	end
	local now = os.clock()
	if now - lastSoundAt < debounce then
		return
	end
	lastSoundAt = now
	sound.PlaybackSpeed = 1 + (math.random() * 2 - 1) * jitter
	SoundService:PlayLocalSound(sound)
end

local function getScale(button)
	local scale = button:FindFirstChildOfClass("UIScale")
	if not scale then
		scale = Instance.new("UIScale")
		scale.Name = "FxScale"
		scale.Parent = button
	end
	if button:GetAttribute("FxBaseScale") == nil then
		button:SetAttribute("FxBaseScale", scale.Scale)
	end
	return scale
end

-- Attach FX to one button. Returns a cleanup function.
function ButtonFX.attach(button: GuiButton, opts)
	if bound[button] then
		return bound[button]
	end
	local o = merge(opts)
	if o.ignoreAttribute and button:GetAttribute(o.ignoreAttribute) then
		return function() end
	end

	local scale = getScale(button)
	local base = button:GetAttribute("FxBaseScale") or 1
	local hovering = false
	local currentTween: Tween? = nil
	local tiltTween: Tween? = nil
	local baseTilt = o.tiltTarget and o.tiltTarget.Rotation or 0
	local connections = {}

	local function scaleTo(factor, info)
		if currentTween then
			currentTween:Cancel()
		end
		currentTween = TweenService:Create(scale, info, { Scale = base * factor })
		currentTween:Play()
	end

	local function tiltTo(deg, info)
		if not o.tiltTarget then
			return
		end
		if tiltTween then
			tiltTween:Cancel()
		end
		tiltTween = TweenService:Create(o.tiltTarget, info, { Rotation = baseTilt + deg })
		tiltTween:Play()
	end

	table.insert(connections, button.MouseEnter:Connect(function()
		hovering = true
		playSound(o.hoverSound, o.pitchJitter, o.soundDebounce)
		scaleTo(o.hoverScale, o.hoverInfo)
		tiltTo(o.tiltDegrees, o.hoverInfo)
	end))

	table.insert(connections, button.MouseLeave:Connect(function()
		hovering = false
		scaleTo(1, o.releaseInfo)
		tiltTo(0, o.releaseInfo)
	end))

	table.insert(connections, button.MouseButton1Down:Connect(function()
		scaleTo(o.pressScale, o.pressInfo)
	end))

	table.insert(connections, button.MouseButton1Up:Connect(function()
		scaleTo(hovering and o.hoverScale or 1, o.releaseInfo)
	end))

	-- Activated also fires for touch and gamepad, where MouseEnter never happens:
	-- squash then spring back so mobile players still get feedback.
	table.insert(connections, button.Activated:Connect(function()
		playSound(o.clickSound, o.pitchJitter, 0)
		if not hovering then
			scaleTo(o.pressScale, o.pressInfo)
			task.delay(o.pressInfo.Time + 0.04, function()
				if not hovering and button.Parent then
					scaleTo(1, o.releaseInfo)
				end
			end)
		end
	end))

	local function cleanup()
		for _, c in ipairs(connections) do
			c:Disconnect()
		end
		table.clear(connections)
		if currentTween then
			currentTween:Cancel()
		end
		if tiltTween then
			tiltTween:Cancel()
		end
		if scale.Parent then
			scale.Scale = base
		end
		bound[button] = nil
	end

	table.insert(connections, button.Destroying:Connect(cleanup))
	bound[button] = cleanup
	return cleanup
end

-- Bind every GuiButton below root (now and later). Returns a function that unbinds everything.
function ButtonFX.autoBind(root: Instance, opts)
	local function try(inst)
		if inst:IsA("GuiButton") then
			-- defer: let the script that created the button finish setting it up first
			task.defer(function()
				if inst.Parent then
					ButtonFX.attach(inst, opts)
				end
			end)
		end
	end
	for _, d in ipairs(root:GetDescendants()) do
		try(d)
	end
	local added = root.DescendantAdded:Connect(try)
	return function()
		added:Disconnect()
		for _, d in ipairs(root:GetDescendants()) do
			local c = bound[d]
			if c then
				c()
			end
		end
	end
end

function ButtonFX.detach(button: GuiButton)
	local c = bound[button]
	if c then
		c()
	end
end

return ButtonFX
