-- Boutiques des stands HAMMERS et TRAILS : une rangée de cartes qui défile de gauche à droite.
-- Chaque carte : nom, rareté, image, bandeau de statistique, puis prix (argent + Robux) ou Equip / Unequip.
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")

local player = Players.LocalPlayer
local EggConfig = require(ReplicatedStorage:WaitForChild("EggSystem"):WaitForChild("EggConfig"))
local hammerSystem = ReplicatedStorage:WaitForChild("HammerSystem")
local HammerConfig = require(hammerSystem:WaitForChild("HammerConfig"))
local hammerModels = hammerSystem:WaitForChild("Models")
local trailSystem = ReplicatedStorage:WaitForChild("TrailSystem")
local TrailConfig = require(trailSystem:WaitForChild("TrailConfig"))
local SpeedConfig = require(ReplicatedStorage:WaitForChild("SpeedSystem"):WaitForChild("SpeedConfig"))

local rgb = Color3.fromRGB
local WHITE, BLACK = Color3.new(1, 1, 1), Color3.new(0, 0, 0)
local FONT = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy)
local STUDS = "rbxassetid://7447638591"
local GREEN, GREY, PINK, BLUE = rgb(92, 220, 60), rgb(160, 164, 172), rgb(226, 60, 236), rgb(70, 150, 240)
-- couleur des cartes et du nom de rareté
local RARITY = {
	Common = rgb(236, 236, 240), Uncommon = rgb(120, 230, 110), Rare = rgb(90, 160, 255), Epic = rgb(200, 110, 255), Legendary = rgb(255, 110, 100),
	Mythic = rgb(255, 205, 80), Secret = rgb(150, 150, 166), Ancient = rgb(150, 220, 90), OG = rgb(255, 170, 70), Divine = rgb(255, 236, 160), Prismatic = rgb(255, 130, 220),
}

local function new(class, props, parent)
	local o = Instance.new(class)
	for k, v in props do o[k] = v end
	o.Parent = parent
	return o
end
local function border(o, t) return new("UIStroke", {Thickness = t or 3, Color = BLACK, ApplyStrokeMode = Enum.ApplyStrokeMode.Border}, o) end
local function studs(o, transparency) return new("ImageLabel", {BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), Image = STUDS, ScaleType = Enum.ScaleType.Tile, TileSize = UDim2.fromOffset(30, 30), ImageTransparency = transparency or 0.8, ZIndex = o.ZIndex}, o) end
local function text(parent, props)
	local l = new("TextLabel", {BackgroundTransparency = 1, FontFace = FONT, TextColor3 = WHITE, TextScaled = true, ZIndex = parent.ZIndex + 1}, parent)
	for k, v in props do l[k] = v end
	new("UIStroke", {Thickness = 3, Color = BLACK}, l)
	return l
end
local function button(parent, color, props)
	local b = new("TextButton", {Text = "", AutoButtonColor = true, BackgroundColor3 = color, BorderSizePixel = 0, ZIndex = parent.ZIndex + 2}, parent)
	for k, v in props do b[k] = v end
	border(b, 3)
	studs(b, 0.7)
	local label = text(b, {Name = "Label", Position = UDim2.fromScale(0.06, 0.16), Size = UDim2.fromScale(0.88, 0.68), ZIndex = b.ZIndex + 1})
	return b, label
end

local gui = new("ScreenGui", {Name = "ShopCardsGui", ResetOnSpawn = false, DisplayOrder = 20, ZIndexBehavior = Enum.ZIndexBehavior.Sibling}, player:WaitForChild("PlayerGui"))

-- les icônes des traînées sont chargées dès l'arrivée du joueur : sinon les cartes restent vides quelques secondes à la première ouverture
task.spawn(function()
	local holder = new("Frame", {Name = "IconPreload", BackgroundTransparency = 1, Size = UDim2.fromOffset(1, 1), Position = UDim2.fromOffset(-10, -10)}, gui)
	local images = {}
	for _, info in TrailConfig.Trails do
		if info.Icon then table.insert(images, new("ImageLabel", {BackgroundTransparency = 1, ImageTransparency = 0.99, Size = UDim2.fromOffset(1, 1), Image = info.Icon}, holder)) end
	end
	pcall(function() game:GetService("ContentProvider"):PreloadAsync(images) end)
end)

---------------------------------------------------------------- images des cartes (ViewportFrame)
local function frameModel(view, model, tilt)
	model:PivotTo(CFrame.new())
	model.Parent = view
	local cf, size = model:GetBoundingBox()
	local camera = new("Camera", {FieldOfView = 36}, view)
	camera.CFrame = CFrame.lookAt(cf.Position + Vector3.new(0.35, 0.15, 1).Unit * math.max(size.X, size.Y, size.Z) * 1.5, cf.Position) * CFrame.Angles(0, 0, math.rad(tilt or 0))
	view.CurrentCamera = camera
end
-- petit coureur en blocs avec sa traînée derrière lui, aux couleurs de la traînée
local function runnerModel(info)
	local model = Instance.new("Model")
	local index = 0
	local function part(size, cf, trail)
		index += 1
		local p = Instance.new("Part")
		p.Anchored = true
		p.Size, p.CFrame = size, cf
		p.Material = info.Neon and Enum.Material.Neon or Enum.Material.SmoothPlastic
		local color = info.Color
		if info.Sequence then
			local keys = info.Sequence.Keypoints
			color = keys[(index - 1) % #keys + 1].Value
		end
		if info.Stripes and index % 2 == 0 then color = info.Stripes end
		p.Color = trail and color:Lerp(WHITE, 0.25) or color
		p.Parent = model
		return p
	end
	local A, C, rad = CFrame.Angles, CFrame.new, math.rad
	local lean = A(rad(-18), 0, 0)
	part(Vector3.new(1.2, 1.2, 1.2), C(0, 4.5, -0.5))                                  -- tête
	part(Vector3.new(2, 2, 1), C(0, 3, 0) * lean)                                      -- buste
	part(Vector3.new(0.9, 2, 0.9), C(-1.5, 3.1, -0.6) * A(rad(60), 0, 0))              -- bras gauche en avant
	part(Vector3.new(0.9, 2, 0.9), C(1.5, 2.9, 0.7) * A(rad(-55), 0, 0))               -- bras droit en arrière
	part(Vector3.new(0.95, 2, 0.95), C(-0.5, 1.1, 0.9) * A(rad(-50), 0, 0))            -- jambe gauche en arrière
	part(Vector3.new(0.95, 2, 0.95), C(0.5, 1.3, -0.9) * A(rad(55), 0, 0))             -- jambe droite en avant
	for i = 0, 4 do                                                                     -- traînée : des rubans qui s'affinent
		part(Vector3.new(0.3, 2.2 - i * 0.36, 1.5), C(0, 3 - i * 0.12, 1.3 + i * 1.4) * A(rad(-8 - i * 3), 0, 0), true)
	end
	return model
end

---------------------------------------------------------------- fenêtre
local window = new("Frame", {Name = "Window", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(880, 520),
	BackgroundColor3 = rgb(44, 46, 54), BorderSizePixel = 0, Visible = false}, gui)
border(window, 4)
studs(window, 0.88)
local scale = new("UIScale", {}, window)
local function fit()
	local size = workspace.CurrentCamera.ViewportSize
	scale.Scale = math.clamp(math.min(size.X / 940, size.Y / 600), 0.45, 1.15)
end
workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(fit)
fit()
local header = new("Frame", {Name = "Header", BackgroundColor3 = WHITE, BorderSizePixel = 0, Position = UDim2.fromOffset(6, 6), Size = UDim2.new(1, -12, 0, 74), ZIndex = 2}, window)
border(header, 3)
local headerGradient = new("UIGradient", {Rotation = 0}, header)
studs(header, 0.8)
for i = 0, 2 do -- reflets en biais
	new("Frame", {BackgroundColor3 = WHITE, BackgroundTransparency = 0.78, BorderSizePixel = 0, Rotation = 24, Position = UDim2.new(0.52 + i * 0.09, 0, -0.6, 0), Size = UDim2.new(0.035 + i * 0.012, 0, 2.2, 0), ZIndex = 2}, header)
end
header.ClipsDescendants = true
local title = text(header, {Name = "Title", Text = "", TextXAlignment = Enum.TextXAlignment.Left, Position = UDim2.fromOffset(20, 14), Size = UDim2.new(1, -120, 1, -28), ZIndex = 4})
local close = new("TextButton", {Name = "Close", Text = "X", FontFace = FONT, TextSize = 40, TextColor3 = WHITE, BackgroundColor3 = rgb(226, 34, 44), BorderSizePixel = 0,
	AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -8, 0.5, 0), Size = UDim2.fromOffset(64, 58), ZIndex = 5}, header)
border(close, 3)
new("UIStroke", {Thickness = 3, Color = BLACK}, close)
close.Activated:Connect(function() window.Visible = false end)
local row = new("ScrollingFrame", {Name = "Cards", BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromOffset(8, 90), Size = UDim2.new(1, -16, 1, -98),
	ScrollingDirection = Enum.ScrollingDirection.X, ScrollBarThickness = 8, CanvasSize = UDim2.new(), AutomaticCanvasSize = Enum.AutomaticSize.X, ZIndex = 2}, window)
new("UIListLayout", {FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0, 12), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Top}, row)
new("UIPadding", {PaddingLeft = UDim.new(0, 4), PaddingRight = UDim.new(0, 4), PaddingTop = UDim.new(0, 4)}, row)

-- une carte ; renvoie {Price, PriceLabel, Robux, Wide, WideLabel}
local function card(order, name, rarity, statText, statColor, fill)
	local color = RARITY[rarity] or RARITY.Common
	local c = new("Frame", {BackgroundColor3 = WHITE, BorderSizePixel = 0, Size = UDim2.fromOffset(272, 396), LayoutOrder = order, ZIndex = 3}, row)
	border(c, 4)
	new("UIGradient", {Rotation = 90, Color = ColorSequence.new(color:Lerp(WHITE, 0.35), color:Lerp(BLACK, 0.12))}, c)
	studs(c, 0.94)
	text(c, {Text = name, Position = UDim2.fromOffset(8, 8), Size = UDim2.new(1, -16, 0, 40), ZIndex = 5})
	text(c, {Text = rarity, TextColor3 = color:Lerp(WHITE, 0.15), Position = UDim2.fromOffset(40, 48), Size = UDim2.new(1, -80, 0, 26), ZIndex = 5})
	local view = new("ViewportFrame", {BackgroundTransparency = 1, Position = UDim2.fromOffset(16, 70), Size = UDim2.new(1, -32, 0, 206), ZIndex = 4, Ambient = rgb(215, 215, 215), LightColor = WHITE, LightDirection = Vector3.new(-1, -1, -1)}, c)
	fill(view)
	local stat = new("Frame", {BackgroundColor3 = rgb(60, 62, 70), BackgroundTransparency = 0.15, BorderSizePixel = 0, Position = UDim2.fromOffset(14, 270), Size = UDim2.new(1, -28, 0, 50), ZIndex = 5}, c)
	border(stat, 3)
	local statLabel = text(stat, {Text = statText, RichText = true, Position = UDim2.fromScale(0.05, 0.16), Size = UDim2.fromScale(0.9, 0.68), ZIndex = 6})
	local price, priceLabel = button(c, GREEN, {Position = UDim2.fromOffset(14, 330), Size = UDim2.new(0.6, -20, 0, 54), ZIndex = 5})
	local robux, robuxLabel = button(c, PINK, {AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -14, 0, 330), Size = UDim2.new(0.4, -14, 0, 54), ZIndex = 5})
	robuxLabel.Position, robuxLabel.Size, robuxLabel.TextXAlignment = UDim2.fromScale(0.42, 0.18), UDim2.fromScale(0.54, 0.64), Enum.TextXAlignment.Left
	local icon = text(robux, {Text = utf8.char(0xE002), Position = UDim2.fromScale(0.06, 0.18), Size = UDim2.fromScale(0.34, 0.64), ZIndex = robux.ZIndex + 1})
	icon.FontFace = Font.fromEnum(Enum.Font.GothamBold)
	local wide, wideLabel = button(c, GREEN, {Position = UDim2.fromOffset(14, 330), Size = UDim2.new(1, -28, 0, 54), ZIndex = 5, Visible = false})
	return {Price = price, PriceLabel = priceLabel, Robux = robux, RobuxLabel = robuxLabel, Wide = wide, WideLabel = wideLabel}
end

-- état d'une carte : à vendre (prix + Robux), ou un seul bouton large (Equip, Unequip, Equipped, Locked...)
local function forSale(c, priceText, affordable, robuxText)
	c.Price.Visible, c.Robux.Visible, c.Wide.Visible = true, true, false
	c.PriceLabel.Text = priceText
	c.Price.BackgroundColor3 = affordable and GREEN or GREY
	c.RobuxLabel.Text = robuxText
end
local function single(c, label, color)
	c.Price.Visible, c.Robux.Visible, c.Wide.Visible = false, false, true
	c.WideLabel.Text = label
	c.Wide.BackgroundColor3 = color
end

---------------------------------------------------------------- contenu des deux boutiques
local current
local cards = {}
local refresh

local HAMMER_RARITY = {"Common", "Uncommon", "Rare", "Epic", "Legendary", "Prismatic"}
local HAMMER_ROBUX = {0, 24, 99, 249, 499, 899}
local function bestZoneOf(tier)
	local best
	for _, rarity in EggConfig.Rarities do
		if EggConfig.ZoneHammer(rarity) <= tier then best = EggConfig.ZoneTitles[rarity] end
	end
	return best or "-"
end

local function build(which)
	for _, child in row:GetChildren() do if child:IsA("Frame") then child:Destroy() end end
	table.clear(cards)
	current = which
	if which == "Hammers" then
		title.Text = "Hammer Shop"
		headerGradient.Color = ColorSequence.new(rgb(255, 120, 20), rgb(255, 196, 40))
		for index, info in HammerConfig.Tiers do
			local c = card(index, info.Name, HAMMER_RARITY[index] or "Common", '<font color="#40C4FF">' .. info.Damage .. '</font> Power', nil, function(view)
				local template = hammerModels:FindFirstChild("Tier" .. index)
				if template then frameModel(view, template:Clone(), -30) end
			end)
			c.Price.Activated:Connect(function() hammerSystem.Buy:FireServer() end)
			c.Robux.Activated:Connect(function() hammerSystem.Buy:FireServer(true) end)
			cards[index] = c
		end
	else
		title.Text = "Trail Shop"
		headerGradient.Color = ColorSequence.new(rgb(30, 150, 255), rgb(60, 220, 255))
		for index, info in TrailConfig.Trails do
			local c = card(index, info.Name, info.Rarity, '<font color="#60FF50">x' .. SpeedConfig.Format(info.Mult) .. '</font> Speed', nil, function(view)
				if info.Icon then -- l'icône de la traînée, un peu penchée, à la place du petit coureur en blocs
					view.Visible = false
					new("ImageLabel", {Name = "Icon", BackgroundTransparency = 1, Image = info.Icon, ScaleType = Enum.ScaleType.Fit, Rotation = -6,
						AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0.5, 0, 0, 172), Size = UDim2.fromOffset(214, 214), ZIndex = 4}, view.Parent)
					return
				end
				-- vu de trois quarts : le coureur devant, sa traînée qui file derrière lui
				local model = runnerModel(info)
				model.Parent = view
				local cf, size = model:GetBoundingBox()
				local camera = new("Camera", {FieldOfView = 36}, view)
				camera.CFrame = CFrame.lookAt(cf.Position + Vector3.new(1, 0.3, -0.55).Unit * math.max(size.X, size.Y, size.Z) * 1.05, cf.Position)
				view.CurrentCamera = camera
			end)
			c.Price.Activated:Connect(function() trailSystem.Buy:FireServer(index) end)
			c.Robux.Activated:Connect(function() trailSystem.Buy:FireServer(index, true) end)
			c.Wide.Activated:Connect(function() trailSystem.Equip:FireServer(index) end)
			cards[index] = c
		end
	end
	row.CanvasPosition = Vector2.zero
	refresh()
end

function refresh()
	if not current then return end
	local money = player:GetAttribute("Money") or 0
	if current == "Hammers" then
		local owned = player:GetAttribute("Hammer") or 1
		for index, c in cards do
			local info = HammerConfig.Tiers[index]
			if index == owned then single(c, "Equipped", BLUE)
			elseif index < owned then single(c, "Owned", GREY)
			elseif index == owned + 1 then forSale(c, EggConfig.FormatMoney(info.Price), money >= info.Price, tostring(HAMMER_ROBUX[index] or 0))
			else single(c, "Buy the " .. HammerConfig.Tiers[index - 1].Name:gsub(" Hammer", "") .. " first", GREY) end
		end
	else
		local owned = TrailConfig.Owned(player:GetAttribute("Trails"))
		local equipped = player:GetAttribute("Trail") or 0
		for index, c in cards do
			local info = TrailConfig.Trails[index]
			if equipped == index then single(c, "Unequip", rgb(120, 200, 70))
			elseif owned[index] then single(c, "Equip", GREEN)
			else forSale(c, EggConfig.FormatMoney(info.Price), money >= info.Price, tostring(info.Robux)) end
		end
	end
end
for _, name in {"Money", "Hammer", "Trail", "Trails"} do
	player:GetAttributeChangedSignal(name):Connect(function() if window.Visible then refresh() end end)
end

local function open(which)
	if window.Visible and current == which then window.Visible = false return end
	build(which)
	window.Visible = true
end
hammerSystem:WaitForChild("OpenShop").OnClientEvent:Connect(function() open("Hammers") end)
trailSystem:WaitForChild("OpenShop").OnClientEvent:Connect(function() open("Trails") end)
