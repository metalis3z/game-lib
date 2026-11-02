-- Shop window (Shop button on the left): the featured egg banner (ShopConfig.Featured) on top, then the game passes.
-- Banner: egg art, title, countdown, the six animals with their chances, and one buy button per pack (with a gift button).
local Players = game:GetService("Players")
local MarketplaceService = game:GetService("MarketplaceService")
-- PRIX EN DIRECT : le prix affiché est celui du Creator Dashboard (lu chez Roblox), pas celui écrit dans ShopConfig.
-- Si tu changes le prix d'un gamepass / produit sur le Dashboard, la boutique affiche tout de suite le nouveau prix.
local priceCache = {}
local function livePrice(id, isProduct, onPrice)
	if not id or id == 0 then return end
	task.spawn(function()
		local key = (isProduct and "p" or "g") .. id
		local price = priceCache[key]
		if not price then
			local ok, info = pcall(function()
				return MarketplaceService:GetProductInfo(id, isProduct and Enum.InfoType.Product or Enum.InfoType.GamePass)
			end)
			price = ok and info and info.PriceInRobux or nil
			if price then priceCache[key] = price end
		end
		if price then onPrice(price) end
	end)
end
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TextChatService = game:GetService("TextChatService")
local CollectionService = game:GetService("CollectionService")

local shopSystem = ReplicatedStorage:WaitForChild("ShopSystem")
local ShopConfig = require(shopSystem:WaitForChild("ShopConfig"))
local buyFeatured = shopSystem:WaitForChild("Remotes"):WaitForChild("BuyFeatured")
local eggSystem = ReplicatedStorage:WaitForChild("EggSystem")
local EggConfig = require(eggSystem:WaitForChild("EggConfig"))
local petTemplates = eggSystem:WaitForChild("Pets")
local Portrait = require(eggSystem:WaitForChild("PetPortrait"))
local AnimalAnimator = require(ReplicatedStorage:WaitForChild("AnimalKit"):WaitForChild("AnimalAnimator"))
local TweenService = game:GetService("TweenService")
local PATTERN = "rbxassetid://82096270344702" -- le motif studs du jeu

local player = Players.LocalPlayer
local gui = script.Parent
local main = gui:WaitForChild("Main")
local rowTemplate = script:WaitForChild("RowTemplate")
local openButton = player:WaitForChild("PlayerGui"):WaitForChild("left bottom"):WaitForChild("Holder"):WaitForChild("ShopButton")

local rgb = Color3.fromRGB
local WHITE, BLACK = Color3.new(1, 1, 1), Color3.new(0, 0, 0)
local FONT = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy)
local SERIF = Font.new("rbxasset://fonts/families/Merriweather.json", Enum.FontWeight.Heavy)
local STUDS = "rbxassetid://7447638591"
local ART = {Egg = "rbxassetid://119221572901822", Banner = "rbxassetid://138079645273228", Frame = "rbxassetid://125092856491930", Gift = "rbxassetid://98725504330944",
	AngelSky = "rbxassetid://81952387469586", Feather = "rbxassetid://71307509222912"}
local BUY_GRADIENT = ColorSequence.new(rgb(150, 226, 96), rgb(66, 170, 70))
local OWNED_GRADIENT = ColorSequence.new(rgb(130, 214, 255), rgb(70, 140, 236))
local SOON_GRADIENT = ColorSequence.new(rgb(206, 206, 216), rgb(150, 150, 166))

local function new(class, props, parent)
	local o = Instance.new(class)
	for k, v in props do o[k] = v end
	o.Parent = parent
	return o
end
local function border(o, thickness, color)
	return new("UIStroke", {Thickness = thickness or 3, Color = color or BLACK, ApplyStrokeMode = Enum.ApplyStrokeMode.Border}, o)
end
local function studs(o, transparency, tile)
	return new("ImageLabel", {Name = "Studs", BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), Image = STUDS, ScaleType = Enum.ScaleType.Tile,
		TileSize = UDim2.fromOffset(tile or 30, tile or 30), ImageTransparency = transparency or 0.8, ZIndex = o.ZIndex}, o)
end
local function text(parent, props, stroke)
	local l = new("TextLabel", {BackgroundTransparency = 1, FontFace = FONT, TextColor3 = WHITE, TextScaled = true, ZIndex = parent.ZIndex + 1}, parent)
	for k, v in props do l[k] = v end
	new("UIStroke", {Thickness = stroke or 3, Color = BLACK}, l)
	return l
end
-- bouton du jeu : dégradé clair en haut / vif en bas, studs, contour noir épais, liseré intérieur plus sombre
local function fancyButton(parent, top, bottom, props)
	local b = new("TextButton", {Text = "", AutoButtonColor = true, BackgroundColor3 = WHITE, BorderSizePixel = 0, ZIndex = parent.ZIndex + 2}, parent)
	for k, v in props do b[k] = v end
	new("UIGradient", {Name = "Fill", Rotation = 90, Color = ColorSequence.new(top, bottom)}, b)
	new("UICorner", {CornerRadius = UDim.new(0, 12)}, b)
	border(b, 2.5, bottom:Lerp(BLACK, 0.55)) -- un seul contour, fin, de la couleur du bouton en plus sombre
	local inner = new("Frame", {Name = "Inner", BackgroundTransparency = 1, Position = UDim2.fromOffset(3, 3), Size = UDim2.new(1, -6, 1, -6), ZIndex = b.ZIndex}, b)
	local shine = border(inner, 2, WHITE) -- reflet clair à l'intérieur (au lieu du double contour noir)
	shine.Transparency = 0.7
	new("UICorner", {CornerRadius = UDim.new(0, 9)}, inner)
	return b
end

---------------------------------------------------------------- fenêtre
for _, name in {"Studs", "Header", "Subtitle", "List", "Shade"} do -- l'ancienne présentation
	local old = main:FindFirstChild(name)
	if old then old:Destroy() end
end
main.Size = UDim2.fromOffset(940, 620)
main.BackgroundColor3 = rgb(44, 46, 54)
local outline = main:FindFirstChildOfClass("UIStroke") or border(main, 4)
outline.Thickness, outline.Color = 3, rgb(14, 15, 20)
if not main:FindFirstChildOfClass("UICorner") then new("UICorner", {CornerRadius = UDim.new(0, 18)}, main) end
studs(main, 0.88, 34)

local header = new("Frame", {Name = "Header", BackgroundColor3 = WHITE, BorderSizePixel = 0, Position = UDim2.fromOffset(6, 6), Size = UDim2.new(1, -12, 0, 78), ClipsDescendants = true, ZIndex = 2}, main)
new("UIGradient", {Color = ColorSequence.new(rgb(196, 255, 44), rgb(74, 228, 30))}, header)
new("UICorner", {CornerRadius = UDim.new(0, 14)}, header)
border(header, 2.5, rgb(30, 90, 10))
studs(header, 0.8)
for i = 0, 2 do -- reflets en biais
	new("Frame", {BackgroundColor3 = WHITE, BackgroundTransparency = 0.72, BorderSizePixel = 0, Rotation = 24, Position = UDim2.new(0.5 + i * 0.085, 0, -0.6, 0), Size = UDim2.new(0.035 + i * 0.012, 0, 2.2, 0), ZIndex = 2}, header)
end
text(header, {Name = "Title", Text = "Shop", TextXAlignment = Enum.TextXAlignment.Left, Position = UDim2.fromOffset(22, 10), Size = UDim2.new(1, -130, 1, -20), ZIndex = 4}, 4)
local close = new("TextButton", {Name = "Close", Text = "X", FontFace = FONT, TextSize = 42, TextColor3 = WHITE, BackgroundColor3 = WHITE, BorderSizePixel = 0,
	AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -8, 0.5, 0), Size = UDim2.fromOffset(66, 60), ZIndex = 5}, header)
new("UIGradient", {Rotation = 90, Color = ColorSequence.new(rgb(255, 70, 70), rgb(190, 14, 30))}, close)
new("UICorner", {CornerRadius = UDim.new(0, 12)}, close)
border(close, 2.5, rgb(90, 6, 14))
new("UIStroke", {Thickness = 3, Color = BLACK}, close)
close.Activated:Connect(function() main.Visible = false end)

local body = new("ScrollingFrame", {Name = "Body", BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromOffset(8, 92), Size = UDim2.new(1, -16, 1, -100),
	ScrollBarThickness = 8, CanvasSize = UDim2.new(), AutomaticCanvasSize = Enum.AutomaticSize.Y, ScrollingDirection = Enum.ScrollingDirection.Y, ZIndex = 2}, main)
new("UIListLayout", {Padding = UDim.new(0, 8), SortOrder = Enum.SortOrder.LayoutOrder, HorizontalAlignment = Enum.HorizontalAlignment.Center}, body)
new("UIPadding", {PaddingTop = UDim.new(0, 4), PaddingBottom = UDim.new(0, 10)}, body)

local function sectionTitle(label, order)
	local l = text(body, {Text = "~ " .. label .. " ~", Size = UDim2.new(1, -40, 0, 44), LayoutOrder = order, ZIndex = 3}, 3.5)
	new("UIGradient", {Rotation = 90, Color = ColorSequence.new(rgb(255, 240, 80), rgb(255, 176, 20))}, l)
	return l
end

---------------------------------------------------------------- œuf en vedette
local featured = ShopConfig.Featured
local eggInfo = featured and EggConfig.Eggs[featured.Egg]
local timerLabel
local packButtons = {}

if featured and eggInfo then
	sectionTitle("Featured", 1)
	-- le cadre doré est posé AUTOUR de la bannière (comme un contour) : il ne mange pas l'intérieur
	local holder = new("Frame", {Name = "FeaturedHolder", BackgroundTransparency = 1, Size = UDim2.fromOffset(916, 440), LayoutOrder = 2, ZIndex = 3}, body)
	local banner = new("Frame", {Name = "Featured", BackgroundColor3 = rgb(26, 12, 54), BorderSizePixel = 0, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5),
		Size = UDim2.fromOffset(884, 408), ZIndex = 3}, holder)
	-- fond ANGE : ciel bleu, lumière dorée derrière l'œuf, nuages, étoiles ; des plumes tombent et des étincelles scintillent
	new("ImageLabel", {Name = "Background", BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), Image = ART.AngelSky, ScaleType = Enum.ScaleType.Crop, ZIndex = 3}, banner)
	local sky = new("Frame", {Name = "SkyFx", BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), ClipsDescendants = true, ZIndex = 4}, banner)
	task.spawn(function()
		local nextFeather, nextSpark = 0, 0
		while sky.Parent do
			if main.Visible then
				local t = os.clock()
				if t > nextFeather then -- une plume qui descend en se balançant
					nextFeather = t + 0.22 + math.random() * 0.25 -- (2x plus de plumes)
					local size = math.random(54, 102) -- (3x plus grandes)
					local x = math.random(20, 864)
					local f = new("ImageLabel", {BackgroundTransparency = 1, Image = ART.Feather, ScaleType = Enum.ScaleType.Fit, AnchorPoint = Vector2.new(0.5, 0.5),
						Position = UDim2.fromOffset(x, -60), Size = UDim2.fromOffset(size, size), Rotation = math.random(-60, 60), ImageTransparency = 0.1, ZIndex = 4}, sky)
					local fall = 5 + math.random() * 3
					TweenService:Create(f, TweenInfo.new(fall, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Position = UDim2.fromOffset(x + math.random(-90, 90), 440),
						Rotation = f.Rotation + math.random(-140, 140), ImageTransparency = 0.5}):Play()
					task.delay(fall, function() f:Destroy() end)
				end
				if t > nextSpark then -- une étincelle dorée qui s'allume et s'éteint
					nextSpark = t + 0.15 + math.random() * 0.2
					local s = new("Frame", {BackgroundColor3 = rgb(255, 238, 160), BorderSizePixel = 0, AnchorPoint = Vector2.new(0.5, 0.5), Rotation = 45,
						Position = UDim2.fromOffset(math.random(10, 874), math.random(10, 300)), Size = UDim2.fromOffset(0, 0), ZIndex = 4}, sky)
					local big = math.random(5, 10)
					TweenService:Create(s, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.fromOffset(big, big)}):Play()
					task.delay(0.5, function() TweenService:Create(s, TweenInfo.new(0.5), {Size = UDim2.fromOffset(0, 0), BackgroundTransparency = 1}):Play() end)
					task.delay(1.1, function() s:Destroy() end)
				end
			end
			task.wait(0.05)
		end
	end)
	new("UICorner", {CornerRadius = UDim.new(0, 18)}, banner)
	local goldLine = new("UIStroke", {Thickness = 5, Color = WHITE, ApplyStrokeMode = Enum.ApplyStrokeMode.Border}, banner)
	new("UIGradient", {Rotation = 90, Color = ColorSequence.new({ColorSequenceKeypoint.new(0, rgb(255, 244, 170)), ColorSequenceKeypoint.new(0.5, rgb(255, 196, 60)), ColorSequenceKeypoint.new(1, rgb(196, 120, 20))})}, goldLine)

	-- l'œuf, à gauche, qui se balance doucement
	local rays = Portrait.rays(banner, rgb(255, 232, 150), 0.3, 4) -- éclat de lumière qui tourne derrière l'œuf
	rays.SizeConstraint = Enum.SizeConstraint.RelativeXY
	rays.Position, rays.Size = UDim2.fromOffset(130, 168), UDim2.fromOffset(340, 340)
	-- l'œuf en 3D (ReplicatedStorage.ShopSystem.FallenAngelShopEgg) : il tourne doucement sur lui-même et flotte
	local egg = new("ViewportFrame", {Name = "Egg", BackgroundTransparency = 1, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromOffset(130, 168),
		Size = UDim2.fromOffset(330, 330), Ambient = rgb(215, 208, 232), LightColor = WHITE, LightDirection = Vector3.new(-0.35, -0.6, -1), ZIndex = 5}, banner)
	-- le VRAI Fallen Angel Egg du jeu (EggModels.AngelEgg, sans son nid), avec un gros "?" doré posé sur sa face avant,
	-- et tourné de 15° vers la droite
	local function buildShopEgg()
		local real = eggSystem:WaitForChild("EggModels"):FindFirstChild(featured.Egg)
		if not real then return shopSystem:WaitForChild("FallenAngelShopEgg"):Clone() end
		local model = real:Clone()
		local nest = model:FindFirstChild("Nest")
		if nest then nest:Destroy() end
		for _, d in model:GetDescendants() do
			if d:IsA("BillboardGui") or d:IsA("ProximityPrompt") or d:IsA("Script") or d:IsA("LocalScript") then d:Destroy() end
		end
		-- la coquille : la plus grosse pièce (hors ailes / auréole)
		local shell
		for _, p in model:GetDescendants() do
			if p:IsA("BasePart") and p.Name ~= "Angel" and p.Name ~= "Root" and (not shell or p.Size.Magnitude > shell.Size.Magnitude) then shell = p end
		end
		-- le "?" : celui de l'œuf de la boutique (lettre jaune + contour noir en blocs), recentré et agrandi sur la coquille
		local q = {}
		for _, p in shopSystem:WaitForChild("FallenAngelShopEgg"):GetChildren() do
			if p:IsA("BasePart") and (p.Name == "Q" or p.Name == "QOutline") then table.insert(q, p) end
		end
		if shell and #q > 0 then
			local lo, hi = Vector3.new(math.huge, math.huge, math.huge), Vector3.new(-math.huge, -math.huge, -math.huge)
			for _, p in q do lo, hi = lo:Min(p.Position), hi:Max(p.Position) end
			local qCenter, qHeight = (lo + hi) / 2, math.max(hi.Y - lo.Y, 0.01)
			local k = shell.Size.Y * 0.5 / qHeight
			local front = shell.Position + Vector3.new(0, shell.Size.Y * 0.04, -shell.Size.Z * 0.5)
			for _, p in q do
				local c = p:Clone()
				for _, j in c:GetChildren() do if j:IsA("JointInstance") or j:IsA("WeldConstraint") then j:Destroy() end end
				c.Anchored = true
				c.Size = c.Size * k
				local rel = (p.Position - qCenter) * k
				-- les pièces du contour passent un tout petit peu derrière la lettre
				local depth = p.Name == "QOutline" and 0.02 or -0.06
				c.CFrame = CFrame.new(front + Vector3.new(rel.X, rel.Y, depth * shell.Size.Z)) * p.CFrame.Rotation
				if p.Name == "Q" then c.Material = Enum.Material.Neon c.Color = Color3.fromRGB(255, 214, 60) end
				c.Parent = model
			end
		end
		local center = (model:GetBoundingBox()).Position
		model:PivotTo(CFrame.new(center) * CFrame.Angles(0, math.rad(15), 0) * CFrame.new(-center) * model:GetPivot())
		return model
	end
	local eggModel = buildShopEgg()
	local eggCF, eggSize = eggModel:GetBoundingBox()
	local eggCenter = eggCF.Position
	eggModel.Parent = egg
	local eggCamera = new("Camera", {FieldOfView = 32}, egg)
	egg.CurrentCamera = eggCamera
	local distance = math.max(eggSize.X, eggSize.Y) / 2 / math.tan(math.rad(16)) * 0.82
	-- vue de face (le "?" est sur le côté -Z), fixe : l'œuf ne tourne pas, il monte un tout petit peu et redescend
	eggCamera.CFrame = CFrame.lookAt(eggCenter + Vector3.new(0, eggSize.Y * 0.04, -distance), eggCenter)
	banner.ClipsDescendants = true
	task.spawn(function()
		while egg.Parent do
			if main.Visible then
				local t = os.clock()
				local up = (math.sin(t * 1.8) + 1) / 2 -- 0 -> 1 -> 0 : il monte un peu puis revient à sa place
				egg.Position = UDim2.fromOffset(130, 172 - up * up * (3 - 2 * up) * 9)
				rays.Rotation = (t * 16) % 360
			end
			task.wait(0.03)
		end
	end)
	local tag = new("Frame", {Name = "New", BackgroundColor3 = WHITE, BorderSizePixel = 0, Rotation = -6, Position = UDim2.fromOffset(44, 34), Size = UDim2.fromOffset(118, 34), ZIndex = 8}, banner)
	new("UIGradient", {Rotation = 90, Color = ColorSequence.new(rgb(255, 80, 80), rgb(196, 14, 30))}, tag)
	new("UICorner", {CornerRadius = UDim.new(0, 8)}, tag)
	border(tag, 2, rgb(100, 6, 16))
	text(tag, {Text = "NEW!", Position = UDim2.fromScale(0.08, 0.1), Size = UDim2.fromScale(0.84, 0.8), ZIndex = 9}, 2.5)

	local title = text(banner, {Name = "Title", Text = featured.Title or eggInfo.Name, FontFace = SERIF, TextXAlignment = Enum.TextXAlignment.Left,
		Position = UDim2.fromOffset(280, 26), Size = UDim2.fromOffset(380, 52), ZIndex = 7}, 3.5)
	new("UIGradient", {Rotation = 90, Color = ColorSequence.new(rgb(255, 232, 150), rgb(214, 140, 30))}, title)
	text(banner, {Name = "Limited", Text = "Limited time!", TextXAlignment = Enum.TextXAlignment.Left, Position = UDim2.fromOffset(282, 82), Size = UDim2.fromOffset(260, 26), ZIndex = 7})
	timerLabel = text(banner, {Name = "Timer", Text = "", TextXAlignment = Enum.TextXAlignment.Right, AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -24, 0, 32), Size = UDim2.fromOffset(210, 30), ZIndex = 7})

	-- les animaux de l'œuf, du plus courant au plus rare : les cartes grandissent avec la rareté. Chaque carte a une bande sombre en
	-- bas, avec sa chance bien centrée.
	local pets = table.clone(eggInfo.Pets)
	table.sort(pets, function(a, b) return a.Chance > b.Chance end)
	local sizes = {72, 80, 90, 102, 116, 132}
	local gap = 10
	local x = 866
	for i = #pets, 1, -1 do x -= (sizes[i] or 100) + gap end
	x += gap
	local bottom = 304
	for i, entry in pets do
		local size = sizes[i] or 100
		local rare = i >= #pets - 1
		local card = new("Frame", {Name = entry.Pet, BackgroundColor3 = rgb(255, 255, 255), BackgroundTransparency = 0.25, BorderSizePixel = 0,
			Position = UDim2.fromOffset(x, bottom - size), Size = UDim2.fromOffset(size, size), ClipsDescendants = true, ZIndex = 6}, banner)
		new("UIGradient", {Rotation = 90, Color = ColorSequence.new(rgb(255, 255, 255), rare and rgb(255, 222, 140) or rgb(190, 220, 255))}, card)
		Portrait.rays(card, rare and rgb(255, 214, 90) or rgb(255, 255, 255), 0.35, 6)
		new("UICorner", {CornerRadius = UDim.new(0, 12)}, card)
		local stroke = border(card, rare and 3 or 2, rgb(200, 190, 255))
		stroke.Transparency = rare and 0 or 0.45
		if i == #pets then -- le plus rare : contour arc-en-ciel
			stroke.Color = WHITE
			local rainbow = new("UIGradient", {Color = ColorSequence.new({ColorSequenceKeypoint.new(0, rgb(255, 80, 80)), ColorSequenceKeypoint.new(0.25, rgb(255, 220, 70)),
				ColorSequenceKeypoint.new(0.5, rgb(90, 240, 120)), ColorSequenceKeypoint.new(0.75, rgb(80, 170, 255)), ColorSequenceKeypoint.new(1, rgb(210, 110, 255))})}, stroke)
			CollectionService:AddTag(rainbow, "AnimatedGradient") -- tourné par PetClient
		elseif i == #pets - 1 then
			stroke.Color = rgb(255, 196, 40)
		end
		local strip = math.floor(16 + size * 0.08)
		local view = new("ViewportFrame", {BackgroundTransparency = 1, Size = UDim2.new(1, 0, 1, -strip + 4), ZIndex = 6, Ambient = rgb(200, 200, 215), LightColor = WHITE, LightDirection = Vector3.new(-1, -1, -1)}, card)
		local petModel = Portrait.fill(view, petTemplates:FindFirstChild(entry.Pet))
		-- l'animal bouge dans sa photo comme en jeu (MeshAnimalClient) : os, ailes qui battent, auréole qui tourne.
		-- Il faut un WorldModel pour que les soudures et les os bougent dans un ViewportFrame.
		if petModel then
			local world = new("WorldModel", {}, view)
			petModel.Parent = world
			CollectionService:AddTag(petModel, "MeshAnimal")
		end
		local stripFrame = new("Frame", {Name = "Strip", BackgroundColor3 = BLACK, BackgroundTransparency = 0.4, BorderSizePixel = 0, AnchorPoint = Vector2.new(0, 1), Position = UDim2.fromScale(0, 1), Size = UDim2.new(1, 0, 0, strip), ZIndex = 7}, card)
		new("UICorner", {CornerRadius = UDim.new(0, 12)}, stripFrame)
		text(card, {Name = "Chance", Text = EggConfig.FormatChance(entry.Chance), TextColor3 = rare and rgb(255, 226, 90) or WHITE,
			AnchorPoint = Vector2.new(0.5, 1), Position = UDim2.new(0.5, 0, 1, -2), Size = UDim2.new(1, -8, 0, strip - 4), ZIndex = 8}, 2.5)
		x += size + gap
	end

	-- un bouton par lot (le plus gros à gauche), chacun avec son bouton cadeau. Dans le bouton : l'icône Robux et le prix, centrés
	-- ensemble sur une ligne, et le nombre d'œufs centré dessous.
	local count = #featured.Packs
	local slot = (884 - 44) / count
	for position = 1, count do
		local index = count - position + 1
		local pack = featured.Packs[index]
		local left = 22 + (position - 1) * slot
		local gift = fancyButton(banner, rgb(255, 150, 250), rgb(214, 50, 226), {Name = "Gift" .. index, Position = UDim2.fromOffset(left + 4, 320), Size = UDim2.fromOffset(52, 62), ZIndex = 8})
		new("ImageLabel", {BackgroundTransparency = 1, Image = ART.Gift, ScaleType = Enum.ScaleType.Fit, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.72, 0.72), ZIndex = 10}, gift)
		local buy = fancyButton(banner, rgb(190, 255, 60), rgb(60, 214, 40), {Name = "Buy" .. index, Position = UDim2.fromOffset(left + 64, 320), Size = UDim2.fromOffset(slot - 76, 62), ZIndex = 8})
		if position == 1 then -- le gros lot : en or
			buy.Fill.Color = ColorSequence.new(rgb(255, 238, 110), rgb(250, 164, 16))
			buy.UIStroke.Color = rgb(150, 86, 6)
		end
		local line = new("Frame", {Name = "PriceLine", BackgroundTransparency = 1, AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 5), Size = UDim2.new(1, -12, 0, 30), ZIndex = 10}, buy)
		new("UIListLayout", {FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, VerticalAlignment = Enum.VerticalAlignment.Center, Padding = UDim.new(0, 5), SortOrder = Enum.SortOrder.LayoutOrder}, line)
		text(line, {Name = "Robux", Text = utf8.char(0xE002), FontFace = Font.fromEnum(Enum.Font.GothamBold), Size = UDim2.fromOffset(28, 28), LayoutOrder = 1, ZIndex = 10})
		local packPrice = text(line, {Name = "Price", Text = tostring(pack.Robux), TextScaled = false, TextSize = 28, AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.fromOffset(0, 30), LayoutOrder = 2, ZIndex = 10}, 3)
		-- (packs d'œufs : prix affiché = pack.Robux de ShopConfig, 80 / 200 / 640 / 2800, pas le prix du Dashboard)
		text(buy, {Name = "Count", Text = pack.Count == 1 and "1 egg" or (pack.Count .. " eggs"), TextScaled = false, TextSize = 15, AnchorPoint = Vector2.new(0.5, 1), Position = UDim2.new(0.5, 0, 1, -7), Size = UDim2.new(1, -8, 0, 16), ZIndex = 11}, 2.5)
		buy.Activated:Connect(function() buyFeatured:FireServer(index, false) end)
		gift.Activated:Connect(function() shopSystem.OpenGift:Fire("Eggs" .. pack.Count) end) -- fenêtre cadeau (GiftClient)
		table.insert(packButtons, buy)
	end
end

---------------------------------------------------------------- packs de vitesse : bannière du gamepass Double Speed
-- une carte par pass speed (Double, x4, x8) : même modèle, couleurs de pass.Card (or par défaut)
local function speedCard(pass, order)
	if pass then
		-- toutes les cartes Speed : dégradé bleu glace -> bleu clair -> bleu foncé
		local colors = {rgb(225, 250, 255), rgb(110, 200, 255), rgb(22, 78, 196)}
		local card = new("Frame", {Name = pass.Key, BackgroundColor3 = WHITE, BorderSizePixel = 0, Size = UDim2.fromOffset(884, 214), LayoutOrder = order, ClipsDescendants = true, ZIndex = 3}, body)
		card:SetAttribute("SpeedCard", true)
		new("UIGradient", {Name = "Fill", Color = ColorSequence.new({ColorSequenceKeypoint.new(0, colors[1]), ColorSequenceKeypoint.new(0.35, colors[2]),
			ColorSequenceKeypoint.new(1, colors[3])})}, card)
		new("UICorner", {CornerRadius = UDim.new(0, 18)}, card)
		local cardLine = new("UIStroke", {Thickness = 5, Color = WHITE, ApplyStrokeMode = Enum.ApplyStrokeMode.Border}, card)
		new("UIGradient", {Rotation = 90, Color = ColorSequence.new(colors[1]:Lerp(WHITE, 0.4), colors[3]:Lerp(BLACK, 0.2))}, cardLine)
		-- le motif studs sur toute la carte (comme la carte VIP), teinté bleu glacé
		new("ImageLabel", {Name = "Studs", BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), Image = PATTERN, ScaleType = Enum.ScaleType.Tile,
			TileSize = UDim2.fromOffset(80, 80), ImageTransparency = 0.55, ImageColor3 = rgb(150, 215, 255), ZIndex = 3}, card)
		-- rayons de soleil blancs qui tournent derrière l'éclair
		local sun = Portrait.rays(card, rgb(255, 255, 230), 0.5, 4)
		sun.SizeConstraint = Enum.SizeConstraint.RelativeXY
		sun.Position, sun.Size = UDim2.fromOffset(150, 107), UDim2.fromOffset(420, 420)
		local glow = new("ImageLabel", {Name = "Glow", BackgroundTransparency = 1, Image = "rbxassetid://4509687978", ImageColor3 = rgb(255, 250, 210), ImageTransparency = 0.45,
			AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromOffset(150, 107), Size = UDim2.fromOffset(230, 230), ZIndex = 5}, card)
		-- pluie d'icônes derrière le texte, puis la même icône 2x plus grande en transparence, puis l'icône (immobile)
		local rain = new("Frame", {Name = "IconRain", BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), ClipsDescendants = true, ZIndex = 5}, card)
		new("ImageLabel", {Name = "IconBig", BackgroundTransparency = 1, Image = pass.Icon, ScaleType = Enum.ScaleType.Fit, AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.fromOffset(150, 107), Size = UDim2.fromOffset(360, 360), Rotation = -8, ImageTransparency = 0.65, ZIndex = 19}, card)
		new("ImageLabel", {Name = "Icon", BackgroundTransparency = 1, Image = pass.Icon, ScaleType = Enum.ScaleType.Fit, AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.fromOffset(150, 107), Size = UDim2.fromOffset(180, 180), Rotation = -8, ZIndex = 20}, card)
		local headline = text(card, {Name = "Title", Text = pass.Headline or "DOUBLE Your Speed", Position = UDim2.fromOffset(280, 14), Size = UDim2.fromOffset(560, 58), ZIndex = 7}, 4)
		local mult = new("Frame", {Name = "Mult", BackgroundTransparency = 1, Position = UDim2.fromOffset(280, 76), Size = UDim2.fromOffset(560, 62), ZIndex = 7}, card)
		new("UIListLayout", {FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, VerticalAlignment = Enum.VerticalAlignment.Center,
			Padding = UDim.new(0, 26), SortOrder = Enum.SortOrder.LayoutOrder}, mult)
		text(mult, {Name = "From", Text = pass.From or "x1", TextScaled = false, TextSize = 58, AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.fromOffset(0, 62), LayoutOrder = 1, ZIndex = 7}, 4)
		local arrow = text(mult, {Name = "Arrow", Text = "▶", TextScaled = false, TextSize = 58, Size = UDim2.fromOffset(60, 62), LayoutOrder = 2, ZIndex = 7}, 4)
		new("UIGradient", {Rotation = 90, Color = ColorSequence.new(WHITE, rgb(150, 220, 255))}, arrow)
		local to = text(mult, {Name = "To", Text = pass.To or "x2", TextScaled = false, TextSize = 64, AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.fromOffset(0, 62), LayoutOrder = 3, ZIndex = 7}, 4)
		new("UIGradient", {Rotation = 90, Color = ColorSequence.new(rgb(190, 255, 90), rgb(40, 210, 40))}, to)
		local gift = fancyButton(card, rgb(255, 150, 250), rgb(214, 50, 226), {Name = "Gift", Position = UDim2.fromOffset(392, 148), Size = UDim2.fromOffset(64, 54), ZIndex = 8})
		new("ImageLabel", {BackgroundTransparency = 1, Image = ART.Gift, ScaleType = Enum.ScaleType.Fit, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.72, 0.72), ZIndex = 10}, gift)
		local buy = fancyButton(card, rgb(190, 255, 60), rgb(60, 214, 40), {Name = "Buy", Position = UDim2.fromOffset(468, 148), Size = UDim2.fromOffset(300, 54), ZIndex = 8})
		local priceLine = new("Frame", {BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), ZIndex = 10}, buy)
		new("UIListLayout", {FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, VerticalAlignment = Enum.VerticalAlignment.Center, Padding = UDim.new(0, 6), SortOrder = Enum.SortOrder.LayoutOrder}, priceLine)
		local robux = text(priceLine, {Name = "Robux", Text = utf8.char(0xE002), FontFace = Font.fromEnum(Enum.Font.GothamBold), TextScaled = false, TextSize = 34, Size = UDim2.fromOffset(36, 40), LayoutOrder = 1, ZIndex = 10})
		local price = text(priceLine, {Name = "Price", Text = tostring(pass.Price), TextScaled = false, TextSize = 36, AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.fromOffset(0, 40), LayoutOrder = 2, ZIndex = 10}, 3)
		-- le bouton montre toujours le prix et ouvre toujours l'achat ; un petit badge "OWNED" s'affiche au-dessus si on l'a déjà
		local ownedTag = text(card, {Name = "Owned", Text = "✔ OWNED", Visible = false, TextColor3 = rgb(120, 255, 120), Position = UDim2.fromOffset(620, 118), Size = UDim2.fromOffset(150, 24), ZIndex = 9}, 3)
		ownedTag.Visible = false
		local fromLabel = mult:FindFirstChild("From")
		local arrowLabel = mult:FindFirstChild("Arrow")
		local function refreshSpeedPass()
			-- acheté : bouton bleu "OWNED", et seulement "x2" (plus de "x1 ▶ x2")
			local owned = ShopConfig.HasPass(player, pass.Key)
			robux.Visible = not owned
			price.Text = owned and "OWNED" or tostring(pass.Price)
			buy.Fill.Color = owned and ColorSequence.new(rgb(140, 220, 255), rgb(50, 130, 236)) or ColorSequence.new(rgb(190, 255, 60), rgb(60, 214, 40))
			if fromLabel then fromLabel.Visible = not owned end
			if arrowLabel then arrowLabel.Visible = not owned end
		end
		player:GetAttributeChangedSignal("Pass_" .. pass.Key):Connect(refreshSpeedPass)
		refreshSpeedPass()
		buy.Activated:Connect(function()
			if not ShopConfig.HasPass(player, pass.Key) then MarketplaceService:PromptGamePassPurchase(player, pass.Id) end
		end)
		gift.Activated:Connect(function() shopSystem.OpenGift:Fire(pass.Key) end) -- fenêtre cadeau (GiftClient)
		-- les rayons tournent, des petits éclairs tombent en tournant (l'éclair, lui, ne bouge pas)
		local nextDrop = 0
		task.spawn(function()
			while card.Parent do
				if main.Visible and card.Visible then
					local t = os.clock()
					sun.Rotation = (t * 22) % 360
					glow.ImageTransparency = 0.5 + 0.15 * math.sin(t * 3)
					if t > nextDrop then
						nextDrop = t + 0.12 + math.random() * 0.14
						local size = math.random(48, 100) -- (2x plus gros)
						local x = math.random(0, 884)
						local drop = new("ImageLabel", {BackgroundTransparency = 1, Image = pass.Icon, ScaleType = Enum.ScaleType.Fit, AnchorPoint = Vector2.new(0.5, 0.5),
							Position = UDim2.fromOffset(x, -40), Size = UDim2.fromOffset(size, size), Rotation = math.random(-40, 40), ImageTransparency = 0.05, ZIndex = 5}, rain)
						local fall = 3 + math.random() * 3
						TweenService:Create(drop, TweenInfo.new(fall, Enum.EasingStyle.Linear), {Position = UDim2.fromOffset(x + math.random(-60, 60), 260),
							Rotation = drop.Rotation + math.random(-200, 200), ImageTransparency = 0.55}):Play()
						task.delay(fall, function() drop:Destroy() end)
					end
				end
				task.wait(0.03)
			end
		end)
	end
end
do
	local speedTitle = sectionTitle("Speed Packs", 3)
	speedTitle:FindFirstChildOfClass("UIGradient").Color = ColorSequence.new(rgb(120, 230, 255), rgb(30, 140, 255))
	-- UNE seule carte à la fois : x2, puis (x2 acheté) x4, puis (x4 acheté) x8 ; tout acheté : x8 "OWNED"
	local chain = {"DoubleSpeed", "QuadSpeed", "OctoSpeed"}
	for i, key in chain do speedCard(ShopConfig.GetPass(key), 4) end
	local function showNext()
		local current = chain[#chain]
		for _, key in chain do
			if not ShopConfig.HasPass(player, key) then current = key break end
		end
		for _, key in chain do
			local c = body:FindFirstChild(key)
			if c then c.Visible = key == current end
		end
	end
	for _, key in chain do player:GetAttributeChangedSignal("Pass_" .. key):Connect(showNext) end
	showNext()
end

---------------------------------------------------------------- VIP : bannière jaune, motif studs partout, grosse couronne avec rayons, couronnes qui tombent
do
	local vip = ShopConfig.GetPass("VIP")
	if vip and (vip.Id or 0) > 0 then
		local vipTitle = sectionTitle("VIP", 5)
		vipTitle:FindFirstChildOfClass("UIGradient").Color = ColorSequence.new(rgb(255, 250, 150), rgb(255, 170, 20))
		local card = new("Frame", {Name = "VipCard", BackgroundColor3 = WHITE, BorderSizePixel = 0, Size = UDim2.fromOffset(884, 214), LayoutOrder = 6, ClipsDescendants = true, ZIndex = 3}, body)
		card:SetAttribute("SpeedCard", true) -- (même reflet que les cartes de vitesse)
		new("UIGradient", {Name = "Fill", Rotation = 25, Color = ColorSequence.new({ColorSequenceKeypoint.new(0, rgb(255, 246, 140)), ColorSequenceKeypoint.new(0.4, rgb(255, 206, 40)),
			ColorSequenceKeypoint.new(1, rgb(255, 150, 16))})}, card)
		new("UICorner", {CornerRadius = UDim.new(0, 18)}, card)
		local line = new("UIStroke", {Thickness = 5, Color = WHITE, ApplyStrokeMode = Enum.ApplyStrokeMode.Border}, card)
		new("UIGradient", {Rotation = 90, Color = ColorSequence.new(rgb(255, 250, 200), rgb(200, 110, 10))}, line)
		-- le motif studs sur toute la carte
		new("ImageLabel", {Name = "Studs", BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), Image = PATTERN, ScaleType = Enum.ScaleType.Tile,
			TileSize = UDim2.fromOffset(80, 80), ImageTransparency = 0.55, ImageColor3 = rgb(255, 214, 90), ZIndex = 3}, card)
		-- rayons de soleil derrière la couronne
		local sun = Portrait.rays(card, rgb(255, 255, 240), 0.12, 4)
		sun.SizeConstraint = Enum.SizeConstraint.RelativeXY
		sun.Position, sun.Size = UDim2.fromOffset(150, 107), UDim2.fromOffset(480, 480)
		-- les petites couronnes qui tombent en tournant (derrière le texte)
		local rain = new("Frame", {Name = "CrownRain", BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), ClipsDescendants = true, ZIndex = 5}, card)
		local glow = new("ImageLabel", {Name = "Glow", BackgroundTransparency = 1, Image = "rbxassetid://4509687978", ImageColor3 = rgb(255, 250, 200), ImageTransparency = 0.4,
			AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromOffset(150, 107), Size = UDim2.fromOffset(250, 250), ZIndex = 6}, card)
		-- la même icône, 1,5x plus grande, posée au même endroit (en transparence, derrière), puis l'icône : rien ne bouge
		new("ImageLabel", {Name = "IconBig", BackgroundTransparency = 1, Image = vip.Icon, ScaleType = Enum.ScaleType.Fit, AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.fromOffset(150, 107), Size = UDim2.fromOffset(285, 285), ImageTransparency = 0.6, ZIndex = 19}, card)
		new("ImageLabel", {Name = "Icon", BackgroundTransparency = 1, Image = vip.Icon, ScaleType = Enum.ScaleType.Fit, AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.fromOffset(150, 107), Size = UDim2.fromOffset(190, 190), ZIndex = 20}, card)
		local title = text(card, {Name = "Title", Text = "VIP PASS", TextXAlignment = Enum.TextXAlignment.Left, Position = UDim2.fromOffset(292, 16), Size = UDim2.fromOffset(420, 66), ZIndex = 9}, 4.5)
		new("UIGradient", {Rotation = 90, Color = ColorSequence.new({ColorSequenceKeypoint.new(0, rgb(255, 255, 200)), ColorSequenceKeypoint.new(0.5, rgb(255, 230, 60)), ColorSequenceKeypoint.new(1, rgb(255, 160, 20))})}, title)
		-- les avantages : Name Tag (arc-en-ciel qui défile) et 2x Cash (rouge -> rose)
		local perks = vip.Perks or {"Name Tag", "2x Cash"}
		local perkColors = {
			ColorSequence.new({ColorSequenceKeypoint.new(0, rgb(255, 90, 90)), ColorSequenceKeypoint.new(0.25, rgb(255, 210, 60)), ColorSequenceKeypoint.new(0.5, rgb(90, 240, 120)),
				ColorSequenceKeypoint.new(0.75, rgb(80, 170, 255)), ColorSequenceKeypoint.new(1, rgb(220, 110, 255))}),
			ColorSequence.new({ColorSequenceKeypoint.new(0, rgb(255, 60, 60)), ColorSequenceKeypoint.new(0.5, rgb(255, 120, 200)), ColorSequenceKeypoint.new(1, rgb(255, 60, 60))}),
		}
		local perkGradients = {}
		for i, perk in perks do
			local l = text(card, {Name = "Perk" .. i, Text = perk, TextXAlignment = Enum.TextXAlignment.Left, Position = UDim2.fromOffset(296, 84 + (i - 1) * 44), Size = UDim2.fromOffset(300, 40), ZIndex = 9}, 3.5)
			perkGradients[i] = new("UIGradient", {Color = perkColors[i] or perkColors[1]}, l)
		end
		-- acheter : bouton vert avec le prix du Dashboard ; acheté = bleu "OWNED"
		local buy = fancyButton(card, rgb(190, 255, 60), rgb(60, 214, 40), {Name = "Buy", AnchorPoint = Vector2.new(1, 1), Position = UDim2.new(1, -22, 1, -22), Size = UDim2.fromOffset(250, 70), ZIndex = 10})
		local priceLine = new("Frame", {BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), ZIndex = 12}, buy)
		new("UIListLayout", {FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, VerticalAlignment = Enum.VerticalAlignment.Center, Padding = UDim.new(0, 8), SortOrder = Enum.SortOrder.LayoutOrder}, priceLine)
		local robux = text(priceLine, {Name = "Robux", Text = utf8.char(0xE002), FontFace = Font.fromEnum(Enum.Font.GothamBold), TextScaled = false, TextSize = 40, Size = UDim2.fromOffset(42, 46), LayoutOrder = 1, ZIndex = 12})
		local price = text(priceLine, {Name = "Price", Text = tostring(vip.Price), TextScaled = false, TextSize = 44, AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.fromOffset(0, 46), LayoutOrder = 2, ZIndex = 12}, 3.5)
		local livePriceValue = vip.Price
		livePrice(vip.Id, false, function(p) livePriceValue = p if not ShopConfig.HasPass(player, "VIP") then price.Text = tostring(p) end end)
		local function refreshVip()
			local owned = ShopConfig.HasPass(player, "VIP")
			robux.Visible = not owned
			price.Text = owned and "OWNED" or tostring(livePriceValue)
			buy.Fill.Color = owned and ColorSequence.new(rgb(140, 220, 255), rgb(50, 130, 236)) or ColorSequence.new(rgb(190, 255, 60), rgb(60, 214, 40))
		end
		player:GetAttributeChangedSignal("Pass_VIP"):Connect(refreshVip)
		refreshVip()
		buy.Activated:Connect(function()
			if not ShopConfig.HasPass(player, "VIP") then MarketplaceService:PromptGamePassPurchase(player, vip.Id) end
		end)
		-- animation : rayons qui tournent, dégradés des avantages qui défilent, pluie d'icônes (l'icône, elle, ne bouge pas)
		local nextDrop = 0
		task.spawn(function()
			while card.Parent do
				if main.Visible then
					local t = os.clock()
					sun.Rotation = (t * 18) % 360
					glow.ImageTransparency = 0.45 + 0.15 * math.sin(t * 3)
					for i, g in perkGradients do g.Offset = Vector2.new(math.sin(t * 1.2 + i) * 0.35, 0) end
					if t > nextDrop then
						nextDrop = t + 0.12 + math.random() * 0.14
						local size = math.random(26, 54)
						local x = math.random(0, 884)
						local drop = new("ImageLabel", {BackgroundTransparency = 1, Image = vip.Icon, ScaleType = Enum.ScaleType.Fit, AnchorPoint = Vector2.new(0.5, 0.5),
							Position = UDim2.fromOffset(x, -40), Size = UDim2.fromOffset(size, size), Rotation = math.random(-40, 40), ImageTransparency = 0.05, ZIndex = 5}, rain)
						local fall = 3 + math.random() * 3
						TweenService:Create(drop, TweenInfo.new(fall, Enum.EasingStyle.Linear), {Position = UDim2.fromOffset(x + math.random(-60, 60), 260),
							Rotation = drop.Rotation + math.random(-200, 200), ImageTransparency = 0.55}):Play()
						task.delay(fall, function() drop:Destroy() end)
					end
				end
				task.wait(0.03)
			end
		end)
	end
end

---------------------------------------------------------------- game passes
-- (les passes pas encore créés, Id = 0 : VIP, 2x Mutation Luck... ne sont plus affichés du tout, ni la section s'il n'en reste aucun)
local listed = false
for _, pass in ShopConfig.Passes do
	if not pass.Featured and (pass.Id or 0) > 0 then listed = true end
end
if listed then sectionTitle("Game Passes", 7) end
for order, pass in ShopConfig.Passes do
	if pass.Featured then continue end -- (a sa propre bannière plus haut)
	if (pass.Id or 0) == 0 then continue end -- pas encore en vente : pas de ligne "Soon"
	local row = rowTemplate:Clone()
	row.Name = pass.Key
	row.LayoutOrder = 10 + order
	row.Size = UDim2.new(1, -24, 0, 92)
	row.PassName.Text = pass.Name
	row.Description.Text = pass.Description
	local icon = script.Icons:FindFirstChild(pass.Key)
	row.Badge.Text.Visible = icon == nil
	row.Badge.Text.Text = pass.Badge
	if icon then icon:Clone().Parent = row.Badge end

	local function refresh()
		local owned = ShopConfig.HasPass(player, pass.Key)
		row.Buy.Text = owned and "OWNED" or pass.Id > 0 and ("R$ " .. pass.Price) or ("Soon · R$ " .. pass.Price)
		row.Buy.Shade.Color = owned and OWNED_GRADIENT or pass.Id > 0 and BUY_GRADIENT or SOON_GRADIENT
	end
	player:GetAttributeChangedSignal("Pass_" .. pass.Key):Connect(refresh)
	refresh()

	row.Buy.Activated:Connect(function()
		if pass.Id > 0 and not ShopConfig.HasPass(player, pass.Key) then
			MarketplaceService:PromptGamePassPurchase(player, pass.Id)
		end
	end)
	row.Parent = body
end

openButton.Activated:Connect(function() main.Visible = not main.Visible end)

---------------------------------------------------------------- effets de toute la boutique
-- GLEAM : un reflet blanc en biais traverse régulièrement les boutons, bannières et l'en-tête (calque transparent, mêmes coins arrondis).
-- CONTOURS : chaque contour de cadre reçoit un dégradé clair / sombre de sa couleur, qui tourne lentement : il scintille.
local gleams, strokes = {}, {}
local GLEAM_BAND = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.42, 1), NumberSequenceKeypoint.new(0.5, 0.45),
	NumberSequenceKeypoint.new(0.58, 1), NumberSequenceKeypoint.new(1, 1)})
local function addGleam(o, phase)
	if o:FindFirstChild("Gleam") then return end
	local layer = new("Frame", {Name = "Gleam", BackgroundColor3 = WHITE, BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), ZIndex = o.ZIndex + 1, Active = false}, o)
	local corner = o:FindFirstChildOfClass("UICorner")
	if corner then new("UICorner", {CornerRadius = corner.CornerRadius}, layer) end
	local g = new("UIGradient", {Rotation = 20, Transparency = GLEAM_BAND, Offset = Vector2.new(-1, 0)}, layer)
	table.insert(gleams, {Gradient = g, Phase = phase})
end
local function addStrokeShimmer(stroke, phase)
	if stroke:FindFirstChildOfClass("UIGradient") then return end -- déjà un dégradé (or, arc-en-ciel...) : on le fait tourner aussi
	local c = stroke.Color
	local light, dark = c:Lerp(WHITE, 0.55), c:Lerp(BLACK, 0.15)
	local g = new("UIGradient", {Color = ColorSequence.new({ColorSequenceKeypoint.new(0, dark), ColorSequenceKeypoint.new(0.45, dark), ColorSequenceKeypoint.new(0.5, light),
		ColorSequenceKeypoint.new(0.55, dark), ColorSequenceKeypoint.new(1, dark)})}, stroke)
	stroke.Color = WHITE -- (le dégradé colore le contour)
	table.insert(strokes, {Gradient = g, Phase = phase})
end
local function decorate()
	local n = 0
	for _, d in main:GetDescendants() do
		n += 1
		if d:IsA("UIStroke") and d.ApplyStrokeMode == Enum.ApplyStrokeMode.Border and d.Thickness >= 2 and d.Parent and d.Parent:IsA("GuiObject") and d.Transparency < 0.5 then
			if d:FindFirstChildOfClass("UIGradient") then
				table.insert(strokes, {Gradient = d:FindFirstChildOfClass("UIGradient"), Phase = n * 0.37, Spin = true})
			else
				addStrokeShimmer(d, n * 0.37)
			end
		end
		if (d:IsA("GuiButton") and d:FindFirstChild("Fill")) or d.Name == "Featured" or d:GetAttribute("SpeedCard") or d.Name == "Header" then
			addGleam(d, n * 0.29)
		end
	end
end
decorate()
local PERIOD, SWEEP = 3.2, 0.9 -- un reflet toutes les 3,2 s, qui traverse en 0,9 s
task.spawn(function()
	while true do
		if main.Visible then
			local t = os.clock()
			for _, gl in gleams do
				local k = ((t + gl.Phase) % PERIOD) / SWEEP
				gl.Gradient.Offset = Vector2.new(k <= 1 and (-1.1 + k * 2.2) or 1.2, 0)
			end
			for _, st in strokes do st.Gradient.Rotation = (t * 70 + st.Phase * 60) % 360 end
		end
		task.wait(0.03)
	end
end)

-- compte à rebours de l'œuf en vedette : "12d 3h 19m 42s"
if timerLabel then
	task.spawn(function()
		while true do
			local left = math.max(0, (featured.EndsAt or 0) - os.time())
			if left <= 0 then
				timerLabel.Text = "Ended"
			else
				local d, h, m, s = left // 86400, left % 86400 // 3600, left % 3600 // 60, left % 60
				timerLabel.Text = (d > 0 and (d .. "d ") or "") .. h .. "h " .. m .. "m " .. s .. "s"
			end
			for _, b in packButtons do b.Active = left > 0 end
			task.wait(1)
		end
	end)
end

-- VIP tag in chat
TextChatService.OnIncomingMessage = function(message)
	local source = message.TextSource
	local sender = source and Players:GetPlayerByUserId(source.UserId)
	if sender and ShopConfig.HasPass(sender, "VIP") then
		local properties = Instance.new("TextChatMessageProperties")
		properties.PrefixText = "<font color='#FFC83C'>[VIP]</font> " .. message.PrefixText
		return properties
	end
	return nil
end
