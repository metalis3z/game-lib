-- Boutique de dragons : tous les dragons de DragonConfig, le premier est offert. S'ouvre avec le ProximityPrompt du stand "dragon shop".
-- Acheter un dragon l'équipe tout de suite ; on peut ensuite changer librement entre ceux qu'on possède.
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ProximityPromptService = game:GetService("ProximityPromptService")

local dragonSystem = ReplicatedStorage:WaitForChild("DragonSystem")
local DragonConfig = require(dragonSystem:WaitForChild("DragonConfig"))
local dragonShop = dragonSystem:WaitForChild("DragonShop")
local templates = ReplicatedStorage:WaitForChild("Dragons")
local EggConfig = require(ReplicatedStorage:WaitForChild("EggSystem"):WaitForChild("EggConfig"))

local player = Players.LocalPlayer
local gui = script.Parent
local main = gui:WaitForChild("Main")
local list = main:WaitForChild("List")
local cardTemplate = script:WaitForChild("CardTemplate")

local PROMPT_NAME = "DragonShopPrompt"
local CLOSE_DISTANCE = 26
local EQUIPPED = ColorSequence.new(Color3.fromRGB(130, 214, 255), Color3.fromRGB(70, 140, 236))
local EQUIP = ColorSequence.new(Color3.fromRGB(150, 240, 110), Color3.fromRGB(54, 176, 70))
local CAN_BUY = ColorSequence.new(Color3.fromRGB(255, 214, 96), Color3.fromRGB(245, 150, 50))
local TOO_EXPENSIVE = ColorSequence.new(Color3.fromRGB(206, 206, 216), Color3.fromRGB(150, 150, 166))
local SELECTED_OUTLINE, NORMAL_OUTLINE = Color3.fromRGB(80, 170, 255), Color3.fromRGB(36, 23, 51)

local cards = {}
local shopPosition

local function fillViewport(view, key)
	local template = templates:FindFirstChild(key)
	if not template then return end
	local model = template:Clone()
	model:PivotTo(CFrame.new())
	model.Parent = view
	local cf, size = model:GetBoundingBox()
	local camera = Instance.new("Camera")
	camera.FieldOfView = 40
	-- le dragon regarde vers +Z : vue de trois-quarts face
	camera.CFrame = CFrame.lookAt(cf.Position + Vector3.new(0.85, 0.3, 1).Unit * math.max(size.X, size.Y, size.Z) * 1.25, cf.Position)
	camera.Parent = view
	view.CurrentCamera = camera
end

local function refresh()
	local money = player:GetAttribute("Money") or 0
	local equipped = DragonConfig.Equipped(player)
	for key, entry in cards do
		local card, dragon = entry.Card, entry.Dragon
		local owned = DragonConfig.Owns(player, key)
		local button = card.Action
		if key == equipped then
			button.Text = "EQUIPPED"
			button.Shade.Color = EQUIPPED
		elseif owned then
			button.Text = "EQUIP"
			button.Shade.Color = EQUIP
		else
			button.Text = EggConfig.FormatMoney(dragon.Price)
			button.Shade.Color = money >= dragon.Price and CAN_BUY or TOO_EXPENSIVE
		end
		card.Outline.Color = key == equipped and SELECTED_OUTLINE or NORMAL_OUTLINE
		card.Outline.Thickness = key == equipped and 6 or 4
		card.Tagline.Text = (owned and key ~= equipped) and "Owned" or dragon.Tagline
	end
end

for order, dragon in DragonConfig.List do
	local card = cardTemplate:Clone()
	card.Name = dragon.Key
	card.LayoutOrder = order
	card.DragonName.Text = dragon.Name
	card.Bonus.Text = string.format("Stamina x%g", dragon.StaminaMult)
	card.Bonus.Visible = dragon.StaminaMult > 1
	fillViewport(card.View, dragon.Key)
	card.Action.Activated:Connect(function()
		if DragonConfig.Owns(player, dragon.Key) then
			dragonShop:FireServer("Equip", dragon.Key)
		else
			dragonShop:FireServer("Buy", dragon.Key)
		end
	end)
	card.Parent = list
	cards[dragon.Key] = {Card = card, Dragon = dragon}
end
-- portrait du dragon équipé dans le bandeau
local headerView = main:WaitForChild("Band"):WaitForChild("HeaderView")
local function refreshHeader()
	headerView:ClearAllChildren()
	fillViewport(headerView, DragonConfig.Equipped(player))
end
refreshHeader()
player:GetAttributeChangedSignal("Dragon"):Connect(refreshHeader)
player:GetAttributeChangedSignal("Dragon"):Connect(refresh)
player:GetAttributeChangedSignal("OwnedDragons"):Connect(refresh)
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
