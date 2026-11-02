-- Admin panel, built on ReplicatedStorage.NovaUI.
--
-- Opens from the lobby's "Admin" button (next to Settings; Lobby.Buttons fires
-- PlayerGui.AdminPanel.Toggle) or with F5. Clicking your profile card (bottom left) shows your
-- statistics, read-only.
--
-- Colours mean something: green gives / unlocks, red removes, blue sets a number, purple maxes.
-- The brand (logo, profile rings) is a neutral silver; no gold anywhere. Each tab has its own tint.
--
-- Everything it shows comes from ServerScriptService.Server.AdminPanelService through
-- ReplicatedStorage.AdminPanelRemote: "Catalog" once, then a fresh State with every answer,
-- "Profile" for the stats page. The server owns the 25s cooldowns; buttons only mirror them.

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
local rgb = Color3.fromRGB

local PALETTE = {
	Green = { Hi = rgb(134, 239, 172), Mid = rgb(34, 197, 94), Lo = rgb(21, 128, 61), Text = rgb(4, 36, 16) },
	Red = { Hi = rgb(252, 165, 165), Mid = rgb(239, 68, 68), Lo = rgb(185, 28, 28), Text = WHITE },
	Blue = { Hi = rgb(147, 197, 253), Mid = rgb(59, 130, 246), Lo = rgb(29, 78, 216), Text = WHITE },
	Purple = { Hi = rgb(216, 180, 254), Mid = rgb(168, 85, 247), Lo = rgb(109, 40, 217), Text = WHITE },
	Pink = { Hi = rgb(251, 207, 232), Mid = rgb(236, 72, 153), Lo = rgb(190, 24, 93), Text = WHITE },
	Orange = { Hi = rgb(254, 215, 170), Mid = rgb(249, 115, 22), Lo = rgb(194, 65, 12), Text = WHITE },
	Teal = { Hi = rgb(153, 246, 228), Mid = rgb(20, 184, 166), Lo = rgb(15, 118, 110), Text = WHITE },
	Slate = { Hi = rgb(241, 245, 249), Mid = rgb(203, 213, 225), Lo = rgb(148, 163, 184), Text = rgb(15, 23, 42) },
}
-- what each colour does
local GIVE, REMOVE, SET, MAX, BRAND = "Green", "Red", "Blue", "Purple", "Slate"

local STATUS_COLORS = {
	Prime = rgb(190, 132, 255),
	Contraband = rgb(255, 96, 96),
}
local STATUS_TINT = {
	Standard = { rgb(28, 28, 28), rgb(15, 15, 15) },
	Prime = { rgb(40, 30, 60), rgb(16, 14, 21) },
	Contraband = { rgb(58, 22, 22), rgb(19, 14, 14) },
}
local ADMIN_ICON = "rbxassetid://127904742940104" -- the game's own staff/debug icon

local T = Nova.Theme
T.Accent = PALETTE.Green.Mid

local FONT, MED, BOLD = Enum.Font.BuilderSans, Enum.Font.BuilderSansMedium, Enum.Font.BuilderSansBold
local FAST = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local EASE = TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
local SPRING = TweenInfo.new(0.45, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
local AMOUNTS = { 1, 5, 10, 25, 50 }
local MAX_AMOUNT = 1000
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

-- A glossy fill in one of the PALETTE colours (the parent's own colour must be white).
local function fill(parent, colorName: string, rotation: number?)
	local p = PALETTE[colorName]
	return gradient(parent, p.Hi, p.Mid, rotation or 90, p.Lo)
end

-- A colour mixed into the dark card colour, for tints.
local function tint(colorName: string, amount: number): Color3
	return rgb(16, 16, 16):Lerp(PALETTE[colorName].Mid, amount)
end

local function hex(c: Color3): string
	return string.format("#%02X%02X%02X", math.floor(c.R * 255), math.floor(c.G * 255), math.floor(c.B * 255))
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

-- A rounded square tinted with a colour, with an icon in it.
local function iconBadge(parent, size: number, o, colorName: string, props)
	local b = new("Frame", { Size = UDim2.fromOffset(size, size), BackgroundColor3 = WHITE, Parent = parent }, { corner(math.floor(size * 0.28)) })
	gradient(b, tint(colorName, 0.32), tint(colorName, 0.1), 135)
	stroke(PALETTE[colorName].Mid, 0.55).Parent = b
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
-- It stays below Roblox's top bar (the title bar under it can't be touched on phones), and on
-- touch screens it leaves room around it so it can actually be dragged somewhere.
local autoSize = nil
local function fitWindow()
	if ui.Maximized or ui.Minimized or (autoSize and ui.Size ~= autoSize) then
		return
	end
	local vp = workspace.CurrentCamera.ViewportSize
	local inset = game:GetService("GuiService"):GetGuiInset().Y
	local touch = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
	local w = touch and math.floor(vp.X * 0.86) or vp.X - 24
	local h = touch and math.floor((vp.Y - inset) * 0.9) or vp.Y - inset - 24
	local first = autoSize == nil
	autoSize = UDim2.fromOffset(math.clamp(w, 480, 900), math.clamp(h, 300, 600))
	ui.Size = autoSize
	ui.Window.Size = autoSize
	if first then
		ui.Window.Position = UDim2.new(0.5, 0, 0.5, inset / 2)
	end
	ui:_clamp()
end
do
	local deadline = os.clock() + 10
	while workspace.CurrentCamera.ViewportSize.X < 100 and os.clock() < deadline do
		task.wait()
	end
	fitWindow()
end


local titleBar
for _, child in ui.Window:GetChildren() do
	if child:IsA("Frame") and child.Size == UDim2.new(1, 0, 0, 40) then
		titleBar = child
	end
end

-- a wash across the top of the pages, in the current tab's tint
local wash = new("Frame", {
	Name = "Wash",
	Size = UDim2.new(1, 0, 0, 220),
	BackgroundColor3 = PALETTE.Green.Mid,
	BorderSizePixel = 0,
	ZIndex = 0,
	Parent = ui.Pages,
})
do
	local g = new("UIGradient", { Rotation = 90, Parent = wash })
	g.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.92), NumberSequenceKeypoint.new(1, 1) })
end

-- sidebar: logo, brand, status line, active pill with an edge in the tab's tint
for _, child in ui.SideFrame:GetChildren() do
	if child:IsA("Frame") and child.Size == UDim2.fromOffset(18, 18) then
		for _, bar in child:GetChildren() do
			bar:Destroy()
		end
		child.Size = UDim2.fromOffset(22, 22)
		child.Position = UDim2.fromOffset(2, 0)
		child.BackgroundColor3 = WHITE
		corner(7).Parent = child
		fill(child, BRAND, 135)
		icon(child, {
			Image = ADMIN_ICON,
			Size = UDim2.fromScale(0.8, 0.8),
			Position = UDim2.fromScale(0.5, 0.5),
			AnchorPoint = Vector2.new(0.5, 0.5),
		})
	elseif child:IsA("TextLabel") and child.Text == "nova" then
		child.Text = "Admin Panel"
		child.Font = BOLD
		child.TextSize = 15
		child.TextColor3 = WHITE
		child.Position = UDim2.fromOffset(32, 0)
	elseif child:IsA("TextLabel") and child.Text == "Online" then
		child.Size = UDim2.fromOffset(150, 20)
		child.TextTruncate = Enum.TextTruncate.AtEnd
		child.Text = "25s cooldown on each command"
	end
end
ui.ActivePill.BackgroundColor3 = rgb(30, 30, 30)
local pillEdge = new("Frame", {
	AnchorPoint = Vector2.new(0, 0.5),
	Position = UDim2.new(0, 0, 0.5, 0),
	Size = UDim2.fromOffset(3, 16),
	BackgroundColor3 = PALETTE.Green.Mid,
	BorderSizePixel = 0,
	Parent = ui.ActivePill,
}, { corner(2) })

-- toasts: a red cross instead of the check when something failed
local toastResults = {} -- one entry per notify(), in order (ChildAdded may fire deferred)
ui.Toasts.ChildAdded:Connect(function(toast)
	local ok = table.remove(toastResults, 1)
	if ok == nil then
		ok = true
	end
	task.defer(function()
		if ok then
			return
		end
		for _, child in toast:GetChildren() do
			if child:IsA("Frame") and child.Size == UDim2.fromOffset(18, 18) then
				child.BackgroundColor3 = rgb(70, 20, 20)
				for _, mark in child:GetChildren() do
					if mark:IsA("GuiObject") then
						mark.Visible = false
					end
				end
				text("\u{2715}", 11, PALETTE.Red.Hi, {
					Font = BOLD,
					Size = UDim2.fromScale(1, 1),
					TextXAlignment = Enum.TextXAlignment.Center,
					Parent = child,
				})
			end
		end
	end)
end)
local function notify(message: string, ok: boolean?)
	table.insert(toastResults, ok ~= false)
	ui:Notify(message)
end

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
		notify(string.format("On cooldown for %ds", left), false)
		return
	end
	pending[key] = true
	task.spawn(function()
		local ok, result = pcall(Remote.InvokeServer, Remote, action, a, b)
		pending[key] = nil
		if not ok or type(result) ~= "table" then
			notify("Couldn't reach the server", false)
			return
		end
		applyState(result.State)
		if result.Message then
			notify(result.Message, result.Ok == true)
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

-- colorName: a PALETTE colour, or "Ghost". key = the server cooldown it mirrors. Attributes:
-- Label (text when not cooling down), Disabled (greyed, e.g. "Owned"), Compact (short countdown).
-- The colour lives on a "Fill" child and the text on a "Label" child above it: a UIGradient on
-- the button itself would tint its text too (white text on red would vanish).
local function button(parent, label: string, colorName: string, key: string?, props)
	local colors = PALETTE[colorName]
	local b = new("TextButton", {
		Text = "",
		AutoButtonColor = false,
		TextSize = 12,
		BackgroundColor3 = T.Pill,
		BackgroundTransparency = colors and 1 or 0,
		Size = UDim2.fromOffset(0, 30),
		AutomaticSize = Enum.AutomaticSize.X,
		Parent = parent,
	}, { corner(9) })
	local bg, grad
	if colors then
		bg = new("Frame", { Name = "Fill", Size = UDim2.fromScale(1, 1), BackgroundColor3 = WHITE, BorderSizePixel = 0, Parent = b }, { corner(9) })
		grad = fill(bg, colorName)
	end
	local st = stroke(colors and colors.Hi or T.Line2, colors and 0.6 or 0)
	st.Parent = b
	for k, v in props or {} do
		b[k] = v
	end
	local text = new("TextLabel", {
		Name = "Label",
		BackgroundTransparency = 1,
		Text = label,
		Font = BOLD,
		TextSize = b.TextSize,
		TextColor3 = colors and colors.Text or T.Body,
		Size = b.AutomaticSize == Enum.AutomaticSize.X and UDim2.fromScale(0, 1) or UDim2.fromScale(1, 1),
		AutomaticSize = b.AutomaticSize == Enum.AutomaticSize.X and Enum.AutomaticSize.X or Enum.AutomaticSize.None,
		ZIndex = 2,
		Parent = b,
	}, { new("UIPadding", { PaddingLeft = UDim.new(0, 14), PaddingRight = UDim.new(0, 14) }) })
	b:SetAttribute("Label", label)
	local scale = new("UIScale", { Parent = b })
	local hovered = false
	local function paint()
		local disabled = b:GetAttribute("Disabled") == true
		local cooling = secondsLeft(key) > 0
		local live = hovered and not disabled and not cooling
		if colors then
			grad.Enabled = not disabled
			bg.BackgroundColor3 = disabled and T.Pill or WHITE
			text.TextColor3 = disabled and T.Muted or colors.Text
			tw(st, FAST, { Transparency = disabled and 0.2 or (live and 0 or 0.6), Color = disabled and T.Line2 or colors.Hi })
			tw(bg, FAST, { BackgroundTransparency = cooling and 0.5 or 0 })
		else
			tw(st, FAST, { Color = live and T.Muted or T.Line2 })
			tw(text, FAST, { TextColor3 = live and T.Text or T.Body })
			tw(b, FAST, { BackgroundTransparency = cooling and 0.5 or 0 })
		end
		tw(text, FAST, { TextTransparency = cooling and 0.25 or 0 })
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
			text.Text = b:GetAttribute("Label")
		end
	end)
	b:GetAttributeChangedSignal("Disabled"):Connect(paint)
	b:GetAttributeChangedSignal("Compact"):Connect(function()
		-- narrow icon buttons: no side padding
		local pad = text:FindFirstChildOfClass("UIPadding")
		if pad then
			pad:Destroy()
		end
	end)
	if key then
		watch(key, function(left)
			if left > 0 then
				text.Text = b:GetAttribute("Compact") and (left .. "s") or ("\u{23F3} " .. left .. "s")
			else
				text.Text = b:GetAttribute("Label")
			end
			paint()
		end)
	end
	paint()
	return b
end

-- A number-only text box. onEnter(value) when Enter is pressed.
local function numberBox(parent, placeholder: string, props, onEnter)
	local box = new("TextBox", {
		BackgroundColor3 = rgb(12, 12, 12),
		Text = "",
		PlaceholderText = placeholder,
		PlaceholderColor3 = T.Dim,
		TextColor3 = T.Text,
		Font = MED,
		TextSize = 13,
		ClearTextOnFocus = false,
		TextXAlignment = Enum.TextXAlignment.Left,
		Parent = parent,
	}, { corner(9), new("UIPadding", { PaddingLeft = UDim.new(0, 11), PaddingRight = UDim.new(0, 11) }) })
	local st = stroke(T.Line2)
	st.Parent = box
	for k, v in props or {} do
		box[k] = v
	end
	box.Focused:Connect(function()
		tw(st, FAST, { Color = PALETTE.Blue.Mid })
	end)
	box:GetPropertyChangedSignal("Text"):Connect(function()
		local clean = string.sub(string.gsub(box.Text, "%D", ""), 1, 10)
		if clean ~= box.Text then
			box.Text = clean
		end
	end)
	box.FocusLost:Connect(function(enter)
		tw(st, FAST, { Color = T.Line2 })
		if enter and onEnter then
			onEnter(tonumber(box.Text))
		end
	end)
	return box
end

-- A NovaUI-style card (holder + CanvasGroup "Card"), so the tab's rise animation picks it up.
-- search: text NovaUI's sidebar search matches against (children with a "Search" attribute
-- are shown / hidden by it; everything else always shows).
local function card(tab, h: number, search: string?)
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
	gradient(bg, rgb(22, 22, 22), rgb(14, 14, 14), 90)
	local st = stroke(T.Line)
	st.Parent = c
	holder.MouseEnter:Connect(function()
		tw(st, FAST, { Color = PALETTE[tab.Tint].Mid, Transparency = 0.5 })
	end)
	holder.MouseLeave:Connect(function()
		tw(st, FAST, { Color = T.Line, Transparency = 0 })
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

local function sectionRow(parent, s: string, colorName: string, order: number?)
	local row = new("Frame", {
		Size = UDim2.new(1, 0, 0, 30),
		BackgroundTransparency = 1,
		LayoutOrder = order or 0,
		Parent = parent,
	})
	new("Frame", {
		Position = UDim2.fromOffset(0, 12),
		Size = UDim2.fromOffset(3, 12),
		BackgroundColor3 = PALETTE[colorName].Mid,
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
	return label, row
end

local function section(tab, s: string, search: string?)
	tab.Order += 1
	local label, row = sectionRow(tab.Page, s, tab.Tint, tab.Order)
	if search then
		row:SetAttribute("Search", search)
	end
	return label
end

-- The big card at the top of a page: a large number, what it counts, an optional button (or a
-- line of text), a picture on the right and a progress line along the bottom, all in the tab's tint.
-- o = { Big(s), Caption(s), Image?, Zoom?, Emoji?, Desc?, Button?, Color?, Key?, OnClick?, Progress(s)? }
local function hero(tab, o)
	local c = card(tab, 128)
	local colors = PALETTE[tab.Tint]
	c.Bg:FindFirstChildOfClass("UIGradient"):Destroy()
	gradient(c.Bg, tint(tab.Tint, 0.28), tint(tab.Tint, 0.08), 0, rgb(16, 16, 16))
	c:FindFirstChildOfClass("UIStroke").Color = colors.Mid
	c:FindFirstChildOfClass("UIStroke").Transparency = 0.65
	for i, size in { 230, 150 } do
		new("Frame", {
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.new(1, -92, 0.5, 0),
			Size = UDim2.fromOffset(size, size),
			BackgroundColor3 = colors.Mid,
			BackgroundTransparency = i == 1 and 0.92 or 0.86,
			Parent = c,
		}, { corner(size // 2) })
	end
	icon(c, {
		Image = o.Image,
		Zoom = o.Zoom,
		Emoji = o.Emoji,
		Size = UDim2.fromOffset(o.Zoom and 150 or 100, 100),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.new(1, -92, 0.5, 0),
		Rotation = -8,
	})
	local big = text("", 36, T.Text, { Font = BOLD, Position = UDim2.fromOffset(22, 14), Size = UDim2.new(1, -230, 0, 40), Parent = c })
	local caption = text("", 13, colors.Hi, { Font = MED, Position = UDim2.fromOffset(22, 54), Size = UDim2.new(1, -230, 0, 18), Parent = c })
	if o.Button then
		local b = button(c, o.Button, o.Color or GIVE, o.Key, { Position = UDim2.fromOffset(22, 80), Size = UDim2.fromOffset(0, 32) })
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
	local bar
	if o.Progress then
		local track = new("Frame", {
			AnchorPoint = Vector2.new(0, 1),
			Position = UDim2.fromScale(0, 1),
			Size = UDim2.new(1, 0, 0, 4),
			BackgroundColor3 = tint(tab.Tint, 0.2),
			BorderSizePixel = 0,
			Parent = c,
		})
		bar = new("Frame", { Size = UDim2.fromScale(0, 1), BackgroundColor3 = WHITE, BorderSizePixel = 0, Parent = track })
		fill(bar, GIVE, 0)
	end
	table.insert(updaters, function(s)
		big.Text = o.Big(s)
		caption.Text = o.Caption(s)
		if bar then
			tw(bar, EASE, { Size = UDim2.fromScale(math.clamp(o.Progress(s), 0, 1), 1) })
		end
	end)
end

-- Icon, title, live subtitle, optional progress bar with a percentage, a button on the right.
-- o = { Title, Icon?, IconColor?, Sub(state), Progress(state)?, Fill?, Button, Color, Label(state)?,
--       Disabled(state)?, Key, OnClick }
local function actionCard(tab, o)
	local h = o.Progress and 78 or 66
	local c = card(tab, h, o.Title)
	local x = 18
	if o.Icon then
		iconBadge(c, 46, o.Icon, o.IconColor or o.Color, { AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 14, 0.5, 0) })
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
	local bar, percent
	if o.Progress then
		local track = new("Frame", {
			Position = UDim2.fromOffset(x, 57),
			Size = UDim2.new(1, -x - 190, 0, 6),
			BackgroundColor3 = rgb(34, 34, 34),
			BorderSizePixel = 0,
			Parent = c,
		}, { corner(3) })
		bar = new("Frame", { Size = UDim2.fromScale(0, 1), BackgroundColor3 = WHITE, BorderSizePixel = 0, Parent = track }, { corner(3) })
		fill(bar, o.Fill or GIVE, 0)
		percent = text("0%", 11, PALETTE[o.Fill or GIVE].Hi, { Font = BOLD, Position = UDim2.new(1, -182, 0, 52), Size = UDim2.fromOffset(40, 16), Parent = c })
	end
	local b = button(c, o.Button, o.Color, o.Key, {
		AnchorPoint = Vector2.new(1, 0.5),
		Position = UDim2.new(1, -18, 0.5, 0),
		AutomaticSize = Enum.AutomaticSize.None,
		Size = UDim2.fromOffset(112, 32),
	})
	b.MouseButton1Click:Connect(o.OnClick)
	table.insert(updaters, function(s)
		sub.Text = o.Sub(s)
		if bar then
			local p = math.clamp(o.Progress(s), 0, 1)
			tw(bar, EASE, { Size = UDim2.fromScale(p, 1) })
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

-- Icon, title, "Current: x", a number box and a blue Set.
-- o = { Title, Icon?, Current(state), Key, OnSet(value), Placeholder? }
local function valueRow(tab, o)
	local c = card(tab, 66, o.Title)
	local x = 18
	if o.Icon then
		iconBadge(c, 42, o.Icon, tab.Tint, { AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 14, 0.5, 0) })
		x = 68
	end
	text(o.Title, 14, T.Text, { Font = BOLD, Position = UDim2.fromOffset(x, 14), Size = UDim2.new(1, -x - 220, 0, 18), Parent = c })
	local current = text("", 12, T.Muted, {
		Position = UDim2.fromOffset(x, 33),
		Size = UDim2.new(1, -x - 220, 0, 16),
		RichText = true,
		Parent = c,
	})
	local submit
	local box = numberBox(c, o.Placeholder or "Amount", {
		AnchorPoint = Vector2.new(1, 0.5),
		Position = UDim2.new(1, -94, 0.5, 0),
		Size = UDim2.fromOffset(124, 32),
	}, function()
		submit()
	end)
	local b = button(c, "Set", SET, o.Key, {
		AnchorPoint = Vector2.new(1, 0.5),
		Position = UDim2.new(1, -18, 0.5, 0),
		AutomaticSize = Enum.AutomaticSize.None,
		Size = UDim2.fromOffset(66, 32),
	})
	submit = function()
		local value = tonumber(box.Text)
		if not value then
			notify("Enter a number first", false)
			return
		end
		o.OnSet(value)
		box.Text = ""
	end
	b.MouseButton1Click:Connect(submit)
	table.insert(updaters, function(s)
		current.Text = 'Current: <font color="#F5F5F5"><b>' .. o.Current(s) .. "</b></font>"
	end)
end

-- A switch driven by state (it only flips once the server answers).
local function switchRow(tab, o)
	local c = card(tab, 66, o.Title)
	local x = 18
	if o.Icon then
		iconBadge(c, 42, o.Icon, tab.Tint, { AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 14, 0.5, 0) })
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
	local trackFill = fill(track, GIVE, 0)
	trackFill.Enabled = false
	local knob = new("Frame", {
		Size = UDim2.fromOffset(18, 18),
		Position = UDim2.fromOffset(3, 3),
		BackgroundColor3 = rgb(250, 250, 250),
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
		trackFill.Enabled = on
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

-- Hover/press feel for grid tiles; the border lights up in `colorName`.
local function tileFeel(t, st, colorName: string, rest: () -> (Color3, number))
	local scale = new("UIScale", { Parent = t })
	t.MouseEnter:Connect(function()
		tw(st, FAST, { Color = PALETTE[colorName].Mid, Transparency = 0 })
		tw(scale, SPRING, { Scale = 1.03 })
	end)
	t.MouseLeave:Connect(function()
		local color, transparency = rest()
		tw(st, FAST, { Color = color, Transparency = transparency })
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
		BackgroundColor3 = rgb(34, 34, 34),
		Size = UDim2.fromOffset(0, 18),
		AutomaticSize = Enum.AutomaticSize.X,
		Parent = parent,
	}, { corner(6), new("UIPadding", { PaddingLeft = UDim.new(0, 7), PaddingRight = UDim.new(0, 7) }) })
	for k, v in props or {} do
		c[k] = v
	end
	return c
end

-- profile (read-only statistics) ---------------------------------------------------------------

local profileView = new("Frame", {
	Name = "ProfileView",
	Size = UDim2.fromScale(1, 1),
	BackgroundColor3 = T.Bg,
	BorderSizePixel = 0,
	ZIndex = 5,
	Visible = false,
	Parent = ui.Pages,
})
local profileScroll = new("ScrollingFrame", {
	Size = UDim2.fromScale(1, 1),
	BackgroundTransparency = 1,
	BorderSizePixel = 0,
	ScrollBarThickness = 4,
	ScrollBarImageColor3 = rgb(40, 40, 40),
	CanvasSize = UDim2.new(),
	AutomaticCanvasSize = Enum.AutomaticSize.Y,
	Parent = profileView,
}, {
	new("UIListLayout", { Padding = UDim.new(0, 10), SortOrder = Enum.SortOrder.LayoutOrder }),
	new("UIPadding", { PaddingTop = UDim.new(0, 18), PaddingLeft = UDim.new(0, 22), PaddingRight = UDim.new(0, 22), PaddingBottom = UDim.new(0, 22) }),
})
local profileBody -- rebuilt on every open

local function hideProfile()
	if profileView.Visible then
		profileView.Visible = false
		ui.ActivePill.Visible = true
	end
end

do
	local back = button(profileScroll, "\u{2039}  Back", "Ghost", nil, { LayoutOrder = 1, Size = UDim2.fromOffset(0, 28) })
	back.MouseButton1Click:Connect(hideProfile)

	-- header: headshot, names, level and weapons chips
	local head = new("Frame", { Size = UDim2.new(1, 0, 0, 104), BackgroundColor3 = WHITE, LayoutOrder = 2, Parent = profileScroll }, { corner(14) })
	gradient(head, rgb(32, 32, 32), rgb(20, 20, 20), 0, rgb(16, 16, 16))
	stroke(T.Line2).Parent = head
	local ring = new("Frame", {
		AnchorPoint = Vector2.new(0, 0.5),
		Position = UDim2.new(0, 18, 0.5, 0),
		Size = UDim2.fromOffset(72, 72),
		BackgroundColor3 = WHITE,
		Parent = head,
	}, { corner(36) })
	fill(ring, BRAND, 135)
	local avatar = new("ImageLabel", {
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.5),
		Size = UDim2.fromOffset(66, 66),
		BackgroundColor3 = rgb(24, 24, 24),
		Parent = ring,
	}, { corner(33) })
	task.spawn(function()
		local ok, image = pcall(Players.GetUserThumbnailAsync, Players, math.max(player.UserId, 1), Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size150x150)
		if ok then
			avatar.Image = image
		end
	end)
	text(player.DisplayName, 22, T.Text, { Font = BOLD, Position = UDim2.fromOffset(106, 18), Size = UDim2.new(1, -120, 0, 26), TextTruncate = Enum.TextTruncate.AtEnd, Parent = head })
	text("@" .. player.Name, 13, T.Muted, { Position = UDim2.fromOffset(106, 44), Size = UDim2.new(1, -120, 0, 16), Parent = head })
	local chips = new("Frame", { Position = UDim2.fromOffset(106, 66), Size = UDim2.new(1, -120, 0, 22), BackgroundTransparency = 1, Parent = head }, {
		new("UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0, 6), SortOrder = Enum.SortOrder.LayoutOrder }),
	})
	local levelChip = chip(chips, { Size = UDim2.fromOffset(0, 22), TextSize = 11, TextColor3 = WHITE, BackgroundColor3 = PALETTE.Blue.Mid, LayoutOrder = 1 })
	local weaponsChip = chip(chips, { Size = UDim2.fromOffset(0, 22), TextSize = 11, TextColor3 = WHITE, BackgroundColor3 = PALETTE.Purple.Mid, LayoutOrder = 2 })

	text("Statistics are earned in duels and can't be edited.", 12, T.Dim, { Size = UDim2.new(1, 0, 0, 16), LayoutOrder = 3, Parent = profileScroll })

	local function showProfile()
		profileView.Visible = true
		ui.ActivePill.Visible = false
		profileScroll.CanvasPosition = Vector2.zero
		levelChip.Text = "LEVEL " .. (state and commas(state.Level) or "-")
		weaponsChip.Text = (state and count(state.Weapons) or 0) .. " WEAPONS"
		if profileBody then
			profileBody:Destroy()
		end
		profileBody = new("Frame", { Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, BackgroundTransparency = 1, LayoutOrder = 4, Parent = profileScroll }, {
			new("UIListLayout", { Padding = UDim.new(0, 8), SortOrder = Enum.SortOrder.LayoutOrder }),
		})
		local body = profileBody
		local loading = text("Loading your stats\u{2026}", 13, T.Muted, { Size = UDim2.new(1, 0, 0, 40), Parent = body })
		task.spawn(function()
			local ok, result = pcall(Remote.InvokeServer, Remote, "Profile")
			if body ~= profileBody then
				return
			end
			if not ok or type(result) ~= "table" or type(result.Profile) ~= "table" then
				loading.Text = "Couldn't load your stats"
				return
			end
			loading:Destroy()
			local profile = result.Profile
			levelChip.Text = "LEVEL " .. commas(profile.Level or 1)
			weaponsChip.Text = (profile.Weapons or 0) .. " WEAPONS"
			for gi, group in profile.Groups or {} do
				local colorName = PALETTE[group.Color] and group.Color or "Green"
				sectionRow(body, string.upper(group.Title), colorName, gi * 2 - 1)
				local g = new("Frame", { Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, BackgroundTransparency = 1, LayoutOrder = gi * 2, Parent = body }, {
					new("UIGridLayout", { CellSize = UDim2.fromOffset(150, 78), CellPadding = UDim2.fromOffset(10, 10), SortOrder = Enum.SortOrder.LayoutOrder }),
				})
				for si, entry in group.Stats or {} do
					local cell = new("Frame", { BackgroundColor3 = WHITE, LayoutOrder = si, Parent = g }, { corner(12) })
					gradient(cell, tint(colorName, 0.22), tint(colorName, 0.05), 135)
					stroke(PALETTE[colorName].Mid, 0.7).Parent = cell
					icon(cell, { Emoji = entry[3], Size = UDim2.fromOffset(18, 18), Position = UDim2.fromOffset(12, 10) })
					text(tostring(entry[1]), 11, T.Muted, { Font = MED, Position = UDim2.fromOffset(36, 10), Size = UDim2.new(1, -44, 0, 18), TextTruncate = Enum.TextTruncate.AtEnd, Parent = cell })
					text(tostring(entry[2]), 24, T.Text, { Font = BOLD, Position = UDim2.fromOffset(12, 36), Size = UDim2.new(1, -24, 0, 30), TextTruncate = Enum.TextTruncate.AtEnd, Parent = cell })
				end
			end
		end)
	end

	-- the profile footer in the sidebar opens it
	local foot = new("TextButton", {
		Text = "",
		AutoButtonColor = false,
		AnchorPoint = Vector2.new(0, 1),
		Position = UDim2.fromScale(0, 1),
		Size = UDim2.new(1, 0, 0, 46),
		BackgroundColor3 = WHITE,
		Parent = ui.SideFrame,
	}, { corner(11) })
	gradient(foot, rgb(30, 30, 30), rgb(17, 17, 17), 0)
	local footStroke = stroke(T.Line2)
	footStroke.Parent = foot
	local smallRing = new("Frame", { Position = UDim2.fromOffset(7, 7), Size = UDim2.fromOffset(32, 32), BackgroundColor3 = WHITE, Parent = foot }, { corner(16) })
	fill(smallRing, BRAND, 135)
	local smallAvatar = new("ImageLabel", {
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.5),
		Size = UDim2.fromOffset(28, 28),
		BackgroundColor3 = rgb(24, 24, 24),
		Parent = smallRing,
	}, { corner(14) })
	text(player.DisplayName, 13, T.Text, { Font = BOLD, Position = UDim2.fromOffset(47, 7), Size = UDim2.new(1, -70, 0, 16), TextTruncate = Enum.TextTruncate.AtEnd, Parent = foot })
	local hint = text("View stats", 11, T.Muted, { Position = UDim2.fromOffset(47, 23), Size = UDim2.new(1, -70, 0, 14), TextTruncate = Enum.TextTruncate.AtEnd, Parent = foot })
	local arrow = text("\u{203A}", 18, T.Dim, { AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -10, 0.5, -1), Size = UDim2.fromOffset(10, 20), Parent = foot })
	task.spawn(function()
		local ok, image = pcall(Players.GetUserThumbnailAsync, Players, math.max(player.UserId, 1), Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size48x48)
		if ok then
			smallAvatar.Image = image
		end
	end)
	foot.MouseEnter:Connect(function()
		tw(footStroke, FAST, { Color = T.Muted })
		tw(arrow, SPRING, { Position = UDim2.new(1, -6, 0.5, -1), TextColor3 = T.Text })
		tw(hint, FAST, { TextColor3 = T.Text })
	end)
	foot.MouseLeave:Connect(function()
		tw(footStroke, FAST, { Color = T.Line2 })
		tw(arrow, SPRING, { Position = UDim2.new(1, -10, 0.5, -1), TextColor3 = T.Dim })
		tw(hint, FAST, { TextColor3 = T.Muted })
	end)
	foot.MouseButton1Click:Connect(showProfile)

	-- keep the tab list clear of the footer
	if ui.Nav then
		ui.Nav.Size = UDim2.new(1, 0, 1, -ui.Nav.Position.Y.Offset - 54)
	end
end

-- pages ----------------------------------------------------------------------------------------

local tabIcons = {} -- tab -> icon holder

local function styleTab(tab, colorName: string, iconSpec)
	tab.Tint = colorName
	tab.Eyebrow.Text = string.upper(tab.Name)
	tab.Eyebrow.TextColor3 = PALETTE[colorName].Hi
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
	tab.Btn.MouseButton1Click:Connect(hideProfile)
end

local function paintTabs()
	for tab, holder in tabIcons do
		local active = ui.Current == tab
		for _, d in holder:GetDescendants() do
			if d:IsA("ImageLabel") then
				tw(d, FAST, { ImageTransparency = active and 0 or 0.45 })
			end
		end
		if active then
			tw(pillEdge, FAST, { BackgroundColor3 = PALETTE[tab.Tint].Mid })
			tw(wash, FAST, { BackgroundColor3 = PALETTE[tab.Tint].Mid })
		end
	end
end

do
	local select = ui.Select
	ui.Select = function(self, tab, instant)
		select(self, tab, instant)
		task.defer(paintTabs)
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

	styleTab(passes, "Blue", { Image = "rbxassetid://17619445340" })
	styleTab(weapons, "Purple", { Image = arImage, Zoom = WEAPON_ZOOM })
	styleTab(cosmetics, "Pink", { Image = catalog.CosmeticImages.Skin })
	styleTab(crates, "Orange", { Image = firstCrate and firstCrate.Image or "" })
	styleTab(progression, "Green", { Image = catalog.PassImages[1] or "" })
	styleTab(currency, "Teal", { Image = keyInfo and keyInfo.Image or "" })
	paintTabs()

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
		gradient(t, tint("Blue", 0.18), rgb(15, 15, 15), 90)
		local st = stroke(T.Line)
		st.Parent = t
		tileFeel(t, st, "Blue", function()
			if owned then
				return PALETTE.Green.Mid, 0.5
			end
			return T.Line, 0
		end)
		new("Frame", {
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.new(0.5, 0, 0, 58),
			Size = UDim2.fromOffset(92, 92),
			BackgroundColor3 = PALETTE.Blue.Mid,
			BackgroundTransparency = 0.88,
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
			chip(t, {
				Text = pass.Bubble,
				TextColor3 = PALETTE.Blue.Hi,
				BackgroundColor3 = tint("Blue", 0.3),
				AnchorPoint = Vector2.new(1, 0),
				Position = UDim2.new(1, -8, 0, 8),
			})
		end
		text(pass.DisplayName, 13, T.Text, {
			Font = BOLD,
			Position = UDim2.fromOffset(12, 108),
			Size = UDim2.new(1, -24, 0, 18),
			TextTruncate = Enum.TextTruncate.AtEnd,
			Parent = t,
		})
		local price = text("", 12, T.Body, {
			Font = BOLD,
			Position = UDim2.fromOffset(12, 126),
			Size = UDim2.new(1, -24, 0, 16),
			RichText = true,
			Parent = t,
		})
		local give = button(t, "Give", GIVE, key, {
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
			st.Color, st.Transparency = owned and PALETTE.Green.Mid or T.Line, owned and 0.5 or 0
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
	describe(weapons, "Unlock weapons and max their levels. Tap a locked weapon to unlock it, an owned one to max it.")
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
		Icon = { Emoji = "\u{2B06}\u{FE0F}" },
		Color = MAX,
		Fill = MAX,
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
			header.Text = string.format('%s   <font color="%s">%d</font><font color="#5C5C5C">/%d</font>', string.upper(class), hex(PALETTE.Green.Hi), owned, #list)
		end)
		local g = grid(weapons, UDim2.fromOffset(120, 128), classNames)
		for i, w in list do
			local key = "Weapon:" .. w.Name
			local statusTint = STATUS_TINT[w.Status] or STATUS_TINT.Standard
			local t = new("TextButton", { Text = "", AutoButtonColor = false, BackgroundColor3 = WHITE, LayoutOrder = i, Parent = g }, { corner(12) })
			gradient(t, statusTint[1], statusTint[2], 90)
			local st = stroke(T.Line)
			st.Parent = t
			local level = nil
			local function rest()
				if level and level >= maxLevel then
					return PALETTE.Purple.Mid, 0.3
				elseif level then
					return PALETTE.Green.Mid, 0.6
				end
				return T.Line, 0
			end
			-- the border shows what a tap does: green unlocks, purple maxes
			local scale = new("UIScale", { Parent = t })
			t.MouseEnter:Connect(function()
				tw(st, FAST, { Color = level and PALETTE.Purple.Mid or PALETTE.Green.Mid, Transparency = 0 })
				tw(scale, SPRING, { Scale = 1.04 })
			end)
			t.MouseLeave:Connect(function()
				local color, transparency = rest()
				tw(st, FAST, { Color = color, Transparency = transparency })
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
			local function paint(left)
				local maxed = level and level >= maxLevel
				if left > 0 then
					badge.Text = "\u{23F3} " .. left .. "s"
					badge.TextColor3, badge.BackgroundColor3 = T.Muted, rgb(34, 34, 34)
				elseif not level then
					badge.Text = "\u{1F512} LOCKED"
					badge.TextColor3, badge.BackgroundColor3 = T.Dim, rgb(26, 26, 26)
				elseif maxed then
					badge.Text = "MAX \u{2022} LV " .. level
					badge.TextColor3, badge.BackgroundColor3 = WHITE, PALETTE.Purple.Mid
				else
					badge.Text = "LV " .. level
					badge.TextColor3, badge.BackgroundColor3 = PALETTE.Green.Hi, tint("Green", 0.25)
				end
				img.ImageTransparency = level and 0 or 0.35
				img.ImageColor3 = level and WHITE or rgb(110, 110, 110)
				st.Color, st.Transparency = rest()
			end
			watch(key, paint)
			table.insert(updaters, function(s)
				level = s.Weapons[w.Name]
			end)
			t.MouseButton1Click:Connect(function()
				if level and level >= maxLevel then
					notify(w.Name .. " is already maxed", false)
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
			IconColor = "Pink",
			Color = GIVE,
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
	local amountChanged = {} -- fn()
	local function setAmount(n: number)
		amount = math.clamp(math.floor(n), 1, MAX_AMOUNT)
		for _, fn in amountChanged do
			fn()
		end
	end
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
		local c = card(crates, 64, "Amount")
		text("Amount", 14, T.Text, { Font = BOLD, Position = UDim2.fromOffset(18, 12), Size = UDim2.new(0, 160, 0, 18), Parent = c })
		local amountSub = text("", 12, T.Muted, { Position = UDim2.fromOffset(18, 31), Size = UDim2.new(0, 200, 0, 16), RichText = true, Parent = c })
		local row = new("Frame", {
			AnchorPoint = Vector2.new(1, 0.5),
			Position = UDim2.new(1, -14, 0.5, 0),
			Size = UDim2.fromOffset(0, 36),
			AutomaticSize = Enum.AutomaticSize.X,
			BackgroundTransparency = 1,
			Parent = c,
		}, {
			new("UIListLayout", {
				FillDirection = Enum.FillDirection.Horizontal,
				VerticalAlignment = Enum.VerticalAlignment.Center,
				HorizontalAlignment = Enum.HorizontalAlignment.Right,
				Padding = UDim.new(0, 8),
				SortOrder = Enum.SortOrder.LayoutOrder,
			}),
		})
		local custom = numberBox(row, "Custom", { Size = UDim2.fromOffset(92, 34), LayoutOrder = 1 })
		-- typing a number uses it straight away (no Enter needed)
		custom:GetPropertyChangedSignal("Text"):Connect(function()
			local value = tonumber(custom.Text)
			if value and value >= 1 and value ~= amount then
				setAmount(value)
			end
		end)
		local seg = new("Frame", {
			Size = UDim2.fromOffset(0, 36),
			AutomaticSize = Enum.AutomaticSize.X,
			BackgroundColor3 = rgb(12, 12, 12),
			LayoutOrder = 2,
			Parent = row,
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
				p.Fill.Enabled = on
				p.Button.BackgroundTransparency = on and 0 or 1
				tw(p.Button, FAST, { TextColor3 = on and PALETTE.Green.Text or T.Muted })
			end
			amountSub.Text = string.format('Give or remove <font color="%s"><b>x%s</b></font> at a time', hex(PALETTE.Green.Hi), commas(amount))
			if not table.find(AMOUNTS, amount) then
				custom.Text = tostring(amount)
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
				Size = UDim2.fromOffset(46, 28),
				LayoutOrder = i,
				Parent = seg,
			}, { corner(7) })
			pills[value] = { Button = pill, Fill = fill(pill, GIVE) }
			pill.MouseButton1Click:Connect(function()
				custom.Text = ""
				setAmount(value)
			end)
		end
		table.insert(amountChanged, paint)
		paint()
	end
	actionCard(crates, {
		Title = "Give Every Crate",
		Icon = { Emoji = "\u{1F4E6}" },
		IconColor = "Orange",
		Color = GIVE,
		Sub = function()
			return string.format("All %d crates, at the amount above", crateTotal)
		end,
		Button = "Give All",
		Key = "GiveAllCrates",
		OnClick = function()
			run("GiveAllCrates", "GiveAllCrates", amount)
		end,
	})
	actionCard(crates, {
		Title = "Clear Backpack",
		Icon = { Emoji = "\u{1F5D1}\u{FE0F}" },
		IconColor = "Red",
		Color = REMOVE,
		Sub = function(s)
			local n = backpackTotal(s)
			return n > 0 and string.format("Removes everything in your backpack (%s crates)", commas(n)) or "Your backpack is empty"
		end,
		Disabled = function(s)
			return backpackTotal(s) == 0
		end,
		Button = "Clear",
		Key = "ClearBackpack",
		OnClick = function()
			if state and backpackTotal(state) > 0 then
				run("ClearBackpack", "ClearBackpack")
			end
		end,
	})
	local crateNames = "crates " .. names(catalog.Crates, "DisplayName")
	section(crates, "CRATES", crateNames)
	local crateGrid = grid(crates, UDim2.fromOffset(120, 176), crateNames)
	for i, crate in catalog.Crates do
		local key = "Crate:" .. crate.Name
		local removeKey = "RemoveCrate:" .. crate.Name
		local have = 0
		local t = new("Frame", { BackgroundColor3 = WHITE, LayoutOrder = i, Parent = crateGrid }, { corner(12) })
		gradient(t, tint("Orange", 0.12), rgb(15, 15, 15), 90)
		local st = stroke(T.Line)
		st.Parent = t
		tileFeel(t, st, "Orange", function()
			return T.Line, 0
		end)
		new("Frame", {
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.new(0.5, 0, 0, 46),
			Size = UDim2.fromOffset(74, 74),
			BackgroundColor3 = PALETTE.Orange.Mid,
			BackgroundTransparency = 0.9,
			Parent = t,
		}, { corner(37) })
		icon(t, {
			Image = crate.Image,
			Size = UDim2.fromOffset(72, 72),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.new(0.5, 0, 0, 46),
		})
		local countChip = chip(t, {
			AnchorPoint = Vector2.new(1, 0),
			Position = UDim2.new(1, -7, 0, 7),
			TextColor3 = PALETTE.Green.Text,
			BackgroundColor3 = PALETTE.Green.Mid,
			Visible = false,
		})
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
		-- bottom row: green Give, red remove
		local give = button(t, "Give", GIVE, key, {
			AnchorPoint = Vector2.new(0, 1),
			Position = UDim2.new(0, 10, 1, -10),
			AutomaticSize = Enum.AutomaticSize.None,
			Size = UDim2.new(1, -58, 0, 30),
		})
		local remove = button(t, "\u{2212}", REMOVE, removeKey, {
			AnchorPoint = Vector2.new(1, 1),
			Position = UDim2.new(1, -10, 1, -10),
			AutomaticSize = Enum.AutomaticSize.None,
			Size = UDim2.fromOffset(38, 30),
			TextSize = 18,
		})
		remove:SetAttribute("Compact", true)
		give.MouseButton1Click:Connect(function()
			run("GiveCrate", key, crate.Name, amount)
		end)
		remove.MouseButton1Click:Connect(function()
			if have > 0 then
				run("RemoveCrate", removeKey, crate.Name, amount)
			end
		end)
		local function labels()
			give:SetAttribute("Label", amount > 1 and ("Give x" .. commas(amount)) or "Give")
		end
		table.insert(amountChanged, labels)
		labels()
		table.insert(updaters, function(s)
			have = s.Crates[crate.Name] or 0
			countChip.Visible = have > 0
			countChip.Text = "x" .. commas(have)
			haveText.Text = have > 0 and string.format("%s in backpack", commas(have)) or "None in backpack"
			haveText.TextColor3 = have > 0 and T.Muted or T.Dim
			remove:SetAttribute("Disabled", have == 0)
		end)
	end

	-- Progression ---------------------------------------------------------------------------
	local maxPass = catalog.MaxPassLevel or 100
	describe(progression, "Your account level, the season pass and Prime. Click your profile (bottom left) to see your statistics.")
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

-- header: Unlock Everything (green, it unlocks) -------------------------------------------------

if titleBar then
	local everything = button(titleBar, "Unlock Everything", GIVE, "UnlockEverything", {
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
		notify("Admin panel is still loading", false)
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
