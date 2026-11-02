--credit to leon games studio
--[[
	RainbowSeedService  (MODDED)
	------------------------------------------------------------------
	Podio RAINBOWSEEDOPSIZE del Merchant (Podium1Lever).
	- Rota cada STOCK_SECONDS (sincronizado por reloj de pared; el TimeLabel lo
	  escribe OpSprinklerService).
	- Muestra una semilla Rainbow GIRANDO en pequeño sobre el attachment
	  RAINBOWSEEDOPSIZE (usa el Part Assets.Seeds.Rainbow).
	- Compra con el ProximityPrompt Podium1Lever.PromptAttachment.RAINBOWSEEDOPSIZE:
	  paga sheckles y recibe una semilla de planta ALEATORIA con mutación
	  "Rainbow" + tamaño OP (SizeMultiplier del tier) -> la fruta sale grande Y
	  arcoíris. Una vez por oferta. El tier (tamaño/precio) es lo que rota:
	  más grande = menos probable que salga = más caro.
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
local DISPLAY_SEED = "Rainbow" -- Part en Assets.Seeds que se muestra girando

-- Tiers: Name = etiqueta, Price = sheckles, Size = SizeMultiplier de la semilla,
-- Weight = peso del sorteo (más grande = menos probable).
local OFFERS = {
	{ Name = "Rainbow Seed [S]",   Price = 30e6,  Size = 5,  Weight = 40 },
	{ Name = "Rainbow Seed [M]",   Price = 80e6,  Size = 10, Weight = 27 },
	{ Name = "Rainbow Seed [L]",   Price = 200e6, Size = 18, Weight = 18 },
	{ Name = "Rainbow Seed [XL]",  Price = 600e6, Size = 28, Weight = 10 },
	{ Name = "Rainbow Seed [MAX]", Price = 1.5e9, Size = 40, Weight = 5  },
}

----------------------------------------------------------------------
-- Referencias
----------------------------------------------------------------------
local Merchant = Workspace:WaitForChild("Map"):WaitForChild("Stands"):WaitForChild("Merchant")
local SeedAssets = ReplicatedStorage:WaitForChild("Assets"):WaitForChild("Seeds")

local seedAttachment = Merchant:WaitForChild("RAINBOWSEEDOPSIZE")
local prompt = Merchant:WaitForChild("Podium1Lever"):WaitForChild("PromptAttachment"):WaitForChild("RAINBOWSEEDOPSIZE")
local priceFrame = seedAttachment:WaitForChild("SlotO"):WaitForChild("Frame")

-- Nombres de planta reales para dar la semilla al azar.
local SEED_NAMES = {}
for _, entry in SeedData do
	if entry.SeedName then
		table.insert(SEED_NAMES, entry.SeedName)
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
local displayHolder = Merchant:FindFirstChild("RainbowSeedDisplay")
if displayHolder then
	displayHolder:Destroy()
end
displayHolder = Instance.new("Folder")
displayHolder.Name = "RainbowSeedDisplay"
displayHolder.Parent = Merchant

local currentModel: Model? = nil
local baseCFrame = seedAttachment.WorldCFrame

local function buildDisplay()
	if currentModel then
		currentModel:Destroy()
		currentModel = nil
	end
	local template = SeedAssets:FindFirstChild(DISPLAY_SEED)
	if not template then
		return
	end
	local clone = template:Clone()
	local model = Instance.new("Model")
	if clone:IsA("BasePart") then
		clone.Parent = model
		model.PrimaryPart = clone
	else
		clone.Parent = model
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
	buildDisplay()
	local priceText = formatPrice(currentOffer.Price)
	setLabelText("PriceLabel", priceText)
	setLabelText("NameLabel", currentOffer.Name)
	prompt.ActionText = "Buy " .. currentOffer.Name
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
	local seedName = SEED_NAMES[math.random(#SEED_NAMES)]
	GameServerAPI.GiveMutatedOpSeed(player, seedName, currentOffer.Size, "Rainbow")
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
