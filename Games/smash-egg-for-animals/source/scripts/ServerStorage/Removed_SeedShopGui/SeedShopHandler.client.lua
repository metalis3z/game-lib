-- Boutique de graines : s'ouvre avec le ProximityPrompt du stand, un clic sur le prix achète une graine
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local ProximityPromptService = game:GetService("ProximityPromptService")

local EggConfig = require(ReplicatedStorage:WaitForChild("EggSystem"):WaitForChild("EggConfig"))
local system = ReplicatedStorage:WaitForChild("PlantSystem")
local Config = require(system:WaitForChild("PlantConfig"))
local remotes = system:WaitForChild("Remotes")
local cropModels = system:WaitForChild("CropModels")

local player = Players.LocalPlayer
local gui = script.Parent
local main = gui:WaitForChild("Main")
local list = main:WaitForChild("List")
local rowTemplate = script:WaitForChild("RowTemplate")

local PROMPT_NAME = "SeedShopPrompt"
local CLOSE_DISTANCE = 22 -- la boutique se ferme si on s'éloigne du stand
local CAN_BUY_COLOR = ColorSequence.new(Color3.fromRGB(255, 214, 96), Color3.fromRGB(245, 150, 50))
local TOO_EXPENSIVE_COLOR = ColorSequence.new(Color3.fromRGB(206, 206, 216), Color3.fromRGB(150, 150, 166))

local rows = {} -- [nom de graine] = ligne
local shopPosition = nil

local function fillViewport(view, seedName)
	local template = cropModels:FindFirstChild(seedName)
	if not template then return end
	local model = template:Clone()
	model:PivotTo(CFrame.new())
	model.Parent = view
	local cf, size = model:GetBoundingBox()
	local camera = Instance.new("Camera")
	camera.FieldOfView = 40
	local distance = math.max(size.X, size.Y, size.Z) * 1.55
	camera.CFrame = CFrame.lookAt(cf.Position + Vector3.new(0.6, 0.45, 1).Unit * distance, cf.Position)
	camera.Parent = view
	view.CurrentCamera = camera
end

local function refreshButtons()
	local money = player:GetAttribute("Money") or 0
	for seedName, row in rows do
		row.Buy.Shade.Color = money >= Config.Seeds[seedName].Price and CAN_BUY_COLOR or TOO_EXPENSIVE_COLOR
	end
end

for seedName, seed in Config.Seeds do
	local row = rowTemplate:Clone()
	row.Name = seedName
	row.LayoutOrder = seed.Order
	row.SeedName.Text = seed.Name .. " Seed"
	row.Rarity.Text = seed.Rarity
	-- le temps dépend du poids de la plante : on ne l'affiche que pour le créateur (toujours 5 s)
	row.Grow.Text = Config.IsOwner(player.UserId) and ("Grows in " .. EggConfig.FormatTime(Config.OwnerGrowTime)) or "Heavier plants take longer to grow"
	row.Sell.Text = "Gives " .. seed.Xp .. " XP to a pet"
	row.Accent.BackgroundColor3 = seed.Color

	local gradientColor = EggConfig.Gradients[seed.Rarity]
	if gradientColor then
		row.SeedName.UIGradient.Color = gradientColor
		row.SeedName.UIGradient.Enabled = true
		CollectionService:AddTag(row.SeedName.UIGradient, "AnimatedGradient")
	end

	row.Buy.Text = EggConfig.FormatMoney(seed.Price)
	row.Buy.Activated:Connect(function()
		remotes.BuySeed:FireServer(seedName)
	end)

	fillViewport(row.View, seedName)
	rows[seedName] = row
	row.Visible = true
	row.Parent = list
end

-- chances tirées quand on plante : kilos bonus et mutation
do
	local weights, mutations = {}, {}
	for index = #EggConfig.WeightTiers, 1, -1 do
		local tier = EggConfig.WeightTiers[index]
		table.insert(weights, "+" .. EggConfig.FormatKg(tier.Min) .. " : " .. tier.Chance .. "%")
	end
	for index = #EggConfig.Mutations, 1, -1 do
		local mutation = EggConfig.Mutations[index]
		table.insert(mutations, mutation.Name .. " x" .. mutation.Mult .. " : " .. mutation.Chance .. "%")
	end
	local grass = main:WaitForChild("Grass")
	grass:WaitForChild("Weights").Text = "Bonus weight when planted:  " .. table.concat(weights, "   ")
	grass:WaitForChild("Mutations").Text = "Mutation (XP) :  " .. table.concat(mutations, "   ")
end

refreshButtons()
player:GetAttributeChangedSignal("Money"):Connect(refreshButtons)

remotes:WaitForChild("SeedsUpdated").OnClientEvent:Connect(function(state)
	local counts = {}
	for _, entry in state.Seeds do counts[entry.Seed] = entry.Count end
	for seedName, row in rows do
		row.Owned.Text = "Owned: " .. (counts[seedName] or 0)
	end
end)

local function setOpen(open)
	main.Visible = open
end

ProximityPromptService.PromptTriggered:Connect(function(prompt)
	if prompt.Name ~= PROMPT_NAME then return end
	shopPosition = prompt.Parent.Position
	setOpen(not main.Visible)
end)

main:WaitForChild("Header"):WaitForChild("Close").Activated:Connect(function() setOpen(false) end)

task.spawn(function()
	while true do
		task.wait(0.5)
		if main.Visible and shopPosition then
			local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
			if not hrp or (hrp.Position - shopPosition).Magnitude > CLOSE_DISTANCE then setOpen(false) end
		end
	end
end)

remotes:WaitForChild("SeedAction"):FireServer("Sync")
