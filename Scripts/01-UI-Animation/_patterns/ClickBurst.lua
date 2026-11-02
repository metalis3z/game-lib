--[[
	ClickBurst  (ModuleScript)
	Camera-free 2D particle bursts made of Frames: sparkle on every click / tap, coin burst
	from a button, "+$100" floating text. No ParticleEmitters, no 3D, no assets needed.

	Derived from techniques in:
	  - drill-and-mine ClickEffect           (8 dots + 8 streaks fly outward at random angles, shrink and fade in 0.5 s;
	                                          GuiService:GetGuiInset() correction for click positions)
	  - brainrot-lab   PopUpController        (reward text pops at a random spot near centre, Back-out size pop,
	                                          then floats up 15% and fades)
	  - smash-egg-for-animals MoneyHandler   ("+$N" bursts out to the side growing from 0.3 scale, then rises and fades;
	                                          several gains in the same 0.12 s are merged into one popup)

	Usage (LocalScript):
		local ClickBurst = require(game.ReplicatedStorage.UI.ClickBurst)

		ClickBurst.enableClickSparkles()                       -- sparkle wherever the player clicks / taps
		-- burstAt takes full-screen pixels. A button inside a normal ScreenGui (IgnoreGuiInset = false)
		-- needs the top-bar inset added: + Vector2.new(0, GuiService:GetGuiInset().Y)
		ClickBurst.burstAt(button.AbsolutePosition + button.AbsoluteSize / 2, { color = Color3.fromRGB(255, 215, 0) })
		ClickBurst.floatText("+$250", Vector2.new(500, 300), { color = Color3.fromRGB(120, 255, 90) })
]]

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local ClickBurst = {}

local layer: ScreenGui? = nil

local function getLayer(): ScreenGui
	if layer and layer.Parent then
		return layer
	end
	local g = Instance.new("ScreenGui")
	g.Name = "ClickBurstLayer"
	g.IgnoreGuiInset = true -- positions below are full-screen pixel coordinates
	g.ResetOnSpawn = false
	g.DisplayOrder = 99
	g.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	g.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")
	layer = g
	return g
end

local function particle(pos: Vector2, size: Vector2, rotation: number, color: Color3, round: boolean)
	local f = Instance.new("Frame")
	f.AnchorPoint = Vector2.new(0.5, 0.5)
	f.BackgroundColor3 = color
	f.BorderSizePixel = 0
	f.Position = UDim2.fromOffset(pos.X, pos.Y)
	f.Size = UDim2.fromOffset(size.X, size.Y)
	f.Rotation = rotation
	f.ZIndex = 100
	local c = Instance.new("UICorner")
	c.CornerRadius = round and UDim.new(1, 0) or UDim.new(0, 1)
	c.Parent = f
	f.Parent = getLayer()
	return f
end

local function fly(f: Frame, target: Vector2, lifetime: number)
	local tw = TweenService:Create(f, TweenInfo.new(lifetime, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		Position = UDim2.fromOffset(target.X, target.Y),
		Size = UDim2.fromOffset(0, 0),
		BackgroundTransparency = 1,
	})
	tw.Completed:Once(function()
		f:Destroy()
	end)
	tw:Play()
end

-- Radial burst of dots + streaks at a screen position (pixels, top-left of the screen incl. top bar).
-- opts: color, dots (8), streaks (8), radius (60), lifetime (0.5)
function ClickBurst.burstAt(pos: Vector2, opts)
	opts = opts or {}
	local color = opts.color or Color3.new(1, 1, 1)
	local radius = opts.radius or 60
	local lifetime = opts.lifetime or 0.5
	local dots, streaks = opts.dots or 8, opts.streaks or 8

	for i = 1, dots do
		local angle = (2 * math.pi / dots) * i + math.rad(math.random(-15, 15))
		local dist = radius * (0.5 + math.random() * 0.5)
		local s = math.random(4, 10)
		local f = particle(pos, Vector2.new(s, s), 0, color, true)
		fly(f, pos + Vector2.new(math.cos(angle), math.sin(angle)) * dist, lifetime)
	end
	for i = 1, streaks do
		local angle = (2 * math.pi / streaks) * i + math.pi / streaks + math.rad(math.random(-10, 10))
		local dist = radius * (0.4 + math.random() * 0.5)
		local f = particle(pos, Vector2.new(math.random(12, 28), 2), math.deg(angle), color, false)
		fly(f, pos + Vector2.new(math.cos(angle), math.sin(angle)) * dist, lifetime)
	end
end

-- Floating text that pops in and drifts up while fading. opts: color, size (TextSize, 36), rise (px, 90), stroke (Color3)
function ClickBurst.floatText(text: string, pos: Vector2, opts)
	opts = opts or {}
	local label = Instance.new("TextLabel")
	label.BackgroundTransparency = 1
	label.AnchorPoint = Vector2.new(0.5, 0.5)
	label.Position = UDim2.fromOffset(pos.X, pos.Y)
	label.Size = UDim2.fromOffset(300, 50)
	label.FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json")
	label.Text = text
	label.TextSize = opts.size or 36
	label.TextColor3 = opts.color or Color3.new(1, 1, 1)
	label.Rotation = math.random(-8, 8)
	label.ZIndex = 101
	local stroke = Instance.new("UIStroke")
	stroke.Thickness = 3
	stroke.Color = opts.stroke or Color3.fromRGB(20, 20, 20)
	stroke.Parent = label
	local scale = Instance.new("UIScale")
	scale.Scale = 0.3
	scale.Parent = label
	label.Parent = getLayer()

	TweenService:Create(scale, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), { Scale = 1 }):Play()
	task.delay(0.4, function()
		local info = TweenInfo.new(0.7, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
		TweenService:Create(label, info, { Position = UDim2.fromOffset(pos.X, pos.Y - (opts.rise or 90)), TextTransparency = 1 }):Play()
		TweenService:Create(stroke, info, { Transparency = 1 }):Play()
		local s = TweenService:Create(scale, info, { Scale = 0.8 })
		s.Completed:Once(function()
			label:Destroy()
		end)
		s:Play()
	end)
end

-- Sparkle at every mouse click / touch. Returns disconnect().
function ClickBurst.enableClickSparkles(opts)
	local conn = UserInputService.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			-- input.Position is measured below the top-bar inset, but our layer uses IgnoreGuiInset = true
			-- (its 0,0 is the real screen corner), so add the inset height -- same fix as drill-and-mine ClickEffect.
			local p = input.Position
			ClickBurst.burstAt(Vector2.new(p.X, p.Y + game:GetService("GuiService"):GetGuiInset().Y), opts)
		end
	end)
	return function()
		conn:Disconnect()
	end
end

return ClickBurst
