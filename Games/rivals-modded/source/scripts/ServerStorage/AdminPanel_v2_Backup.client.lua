-- Admin panel, built on ReplicatedStorage.NovaUI, in gold.
--
-- Opens from the lobby's "Admin" button (next to Settings; Lobby.Buttons fires
-- PlayerGui.AdminPanel.Toggle) or with F5.
--
-- Everything it shows comes from ServerScriptService.Server.AdminPanelService through
-- ReplicatedStorage.AdminPanelRemote: "Catalog" once (weapons, crates, passes...), then a fresh
-- State with every answer. The server owns the 25s cooldowns; buttons only mirror them.
-- Recorded statistics (win streak, duels, tasks...) are not editable from here on purpose.

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local Nova = require(ReplicatedStorage:WaitForChild("NovaUI"))
local Remote = ReplicatedStorage:WaitForChild("AdminPanelRemote", 120) :: RemoteFunction
if not Remote then
	warn("[AdminPanel] ReplicatedStorage.AdminPanelRemote never appeared")
	return
end

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- theme ----------------------------------------------------------------------------------------

local WHITE = Color3.new(1, 1, 1)
local GOLD = Color3.fromRGB(255, 200, 64)
local GOLD_HI = Color3.fromRGB(255, 234, 156)
local GOLD_LO = Color3.fromRGB(226, 140, 18)
local GOLD_TEXT = Color3.fromRGB(46, 28, 0)
local STATUS_COLORS = {
	Prime = Color3.fromRGB(190, 132, 255),
	Contraband = Color3.fromRGB(255, 96, 96),
}
local STATUS_TINT = {
	Standard = { Color3.fromRGB(28, 28, 28), Color3.fromRGB(15, 15, 15) },
	Prime = { Color3.fromRGB(42, 30, 62), Color3.fromRGB(16, 14, 21) },
	Contraband = { Color3.fromRGB(60, 22, 22), Color3.fromRGB(19, 14, 14) },
}

local T = Nova.Theme
T.Accent = GOLD
T.Track = Color3.fromRGB(40, 35, 26)

local FONT, MED, BOLD = Enum.Font.BuilderSans, Enum.Font.BuilderSansMedium, Enum.Font.BuilderSansBold
local FAST = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local EASE = TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
local SPRING = TweenInfo.new(0.45, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
local AMOUNTS = { 1, 5, 10, 25, 50 }
local TOGGLE_KEY = Enum.KeyCode.F5
local WEAPON_ZOOM = 2.2

-- helpers --------------------------------------------------------------------------------------

local function tw(o, info, p)
	local t = TweenService:Create(o, info, p)
	t:Play()
	return t
end

local function new(class, props, kids)
	local o = Instance.new(class)
	local parent = props and props.Parent
	for k, v in props or {} do
		if k ~= "Parent" then
			o[k] = v
		end
	end
	for _, c in kids or {} do
		c.Parent = o
	end
	if parent then
		o.Parent = parent
	end
	return o
end

local function corner(r)
	return new("UICorner", { CornerRadius = UDim.new(0, r) })
end

local function stroke(c, transparency)
	return new("UIStroke", {
		Color = c or T.Line,
		Thickness = 1,
		Transparency = transparency or 0,
		ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
	})
end

local function text(t, size, color, props)
	local l = new("TextLabel", {
		BackgroundTransparency = 1,
		Text = t,
		TextSize = size,
		TextColor3 = color,
		Font = FONT,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextYAlignment = Enum.TextYAlignment.Center,
	})
	for k, v in props or {} do
		l[k] = v
	end
	return l
end

local function gradient(parent, a: Color3, b: Color3, rotation: number?, c: Color3?)
	local keys = c and { ColorSequenceKeypoint.new(0, a), ColorSequenceKeypoint.new(0.5, b), ColorSequenceKeypoint.new(1, c) }
		or { ColorSequenceKeypoint.new(0, a), ColorSequenceKeypoint.new(1, b) }
	return new("UIGradient", { Color = ColorSequence.new(keys), Rotation = rotation or 90, Parent = parent })
end

local function goldFill(parent, rotation: number?)
	return gradient(parent, GOLD_HI, GOLD, rotation or 90, GOLD_LO)
end

local function commas(n: number): string
	local s = tostring(math.floor(n))
	local out = s:reverse():gsub("(%d%d%d)", "%1,"):reverse()
	return (out:gsub("^,", ""))
end

local function count(t): number
	local n = 0
	for _ in t or {} do
		n += 1
	end
	return n
end

-- An image (optionally zoomed through a clipping canvas: weapon icons sit small in the middle
-- of a big transparent image, the game shows them the same way) or an emoji.
local function icon(parent, o)
	local holder = new("Frame", {
		BackgroundTransparency = 1,
		Size = o.Size,
		Position = o.Position or UDim2.new(),
		AnchorPoint = o.AnchorPoint or Vector2.zero,
		ClipsDescendants = o.Zoom ~= nil,
		Rotation = o.Zoom and 0 or (o.Rotation or 0),
		Parent = parent,
	})
	local img
	if o.Emoji then
		img = text(o.Emoji, 14, WHITE, {
			Size = UDim2.fromScale(1, 1),
			TextScaled = true,
			Font = BOLD,
			TextXAlignment = Enum.TextXAlignment.Center,
			Parent = holder,
		})
	elseif o.Zoom then
		img = new("ImageLabel", {
			Image = o.Image or "",
			BackgroundTransparency = 1,
			ScaleType = Enum.ScaleType.Crop,
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.fromScale(0.5, 0.5),
			Size = UDim2.fromScale(o.Zoom, o.Zoom),
			Parent = holder,
		})
	else
		img = new("ImageLabel", {
			Image = o.Image or "",
			BackgroundTransparency = 1,
			ScaleType = Enum.ScaleType.Fit,
			Size = UDim2.fromScale(1, 1),
			Parent = holder,
		})
	end
	return holder, img
end

-- A rounded dark-gold square with an icon in it.
local function iconBadge(parent, size: number, o, props)
	local b = new("Frame", { Size = UDim2.fromOffset(size, size), BackgroundColor3 = WHITE, Parent = parent }, { corner(math.floor(size * 0.28)) })
	gradient(b, Color3.fromRGB(70, 52, 16), Color3.fromRGB(26, 21, 11), 135)
	stroke(GOLD, 0.7).Parent = b
	for k, v in props or {} do
		b[k] = v
	end
	o = table.clone(o)
	o.Size = UDim2.fromScale(0.74, 0.74)
	o.Position = UDim2.fromScale(0.5, 0.5)
	o.AnchorPoint = Vector2.new(0.5, 0.5)
	icon(b, o)
	return b
end

-- window ---------------------------------------------------------------------------------------

local ui = Nova.new(playerGui, "Admin Panel")
ui.Gui.Name = "AdminPanel"
local ToggleEvent = new("BindableEvent", { Name = "Toggle", Parent = ui.Gui })

-- Sized from the viewport, again on every open unless the player resized it by hand (the camera
-- reports a tiny viewport for the first frames after joining).
local autoSize = nil
local function fitWindow()
	if ui.Maximized or ui.Minimized or (autoSize and ui.Size ~= autoSize) then
		return
	end
	local vp = workspace.CurrentCamera.ViewportSize
	autoSize = UDim2.fromOffset(math.clamp(vp.X - 24, 480, 900), math.clamp(vp.Y - 24, 300, 600))
	ui.Size = autoSize
	ui.Window.Size = autoSize
end
do
	local deadline = os.clock() + 10
	while workspace.CurrentCamera.ViewportSize.X < 100 and os.clock() < deadline do
		task.wait()
	end
	fitWindow()
end

-- gold rim on the window
do
	ui.Stroke.Color = WHITE
	local rim = gradient(ui.Stroke, GOLD, Color3.fromRGB(60, 60, 60), 35, GOLD_LO)
	rim.Transparency = NumberSequence.new({
		NumberSequenceKeypoint.new(0, 0.15),
		NumberSequenceKeypoint.new(0.5, 0.55),
		NumberSequenceKeypoint.new(1, 0.3),
	})
end

local titleBar
for _, child in ui.Window:GetChildren() do
	if child:IsA("Frame") and child.Size == UDim2.new(1, 0, 0, 40) then
		titleBar = child
	end
end

-- warm wash across the top of every page
do
	local wash = new("Frame", {
		Name = "Wash",
		Size = UDim2.new(1, 0, 0, 220),
		BackgroundColor3 = GOLD,
		BorderSizePixel = 0,
		ZIndex = 0,
		Parent = ui.Pages,
	})
	local g = new("UIGradient", { Rotation = 90, Parent = wash })
	g.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.9), NumberSequenceKeypoint.new(1, 1) })
end

-- sidebar: crown logo, gold brand, status line, active pill with a gold edge
local statusLabel
for _, child in ui.SideFrame:GetChildren() do
	if child:IsA("Frame") and child.Size == UDim2.fromOffset(18, 18) then
		for _, bar in child:GetChildren() do
			bar:Destroy()
		end
		child.Size = UDim2.fromOffset(22, 22)
		child.Position = UDim2.fromOffset(2, 0)
		child.BackgroundColor3 = WHITE
		corner(7).Parent = child
		goldFill(child, 135)
		icon(child, {
			Emoji = "\u{1F451}",
			Size = UDim2.fromScale(0.72, 0.72),
			Position = UDim2.fromScale(0.5, 0.5),
			AnchorPoint = Vector2.new(0.5, 0.5),
		})
	elseif child:IsA("TextLabel") and child.Text == "nova" then
		child.Text = "Admin Panel"
		child.Font = BOLD
		child.TextSize = 15
		child.TextColor3 = WHITE
		child.Position = UDim2.fromOffset(32, 0)
		goldFill(child)
	elseif child:IsA("TextLabel") and child.Text == "Online" then
		statusLabel = child
		child.Size = UDim2.fromOffset(150, 20)
		child.TextTruncate = Enum.TextTruncate.AtEnd
		child.Text = "25s cooldown on each command"
	end
end
ui.ActivePill.BackgroundColor3 = Color3.fromRGB(34, 30, 21)
new("Frame", {
	AnchorPoint = Vector2.new(0, 0.5),
	Position = UDim2.new(0, 0, 0.5, 0),
	Size = UDim2.fromOffset(3, 16),
	BackgroundColor3 = GOLD,
	BorderSizePixel = 0,
	Parent = ui.ActivePill,
}, { corner(2) })

-- profile footer
do
	local foot = new("Frame", {
		AnchorPoint = Vector2.new(0, 1),
		Position = UDim2.fromScale(0, 1),
		Size = UDim2.new(1, 0, 0, 46),
		BackgroundColor3 = WHITE,
		Parent = ui.SideFrame,
	}, { corner(11) })
	gradient(foot, Color3.fromRGB(40, 32, 16), Color3.fromRGB(17, 16, 14), 0)
	stroke(GOLD, 0.75).Parent = foot
	local ring = new("Frame", {
		Position = UDim2.fromOffset(7, 7),
		Size = UDim2.fromOffset(32, 32),
		BackgroundColor3 = WHITE,
		Parent = foot,
	}, { corner(16) })
	goldFill(ring, 135)
	local avatar = new("ImageLabel", {
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.5),
		Size = UDim2.fromOffset(28, 28),
		BackgroundColor3 = Color3.fromRGB(24, 24, 24),
		Parent = ring,
	}, { corner(14) })
	text(player.DisplayName, 13, T.Text, {
		Font = BOLD,
		Position = UDim2.fromOffset(47, 7),
		Size = UDim2.new(1, -52, 0, 16),
		TextTruncate = Enum.TextTruncate.AtEnd,
		Parent = foot,
	})
	text("@" .. player.Name, 11, T.Muted, {
		Position = UDim2.fromOffset(47, 23),
		Size = UDim2.new(1, -52, 0, 14),
		TextTruncate = Enum.TextTruncate.AtEnd,
		Parent = foot,
	})
	-- keep the tab list clear of the footer
	if ui.Nav then
		ui.Nav.Size = UDim2.new(1, 0, 1, -ui.Nav.Position.Y.Offset - 54)
	end
	task.spawn(function()
		local ok, image = pcall(
			Players.GetUserThumbnailAsync,
			Players,
			math.max(player.UserId, 1),
			Enum.ThumbnailType.HeadShot,
			Enum.ThumbnailSize.Size48x48
		)
		if ok then
			avatar.Image = image
		end
	end)
end

-- toasts: Nova draws a green circle behind its check; make it gold
ui.Toasts.ChildAdded:Connect(function(toast)
	task.defer(function()
		for _, child in toast:GetChildren() do
			if child:IsA("Frame") and child.Size == UDim2.fromOffset(18, 18) then
				child.BackgroundColor3 = Color3.fromRGB(74, 56, 16)
			end
		end
		local st = toast:FindFirstChildOfClass("UIStroke")
		if st then
			st.Color = Color3.fromRGB(92, 72, 28)
		end
	end)
end)

-- state, cooldowns, commands -------------------------------------------------------------------

local state = nil
local cooldownEnds: { [string]: number } = {}
local watchers = {} -- { Key, Fn(secondsLeft), Last }
local updaters = {} -- fn(state)
local pending: { [string]: boolean } = {}

local function secondsLeft(key: string?): number
	if not key then
		return 0
	end
	local ends = cooldownEnds[key]
	return ends and math.max(0, math.ceil(ends - os.clock())) or 0
end

local function watch(key: string, fn)
	table.insert(watchers, { Key = key, Fn = fn, Last = -1 })
end

local function tick(force: boolean?)
	for _, w in watchers do
		local left = secondsLeft(w.Key)
		if force or left ~= w.Last then
			w.Last = left
			w.Fn(left)
		end
	end
end

local function applyState(s)
	if type(s) ~= "table" then
		return
	end
	state = s
	table.clear(cooldownEnds)
	local now = os.clock()
	for key, left in s.Cooldowns or {} do
		cooldownEnds[key] = now + left
	end
	for _, fn in updaters do
		local ok, err = pcall(fn, s)
		if not ok then
			warn("[AdminPanel] " .. tostring(err))
		end
	end
	tick(true)
end

local function run(action: string, key: string, a: any?, b: any?)
	if pending[key] then
		return
	end
	local left = secondsLeft(key)
	if left > 0 then
		ui:Notify(string.format("On cooldown for %ds", left))
		return
	end
	pending[key] = true
	task.spawn(function()
		local ok, result = pcall(Remote.InvokeServer, Remote, action, a, b)
		pending[key] = nil
		if not ok or type(result) ~= "table" then
			ui:Notify("Couldn't reach the server")
			return
		end
		applyState(result.State)
		if result.Message then
			ui:Notify(result.Message)
		end
	end)
end

local function refresh()
	task.spawn(function()
		local ok, result = pcall(Remote.InvokeServer, Remote, "State")
		if ok and type(result) == "table" then
			applyState(result.State)
		end
	end)
end

-- controls -------------------------------------------------------------------------------------

-- style "accent" (gold) or "ghost"; key = the server cooldown it mirrors. Attributes:
-- Label (text when not cooling down), Disabled (greyed, e.g. "Owned").
local function button(parent, label: string, style: string, key: string?, props)
	local accent = style == "accent"
	local b = new("TextButton", {
		Text = label,
		AutoButtonColor = false,
		Font = BOLD,
		TextSize = 12,
		TextColor3 = accent and GOLD_TEXT or T.Body,
		BackgroundColor3 = accent and WHITE or T.Pill,
		Size = UDim2.fromOffset(0, 30),
		AutomaticSize = Enum.AutomaticSize.X,
		Parent = parent,
	}, { corner(9), new("UIPadding", { PaddingLeft = UDim.new(0, 14), PaddingRight = UDim.new(0, 14) }) })
	local grad = accent and goldFill(b) or nil
	local st = stroke(accent and GOLD_HI or T.Line2, accent and 0.6 or 0)
	st.Parent = b
	for k, v in props or {} do
		b[k] = v
	end
	b:SetAttribute("Label", label)
	local scale = new("UIScale", { Parent = b })
	local hovered = false
	local function paint()
		local disabled = b:GetAttribute("Disabled") == true
		local cooling = secondsLeft(key) > 0
		local live = hovered and not disabled and not cooling
		if accent then
			grad.Enabled = not disabled
			b.BackgroundColor3 = disabled and T.Pill or WHITE
			b.TextColor3 = disabled and T.Muted or GOLD_TEXT
			tw(st, FAST, { Transparency = disabled and 0.2 or (live and 0 or 0.6), Color = disabled and T.Line2 or GOLD_HI })
		else
			tw(st, FAST, { Color = live and GOLD or T.Line2 })
			tw(b, FAST, { TextColor3 = live and GOLD or T.Body })
		end
		tw(b, FAST, { BackgroundTransparency = cooling and 0.5 or 0, TextTransparency = cooling and 0.25 or 0 })
		tw(scale, SPRING, { Scale = live and 1.04 or 1 })
	end
	b.MouseEnter:Connect(function()
		hovered = true
		paint()
	end)
	b.MouseLeave:Connect(function()
		hovered = false
		paint()
	end)
	b.MouseButton1Down:Connect(function()
		tw(scale, FAST, { Scale = 0.95 })
	end)
	b.MouseButton1Up:Connect(function()
		tw(scale, SPRING, { Scale = hovered and 1.04 or 1 })
	end)
	b:GetAttributeChangedSignal("Label"):Connect(function()
		if secondsLeft(key) == 0 then
			b.Text = b:GetAttribute("Label")
		end
	end)
	b:GetAttributeChangedSignal("Disabled"):Connect(paint)
	if key then
		watch(key, function(left)
			b.Text = left > 0 and ("\u{23F3} " .. left .. "s") or b:GetAttribute("Label")
			paint()
		end)
	end
	paint()
	return b
end

-- A NovaUI-style card (holder + CanvasGroup "Card"), so the tab's rise animation picks it up.
-- search: text NovaUI's sidebar search matches against (children with a "Search" attribute
-- are shown / hidden by it; everything else always shows).
local function card(tab, h: number, lineColor: Color3?, lineTransparency: number?, search: string?)
	tab.Order += 1
	local holder = new("Frame", {
		Size = UDim2.new(1, 0, 0, h),
		BackgroundTransparency = 1,
		LayoutOrder = tab.Order,
		Parent = tab.Page,
	})
	if search then
		holder:SetAttribute("Search", search)
	end
	local c = new("CanvasGroup", { Name = "Card", Size = UDim2.fromScale(1, 1), BackgroundColor3 = T.Card, Parent = holder }, { corner(14) })
	-- A UIGradient on the CanvasGroup itself would tint everything inside it, so the gradient
	-- lives on a background frame under the content.
	local bg = new("Frame", { Name = "Bg", Size = UDim2.fromScale(1, 1), BackgroundColor3 = WHITE, BorderSizePixel = 0, ZIndex = 0, Parent = c })
	gradient(bg, Color3.fromRGB(22, 21, 19), Color3.fromRGB(14, 14, 14), 90)
	local base = lineTransparency or 0
	local st = stroke(lineColor or T.Line, base)
	st.Parent = c
	holder.MouseEnter:Connect(function()
		tw(st, FAST, { Color = GOLD, Transparency = 0.55 })
	end)
	holder.MouseLeave:Connect(function()
		tw(st, FAST, { Color = lineColor or T.Line, Transparency = base })
	end)
	table.insert(tab.Items, holder)
	return c, holder
end

local function describe(tab, s: string)
	tab.Order += 1
	text(s, 13, T.Muted, {
		Size = UDim2.new(1, 0, 0, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
		TextWrapped = true,
		LayoutOrder = tab.Order,
		Parent = tab.Page,
	})
end

local function section(tab, s: string, search: string?)
	tab.Order += 1
	local row = new("Frame", {
		Size = UDim2.new(1, 0, 0, 30),
		BackgroundTransparency = 1,
		LayoutOrder = tab.Order,
		Parent = tab.Page,
	})
	if search then
		row:SetAttribute("Search", search)
	end
	new("Frame", {
		Position = UDim2.fromOffset(0, 12),
		Size = UDim2.fromOffset(3, 12),
		BackgroundColor3 = GOLD,
		BorderSizePixel = 0,
		Parent = row,
	}, { corner(2) })
	local label = text(s, 11, T.Body, {
		Font = BOLD,
		Position = UDim2.fromOffset(10, 8),
		Size = UDim2.new(1, -10, 0, 20),
		RichText = true,
		Parent = row,
	})
	return label
end

-- The big card at the top of a page: a large gold number, what it counts, an optional button
-- (or a line of text), a picture on the right and a progress line along the bottom.
-- o = { Big(s), Caption(s), Image?, Zoom?, Emoji?, Desc?, Button?, Key?, OnClick?, Progress(s)? }
local function hero(tab, o)
	local c = card(tab, 128, GOLD, 0.6)
	c.Bg:FindFirstChildOfClass("UIGradient"):Destroy()
	gradient(c.Bg, Color3.fromRGB(70, 52, 16), Color3.fromRGB(26, 22, 14), 0, Color3.fromRGB(16, 16, 16))
	for i, size in { 230, 150 } do
		new("Frame", {
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.new(1, -92, 0.5, 0),
			Size = UDim2.fromOffset(size, size),
			BackgroundColor3 = GOLD,
			BackgroundTransparency = i == 1 and 0.93 or 0.88,
			Parent = c,
		}, { corner(size // 2) })
	end
	icon(c, {
		Image = o.Image,
		Zoom = o.Zoom,
		Emoji = o.Emoji,
		Size = UDim2.fromOffset(o.Zoom and 150 or 100, o.Zoom and 100 or 100),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.new(1, -92, 0.5, 0),
		Rotation = -8,
	})
	local big = text("", 36, WHITE, { Font = BOLD, Position = UDim2.fromOffset(22, 14), Size = UDim2.new(1, -230, 0, 40), Parent = c })
	goldFill(big)
	local caption = text("", 13, T.Body, { Font = MED, Position = UDim2.fromOffset(22, 54), Size = UDim2.new(1, -230, 0, 18), Parent = c })
	if o.Button then
		local b = button(c, o.Button, "accent", o.Key, { Position = UDim2.fromOffset(22, 80), Size = UDim2.fromOffset(0, 32) })
		b.MouseButton1Click:Connect(o.OnClick)
	elseif o.Desc then
		text(o.Desc, 12, T.Muted, {
			Position = UDim2.fromOffset(22, 78),
			Size = UDim2.new(1, -230, 0, 34),
			TextWrapped = true,
			TextYAlignment = Enum.TextYAlignment.Top,
			Parent = c,
		})
	end
	local fill
	if o.Progress then
		local track = new("Frame", {
			AnchorPoint = Vector2.new(0, 1),
			Position = UDim2.fromScale(0, 1),
			Size = UDim2.new(1, 0, 0, 4),
			BackgroundColor3 = Color3.fromRGB(44, 37, 22),
			BorderSizePixel = 0,
			Parent = c,
		})
		fill = new("Frame", { Size = UDim2.fromScale(0, 1), BackgroundColor3 = WHITE, BorderSizePixel = 0, Parent = track })
		goldFill(fill, 0)
	end
	table.insert(updaters, function(s)
		big.Text = o.Big(s)
		caption.Text = o.Caption(s)
		if fill then
			tw(fill, EASE, { Size = UDim2.fromScale(math.clamp(o.Progress(s), 0, 1), 1) })
		end
	end)
end

-- Icon, title, live subtitle, optional progress bar with a percentage, a button on the right.
-- o = { Title, Icon?, Sub(state), Progress(state)?, Button, Label(state)?, Disabled(state)?, Key, OnClick }
local function actionCard(tab, o)
	local h = o.Progress and 78 or 66
	local c = card(tab, h, nil, nil, o.Title)
	local x = 18
	if o.Icon then
		iconBadge(c, 46, o.Icon, { AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 14, 0.5, 0) })
		x = 74
	end
	text(o.Title, 15, T.Text, { Font = BOLD, Position = UDim2.fromOffset(x, 13), Size = UDim2.new(1, -x - 150, 0, 18), Parent = c })
	local sub = text("", 12, T.Muted, {
		Position = UDim2.fromOffset(x, 32),
		Size = UDim2.new(1, -x - 150, 0, 16),
		TextTruncate = Enum.TextTruncate.AtEnd,
		RichText = true,
		Parent = c,
	})
	local fill, percent
	if o.Progress then
		local track = new("Frame", {
			Position = UDim2.fromOffset(x, 57),
			Size = UDim2.new(1, -x - 190, 0, 6),
			BackgroundColor3 = T.Track,
			BorderSizePixel = 0,
			Parent = c,
		}, { corner(3) })
		fill = new("Frame", { Size = UDim2.fromScale(0, 1), BackgroundColor3 = WHITE, BorderSizePixel = 0, Parent = track }, { corner(3) })
		goldFill(fill, 0)
		percent = text("0%", 11, GOLD, { Font = BOLD, Position = UDim2.new(1, -182, 0, 52), Size = UDim2.fromOffset(40, 16), Parent = c })
	end
	local b = button(c, o.Button, "accent", o.Key, {
		AnchorPoint = Vector2.new(1, 0.5),
		Position = UDim2.new(1, -18, 0.5, 0),
		AutomaticSize = Enum.AutomaticSize.None,
		Size = UDim2.fromOffset(112, 32),
	})
	b.MouseButton1Click:Connect(o.OnClick)
	table.insert(updaters, function(s)
		sub.Text = o.Sub(s)
		if fill then
			local p = math.clamp(o.Progress(s), 0, 1)
			tw(fill, EASE, { Size = UDim2.fromScale(p, 1) })
			percent.Text = math.floor(p * 100 + 0.5) .. "%"
		end
		if o.Label then
			b:SetAttribute("Label", o.Label(s))
		end
		if o.Disabled then
			b:SetAttribute("Disabled", o.Disabled(s))
		end
	end)
	return c
end

-- Icon, title, "Current: x", a number box and Set.
-- o = { Title, Icon?, Current(state), Key, OnSet(value), Placeholder? }
local function valueRow(tab, o)
	local c = card(tab, 66, nil, nil, o.Title)
	local x = 18
	if o.Icon then
		iconBadge(c, 42, o.Icon, { AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 14, 0.5, 0) })
		x = 68
	end
	text(o.Title, 14, T.Text, { Font = BOLD, Position = UDim2.fromOffset(x, 14), Size = UDim2.new(1, -x - 220, 0, 18), Parent = c })
	local current = text("", 12, T.Muted, {
		Position = UDim2.fromOffset(x, 33),
		Size = UDim2.new(1, -x - 220, 0, 16),
		RichText = true,
		Parent = c,
	})
	local box = new("TextBox", {
		AnchorPoint = Vector2.new(1, 0.5),
		Position = UDim2.new(1, -94, 0.5, 0),
		Size = UDim2.fromOffset(124, 32),
		BackgroundColor3 = Color3.fromRGB(12, 12, 12),
		Text = "",
		PlaceholderText = o.Placeholder or "Amount",
		PlaceholderColor3 = T.Dim,
		TextColor3 = T.Text,
		Font = MED,
		TextSize = 13,
		ClearTextOnFocus = false,
		TextXAlignment = Enum.TextXAlignment.Left,
		Parent = c,
	}, { corner(9), new("UIPadding", { PaddingLeft = UDim.new(0, 11), PaddingRight = UDim.new(0, 11) }) })
	local boxStroke = stroke(T.Line2)
	boxStroke.Parent = box
	box.Focused:Connect(function()
		tw(boxStroke, FAST, { Color = GOLD })
	end)
	box:GetPropertyChangedSignal("Text"):Connect(function()
		local clean = string.sub(string.gsub(box.Text, "%D", ""), 1, 10)
		if clean ~= box.Text then
			box.Text = clean
		end
	end)
	local b = button(c, "Set", "accent", o.Key, {
		AnchorPoint = Vector2.new(1, 0.5),
		Position = UDim2.new(1, -18, 0.5, 0),
		AutomaticSize = Enum.AutomaticSize.None,
		Size = UDim2.fromOffset(66, 32),
	})
	local function submit()
		local value = tonumber(box.Text)
		if not value then
			ui:Notify("Enter a number first")
			return
		end
		o.OnSet(value)
		box.Text = ""
	end
	b.MouseButton1Click:Connect(submit)
	box.FocusLost:Connect(function(enter)
		tw(boxStroke, FAST, { Color = T.Line2 })
		if enter then
			submit()
		end
	end)
	table.insert(updaters, function(s)
		current.Text = 'Current: <font color="#FFC840"><b>' .. o.Current(s) .. "</b></font>"
	end)
end

-- A switch driven by state (it only flips once the server answers).
local function switchRow(tab, o)
	local c = card(tab, 66, nil, nil, o.Title)
	local x = 18
	if o.Icon then
		iconBadge(c, 42, o.Icon, { AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 14, 0.5, 0) })
		x = 68
	end
	text(o.Title, 14, T.Text, { Font = BOLD, Position = UDim2.fromOffset(x, 14), Size = UDim2.new(1, -x - 90, 0, 18), Parent = c })
	local sub = text(o.SubText or "", 12, T.Muted, { Position = UDim2.fromOffset(x, 33), Size = UDim2.new(1, -x - 90, 0, 16), Parent = c })
	local track = new("TextButton", {
		Text = "",
		AutoButtonColor = false,
		Size = UDim2.fromOffset(44, 24),
		Position = UDim2.new(1, -62, 0.5, -12),
		BackgroundColor3 = T.Track,
		Parent = c,
	}, { corner(12) })
	local trackGold = goldFill(track, 0)
	trackGold.Enabled = false
	local knob = new("Frame", {
		Size = UDim2.fromOffset(18, 18),
		Position = UDim2.fromOffset(3, 3),
		BackgroundColor3 = Color3.fromRGB(250, 250, 250),
		Parent = track,
	}, { corner(9) })
	local on = false
	track.MouseButton1Click:Connect(function()
		o.OnToggle(not on)
	end)
	watch(o.Key, function(left)
		sub.Text = left > 0 and string.format("On cooldown for %ds", left) or (o.SubText or "")
	end)
	table.insert(updaters, function(s)
		on = o.Get(s)
		trackGold.Enabled = on
		track.BackgroundColor3 = on and WHITE or T.Track
		tw(knob, SPRING, { Position = UDim2.fromOffset(on and 23 or 3, 3) })
	end)
end

local function grid(tab, cell: UDim2, search: string?)
	tab.Order += 1
	local g = new("Frame", {
		Size = UDim2.new(1, 0, 0, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		LayoutOrder = tab.Order,
		Parent = tab.Page,
	}, { new("UIGridLayout", { CellSize = cell, CellPadding = UDim2.fromOffset(10, 10), SortOrder = Enum.SortOrder.LayoutOrder }) })
	if search then
		g:SetAttribute("Search", search)
	end
	return g
end

local function names(list, field: string): string
	local out = {}
	for _, item in list do
		table.insert(out, item[field])
	end
	return table.concat(out, " ")
end

-- Hover/press feel for grid tiles.
local function tileFeel(t, st, restColor: Color3, restTransparency: () -> number)
	local scale = new("UIScale", { Parent = t })
	t.MouseEnter:Connect(function()
		tw(st, FAST, { Color = GOLD, Transparency = 0 })
		tw(scale, SPRING, { Scale = 1.03 })
	end)
	t.MouseLeave:Connect(function()
		tw(st, FAST, { Color = restColor, Transparency = restTransparency() })
		tw(scale, SPRING, { Scale = 1 })
	end)
	if t:IsA("GuiButton") then
		t.MouseButton1Down:Connect(function()
			tw(scale, FAST, { Scale = 0.96 })
		end)
		t.MouseButton1Up:Connect(function()
			tw(scale, SPRING, { Scale = 1.03 })
		end)
	end
end

local function chip(parent, props)
	local c = new("TextLabel", {
		Text = "",
		Font = BOLD,
		TextSize = 10,
		TextColor3 = T.Muted,
		BackgroundColor3 = Color3.fromRGB(34, 34, 34),
		Size = UDim2.fromOffset(0, 18),
		AutomaticSize = Enum.AutomaticSize.X,
		Parent = parent,
	}, { corner(6), new("UIPadding", { PaddingLeft = UDim.new(0, 7), PaddingRight = UDim.new(0, 7) }) })
	for k, v in props or {} do
		c[k] = v
	end
	return c
end

-- pages ----------------------------------------------------------------------------------------

local tabIcons = {} -- tab -> ImageLabel

local function styleTab(tab, iconSpec)
	tab.Eyebrow.Text = string.upper(tab.Name)
	tab.Eyebrow.TextColor3 = GOLD
	tab.Eyebrow.Font = BOLD
	tab.Title.Font = BOLD
	tab.Title.TextSize = 24
	tab.Title.Size = UDim2.new(1, 0, 0, 32)
	tab.Lbl.Position = UDim2.fromOffset(36, 0)
	tab.Lbl.Size = UDim2.new(1, -36, 1, 0)
	local spec = table.clone(iconSpec)
	spec.Size = UDim2.fromOffset(18, 18)
	spec.Position = UDim2.new(0, 10, 0.5, -9)
	local holder = icon(tab.Btn, spec)
	holder.ZIndex = 3
	for _, d in holder:GetDescendants() do
		if d:IsA("GuiObject") then
			d.ZIndex = 3
		end
	end
	tabIcons[tab] = holder
end

local function paintTabIcons()
	for tab, holder in tabIcons do
		local active = ui.Current == tab
		for _, d in holder:GetDescendants() do
			if d:IsA("ImageLabel") then
				tw(d, FAST, { ImageTransparency = active and 0 or 0.45 })
			elseif d:IsA("TextLabel") then
				tw(d, FAST, { TextTransparency = active and 0 or 0.45 })
			end
		end
		tw(tab.Lbl, FAST, { TextColor3 = active and GOLD_HI or T.Dim })
	end
end

do
	local select = ui.Select
	ui.Select = function(self, tab, instant)
		select(self, tab, instant)
		task.defer(paintTabIcons)
	end
end

local function build(catalog)
	local weaponByName = {}
	for _, w in catalog.Weapons do
		weaponByName[w.Name] = w
	end
	local arImage = weaponByName["Assault Rifle"] and weaponByName["Assault Rifle"].Image or ""
	local keyInfo
	for _, info in catalog.Currencies do
		if info.Field == "WeaponKeys" then
			keyInfo = info
		end
	end
	local firstCrate = catalog.Crates[1]

	local passes = ui:Tab("Game Passes")
	local weapons = ui:Tab("Weapons")
	local cosmetics = ui:Tab("Cosmetics")
	local crates = ui:Tab("Crates")
	local progression = ui:Tab("Progression")
	local currency = ui:Tab("Currency")

	styleTab(passes, { Image = "rbxassetid://17619445340" })
	styleTab(weapons, { Image = arImage, Zoom = WEAPON_ZOOM })
	styleTab(cosmetics, { Image = catalog.CosmeticImages.Skin })
	styleTab(crates, { Image = firstCrate and firstCrate.Image or "" })
	styleTab(progression, { Image = catalog.PassImages[1] or "" })
	styleTab(currency, { Image = keyInfo and keyInfo.Image or "" })
	paintTabIcons()

	-- Game Passes ---------------------------------------------------------------------------
	local passTotal = #catalog.Gamepasses
	describe(passes, "Every game pass, with the bundle of weapons and items that comes with it.")
	hero(passes, {
		Big = function(s)
			return count(s.Gamepasses) .. " / " .. passTotal
		end,
		Caption = function()
			return "game passes owned"
		end,
		Image = "rbxassetid://17619445340",
		Button = "Give All Game Passes",
		Key = "GiveAllGamepasses",
		OnClick = function()
			run("GiveAllGamepasses", "GiveAllGamepasses")
		end,
		Progress = function(s)
			return passTotal > 0 and count(s.Gamepasses) / passTotal or 0
		end,
	})
	local passNames = "game passes " .. names(catalog.Gamepasses, "DisplayName")
	section(passes, "GAME PASSES", passNames)
	local passGrid = grid(passes, UDim2.fromOffset(148, 196), passNames)
	for i, pass in catalog.Gamepasses do
		local key = "Gamepass:" .. pass.Name
		local owned = false
		local t = new("Frame", { BackgroundColor3 = WHITE, LayoutOrder = i, Parent = passGrid }, { corner(14) })
		gradient(t, Color3.fromRGB(44, 34, 14), Color3.fromRGB(16, 15, 13), 90)
		local st = stroke(T.Line)
		st.Parent = t
		tileFeel(t, st, T.Line, function()
			return 0
		end)
		new("Frame", {
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.new(0.5, 0, 0, 58),
			Size = UDim2.fromOffset(92, 92),
			BackgroundColor3 = GOLD,
			BackgroundTransparency = 0.9,
			Parent = t,
		}, { corner(46) })
		icon(t, {
			Image = pass.Image,
			Zoom = pass.ImageIsWeapon and WEAPON_ZOOM or nil,
			Emoji = pass.Image == "" and "\u{1F381}" or nil,
			Size = pass.ImageIsWeapon and UDim2.new(1, -16, 0, 80) or UDim2.fromOffset(74, 74),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.new(0.5, 0, 0, 58),
		})
		if pass.Bubble then
			local bubble = chip(t, {
				Text = pass.Bubble,
				TextColor3 = GOLD_TEXT,
				BackgroundColor3 = WHITE,
				AnchorPoint = Vector2.new(1, 0),
				Position = UDim2.new(1, -8, 0, 8),
			})
			goldFill(bubble)
		end
		text(pass.DisplayName, 13, T.Text, {
			Font = BOLD,
			Position = UDim2.fromOffset(12, 108),
			Size = UDim2.new(1, -24, 0, 18),
			TextTruncate = Enum.TextTruncate.AtEnd,
			Parent = t,
		})
		local price = text("", 12, GOLD, {
			Font = BOLD,
			Position = UDim2.fromOffset(12, 126),
			Size = UDim2.new(1, -24, 0, 16),
			RichText = true,
			Parent = t,
		})
		local give = button(t, "Give", "accent", key, {
			AnchorPoint = Vector2.new(0.5, 1),
			Position = UDim2.new(0.5, 0, 1, -12),
			AutomaticSize = Enum.AutomaticSize.None,
			Size = UDim2.new(1, -24, 0, 30),
		})
		give.MouseButton1Click:Connect(function()
			if not owned then
				run("GiveGamepass", key, pass.Name)
			end
		end)
		table.insert(updaters, function(s)
			owned = s.Gamepasses[pass.Name] == true
			give:SetAttribute("Label", owned and "\u{2713} Owned" or "Give")
			give:SetAttribute("Disabled", owned)
			price.Text = string.format('R$ %s  <font color="#8A8A8A">\u{2022} %d items</font>', commas(pass.Price), pass.Rewards)
		end)
	end

	-- Weapons -------------------------------------------------------------------------------
	local weaponTotal = #catalog.Weapons
	local maxLevel = catalog.MaxWeaponLevel or 99
	local function ownedCount(s)
		local n = 0
		for _, w in catalog.Weapons do
			if s.Weapons[w.Name] then
				n += 1
			end
		end
		return n
	end
	local function maxedCount(s)
		local n = 0
		for _, level in s.Weapons do
			if level >= maxLevel then
				n += 1
			end
		end
		return n
	end
	describe(weapons, "Unlock weapons and max their levels. Tap a weapon to unlock or max it.")
	hero(weapons, {
		Big = function(s)
			return ownedCount(s) .. " / " .. weaponTotal
		end,
		Caption = function()
			return "weapons owned"
		end,
		Image = arImage,
		Zoom = WEAPON_ZOOM,
		Button = "Unlock All Weapons",
		Key = "UnlockAllWeapons",
		OnClick = function()
			run("UnlockAllWeapons", "UnlockAllWeapons")
		end,
		Progress = function(s)
			return weaponTotal > 0 and ownedCount(s) / weaponTotal or 0
		end,
	})
	actionCard(weapons, {
		Title = "Max Weapon Levels",
		Icon = { Emoji = "\u{2B50}" },
		Sub = function(s)
			return string.format("Sets every weapon you own to level %d \u{2022} %d / %d maxed", maxLevel, maxedCount(s), count(s.Weapons))
		end,
		Progress = function(s)
			local owned = count(s.Weapons)
			return owned > 0 and maxedCount(s) / owned or 0
		end,
		Button = "Max All",
		Key = "MaxAllWeapons",
		OnClick = function()
			run("MaxAllWeapons", "MaxAllWeapons")
		end,
	})
	local classes = table.clone(catalog.Classes)
	for _, w in catalog.Weapons do
		if not table.find(classes, w.Class) then
			table.insert(classes, w.Class)
		end
	end
	for _, class in classes do
		local list = {}
		for _, w in catalog.Weapons do
			if w.Class == class then
				table.insert(list, w)
			end
		end
		if #list == 0 then
			continue
		end
		local classNames = class .. " " .. names(list, "Name")
		local header = section(weapons, string.upper(class), classNames)
		table.insert(updaters, function(s)
			local owned = 0
			for _, w in list do
				if s.Weapons[w.Name] then
					owned += 1
				end
			end
			header.Text = string.format('%s   <font color="#FFC840">%d</font><font color="#5C5C5C">/%d</font>', string.upper(class), owned, #list)
		end)
		local g = grid(weapons, UDim2.fromOffset(120, 128), classNames)
		for i, w in list do
			local key = "Weapon:" .. w.Name
			local tint = STATUS_TINT[w.Status] or STATUS_TINT.Standard
			local t = new("TextButton", { Text = "", AutoButtonColor = false, BackgroundColor3 = WHITE, LayoutOrder = i, Parent = g }, { corner(12) })
			gradient(t, tint[1], tint[2], 90)
			local st = stroke(T.Line)
			st.Parent = t
			local level = nil
			local function restTransparency()
				return level and level >= maxLevel and 0.35 or 0
			end
			local function restColor()
				return level and level >= maxLevel and GOLD or T.Line
			end
			local scale = new("UIScale", { Parent = t })
			t.MouseEnter:Connect(function()
				tw(st, FAST, { Color = GOLD, Transparency = 0 })
				tw(scale, SPRING, { Scale = 1.04 })
			end)
			t.MouseLeave:Connect(function()
				tw(st, FAST, { Color = restColor(), Transparency = restTransparency() })
				tw(scale, SPRING, { Scale = 1 })
			end)
			t.MouseButton1Down:Connect(function()
				tw(scale, FAST, { Scale = 0.95 })
			end)
			t.MouseButton1Up:Connect(function()
				tw(scale, SPRING, { Scale = 1.04 })
			end)
			if STATUS_COLORS[w.Status] then
				text(string.upper(w.Status), 9, STATUS_COLORS[w.Status], {
					Font = BOLD,
					Position = UDim2.fromOffset(10, 6),
					Size = UDim2.new(1, -20, 0, 12),
					ZIndex = 2,
					Parent = t,
				})
			end
			local _, img = icon(t, { Image = w.Image, Zoom = WEAPON_ZOOM, Size = UDim2.new(1, -16, 0, 64), Position = UDim2.fromOffset(8, 16) })
			text(w.Name, 12, T.Text, {
				Font = BOLD,
				Position = UDim2.fromOffset(10, 82),
				Size = UDim2.new(1, -20, 0, 16),
				TextTruncate = Enum.TextTruncate.AtEnd,
				Parent = t,
			})
			local badge = chip(t, { Position = UDim2.new(0, 10, 1, -26) })
			local badgeGold = goldFill(badge)
			local function paint(left)
				local maxed = level and level >= maxLevel
				badgeGold.Enabled = maxed and left == 0
				if left > 0 then
					badge.Text = "\u{23F3} " .. left .. "s"
					badge.TextColor3, badge.BackgroundColor3 = T.Muted, Color3.fromRGB(34, 34, 34)
				elseif not level then
					badge.Text = "\u{1F512} LOCKED"
					badge.TextColor3, badge.BackgroundColor3 = T.Dim, Color3.fromRGB(26, 26, 26)
				elseif maxed then
					badge.Text = "MAX \u{2022} LV " .. level
					badge.TextColor3, badge.BackgroundColor3 = GOLD_TEXT, WHITE
				else
					badge.Text = "LV " .. level
					badge.TextColor3, badge.BackgroundColor3 = T.Text, Color3.fromRGB(44, 44, 44)
				end
				img.ImageTransparency = level and 0 or 0.35
				img.ImageColor3 = level and WHITE or Color3.fromRGB(110, 110, 110)
				st.Color, st.Transparency = restColor(), restTransparency()
			end
			watch(key, paint)
			table.insert(updaters, function(s)
				level = s.Weapons[w.Name]
			end)
			t.MouseButton1Click:Connect(function()
				if level and level >= maxLevel then
					ui:Notify(w.Name .. " is already maxed")
					return
				end
				run("Weapon", key, w.Name)
			end)
		end
	end

	-- Cosmetics -----------------------------------------------------------------------------
	local allTotal = 0
	for _, n in catalog.CosmeticTotals do
		allTotal += n
	end
	local function allOwned(s)
		local owned = 0
		for _, n in s.Cosmetics do
			owned += n
		end
		return owned
	end
	describe(cosmetics, "Skins, wraps, charms, finishers and emotes, usable on every weapon.")
	hero(cosmetics, {
		Big = function(s)
			return commas(allOwned(s)) .. " / " .. commas(allTotal)
		end,
		Caption = function()
			return "cosmetics owned"
		end,
		Image = catalog.CosmeticImages.Skin,
		Button = "Unlock Every Cosmetic",
		Key = "UnlockAllCosmetics",
		OnClick = function()
			run("UnlockAllCosmetics", "UnlockAllCosmetics")
		end,
		Progress = function(s)
			return allTotal > 0 and allOwned(s) / allTotal or 0
		end,
	})
	section(cosmetics, "BY TYPE")
	for _, kind in catalog.CosmeticTypes do
		local total = catalog.CosmeticTotals[kind] or 0
		local key = "Cosmetics:" .. kind
		actionCard(cosmetics, {
			Title = kind .. "s",
			Icon = { Image = catalog.CosmeticImages[kind] },
			Sub = function(s)
				return string.format('<font color="#F5F5F5"><b>%s</b></font> / %s owned', commas(s.Cosmetics[kind] or 0), commas(total))
			end,
			Progress = function(s)
				return total > 0 and (s.Cosmetics[kind] or 0) / total or 0
			end,
			Button = "Unlock all",
			Key = key,
			OnClick = function()
				run("UnlockCosmetics", key, kind)
			end,
		})
	end

	-- Crates --------------------------------------------------------------------------------
	local crateTotal = #catalog.Crates
	local amount = 1
	local function backpackTotal(s)
		local n = 0
		for _, q in s.Crates do
			n += q
		end
		return n
	end
	hero(crates, {
		Big = function(s)
			return commas(backpackTotal(s))
		end,
		Caption = function()
			return "crates in your backpack"
		end,
		Image = firstCrate and firstCrate.Image or "",
		Desc = "Crates go to your Backpack, open them from the Backpack button in the lobby.",
	})
	do
		local c = card(crates, 58, nil, nil, "Amount")
		text("Amount", 14, T.Text, { Font = BOLD, Position = UDim2.fromOffset(18, 0), Size = UDim2.new(0, 120, 1, 0), Parent = c })
		local seg = new("Frame", {
			AnchorPoint = Vector2.new(1, 0.5),
			Position = UDim2.new(1, -14, 0.5, 0),
			Size = UDim2.fromOffset(0, 36),
			AutomaticSize = Enum.AutomaticSize.X,
			BackgroundColor3 = Color3.fromRGB(12, 12, 12),
			Parent = c,
		}, {
			corner(10),
			stroke(T.Line2),
			new("UIPadding", { PaddingLeft = UDim.new(0, 4), PaddingRight = UDim.new(0, 4) }),
			new("UIListLayout", {
				FillDirection = Enum.FillDirection.Horizontal,
				VerticalAlignment = Enum.VerticalAlignment.Center,
				Padding = UDim.new(0, 3),
				SortOrder = Enum.SortOrder.LayoutOrder,
			}),
		})
		local pills = {}
		local function paint()
			for value, p in pills do
				local on = value == amount
				p.Gold.Enabled = on
				p.Button.BackgroundTransparency = on and 0 or 1
				tw(p.Button, FAST, { TextColor3 = on and GOLD_TEXT or T.Muted })
			end
		end
		for i, value in AMOUNTS do
			local pill = new("TextButton", {
				Text = "x" .. value,
				Font = BOLD,
				TextSize = 13,
				AutoButtonColor = false,
				BackgroundColor3 = WHITE,
				BackgroundTransparency = 1,
				TextColor3 = T.Muted,
				Size = UDim2.fromOffset(48, 28),
				LayoutOrder = i,
				Parent = seg,
			}, { corner(7) })
			pills[value] = { Button = pill, Gold = goldFill(pill) }
			pill.MouseButton1Click:Connect(function()
				amount = value
				paint()
			end)
		end
		paint()
	end
	actionCard(crates, {
		Title = "Give Every Crate",
		Icon = { Emoji = "\u{1F4E6}" },
		Sub = function()
			return string.format("All %d crates, at the amount above", crateTotal)
		end,
		Button = "Give All",
		Key = "GiveAllCrates",
		OnClick = function()
			run("GiveAllCrates", "GiveAllCrates", amount)
		end,
	})
	local crateNames = "crates " .. names(catalog.Crates, "DisplayName")
	section(crates, "CRATES", crateNames)
	local crateGrid = grid(crates, UDim2.fromOffset(120, 176), crateNames)
	for i, crate in catalog.Crates do
		local key = "Crate:" .. crate.Name
		local t = new("Frame", { BackgroundColor3 = WHITE, LayoutOrder = i, Parent = crateGrid }, { corner(12) })
		gradient(t, Color3.fromRGB(30, 28, 24), Color3.fromRGB(15, 15, 15), 90)
		local st = stroke(T.Line)
		st.Parent = t
		tileFeel(t, st, T.Line, function()
			return 0
		end)
		new("Frame", {
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.new(0.5, 0, 0, 46),
			Size = UDim2.fromOffset(74, 74),
			BackgroundColor3 = GOLD,
			BackgroundTransparency = 0.91,
			Parent = t,
		}, { corner(37) })
		icon(t, {
			Image = crate.Image,
			Size = UDim2.fromOffset(72, 72),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.new(0.5, 0, 0, 46),
		})
		local have = chip(t, {
			AnchorPoint = Vector2.new(1, 0),
			Position = UDim2.new(1, -7, 0, 7),
			TextColor3 = GOLD_TEXT,
			BackgroundColor3 = WHITE,
			Visible = false,
		})
		goldFill(have)
		text(crate.DisplayName, 12, T.Text, {
			Font = BOLD,
			Position = UDim2.fromOffset(10, 90),
			Size = UDim2.new(1, -20, 0, 16),
			TextTruncate = Enum.TextTruncate.AtEnd,
			Parent = t,
		})
		local haveText = text("None in backpack", 11, T.Dim, {
			Position = UDim2.fromOffset(10, 106),
			Size = UDim2.new(1, -20, 0, 14),
			TextTruncate = Enum.TextTruncate.AtEnd,
			Parent = t,
		})
		local give = button(t, "Give", "accent", key, {
			AnchorPoint = Vector2.new(0.5, 1),
			Position = UDim2.new(0.5, 0, 1, -10),
			AutomaticSize = Enum.AutomaticSize.None,
			Size = UDim2.new(1, -20, 0, 30),
		})
		give.MouseButton1Click:Connect(function()
			run("GiveCrate", key, crate.Name, amount)
		end)
		table.insert(updaters, function(s)
			local n = s.Crates[crate.Name] or 0
			have.Visible = n > 0
			have.Text = "x" .. commas(n)
			haveText.Text = n > 0 and string.format("%s in backpack", commas(n)) or "None in backpack"
			haveText.TextColor3 = n > 0 and T.Muted or T.Dim
		end)
	end

	-- Progression ---------------------------------------------------------------------------
	local maxPass = catalog.MaxPassLevel or 100
	describe(progression, "Your account level, the season pass and Prime. Statistics like win streaks and duels are earned in game only.")
	hero(progression, {
		Big = function(s)
			return "Level " .. commas(s.Level)
		end,
		Caption = function(s)
			return string.format("Season pass tier %d / %d%s", s.PassLevel, maxPass, s.Prime and "  \u{2022}  Prime" or "")
		end,
		Image = catalog.PassImages[1] or "",
		Desc = "Level shows on your nametag, profile and the Highest Level board.",
		Progress = function(s)
			return s.PassLevel / maxPass
		end,
	})
	valueRow(progression, {
		Title = "Level",
		Icon = { Emoji = "\u{1F396}\u{FE0F}" },
		Key = "SetLevel",
		Placeholder = "1 - 9999",
		Current = function(s)
			return commas(s.Level)
		end,
		OnSet = function(v)
			run("SetLevel", "SetLevel", v)
		end,
	})
	valueRow(progression, {
		Title = "Season Pass Tier",
		Icon = { Image = catalog.PassImages[1] or "" },
		Key = "SetPassLevel",
		Placeholder = "0 - " .. maxPass,
		Current = function(s)
			return s.PassLevel .. " / " .. maxPass
		end,
		OnSet = function(v)
			run("SetPassLevel", "SetPassLevel", v)
		end,
	})
	switchRow(progression, {
		Title = "Prime Season Pass",
		Icon = { Image = catalog.PassImages[2] or catalog.PassImages[1] or "" },
		SubText = "The premium track of the current season",
		Key = "SetPrime",
		Get = function(s)
			return s.Prime == true
		end,
		OnToggle = function(on)
			run("SetPrime", "SetPrime", on)
		end,
	})

	-- Currency ------------------------------------------------------------------------------
	describe(currency, "Set how much of each currency you have. Keys unlock weapons in the shop.")
	hero(currency, {
		Big = function(s)
			return commas(s.Currency.WeaponKeys or 0)
		end,
		Caption = function()
			return "keys"
		end,
		Image = keyInfo and keyInfo.Image or "",
		Desc = "The shop, crates and weapon unlocks all spend keys.",
	})
	for _, info in catalog.Currencies do
		local key = "Currency:" .. info.Field
		valueRow(currency, {
			Title = info.Name,
			Icon = { Image = info.Image },
			Key = key,
			Current = function(s)
				return commas(s.Currency[info.Field] or 0)
			end,
			OnSet = function(v)
				run("SetCurrency", key, info.Field, v)
			end,
		})
	end
end

-- header: Unlock Everything ---------------------------------------------------------------------

if titleBar then
	local everything = button(titleBar, "\u{1F451}  Unlock Everything", "accent", "UnlockEverything", {
		AnchorPoint = Vector2.new(1, 0.5),
		Position = UDim2.new(1, -54, 0.5, 0),
		Size = UDim2.fromOffset(0, 28),
	})
	everything.MouseButton1Click:Connect(function()
		run("UnlockEverything", "UnlockEverything")
	end)
end

-- open / close ---------------------------------------------------------------------------------

local built = false

local function toggle()
	if not built then
		ui:Notify("Admin panel is still loading")
		return
	end
	local opening = not ui.Visible
	if opening then
		fitWindow()
	end
	ui:Toggle(opening)
	if opening then
		refresh()
	end
end

ToggleEvent.Event:Connect(toggle)
UserInputService.InputBegan:Connect(function(input)
	if input.KeyCode == TOGGLE_KEY and not UserInputService:GetFocusedTextBox() then
		toggle()
	end
end)

-- cooldown countdowns
task.spawn(function()
	while true do
		task.wait(0.25)
		if ui.Visible then
			tick(false)
		end
	end
end)

-- boot: the catalog once (retries while the player's data loads)
task.spawn(function()
	for _ = 1, 60 do
		local ok, result = pcall(Remote.InvokeServer, Remote, "Catalog")
		if ok and type(result) == "table" and result.Ok and result.Catalog then
			build(result.Catalog)
			built = true
			applyState(result.State)
			return
		end
		task.wait(2)
	end
	warn("[AdminPanel] could not load the catalog")
end)
