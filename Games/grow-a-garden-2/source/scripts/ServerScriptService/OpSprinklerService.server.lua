--credit to leon games studio
--[[
	OpSprinklerService  (MODDED)
	------------------------------------------------------------------
	Tienda rotativa de "OP Sprinklers" en el Merchant.

	- Cada 15 minutos se elige un sprinkler al azar (ponderado: cuanto mas
	  raro, menos probable que salga).
	- El sprinkler elegido se muestra en pequeño GIRANDO sobre el attachment
	  Workspace.Map.Stands.Merchant.OPSPRINKLERS.
	- El cartel Merchant.MerchantSign.SurfaceGui.TimeLabel muestra la cuenta
	  atras: "Timer: MM:SS".
	- El precio se muestra en Merchant.OPSEEDSIZE.Slot.Frame.PriceLabel
	  (y tambien en OPSPRINKLERS.Slot4) y empieza en $20M para el mas comun.
	- El jugador compra con el ProximityPrompt
	  Merchant.Podium2Lever.PromptAttachment.OPSEEDSIZE: paga sheckles y recibe
	  una semilla OP (planta al azar) cuyo SizeMultiplier depende de la rareza
	  del sprinkler actual -> sus frutas salen GRANDES (mas raro = mas grande).
	- Solo se puede comprar UNA vez por cada sprinkler en oferta (se resetea al
	  rotar a uno nuevo).
]]

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local RunService = game:GetService("RunService")

local GameServerAPI = require(ServerScriptService:WaitForChild("GameServerAPI"))
local SeedData = require(ReplicatedStorage.SharedModules.SeedData)

----------------------------------------------------------------------
-- Config
----------------------------------------------------------------------
local STOCK_SECONDS = 15 * 60          -- cada 15 minutos rota la oferta
local DISPLAY_HEIGHT = 2.5             -- altura objetivo (studs) del modelo en pequeño
local SPIN_SPEED = math.rad(45)        -- velocidad de giro (rad/seg)

-- Oferta por sprinkler: Price = sheckles, Size = SizeMultiplier de la semilla
-- OP (mas raro = mas grande), Weight = peso para el sorteo (mas raro = menos
-- probable que salga).
local OFFERS = {
	{ Name = "Common Sprinkler",    Price = 20e6,  Size = 3,  Weight = 40 },
	{ Name = "Uncommon Sprinkler",  Price = 50e6,  Size = 6,  Weight = 27 },
	{ Name = "Rare Sprinkler",      Price = 150e6, Size = 10, Weight = 18 },
	{ Name = "Legendary Sprinkler", Price = 500e6, Size = 18, Weight = 10 },
	{ Name = "Super Sprinkler",     Price = 1e9,   Size = 30, Weight = 5  },
}

----------------------------------------------------------------------
-- Referencias en el mapa
----------------------------------------------------------------------
local Merchant = Workspace:WaitForChild("Map"):WaitForChild("Stands"):WaitForChild("Merchant")
local SprinklerAssets = ReplicatedStorage:WaitForChild("Assets"):WaitForChild("Sprinklers")

local sprinklerAttachment = Merchant:WaitForChild("OPSPRINKLERS")
local timeLabel = Merchant:WaitForChild("MerchantSign"):WaitForChild("SurfaceGui"):WaitForChild("TimeLabel")
local prompt = Merchant:WaitForChild("Podium2Lever"):WaitForChild("PromptAttachment"):WaitForChild("OPSPRINKLERS")

-- Cartel de precio/nombre del propio podio del sprinkler (OPSPRINKLERS.Slot.Frame).
local priceFrame = sprinklerAttachment:WaitForChild("Slot"):WaitForChild("Frame")

----------------------------------------------------------------------
-- Util
----------------------------------------------------------------------
local function formatPrice(n: number): string
	local units = { { 1e12, "T" }, { 1e9, "B" }, { 1e6, "M" }, { 1e3, "K" } }
	for _, u in units do
		if n >= u[1] then
			local v = n / u[1]
			local s = string.format("%.2f", v):gsub("%.?0+$", "")
			return "$" .. s .. u[2]
		end
	end
	return "$" .. tostring(math.floor(n))
end

-- Lista de nombres de semilla disponibles para dar semillas OP al azar.
local SEED_NAMES = {}
for _, entry in SeedData do
	if entry.SeedName then
		table.insert(SEED_NAMES, entry.SeedName)
	end
end

local function pickWeightedOffer()
	local total = 0
	for _, o in OFFERS do
		total += o.Weight
	end
	local roll = math.random() * total
	local acc = 0
	for _, o in OFFERS do
		acc += o.Weight
		if roll <= acc then
			return o
		end
	end
	return OFFERS[1]
end

local function setLabelText(frame, childName, text)
	if not frame then
		return
	end
	local lbl = frame:FindFirstChild(childName)
	if lbl and lbl:IsA("TextLabel") then
		lbl.Text = text
	end
end

----------------------------------------------------------------------
-- Display del modelo que gira
----------------------------------------------------------------------
local displayHolder = Merchant:FindFirstChild("OpSprinklerDisplay")
if displayHolder then
	displayHolder:Destroy()
end
displayHolder = Instance.new("Folder")
displayHolder.Name = "OpSprinklerDisplay"
displayHolder.Parent = Merchant

local currentModel: Model? = nil
local baseCFrame = sprinklerAttachment.WorldCFrame

local function buildDisplay(sprinklerName: string)
	if currentModel then
		currentModel:Destroy()
		currentModel = nil
	end

	local template = SprinklerAssets:FindFirstChild(sprinklerName)
	if not template then
		return
	end

	local model = template:Clone()
	-- Preparar el modelo: anclado, sin colision, decorativo.
	for _, d in model:GetDescendants() do
		if d:IsA("BasePart") then
			d.Anchored = true
			d.CanCollide = false
			d.CanQuery = false
			d.CanTouch = false
			d.Massless = true
		elseif d:IsA("Script") or d:IsA("LocalScript") then
			d:Destroy()
		end
	end

	model.Parent = displayHolder

	-- Escalar a pequeño (altura objetivo).
	local _, size = model:GetBoundingBox()
	local biggest = math.max(size.X, size.Y, size.Z)
	if biggest > 0 then
		model:ScaleTo(DISPLAY_HEIGHT / biggest)
	end

	model:PivotTo(baseCFrame)
	currentModel = model
end

-- Giro continuo.
local spinAngle = 0
RunService.Heartbeat:Connect(function(dt)
	if currentModel and currentModel.Parent then
		spinAngle += SPIN_SPEED * dt
		currentModel:PivotTo(baseCFrame * CFrame.Angles(0, spinAngle, 0))
	end
end)

----------------------------------------------------------------------
-- Estado de la oferta
----------------------------------------------------------------------
local currentOffer = OFFERS[1]
local purchased: { [Player]: boolean } = {}

local function rollNewOffer()
	currentOffer = pickWeightedOffer()
	purchased = {}

	buildDisplay(currentOffer.Name)

	local priceText = formatPrice(currentOffer.Price)
	setLabelText(priceFrame, "PriceLabel", priceText)
	setLabelText(priceFrame, "NameLabel", currentOffer.Name)

	prompt.ActionText = "Buy " .. currentOffer.Name
	prompt.ObjectText = priceText
end

----------------------------------------------------------------------
-- Compra
----------------------------------------------------------------------
prompt.HoldDuration = 0.5
prompt.Enabled = true

prompt.Triggered:Connect(function(player)
	if not player or not player.Parent then
		return
	end
	if purchased[player] then
		return -- ya compro esta oferta
	end

	local price = currentOffer.Price
	if GameServerAPI.GetSheckles(player) < price then
		return -- sin sheckles suficientes
	end

	-- Cobrar.
	GameServerAPI.AddSheckles(player, -price)
	purchased[player] = true

	-- Dar el SPRINKLER real (gear apilable, se persiste vía GearService) y aplicar
	-- el BUFF: a partir de ahora las frutas del jugador salen enormes (escala segun
	-- la rareza del sprinkler). El buff se queda con el MAYOR comprado y se persiste.
	if GameServerAPI.GiveGear then
		GameServerAPI.GiveGear(player, currentOffer.Name, 1)
	end
	local current = player:GetAttribute("FruitSizeBuff")
	if type(current) ~= "number" or currentOffer.Size > current then
		player:SetAttribute("FruitSizeBuff", currentOffer.Size)
	end

	if GameServerAPI.PlaySFX then
		pcall(function()
			GameServerAPI.PlaySFX(player, "Purchase")
		end)
	end
end)

-- Limpiar el flag al salir.
Players.PlayerRemoving:Connect(function(player)
	purchased[player] = nil
end)

----------------------------------------------------------------------
-- Bucle de timer / rotacion
----------------------------------------------------------------------
-- Rotacion sincronizada a reloj de pared: todos los podios del merchant rotan
-- en la misma ventana de STOCK_SECONDS. Este servicio (sprinklers) es el unico
-- que escribe el TimeLabel compartido del MerchantSign.
local function currentWindow(): number
	return math.floor(os.time() / STOCK_SECONDS)
end

rollNewOffer()
local lastWindow = currentWindow()

task.spawn(function()
	while true do
		local remaining = STOCK_SECONDS - (os.time() % STOCK_SECONDS)
		timeLabel.Text = string.format("Timer: %02d:%02d", math.floor(remaining / 60), remaining % 60)
		local w = currentWindow()
		if w ~= lastWindow then
			lastWindow = w
			rollNewOffer()
		end
		task.wait(1)
	end
end)
