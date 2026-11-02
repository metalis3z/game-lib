--credit to quartz games studio
--[[
	OpSeedSizeService  (MODDED)
	------------------------------------------------------------------
	Podio OPSEEDSIZE del Merchant (Podium5Lever).
	- Rota cada STOCK_SECONDS (sincronizado por reloj de pared; el TimeLabel lo
	  escribe OpSprinklerService).
	- Vende SOLO semillas NORMALES (sin mutación) pero con tamaño OP: alto y ancho
	  grandes (PLANT_HEIGHT x PLANT_WIDTH = 25 x 25). Cada semilla que se planta
	  crece enorme y ancha.
	- Muestra la semilla en oferta GIRANDO en pequeño sobre el attachment OPSEEDSIZE.
	- Compra con el ProximityPrompt Podium5Lever.PromptAttachment.OPSEEDSIZE:
	  paga sheckles y recibe ESA semilla con alto/ancho 25. Una vez por oferta.
	- Lo que rota es QUÉ planta sale; el precio depende de su rareza (más raro =
	  menos probable que salga = más caro). El tamaño 25x25 es fijo.
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
local STOCK_SECONDS = 15 * 60
local DISPLAY_HEIGHT = 2.5
local SPIN_SPEED = math.rad(45)
local PLANT_HEIGHT = 4    -- alto de la planta (HeightMultiplier /opseed)
local PLANT_WIDTH = 4     -- ancho de la planta (WidthMultiplier /opseed)

-- Precio por rareza de la planta (premium: el 25x25 es OP -> más caro).
local RARITY_PRICE = {
	Common = 40e6,
	Uncommon = 75e6,
	Rare = 150e6,
	Epic = 300e6,
	Legendary = 600e6,
	Mythic = 1.2e9,
	Super = 2.5e9,
}
-- Peso del sorteo por rareza (más raro = menos probable que salga).
local RARITY_WEIGHT = {
	Common = 35,
	Uncommon = 26,
	Rare = 18,
	Epic = 12,
	Legendary = 8,
	Mythic = 5,
	Super = 2,
}
local DEFAULT_PRICE = 40e6
local DEFAULT_WEIGHT = 10

----------------------------------------------------------------------
-- Referencias
----------------------------------------------------------------------
local Merchant = Workspace:WaitForChild("Map"):WaitForChild("Stands"):WaitForChild("Merchant")
local SeedAssets = ReplicatedStorage:WaitForChild("Assets"):WaitForChild("Seeds")

local seedAttachment = Merchant:WaitForChild("OPSEEDSIZE")
local prompt = Merchant:WaitForChild("Podium5Lever"):WaitForChild("PromptAttachment"):WaitForChild("OPSEEDSIZE")
local priceFrame = seedAttachment:WaitForChild("Slot4"):WaitForChild("Frame")

----------------------------------------------------------------------
-- Ofertas (todas las plantas normales de SeedData con Part de semilla)
----------------------------------------------------------------------
local OFFERS = {}
for _, entry in SeedData do
	if entry.SeedName then
		local rarity = entry.Rarity or "Common"
		table.insert(OFFERS, {
			Seed = entry.SeedName,
			Price = RARITY_PRICE[rarity] or DEFAULT_PRICE,
			Weight = RARITY_WEIGHT[rarity] or DEFAULT_WEIGHT,
		})
	end
end

----------------------------------------------------------------------
-- Util
----------------------------------------------------------------------
local function formatPrice(n: number): string
	local units = { { 1e12, "T" }, { 1e9, "B" }, { 1e6, "M" }, { 1e3, "K" } }
	for _, u in units do
		if n >= u[1] then
			local s = string.format("%.2f", n / u[1]):gsub("%.?0+$", "")
			return "$" .. s .. u[2]
		end
	end
	return "$" .. tostring(math.floor(n))
end

local function pickWeighted()
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

local function setLabelText(childName, text)
	local lbl = priceFrame:FindFirstChild(childName)
	if lbl and lbl:IsA("TextLabel") then
		lbl.Text = text
	end
end

----------------------------------------------------------------------
-- Display girando (el seed es un Part -> lo envuelvo en un Model para escalar)
----------------------------------------------------------------------
local displayHolder = Merchant:FindFirstChild("OpSeedSizeDisplay")
if displayHolder then
	displayHolder:Destroy()
end
displayHolder = Instance.new("Folder")
displayHolder.Name = "OpSeedSizeDisplay"
displayHolder.Parent = Merchant

local currentModel: Model? = nil
local baseCFrame = seedAttachment.WorldCFrame

local function buildDisplay(seedName: string)
	if currentModel then
		currentModel:Destroy()
		currentModel = nil
	end
	local template = SeedAssets:FindFirstChild(seedName) or SeedAssets:FindFirstChild("Carrot")
	if not template then
		return
	end
	local clone = template:Clone()
	local model
	if clone:IsA("Model") then
		model = clone
	else
		model = Instance.new("Model")
		clone.Parent = model
		if clone:IsA("BasePart") then
			model.PrimaryPart = clone
		end
	end
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
	local _, size = model:GetBoundingBox()
	local biggest = math.max(size.X, size.Y, size.Z)
	if biggest > 0 then
		model:ScaleTo(DISPLAY_HEIGHT / biggest)
	end
	model:PivotTo(baseCFrame)
	currentModel = model
end

local spinAngle = 0
RunService.Heartbeat:Connect(function(dt)
	if currentModel and currentModel.Parent then
		spinAngle += SPIN_SPEED * dt
		currentModel:PivotTo(baseCFrame * CFrame.Angles(0, spinAngle, 0))
	end
end)

----------------------------------------------------------------------
-- Estado / oferta
----------------------------------------------------------------------
local currentOffer = OFFERS[1]
local purchased: { [Player]: boolean } = {}

local function rollNewOffer()
	currentOffer = pickWeighted()
	purchased = {}
	buildDisplay(currentOffer.Seed)
	local priceText = formatPrice(currentOffer.Price)
	setLabelText("PriceLabel", priceText)
	setLabelText("NameLabel", currentOffer.Seed .. " 4x4")
	prompt.ActionText = "Buy " .. currentOffer.Seed .. " (4x4)"
	prompt.ObjectText = priceText
end

----------------------------------------------------------------------
-- Compra
----------------------------------------------------------------------
prompt.HoldDuration = 0.5
prompt.Enabled = true

prompt.Triggered:Connect(function(player)
	if not player or not player.Parent or purchased[player] then
		return
	end
	if GameServerAPI.GetSheckles(player) < currentOffer.Price then
		return
	end
	GameServerAPI.AddSheckles(player, -currentOffer.Price)
	purchased[player] = true
	-- size base 1: el tamaño total lo dan alto/ancho (igual que el comando /opseed).
	GameServerAPI.GiveOpSizeSeed(player, currentOffer.Seed, 1, PLANT_HEIGHT, PLANT_WIDTH)
	if GameServerAPI.PlaySFX then
		pcall(function()
			GameServerAPI.PlaySFX(player, "Purchase")
		end)
	end
end)

Players.PlayerRemoving:Connect(function(player)
	purchased[player] = nil
end)

----------------------------------------------------------------------
-- Rotacion sincronizada (no escribe TimeLabel; lo hace OpSprinklerService)
----------------------------------------------------------------------
local function currentWindow(): number
	return math.floor(os.time() / STOCK_SECONDS)
end

rollNewOffer()
local lastWindow = currentWindow()

task.spawn(function()
	while true do
		local w = currentWindow()
		if w ~= lastWindow then
			lastWindow = w
			rollNewOffer()
		end
		task.wait(1)
	end
end)
