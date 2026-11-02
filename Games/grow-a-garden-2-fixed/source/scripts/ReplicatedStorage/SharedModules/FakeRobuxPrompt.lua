--credit to quartz games studio
--[[
	FakeRobuxPrompt  (cliente)
	--------------------------------------------------------------------
	Réplica del prompt de compra NATIVO de Roblox (tema oscuro) para la
	moneda interna "Fake Robux". Dos pantallas:

	1) COMPRA: tarjeta oscura. Arriba "Buy item" (izq) | ícono Robux + TU
	   saldo + X (der). Fila: imagen del ítem (o placeholder gris) + nombre +
	   precio. Botón azul "Buy" cuya barra brillante SE RELLENA al APARECER la
	   GUI (~1.2s). Al tocar "Buy": carga un poco y pasa a la pantalla 2.
	2) COMPLETADA: "Compra completada" + ✓ + "Compraste X con éxito." + botón
	   azul "Aceptar". Aceptar o la X cierran (confirman la compra).

	NO cobra nada por sí mismo: sólo devuelve la elección (true = compró). El
	cobro/entrega los hace el servidor (DevProductService).
]]

local Players            = game:GetService("Players")
local MarketplaceService = game:GetService("MarketplaceService")
local TweenService       = game:GetService("TweenService")

local LocalPlayer = Players.LocalPlayer

local ROBUX_ICON = "rbxasset://textures/ui/common/robux.png"
local FILL_TIME  = 1.2   -- rellenado al aparecer (segundos)
local BUY_LOAD   = 0.5   -- "carga un poco" al tocar Buy (segundos)

local C = {
	card        = Color3.fromRGB(24, 26, 33),
	text        = Color3.fromRGB(255, 255, 255),
	subtle      = Color3.fromRGB(170, 175, 185),
	placeholder = Color3.fromRGB(58, 61, 72),
	buyBase     = Color3.fromRGB(44, 62, 145),
	buyFill     = Color3.fromRGB(62, 93, 255),
	accept      = Color3.fromRGB(83, 109, 254),
	buyOff      = Color3.fromRGB(80, 84, 96),
}

local M = {}

----------------------------------------------------------------------
-- Utilidades
----------------------------------------------------------------------
local function comma(n)
	n = math.floor(tonumber(n) or 0)
	local s = tostring(n)
	local out = s:reverse():gsub("(%d%d%d)", "%1,"):reverse()
	return (out:gsub("^,", ""))
end

local infoCache = {}
local function getInfo(kind, id)
	local cacheKey = tostring(kind) .. ":" .. tostring(id)
	if infoCache[cacheKey] then
		return infoCache[cacheKey]
	end
	local infoType = (kind == "Gamepass") and Enum.InfoType.GamePass or Enum.InfoType.Product
	local result = { name = nil, price = 0, image = nil }
	if type(id) == "number" then
		local ok, info = pcall(function()
			return MarketplaceService:GetProductInfo(id, infoType)
		end)
		if ok and type(info) == "table" then
			result.name = info.Name
			result.price = tonumber(info.PriceInRobux) or 0
			if type(info.IconImageAssetId) == "number" and info.IconImageAssetId > 0 then
				result.image = "rbxassetid://" .. info.IconImageAssetId
			end
		end
	end
	infoCache[cacheKey] = result
	return result
end

local function getFakeRobux()
	local nv = LocalPlayer:FindFirstChild("FakeRobux")
	return nv and nv.Value or 0
end

----------------------------------------------------------------------
-- Construcción de la GUI (una sola vez, se reusa)
----------------------------------------------------------------------
local gui

local function build()
	if gui then
		return gui
	end

	local screen = Instance.new("ScreenGui")
	screen.Name = "FakeRobuxPrompt"
	screen.ResetOnSpawn = false
	screen.IgnoreGuiInset = true
	screen.DisplayOrder = 1000
	screen.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	screen.Enabled = false
	screen.Parent = LocalPlayer:WaitForChild("PlayerGui")

	local shade = Instance.new("TextButton")
	shade.Name = "Shade"
	shade.Text = ""
	shade.AutoButtonColor = false
	shade.Size = UDim2.fromScale(1, 1)
	shade.BackgroundColor3 = Color3.new(0, 0, 0)
	shade.BackgroundTransparency = 1
	shade.BorderSizePixel = 0
	shade.ZIndex = 1
	shade.Parent = screen

	local card = Instance.new("Frame")
	card.Name = "Card"
	card.AnchorPoint = Vector2.new(0.5, 0.5)
	card.Position = UDim2.fromScale(0.5, 0.5)
	card.Size = UDim2.fromOffset(440, 215)
	card.BackgroundColor3 = C.card
	card.BorderSizePixel = 0
	card.ZIndex = 2
	card.Parent = screen
	Instance.new("UICorner", card).CornerRadius = UDim.new(0, 16)

	local pad = Instance.new("UIPadding", card)
	pad.PaddingTop = UDim.new(0, 18)
	pad.PaddingBottom = UDim.new(0, 18)
	pad.PaddingLeft = UDim.new(0, 18)
	pad.PaddingRight = UDim.new(0, 18)

	-- helper para una X de cierre (Unicode por escape, a prueba de encoding)
	local function makeClose()
		local x = Instance.new("TextButton")
		x.Name = "Close"
		x.BackgroundTransparency = 1
		x.AnchorPoint = Vector2.new(1, 0)
		x.Position = UDim2.new(1, 0, 0, 2)
		x.Size = UDim2.fromOffset(28, 28)
		x.Font = Enum.Font.GothamBold
		x.Text = "\u{2715}"
		x.TextSize = 22
		x.TextColor3 = C.text
		x.ZIndex = 5
		return x
	end

	-- =============== Vista 1: COMPRA ===============
	local buyView = Instance.new("Frame")
	buyView.Name = "BuyView"
	buyView.BackgroundTransparency = 1
	buyView.Size = UDim2.fromScale(1, 1)
	buyView.ZIndex = 3
	buyView.Parent = card

	local title = Instance.new("TextLabel")
	title.Name = "Title"
	title.BackgroundTransparency = 1
	title.Size = UDim2.new(0.5, 0, 0, 30)
	title.Font = Enum.Font.GothamBold
	title.Text = "Buy item"
	title.TextSize = 22
	title.TextColor3 = C.text
	title.TextXAlignment = Enum.TextXAlignment.Left
	title.ZIndex = 3
	title.Parent = buyView

	-- cluster der: [ícono][saldo]   [X]
	local topRight = Instance.new("Frame")
	topRight.Name = "TopRight"
	topRight.BackgroundTransparency = 1
	topRight.AnchorPoint = Vector2.new(1, 0)
	topRight.Position = UDim2.new(1, 0, 0, 2)
	topRight.Size = UDim2.new(0, 240, 0, 28)
	topRight.ZIndex = 3
	topRight.Parent = buyView
	local trLayout = Instance.new("UIListLayout", topRight)
	trLayout.FillDirection = Enum.FillDirection.Horizontal
	trLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
	trLayout.VerticalAlignment = Enum.VerticalAlignment.Center
	trLayout.Padding = UDim.new(0, 6)

	local balIcon = Instance.new("ImageLabel")
	balIcon.Name = "BalIcon"
	balIcon.BackgroundTransparency = 1
	balIcon.Size = UDim2.fromOffset(20, 20)
	balIcon.Image = ROBUX_ICON
	balIcon.LayoutOrder = 1
	balIcon.ZIndex = 3
	balIcon.Parent = topRight

	local balText = Instance.new("TextLabel")
	balText.Name = "Balance"
	balText.BackgroundTransparency = 1
	balText.AutomaticSize = Enum.AutomaticSize.X
	balText.Size = UDim2.fromOffset(0, 24)
	balText.Font = Enum.Font.GothamMedium
	balText.Text = "0"
	balText.TextSize = 17
	balText.TextColor3 = C.text
	balText.LayoutOrder = 2
	balText.ZIndex = 3
	balText.Parent = topRight

	local closeBuy = makeClose()
	closeBuy.AnchorPoint = Vector2.new(0, 0)
	closeBuy.Position = UDim2.fromOffset(0, 0)
	closeBuy.LayoutOrder = 3
	closeBuy.Parent = topRight

	local icon = Instance.new("ImageLabel")
	icon.Name = "Icon"
	icon.BackgroundColor3 = C.placeholder
	icon.Position = UDim2.fromOffset(0, 48)
	icon.Size = UDim2.fromOffset(64, 64)
	icon.ScaleType = Enum.ScaleType.Fit
	icon.Image = ""
	icon.ZIndex = 3
	icon.Parent = buyView
	Instance.new("UICorner", icon).CornerRadius = UDim.new(0, 8)

	local itemName = Instance.new("TextLabel")
	itemName.Name = "ItemName"
	itemName.BackgroundTransparency = 1
	itemName.Position = UDim2.fromOffset(78, 50)
	itemName.Size = UDim2.new(1, -78, 0, 24)
	itemName.Font = Enum.Font.GothamBold
	itemName.Text = "Item"
	itemName.TextSize = 18
	itemName.TextColor3 = C.text
	itemName.TextXAlignment = Enum.TextXAlignment.Left
	itemName.TextTruncate = Enum.TextTruncate.AtEnd
	itemName.ZIndex = 3
	itemName.Parent = buyView

	local priceRow = Instance.new("Frame")
	priceRow.Name = "PriceRow"
	priceRow.BackgroundTransparency = 1
	priceRow.Position = UDim2.fromOffset(78, 80)
	priceRow.Size = UDim2.new(1, -78, 0, 24)
	priceRow.ZIndex = 3
	priceRow.Parent = buyView
	local prLayout = Instance.new("UIListLayout", priceRow)
	prLayout.FillDirection = Enum.FillDirection.Horizontal
	prLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
	prLayout.VerticalAlignment = Enum.VerticalAlignment.Center
	prLayout.Padding = UDim.new(0, 4)

	local priceIcon = Instance.new("ImageLabel")
	priceIcon.Name = "PriceIcon"
	priceIcon.BackgroundTransparency = 1
	priceIcon.Size = UDim2.fromOffset(20, 20)
	priceIcon.Image = ROBUX_ICON
	priceIcon.ZIndex = 3
	priceIcon.Parent = priceRow

	local priceText = Instance.new("TextLabel")
	priceText.Name = "PriceText"
	priceText.BackgroundTransparency = 1
	priceText.AutomaticSize = Enum.AutomaticSize.X
	priceText.Size = UDim2.fromOffset(0, 22)
	priceText.Font = Enum.Font.GothamBold
	priceText.Text = "0"
	priceText.TextSize = 18
	priceText.TextColor3 = C.text
	priceText.ZIndex = 3
	priceText.Parent = priceRow

	local buy = Instance.new("TextButton")
	buy.Name = "Buy"
	buy.AnchorPoint = Vector2.new(0.5, 1)
	buy.Position = UDim2.new(0.5, 0, 1, 0)
	buy.Size = UDim2.new(1, 0, 0, 48)
	buy.BackgroundColor3 = C.buyBase
	buy.AutoButtonColor = false
	buy.Text = ""
	buy.BorderSizePixel = 0
	buy.ClipsDescendants = true
	buy.ZIndex = 3
	buy.Parent = buyView
	Instance.new("UICorner", buy).CornerRadius = UDim.new(0, 10)

	local fill = Instance.new("Frame")
	fill.Name = "Fill"
	fill.BackgroundColor3 = C.buyFill
	fill.BorderSizePixel = 0
	fill.AnchorPoint = Vector2.new(0, 0)
	fill.Position = UDim2.fromScale(0, 0)
	fill.Size = UDim2.fromScale(0, 1)
	fill.ZIndex = 3
	fill.Parent = buy
	Instance.new("UICorner", fill).CornerRadius = UDim.new(0, 10)

	local buyLabel = Instance.new("TextLabel")
	buyLabel.Name = "BuyLabel"
	buyLabel.BackgroundTransparency = 1
	buyLabel.Size = UDim2.fromScale(1, 1)
	buyLabel.Font = Enum.Font.GothamBold
	buyLabel.Text = "Buy"
	buyLabel.TextSize = 18
	buyLabel.TextColor3 = C.text
	buyLabel.ZIndex = 4
	buyLabel.Parent = buy

	-- =============== Vista 2: COMPLETADA ===============
	local doneView = Instance.new("Frame")
	doneView.Name = "DoneView"
	doneView.BackgroundTransparency = 1
	doneView.Size = UDim2.fromScale(1, 1)
	doneView.Visible = false
	doneView.ZIndex = 3
	doneView.Parent = card

	local titleDone = Instance.new("TextLabel")
	titleDone.Name = "TitleDone"
	titleDone.BackgroundTransparency = 1
	titleDone.Size = UDim2.new(0.8, 0, 0, 30)
	titleDone.Font = Enum.Font.GothamBold
	titleDone.Text = "Compra completada"
	titleDone.TextSize = 22
	titleDone.TextColor3 = C.text
	titleDone.TextXAlignment = Enum.TextXAlignment.Left
	titleDone.ZIndex = 3
	titleDone.Parent = doneView

	local closeDone = makeClose()
	closeDone.Parent = doneView

	local checkCircle = Instance.new("Frame")
	checkCircle.Name = "CheckCircle"
	checkCircle.BackgroundTransparency = 1
	checkCircle.AnchorPoint = Vector2.new(0.5, 0)
	checkCircle.Position = UDim2.new(0.5, 0, 0, 42)
	checkCircle.Size = UDim2.fromOffset(56, 56)
	checkCircle.ZIndex = 3
	checkCircle.Parent = doneView
	Instance.new("UICorner", checkCircle).CornerRadius = UDim.new(1, 0)
	local cStroke = Instance.new("UIStroke", checkCircle)
	cStroke.Color = C.text
	cStroke.Thickness = 3

	local checkMark = Instance.new("TextLabel")
	checkMark.Name = "Check"
	checkMark.BackgroundTransparency = 1
	checkMark.Size = UDim2.fromScale(1, 1)
	checkMark.Font = Enum.Font.GothamBold
	checkMark.Text = "\u{2713}"
	checkMark.TextSize = 30
	checkMark.TextColor3 = C.text
	checkMark.ZIndex = 3
	checkMark.Parent = checkCircle

	local successText = Instance.new("TextLabel")
	successText.Name = "SuccessText"
	successText.BackgroundTransparency = 1
	successText.AnchorPoint = Vector2.new(0.5, 0)
	successText.Position = UDim2.new(0.5, 0, 0, 108)
	successText.Size = UDim2.new(1, 0, 0, 20)
	successText.Font = Enum.Font.GothamMedium
	successText.Text = "Compraste el item con \u{00E9}xito."
	successText.TextSize = 16
	successText.TextColor3 = C.subtle
	successText.ZIndex = 3
	successText.Parent = doneView

	local accept = Instance.new("TextButton")
	accept.Name = "Accept"
	accept.AnchorPoint = Vector2.new(0.5, 1)
	accept.Position = UDim2.new(0.5, 0, 1, 0)
	accept.Size = UDim2.new(1, 0, 0, 48)
	accept.BackgroundColor3 = C.accept
	accept.AutoButtonColor = true
	accept.Font = Enum.Font.GothamBold
	accept.Text = "Aceptar"
	accept.TextSize = 18
	accept.TextColor3 = C.text
	accept.BorderSizePixel = 0
	accept.ZIndex = 3
	accept.Parent = doneView
	Instance.new("UICorner", accept).CornerRadius = UDim.new(0, 10)

	gui = {
		screen = screen, shade = shade, card = card,
		buyView = buyView, doneView = doneView,
		balText = balText, closeBuy = closeBuy, icon = icon, itemName = itemName,
		priceText = priceText, buy = buy, fill = fill, buyLabel = buyLabel,
		closeDone = closeDone, successText = successText, accept = accept,
	}
	return gui
end

----------------------------------------------------------------------
-- API
----------------------------------------------------------------------
local activeResolve

function M.Prompt(opts)
	opts = opts or {}
	if activeResolve then
		return false
	end

	local info = getInfo(opts.kind, opts.id)
	local price = info.price or 0
	local name  = opts.name or info.name or "Item"
	local image = opts.image or info.image

	local g = build()
	g.buyView.Visible = true
	g.doneView.Visible = false
	g.itemName.Text = name
	g.icon.Image = image or ""
	g.priceText.Text = (price > 0) and comma(price) or "Free"
	g.balText.Text = comma(getFakeRobux())
	g.successText.Text = ("Compraste %s con \u{00E9}xito."):format(name)

	local canAfford = getFakeRobux() >= price
	g.fill.Size = UDim2.fromScale(0, 1)
	if canAfford then
		g.buyLabel.Text = "Buy"
		g.buy.BackgroundColor3 = C.buyBase
		g.buy.Active = true
	else
		g.buyLabel.Text = "Not enough"
		g.buy.BackgroundColor3 = C.buyOff
		g.buy.Active = false
	end

	-- Mostrar con animación + rellenado de la barra AL APARECER
	g.screen.Enabled = true
	g.shade.BackgroundTransparency = 1
	g.card.Size = UDim2.fromOffset(420, 205)
	TweenService:Create(g.shade, TweenInfo.new(0.15), { BackgroundTransparency = 0.5 }):Play()
	TweenService:Create(g.card, TweenInfo.new(0.18, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
		{ Size = UDim2.fromOffset(440, 215) }):Play()
	if canAfford then
		TweenService:Create(g.fill, TweenInfo.new(FILL_TIME, Enum.EasingStyle.Linear),
			{ Size = UDim2.fromScale(1, 1) }):Play()
	end

	-- Máquina de estados
	local choice = false
	local busy = false
	local thread = coroutine.running()
	activeResolve = function(result)
		activeResolve = nil
		choice = result
		task.spawn(thread)
	end

	local conns = {}
	local function disc()
		for _, c in conns do c:Disconnect() end
	end
	local function finish(result)
		disc()
		if activeResolve then
			activeResolve(result)
		end
	end

	-- Buy -> carga un poco -> pantalla "Compra completada"
	conns[#conns + 1] = g.buy.Activated:Connect(function()
		if not g.buy.Active or busy then
			return
		end
		busy = true
		g.fill.Size = UDim2.fromScale(0, 1)
		local tw = TweenService:Create(g.fill, TweenInfo.new(BUY_LOAD, Enum.EasingStyle.Linear),
			{ Size = UDim2.fromScale(1, 1) })
		tw:Play()
		tw.Completed:Once(function()
			g.buyView.Visible = false
			g.doneView.Visible = true
		end)
	end)

	-- Cancelar (pantalla 1): X o fondo, sólo si no se está comprando
	conns[#conns + 1] = g.closeBuy.Activated:Connect(function()
		if not busy then finish(false) end
	end)
	conns[#conns + 1] = g.shade.Activated:Connect(function()
		if not busy then finish(false) end
	end)

	-- Confirmar (pantalla 2): Aceptar o X -> compra confirmada
	conns[#conns + 1] = g.accept.Activated:Connect(function()
		finish(true)
	end)
	conns[#conns + 1] = g.closeDone.Activated:Connect(function()
		finish(true)
	end)

	coroutine.yield()

	-- Ocultar
	TweenService:Create(g.shade, TweenInfo.new(0.12), { BackgroundTransparency = 1 }):Play()
	local hide = TweenService:Create(g.card, TweenInfo.new(0.12), { Size = UDim2.fromOffset(420, 205) })
	hide:Play()
	hide.Completed:Once(function()
		if not activeResolve then
			g.screen.Enabled = false
		end
	end)

	return choice
end

return M
