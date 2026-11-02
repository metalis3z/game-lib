-- SurfaceModeController: underground (in the zones) the level bar slides up
-- and away and the red Surface button slides smoothly down from the top;
-- on the way back up the button slides away first, then the bar slides back
-- down. Pressing the button teleports back to the surface.
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TextService = game:GetService("TextService")
local TweenService = game:GetService("TweenService")

local UNDERGROUND_Y = -4 -- below the TPBack floor slab

local SURFACE_BUTTON_SCALE = 1.2 -- original size, just a bit bigger
local HIDE_OFFSET = UDim2.fromScale(0, 0.45) -- how far things slide up off-screen

local TWEEN_OUT = TweenInfo.new(0.28, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
local TWEEN_IN = TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out)

local plr = Players.LocalPlayer
local playerGui = plr:WaitForChild("PlayerGui")
local surfacePart = workspace:WaitForChild("Assets"):WaitForChild("Teleports"):WaitForChild("Surface")

local levelReadout, surfaceBtn, topButtons
local readoutShownPos, topShownPos
local topScale

-- Title + Double drop-shadow pair: with TextScaled, the glyphs re-fit in
-- INTEGER size jumps during the appear (0.6->1.2 Back-Out) and hover
-- (1->0.95/0.87) UIScale tweens while the -3px shadow offset and the
-- stroke thickness scale CONTINUOUSLY -- every jump momentarily exposed
-- the back copy's black stroke through the front text ("shadow clips
-- through on hover"). Fixed TextSize computed from the PRE-scale box
-- renders the whole pair as one rigid transform: glyphs, strokes and the
-- shadow lip now scale in perfect lockstep. Recomputed on viewport
-- resize (the box is Scale-sized), so it stays responsive.
local surfaceTextBoxY = nil
local function fitSurfaceText()
	if not surfaceBtn then return end
	local title = surfaceBtn:FindFirstChild("Title")
	local dbl = title and title:FindFirstChild("Double")
	if not (title and dbl) then return end
	-- divide every ancestor UIScale (SurfaceScale, HoverScale) out of
	-- AbsoluteSize so the fit is stable no matter when this runs
	local scaleProduct = 1
	local cur = title
	while cur and not cur:IsA("LayerCollector") do
		if cur:IsA("GuiObject") then
			for _, c in ipairs(cur:GetChildren()) do
				if c:IsA("UIScale") then
					scaleProduct *= c.Scale
				end
			end
		end
		cur = cur.Parent
	end
	if scaleProduct < 1e-3 then return end
	local box = title.AbsoluteSize / scaleProduct
	if box.X < 2 or box.Y < 2 then return end
	if surfaceTextBoxY and math.abs(box.Y - surfaceTextBoxY) < 0.75 then return end
	local params = Instance.new("GetTextBoundsParams")
	params.Font = title.FontFace
	params.Text = title.Text
	params.Size = 100
	params.Width = 100000
	local ok, bounds = pcall(TextService.GetTextBoundsAsync, TextService, params)
	if not ok or bounds.X < 1 or bounds.Y < 1 then return end
	local fitted = math.clamp(math.floor(100 * math.min(box.X / bounds.X, box.Y / bounds.Y)), 1, 100)
	surfaceTextBoxY = box.Y
	for _, l in ipairs({ title, dbl }) do
		l.TextScaled = false
		l.TextWrapped = false
		l.TextSize = fitted
	end
end

local function bindGui(gui)
	surfaceTextBoxY = nil -- fresh GUI clone (respawn): force a re-fit
	local hud = gui:WaitForChild("HUD")
	-- LevelReadout wraps LevelBar + LevelSubBg; sliding the container moves
	-- the whole readout as one unit.
	levelReadout = hud:WaitForChild("LevelReadout")
	topButtons = hud:WaitForChild("TopButtons")
	surfaceBtn = topButtons:WaitForChild("Surface")

	readoutShownPos = levelReadout.Position
	-- pinned to exact screen center and dropped a touch lower than authored so
	-- the button doesn't hug the top edge of the screen
	topButtons.AnchorPoint = Vector2.new(0.5, 0)
	topShownPos = UDim2.new(0.5, 0, topButtons.Position.Y.Scale + 0.05, 0)

	-- FrameAnimator slides the top strip away when a frame opens; publish the
	-- shown positions so on close it can put the RIGHT element back for the
	-- current surface/underground mode (see FrameAnimator.tweenHud).
	levelReadout:SetAttribute("SurfaceShownPos", readoutShownPos)
	topButtons:SetAttribute("SurfaceShownPos", topShownPos)

	-- The button keeps its authored look: same gradient/studs/shadow as the
	-- Drop button, with solid black UIStrokes (user-requested styling).
	-- Tiled overlay images (Studs pattern) use scale-relative TileSize, so the
	-- UIScale would fatten the pattern; shrink TileSize once to compensate so
		-- the studs render at the same on-screen size as every other button.
	for _, child in ipairs(surfaceBtn:GetChildren()) do
		if child:IsA("ImageLabel") and child.ScaleType == Enum.ScaleType.Tile and not child:GetAttribute("LootScaleAdjusted") then
			child:SetAttribute("LootScaleAdjusted", true)
			local ts = child.TileSize
			child.TileSize = UDim2.new(ts.X.Scale / SURFACE_BUTTON_SCALE, ts.X.Offset, ts.Y.Scale / SURFACE_BUTTON_SCALE, ts.Y.Offset)
		end
	end
	-- The 1.2x UIScale fattens UIStroke rendering the same way, which made the
	-- outline read thicker than every other button. Divide the thickness once
	-- to compensate; also adjust UiStrokeScaler's cached __BaseThickness so a
	-- window resize doesn't restore the fat stroke.
	for _, d in ipairs(surfaceBtn:GetDescendants()) do
		if d:IsA("UIStroke") and not d:GetAttribute("SurfaceScaleAdjusted") then
			d:SetAttribute("SurfaceScaleAdjusted", true)
			local base = d:GetAttribute("__BaseThickness")
			if base then
				d:SetAttribute("__BaseThickness", base / SURFACE_BUTTON_SCALE)
			end
			d.Thickness = d.Thickness / SURFACE_BUTTON_SCALE
		end
	end
	surfaceBtn.Visible = true

	task.spawn(fitSurfaceText)
	-- the box is Scale-sized: re-fit when the un-scaled box actually changes
	-- (viewport resize). UIScale tweens also fire AbsoluteSize, but the
	-- pre-scale box compare early-outs those.
	surfaceBtn.Title:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
		task.spawn(fitSurfaceText)
	end)

	topScale = topButtons:FindFirstChild("SurfaceScale")
	if not topScale then
		topScale = Instance.new("UIScale")
		topScale.Name = "SurfaceScale"
		topScale.Parent = topButtons
	end

	-- start hidden above the screen; the bar owns the slot
	topButtons.Visible = false
	topButtons.Position = topShownPos - HIDE_OFFSET
	topScale.Scale = 0.6

	surfaceBtn.MouseButton1Click:Connect(function()
		local char = plr.Character
		if char then
			char:PivotTo(CFrame.new(surfacePart.Position + Vector3.new(0, 4, 0)))
		end
	end)
end

playerGui.ChildAdded:Connect(function(c)
	if c.Name == "GUI" then bindGui(c) end
end)
local existing = playerGui:FindFirstChild("GUI")
if existing then bindGui(existing) end

local transitionToken = 0

local function slideOut(object, shownPos, onDone)
	local tween = TweenService:Create(object, TWEEN_OUT, { Position = shownPos - HIDE_OFFSET })
	if onDone then tween.Completed:Once(onDone) end
	tween:Play()
	return tween
end

local function slideIn(object, shownPos)
	object.Visible = true
	TweenService:Create(object, TWEEN_IN, { Position = shownPos }):Play()
end

local function enterUnderground(token)
	-- bar glides up first, then the big purple button drops in from the top
	slideOut(levelReadout, readoutShownPos, function()
		if token ~= transitionToken then return end
		levelReadout.Visible = false
		slideIn(topButtons, topShownPos)
		TweenService:Create(topScale, TWEEN_IN, { Scale = SURFACE_BUTTON_SCALE }):Play()
	end)
end

local function enterSurface(token)
	-- button glides up and away first, then the bar drops back down
	TweenService:Create(topScale, TWEEN_OUT, { Scale = 0.6 }):Play()
	slideOut(topButtons, topShownPos, function()
		if token ~= transitionToken then return end
		topButtons.Visible = false
		slideIn(levelReadout, readoutShownPos)
	end)
end

local underground = nil
local function setMode(isUnder)
	if underground == isUnder then return end
	underground = isUnder
	plr:SetAttribute("Underground", isUnder)
	if not (levelReadout and topButtons and topScale) then return end
	transitionToken += 1
	if isUnder then
		enterUnderground(transitionToken)
	else
		enterSurface(transitionToken)
	end
end

RunService.Heartbeat:Connect(function()
	local char = plr.Character
	local hrp = char and char:FindFirstChild("HumanoidRootPart")
	if hrp then
		setMode(hrp.Position.Y < UNDERGROUND_Y)
	end
end)
