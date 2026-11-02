-- NovaUI — Roblox port of the Nova desktop UI (same colours, spacing and motion as the web version).
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local GuiService = game:GetService("GuiService")

-- Height of Roblox's top bar. The window's ScreenGui ignores the inset, so without this the title
-- bar can end up underneath the top bar, where (on phones especially) Roblox's own buttons take
-- every touch and the window can't be grabbed.
local function topInset()
	local inset = GuiService:GetGuiInset()
	return inset.Y
end

local Nova = {}
Nova.__index = Nova

-- palette taken from the web CSS (neutral-950 base, white-alpha surfaces)
local T = {
	Bg = Color3.fromRGB(10, 10, 10),        -- #0a0a0a
	Side = Color3.fromRGB(14, 14, 14),      -- #0e0e0e
	Bar = Color3.fromRGB(16, 16, 16),       -- rgba(23,23,23,.6) over bg
	Card = Color3.fromRGB(15, 15, 15),      -- rgba(23,23,23,.45) over bg
	Pill = Color3.fromRGB(25, 25, 25),      -- rgba(255,255,255,.06) over side
	PillHover = Color3.fromRGB(19, 19, 19), -- rgba(255,255,255,.035)
	Line = Color3.fromRGB(26, 26, 26),      -- rgba(255,255,255,.06)
	Line2 = Color3.fromRGB(36, 36, 36),     -- rgba(255,255,255,.1)
	Text = Color3.fromRGB(245, 245, 245), Body = Color3.fromRGB(229, 229, 229),
	Muted = Color3.fromRGB(138, 138, 138), Dim = Color3.fromRGB(92, 92, 92),
	Accent = Color3.fromRGB(16, 185, 129), Track = Color3.fromRGB(38, 38, 38),
}
Nova.Theme = T
local FONT = Enum.Font.BuilderSans
local MED = Enum.Font.BuilderSansMedium
local BOLD = Enum.Font.BuilderSansBold

-- web easings: --ease cubic-bezier(.22,1,.36,1) ≈ Quint Out, --spring (.34,1.56,.64,1) ≈ Back Out
local EASE = TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
local SPRING = TweenInfo.new(0.45, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
local FAST = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local function tw(o, info, p) local t = TweenService:Create(o, info, p); t:Play(); return t end

-- glide(): frame-rate independent follow that re-targets mid-motion without restarting,
-- the way CSS transitions behave. Used for anything that moves continuously.
local RunService = game:GetService("RunService")
local glides = {}
-- values are kept as float arrays so pixel offsets don't get rounded down every frame (UDim2 offsets are ints)
local function pack(v)
	local ty = typeof(v)
	if ty == "number" then return {v} end
	if ty == "UDim2" then return {v.X.Scale, v.X.Offset, v.Y.Scale, v.Y.Offset} end
	return {v.R, v.G, v.B}
end
local function unpackAs(ty, a)
	if ty == "number" then return a[1] end
	if ty == "UDim2" then return UDim2.new(a[1], math.round(a[2]), a[3], math.round(a[4])) end
	return Color3.new(a[1], a[2], a[3])
end
local function glide(obj, prop, goal, speed)
	glides[obj] = glides[obj] or {}
	local g = glides[obj][prop]
	local ty = typeof(goal)
	if g and g.ty == ty then g.goal, g.speed = pack(goal), speed or 18
	else glides[obj][prop] = {ty = ty, cur = pack(obj[prop]), goal = pack(goal), speed = speed or 18} end
end
RunService.RenderStepped:Connect(function(dt)
	for obj, props in pairs(glides) do
		if not obj.Parent then glides[obj] = nil continue end
		for prop, g in pairs(props) do
			local k, done = 1 - math.exp(-g.speed * dt), true
			for i = 1, #g.cur do
				local d = g.goal[i] - g.cur[i]
				local eps = (g.ty == "UDim2" and (i == 2 or i == 4)) and 0.25 or 1e-4
				if math.abs(d) > eps then g.cur[i] += d * k; done = false else g.cur[i] = g.goal[i] end
			end
			obj[prop] = unpackAs(g.ty, g.cur)
			if done then props[prop] = nil end
		end
		if next(props) == nil then glides[obj] = nil end
	end
end)

local function new(class, props, kids)
	local o = Instance.new(class)
	local parent = props and props.Parent
	for k, v in pairs(props or {}) do if k ~= "Parent" then o[k] = v end end
	for _, c in ipairs(kids or {}) do c.Parent = o end
	if parent then o.Parent = parent end
	return o
end
local function corner(r) return new("UICorner", {CornerRadius = UDim.new(0, r)}) end
local function stroke(c) return new("UIStroke", {Color = c or T.Line, Thickness = 1, ApplyStrokeMode = Enum.ApplyStrokeMode.Border}) end
local function text(t, size, color, props)
	local l = new("TextLabel", {BackgroundTransparency = 1, Text = t, TextSize = size, TextColor3 = color, Font = FONT,
		TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Center})
	for k, v in pairs(props or {}) do l[k] = v end
	return l
end
local function checkmark(parent, color, box, props)
	-- drawn with two rounded bars so it looks the same everywhere (no font glyph)
	local g = new("CanvasGroup", {BackgroundTransparency = 1, Size = UDim2.fromOffset(box, box), Parent = parent})
	for k, v in pairs(props or {}) do g[k] = v end
	local k = box / 10
	new("Frame", {AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromOffset(2.6 * k, 6.4 * k), Size = UDim2.fromOffset(4.2 * k, 2 * k),
		Rotation = 45, BackgroundColor3 = color, BorderSizePixel = 0, Parent = g}, {corner(k)})
	new("Frame", {AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromOffset(6.3 * k, 5 * k), Size = UDim2.fromOffset(8 * k, 2 * k),
		Rotation = -50, BackgroundColor3 = color, BorderSizePixel = 0, Parent = g}, {corner(k)})
	return g
end
local YELLOW = Color3.fromRGB(250, 204, 21)
-- a star drawn from rounded bars (outline) plus rays from the centre (fill), no font glyphs
local function star(parent, size)
	local g = new("Frame", {BackgroundTransparency = 1, Size = UDim2.fromOffset(size, size), Parent = parent})
	local cx, cy, R, r = size / 2, size / 2 + size * 0.05, size * 0.5, size * 0.21
	local pts = {}
	for i = 0, 9 do
		local a = math.rad(-90 + i * 36)
		local rad = (i % 2 == 0) and R or r
		pts[i + 1] = Vector2.new(cx + math.cos(a) * rad, cy + math.sin(a) * rad)
	end
	local function seg(a, b, th, par, color)
		local mid, d = (a + b) / 2, b - a
		return new("Frame", {AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromOffset(mid.X, mid.Y), Size = UDim2.fromOffset(d.Magnitude + th * 0.7, th),
			Rotation = math.deg(math.atan2(d.Y, d.X)), BackgroundColor3 = color, BorderSizePixel = 0, Parent = par}, {corner(th)})
	end
	local fill = new("CanvasGroup", {BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), GroupTransparency = 1, Parent = g})
	local centre = Vector2.new(cx, cy)
	for i = 1, 10 do
		local a, b = pts[i], pts[i % 10 + 1]
		for t = 0, 1, 0.2 do seg(centre, a:Lerp(b, t), 2.2, fill, YELLOW) end
	end
	local outline = {}
	for i = 1, 10 do table.insert(outline, seg(pts[i], pts[i % 10 + 1], 1.5, g, T.Dim)) end
	return g, outline, fill
end
-- "glass" hover: a soft light that follows the mouse inside a card (web .stat::after radial spotlight)
local function spotlight(c, holder)
	local glow = new("CanvasGroup", {AnchorPoint = Vector2.new(0.5, 0.5), Size = UDim2.fromOffset(260, 260), BackgroundTransparency = 1,
		GroupTransparency = 1, ZIndex = 0, Parent = c})
	for i = 1, 7 do
		local k = 1 - (i - 1) * 0.13
		new("Frame", {AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(k, k),
			BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 0.988, BorderSizePixel = 0, ZIndex = 0, Parent = glow}, {new("UICorner", {CornerRadius = UDim.new(0.5, 0)})})
	end
	holder.MouseMoved:Connect(function(x, y)
		local p = Vector2.new(x, y) - c.AbsolutePosition
		if glow.GroupTransparency > 0.95 then glow.Position = UDim2.fromOffset(p.X, p.Y) end
		glide(glow, "Position", UDim2.fromOffset(p.X, p.Y), 22)
	end)
	holder.MouseEnter:Connect(function() tw(glow, FAST, {GroupTransparency = 0}) end)
	holder.MouseLeave:Connect(function() tw(glow, EASE, {GroupTransparency = 1}) end)
end
local function isClick(i) return i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch end

-- window -------------------------------------------------------------------------------------------
function Nova.new(playerGui, title)
	local self = setmetatable({Tabs = {}, Visible = false}, Nova)
	local gui = new("ScreenGui", {Name = "NovaUI", ResetOnSpawn = false, IgnoreGuiInset = true, DisplayOrder = 1000,
		ZIndexBehavior = Enum.ZIndexBehavior.Sibling, Parent = playerGui})
	self.Gui = gui

	local win = new("CanvasGroup", {Name = "Window", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5),
		Size = UDim2.fromOffset(640, 420), BackgroundColor3 = T.Bg, GroupTransparency = 1, Visible = false, Parent = gui},
		{corner(14), stroke(T.Line2)})
	self.Window = win
	self.Stroke = win:FindFirstChildOfClass("UIStroke")
	self.Stroke.Transparency = 1
	self.Size = win.Size
	self.Scale = new("UIScale", {Scale = 0.985, Parent = win})

	-- title bar: traffic lights (symbols appear on hover, like macOS) + "nova · <tab>"
	local bar = new("Frame", {Size = UDim2.new(1, 0, 0, 40), BackgroundColor3 = T.Bar, BorderSizePixel = 0, Parent = win})
	new("Frame", {Size = UDim2.new(1, 0, 0, 1), Position = UDim2.new(0, 0, 1, -1), BackgroundColor3 = T.Line, BorderSizePixel = 0, Parent = bar})
	local lights = new("Frame", {Size = UDim2.fromOffset(60, 40), Position = UDim2.fromOffset(14, 0), BackgroundTransparency = 1, Parent = bar})
	local glyphs = {}
	for i, spec in ipairs({{Color3.fromRGB(255, 95, 86), "×"}, {Color3.fromRGB(255, 189, 46), "–"}, {Color3.fromRGB(39, 201, 63), "+"}}) do
		local b = new("TextButton", {Text = "", AutoButtonColor = false, Size = UDim2.fromOffset(12, 12), Position = UDim2.new(0, (i - 1) * 19, 0.5, -6),
			BackgroundColor3 = spec[1], Parent = lights}, {corner(6)})
		glyphs[i] = text(spec[2], 11, Color3.fromRGB(80, 40, 30), {Size = UDim2.fromScale(1, 1), TextXAlignment = Enum.TextXAlignment.Center,
			Font = BOLD, TextTransparency = 1, Parent = b})
		local sc = new("UIScale", {Parent = b})
		b.MouseButton1Down:Connect(function() tw(sc, FAST, {Scale = 0.82}) end)
		b.MouseButton1Up:Connect(function() tw(sc, SPRING, {Scale = 1}) end)
		b.MouseLeave:Connect(function() tw(sc, SPRING, {Scale = 1}) end)
		b.MouseButton1Click:Connect(function() if i == 1 then self:Toggle(false) elseif i == 2 then self:Minimize() else self:Maximize() end end)
	end
	lights.MouseEnter:Connect(function() for _, g in ipairs(glyphs) do tw(g, FAST, {TextTransparency = 0}) end end)
	lights.MouseLeave:Connect(function() for _, g in ipairs(glyphs) do tw(g, FAST, {TextTransparency = 1}) end end)
	text((title or "nova") .. " ·", 12, T.Dim, {Position = UDim2.fromOffset(86, 0), Size = UDim2.fromOffset(0, 40), AutomaticSize = Enum.AutomaticSize.X, Parent = bar})
	self.Crumb = text("", 12, T.Muted, {Position = UDim2.fromOffset(0, 0), Size = UDim2.fromOffset(200, 40), Parent = bar})
	task.defer(function() self.Crumb.Position = UDim2.fromOffset(90 + bar:FindFirstChildOfClass("TextLabel").TextBounds.X, 0) end)
	text("F5", 11, T.Dim, {AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -14, 0.5, 0), Size = UDim2.fromOffset(28, 20),
		TextXAlignment = Enum.TextXAlignment.Center, BackgroundTransparency = 1, Font = Enum.Font.Code, Parent = bar}, {})
	local kbd = bar:GetChildren()[#bar:GetChildren()]
	new("UIStroke", {Color = T.Line2, Parent = kbd}); corner(5).Parent = kbd

	-- smooth drag (lerped, like a native window). On touch only the finger that grabbed the bar
	-- moves it (another finger on the thumbstick or camera must not drag or drop the window).
	local dragging, from, startPos, goal, dragTouch = false, nil, nil, nil, nil
	bar.InputBegan:Connect(function(i)
		if isClick(i) then
			dragging, from, startPos, goal = true, i.Position, win.Position, win.Position
			dragTouch = i.UserInputType == Enum.UserInputType.Touch and i or nil
		end
	end)
	UIS.InputChanged:Connect(function(i)
		if not dragging then return end
		local mine = (dragTouch == nil and i.UserInputType == Enum.UserInputType.MouseMovement) or (dragTouch ~= nil and i == dragTouch)
		if mine then
			local d = i.Position - from
			goal = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X, startPos.Y.Scale, startPos.Y.Offset + d.Y)
			glide(win, "Position", goal, 32)
		end
	end)
	UIS.InputEnded:Connect(function(i)
		if not dragging or not isClick(i) then return end
		if dragTouch ~= nil and i ~= dragTouch then return end
		dragging, dragTouch = false, nil
		self:_clamp(goal)
	end)

	-- sidebar: brand, status, nav (sliding active pill + gliding hover pill), profile
	local side = new("Frame", {Position = UDim2.fromOffset(0, 40), Size = UDim2.new(0, 190, 1, -40), BackgroundColor3 = T.Side, BorderSizePixel = 0, Parent = win},
		{new("UIPadding", {PaddingLeft = UDim.new(0, 12), PaddingRight = UDim.new(0, 12), PaddingTop = UDim.new(0, 12), PaddingBottom = UDim.new(0, 12)})})
	self.SideFrame = side
	new("Frame", {Size = UDim2.new(0, 1, 1, 24), Position = UDim2.new(1, 12, 0, -12), BackgroundColor3 = T.Line, BorderSizePixel = 0, Parent = side})
	local logo = new("Frame", {Size = UDim2.fromOffset(18, 18), Position = UDim2.fromOffset(4, 2), BackgroundColor3 = Color3.fromRGB(22, 22, 22), Parent = side},
		{corner(5), stroke(T.Line2)})
	for i, h in ipairs({5, 8, 11}) do
		new("Frame", {AnchorPoint = Vector2.new(0, 1), Size = UDim2.fromOffset(2, h), Position = UDim2.fromOffset(3 + (i - 1) * 4.5, 15),
			BackgroundColor3 = i == 3 and T.Text or T.Accent, BorderSizePixel = 0, Parent = logo}, {corner(1)})
	end
	text("nova", 13, Color3.fromRGB(212, 212, 212), {Font = MED, Position = UDim2.fromOffset(30, 0), Size = UDim2.fromOffset(100, 22), Parent = side})
	local dot = new("Frame", {Size = UDim2.fromOffset(6, 6), Position = UDim2.fromOffset(5, 36), BackgroundColor3 = T.Accent, Parent = side}, {corner(3)})
	local ring = new("Frame", {AnchorPoint = Vector2.new(0.5, 0.5), Size = UDim2.fromOffset(6, 6), Position = UDim2.fromScale(0.5, 0.5),
		BackgroundColor3 = T.Accent, BackgroundTransparency = 0.3, Parent = dot}, {corner(20)})
	task.spawn(function()  -- live "ping" pulse on the status dot
		while ring.Parent do
			ring.Size, ring.BackgroundTransparency = UDim2.fromOffset(6, 6), 0.3
			tw(ring, TweenInfo.new(1.8, Enum.EasingStyle.Quint), {Size = UDim2.fromOffset(19, 19), BackgroundTransparency = 1})
			task.wait(2.2)
		end
	end)
	text("Online", 11, T.Dim, {Position = UDim2.fromOffset(18, 29), Size = UDim2.fromOffset(120, 20), Parent = side})

	local sbox = new("Frame", {Position = UDim2.fromOffset(0, 58), Size = UDim2.new(1, 0, 0, 30), BackgroundColor3 = Color3.fromRGB(10, 10, 10), Parent = side}, {corner(8)})
	local sst = stroke(T.Line); sst.Parent = sbox
	local lens = new("Frame", {Size = UDim2.fromOffset(9, 9), Position = UDim2.fromOffset(10, 9), BackgroundTransparency = 1, Parent = sbox},
		{new("UICorner", {CornerRadius = UDim.new(0.5, 0)}), new("UIStroke", {Color = T.Dim, Thickness = 1.5})})
	local handle = new("Frame", {AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromOffset(20.5, 20.5), Size = UDim2.fromOffset(5, 1.5), Rotation = 45,
		BackgroundColor3 = T.Dim, BorderSizePixel = 0, Parent = sbox}, {corner(1)})
	local box = new("TextBox", {Text = "", PlaceholderText = "Search", PlaceholderColor3 = T.Dim, TextColor3 = T.Body, TextSize = 12.5, Font = FONT,
		ClearTextOnFocus = false, BackgroundTransparency = 1, TextXAlignment = Enum.TextXAlignment.Left,
		Position = UDim2.fromOffset(28, 0), Size = UDim2.new(1, -34, 1, 0), Parent = sbox})
	box.Focused:Connect(function() tw(sst, FAST, {Color = T.Accent, Transparency = 0.45}); tw(lens.UIStroke, FAST, {Color = T.Muted}); tw(handle, FAST, {BackgroundColor3 = T.Muted}) end)
	box.FocusLost:Connect(function() tw(sst, FAST, {Color = T.Line, Transparency = 0}); tw(lens.UIStroke, FAST, {Color = T.Dim}); tw(handle, FAST, {BackgroundColor3 = T.Dim}) end)
	box:GetPropertyChangedSignal("Text"):Connect(function() self.Query = box.Text; self:_filter() end)
	self.SearchBox = box
	UIS.InputBegan:Connect(function(i)
		if self.Visible and i.KeyCode == Enum.KeyCode.F and (UIS:IsKeyDown(Enum.KeyCode.LeftControl) or UIS:IsKeyDown(Enum.KeyCode.RightControl)) then
			task.defer(function() box:CaptureFocus() end)
		end
	end)
	local nav = new("Frame", {Position = UDim2.fromOffset(0, 98), Size = UDim2.new(1, 0, 1, -98), BackgroundTransparency = 1, Parent = side})
	self.HoverPill = new("Frame", {Size = UDim2.new(1, 0, 0, 33), BackgroundColor3 = T.PillHover, BackgroundTransparency = 1, Parent = nav}, {corner(8)})
	self.ActivePill = new("Frame", {Size = UDim2.new(1, 0, 0, 33), BackgroundColor3 = T.Pill, Parent = nav}, {corner(8)})
	self.Nav = nav
	nav.MouseLeave:Connect(function() glide(self.HoverPill, "BackgroundTransparency", 1, 14) end)

	

	self.Pages = new("Frame", {Position = UDim2.fromOffset(191, 40), Size = UDim2.new(1, -191, 1, -40), BackgroundTransparency = 1, ClipsDescendants = true, Parent = win})

	self.Toasts = new("Frame", {AnchorPoint = Vector2.new(1, 1), Position = UDim2.new(1, -16, 1, -16), Size = UDim2.fromOffset(280, 300), BackgroundTransparency = 1, Parent = gui},
		{new("UIListLayout", {VerticalAlignment = Enum.VerticalAlignment.Bottom, HorizontalAlignment = Enum.HorizontalAlignment.Right, Padding = UDim.new(0, 8), SortOrder = Enum.SortOrder.LayoutOrder})})
	self.ToastN = 0

	-- tooltip (shared)
	local tip = new("CanvasGroup", {AnchorPoint = Vector2.new(0.5, 1), Size = UDim2.fromOffset(0, 18), AutomaticSize = Enum.AutomaticSize.X,
		BackgroundColor3 = Color3.fromRGB(245, 245, 245), GroupTransparency = 1, ZIndex = 50, Parent = gui},
		{corner(5), new("UIPadding", {PaddingLeft = UDim.new(0, 6), PaddingRight = UDim.new(0, 6)})})
	self.TipLabel = text("", 10, Color3.fromRGB(23, 23, 23), {Font = MED, Size = UDim2.fromOffset(0, 18), AutomaticSize = Enum.AutomaticSize.X, ZIndex = 51, Parent = tip})
	self.Tip = tip


	-- resize grip (bottom-right): drag to resize, glides like the window drag, content reflows
	local grip = new("TextButton", {Text = "", AutoButtonColor = false, AnchorPoint = Vector2.new(1, 1), Position = UDim2.fromScale(1, 1),
		Size = UDim2.fromOffset(18, 18), BackgroundTransparency = 1, ZIndex = 10, Parent = win})
	for _, p in ipairs({{15, 15}, {11, 15}, {7, 15}, {15, 11}, {15, 7}, {11, 11}}) do
		new("Frame", {AnchorPoint = Vector2.new(1, 1), Position = UDim2.fromOffset(p[1], p[2]), Size = UDim2.fromOffset(2, 2),
			BackgroundColor3 = T.Dim, BorderSizePixel = 0, ZIndex = 10, Parent = grip}, {corner(1)})
	end
	grip.MouseEnter:Connect(function() for _, d in ipairs(grip:GetChildren()) do tw(d, FAST, {BackgroundColor3 = T.Muted}) end end)
	grip.MouseLeave:Connect(function() for _, d in ipairs(grip:GetChildren()) do tw(d, FAST, {BackgroundColor3 = T.Dim}) end end)
	local resizing, r0, s0
	grip.InputBegan:Connect(function(i)
		if isClick(i) and not self.Maximized and not self.Minimized then resizing, r0, s0 = true, i.Position, win.AbsoluteSize end
	end)
	UIS.InputChanged:Connect(function(i)
		if resizing and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
			local d = i.Position - r0
			local vp = workspace.CurrentCamera.ViewportSize
			local w = math.clamp(s0.X + d.X * 2, 480, vp.X - 20)   -- centre-anchored window grows both ways
			local h = math.clamp(s0.Y + d.Y * 2, 300, vp.Y - 20)
			self.Size = UDim2.fromOffset(w, h)
			glide(win, "Size", self.Size, 30)
		end
	end)
	UIS.InputEnded:Connect(function(i) if isClick(i) and resizing then resizing = false; self:_clamp() end end)
	self.Grip = grip
	workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(function()
		if self.Maximized then
			local vp = workspace.CurrentCamera.ViewportSize
			glide(win, "Position", UDim2.new(0.5, 0, 0.5, topInset() / 2), 16)
			glide(win, "Size", UDim2.fromOffset(vp.X - 32, vp.Y - topInset() - 32), 16)
		else self:_clamp() end
	end)
	return self
end

-- keep the whole window on screen so it can always be grabbed again
function Nova:_clamp(pos)
	local win = self.Window
	pos = pos or win.Position
	local vp = workspace.CurrentCamera.ViewportSize
	local size = self.Minimized and Vector2.new(self.Size.X.Offset, 40) or (self.Maximized and win.AbsoluteSize or Vector2.new(self.Size.X.Offset, self.Size.Y.Offset))
	local cx = vp.X * pos.X.Scale + pos.X.Offset
	local cy = vp.Y * pos.Y.Scale + pos.Y.Offset
	local hw, hh = size.X / 2, size.Y / 2
	-- glide fully back inside the screen, below Roblox's top bar (if it's bigger than the screen,
	-- pin its top-left corner instead)
	local pad = 8
	local top = topInset() + pad
	local ncx = hw * 2 + pad * 2 <= vp.X and math.clamp(cx, hw + pad, vp.X - hw - pad) or hw
	local ncy = hh * 2 + top + pad <= vp.Y and math.clamp(cy, hh + top, vp.Y - hh - pad) or hh + topInset()
	if ncx ~= cx or ncy ~= cy then
		glide(win, "Position", UDim2.new(pos.X.Scale, ncx - vp.X * pos.X.Scale, pos.Y.Scale, ncy - vp.Y * pos.Y.Scale), 12)
	end
end

function Nova:_tip(target, textFn)
	local token
	target.MouseEnter:Connect(function()
		local my = {}; token = my
		task.delay(0.5, function() if token == my then self:_showTip(target, textFn()) end end)
	end)
	target.MouseLeave:Connect(function() token = nil; self:_hideTip() end)
end
function Nova:_showTip(target, msg)
	local tip = self.Tip
	self.TipLabel.Text = msg
	-- measure relative to the ScreenGui itself (AbsolutePosition is offset by the top-bar inset)
	local p, sz = target.AbsolutePosition - self.Gui.AbsolutePosition, target.AbsoluteSize
	local at = UDim2.fromOffset(p.X + sz.X / 2, p.Y - 4)
	tip.Position = at + UDim2.fromOffset(0, 4)
	tw(tip, EASE, {GroupTransparency = 0, Position = at})
end
function Nova:_hideTip() tw(self.Tip, FAST, {GroupTransparency = 1}) end
function Nova:_tipText(msg) if self.Tip.GroupTransparency < 0.9 then self.TipLabel.Text = msg end end

function Nova:_filter()
	local q = string.lower(self.Query or "")
	local firstMatch
	for _, tab in ipairs(self.Tabs) do
		local nameHit = q == "" or string.find(string.lower(tab.Name), q, 1, true) ~= nil
		local any = false
		for _, ch in ipairs(tab.Page:GetChildren()) do
			local key = ch:GetAttribute("Search")
			if key then
				local show = nameHit or string.find(string.lower(key), q, 1, true) ~= nil
				any = any or show
				if ch.Visible ~= show then
					ch.Visible = show
					local c = ch:FindFirstChild("Card")
					if show and c and tab == self.Current then c.GroupTransparency = 1; c.Position = UDim2.fromOffset(0, 8); tw(c, EASE, {GroupTransparency = 0, Position = UDim2.fromOffset(0, 0)}) end
				end
			elseif ch:GetAttribute("Section") then
				ch.Visible = nameHit
			end
		end
		tab.Match = nameHit or any
		if tab.Match and not firstMatch then firstMatch = tab end
		if tab.Empty then tab.Empty.Visible = false end
	end
	self:_layoutNav()
	if self.Current and not self.Current.Match and firstMatch then self:Select(firstMatch) end
end

-- favourites first, then the rest; tabs hidden by the search collapse out of the list
function Nova:_layoutNav()
	local order = {}
	for _, t in ipairs(self.Tabs) do if t.Fav then table.insert(order, t) end end
	for _, t in ipairs(self.Tabs) do if not t.Fav then table.insert(order, t) end end
	local y = 0
	for _, t in ipairs(order) do
		local show = t.Match ~= false
		if show then
			if not t.Btn.Visible then t.Btn.Position = UDim2.fromOffset(0, y); t.Lbl.TextTransparency = 1; tw(t.Lbl, EASE, {TextTransparency = 0}) end
			t.Y = y
			glide(t.Btn, "Position", UDim2.fromOffset(0, y), 16)
			y += 35
		end
		t.Btn.Visible = show
	end
	if self.Current then
		self.ActivePill.Visible = self.Current.Match ~= false
		glide(self.ActivePill, "Position", UDim2.fromOffset(0, self.Current.Y or 0), 16)
	end
	glide(self.HoverPill, "BackgroundTransparency", 1, 14)
end

function Nova:Minimize()
	if self.Maximized then self:Maximize() end
	self.Minimized = not self.Minimized
	local win, side, pages = self.Window, self.SideFrame, self.Pages
	local h = win.AbsoluteSize.Y - 40
	self.MinN = (self.MinN or 0) + 1
	local n = self.MinN
	if self.Minimized then
		side.Size = UDim2.new(0, 190, 0, h); pages.Size = UDim2.new(1, -191, 0, h)
		glide(win, "Size", UDim2.fromOffset(self.Size.X.Offset, 40), 16)
		task.delay(0.45, function() if n == self.MinN then side.Visible = false; pages.Visible = false end end)
	else
		side.Visible = true; pages.Visible = true
		side.Size = UDim2.new(0, 190, 0, self.Size.Y.Offset - 40); pages.Size = UDim2.new(1, -191, 0, self.Size.Y.Offset - 40)
		glide(win, "Size", self.Size, 16)
		task.delay(0.6, function() if n == self.MinN then side.Size = UDim2.new(0, 190, 1, -40); pages.Size = UDim2.new(1, -191, 1, -40) end end)
	end
	self.Grip.Visible = not self.Minimized
	task.delay(0.05, function() self:_clamp() end)
end

function Nova:Maximize()
	if self.Minimized then self.Minimized = false; self.SideFrame.Visible = true; self.Pages.Visible = true
		self.SideFrame.Size = UDim2.new(0, 190, 1, -40); self.Pages.Size = UDim2.new(1, -191, 1, -40) end
	self.Maximized = not self.Maximized
	local win = self.Window
	if self.Maximized then
		self.RestorePos = win.Position
		local vp = workspace.CurrentCamera.ViewportSize
		glide(win, "Position", UDim2.new(0.5, 0, 0.5, topInset() / 2), 16)
		glide(win, "Size", UDim2.fromOffset(vp.X - 32, vp.Y - topInset() - 32), 16)
	else
		glide(win, "Position", self.RestorePos or UDim2.fromScale(0.5, 0.5), 16)
		glide(win, "Size", self.Size, 16)
	end
	self.Grip.Visible = not self.Maximized
end

function Nova:Toggle(state)
	if state == nil then state = not self.Visible end
	self.Visible = state
	local win = self.Window
	if state then  -- boot animation from the web version: fade in + scale .985 -> 1
		win.Visible = true
		self.Scale.Scale = 0.985
		tw(win, EASE, {GroupTransparency = 0}); tw(self.Stroke, EASE, {Transparency = 0}); tw(self.Scale, EASE, {Scale = 1})
		if self.Current then self:_rise(self.Current) end
	else
		tw(self.Scale, FAST, {Scale = 0.97}); tw(self.Stroke, FAST, {Transparency = 1})
		tw(win, FAST, {GroupTransparency = 1}).Completed:Connect(function() if not self.Visible then win.Visible = false end end)
	end
end

function Nova:Tab(name)
	local index = #self.Tabs + 1
	local y = (index - 1) * 35
	local btn = new("TextButton", {Text = "", AutoButtonColor = false, BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 33),
		Position = UDim2.fromOffset(0, y), ZIndex = 3, Parent = self.Nav})
	local lbl = text(name, 13, T.Dim, {Position = UDim2.fromOffset(12, 0), Size = UDim2.new(1, -12, 1, 0), ZIndex = 3, Parent = btn})
	local page = new("ScrollingFrame", {Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, BorderSizePixel = 0, ScrollBarThickness = 4,
		ScrollBarImageColor3 = Color3.fromRGB(40, 40, 40), CanvasSize = UDim2.new(), AutomaticCanvasSize = Enum.AutomaticSize.Y, Visible = false, Parent = self.Pages},
		{new("UIListLayout", {Padding = UDim.new(0, 8), SortOrder = Enum.SortOrder.LayoutOrder}),
		 new("UIPadding", {PaddingTop = UDim.new(0, 18), PaddingLeft = UDim.new(0, 22), PaddingRight = UDim.new(0, 22), PaddingBottom = UDim.new(0, 22)})})
	-- page header like the web: small eyebrow + title
	local eyebrow = text(string.lower(name), 10, T.Dim, {Size = UDim2.new(1, 0, 0, 12), LayoutOrder = -2, Parent = page})
	local titleL = text(name, 17, T.Text, {Font = MED, Size = UDim2.new(1, 0, 0, 26), LayoutOrder = -1, Parent = page})
	local empty = text("", 12, T.Dim, {Size = UDim2.new(1, 0, 0, 60), TextXAlignment = Enum.TextXAlignment.Center, LayoutOrder = 100000, Visible = false, Parent = page})
	local STAR_LINE, STAR_FILL = "rbxassetid://76676323175277", "rbxassetid://107484690098191"
	local starBtn = new("ImageButton", {AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -8, 0.5, 0), Size = UDim2.fromOffset(14, 14),
		BackgroundTransparency = 1, Image = STAR_LINE, ImageColor3 = T.Muted, ImageTransparency = 1, ZIndex = 4, Parent = btn})
	local pop = new("UIScale", {Parent = starBtn})
	local tab = setmetatable({Star = starBtn, Empty = empty, Name = name, Btn = btn, Lbl = lbl, Page = page, Window = self, Order = 0, Items = {}, Eyebrow = eyebrow, Title = titleL}, {__index = Nova.TabMethods})
	btn.MouseEnter:Connect(function()
		local hp = self.HoverPill
		if hp.BackgroundTransparency > 0.9 then hp.Position = btn.Position end  -- appear in place, then glide
		glide(hp, "Position", btn.Position, 16); glide(hp, "BackgroundTransparency", 0, 14)
		if self.Current ~= tab then tw(lbl, FAST, {TextColor3 = Color3.fromRGB(163, 163, 163)}) end
	end)
	btn.MouseLeave:Connect(function() if self.Current ~= tab then tw(lbl, FAST, {TextColor3 = T.Dim}) end end)
	btn.MouseButton1Click:Connect(function() self:Select(tab) end)
	local hovering = false
	local function paintStar()
		if tab.Fav then
			starBtn.Image = STAR_FILL
			tw(starBtn, FAST, {ImageColor3 = YELLOW, ImageTransparency = 0})
		else
			starBtn.Image = STAR_LINE
			tw(starBtn, FAST, {ImageColor3 = T.Muted, ImageTransparency = hovering and 0.25 or 1})
		end
	end
	btn.MouseEnter:Connect(function() hovering = true; paintStar() end)
	btn.MouseLeave:Connect(function() hovering = false; paintStar() end)
	starBtn.MouseEnter:Connect(function() hovering = true; if not tab.Fav then tw(starBtn, FAST, {ImageTransparency = 0}) end end)
	starBtn.MouseButton1Click:Connect(function()
		tab.Fav = not tab.Fav
		pop.Scale = 0.55; tw(pop, SPRING, {Scale = 1})
		paintStar(); self:_tipText(tab.Fav and "Unfavorite" or "Favorite")
		self:_layoutNav()
	end)
	self:_tip(starBtn, function() return tab.Fav and "Unfavorite" or "Favorite" end)
	tab.Y = y
	table.insert(self.Tabs, tab)
	if index == 1 then self:Select(tab, true) end
	return tab
end

function Nova:_rise(tab)  -- staggered "rise" of page items (web: .st animation)
	for n, l in ipairs({tab.Eyebrow, tab.Title}) do
		l.TextTransparency = 1
		task.delay(0.03 * n, function() tw(l, EASE, {TextTransparency = 0}) end)
	end
	for n, item in ipairs(tab.Items) do
		local cardObj = item:FindFirstChild("Card")
		if cardObj then
			cardObj.Position = UDim2.fromOffset(0, 12); cardObj.GroupTransparency = 1
			task.delay(0.035 * n, function() tw(cardObj, EASE, {Position = UDim2.fromOffset(0, 0), GroupTransparency = 0}) end)
		end
	end
end

function Nova:Select(tab, instant)
	local prev = self.Current
	if prev == tab then return end
	self.Current = tab
	for _, t in ipairs(self.Tabs) do tw(t.Lbl, FAST, {TextColor3 = t == tab and T.Text or T.Dim}); t.Lbl.Font = t == tab and MED or FONT end
	local crumb, nameTxt = self.Crumb, string.lower(tab.Name)
	if instant or crumb.Text == "" then crumb.Text = nameTxt else
		self.CrumbN = (self.CrumbN or 0) + 1
		local n = self.CrumbN
		local base = self.CrumbBase or crumb.Position
		self.CrumbBase = base
		tw(crumb, FAST, {TextTransparency = 1, Position = base - UDim2.fromOffset(0, 4)})
		task.delay(0.16, function()
			if n ~= self.CrumbN then return end
			crumb.Text = nameTxt; crumb.Position = base + UDim2.fromOffset(0, 4)
			tw(crumb, EASE, {TextTransparency = 0, Position = base})
		end)
	end
	local slot = UDim2.fromOffset(0, tab.Y or 0)
	if instant then self.ActivePill.Position = slot else glide(self.ActivePill, "Position", slot, 13) end
	if prev then prev.Page.Visible = false end
	tab.Page.Visible = true
	tab.Page.CanvasPosition = Vector2.zero
	self:_filter()
	if not instant then self:_rise(tab) end
end

function Nova:Notify(msg)
	self.ToastN += 1
	local card = new("CanvasGroup", {Size = UDim2.fromOffset(0, 38), AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(28, 28, 28),
		LayoutOrder = self.ToastN, GroupTransparency = 1, Parent = self.Toasts},
		{corner(10), new("UIPadding", {PaddingLeft = UDim.new(0, 10), PaddingRight = UDim.new(0, 14)}),
		 new("UIListLayout", {FillDirection = Enum.FillDirection.Horizontal, VerticalAlignment = Enum.VerticalAlignment.Center, Padding = UDim.new(0, 9)})})
	local ic = new("Frame", {Size = UDim2.fromOffset(18, 18), BackgroundColor3 = Color3.fromRGB(21, 56, 44), Parent = card}, {corner(9)})
	checkmark(ic, T.Accent, 10, {AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5)})
	text(msg, 13, T.Body, {Size = UDim2.fromOffset(0, 38), AutomaticSize = Enum.AutomaticSize.X, Parent = card})
	local sc = new("UIScale", {Scale = 0.92, Parent = card})
	local cst = new("UIStroke", {Color = T.Line2, Transparency = 1, Parent = card})
	tw(card, EASE, {GroupTransparency = 0}); tw(cst, EASE, {Transparency = 0}); tw(sc, SPRING, {Scale = 1})
	task.delay(3.2, function()
		tw(sc, FAST, {Scale = 0.96}); tw(card, FAST, {GroupTransparency = 1}); tw(cst, FAST, {Transparency = 1})
		task.wait(0.25); card:Destroy()
	end)
end

-- controls (cards: 1px border that brightens on hover, like the web .panel) ---------------------------
Nova.TabMethods = {}
local TM = Nova.TabMethods

local function card(tab, h, label)
	tab.Order += 1
	local holder = new("Frame", {Size = UDim2.new(1, 0, 0, h), BackgroundTransparency = 1, LayoutOrder = tab.Order, Parent = tab.Page})
	if label then holder:SetAttribute("Search", label) end
	local c = new("CanvasGroup", {Name = "Card", Size = UDim2.fromScale(1, 1), BackgroundColor3 = T.Card, Parent = holder}, {corner(12)})
	local st = stroke(T.Line); st.Parent = c
	holder.MouseEnter:Connect(function() tw(st, FAST, {Color = T.Line2}) end)
	holder.MouseLeave:Connect(function() tw(st, FAST, {Color = T.Line}) end)
	spotlight(c, holder)
	table.insert(tab.Items, holder)
	return c, holder
end

function TM:Section(t)
	self.Order += 1
	local l = text(t, 10, T.Dim, {Size = UDim2.new(1, 0, 0, 22), TextYAlignment = Enum.TextYAlignment.Bottom, LayoutOrder = self.Order, Parent = self.Page})
	l:SetAttribute("Section", true)
	return l
end

function TM:Button(label, cb)
	local c, holder = card(self, 44, label)
	local b = new("TextButton", {Text = "", AutoButtonColor = false, BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), Parent = c})
	text(label, 13, T.Body, {Position = UDim2.fromOffset(14, 0), Size = UDim2.new(1, -40, 1, 0), Parent = c})
	local arrow = text("›", 18, T.Dim, {Position = UDim2.new(1, -24, 0, -1), Size = UDim2.fromOffset(12, 44), Parent = c})
	local sc = new("UIScale", {Parent = c})
	b.MouseEnter:Connect(function() tw(c, FAST, {BackgroundColor3 = Color3.fromRGB(20, 20, 20)}); tw(arrow, SPRING, {Position = UDim2.new(1, -20, 0, -1), TextColor3 = T.Muted}) end)
	b.MouseLeave:Connect(function() tw(c, FAST, {BackgroundColor3 = T.Card}); tw(arrow, SPRING, {Position = UDim2.new(1, -24, 0, -1), TextColor3 = T.Dim}); tw(sc, SPRING, {Scale = 1}) end)
	b.MouseButton1Down:Connect(function() tw(sc, FAST, {Scale = 0.97}) end)
	b.MouseButton1Up:Connect(function() tw(sc, SPRING, {Scale = 1}) end)
	b.MouseButton1Click:Connect(function() if cb then cb() end end)
end

function TM:Toggle(label, default, cb)
	local on = default and true or false
	local c = card(self, 52, label)
	text(label, 13, T.Body, {Position = UDim2.fromOffset(14, 0), Size = UDim2.new(1, -70, 1, 0), Parent = c})
	-- web .sw: 34x20 track, 14px knob, spring slide, knob stretches while pressed
	local track = new("TextButton", {Text = "", AutoButtonColor = false, Size = UDim2.fromOffset(34, 20), Position = UDim2.new(1, -48, 0.5, -10),
		BackgroundColor3 = on and T.Accent or T.Track, Parent = c}, {corner(10)})
	local knob = new("Frame", {Size = UDim2.fromOffset(14, 14), Position = UDim2.fromOffset(on and 17 or 3, 3), BackgroundColor3 = Color3.fromRGB(250, 250, 250), Parent = track}, {corner(7)})
	local function place(pressed)
		local w = pressed and 18 or 14
		tw(knob, SPRING, {Size = UDim2.fromOffset(w, 14), Position = UDim2.fromOffset(on and (31 - w) or 3, 3)})
	end
	track.MouseButton1Down:Connect(function() place(true) end)
	track.MouseLeave:Connect(function() place(false) end)
	track.MouseButton1Click:Connect(function()
		on = not on
		tw(track, EASE, {BackgroundColor3 = on and T.Accent or T.Track})
		place(false)
		if cb then cb(on) end
	end)
end

function TM:Slider(label, min, max, default, cb)
	local c = card(self, 62, label)
	text(label, 12, T.Muted, {Position = UDim2.fromOffset(14, 10), Size = UDim2.new(1, -80, 0, 18), Parent = c})
	local val = text(tostring(default), 12, T.Body, {Font = MED, Position = UDim2.new(1, -64, 0, 10), Size = UDim2.fromOffset(50, 18),
		TextXAlignment = Enum.TextXAlignment.Right, Parent = c})
	local track = new("TextButton", {Text = "", AutoButtonColor = false, Size = UDim2.new(1, -28, 0, 4), Position = UDim2.new(0, 14, 1, -18),
		BackgroundColor3 = Color3.fromRGB(30, 30, 30), Parent = c}, {corner(2)})
	local hit = new("TextButton", {Text = "", BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 22), Position = UDim2.fromOffset(0, -9), Parent = track})
	local a = (default - min) / (max - min)
	local fill = new("Frame", {Size = UDim2.fromScale(a, 1), BackgroundColor3 = T.Accent, BorderSizePixel = 0, Parent = track}, {corner(2)})
	local knob = new("Frame", {AnchorPoint = Vector2.new(0.5, 0.5), Size = UDim2.fromOffset(14, 14), Position = UDim2.fromScale(a, 0.5),
		BackgroundColor3 = Color3.fromRGB(250, 250, 250), ZIndex = 2, Parent = track}, {corner(7)})
	local halo = new("UIStroke", {Color = Color3.new(1, 1, 1), Transparency = 0.94, Thickness = 4, Parent = knob})
	local held = false
	local function set(x)
		local p = math.clamp((x - track.AbsolutePosition.X) / track.AbsoluteSize.X, 0, 1)
		local v = math.floor(min + (max - min) * p + 0.5)
		glide(fill, "Size", UDim2.fromScale(p, 1), 30)
		glide(knob, "Position", UDim2.fromScale(p, 0.5), 30)
		if val.Text ~= tostring(v) then
			local nv = Instance.new("NumberValue"); nv.Value = tonumber(val.Text) or v
			nv.Changed:Connect(function(x) val.Text = tostring(math.floor(x + 0.5)) end)
			tw(nv, TweenInfo.new(0.25, Enum.EasingStyle.Quint), {Value = v}).Completed:Connect(function() nv:Destroy() end)
			if cb then cb(v) end
		end
	end
	hit.MouseEnter:Connect(function() tw(halo, FAST, {Color = T.Accent, Transparency = 0.8, Thickness = 6}) end)
	hit.MouseLeave:Connect(function() if not held then tw(halo, FAST, {Color = Color3.new(1, 1, 1), Transparency = 0.94, Thickness = 4}) end end)
	hit.InputBegan:Connect(function(i) if isClick(i) then held = true; tw(knob, SPRING, {Size = UDim2.fromOffset(18, 18)}); set(i.Position.X) end end)
	UIS.InputChanged:Connect(function(i)
		if held and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then set(i.Position.X) end
	end)
	UIS.InputEnded:Connect(function(i)
		if held and isClick(i) then held = false; tw(knob, SPRING, {Size = UDim2.fromOffset(14, 14)})
			tw(halo, FAST, {Color = Color3.new(1, 1, 1), Transparency = 0.94, Thickness = 4}) end
	end)
end

function TM:Dropdown(label, options, default, cb)
	local current, open = default or options[1], false
	local c, holder = card(self, 48, label)
	c.ClipsDescendants = true
	text(label, 13, T.Body, {Position = UDim2.fromOffset(14, 0), Size = UDim2.new(0.5, 0, 0, 48), Parent = c})
	local head = new("TextButton", {Text = "", AutoButtonColor = false, BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 48), Parent = c})
	-- web .seg-like pill showing the current value, with a chevron that rotates
	local pill = new("Frame", {AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -12, 0, 24), Size = UDim2.fromOffset(0, 28),
		AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(18, 18, 18), Parent = c},
		{corner(8), stroke(T.Line), new("UIPadding", {PaddingLeft = UDim.new(0, 10), PaddingRight = UDim.new(0, 8)}),
		 new("UIListLayout", {FillDirection = Enum.FillDirection.Horizontal, VerticalAlignment = Enum.VerticalAlignment.Center, Padding = UDim.new(0, 6)})})
	local cur = text(current, 12, T.Body, {Size = UDim2.fromOffset(0, 28), AutomaticSize = Enum.AutomaticSize.X, Parent = pill})
	local chev = text("›", 16, T.Muted, {Size = UDim2.fromOffset(10, 28), TextXAlignment = Enum.TextXAlignment.Center, Rotation = 90, Parent = pill})
	local list = new("Frame", {Position = UDim2.fromOffset(8, 48), Size = UDim2.new(1, -16, 0, #options * 32), BackgroundTransparency = 1, Parent = c})
	local rows = {}
	for i, opt in ipairs(options) do
		local o = new("TextButton", {Text = "", AutoButtonColor = false, BackgroundColor3 = T.Card, BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 30),
			Position = UDim2.fromOffset(0, (i - 1) * 32), Parent = list}, {corner(7)})
		local ol = text(opt, 12.5, opt == current and T.Text or Color3.fromRGB(163, 163, 163), {Position = UDim2.fromOffset(10, 0), Size = UDim2.new(1, -30, 1, 0), Parent = o})
		local tick = checkmark(o, T.Accent, 11, {AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(1, -22, 0.5, 0), GroupTransparency = opt == current and 0 or 1})
		rows[opt] = {ol, tick}
		o.MouseEnter:Connect(function() tw(o, FAST, {BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.955}) end)
		o.MouseLeave:Connect(function() tw(o, FAST, {BackgroundTransparency = 1}) end)
		o.MouseButton1Click:Connect(function()
			current = opt; cur.Text = opt
			for k, r in pairs(rows) do tw(r[1], FAST, {TextColor3 = k == opt and T.Text or Color3.fromRGB(163, 163, 163)}); tw(r[2], FAST, {GroupTransparency = k == opt and 0 or 1}) end
			open = false
			tw(holder, EASE, {Size = UDim2.new(1, 0, 0, 48)}); tw(chev, EASE, {Rotation = 90})
			if cb then cb(opt) end
		end)
	end
	head.MouseButton1Click:Connect(function()
		open = not open
		tw(holder, EASE, {Size = UDim2.new(1, 0, 0, open and 56 + #options * 32 or 48)})
		tw(chev, EASE, {Rotation = open and 270 or 90})
	end)
end

return Nova
