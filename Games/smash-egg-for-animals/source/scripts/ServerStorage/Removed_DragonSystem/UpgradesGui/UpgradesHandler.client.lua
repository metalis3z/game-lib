-- Stand "Upgrades" : trois améliorations du dragon (endurance des ailes, charge, vitesse).
-- S'ouvre avec le ProximityPrompt du stand ; le bouton vert achète avec l'argent du jeu.
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ProximityPromptService = game:GetService("ProximityPromptService")

local dragonSystem = ReplicatedStorage:WaitForChild("DragonSystem")
local UpgradeConfig = require(dragonSystem:WaitForChild("UpgradeConfig"))
local buyUpgrade = dragonSystem:WaitForChild("BuyUpgrade")
local EggConfig = require(ReplicatedStorage:WaitForChild("EggSystem"):WaitForChild("EggConfig"))

local player = Players.LocalPlayer
local gui = script.Parent
local main = gui:WaitForChild("Main")
local list = main:WaitForChild("List")
local rowTemplate = script:WaitForChild("RowTemplate")
local icons = script:WaitForChild("Icons")

local PROMPT_NAME = "UpgradeShopPrompt"
local CLOSE_DISTANCE = 24
local CAN_BUY = ColorSequence.new(Color3.fromRGB(150, 240, 110), Color3.fromRGB(54, 176, 70))
local TOO_EXPENSIVE = ColorSequence.new(Color3.fromRGB(206, 206, 216), Color3.fromRGB(150, 150, 166))
local MAXED = ColorSequence.new(Color3.fromRGB(255, 232, 130), Color3.fromRGB(240, 170, 50))

local rows = {}
local shopPosition

local function refresh()
	local money = player:GetAttribute("Money") or 0
	for key, row in rows do
		local stat = UpgradeConfig.Stats[key]
		local level = UpgradeConfig.Level(player, key)
		local maxed = level >= stat.Max
		row.Title.Text = "+" .. stat.Step .. (stat.Suffix or "") .. " " .. stat.Title
		row.Values.From.Text = tostring(UpgradeConfig.ValueAt(key, level)) .. (stat.Suffix or "")
		row.Values.To.Text = maxed and "MAX" or (tostring(UpgradeConfig.ValueAt(key, level + 1)) .. (stat.Suffix or ""))
		local cost = UpgradeConfig.Cost(key, level)
		row.Buy.Text = maxed and "MAX" or EggConfig.FormatMoney(cost)
		row.Buy.Shade.Color = maxed and MAXED or (money >= cost and CAN_BUY or TOO_EXPENSIVE)
		row.Robux.Visible = not maxed
	end
end

for order, key in UpgradeConfig.Order do
	local stat = UpgradeConfig.Stats[key]
	local row = rowTemplate:Clone()
	row.Name = key
	row.LayoutOrder = order
	local icon = icons:FindFirstChild(key)
	if icon then icon:Clone().Parent = row.IconBox end
	row.Robux.Text = "R$ " .. stat.Robux
	row.Buy.Activated:Connect(function() buyUpgrade:FireServer(key) end)
	row.Robux.Activated:Connect(function()
		-- achat en Robux : à brancher sur un produit développeur
		row.Robux.Text = "Soon"
		task.delay(1.2, function() if row.Parent then row.Robux.Text = "R$ " .. stat.Robux end end)
	end)
	row.Parent = list
	rows[key] = row
	player:GetAttributeChangedSignal("Up_" .. key):Connect(refresh)
end
player:GetAttributeChangedSignal("Money"):Connect(function()
	if main.Visible then refresh() end
end)
refresh()

local function setOpen(open)
	main.Visible = open
	if open then refresh() end
end

ProximityPromptService.PromptTriggered:Connect(function(prompt)
	if prompt.Name ~= PROMPT_NAME then return end
	shopPosition = prompt.Parent.Position
	setOpen(not main.Visible)
end)
main:WaitForChild("Band"):WaitForChild("Close").Activated:Connect(function() setOpen(false) end)

task.spawn(function()
	while true do
		task.wait(0.5)
		if main.Visible and shopPosition then
			local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
			if not hrp or (hrp.Position - shopPosition).Magnitude > CLOSE_DISTANCE then setOpen(false) end
		end
	end
end)
