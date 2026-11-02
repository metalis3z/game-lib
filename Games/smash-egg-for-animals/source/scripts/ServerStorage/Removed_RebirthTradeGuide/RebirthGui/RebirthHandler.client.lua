-- Rebirth window: shows the next rebirth, the two pets it costs, and asks the server to rebirth.
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local system = ReplicatedStorage:WaitForChild("EggSystem")
local Config = require(system:WaitForChild("EggConfig"))
local petTemplates = system:WaitForChild("Pets")
local petRemotes = system:WaitForChild("Remotes")
local shopSystem = ReplicatedStorage:WaitForChild("ShopSystem")
local ShopConfig = require(shopSystem:WaitForChild("ShopConfig"))
local rebirthRemote = shopSystem:WaitForChild("Remotes"):WaitForChild("Rebirth")

local player = Players.LocalPlayer
local gui = script.Parent
local main = gui:WaitForChild("Main")
local current = main:WaitForChild("Current")
local nextFrame = main:WaitForChild("Next")
local needsFrame = nextFrame:WaitForChild("Needs")
local rebirthButton = main:WaitForChild("RebirthNow")
local needTemplate = script:WaitForChild("NeedTemplate")
local openButton = player:WaitForChild("PlayerGui"):WaitForChild("left bottom"):WaitForChild("Holder"):WaitForChild("RebirthButton")

local READY_GRADIENT = ColorSequence.new(Color3.fromRGB(150, 226, 96), Color3.fromRGB(66, 170, 70))
local LOCKED_GRADIENT = ColorSequence.new(Color3.fromRGB(206, 206, 216), Color3.fromRGB(150, 150, 166))
local READY_COLOR = Color3.fromRGB(170, 255, 150)
local MISSING_COLOR = Color3.fromRGB(255, 130, 120)

local ownedPets = {} -- latest pet list sent by the server

local function formatMult(mult) return "x" .. tostring(mult) end

local function fillViewport(view, petName)
	local template = petTemplates:FindFirstChild(petName)
	if not template then return end
	local model = template:Clone()
	model:PivotTo(CFrame.new())
	model.Parent = view
	local cf, size = model:GetBoundingBox()
	local camera = Instance.new("Camera")
	camera.FieldOfView = 40
	camera.CFrame = CFrame.lookAt(cf.Position + Vector3.new(0.75, 0.35, 1).Unit * math.max(size.X, size.Y, size.Z) * 1.55, cf.Position)
	camera.Parent = view
	view.CurrentCamera = camera
end

-- which egg a pet comes from, and with what chance
local function petSource(petName)
	for _, egg in Config.Eggs do
		for _, entry in egg.Pets do
			if entry.Pet == petName then return egg.Name, entry.Chance end
		end
	end
	return nil
end

local function hasPet(petName, used)
	for index, pet in ownedPets do
		if not used[index] and pet.Pet == petName then
			used[index] = true
			return true
		end
	end
	return false
end

local shownRebirth
local function refresh()
	local rebirths = player:GetAttribute("Rebirths") or 0
	local total = #ShopConfig.Rebirths
	local rebirth = ShopConfig.Rebirths[rebirths + 1]
	current.Level.Text = "Rebirth " .. rebirths .. "/" .. total
	current.Mult.Text = "Money " .. formatMult(ShopConfig.RebirthMult(rebirths))
	nextFrame.Maxed.Visible = rebirth == nil
	nextFrame.Title.Visible = rebirth ~= nil
	nextFrame.Cost.Visible = rebirth ~= nil
	needsFrame.Visible = rebirth ~= nil
	if not rebirth then
		rebirthButton.Text = "Max rebirth"
		rebirthButton.Shade.Color = LOCKED_GRADIENT
		return
	end
	nextFrame.Title.Text = "Next: Rebirth " .. (rebirths + 1) .. "  ·  Money " .. formatMult(rebirth.Mult)

	if shownRebirth ~= rebirths then -- rebuild the two requirement cards
		shownRebirth = rebirths
		for _, child in needsFrame:GetChildren() do
			if child:IsA("Frame") then child:Destroy() end
		end
		for order, petName in rebirth.Needs do
			local card = needTemplate:Clone()
			card.Name = petName
			card.LayoutOrder = order
			card.EggName.Text = "1 " .. Config.Pets[petName].Name
			local eggName, chance = petSource(petName)
			card.Source.Text = eggName or ""
			fillViewport(card.View, petName)
			card.Parent = needsFrame
		end
	end

	nextFrame.Cost.Text = "Cost: " .. Config.FormatMoney(rebirth.Price) .. " + the two pets below"
	local used, ready = {}, true
	for _, petName in rebirth.Needs do
		local card = needsFrame:FindFirstChild(petName)
		local has = hasPet(petName, used)
		if not has then ready = false end
		if card then
			card.Status.Text = has and "READY" or "MISSING"
			card.Status.TextColor3 = has and READY_COLOR or MISSING_COLOR
		end
	end
	local label = ready and "Rebirth" or "Missing pets"
	if ready and (player:GetAttribute("Money") or 0) < rebirth.Price then
		ready, label = false, "Need " .. Config.FormatMoney(rebirth.Price)
	end
	rebirthButton.Text = label
	rebirthButton.Shade.Color = ready and READY_GRADIENT or LOCKED_GRADIENT
end

petRemotes:WaitForChild("InventoryUpdated").OnClientEvent:Connect(function(inventory)
	ownedPets = inventory.Pets or {}
	refresh()
end)
player:GetAttributeChangedSignal("Rebirths"):Connect(refresh)
player:GetAttributeChangedSignal("Money"):Connect(function()
	if main.Visible then refresh() end
end)
refresh()

rebirthButton.Activated:Connect(function() rebirthRemote:FireServer() end)
openButton.Activated:Connect(function()
	main.Visible = not main.Visible
	if main.Visible then petRemotes.PetAction:FireServer("Sync") end
end)
main:WaitForChild("Header"):WaitForChild("Close").Activated:Connect(function() main.Visible = false end)
