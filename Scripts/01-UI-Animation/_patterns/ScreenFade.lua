--[[
	ScreenFade  (ModuleScript)
	Full-screen transitions without touching the camera: fade to a colour, run your code
	while the screen is covered (teleport, load map, swap UI), fade back. Optional title
	that types itself in, plus a quick coloured flash for hits / rewards.

	Derived from techniques in:
	  - pet-rng        Engine/Modules/Transition  (frame BackgroundTransparency 1 -> 0 in 0.25 s, title MaxVisibleGraphemes
	                                               tween, MoveTo while covered, everything back to 1 in 0.25 s)
	  - please-donate  Modules/Guis               (StartLoading / StopLoading: 0.15 s in, 0.25 s out, Quint)
	  - smash-egg-for-animals RunAlertClient      (flash frame at 0.45 transparency fading to 1 in 0.5 s Quad-out)
	  - smash-egg-for-animals EventStack          (black fade when night falls)

	Usage (LocalScript):
		local ScreenFade = require(game.ReplicatedStorage.UI.ScreenFade)

		-- yields until the whole transition is over
		ScreenFade.transition(function()
			character:PivotTo(targetCFrame)  -- happens while the screen is fully covered
		end, { title = "Entering the Volcano...", color = Color3.new(0, 0, 0), hold = 0.6 })

		ScreenFade.flash(Color3.fromRGB(255, 40, 40), 0.45, 0.5) -- damage flash
		ScreenFade.fadeOut(0.3) ; task.wait(1) ; ScreenFade.fadeIn(0.3)
]]

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local ScreenFade = {}

local gui: ScreenGui? = nil
local cover: Frame? = nil
local title: TextLabel? = nil

local function ensure()
	if gui and gui.Parent and cover and title then
		return gui, cover, title
	end
	local player = Players.LocalPlayer
	local g = Instance.new("ScreenGui")
	g.Name = "ScreenFade"
	g.IgnoreGuiInset = true -- also cover the top bar
	g.ResetOnSpawn = false
	g.DisplayOrder = 1000
	g.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

	local f = Instance.new("Frame")
	f.Name = "Cover"
	f.BorderSizePixel = 0
	f.BackgroundColor3 = Color3.new(0, 0, 0)
	f.BackgroundTransparency = 1
	f.Size = UDim2.fromScale(1, 1)
	f.Active = false
	f.Parent = g

	local t = Instance.new("TextLabel")
	t.Name = "Title"
	t.BackgroundTransparency = 1
	t.AnchorPoint = Vector2.new(0.5, 0.5)
	t.Position = UDim2.fromScale(0.5, 0.5)
	t.Size = UDim2.fromScale(0.8, 0.1)
	t.FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json")
	t.TextScaled = true
	t.TextColor3 = Color3.new(1, 1, 1)
	t.TextTransparency = 1
	t.Text = ""
	t.ZIndex = 2
	t.Parent = g
	local stroke = Instance.new("UIStroke")
	stroke.Thickness = 3
	stroke.Transparency = 1
	stroke.Parent = t

	g.Parent = player:WaitForChild("PlayerGui")
	gui, cover, title = g, f, t
	return g, f, t
end

-- Cover the screen. Yields for `time` seconds.
function ScreenFade.fadeOut(time: number?, color: Color3?)
	local _, f = ensure()
	if color then
		f.BackgroundColor3 = color
	end
	f.Active = true -- block clicks while covered
	local tw = TweenService:Create(f, TweenInfo.new(time or 0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { BackgroundTransparency = 0 })
	tw:Play()
	tw.Completed:Wait()
end

-- Uncover the screen. Yields for `time` seconds.
function ScreenFade.fadeIn(time: number?)
	local _, f, t = ensure()
	local info = TweenInfo.new(time or 0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
	TweenService:Create(t, info, { TextTransparency = 1 }):Play()
	TweenService:Create(t:FindFirstChildOfClass("UIStroke") :: UIStroke, info, { Transparency = 1 }):Play()
	local tw = TweenService:Create(f, info, { BackgroundTransparency = 1 })
	tw:Play()
	tw.Completed:Wait()
	f.Active = false
end

-- Typewriter title on the cover (pet-rng trick: tween MaxVisibleGraphemes directly).
function ScreenFade.showTitle(text: string, typeTime: number?)
	local _, _, t = ensure()
	t.Text = text
	t.MaxVisibleGraphemes = 0
	t.TextTransparency = 0
	local stroke = t:FindFirstChildOfClass("UIStroke")
	if stroke then
		stroke.Transparency = 0
	end
	local count = utf8.len(text) or #text
	TweenService:Create(t, TweenInfo.new(typeTime or 0.6, Enum.EasingStyle.Linear), { MaxVisibleGraphemes = count }):Play()
end

-- Fade out, run midCallback while covered (errors are caught so the screen never stays black),
-- hold, fade back in. opts: { color, inTime, outTime, hold, title, typeTime }. Yields.
function ScreenFade.transition(midCallback: (() -> ())?, opts)
	opts = opts or {}
	ScreenFade.fadeOut(opts.inTime or 0.3, opts.color)
	if opts.title then
		ScreenFade.showTitle(opts.title, opts.typeTime)
	end
	if midCallback then
		local ok, err = pcall(midCallback)
		if not ok then
			warn("[ScreenFade] transition callback failed:", err)
		end
	end
	task.wait(opts.hold or 0.4)
	ScreenFade.fadeIn(opts.outTime or 0.35)
end

-- Quick coloured flash (does not block input). strength = starting opacity (0..1).
function ScreenFade.flash(color: Color3?, strength: number?, time: number?)
	local g = ensure()
	local f = Instance.new("Frame")
	f.Name = "Flash"
	f.BorderSizePixel = 0
	f.BackgroundColor3 = color or Color3.new(1, 1, 1)
	f.BackgroundTransparency = 1 - (strength or 0.45)
	f.Size = UDim2.fromScale(1, 1)
	f.ZIndex = 3
	f.Parent = g
	local tw = TweenService:Create(f, TweenInfo.new(time or 0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { BackgroundTransparency = 1 })
	tw.Completed:Once(function()
		f:Destroy()
	end)
	tw:Play()
end

return ScreenFade
