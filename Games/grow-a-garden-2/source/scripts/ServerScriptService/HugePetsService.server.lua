--credit to quartz games studio
--[[
	HugePetsService  (MODDED)
	------------------------------------------------------------------
	Podio HUGEPETS del Merchant (Podium4Lever).
	- Rota cada STOCK_SECONDS (sincronizado por reloj de pared con los demas
	  podios; el TimeLabel lo escribe OpSprinklerService).
	- Muestra la pet en oferta GIRANDO en pequeño sobre el attachment HUGEPETS.
	- Compra con el ProximityPrompt Podium4Lever.PromptAttachment.HUGEPETS:
	  paga sheckles y recibe esa pet en tamaño "Huge". Una vez por oferta.
	- Precio = BasePrice de la pet x HUGE_PRICE_MULT. Más raro = menos probable
	  que salga (peso por rareza).
]]

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local RunService = game:GetService("RunService")

local GameServerAPI = require(ServerScriptService:WaitForChild("GameServerAPI"))
local PetData = require(ReplicatedStorage.SharedData.PetData)

----------------------------------------------------------------------
-- Config
----------------------------------------------------------------------
local STOCK_SECONDS = 15 * 60
local DISPLAY_HEIGHT = 3.5
local SPIN_SPEED = math.rad(45)
local HUGE_PRICE_MULT = 8       -- precio = BasePrice de la pet x esto

-- Peso del sorteo por rareza (más raro = menos probable que salga).
local RARITY_WEIGHT = {
	Common = 35,
	Uncommon = 25,
	Rare = 18,
	Legendary = 12,
	Mythic = 7,
	Super = 3,
}

----------------------------------------------------------------------
-- Referencias
----------------------------------------------------------------------
local Merchant = Workspace:WaitForChild("Map"):WaitForChild("Stands"):WaitForChild("Merchant")
local PetAssets = ReplicatedStorage:WaitForChild("Assets"):WaitForChild("Pets")

local petAttachment = Merchant:WaitForChild("HUGEPETS")
local prompt = Merchant:WaitForChild("Podium4Lever"):WaitForChild("PromptAttachment"):WaitForChild("HUGEPETS")
local priceFrame = petAttachment:WaitForChild("Slot3"):WaitForChild("Frame")

----------------------------------------------------------------------
-- Ofertas (solo pets con modelo en Assets.Pets)
----------------------------------------------------------------------
local OFFERS = {}
for speciesKey, data in PetData do
	if type(data) == "table" and data.Rarity and PetAssets:FindFirstChild(speciesKey) then
		table.insert(OFFERS, {
			Species = speciesKey,
			Display = data.DisplayName or speciesKey,
			Price = math.floor((data.BasePrice or 100000) * HUGE_PRICE_MULT),
			Weight = RARITY_WEIGHT[data.Rarity] or 10,
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
-- Display girando
----------------------------------------------------------------------
local displayHolder = Merchant:FindFirstChild("HugePetsDisplay")
if displayHolder then
	displayHolder:Destroy()
end
displayHolder = Instance.new("Folder")
displayHolder.Name = "HugePetsDisplay"
displayHolder.Parent = Merchant

local currentModel: Model? = nil
local baseCFrame = petAttachment.WorldCFrame

local function buildDisplay(speciesKey: string)
	if currentModel then
		currentModel:Destroy()
		currentModel = nil
	end
	local template = PetAssets:FindFirstChild(speciesKey)
	if not template or not template:IsA("Model") then
		return
	end
	local model = template:Clone()
	for _, d in model:GetDescendants() do
		if d:IsA("BasePart") then
			d.Anchored = true
			d.CanCollide = false
			d.CanQuery = false
			d.CanTouch = false
			d.Massless = true
		elseif d:IsA("Script") or d:IsA("LocalScript") or d:IsA("Humanoid") then
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
	buildDisplay(currentOffer.Species)
	local priceText = formatPrice(currentOffer.Price)
	setLabelText("PriceLabel", priceText)
	setLabelText("NameLabel", "Huge " .. currentOffer.Display)
	prompt.ActionText = "Buy Huge " .. currentOffer.Display
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
	GameServerAPI.AddPet(player, currentOffer.Species, "Huge")
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
