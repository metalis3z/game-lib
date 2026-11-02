-- Boutiques des stands HAMMERS et TRAILS : une rangée de cartes qui défile de gauche à droite.
-- Chaque carte : nom, rareté, image, bandeau de statistique, puis prix (argent + Robux) ou Equip / Unequip.
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local EggConfig = require(ReplicatedStorage:WaitForChild("EggSystem"):WaitForChild("EggConfig"))
local hammerSystem = ReplicatedStorage:WaitForChild("HammerSystem")
local HammerConfig = require(hammerSystem:WaitForChild("HammerConfig"))
local hammerModels = hammerSystem:WaitForChild("Models")
local trailSystem = ReplicatedStorage:WaitForChild("TrailSystem")
local TrailConfig = require(trailSystem:WaitForChild("TrailConfig"))
local SpeedConfig = require(ReplicatedStorage:WaitForChild("SpeedSystem"):WaitForChild("SpeedConfig"))
local Portrait = require(ReplicatedStorage:WaitForChild("EggSystem"):WaitForChild("PetPortrait"))

local rgb = Color3.fromRGB
local WHITE, BLACK = Color3.new(1, 1, 1), Color3.new(0, 0, 0)
local FONT = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy)
local STUDS = "rbxassetid://7447638591"
local GREEN, GREY, PINK, BLUE = rgb(140, 255, 60), rgb(196, 200, 210), rgb(255, 110, 250), rgb(110, 190, 255)
-- couleur des cartes et du nom de rareté
local RARITY = {
	Common = rgb(236, 236, 240), Uncommon = rgb(120, 230, 110), Rare = rgb(90, 160, 255), Epic = rgb(200, 110, 255), Legendary = rgb(255, 110, 100),
	Mythic = rgb(255, 205, 80), Secret = rgb(150, 150, 166), Ancient = rgb(150, 220, 90), OG = rgb(255, 170, 70), Divine = rgb(255, 236, 160), Prismatic = rgb(255, 130, 220), Galactic = rgb(130, 170, 255),
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
	new("UIGradient", {Name = "Fill", Rotation = 90, Color = ColorSequence.new(Color3.new(1, 1, 1), Color3.fromRGB(150, 150, 150))}, b) -- clair en haut, plus soutenu en bas
	new("UIStroke", {Thickness = 2, Color = Color3.new(0, 0, 0), Transparency = 0.72, ApplyStrokeMode = Enum.ApplyStrokeMode.Border},
		new("Frame", {Name = "Inner", BackgroundTransparency = 1, Position = UDim2.fromOffset(3, 3), Size = UDim2.new(1, -6, 1, -6), ZIndex = b.ZIndex}, b)) -- liseré intérieur
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
	c.ClipsDescendants = true
	local rays = Portrait.rays(c, WHITE, 0.45, 3) -- éclat de lumière derrière l'objet
	rays.Position = UDim2.new(0.5, 0, 0, 172)
	local nameLabel = text(c, {Text = name, Position = UDim2.fromOffset(8, 8), Size = UDim2.new(1, -16, 0, 40), ZIndex = 5})
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
	return {Price = price, PriceLabel = priceLabel, Robux = robux, RobuxLabel = robuxLabel, Wide = wide, WideLabel = wideLabel, Frame = c, Name = nameLabel}
end

-- état d'une carte : à vendre (prix + Robux), ou un seul bouton large (Equip, Unequip, Equipped, Locked...)
-- robuxText nil : pas de bouton Robux, le prix prend toute la largeur, centré (marteaux)
local function forSale(c, priceText, affordable, robuxText)
	c.Price.Visible, c.Robux.Visible, c.Wide.Visible = true, robuxText ~= nil, false
	c.Price.Size = robuxText and UDim2.new(0.6, -20, 0, 54) or UDim2.new(1, -28, 0, 54)
	c.PriceLabel.Text = priceText
	c.Price.BackgroundColor3 = affordable and GREEN or GREY
	if robuxText then c.RobuxLabel.Text = robuxText end
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

local HAMMER_RARITY = {"Common", "Uncommon", "Rare", "Epic", "Legendary", "Prismatic", "Mythic", "Secret", "Divine", "Ancient", "Common", "Uncommon", "Rare", "Epic", "Legendary", "Prismatic", "Mythic", "Secret", "Divine", "Ancient"}
local HAMMER_ROBUX = {0, 24, 99, 249, 499, 899, 1499, 1999, 2999, 4999, 7999, 11999, 17999, 24999, 34999, 49999, 69999, 99999, 149999, 199999, 299999, 499999}
local function bestZoneOf(tier)
	local best
	for _, rarity in EggConfig.Rarities do
		if EggConfig.ZoneHammer(rarity) <= tier then best = EggConfig.ZoneTitles[rarity] end
	end
	return best or "-"
end

-- petits textes stylés des cartes de marteaux : numéro, multiplicateur de puissance, nom qui brille, « NEXT! » sur le prochain achat
local shimmers, pulses = {}, {} -- dégradés et échelles animés tant que la boutique est ouverte
local function short(n) return string.sub(EggConfig.FormatMoney(n), 2) end -- 4096 -> "4.1K"
local RAINBOW = ColorSequence.new({ColorSequenceKeypoint.new(0, rgb(255, 90, 90)), ColorSequenceKeypoint.new(0.2, rgb(255, 200, 60)), ColorSequenceKeypoint.new(0.4, rgb(110, 255, 120)),
	ColorSequenceKeypoint.new(0.6, rgb(80, 200, 255)), ColorSequenceKeypoint.new(0.8, rgb(200, 110, 255)), ColorSequenceKeypoint.new(1, rgb(255, 90, 90))})
local function decorateHammer(c, index, info)
	local frame = c.Frame
	-- ruban « #5 » penché en haut à gauche
	local ribbon = new("Frame", {BackgroundColor3 = WHITE, BorderSizePixel = 0, Position = UDim2.fromOffset(12, 82), Size = UDim2.fromOffset(54, 30), Rotation = -8, ZIndex = 6}, frame)
	border(ribbon, 3)
	new("UIGradient", {Rotation = 90, Color = ColorSequence.new(rgb(84, 88, 106), rgb(28, 30, 38))}, ribbon)
	text(ribbon, {Text = "#" .. index, Position = UDim2.fromScale(0.1, 0.12), Size = UDim2.fromScale(0.8, 0.76), ZIndex = 7})
	-- multiplicateur par rapport au marteau précédent : doré, penché, il pulse
	local prev = HammerConfig.Tiers[index - 1]
	if prev and prev.Damage > 0 then
		local mult = info.Damage / prev.Damage
		local label = text(frame, {Text = "x" .. (mult == math.floor(mult) and tostring(mult) or string.format("%.1f", mult)) .. " POWER!", AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.new(1, -66, 0, 98), Size = UDim2.fromOffset(118, 28), Rotation = 7, ZIndex = 7})
		new("UIGradient", {Rotation = 90, Color = ColorSequence.new(rgb(255, 252, 170), rgb(255, 160, 30))}, label)
		table.insert(pulses, {Scale = new("UIScale", {}, label), Phase = index * 0.7, Amount = 0.07})
	end
	-- nom : un reflet de la couleur du marteau le traverse (arc-en-ciel pour les marteaux Rainbow)
	if info.Rainbow then
		table.insert(shimmers, new("UIGradient", {Color = RAINBOW}, c.Name))
	elseif info.Glow then
		local glow = info.Glow:Lerp(WHITE, 0.2)
		table.insert(shimmers, new("UIGradient", {Color = ColorSequence.new({ColorSequenceKeypoint.new(0, WHITE), ColorSequenceKeypoint.new(0.4, WHITE),
			ColorSequenceKeypoint.new(0.5, glow), ColorSequenceKeypoint.new(0.6, WHITE), ColorSequenceKeypoint.new(1, WHITE)})}, c.Name))
	end
	-- « NEXT! » vert qui sautille au-dessus du prochain marteau à acheter (affiché par refresh)
	local nextLabel = text(frame, {Text = "NEXT!", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0.5, 0, 0, 256), Size = UDim2.fromOffset(110, 30), Rotation = -4, ZIndex = 7, Visible = false})
	new("UIGradient", {Rotation = 90, Color = ColorSequence.new(rgb(210, 255, 150), rgb(60, 210, 80))}, nextLabel)
	table.insert(pulses, {Scale = new("UIScale", {}, nextLabel), Phase = 0, Amount = 0.12})
	c.Next = nextLabel
end
RunService.RenderStepped:Connect(function()
	if not window.Visible then return end
	local t = os.clock()
	for _, g in shimmers do g.Offset = Vector2.new((t * 0.55) % 2 - 1, 0) end
	for _, p in pulses do p.Scale.Scale = 1 + p.Amount * math.sin(t * 5 + p.Phase) end
end)

local buildToken = 0
local function build(which)
	buildToken += 1
	local myToken = buildToken
	for _, child in row:GetChildren() do if child:IsA("Frame") then child:Destroy() end end
	table.clear(cards)
	table.clear(shimmers)
	table.clear(pulses)
	current = which
	if which == "Hammers" then
		title.Text = "Hammer Shop"
		headerGradient.Color = ColorSequence.new(rgb(255, 120, 20), rgb(255, 196, 40))
		for index, info in HammerConfig.Tiers do
			if myToken ~= buildToken then return end
			local c = card(index, info.Name, info.Rarity or HAMMER_RARITY[index] or "Common", '<font color="#40C4FF">' .. short(info.Damage) .. '</font> Power', nil, function(view)
				local template = hammerModels:FindFirstChild("Tier" .. index)
				if template then frameModel(view, template:Clone(), -30) end
			end)
			decorateHammer(c, index, info)
			c.Price.Activated:Connect(function() hammerSystem.Buy:FireServer(index) end)
			c.Robux.Activated:Connect(function() hammerSystem.Buy:FireServer(index, true) end)
			c.Wide.Activated:Connect(function() hammerSystem.Equip:FireServer(index) end)
			cards[index] = c
			refresh()
			task.wait()
		end
	else
		title.Text = "Trail Shop"
		headerGradient.Color = ColorSequence.new(rgb(30, 150, 255), rgb(60, 220, 255))
		for index, info in TrailConfig.Trails do
			if myToken ~= buildToken then return end
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
			refresh()
			task.wait()
		end
	end
	if myToken ~= buildToken then return end
	row.CanvasPosition = Vector2.zero
	refresh()
end

function refresh()
	if not current then return end
	local money = player:GetAttribute("Money") or 0
	if current == "Hammers" then
		local owned = {[1] = true} -- chaque marteau acheté à part (OwnedHammers)
		for n in string.gmatch(player:GetAttribute("OwnedHammers") or "", "%d+") do owned[tonumber(n)] = true end
		local equipped = player:GetAttribute("EquippedHammer") or player:GetAttribute("Hammer") or 1
		local nextTier = equipped + 1 -- « NEXT! » : le premier marteau pas encore acheté au-dessus de celui qu'on tient
		while owned[nextTier] do nextTier += 1 end
		for index, c in cards do
			local info = HammerConfig.Tiers[index]
			if c.Next then c.Next.Visible = index == nextTier end
			if index == equipped then single(c, "Equipped", BLUE)
			elseif owned[index] then single(c, "Equip", GREEN)
			else forSale(c, EggConfig.FormatMoney(info.Price), money >= info.Price, nil) end -- tout marteau au-dessus s'achète directement (en argent seulement)
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
for _, name in {"Money", "Hammer", "OwnedHammers", "EquippedHammer", "Trail", "Trails"} do
	player:GetAttributeChangedSignal(name):Connect(function() if window.Visible then refresh() end end)
end

local function open(which)
	if window.Visible and current == which then window.Visible = false return end
	window.Visible = true
	task.spawn(build, which)
end
hammerSystem:WaitForChild("OpenShop").OnClientEvent:Connect(function() open("Hammers") end)
trailSystem:WaitForChild("OpenShop").OnClientEvent:Connect(function() open("Trails") end)

---------------------------------------------------------------- cercles devant les stands
-- Chaque stand a un cercle lumineux au sol (modèle "ShopZone", tag ShopZone, attribut Shop = "Hammers" ou "Trails", Radius),
-- avec un rideau de lumière qui monte de son bord (ServerStorage.ShopZoneBuilder). Marcher dedans ouvre la boutique avec un petit
-- « pop » ; en sortir la ferme. Le bord respire doucement, et tout s'illumine quand on est dedans.
local RunService = game:GetService("RunService")
local SoundService = game:GetService("SoundService")
local pop = Instance.new("Sound")
pop.SoundId = "rbxassetid://6586979979" -- pop cartoon très court
pop.Volume = 0.6
pop.Parent = SoundService
local zones = {} -- [modèle] = {Shop, Radius, Disc, Edge, Fill, Curtain, Motes, Inside, Glow}
-- les pièces du cercle peuvent arriver plus tard (le stand n'est chargé qu'à l'approche, et pas pendant la cinématique) :
-- on les cherche à chaque image tant qu'elles manquent
local function resolve(model, z)
	z.Disc = z.Disc or model:FindFirstChild("Disc")
	if not z.Disc then return false end
	local circle = z.Disc:FindFirstChild("Circle")
	z.Fill = z.Fill or (circle and circle:FindFirstChild("Fill"))
	z.Edge = z.Edge or (z.Fill and z.Fill:FindFirstChild("Edge"))
	z.Curtain = z.Curtain or z.Disc:FindFirstChild("Curtain")
	z.Motes = z.Motes or z.Disc:FindFirstChild("Motes")
	if not z.Walls then -- rebord lumineux en hauteur (dossier Rim : panneaux avec un dégradé)
		local rim = model:FindFirstChild("Rim")
		if rim then
			z.Walls = {}
			for _, d in rim:GetDescendants() do if d:IsA("SurfaceGui") then table.insert(z.Walls, d) end end
		end
	end
	return true
end
local function addZone(model)
	if zones[model] or not model:IsA("Model") then return end
	zones[model] = {Shop = model:GetAttribute("Shop"), Radius = model:GetAttribute("Radius") or 9, Inside = false, Glow = 0}
end
CollectionService:GetInstanceAddedSignal("ShopZone"):Connect(addZone)
CollectionService:GetInstanceRemovedSignal("ShopZone"):Connect(function(model) zones[model] = nil end)
for _, model in CollectionService:GetTagged("ShopZone") do addZone(model) end

RunService.Heartbeat:Connect(function(dt)
	local character = player.Character
	local root = character and character:FindFirstChild("HumanoidRootPart")
	local now = os.clock()
	for model, z in zones do
		if not model.Parent then zones[model] = nil continue end
		if not resolve(model, z) or not z.Disc.Parent then z.Disc = nil continue end
		local center = z.Disc.Position
		local inside = false
		if root then
			local offset = root.Position - center
			inside = Vector3.new(offset.X, 0, offset.Z).Magnitude <= z.Radius and math.abs(offset.Y) < 8
		end
		if inside ~= z.Inside then
			z.Inside = inside
			if inside then
				if not (window.Visible and current == z.Shop) then open(z.Shop) end
				pop.PlaybackSpeed = 1.05 + math.random() * 0.1
				SoundService:PlayLocalSound(pop)
			elseif window.Visible and current == z.Shop then
				window.Visible = false
			end
		end
		-- 0 dehors, 1 dedans, en douceur
		z.Glow += ((z.Inside and 1 or 0) - z.Glow) * math.min(1, dt * 6)
		local breathe = math.sin(now * 2.6) * 0.5 + 0.5
		if z.Edge then z.Edge.Transparency = 0.18 - 0.16 * z.Glow + breathe * 0.12 * (1 - z.Glow) end
		if z.Fill then z.Fill.BackgroundTransparency = 0.66 - 0.2 * z.Glow end
		if z.Curtain then z.Curtain.Rate = 70 + 110 * z.Glow end
		if z.Motes then z.Motes.Rate = 26 + 40 * z.Glow end
		if z.Walls then
			local brightness = 1.6 + 1.6 * z.Glow + breathe * 0.5 * (1 - z.Glow)
			for _, wall in z.Walls do wall.Brightness = brightness end
		end
	end
end)
