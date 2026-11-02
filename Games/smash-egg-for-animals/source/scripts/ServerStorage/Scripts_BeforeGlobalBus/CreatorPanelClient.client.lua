-- CONTENT CREATOR PANEL (button "CREATOR", just under the ADMIN button ; F3 also opens it).
-- Only for players recognized as content creators by ServerScriptService.TagConfig_Old (the server sets IsContentCreator and
-- re-checks EVERY request : this panel is only a remote control, it holds no power by itself).
-- Tabs : TROLL MENU (6 commands with cooldowns), TELEPORT MENU, EMOTE MENU, SPECTATE MENU, PLAYER INFO.
-- Emotes and spectating only affect the creator's own character / camera. Player info is read-only.
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local CollectionService = game:GetService("CollectionService")

local player = Players.LocalPlayer
while player:GetAttribute("IsContentCreator") ~= true do player:GetAttributeChangedSignal("IsContentCreator"):Wait() end

local folder = ReplicatedStorage:WaitForChild("CreatorPanel")
local Config = require(folder:WaitForChild("CreatorConfig"))
local request = folder:WaitForChild("Request")

---------------------------------------------------------------- style
local rgb = Color3.fromRGB
local WHITE, BLACK = Color3.new(1, 1, 1), Color3.new(0, 0, 0)
local FONT = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Bold)
local BOLD = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Bold)
local BG = {rgb(34, 24, 72), rgb(14, 12, 32)}
local CARD = {rgb(52, 40, 104), rgb(28, 22, 62)}
local VIOLET, CYAN, PINK, BLUE = rgb(160, 100, 255), rgb(90, 225, 255), rgb(255, 120, 230), rgb(80, 120, 255)
local ACCENT = {VIOLET, BLUE, CYAN}
local GREEN = {rgb(120, 240, 150), rgb(30, 170, 110)}
local RED = {rgb(255, 110, 120), rgb(200, 30, 60)}
local GALAXY = ColorSequence.new({ColorSequenceKeypoint.new(0, VIOLET), ColorSequenceKeypoint.new(0.35, CYAN), ColorSequenceKeypoint.new(0.5, WHITE),
	ColorSequenceKeypoint.new(0.65, PINK), ColorSequenceKeypoint.new(1, VIOLET)})

local function new(class, props, parent)
	local o = Instance.new(class)
	for k, v in props do o[k] = v end
	o.Parent = parent
	return o
end
local function tween(o, t, props, style, dir)
	local tw = TweenService:Create(o, TweenInfo.new(t, style or Enum.EasingStyle.Quad, dir or Enum.EasingDirection.Out), props)
	tw:Play()
	return tw
end
local function corner(o, r) return new("UICorner", {CornerRadius = UDim.new(0, r or 12)}, o) end
local function stroke(o, t) return new("UIStroke", {Thickness = t or 2, Color = BLACK, ApplyStrokeMode = Enum.ApplyStrokeMode.Border}, o) end
local function gradient(o, colors, rotation)
	local points = {}
	for i, c in colors do points[i] = ColorSequenceKeypoint.new((i - 1) / math.max(#colors - 1, 1), c) end
	if #colors == 1 then points[2] = ColorSequenceKeypoint.new(1, colors[1]) end
	o.BackgroundColor3 = WHITE
	return new("UIGradient", {Color = ColorSequence.new(points), Rotation = rotation or 90}, o)
end
local function text(parent, str, props)
	local l = new("TextLabel", {BackgroundTransparency = 1, Text = str, FontFace = FONT, TextScaled = true, TextColor3 = WHITE, ZIndex = (parent.ZIndex or 1) + 1}, parent)
	for k, v in props or {} do if k ~= "StrokeT" then l[k] = v end end
	new("UIStroke", {Thickness = props and props.StrokeT or 2, Color = BLACK}, l)
	return l
end
local function small(parent, str, props) -- small light text, no outline
	local l = new("TextLabel", {BackgroundTransparency = 1, Text = str, FontFace = BOLD, TextSize = 12, TextWrapped = true, TextColor3 = rgb(215, 210, 245),
		TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top, ZIndex = (parent.ZIndex or 1) + 1}, parent)
	for k, v in props or {} do l[k] = v end
	return l
end

-- animated pieces : only updated while the panel is open (one loop)
local gleams, spinners, shimmers = {}, {}, {}
local GLEAM_BAND = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.42, 1), NumberSequenceKeypoint.new(0.5, 0.5),
	NumberSequenceKeypoint.new(0.58, 1), NumberSequenceKeypoint.new(1, 1)})
local function gleam(o, period)
	local layer = new("Frame", {Name = "PanelGleam", BackgroundColor3 = WHITE, BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), ZIndex = o.ZIndex + 3, Active = false}, o)
	local c = o:FindFirstChildOfClass("UICorner")
	if c then corner(layer, c.CornerRadius.Offset) end
	table.insert(gleams, {Gradient = new("UIGradient", {Rotation = 20, Transparency = GLEAM_BAND, Offset = Vector2.new(-1.2, 0)}, layer), Phase = math.random() * 3, Period = period or 3.2})
end
local function hover(button)
	local s = new("UIScale", {Name = "PanelHover"}, button)
	button.MouseEnter:Connect(function() tween(s, 0.12, {Scale = 1.04}) end)
	button.MouseLeave:Connect(function() tween(s, 0.12, {Scale = 1}) end)
	button.MouseButton1Down:Connect(function() tween(s, 0.06, {Scale = 0.94}) end)
	button.MouseButton1Up:Connect(function() tween(s, 0.18, {Scale = 1.04}, Enum.EasingStyle.Back) end)
	return s
end
local function button(parent, str, colors, props, onClick)
	local b = new("TextButton", {Text = "", AutoButtonColor = false, BorderSizePixel = 0, ZIndex = (parent.ZIndex or 1) + 1}, parent)
	for k, v in props or {} do b[k] = v end
	gradient(b, colors)
	corner(b, 10)
	stroke(b, 2)
	local l = text(b, str, {Name = "Label", Position = UDim2.fromScale(0.06, 0.18), Size = UDim2.fromScale(0.88, 0.64), ZIndex = b.ZIndex + 2})
	hover(b)
	gleam(b)
	if onClick then b.Activated:Connect(onClick) end
	return b, l
end
local function card(parent, props, colors)
	local f = new("Frame", {BorderSizePixel = 0, ZIndex = (parent.ZIndex or 1) + 1}, parent)
	for k, v in props or {} do f[k] = v end
	gradient(f, colors or CARD)
	corner(f, 14)
	stroke(f, 2)
	return f
end

---------------------------------------------------------------- window
local gui = new("ScreenGui", {Name = "CreatorPanelGui", ResetOnSpawn = false, DisplayOrder = 49, ZIndexBehavior = Enum.ZIndexBehavior.Sibling}, player:WaitForChild("PlayerGui"))

-- entry button : just under the ADMIN button (same size, same left edge)
local openButton = new("TextButton", {Name = "Open", Text = "", AutoButtonColor = false, BorderSizePixel = 0, Position = UDim2.fromOffset(12, 54), Size = UDim2.fromOffset(104, 40), ZIndex = 2}, gui)
local openGradient = gradient(openButton, {VIOLET, BLUE, CYAN}, 0)
corner(openButton, 10)
stroke(openButton, 2)
text(openButton, "CREATOR", {Position = UDim2.fromScale(0.08, 0.16), Size = UDim2.fromScale(0.84, 0.68), ZIndex = 4})
hover(openButton)
table.insert(shimmers, {Gradient = openGradient, Always = true})

local main = new("Frame", {Name = "Main", Visible = false, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(880, 560),
	BorderSizePixel = 0, ZIndex = 2}, gui)
local bgGradient = gradient(main, BG, 120)
corner(main, 20)
local mainStroke = new("UIStroke", {Thickness = 3, Color = WHITE, ApplyStrokeMode = Enum.ApplyStrokeMode.Border}, main)
table.insert(spinners, new("UIGradient", {Color = GALAXY}, mainStroke))
-- soft glow and shadow behind the window
new("ImageLabel", {Name = "Glow", BackgroundTransparency = 1, Image = "rbxassetid://4509687978", ImageColor3 = VIOLET, ImageTransparency = 0.55,
	AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.new(1, 160, 1, 160), ZIndex = 1}, main)
local function solid() main.BackgroundTransparency = 0 end
solid()
main:GetPropertyChangedSignal("BackgroundTransparency"):Connect(function() if main.BackgroundTransparency ~= 0 then solid() end end)
local fit = new("UIScale", {}, main)
local baseScale = 1
local function refit()
	local view = workspace.CurrentCamera.ViewportSize
	if view.X > 200 and view.Y > 200 then baseScale = math.min(1, view.X / 920, view.Y / 610) end
	if main.Visible then fit.Scale = baseScale end
end
workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(refit)
refit()

local header = new("Frame", {Name = "Header", BorderSizePixel = 0, Position = UDim2.fromOffset(12, 12), Size = UDim2.new(1, -24, 0, 60), ZIndex = 3, ClipsDescendants = true}, main)
local headerGradient = gradient(header, {rgb(90, 50, 200), rgb(40, 90, 220), rgb(90, 50, 200)}, 0)
corner(header, 14)
stroke(header, 2)
table.insert(shimmers, {Gradient = headerGradient})
gleam(header, 4)
local title = text(header, "CONTENT CREATOR PANEL", {Position = UDim2.fromOffset(18, 8), Size = UDim2.new(0, 470, 0, 30), TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 6, StrokeT = 3})
table.insert(shimmers, {Gradient = new("UIGradient", {Color = GALAXY}, title), Text = true})
small(header, "Fun creator tools · every action is checked by the server · not an admin panel", {Position = UDim2.fromOffset(19, 38), Size = UDim2.new(0, 520, 0, 16), ZIndex = 6, TextColor3 = rgb(220, 230, 255)})
local closeButton = button(header, "X", RED, {AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -8, 0.5, 0), Size = UDim2.fromOffset(44, 44), ZIndex = 6})

local tabColumn = new("Frame", {BackgroundTransparency = 1, Position = UDim2.fromOffset(12, 84), Size = UDim2.new(0, 170, 1, -96), ZIndex = 3}, main)
new("UIListLayout", {Padding = UDim.new(0, 8), SortOrder = Enum.SortOrder.LayoutOrder}, tabColumn)
local content = new("Frame", {Name = "Content", BorderSizePixel = 0, Position = UDim2.fromOffset(194, 84), Size = UDim2.new(1, -206, 1, -96), ZIndex = 3, ClipsDescendants = true}, main)
gradient(content, {rgb(24, 20, 52), rgb(16, 14, 36)})
content:GetPropertyChangedSignal("BackgroundTransparency"):Connect(function() if content.BackgroundTransparency ~= 0 then content.BackgroundTransparency = 0 end end)
corner(content, 16)
stroke(content, 2)

---------------------------------------------------------------- notifications inside the panel
local toastHolder = new("Frame", {BackgroundTransparency = 1, AnchorPoint = Vector2.new(0.5, 1), Position = UDim2.new(0.5, 0, 1, -10), Size = UDim2.fromOffset(460, 50), ZIndex = 40}, main)
local toastId = 0
local function toast(message, ok)
	toastId += 1
	local id = toastId
	for _, c in toastHolder:GetChildren() do c:Destroy() end
	local t = card(toastHolder, {Size = UDim2.fromScale(1, 1), Position = UDim2.fromOffset(0, 30), ZIndex = 41}, ok and {rgb(110, 230, 170), rgb(30, 140, 150)} or {rgb(255, 120, 130), rgb(170, 30, 70)})
	text(t, (ok and "✔  " or "✖  ") .. message, {Position = UDim2.fromOffset(14, 10), Size = UDim2.new(1, -28, 1, -20), ZIndex = 43})
	tween(t, 0.3, {Position = UDim2.fromOffset(0, 0)}, Enum.EasingStyle.Back)
	task.delay(2.8, function()
		if toastId ~= id or not t.Parent then return end
		tween(t, 0.25, {Position = UDim2.fromOffset(0, 70)}, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
		task.wait(0.3)
		if t.Parent then t:Destroy() end
	end)
end
local function ask(action, a, b)
	local ok, result = pcall(request.InvokeServer, request, action, a, b)
	if not ok or type(result) ~= "table" then return {Ok = false, Message = "The server didn't answer. Try again."} end
	return result
end

---------------------------------------------------------------- tabs
local pages, tabs, current = {}, {}, nil
local onShow = {}
local function showPage(name)
	if current == name then return end
	current = name
	for pageName, page in pages do
		local on = pageName == name
		if on then
			page.Visible = true
			page.Position = UDim2.fromOffset(28, 10)
			tween(page, 0.25, {Position = UDim2.fromOffset(10, 10)})
		else
			page.Visible = false
		end
	end
	for tabName, tab in tabs do
		local on = tabName == name
		tab.Shade.Color = on and ColorSequence.new(VIOLET, CYAN) or ColorSequence.new(rgb(70, 56, 130), rgb(40, 32, 84))
		tween(tab, 0.15, {Size = UDim2.new(1, on and 0 or -10, 0, 52)})
	end
	if onShow[name] then onShow[name]() end
end
local function newPage(name, icon, order)
	local tab = new("TextButton", {Name = name, Text = "", AutoButtonColor = false, BorderSizePixel = 0, BackgroundColor3 = WHITE, Size = UDim2.new(1, -10, 0, 52), LayoutOrder = order, ZIndex = 4}, tabColumn)
	new("UIGradient", {Name = "Shade", Rotation = 0}, tab)
	corner(tab, 12)
	stroke(tab, 2)
	text(tab, icon, {Position = UDim2.fromOffset(8, 10), Size = UDim2.fromOffset(32, 32), ZIndex = 6})
	text(tab, name, {Position = UDim2.fromOffset(44, 15), Size = UDim2.new(1, -52, 0, 22), TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 6})
	hover(tab)
	gleam(tab, 5)
	local page = new("Frame", {Name = name, Visible = false, BackgroundTransparency = 1, Position = UDim2.fromOffset(10, 10), Size = UDim2.new(1, -20, 1, -20), ZIndex = 4}, content)
	pages[name], tabs[name] = page, tab
	tab.Activated:Connect(function() showPage(name) end)
	return page
end

---------------------------------------------------------------- player list (searchable, with selection)
local function headshot(userId) return "rbxthumb://type=AvatarHeadShot&id=" .. userId .. "&w=150&h=150" end
local function playerList(parent, position, size, onSelect)
	local box = card(parent, {Position = position, Size = size, ZIndex = 5})
	local search = new("TextBox", {Text = "", PlaceholderText = "🔍  Search players...", ClearTextOnFocus = false, BorderSizePixel = 0, Position = UDim2.fromOffset(8, 8),
		Size = UDim2.new(1, -16, 0, 32), FontFace = BOLD, TextSize = 14, TextColor3 = WHITE, PlaceholderColor3 = rgb(190, 185, 230), TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 7}, box)
	gradient(search, {rgb(20, 16, 44), rgb(30, 24, 62)})
	corner(search, 8)
	new("UIPadding", {PaddingLeft = UDim.new(0, 8)}, search)
	local scroll = new("ScrollingFrame", {BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromOffset(6, 46), Size = UDim2.new(1, -12, 1, -52), CanvasSize = UDim2.new(),
		AutomaticCanvasSize = Enum.AutomaticSize.Y, ScrollBarThickness = 5, ScrollBarImageColor3 = CYAN, ZIndex = 6}, box)
	new("UIListLayout", {Padding = UDim.new(0, 6), SortOrder = Enum.SortOrder.LayoutOrder}, scroll)
	new("UIPadding", {PaddingTop = UDim.new(0, 2), PaddingLeft = UDim.new(0, 2), PaddingRight = UDim.new(0, 6), PaddingBottom = UDim.new(0, 4)}, scroll)
	local list = {Selected = nil}
	local rows = {}
	local function paint()
		for p, row in rows do
			local on = list.Selected == p
			row.Shade.Color = on and ColorSequence.new(rgb(120, 80, 255), rgb(40, 170, 230)) or ColorSequence.new(rgb(62, 50, 120), rgb(38, 30, 80))
			row.Line.Thickness = on and 3 or 2
			row.Line.Color = on and CYAN or BLACK
		end
	end
	function list.Select(p)
		list.Selected = p
		paint()
		onSelect(p)
	end
	function list.Rebuild()
		local filter = string.lower(search.Text)
		for _, row in rows do row:Destroy() end
		table.clear(rows)
		local all = Players:GetPlayers()
		table.sort(all, function(a, b) return string.lower(a.DisplayName) < string.lower(b.DisplayName) end)
		for i, p in all do
			if filter ~= "" and not string.find(string.lower(p.DisplayName), filter, 1, true) and not string.find(string.lower(p.Name), filter, 1, true) then continue end
			local row = new("TextButton", {Name = p.Name, Text = "", AutoButtonColor = false, BorderSizePixel = 0, BackgroundColor3 = WHITE, Size = UDim2.new(1, 0, 0, 48), LayoutOrder = i, ZIndex = 7}, scroll)
			new("UIGradient", {Name = "Shade", Rotation = 0}, row)
			corner(row, 10)
			new("UIStroke", {Name = "Line", Thickness = 2, Color = BLACK, ApplyStrokeMode = Enum.ApplyStrokeMode.Border}, row)
			local face = new("ImageLabel", {BackgroundColor3 = rgb(20, 16, 44), Image = headshot(p.UserId), Position = UDim2.fromOffset(6, 6), Size = UDim2.fromOffset(36, 36), ZIndex = 8}, row)
			corner(face, 18)
			text(row, p.DisplayName .. (p == player and " (you)" or ""), {Position = UDim2.fromOffset(50, 6), Size = UDim2.new(1, -58, 0, 20), TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 9})
			small(row, "@" .. p.Name, {Position = UDim2.fromOffset(50, 28), Size = UDim2.new(1, -58, 0, 14), TextSize = 12, ZIndex = 9})
			hover(row)
			row.Activated:Connect(function() list.Select(p) end)
			rows[p] = row
		end
		if list.Selected and not list.Selected.Parent then list.Select(nil) end
		paint()
	end
	search:GetPropertyChangedSignal("Text"):Connect(list.Rebuild)
	Players.PlayerAdded:Connect(function() task.defer(list.Rebuild) end)
	Players.PlayerRemoving:Connect(function(p)
		if list.Selected == p then list.Selected = nil onSelect(nil) end
		task.defer(list.Rebuild)
	end)
	list.Rebuild()
	return list, box
end
-- "selected player" banner
local function selectedBanner(parent, position, size)
	local b = card(parent, {Position = position, Size = size, ZIndex = 5}, {rgb(70, 50, 150), rgb(30, 60, 140)})
	local face = new("ImageLabel", {BackgroundColor3 = rgb(20, 16, 44), Image = "", Position = UDim2.fromOffset(8, 6), Size = UDim2.new(0, 38, 1, -12), ZIndex = 7}, b)
	corner(face, 19)
	local name = text(b, "No player selected", {Position = UDim2.fromOffset(54, 8), Size = UDim2.new(1, -64, 0, 20), TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 8})
	local sub = small(b, "Pick someone in the list", {Position = UDim2.fromOffset(55, 30), Size = UDim2.new(1, -64, 0, 14), ZIndex = 8})
	gleam(b, 4)
	return function(p)
		face.Image = p and headshot(p.UserId) or ""
		name.Text = p and ("🎯 " .. p.DisplayName) or "No player selected"
		sub.Text = p and ("@" .. p.Name) or "Pick someone in the list"
	end
end

---------------------------------------------------------------- 1. TROLL MENU
local cooldownEnds = {}
local commandCards = {}
local trollTarget
do
	local page = newPage("TROLL MENU", "😈", 1)
	local list = playerList(page, UDim2.fromOffset(0, 0), UDim2.new(0, 220, 1, 0), function(p)
		trollTarget = p
	end)
	local setBanner = selectedBanner(page, UDim2.fromOffset(232, 0), UDim2.new(1, -232, 0, 52))
	local oldSelect = list.Select
	list.Select = function(p) oldSelect(p) setBanner(p) end
	local grid = new("Frame", {BackgroundTransparency = 1, Position = UDim2.fromOffset(232, 60), Size = UDim2.new(1, -232, 1, -60), ZIndex = 5}, page)
	new("UIGridLayout", {CellSize = UDim2.new(0.5, -5, 0, 124), CellPadding = UDim2.fromOffset(10, 8), SortOrder = Enum.SortOrder.LayoutOrder}, grid)
	for i, cmd in Config.Commands do
		local c = card(grid, {LayoutOrder = i, ZIndex = 6, ClipsDescendants = true}, {cmd.Colors[1]:Lerp(rgb(30, 24, 60), 0.35), cmd.Colors[2]:Lerp(rgb(14, 12, 30), 0.45)})
		gleam(c, 4.5)
		text(c, cmd.Icon, {Position = UDim2.fromOffset(8, 6), Size = UDim2.fromOffset(34, 34), ZIndex = 8})
		text(c, cmd.Name, {Position = UDim2.fromOffset(46, 10), Size = UDim2.new(1, -54, 0, 22), TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 8})
		small(c, cmd.Description, {Position = UDim2.fromOffset(10, 42), Size = UDim2.new(1, -20, 0, 34), TextSize = 11, ZIndex = 8})
		local use, useLabel = button(c, "USE", cmd.Colors, {Position = UDim2.new(0, 10, 1, -40), Size = UDim2.new(1, -20, 0, 32), ZIndex = 8})
		-- cooldown : a dark layer that empties from left to right + the time left
		local dim = new("Frame", {Name = "Cooldown", BackgroundColor3 = BLACK, BackgroundTransparency = 0.35, BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), Visible = false, ZIndex = 12}, use)
		corner(dim, 10)
		local timer = text(use, "", {Name = "Timer", Position = UDim2.fromScale(0.08, 0.15), Size = UDim2.fromScale(0.84, 0.7), ZIndex = 14, TextColor3 = rgb(255, 230, 150), Visible = false})
		local busy = false
		use.Activated:Connect(function()
			if busy then return end
			if (cooldownEnds[cmd.Id] or 0) > workspace:GetServerTimeNow() then toast(cmd.Name .. " is still recharging.", false) return end
			if not trollTarget then toast("Select a player first.", false) return end
			busy = true
			useLabel.Text = "..."
			local result = ask("Troll", cmd.Id, trollTarget.UserId)
			busy = false
			useLabel.Text = "USE"
			if result.CooldownEnd then cooldownEnds[cmd.Id] = result.CooldownEnd end
			toast(result.Message or (result.Ok and "Done!" or "Failed."), result.Ok)
			if result.Ok then -- little burst on the card
				local s = c:FindFirstChild("PanelPop") or new("UIScale", {Name = "PanelPop"}, c)
				s.Scale = 1.06
				tween(s, 0.35, {Scale = 1}, Enum.EasingStyle.Back)
			end
		end)
		commandCards[cmd.Id] = {Dim = dim, Timer = timer, Button = use}
	end
	onShow["TROLL MENU"] = function() list.Rebuild() end
	-- keep the banner in sync with the list selection
	task.spawn(function()
		local shown
		while true do
			if trollTarget ~= shown then shown = trollTarget setBanner(shown) end
			task.wait(0.15)
		end
	end)
end

---------------------------------------------------------------- 2. TELEPORT MENU
local zoneGrid, returnButton
local ZONE_ICONS = {Safe = "🏠", Forest = "🌲", Jungle = "🌴", Aquatic = "🌊", Ice = "❄️", Desert = "🏜️", Lava = "🌋", Demon = "😈", Dino = "🦖", Candy = "🍭",
	Angel = "👼", Halloween = "🎃", Galaxy = "🌌"}
local function zoneIcon(name)
	for word, icon in ZONE_ICONS do if string.find(name, word, 1, true) then return icon end end
	return "📍"
end
local teleportTarget
local function buildZones(zones)
	for _, c in zoneGrid:GetChildren() do if c:IsA("GuiObject") then c:Destroy() end end
	for i, z in zones or {} do
		local c1 = typeof(z.Color1) == "Color3" and z.Color1 or rgb(120, 200, 255)
		local c2 = typeof(z.Color2) == "Color3" and z.Color2 or rgb(60, 80, 200)
		local b = new("TextButton", {Text = "", AutoButtonColor = false, BorderSizePixel = 0, LayoutOrder = i, ZIndex = 7}, zoneGrid)
		gradient(b, {c1:Lerp(rgb(30, 24, 60), 0.15), c2:Lerp(rgb(14, 12, 30), 0.35)}, 30)
		corner(b, 12)
		stroke(b, 2)
		text(b, zoneIcon(z.Name), {Position = UDim2.fromOffset(8, 10), Size = UDim2.fromOffset(34, 34), ZIndex = 9})
		text(b, z.Name, {Position = UDim2.fromOffset(48, 8), Size = UDim2.new(1, -56, 0, 22), TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 9})
		small(b, z.Rarity ~= "" and z.Rarity or "Zone", {Position = UDim2.fromOffset(49, 32), Size = UDim2.new(1, -56, 0, 14), ZIndex = 9, TextColor3 = WHITE})
		hover(b)
		gleam(b, 5)
		b.Activated:Connect(function()
			local result = ask("TeleportZone", z.Name)
			toast(result.Message or "", result.Ok)
			if result.HasReturn ~= nil then returnButton.Visible = true end
		end)
	end
end
do
	local page = newPage("TELEPORT MENU", "🌀", 2)
	local list = playerList(page, UDim2.fromOffset(0, 0), UDim2.new(0, 220, 1, -54), function(p) teleportTarget = p end)
	button(page, "TELEPORT TO PLAYER", ACCENT, {Position = UDim2.new(0, 0, 1, -46), Size = UDim2.new(0, 220, 0, 46), ZIndex = 6}, function()
		if not teleportTarget then toast("Select a player first.", false) return end
		local result = ask("TeleportPlayer", teleportTarget.UserId)
		toast(result.Message or "", result.Ok)
	end)
	text(page, "🗺️ ZONES", {Position = UDim2.fromOffset(234, 0), Size = UDim2.fromOffset(200, 28), TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 6})
	local scroll = new("ScrollingFrame", {BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromOffset(232, 34), Size = UDim2.new(1, -232, 1, -90), CanvasSize = UDim2.new(),
		AutomaticCanvasSize = Enum.AutomaticSize.Y, ScrollBarThickness = 5, ScrollBarImageColor3 = CYAN, ZIndex = 6}, page)
	new("UIGridLayout", {CellSize = UDim2.new(0.5, -8, 0, 58), CellPadding = UDim2.fromOffset(8, 8), SortOrder = Enum.SortOrder.LayoutOrder}, scroll)
	new("UIPadding", {PaddingTop = UDim.new(0, 3), PaddingLeft = UDim.new(0, 3), PaddingRight = UDim.new(0, 8), PaddingBottom = UDim.new(0, 4)}, scroll)
	zoneGrid = scroll
	returnButton = button(page, "↩ RETURN TO PREVIOUS POSITION", {rgb(255, 210, 110), rgb(230, 120, 40)}, {Position = UDim2.new(0, 232, 1, -46), Size = UDim2.new(1, -232, 0, 46), ZIndex = 6}, function()
		local result = ask("Return")
		toast(result.Message or "", result.Ok)
	end)
	onShow["TELEPORT MENU"] = function()
		list.Rebuild()
		local state = ask("GetState")
		if state.Ok then buildZones(state.Zones) end
	end
end

---------------------------------------------------------------- 3. EMOTE MENU (own character only)
local BUILT_IN = {{Key = "wave", Name = "Wave", Icon = "👋"}, {Key = "point", Name = "Point", Icon = "👉"}, {Key = "cheer", Name = "Cheer", Icon = "🙌"},
	{Key = "laugh", Name = "Laugh", Icon = "😂"}, {Key = "dance", Name = "Dance 1", Icon = "💃", Loop = true}, {Key = "dance2", Name = "Dance 2", Icon = "🕺", Loop = true},
	{Key = "dance3", Name = "Dance 3", Icon = "🎶", Loop = true}}
local emoteTracks, currentEmote = {}, nil
local nowPlaying
local function stopEmote()
	for _, track in emoteTracks do pcall(function() track:Stop(0.2) end) end
	table.clear(emoteTracks)
	currentEmote = nil
	if nowPlaying then nowPlaying.Text = "Now playing: —" end
end
local function emoteList()
	local list = {}
	local character = player.Character
	local animate = character and character:FindFirstChild("Animate")
	for _, e in BUILT_IN do
		local holder = animate and animate:FindFirstChild(e.Key)
		local anim = holder and holder:FindFirstChildOfClass("Animation")
		if anim then table.insert(list, {Name = e.Name, Icon = e.Icon, Animation = anim, Loop = e.Loop}) end
	end
	local humanoid = character and character:FindFirstChildOfClass("Humanoid")
	local ok, desc = pcall(function() return humanoid and humanoid:GetAppliedDescription() end)
	if ok and desc then
		local names = {}
		for name in desc:GetEmotes() do table.insert(names, name) end
		table.sort(names)
		for _, name in names do table.insert(list, {Name = name, Icon = "✨", Equipped = true}) end
	end
	return list
end
local function playEmote(e)
	local character = player.Character
	local humanoid = character and character:FindFirstChildOfClass("Humanoid")
	local animator = humanoid and humanoid:FindFirstChildOfClass("Animator")
	if not (humanoid and animator and humanoid.Health > 0) then toast("Your character isn't ready.", false) return end
	if character:GetAttribute("CreatorRagdoll") or character:GetAttribute("CreatorFrozen") then toast("You can't emote right now.", false) return end
	stopEmote()
	if e.Animation then
		local ok, track = pcall(function() return animator:LoadAnimation(e.Animation) end)
		if not ok or not track then toast("This emote couldn't load.", false) return end
		track.Priority = Enum.AnimationPriority.Action
		track.Looped = e.Loop == true
		track:Play(0.2)
		table.insert(emoteTracks, track)
	else
		local before = {}
		for _, t in animator:GetPlayingAnimationTracks() do before[t] = true end
		local ok, played = pcall(function() return humanoid:PlayEmote(e.Name) end)
		if not ok or not played then toast("This emote couldn't play.", false) return end
		task.wait()
		for _, t in animator:GetPlayingAnimationTracks() do if not before[t] then table.insert(emoteTracks, t) end end
	end
	currentEmote = e
	if nowPlaying then nowPlaying.Text = "Now playing: " .. e.Icon .. " " .. e.Name end
	toast("Playing " .. e.Name .. "!", true)
end
do
	local page = newPage("EMOTE MENU", "💃", 3)
	local search = new("TextBox", {Text = "", PlaceholderText = "🔍  Search emotes...", ClearTextOnFocus = false, BorderSizePixel = 0, Position = UDim2.fromOffset(0, 0),
		Size = UDim2.new(1, -330, 0, 40), FontFace = BOLD, TextSize = 15, TextColor3 = WHITE, PlaceholderColor3 = rgb(190, 185, 230), TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 6}, page)
	gradient(search, {rgb(30, 24, 62), rgb(20, 16, 44)})
	corner(search, 10)
	stroke(search, 2)
	new("UIPadding", {PaddingLeft = UDim.new(0, 10)}, search)
	local selected
	button(page, "▶ PLAY EMOTE", GREEN, {Position = UDim2.new(1, -320, 0, 0), Size = UDim2.fromOffset(155, 40), ZIndex = 6}, function()
		if not selected then toast("Select an emote first.", false) return end
		playEmote(selected)
	end)
	button(page, "■ STOP EMOTE", RED, {Position = UDim2.new(1, -155, 0, 0), Size = UDim2.fromOffset(155, 40), ZIndex = 6}, function()
		if not currentEmote then toast("No emote is playing.", false) return end
		stopEmote()
		toast("Emote stopped.", true)
	end)
	local banner = card(page, {Position = UDim2.fromOffset(0, 48), Size = UDim2.new(1, 0, 0, 36), ZIndex = 5}, {rgb(70, 50, 150), rgb(30, 60, 140)})
	nowPlaying = text(banner, "Now playing: —", {Position = UDim2.fromOffset(12, 7), Size = UDim2.new(1, -24, 1, -14), TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 7})
	local scroll = new("ScrollingFrame", {BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromOffset(0, 92), Size = UDim2.new(1, 0, 1, -92), CanvasSize = UDim2.new(),
		AutomaticCanvasSize = Enum.AutomaticSize.Y, ScrollBarThickness = 5, ScrollBarImageColor3 = CYAN, ZIndex = 6}, page)
	new("UIGridLayout", {CellSize = UDim2.new(1 / 3, -8, 0, 76), CellPadding = UDim2.fromOffset(8, 8), SortOrder = Enum.SortOrder.LayoutOrder}, scroll)
	new("UIPadding", {PaddingTop = UDim.new(0, 3), PaddingLeft = UDim.new(0, 3), PaddingRight = UDim.new(0, 8), PaddingBottom = UDim.new(0, 4)}, scroll)
	local cards = {}
	local function rebuild()
		for _, c in scroll:GetChildren() do if c:IsA("GuiObject") then c:Destroy() end end
		table.clear(cards)
		local filter = string.lower(search.Text)
		for i, e in emoteList() do
			if filter ~= "" and not string.find(string.lower(e.Name), filter, 1, true) then continue end
			local b = new("TextButton", {Text = "", AutoButtonColor = false, BorderSizePixel = 0, LayoutOrder = i, ZIndex = 7}, scroll)
			local g = gradient(b, {rgb(70, 50, 150), rgb(34, 26, 80)}, 90)
			corner(b, 12)
			local line = stroke(b, 2)
			text(b, e.Icon, {Position = UDim2.fromOffset(10, 18), Size = UDim2.fromOffset(38, 38), ZIndex = 9})
			text(b, e.Name, {Position = UDim2.fromOffset(54, 16), Size = UDim2.new(1, -62, 0, 22), TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 9})
			small(b, e.Equipped and "Your emote" or (e.Loop and "Built-in · loops" or "Built-in"), {Position = UDim2.fromOffset(55, 42), Size = UDim2.new(1, -62, 0, 14), ZIndex = 9})
			hover(b)
			gleam(b, 6)
			cards[e] = {Gradient = g, Line = line}
			b.Activated:Connect(function()
				selected = e
				for other, c in cards do
					local on = other == e
					c.Gradient.Color = on and ColorSequence.new(rgb(120, 80, 255), rgb(40, 170, 230)) or ColorSequence.new(rgb(70, 50, 150), rgb(34, 26, 80))
					c.Line.Color = on and CYAN or BLACK
					c.Line.Thickness = on and 3 or 2
				end
			end)
		end
	end
	search:GetPropertyChangedSignal("Text"):Connect(rebuild)
	onShow["EMOTE MENU"] = rebuild
	player.CharacterAdded:Connect(function()
		stopEmote()
		if current == "EMOTE MENU" then task.delay(1, rebuild) end
	end)
	-- a looping dance stops when you walk
	RunService.Heartbeat:Connect(function()
		if not currentEmote then return end
		local humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
		if not humanoid or humanoid.Health <= 0 or humanoid.MoveDirection.Magnitude > 0.2 then stopEmote() end
	end)
end

---------------------------------------------------------------- 4. SPECTATE MENU (own camera only)
local camera = workspace.CurrentCamera
local spectating, spectateConnections = nil, {}
local spectateLabel, spectateFace
local function clearSpectateConnections()
	for _, c in spectateConnections do c:Disconnect() end
	table.clear(spectateConnections)
end
local function myHumanoid() return player.Character and player.Character:FindFirstChildOfClass("Humanoid") end
local function setSubject(humanoid)
	-- smooth move of the camera to the new subject, then the normal camera follows it
	local target = humanoid and humanoid.Parent and humanoid.Parent:FindFirstChild("Head")
	if target and camera.CameraType == Enum.CameraType.Custom then
		local from = camera.CFrame
		local to = CFrame.lookAt(target.Position - from.LookVector * 14 + Vector3.new(0, 4, 0), target.Position)
		camera.CameraType = Enum.CameraType.Scriptable
		local tw = tween(camera, 0.45, {CFrame = to}, Enum.EasingStyle.Sine)
		tw.Completed:Wait()
		camera.CameraType = Enum.CameraType.Custom
	end
	camera.CameraSubject = humanoid or myHumanoid()
end
local function stopSpectate(silent)
	clearSpectateConnections()
	local was = spectating
	spectating = nil
	if spectateLabel then spectateLabel.Text = "Not spectating" spectateFace.Image = "" end
	if was then
		camera.CameraType = Enum.CameraType.Custom
		camera.CameraSubject = myHumanoid()
		if not silent then toast("Back to your own camera.", true) end
	end
end
local function spectate(p)
	if not p or not p.Parent then toast("Select a player first.", false) return end
	if p == player then stopSpectate() return end
	local humanoid = p.Character and p.Character:FindFirstChildOfClass("Humanoid")
	if not humanoid then toast(p.DisplayName .. " has no character right now.", false) return end
	clearSpectateConnections()
	spectating = p
	spectateLabel.Text = "👁 Spectating " .. p.DisplayName
	spectateFace.Image = headshot(p.UserId)
	task.spawn(setSubject, humanoid)
	-- target respawns : follow the new character ; target leaves : stop
	table.insert(spectateConnections, p.CharacterAdded:Connect(function(character)
		local h = character:WaitForChild("Humanoid", 10)
		if spectating == p and h then camera.CameraSubject = h end
	end))
	table.insert(spectateConnections, p.AncestryChanged:Connect(function()
		if not p.Parent and spectating == p then stopSpectate(true) toast("The player left. Spectating stopped.", false) end
	end))
	-- my own respawn resets the camera : put it back on the target
	table.insert(spectateConnections, player.CharacterAdded:Connect(function()
		task.wait(0.3)
		local h = spectating and spectating.Character and spectating.Character:FindFirstChildOfClass("Humanoid")
		if h then camera.CameraSubject = h end
	end))
end
-- never stay attached to a destroyed character
RunService.Heartbeat:Connect(function()
	if spectating then
		local subject = camera.CameraSubject
		if not subject or not subject.Parent or not subject:IsDescendantOf(workspace) then
			local h = spectating.Character and spectating.Character:FindFirstChildOfClass("Humanoid")
			camera.CameraSubject = (h and h:IsDescendantOf(workspace)) and h or myHumanoid()
		end
	end
end)
do
	local page = newPage("SPECTATE MENU", "👁", 4)
	local spectateTarget
	local list = playerList(page, UDim2.fromOffset(0, 0), UDim2.new(0, 220, 1, 0), function(p) spectateTarget = p end)
	local panel = card(page, {Position = UDim2.fromOffset(232, 0), Size = UDim2.new(1, -232, 0, 150), ZIndex = 5}, {rgb(70, 50, 150), rgb(24, 40, 110)})
	gleam(panel, 4)
	spectateFace = new("ImageLabel", {BackgroundColor3 = rgb(20, 16, 44), Image = "", Position = UDim2.fromOffset(14, 14), Size = UDim2.fromOffset(120, 120), ZIndex = 7}, panel)
	corner(spectateFace, 60)
	new("UIStroke", {Thickness = 3, Color = CYAN}, spectateFace)
	text(panel, "CURRENT TARGET", {Position = UDim2.fromOffset(150, 22), Size = UDim2.new(1, -164, 0, 20), TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 8, TextColor3 = CYAN})
	spectateLabel = text(panel, "Not spectating", {Position = UDim2.fromOffset(150, 52), Size = UDim2.new(1, -164, 0, 30), TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 8})
	small(panel, "Spectating only moves your own camera. Walk or press STOP to come back.", {Position = UDim2.fromOffset(151, 92), Size = UDim2.new(1, -164, 0, 36), ZIndex = 8})
	button(page, "👁 SPECTATE PLAYER", ACCENT, {Position = UDim2.fromOffset(232, 162), Size = UDim2.new(1, -232, 0, 52), ZIndex = 6}, function() spectate(spectateTarget) end)
	local function step(dir)
		local all = {}
		for _, p in Players:GetPlayers() do if p ~= player then table.insert(all, p) end end
		table.sort(all, function(a, b) return string.lower(a.DisplayName) < string.lower(b.DisplayName) end)
		if #all == 0 then toast("No other player to spectate.", false) return end
		local index = table.find(all, spectating or spectateTarget) or 0
		index = ((index - 1 + dir) % #all) + 1
		list.Select(all[index])
		spectate(all[index])
	end
	button(page, "◀ PREVIOUS", {rgb(150, 120, 255), rgb(80, 50, 200)}, {Position = UDim2.fromOffset(232, 224), Size = UDim2.new(0.5, -122, 0, 46), ZIndex = 6}, function() step(-1) end)
	button(page, "NEXT ▶", {rgb(150, 120, 255), rgb(80, 50, 200)}, {Position = UDim2.new(0.5, 122, 0, 224), Size = UDim2.new(0.5, -122, 0, 46), AnchorPoint = Vector2.new(0, 0), ZIndex = 6}, function() step(1) end)
	button(page, "■ STOP SPECTATING", RED, {Position = UDim2.fromOffset(232, 280), Size = UDim2.new(1, -232, 0, 46), ZIndex = 6}, function()
		if not spectating then toast("You're not spectating anyone.", false) return end
		stopSpectate()
	end)
	onShow["SPECTATE MENU"] = function() list.Rebuild() end
end

---------------------------------------------------------------- 5. PLAYER INFO (read-only)
local function zoneOf(position)
	for _, zone in CollectionService:GetTagged("EggZoneArea") do
		if zone:IsA("BasePart") and zone:IsDescendantOf(workspace) then
			local r = zone.CFrame:PointToObjectSpace(position)
			if math.abs(r.X) <= zone.Size.X / 2 and math.abs(r.Z) <= zone.Size.Z / 2 then return zone:GetAttribute("ZoneTitle") or zone.Name end
		end
	end
	local safe = workspace:FindFirstChild("safe zone")
	if safe and safe:IsA("BasePart") then
		local r = safe.CFrame:PointToObjectSpace(position)
		if math.abs(r.X) <= safe.Size.X / 2 and math.abs(r.Z) <= safe.Size.Z / 2 then return "Safe Zone" end
	end
	return "Outside the zones"
end
do
	local page = newPage("PLAYER INFO", "📋", 5)
	local infoTarget
	local list = playerList(page, UDim2.fromOffset(0, 0), UDim2.new(0, 220, 1, 0), function(p) infoTarget = p end)
	local panel = card(page, {Position = UDim2.fromOffset(232, 0), Size = UDim2.new(1, -232, 1, 0), ZIndex = 5}, {rgb(60, 44, 130), rgb(20, 18, 50)})
	gleam(panel, 5)
	local face = new("ImageLabel", {BackgroundColor3 = rgb(20, 16, 44), Image = "", Position = UDim2.fromOffset(18, 18), Size = UDim2.fromOffset(110, 110), ZIndex = 7}, panel)
	corner(face, 55)
	new("UIStroke", {Thickness = 3, Color = CYAN}, face)
	local display = text(panel, "Select a player", {Position = UDim2.fromOffset(142, 30), Size = UDim2.new(1, -156, 0, 32), TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 8})
	table.insert(shimmers, {Gradient = new("UIGradient", {Color = GALAXY}, display), Text = true})
	local username = small(panel, "", {Position = UDim2.fromOffset(143, 70), Size = UDim2.new(1, -156, 0, 18), TextSize = 15, ZIndex = 8})
	local rows = {}
	for i, key in {"User ID", "Character", "Health", "Current zone", "Status"} do
		local row = card(panel, {Position = UDim2.new(0, 18, 0, 140 + (i - 1) * 50), Size = UDim2.new(1, -36, 0, 42), ZIndex = 7}, {rgb(46, 36, 96), rgb(30, 24, 66)})
		text(row, key, {Position = UDim2.fromOffset(12, 10), Size = UDim2.new(0.38, -12, 0, 22), TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 9, TextColor3 = CYAN})
		rows[key] = text(row, "—", {Position = UDim2.new(0.38, 0, 0, 10), Size = UDim2.new(0.62, -12, 0, 22), TextXAlignment = Enum.TextXAlignment.Right, ZIndex = 9})
	end
	local function refresh()
		local p = infoTarget
		if not p or not p.Parent then
			face.Image, display.Text, username.Text = "", "Select a player", ""
			for _, l in rows do l.Text = "—" end
			return
		end
		face.Image = headshot(p.UserId)
		display.Text = p.DisplayName
		username.Text = "@" .. p.Name
		rows["User ID"].Text = tostring(p.UserId)
		local character = p.Character
		local humanoid = character and character:FindFirstChildOfClass("Humanoid")
		local root = character and character:FindFirstChild("HumanoidRootPart")
		rows["Character"].Text = not character and "Not loaded" or (humanoid and humanoid.Health > 0 and "Alive" or "Respawning")
		rows["Health"].Text = humanoid and (math.floor(humanoid.Health) .. " / " .. math.floor(humanoid.MaxHealth)) or "—"
		rows["Current zone"].Text = root and zoneOf(root.Position) or "Unknown (too far)"
		local status = "Exploring"
		if p:GetAttribute("InBossArena") then status = "In the boss fight"
		elseif (p:GetAttribute("Carrying") or 0) > 0 then status = "Carrying an egg / pet"
		elseif p:GetAttribute("OnTreadmill") then status = "Running on the treadmill"
		elseif character and character:GetAttribute("CreatorRagdoll") then status = "Ragdolled 🫠"
		elseif character and character:GetAttribute("CreatorFrozen") then status = "Frozen 🧊" end
		rows["Status"].Text = status
	end
	onShow["PLAYER INFO"] = function() list.Rebuild() refresh() end
	task.spawn(function()
		while true do
			if main.Visible and current == "PLAYER INFO" then refresh() end
			task.wait(0.5)
		end
	end)
end

---------------------------------------------------------------- open / close
local opening = false
local function setOpen(open)
	if opening then return end
	if open == main.Visible then return end
	if open then
		refit()
		main.Visible = true
		fit.Scale = baseScale * 0.8
		tween(fit, 0.3, {Scale = baseScale}, Enum.EasingStyle.Back)
		local state = ask("GetState")
		if state.Ok then
			for id, e in state.Cooldowns or {} do cooldownEnds[id] = e end
			returnButton.Visible = true
			if zoneGrid then buildZones(state.Zones) end
		end
		local name = current
		current = nil
		showPage(name or "TROLL MENU")
	else
		opening = true
		local tw = tween(fit, 0.18, {Scale = baseScale * 0.85}, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
		tw.Completed:Wait()
		main.Visible = false
		opening = false
	end
end
openButton.Activated:Connect(function() setOpen(not main.Visible) end)
closeButton.Activated:Connect(function() setOpen(false) end)
UserInputService.InputBegan:Connect(function(input, processed)
	if not processed and input.KeyCode == Enum.KeyCode.F3 and player:GetAttribute("IsContentCreator") == true then setOpen(not main.Visible) end
end)
-- creator status removed : everything goes away
player:GetAttributeChangedSignal("IsContentCreator"):Connect(function()
	local on = player:GetAttribute("IsContentCreator") == true
	openButton.Visible = on
	if not on then main.Visible = false stopSpectate(true) stopEmote() end
end)

---------------------------------------------------------------- animation loop (cheap ; nothing runs while the panel is closed)
RunService.RenderStepped:Connect(function()
	local t = os.clock()
	for _, s in shimmers do
		if s.Always or main.Visible then s.Gradient.Offset = Vector2.new(math.sin(t * (s.Text and 1.2 or 0.6)) * (s.Text and 0.6 or 0.35), 0) end
	end
	if not main.Visible then return end
	for _, g in spinners do g.Rotation = (t * 60) % 360 end
	for _, gl in gleams do
		local k = ((t + gl.Phase) % gl.Period) / 0.9
		gl.Gradient.Offset = Vector2.new(k <= 1 and (-1.2 + k * 2.4) or 1.3, 0)
	end
	bgGradient.Rotation = 120 + math.sin(t * 0.4) * 20
	-- live cooldowns on the troll buttons
	local serverNow = workspace:GetServerTimeNow()
	for id, c in commandCards do
		local left = (cooldownEnds[id] or 0) - serverNow
		if left > 0 then
			c.Dim.Visible = true
			c.Timer.Visible = true
			c.Button.Label.Visible = false
			local secs = math.ceil(left)
			c.Timer.Text = string.format("⏳ %d:%02d", secs // 60, secs % 60)
			local cfg = Config.ById[id]
			c.Dim.Size = UDim2.fromScale(math.clamp(left / cfg.Cooldown, 0, 1), 1)
		elseif c.Dim.Visible then
			c.Dim.Visible = false
			c.Timer.Visible = false
			c.Button.Label.Visible = true
		end
	end
end)
