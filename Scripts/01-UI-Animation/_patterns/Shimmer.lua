--[[
	Shimmer  (ModuleScript)
	A diagonal "shine" that sweeps across a button, card or label every few seconds.

	Technique: a UIGradient whose Transparency is a narrow opaque band in the middle
	(transparent at both ends). Tweening gradient.Offset from (-1, 0) to (1, 0) slides that
	band across the object. Rotation tilts the band.

	Derived from techniques in:
	  - punching-simulator  StarterGui/.../Effect/LocalScript   (Offset -1 -> 1, Linear 0.4 s, every 2 s)
	  - punching-simulator  Multiplier/LocalScript              (rainbow colour sweep, flip Rotation each pass)
	  - steal-a-brainrot-sab-files Packages/Shime (studied only, decompiled so not copied): overlay frame that copies
	    the parent's UICorner, transparency keypoints 0.15 / 0.5 / 0.85, Rotation 15

	Usage (LocalScript):
		local Shimmer = require(game.ReplicatedStorage.UI.Shimmer)

		-- looping white shine over a buy button
		local stop = Shimmer.attach(buyButton, { period = 2.5, duration = 0.6, angle = 20 })
		-- later: stop()

		-- one sweep (e.g. when an item becomes affordable)
		Shimmer.sweepOnce(buyButton)

		-- shine an EXISTING gradient (e.g. on a TextLabel's text) instead of adding an overlay
		Shimmer.onGradient(titleLabel.UIGradient, { period = 3 })

	Notes:
	  * The overlay is a Frame the size of the target, so it follows rounded corners if the target
	    has a UICorner (it is copied). For irregular image shapes prefer onGradient on the image.
	  * The overlay never blocks clicks (Active = false, no Interactable change needed for Frames).
]]

local TweenService = game:GetService("TweenService")

local Shimmer = {}

local DEFAULTS = {
	period = 2.5, -- seconds between sweeps (start to start)
	duration = 0.6, -- seconds per sweep
	angle = 20, -- band tilt in degrees
	width = 0.3, -- band width as a fraction of the object (0..1)
	strength = 0.45, -- band transparency at its brightest (0 = solid, 1 = invisible)
	color = Color3.new(1, 1, 1),
	easing = Enum.EasingStyle.Quad,
	direction = Enum.EasingDirection.InOut,
	startDelay = 0,
}

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

-- Builds the NumberSequence for a band of the given width centred at 0.5.
function Shimmer.bandTransparency(width: number, strength: number): NumberSequence
	local half = math.clamp(width, 0.02, 0.98) / 2
	return NumberSequence.new({
		NumberSequenceKeypoint.new(0, 1),
		NumberSequenceKeypoint.new(0.5 - half, 1),
		NumberSequenceKeypoint.new(0.5, strength),
		NumberSequenceKeypoint.new(0.5 + half, 1),
		NumberSequenceKeypoint.new(1, 1),
	})
end

local function makeOverlay(target: GuiObject, o)
	local overlay = Instance.new("Frame")
	overlay.Name = "ShimmerOverlay"
	overlay.BackgroundColor3 = o.color
	overlay.BackgroundTransparency = 0
	overlay.BorderSizePixel = 0
	overlay.AnchorPoint = Vector2.new(0.5, 0.5)
	overlay.Position = UDim2.fromScale(0.5, 0.5)
	overlay.Size = UDim2.fromScale(1, 1)
	overlay.ZIndex = target.ZIndex + 1
	overlay.Active = false

	local corner = target:FindFirstChildOfClass("UICorner")
	if corner then
		local c = Instance.new("UICorner")
		c.CornerRadius = corner.CornerRadius
		c.Parent = overlay
	end

	local gradient = Instance.new("UIGradient")
	gradient.Rotation = o.angle
	gradient.Transparency = Shimmer.bandTransparency(o.width, o.strength)
	gradient.Offset = Vector2.new(-1, 0)
	gradient.Parent = overlay

	overlay.Parent = target
	return overlay, gradient
end

local function sweep(gradient: UIGradient, o): Tween
	gradient.Offset = Vector2.new(-1, 0)
	local tw = TweenService:Create(gradient, TweenInfo.new(o.duration, o.easing, o.direction), { Offset = Vector2.new(1, 0) })
	tw:Play()
	return tw
end

local function loop(gradient: UIGradient, o, isAlive: () -> boolean)
	return task.spawn(function()
		if o.startDelay > 0 then
			task.wait(o.startDelay)
		end
		while isAlive() do
			local tw = sweep(gradient, o)
			tw.Completed:Wait()
			gradient.Offset = Vector2.new(-1, 0)
			task.wait(math.max(0, o.period - o.duration))
		end
	end)
end

-- Adds a looping shine overlay to target. Returns stop().
function Shimmer.attach(target: GuiObject, opts)
	local o = merge(opts)
	local overlay, gradient = makeOverlay(target, o)
	local alive = true
	local thread = loop(gradient, o, function()
		return alive and overlay.Parent ~= nil
	end)
	return function()
		alive = false
		if coroutine.status(thread) == "suspended" then
			task.cancel(thread)
		end
		overlay:Destroy()
	end
end

-- Single sweep, overlay removed afterwards. Returns the tween.
function Shimmer.sweepOnce(target: GuiObject, opts)
	local o = merge(opts)
	local overlay, gradient = makeOverlay(target, o)
	local tw = sweep(gradient, o)
	tw.Completed:Once(function()
		overlay:Destroy()
	end)
	return tw
end

-- Colour band for shining TEXT or images: baseColor everywhere, highlight in the band.
-- (A transparency band would hide the text outside the band, so text shines through Color instead.)
function Shimmer.bandColor(baseColor: Color3, highlight: Color3, width: number): ColorSequence
	local half = math.clamp(width, 0.02, 0.98) / 2
	return ColorSequence.new({
		ColorSequenceKeypoint.new(0, baseColor),
		ColorSequenceKeypoint.new(0.5 - half, baseColor),
		ColorSequenceKeypoint.new(0.5, highlight),
		ColorSequenceKeypoint.new(0.5 + half, baseColor),
		ColorSequenceKeypoint.new(1, baseColor),
	})
end

-- Loops a sweep on an existing UIGradient (e.g. on a TextLabel, set TextColor3 to white).
-- Its Color becomes baseColor with a highlight band, unless keepColor = true (you authored
-- the band yourself). Transparency is never touched. Returns stop().
function Shimmer.onGradient(gradient: UIGradient, opts)
	local o = merge(opts)
	if not (opts and opts.keepColor) then
		local base = (opts and opts.baseColor) or gradient.Color.Keypoints[1].Value
		gradient.Color = Shimmer.bandColor(base, o.color, o.width)
	end
	if opts and opts.angle then
		gradient.Rotation = opts.angle
	end
	local alive = true
	local thread = loop(gradient, o, function()
		return alive and gradient.Parent ~= nil
	end)
	return function()
		alive = false
		if coroutine.status(thread) == "suspended" then
			task.cancel(thread)
		end
		gradient.Offset = Vector2.new(-1, 0) -- park the band off the object
	end
end

return Shimmer
