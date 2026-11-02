-- Boutique d'oeufs : s'ouvre avec le ProximityPrompt du stand, un clic sur le prix achète l'oeuf
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local ProximityPromptService = game:GetService("ProximityPromptService")

local system = ReplicatedStorage:WaitForChild("EggSystem")
local Config = require(system:WaitForChild("EggConfig"))
local remotes = system:WaitForChild("Remotes")
local eggModels = system:WaitForChild("EggModels")
local petModels = system:WaitForChild("Pets")

local player = Players.LocalPlayer
local gui = script.Parent
local main = gui:WaitForChild("Main")
local list = main:WaitForChild("List")
local rowTemplate = script:WaitForChild("RowTemplate")

local PROMPT_NAME = "EggShopPrompt"
local CLOSE_DISTANCE = 22 -- la boutique se ferme si on s'éloigne du stand
local CAN_BUY_COLOR = ColorSequence.new(Color3.fromRGB(255, 214, 96), Color3.fromRGB(245, 150, 50))
local TOO_EXPENSIVE_COLOR = ColorSequence.new(Color3.fromRGB(206, 206, 216), Color3.fromRGB(150, 150, 166))

local isOwner = table.find(Config.OwnerUserIds, player.UserId) ~= nil
local buyButtons = {} -- [bouton] = prix
local shopPosition = nil

local function fillViewport(view, templates, name)
	local template = templates:FindFirstChild(name)
	if not template then return end
	local model = template:Clone()
	model:PivotTo(CFrame.new())
	model.Parent = view
	local cf, size = model:GetBoundingBox()
	local camera = Instance.new("Camera")
	camera.FieldOfView = 40
	local distance = math.max(size.X, size.Y, size.Z) * 1.6
	camera.CFrame = CFrame.lookAt(cf.Position + Vector3.new(0.6, 0.3, 1).Unit * distance, cf.Position)
	camera.Parent = view
	view.CurrentCamera = camera
end

local function refreshButtons()
	local money = player:GetAttribute("Money") or 0
	for button, price in buyButtons do
		button.Shade.Color = money >= price and CAN_BUY_COLOR or TOO_EXPENSIVE_COLOR
	end
end

for eggName, egg in Config.Eggs do
	local row = rowTemplate:Clone()
	row.Name = eggName
	row.LayoutOrder = egg.Order
	row.EggName.Text = egg.Name
	row.Info.Text = Config.FormatKg(egg.Kg) .. "  ·  hatches in " .. Config.FormatTime(isOwner and Config.OwnerCooldown or egg.Cooldown)

	local gradientColor = Config.Gradients[egg.Rarity]
	if gradientColor then
		row.EggName.UIGradient.Color = gradientColor
		row.EggName.UIGradient.Enabled = true
		CollectionService:AddTag(row.EggName.UIGradient, "AnimatedGradient")
	end

	local pet = Config.Pets[egg.Pets[1].Pet]
	row.Chances.Text = "Hatches: " .. pet.Name .. "\n" .. egg.Rarity .. "  ·  " .. Config.FormatMoney(pet.Income) .. "/s"

	row.Buy.Text = Config.FormatMoney(egg.Price)
	buyButtons[row.Buy] = egg.Price
	row.Buy.Activated:Connect(function()
		remotes.BuyEgg:FireServer(eggName)
	end)

	fillViewport(row.View, eggModels, eggName)
	fillViewport(row.PetView, petModels, egg.Pets[1].Pet) -- l'animal que donne l'oeuf
	row.Visible = true
	row.Parent = list
end

-- chances à la pose de l'oeuf : taille et mutation
do
	local function describe(list, title)
		local parts = {}
		for index = #list, 1, -1 do
			local entry = list[index]
			table.insert(parts, entry.Name .. " x" .. entry.Mult .. " : " .. entry.Chance .. "%")
		end
		return title .. "  " .. table.concat(parts, "   ")
	end
	do -- chances de kilos bonus, de la plus courante à la plus rare
		local parts = {}
		for index = #Config.WeightTiers, 1, -1 do
			local tier = Config.WeightTiers[index]
			table.insert(parts, "+" .. Config.FormatKg(tier.Min) .. " : " .. tier.Chance .. "%")
		end
		main:WaitForChild("Sizes").Text = "Bonus weight when placed:  " .. table.concat(parts, "   ")
	end
	main:WaitForChild("Mutations").Text = describe(Config.Mutations, "Mutation (income):")
end

refreshButtons()
player:GetAttributeChangedSignal("Money"):Connect(refreshButtons)

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
