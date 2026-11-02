-- Admin panel, built on ReplicatedStorage.NovaUI. F5 or the "Admin" button opens it.
--
-- Everything it shows comes from ServerScriptService.Server.AdminPanelService through
-- ReplicatedStorage.AdminPanelRemote: "Catalog" once (weapons, crates, passes, stats...),
-- then a fresh State with every answer. The server owns the 25s cooldowns; the panel only
-- mirrors them (a button shows its seconds left).

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

local T = Nova.Theme
local FONT, MED, BOLD = Enum.Font.BuilderSans, Enum.Font.BuilderSansMedium, Enum.Font.BuilderSansBold
local FAST = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local EASE = TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
local SPRING = TweenInfo.new(0.45, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
local ACCENT_TEXT = Color3.fromRGB(4, 28, 20)
local ACCENT_HOVER = Color3.fromRGB(52, 211, 153)
local GHOST_HOVER = Color3.fromRGB(34, 34, 34)
local AMOUNTS = { 1, 5, 10, 25, 50 }
local TOGGLE_KEY = Enum.KeyCode.F5

-- small UI helpers, the same look as NovaUI's own controls ------------------------------------

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

local function stroke(c)
	return new("UIStroke", { Color = c or T.Line, Thickness = 1, ApplyStrokeMode = Enum.ApplyStrokeMode.Border })
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

-- window ---------------------------------------------------------------------------------------

local ui = Nova.new(playerGui, "Admin Panel")
ui.Gui.Name = "AdminPanel"

-- The camera reports a 1x1 viewport for the first frames after joining.
do
	local deadline = os.clock() + 10
	while workspace.CurrentCamera.ViewportSize.X < 100 and os.clock() < deadline do
		task.wait()
	end
	local vp = workspace.CurrentCamera.ViewportSize
	ui.Size = UDim2.fromOffset(math.clamp(vp.X - 24, 480, 880), math.clamp(vp.Y - 24, 300, 580))
	ui.Window.Size = ui.Size
end

local titleBar
for _, child in ui.Window:GetChildren() do
	if child:IsA("Frame") and child.Size == UDim2.new(1, 0, 0, 40) then
		titleBar = child
	end
end

local statusLabel
for _, child in ui.SideFrame:GetChildren() do
	if child:IsA("TextLabel") and child.Text == "nova" then
		child.Text = "Admin Panel"
	elseif child:IsA("TextLabel") and child.Text == "Online" then
		statusLabel = child
		child.Size = UDim2.fromOffset(150, 20)
		child.TextTruncate = Enum.TextTruncate.AtEnd
		child.Text = "25s cooldown on each command"
	end
end

-- profile footer
do
	local foot = new("Frame", {
		AnchorPoint = Vector2.new(0, 1),
		Position = UDim2.fromScale(0, 1),
		Size = UDim2.new(1, 0, 0, 44),
		BackgroundColor3 = T.Card,
		Parent = ui.SideFrame,
	}, { corner(10), stroke(T.Line) })
	local avatar = new("ImageLabel", {
		Position = UDim2.fromOffset(7, 7),
		Size = UDim2.fromOffset(30, 30),
		BackgroundColor3 = T.Pill,
		Parent = foot,
	}, { corner(15) })
	text(player.DisplayName, 13, T.Body, {
		Font = MED,
		Position = UDim2.fromOffset(44, 6),
		Size = UDim2.new(1, -50, 0, 16),
		TextTruncate = Enum.TextTruncate.AtEnd,
		Parent = foot,
	})
	text("@" .. player.Name, 11, T.Dim, {
		Position = UDim2.fromOffset(44, 22),
		Size = UDim2.new(1, -50, 0, 14),
		TextTruncate = Enum.TextTruncate.AtEnd,
		Parent = foot,
	})
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

-- state, cooldowns, commands -------------------------------------------------------------------

local state = nil
local noCooldowns = false
local cooldownEnds: { [string]: number } = {}
local watchers = {} -- { Key, Fn(secondsLeft), Last }
local updaters = {} -- fn(state)
local pending: { [string]: boolean } = {}

local function secondsLeft(key: string?): number
	if not key or noCooldowns then
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
	noCooldowns = s.NoCooldowns == true
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

-- style "accent" (filled) or "ghost"; key = the server cooldown it mirrors.
local function button(parent, label: string, style: string, key: string?, props)
	local accent = style == "accent"
	local base = accent and T.Accent or T.Pill
	local b = new("TextButton", {
		Text = label,
		AutoButtonColor = false,
		Font = MED,
		TextSize = 12,
		TextColor3 = accent and ACCENT_TEXT or T.Body,
		BackgroundColor3 = base,
		Size = UDim2.fromOffset(0, 28),
		AutomaticSize = Enum.AutomaticSize.X,
		Parent = parent,
	}, { corner(8), new("UIPadding", { PaddingLeft = UDim.new(0, 12), PaddingRight = UDim.new(0, 12) }) })
	if not accent then
		stroke(T.Line2).Parent = b
	end
	for k, v in props or {} do
		b[k] = v
	end
	b:SetAttribute("Label", label)
	local scale = new("UIScale", { Parent = b })
	local hovered = false
	local function paint()
		local disabled = b:GetAttribute("Disabled") == true or secondsLeft(key) > 0
		local color = hovered and not disabled and (accent and ACCENT_HOVER or GHOST_HOVER) or base
		tw(b, FAST, { BackgroundColor3 = color, BackgroundTransparency = disabled and 0.55 or 0, TextTransparency = disabled and 0.35 or 0 })
	end
	b.MouseEnter:Connect(function()
		hovered = true
		paint()
	end)
	b.MouseLeave:Connect(function()
		hovered = false
		paint()
		tw(scale, SPRING, { Scale = 1 })
	end)
	b.MouseButton1Down:Connect(function()
		tw(scale, FAST, { Scale = 0.95 })
	end)
	b.MouseButton1Up:Connect(function()
		tw(scale, SPRING, { Scale = 1 })
	end)
	b:GetAttributeChangedSignal("Label"):Connect(function()
		if secondsLeft(key) == 0 then
			b.Text = b:GetAttribute("Label")
		end
	end)
	b:GetAttributeChangedSignal("Disabled"):Connect(paint)
	if key then
		watch(key, function(left)
			b.Text = left > 0 and (left .. "s") or b:GetAttribute("Label")
			paint()
		end)
	end
	return b
end

-- A NovaUI-style card (holder + CanvasGroup "Card"), so the tab's rise animation picks it up.
local function card(tab, h: number)
	tab.Order += 1
	local holder = new("Frame", {
		Size = UDim2.new(1, 0, 0, h),
		BackgroundTransparency = 1,
		LayoutOrder = tab.Order,
		Parent = tab.Page,
	})
	local c = new("CanvasGroup", { Name = "Card", Size = UDim2.fromScale(1, 1), BackgroundColor3 = T.Card, Parent = holder }, { corner(12) })
	local st = stroke(T.Line)
	st.Parent = c
	holder.MouseEnter:Connect(function()
		tw(st, FAST, { Color = T.Line2 })
	end)
	holder.MouseLeave:Connect(function()
		tw(st, FAST, { Color = T.Line })
	end)
	table.insert(tab.Items, holder)
	return c, holder
end

local function describe(tab, s: string)
	tab.Order += 1
	text(s, 12, T.Muted, {
		Size = UDim2.new(1, 0, 0, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
		TextWrapped = true,
		LayoutOrder = tab.Order,
		Parent = tab.Page,
	})
end

local function section(tab, s: string)
	return tab:Section(s)
end

-- Title, live subtitle, optional progress bar, one button on the right.
-- o = { Title, Image?, Sub(state), Progress(state)?, Button, Label(state)?, Disabled(state)?, Key, OnClick }
local function actionCard(tab, o)
	local c = card(tab, o.Progress and 74 or 60)
	local x = 16
	if o.Image then
		new("ImageLabel", {
			Image = o.Image,
			BackgroundTransparency = 1,
			ScaleType = Enum.ScaleType.Fit,
			Position = UDim2.new(0, 14, 0.5, -18),
			Size = UDim2.fromOffset(36, 36),
			Parent = c,
		})
		x = 62
	end
	text(o.Title, 14, T.Text, { Font = MED, Position = UDim2.fromOffset(x, 12), Size = UDim2.new(1, -x - 140, 0, 18), Parent = c })
	local sub = text("", 12, T.Muted, {
		Position = UDim2.fromOffset(x, 31),
		Size = UDim2.new(1, -x - 140, 0, 16),
		TextTruncate = Enum.TextTruncate.AtEnd,
		Parent = c,
	})
	local fill
	if o.Progress then
		local track = new("Frame", {
			Position = UDim2.fromOffset(x, 55),
			Size = UDim2.new(1, -x - 140, 0, 5),
			BackgroundColor3 = T.Track,
			BorderSizePixel = 0,
			Parent = c,
		}, { corner(3) })
		fill = new("Frame", { Size = UDim2.fromScale(0, 1), BackgroundColor3 = T.Accent, BorderSizePixel = 0, Parent = track }, { corner(3) })
	end
	local b = button(c, o.Button, "accent", o.Key, {
		AnchorPoint = Vector2.new(1, 0.5),
		Position = UDim2.new(1, -16, 0.5, 0),
		AutomaticSize = Enum.AutomaticSize.None,
		Size = UDim2.fromOffset(104, 30),
	})
	b.MouseButton1Click:Connect(o.OnClick)
	table.insert(updaters, function(s)
		sub.Text = o.Sub(s)
		if fill then
			tw(fill, EASE, { Size = UDim2.fromScale(math.clamp(o.Progress(s), 0, 1), 1) })
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

-- Title, "Current: x", a number box and Set.
-- o = { Title, Image?, Current(state), Key, OnSet(value), Placeholder? }
local function valueRow(tab, o)
	local c = card(tab, 58)
	local x = 16
	if o.Image then
		new("ImageLabel", {
			Image = o.Image,
			BackgroundTransparency = 1,
			ScaleType = Enum.ScaleType.Fit,
			Position = UDim2.new(0, 14, 0.5, -15),
			Size = UDim2.fromOffset(30, 30),
			Parent = c,
		})
		x = 54
	end
	text(o.Title, 13, T.Body, { Font = MED, Position = UDim2.fromOffset(x, 10), Size = UDim2.new(1, -x - 200, 0, 18), Parent = c })
	local current = text("Current: 0", 11, T.Dim, { Position = UDim2.fromOffset(x, 29), Size = UDim2.new(1, -x - 200, 0, 16), Parent = c })
	local box = new("TextBox", {
		AnchorPoint = Vector2.new(1, 0.5),
		Position = UDim2.new(1, -84, 0.5, 0),
		Size = UDim2.fromOffset(116, 30),
		BackgroundColor3 = Color3.fromRGB(18, 18, 18),
		Text = "",
		PlaceholderText = o.Placeholder or "Amount",
		PlaceholderColor3 = T.Dim,
		TextColor3 = T.Text,
		Font = MED,
		TextSize = 12,
		ClearTextOnFocus = false,
		TextXAlignment = Enum.TextXAlignment.Left,
		Parent = c,
	}, { corner(8), new("UIPadding", { PaddingLeft = UDim.new(0, 10), PaddingRight = UDim.new(0, 10) }) })
	local boxStroke = stroke(T.Line)
	boxStroke.Parent = box
	box.Focused:Connect(function()
		tw(boxStroke, FAST, { Color = T.Accent })
	end)
	box:GetPropertyChangedSignal("Text"):Connect(function()
		local clean = string.sub(string.gsub(box.Text, "%D", ""), 1, 10)
		if clean ~= box.Text then
			box.Text = clean
		end
	end)
	local b = button(c, "Set", "accent", o.Key, {
		AnchorPoint = Vector2.new(1, 0.5),
		Position = UDim2.new(1, -16, 0.5, 0),
		AutomaticSize = Enum.AutomaticSize.None,
		Size = UDim2.fromOffset(58, 30),
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
		tw(boxStroke, FAST, { Color = T.Line })
		if enter then
			submit()
		end
	end)
	table.insert(updaters, function(s)
		current.Text = "Current: " .. o.Current(s)
	end)
end

-- A NovaUI switch driven by state (no local flip until the server answers).
local function switchRow(tab, o)
	local c = card(tab, 58)
	text(o.Title, 13, T.Body, { Font = MED, Position = UDim2.fromOffset(16, 10), Size = UDim2.new(1, -90, 0, 18), Parent = c })
	local sub = text(o.SubText or "", 11, T.Dim, { Position = UDim2.fromOffset(16, 29), Size = UDim2.new(1, -90, 0, 16), Parent = c })
	local track = new("TextButton", {
		Text = "",
		AutoButtonColor = false,
		Size = UDim2.fromOffset(34, 20),
		Position = UDim2.new(1, -50, 0.5, -10),
		BackgroundColor3 = T.Track,
		Parent = c,
	}, { corner(10) })
	local knob = new("Frame", {
		Size = UDim2.fromOffset(14, 14),
		Position = UDim2.fromOffset(3, 3),
		BackgroundColor3 = Color3.fromRGB(250, 250, 250),
		Parent = track,
	}, { corner(7) })
	local on = false
	track.MouseButton1Click:Connect(function()
		o.OnToggle(not on)
	end)
	watch(o.Key, function(left)
		sub.Text = left > 0 and string.format("On cooldown for %ds", left) or (o.SubText or "")
	end)
	table.insert(updaters, function(s)
		on = o.Get(s)
		tw(track, EASE, { BackgroundColor3 = on and T.Accent or T.Track })
		tw(knob, SPRING, { Position = UDim2.fromOffset(on and 17 or 3, 3) })
	end)
end

local function grid(tab, cell: UDim2)
	tab.Order += 1
	return new("Frame", {
		Size = UDim2.new(1, 0, 0, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		LayoutOrder = tab.Order,
		Parent = tab.Page,
	}, { new("UIGridLayout", { CellSize = cell, CellPadding = UDim2.fromOffset(8, 8), SortOrder = Enum.SortOrder.LayoutOrder }) })
end

-- A grid tile: image, name, and whatever the caller adds under it.
-- zoom: weapon icons sit small in the middle of a big transparent image; the game shows them
-- through a clipping canvas with the icon at 4x (IconCanvas.Icon, ScaleType Crop). Same here.
local function tile(parent, order: number, image: string, name: string, imageHeight: number, clickable: boolean, zoom: number?)
	local t = new(clickable and "TextButton" or "Frame", {
		BackgroundColor3 = T.Card,
		LayoutOrder = order,
		Parent = parent,
	}, { corner(10) })
	if clickable then
		t.Text = ""
		t.AutoButtonColor = false
	end
	local st = stroke(T.Line)
	st.Parent = t
	local img
	if zoom then
		local canvas = new("Frame", {
			BackgroundTransparency = 1,
			ClipsDescendants = true,
			Position = UDim2.fromOffset(10, 8),
			Size = UDim2.new(1, -20, 0, imageHeight),
			Parent = t,
		})
		img = new("ImageLabel", {
			Image = image,
			BackgroundTransparency = 1,
			ScaleType = Enum.ScaleType.Crop,
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.fromScale(0.5, 0.5),
			Size = UDim2.fromScale(zoom, zoom),
			Parent = canvas,
		})
	else
		img = new("ImageLabel", {
			Image = image,
			BackgroundTransparency = 1,
			ScaleType = Enum.ScaleType.Fit,
			Position = UDim2.fromOffset(10, 8),
			Size = UDim2.new(1, -20, 0, imageHeight),
			Parent = t,
		})
	end
	text(name, 12, T.Body, {
		Font = MED,
		Position = UDim2.fromOffset(10, imageHeight + 12),
		Size = UDim2.new(1, -20, 0, 16),
		TextTruncate = Enum.TextTruncate.AtEnd,
		Parent = t,
	})
	local scale = new("UIScale", { Parent = t })
	t.MouseEnter:Connect(function()
		tw(st, FAST, { Color = T.Line2 })
		tw(t, FAST, { BackgroundColor3 = Color3.fromRGB(20, 20, 20) })
	end)
	t.MouseLeave:Connect(function()
		tw(st, FAST, { Color = T.Line })
		tw(t, FAST, { BackgroundColor3 = T.Card })
		tw(scale, SPRING, { Scale = 1 })
	end)
	if clickable then
		t.MouseButton1Down:Connect(function()
			tw(scale, FAST, { Scale = 0.96 })
		end)
		t.MouseButton1Up:Connect(function()
			tw(scale, SPRING, { Scale = 1 })
		end)
	end
	return t, img
end

local function badge(parent, props)
	local b = new("TextLabel", {
		Text = "",
		Font = BOLD,
		TextSize = 10,
		TextColor3 = T.Muted,
		BackgroundColor3 = T.Pill,
		Size = UDim2.fromOffset(0, 18),
		AutomaticSize = Enum.AutomaticSize.X,
		Parent = parent,
	}, { corner(6), new("UIPadding", { PaddingLeft = UDim.new(0, 7), PaddingRight = UDim.new(0, 7) }) })
	for k, v in props or {} do
		b[k] = v
	end
	return b
end

-- header: Unlock Everything + No Cooldowns ------------------------------------------------------

if titleBar then
	local holder = new("Frame", {
		AnchorPoint = Vector2.new(1, 0.5),
		Position = UDim2.new(1, -54, 0.5, 0),
		Size = UDim2.fromOffset(0, 26),
		AutomaticSize = Enum.AutomaticSize.X,
		BackgroundTransparency = 1,
		Parent = titleBar,
	}, {
		new("UIListLayout", {
			FillDirection = Enum.FillDirection.Horizontal,
			HorizontalAlignment = Enum.HorizontalAlignment.Right,
			VerticalAlignment = Enum.VerticalAlignment.Center,
			Padding = UDim.new(0, 8),
			SortOrder = Enum.SortOrder.LayoutOrder,
		}),
	})
	local passButton = button(holder, "No Cooldowns \u{2022} R$39", "ghost", nil, { Size = UDim2.fromOffset(0, 26), LayoutOrder = 1 })
	passButton.MouseButton1Click:Connect(function()
		if not noCooldowns then
			run("BuyNoCooldowns", "BuyNoCooldowns")
		end
	end)
	local everything = button(holder, "Unlock Everything", "accent", "UnlockEverything", { Size = UDim2.fromOffset(0, 26), LayoutOrder = 2 })
	everything.MouseButton1Click:Connect(function()
		run("UnlockEverything", "UnlockEverything")
	end)
	table.insert(updaters, function(s)
		passButton:SetAttribute("Label", s.NoCooldowns and "No Cooldowns \u{2022} Owned" or "No Cooldowns \u{2022} R$39")
		passButton:SetAttribute("Disabled", s.NoCooldowns == true)
		if statusLabel then
			statusLabel.Text = s.NoCooldowns and "No cooldowns" or "25s cooldown on each command"
		end
	end)
end

-- pages ----------------------------------------------------------------------------------------

local function build(catalog)
	local passes = ui:Tab("Game Passes")
	local weapons = ui:Tab("Weapons")
	local cosmetics = ui:Tab("Cosmetics")
	local crates = ui:Tab("Crates")
	local progression = ui:Tab("Progression")
	local statistics = ui:Tab("Statistics")
	local currency = ui:Tab("Currency")

	-- Game Passes
	describe(passes, "Every game pass, with the bundle of weapons and items that comes with it.")
	local passTotal = #catalog.Gamepasses
	actionCard(passes, {
		Title = "Give All Game Passes",
		Sub = function(s)
			return string.format("%d of %d game passes owned", count(s.Gamepasses), passTotal)
		end,
		Progress = function(s)
			return passTotal > 0 and count(s.Gamepasses) / passTotal or 0
		end,
		Button = "Give All",
		Key = "GiveAllGamepasses",
		OnClick = function()
			run("GiveAllGamepasses", "GiveAllGamepasses")
		end,
	})
	section(passes, "GAME PASSES")
	for _, pass in catalog.Gamepasses do
		local key = "Gamepass:" .. pass.Name
		actionCard(passes, {
			Title = pass.DisplayName,
			Sub = function(s)
				return string.format("R$%s \u{2022} %s", commas(pass.Price), s.Gamepasses[pass.Name] and "Owned" or "Not owned")
			end,
			Button = "Give",
			Label = function(s)
				return s.Gamepasses[pass.Name] and "Owned" or "Give"
			end,
			Disabled = function(s)
				return s.Gamepasses[pass.Name] == true
			end,
			Key = key,
			OnClick = function()
				if state and not state.Gamepasses[pass.Name] then
					run("GiveGamepass", key, pass.Name)
				end
			end,
		})
	end

	-- Weapons
	describe(weapons, "Unlock weapons and max their levels. Tap a weapon to unlock or max it.")
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
	actionCard(weapons, {
		Title = "Unlock All Weapons",
		Sub = function(s)
			return string.format("%d of %d weapons owned", ownedCount(s), weaponTotal)
		end,
		Progress = function(s)
			return weaponTotal > 0 and ownedCount(s) / weaponTotal or 0
		end,
		Button = "Unlock All",
		Key = "UnlockAllWeapons",
		OnClick = function()
			run("UnlockAllWeapons", "UnlockAllWeapons")
		end,
	})
	actionCard(weapons, {
		Title = "Max Weapon Levels",
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
		local header = section(weapons, string.upper(class))
		table.insert(updaters, function(s)
			local owned = 0
			for _, w in list do
				if s.Weapons[w.Name] then
					owned += 1
				end
			end
			header.Text = string.format("%s   %d/%d", string.upper(class), owned, #list)
		end)
		local g = grid(weapons, UDim2.fromOffset(118, 122))
		for i, w in list do
			local key = "Weapon:" .. w.Name
			local t, img = tile(g, i, w.Image, w.Name, 66, true, 2.2)
			local b = badge(t, { Position = UDim2.new(0, 10, 1, -26) })
			local level = nil
			local function paint(left)
				if left > 0 then
					b.Text = left .. "s"
					b.TextColor3, b.BackgroundColor3 = T.Muted, T.Pill
				elseif not level then
					b.Text = "LOCKED"
					b.TextColor3, b.BackgroundColor3 = T.Dim, T.Pill
				elseif level >= maxLevel then
					b.Text = "LV " .. level
					b.TextColor3, b.BackgroundColor3 = ACCENT_TEXT, T.Accent
				else
					b.Text = "LV " .. level
					b.TextColor3, b.BackgroundColor3 = T.Body, T.Pill
				end
				img.ImageTransparency = level and 0 or 0.55
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

	-- Cosmetics
	describe(cosmetics, "Skins, wraps, charms, finishers and emotes, usable on every weapon.")
	local allTotal = 0
	for _, n in catalog.CosmeticTotals do
		allTotal += n
	end
	actionCard(cosmetics, {
		Title = "Every Cosmetic",
		Sub = function(s)
			local owned = 0
			for _, n in s.Cosmetics do
				owned += n
			end
			return string.format("%s / %s owned", commas(owned), commas(allTotal))
		end,
		Progress = function(s)
			local owned = 0
			for _, n in s.Cosmetics do
				owned += n
			end
			return allTotal > 0 and owned / allTotal or 0
		end,
		Button = "Unlock All",
		Key = "UnlockAllCosmetics",
		OnClick = function()
			run("UnlockAllCosmetics", "UnlockAllCosmetics")
		end,
	})
	for _, kind in catalog.CosmeticTypes do
		local total = catalog.CosmeticTotals[kind] or 0
		local key = "Cosmetics:" .. kind
		actionCard(cosmetics, {
			Title = kind .. "s",
			Sub = function(s)
				return string.format("%d / %d owned", s.Cosmetics[kind] or 0, total)
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

	-- Crates
	describe(crates, "Crates go to your Backpack, open them from the Backpack button in the lobby.")
	local amount = 1
	do
		local c = card(crates, 52)
		text("Amount", 13, T.Body, { Font = MED, Position = UDim2.fromOffset(16, 0), Size = UDim2.new(0, 100, 1, 0), Parent = c })
		local seg = new("Frame", {
			AnchorPoint = Vector2.new(1, 0.5),
			Position = UDim2.new(1, -12, 0.5, 0),
			Size = UDim2.fromOffset(0, 32),
			AutomaticSize = Enum.AutomaticSize.X,
			BackgroundColor3 = Color3.fromRGB(18, 18, 18),
			Parent = c,
		}, {
			corner(9),
			stroke(T.Line),
			new("UIPadding", { PaddingLeft = UDim.new(0, 3), PaddingRight = UDim.new(0, 3) }),
			new("UIListLayout", {
				FillDirection = Enum.FillDirection.Horizontal,
				VerticalAlignment = Enum.VerticalAlignment.Center,
				Padding = UDim.new(0, 2),
				SortOrder = Enum.SortOrder.LayoutOrder,
			}),
		})
		local pills = {}
		local function paint()
			for value, pill in pills do
				local on = value == amount
				tw(pill, FAST, { BackgroundTransparency = on and 0 or 1, TextColor3 = on and T.Text or T.Dim })
			end
		end
		for i, value in AMOUNTS do
			local pill = new("TextButton", {
				Text = "x" .. value,
				Font = MED,
				TextSize = 12,
				AutoButtonColor = false,
				BackgroundColor3 = T.Pill,
				BackgroundTransparency = 1,
				TextColor3 = T.Dim,
				Size = UDim2.fromOffset(44, 26),
				LayoutOrder = i,
				Parent = seg,
			}, { corner(7) })
			pills[value] = pill
			pill.MouseButton1Click:Connect(function()
				amount = value
				paint()
			end)
		end
		paint()
	end
	local crateTotal = #catalog.Crates
	actionCard(crates, {
		Title = "Give Every Crate",
		Sub = function()
			return string.format("All %d crates, at the amount above", crateTotal)
		end,
		Button = "Give All",
		Key = "GiveAllCrates",
		OnClick = function()
			run("GiveAllCrates", "GiveAllCrates", amount)
		end,
	})
	section(crates, "CRATES")
	local crateGrid = grid(crates, UDim2.fromOffset(118, 166))
	for i, crate in catalog.Crates do
		local key = "Crate:" .. crate.Name
		local t = tile(crateGrid, i, crate.Image, crate.DisplayName, 66, false)
		local have = text("None in backpack", 11, T.Dim, {
			Position = UDim2.fromOffset(10, 96),
			Size = UDim2.new(1, -20, 0, 14),
			TextTruncate = Enum.TextTruncate.AtEnd,
			Parent = t,
		})
		local give = button(t, "Give", "ghost", key, {
			AnchorPoint = Vector2.new(0.5, 1),
			Position = UDim2.new(0.5, 0, 1, -10),
			AutomaticSize = Enum.AutomaticSize.None,
			Size = UDim2.new(1, -20, 0, 28),
		})
		give.MouseButton1Click:Connect(function()
			run("GiveCrate", key, crate.Name, amount)
		end)
		table.insert(updaters, function(s)
			local n = s.Crates[crate.Name] or 0
			have.Text = n > 0 and string.format("%s in backpack", commas(n)) or "None in backpack"
			have.TextColor3 = n > 0 and T.Muted or T.Dim
		end)
	end

	-- Progression
	describe(progression, "Your account level, the season pass and Prime.")
	valueRow(progression, {
		Title = "Level",
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
		Title = "Season Pass Level",
		Key = "SetPassLevel",
		Placeholder = "0 - " .. (catalog.MaxPassLevel or 100),
		Current = function(s)
			return s.PassLevel .. " / " .. (catalog.MaxPassLevel or 100)
		end,
		OnSet = function(v)
			run("SetPassLevel", "SetPassLevel", v)
		end,
	})
	switchRow(progression, {
		Title = "Prime Season Pass",
		SubText = "The premium track of the current season",
		Key = "SetPrime",
		Get = function(s)
			return s.Prime == true
		end,
		OnToggle = function(on)
			run("SetPrime", "SetPrime", on)
		end,
	})

	-- Statistics
	describe(statistics, "What shows on your profile, above your head and on the leaderboard.")
	for _, stat in catalog.Stats do
		local key = "Stat:" .. stat.Field
		valueRow(statistics, {
			Title = stat.Name,
			Key = key,
			Current = function(s)
				return commas(s.Stats[stat.Field] or 0)
			end,
			OnSet = function(v)
				run("SetStat", key, stat.Field, v)
			end,
		})
	end

	-- Currency
	describe(currency, "Set how much of each currency you have. Keys unlock weapons in the shop.")
	for _, info in catalog.Currencies do
		local key = "Currency:" .. info.Field
		valueRow(currency, {
			Title = info.Name,
			Image = info.Image ~= "" and info.Image or nil,
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

-- open button + key ----------------------------------------------------------------------------

local opener = new("ScreenGui", {
	Name = "AdminPanelButton",
	ResetOnSpawn = false,
	DisplayOrder = 5,
	ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
	Parent = playerGui,
})
local openButton = new("TextButton", {
	Name = "Open",
	Text = "",
	AutoButtonColor = false,
	-- top-left, under Roblox's top bar and above the lobby's Beginner Tasks list
	Position = UDim2.fromOffset(12, 12),
	Size = UDim2.fromOffset(92, 34),
	BackgroundColor3 = T.Bg,
	Parent = opener,
}, { corner(10), stroke(T.Line2) })
do
	local logo = new("Frame", {
		Size = UDim2.fromOffset(18, 18),
		Position = UDim2.new(0, 10, 0.5, -9),
		BackgroundColor3 = Color3.fromRGB(22, 22, 22),
		Parent = openButton,
	}, { corner(5), stroke(T.Line2) })
	for i, h in { 5, 8, 11 } do
		new("Frame", {
			AnchorPoint = Vector2.new(0, 1),
			Size = UDim2.fromOffset(2, h),
			Position = UDim2.fromOffset(3 + (i - 1) * 4.5, 15),
			BackgroundColor3 = i == 3 and T.Text or T.Accent,
			BorderSizePixel = 0,
			Parent = logo,
		}, { corner(1) })
	end
	text("Admin", 13, T.Body, { Font = MED, Position = UDim2.fromOffset(36, 0), Size = UDim2.new(1, -40, 1, 0), Parent = openButton })
	local st = openButton:FindFirstChildOfClass("UIStroke")
	local scale = new("UIScale", { Parent = openButton })
	openButton.MouseEnter:Connect(function()
		tw(openButton, FAST, { BackgroundColor3 = Color3.fromRGB(20, 20, 20) })
		tw(st, FAST, { Color = T.Accent })
	end)
	openButton.MouseLeave:Connect(function()
		tw(openButton, FAST, { BackgroundColor3 = T.Bg })
		tw(st, FAST, { Color = T.Line2 })
		tw(scale, SPRING, { Scale = 1 })
	end)
	openButton.MouseButton1Down:Connect(function()
		tw(scale, FAST, { Scale = 0.94 })
	end)
	openButton.MouseButton1Up:Connect(function()
		tw(scale, SPRING, { Scale = 1 })
	end)
end

local built = false

local function toggle()
	if not built then
		ui:Notify("Admin panel is still loading")
		return
	end
	local opening = not ui.Visible
	ui:Toggle(opening)
	if opening then
		refresh()
	end
end

openButton.MouseButton1Click:Connect(toggle)
UserInputService.InputBegan:Connect(function(input, processed)
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
