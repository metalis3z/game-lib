-- Shop window (Shop button on the left): the featured egg banner (ShopConfig.Featured) on top, then the game passes.
-- Banner: egg art, title, countdown, the six animals with their chances, and one buy button per pack (with a gift button).
local Players = game:GetService("Players")
local MarketplaceService = game:GetService("MarketplaceService")
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
local ART = {Egg = "rbxassetid://119221572901822", Banner = "rbxassetid://138079645273228", Frame = "rbxassetid://125092856491930", Gift = "rbxassetid://98725504330944"}
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
	border(b, 3)
	local inner = new("Frame", {Name = "Inner", BackgroundTransparency = 1, Position = UDim2.fromOffset(3, 3), Size = UDim2.new(1, -6, 1, -6), ZIndex = b.ZIndex}, b)
	border(inner, 2, bottom:Lerp(BLACK, 0.4))
	studs(b, 0.74, 26)
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
outline.Thickness, outline.Color = 4, BLACK
studs(main, 0.88, 34)

local header = new("Frame", {Name = "Header", BackgroundColor3 = WHITE, BorderSizePixel = 0, Position = UDim2.fromOffset(6, 6), Size = UDim2.new(1, -12, 0, 78), ClipsDescendants = true, ZIndex = 2}, main)
new("UIGradient", {Color = ColorSequence.new(rgb(196, 255, 44), rgb(74, 228, 30))}, header)
border(header, 3)
studs(header, 0.8)
for i = 0, 2 do -- reflets en biais
	new("Frame", {BackgroundColor3 = WHITE, BackgroundTransparency = 0.72, BorderSizePixel = 0, Rotation = 24, Position = UDim2.new(0.5 + i * 0.085, 0, -0.6, 0), Size = UDim2.new(0.035 + i * 0.012, 0, 2.2, 0), ZIndex = 2}, header)
end
text(header, {Name = "Title", Text = "Shop", TextXAlignment = Enum.TextXAlignment.Left, Position = UDim2.fromOffset(22, 10), Size = UDim2.new(1, -130, 1, -20), ZIndex = 4}, 4)
local close = new("TextButton", {Name = "Close", Text = "X", FontFace = FONT, TextSize = 42, TextColor3 = WHITE, BackgroundColor3 = WHITE, BorderSizePixel = 0,
	AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -8, 0.5, 0), Size = UDim2.fromOffset(66, 60), ZIndex = 5}, header)
new("UIGradient", {Rotation = 90, Color = ColorSequence.new(rgb(255, 70, 70), rgb(190, 14, 30))}, close)
border(close, 3)
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
	new("ImageLabel", {Name = "Background", BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), Image = ART.Banner, ScaleType = Enum.ScaleType.Crop, ZIndex = 3}, banner)
	new("ImageLabel", {Name = "GoldFrame", BackgroundTransparency = 1, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(884 + 32, 408 + 32),
		Image = ART.Frame, ScaleType = Enum.ScaleType.Slice, SliceCenter = Rect.new(84, 84, 172, 172), SliceScale = 0.62, ZIndex = 12}, holder)

	-- l'œuf, à gauche, qui se balance doucement
	local rays = Portrait.rays(banner, rgb(255, 232, 150), 0.3, 4) -- éclat de lumière qui tourne derrière l'œuf
	rays.SizeConstraint = Enum.SizeConstraint.RelativeXY
	rays.Position, rays.Size = UDim2.fromOffset(140, 176), UDim2.fromOffset(380, 380)
	local egg = new("ImageLabel", {Name = "Egg", BackgroundTransparency = 1, Image = ART.Egg, ScaleType = Enum.ScaleType.Fit, AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromOffset(140, 176), Size = UDim2.fromOffset(290, 290), ZIndex = 5}, banner)
	banner.ClipsDescendants = true
	task.spawn(function()
		while egg.Parent do
			if main.Visible then
				local t = os.clock()
				egg.Rotation = math.sin(t * 1.6) * 4
				egg.Position = UDim2.fromOffset(140, 176 + math.sin(t * 2.2) * 5) -- il flotte
				rays.Rotation = (t * 16) % 360
			end
			task.wait(0.03)
		end
	end)
	local tag = new("Frame", {Name = "New", BackgroundColor3 = WHITE, BorderSizePixel = 0, Rotation = -6, Position = UDim2.fromOffset(44, 34), Size = UDim2.fromOffset(118, 34), ZIndex = 8}, banner)
	new("UIGradient", {Rotation = 90, Color = ColorSequence.new(rgb(255, 80, 80), rgb(196, 14, 30))}, tag)
	border(tag, 3)
	text(tag, {Text = "NEW!", Position = UDim2.fromScale(0.08, 0.1), Size = UDim2.fromScale(0.84, 0.8), ZIndex = 9}, 2.5)

	local title = text(banner, {Name = "Title", Text = featured.Title or eggInfo.Name, FontFace = SERIF, TextXAlignment = Enum.TextXAlignment.Left,
		Position = UDim2.fromOffset(262, 28), Size = UDim2.fromOffset(372, 52), ZIndex = 7}, 3.5)
	new("UIGradient", {Rotation = 90, Color = ColorSequence.new(rgb(255, 232, 150), rgb(214, 140, 30))}, title)
	text(banner, {Name = "Limited", Text = "Limited time!", TextXAlignment = Enum.TextXAlignment.Left, Position = UDim2.fromOffset(264, 84), Size = UDim2.fromOffset(260, 28), ZIndex = 7})
	timerLabel = text(banner, {Name = "Timer", Text = "", TextXAlignment = Enum.TextXAlignment.Right, AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -24, 0, 32), Size = UDim2.fromOffset(210, 30), ZIndex = 7})

	-- les animaux de l'œuf, du plus courant au plus rare : les cartes grandissent avec la rareté
	local pets = table.clone(eggInfo.Pets)
	table.sort(pets, function(a, b) return a.Chance > b.Chance end)
	local sizes = {86, 94, 104, 118, 134, 150}
	local x = 874
	for i = #pets, 1, -1 do x -= (sizes[i] or 100) + 8 end
	local bottom = 316
	for i, entry in pets do
		local size = sizes[i] or 100
		local card = new("Frame", {Name = entry.Pet, BackgroundColor3 = rgb(24, 20, 40), BackgroundTransparency = 0.2, BorderSizePixel = 0,
			Position = UDim2.fromOffset(x, bottom - size), Size = UDim2.fromOffset(size, size), ClipsDescendants = true, ZIndex = 6}, banner)
		Portrait.rays(card, i >= #pets - 1 and rgb(255, 226, 120) or rgb(196, 186, 255), 0.6, 6)
		local stroke = border(card, i >= #pets - 1 and 4 or 3)
		if i == #pets then -- le plus rare : contour arc-en-ciel
			stroke.Color = WHITE
			local rainbow = new("UIGradient", {Color = ColorSequence.new({ColorSequenceKeypoint.new(0, rgb(255, 80, 80)), ColorSequenceKeypoint.new(0.25, rgb(255, 220, 70)),
				ColorSequenceKeypoint.new(0.5, rgb(90, 240, 120)), ColorSequenceKeypoint.new(0.75, rgb(80, 170, 255)), ColorSequenceKeypoint.new(1, rgb(210, 110, 255))})}, stroke)
			CollectionService:AddTag(rainbow, "AnimatedGradient") -- tourné par PetClient
		elseif i == #pets - 1 then
			stroke.Color = rgb(255, 196, 40)
		end
		local view = new("ViewportFrame", {BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), ZIndex = 6, Ambient = rgb(200, 200, 215), LightColor = WHITE, LightDirection = Vector3.new(-1, -1, -1)}, card)
		Portrait.fill(view, petTemplates:FindFirstChild(entry.Pet))
		text(card, {Text = EggConfig.FormatChance(entry.Chance), TextColor3 = i >= #pets - 1 and rgb(255, 226, 90) or WHITE, TextXAlignment = Enum.TextXAlignment.Right,
			AnchorPoint = Vector2.new(1, 1), Position = UDim2.new(1, -4, 1, -2), Size = UDim2.new(0.8, 0, 0, 14 + size * 0.07), ZIndex = 8}, 2.5)
		x += size + 8
	end

	-- un bouton par lot (le plus gros à gauche), chacun avec son bouton cadeau
	local count = #featured.Packs
	local slot = (884 - 36) / count
	for position = 1, count do
		local index = count - position + 1
		local pack = featured.Packs[index]
		local left = 18 + (position - 1) * slot
		local gift = fancyButton(banner, rgb(255, 150, 250), rgb(214, 50, 226), {Name = "Gift" .. index, Position = UDim2.fromOffset(left + 6, 328), Size = UDim2.fromOffset(46, 46), ZIndex = 8})
		new("ImageLabel", {BackgroundTransparency = 1, Image = ART.Gift, ScaleType = Enum.ScaleType.Fit, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.74, 0.74), ZIndex = 10}, gift)
		local buy = fancyButton(banner, rgb(190, 255, 60), rgb(60, 214, 40), {Name = "Buy" .. index, Position = UDim2.fromOffset(left + 58, 328), Size = UDim2.fromOffset(slot - 72, 46), ZIndex = 8})
		if position == 1 then -- le gros lot : dégradé rouge sombre -> vert
			buy.Fill.Rotation = 0
			buy.Fill.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, rgb(200, 30, 60)), ColorSequenceKeypoint.new(0.55, rgb(150, 150, 40)), ColorSequenceKeypoint.new(1, rgb(80, 214, 40))})
		end
		text(buy, {Text = utf8.char(0xE002), FontFace = Font.fromEnum(Enum.Font.GothamBold), AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(0.42, 0, 0, 3), Size = UDim2.fromOffset(30, 28), ZIndex = 10})
		text(buy, {Name = "Price", Text = tostring(pack.Robux), TextXAlignment = Enum.TextXAlignment.Left, Position = UDim2.new(0.42, 4, 0, 1), Size = UDim2.new(0.58, -8, 0, 32), ZIndex = 10}, 3)
		text(buy, {Name = "Count", Text = pack.Count == 1 and "1 Egg" or (pack.Count .. " eggs"), TextScaled = false, TextSize = 15, AnchorPoint = Vector2.new(0.5, 1), Position = UDim2.new(0.5, 0, 1, 7), Size = UDim2.new(1, 0, 0, 18), ZIndex = 11}, 2.5)
		buy.Activated:Connect(function() buyFeatured:FireServer(index, false) end)
		gift.Activated:Connect(function() buyFeatured:FireServer(index, true) end)
		table.insert(packButtons, buy)
	end
end

---------------------------------------------------------------- game passes
sectionTitle("Game Passes", 3)
for order, pass in ShopConfig.Passes do
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
