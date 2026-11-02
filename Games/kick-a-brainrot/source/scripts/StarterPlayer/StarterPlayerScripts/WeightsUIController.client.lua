--!strict
-- LOCATION: StarterPlayerScripts/WeightsUIController

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MarketplaceService = game:GetService("MarketplaceService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- [ MODULES ]
local NumberFormatter = require(ReplicatedStorage:WaitForChild("Modules"):WaitForChild("NumberFormatter"))
local WeightConfigurations = require(ReplicatedStorage:WaitForChild("Modules"):WaitForChild("WeightConfigurations"))

-- [ ASSETS & UI REFERENCES ]
local Templates = ReplicatedStorage:WaitForChild("Templates")
local WeightTemplate = Templates:WaitForChild("WeightTemplate")
local Events = ReplicatedStorage:WaitForChild("Events")

local gui = playerGui:WaitForChild("GUI")
local frames = gui:WaitForChild("Frames")
local weightsFrame = frames:WaitForChild("Weights")
local scrolling = weightsFrame:WaitForChild("Scrolling")

-- Animation Config
local HOVER_SCALE = 1.05
local CLICK_SCALE = 0.95
local TWEEN_INFO = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

print("[WeightsUIController] Loaded")

-- [ STATE ]
local getUnlockedWeightsEvent = Events:WaitForChild("GetUnlockedWeights", 10)
local unlockedWeights = {}
local equippedWeight: string? = nil -- Track the active weight

if getUnlockedWeightsEvent then
	local success, data = pcall(function() return getUnlockedWeightsEvent:InvokeServer() end)
	if success and data then unlockedWeights = data end
end

-- [ HELPER: Find Currently Equipped Tool ]
local function findInitialEquipped()
	local char = player.Character
	local backpack = player:FindFirstChild("Backpack")

	if char then
		for _, item in ipairs(char:GetChildren()) do
			if item:IsA("Tool") and item:GetAttribute("IsWeight") then return item.Name end
		end
	end
	if backpack then
		for _, item in ipairs(backpack:GetChildren()) do
			if item:IsA("Tool") and item:GetAttribute("IsWeight") then return item.Name end
		end
	end
	return nil
end

-- [ HELPER: Button Animation ]
local function setupButtonAnimation(button: GuiButton)
	local uiScale = button:FindFirstChildOfClass("UIScale")
	if not uiScale then
		uiScale = Instance.new("UIScale")
		uiScale.Name = "AnimationScale"
		uiScale.Parent = button
	end

	button.MouseEnter:Connect(function() TweenService:Create(uiScale, TWEEN_INFO, {Scale = HOVER_SCALE}):Play() end)
	button.MouseLeave:Connect(function() TweenService:Create(uiScale, TWEEN_INFO, {Scale = 1}):Play() end)
	button.MouseButton1Down:Connect(function() TweenService:Create(uiScale, TWEEN_INFO, {Scale = CLICK_SCALE}):Play() end)
	button.MouseButton1Up:Connect(function() TweenService:Create(uiScale, TWEEN_INFO, {Scale = HOVER_SCALE}):Play() end)
end

-- [ HELPER: Sort Weights by Price ]
local function getSortedWeights()
	local sorted = {}
	for name, data in pairs(WeightConfigurations.Weights) do
		table.insert(sorted, {Name = name, Data = data})
	end

	table.sort(sorted, function(a, b)
		if a.Data.Price == b.Data.Price then
			return a.Name < b.Name 
		end
		return a.Data.Price < b.Data.Price
	end)

	return sorted
end

-- [ HELPER: Update All Button States ]
local function updateButtonStates()
	for _, child in ipairs(scrolling:GetChildren()) do
		if child:IsA("Frame") then
			local weightName = child.Name
			local data = WeightConfigurations.GetWeightData(weightName)
			if not data then continue end

			local buttonsContainer = child:FindFirstChild("Buttons")
			if buttonsContainer then
				local buyButton = buttonsContainer:FindFirstChild("Buy") :: TextButton
				local robuxButton = buttonsContainer:FindFirstChild("Robux") :: TextButton
				local priceLabel = buyButton and buyButton:FindFirstChild("Text") :: TextLabel

				if buyButton and priceLabel then
					if equippedWeight == weightName then
						-- Active Weight
						priceLabel.Text = "EQUIPPED"
						buyButton.BackgroundColor3 = Color3.fromRGB(0, 100, 0) -- Darker Green
						if robuxButton then robuxButton.Visible = false end

					elseif unlockedWeights[weightName] then
						-- Owned but inactive
						priceLabel.Text = "EQUIP"
						buyButton.BackgroundColor3 = Color3.fromRGB(0, 150, 0) -- Lighter Green
						if robuxButton then robuxButton.Visible = false end

					else
						-- Unowned
						priceLabel.Text = data.Price > 0 and "$" .. NumberFormatter.Format(data.Price) or "FREE"
						buyButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50) -- Default Grey
						if robuxButton and data.ProductId then
							robuxButton.Visible = true
						end
					end
				end
			end
		end
	end
end

-- [ CORE LOGIC: Populate UI ]
local function populateWeights()
	for _, child in ipairs(scrolling:GetChildren()) do
		if child:IsA("Frame") then child:Destroy() end
	end

	local buyWeightEvent = Events:FindFirstChild("RequestWeightPurchase")
	if not buyWeightEvent then
		buyWeightEvent = Instance.new("RemoteEvent")
		buyWeightEvent.Name = "RequestWeightPurchase"
		buyWeightEvent.Parent = Events
	end

	local sortedWeights = getSortedWeights()
	for index, weightInfo in ipairs(sortedWeights) do
		local weightName = weightInfo.Name
		local data = weightInfo.Data

		local template = WeightTemplate:Clone()
		template.Name = weightName
		template.LayoutOrder = index 
		template.Parent = scrolling
		template.Visible = true

		local nameLabel = template:FindFirstChild("Name") :: TextLabel
		local powerLabel = template:FindFirstChild("Power") :: TextLabel
		local imageLabel = template:FindFirstChild("Image") :: ImageLabel 
		local buttonsContainer = template:FindFirstChild("Buttons")

		if nameLabel then nameLabel.Text = weightName end
		if powerLabel then powerLabel.Text = "+" .. NumberFormatter.Format(data.Power) .. " Power/s" end
		if imageLabel and data.ImageId then imageLabel.Image = data.ImageId end

		if buttonsContainer then
			local buyButton = buttonsContainer:FindFirstChild("Buy") :: TextButton
			local robuxButton = buttonsContainer:FindFirstChild("Robux") :: TextButton

			if buyButton then
				setupButtonAnimation(buyButton)

				buyButton.MouseButton1Click:Connect(function()
					-- Prevent spamming network if it's already the equipped item
					if equippedWeight ~= weightName then
						buyWeightEvent:FireServer(weightName)
					end
				end)
			end

			if robuxButton then
				if data.ProductId then
					setupButtonAnimation(robuxButton)

					local robuxPriceLabel = robuxButton:FindFirstChild("Text") :: TextLabel
					task.spawn(function()
						local success, info = pcall(function()
							return MarketplaceService:GetProductInfo(data.ProductId, Enum.InfoType.Product)
						end)
						if success and info and robuxPriceLabel then
							robuxPriceLabel.Text = "" .. tostring(info.PriceInRobux)
						else
							if robuxPriceLabel then robuxPriceLabel.Text = "N/A" end
						end
					end)

					robuxButton.MouseButton1Click:Connect(function()
						MarketplaceService:PromptProductPurchase(player, data.ProductId)
					end)
				else
					robuxButton.Visible = false
				end
			end
		end
	end

	-- Establish initial state before applying visuals
	equippedWeight = findInitialEquipped()
	updateButtonStates()
end

-- Initialize UI
populateWeights()

-- [ REAL-TIME UPDATES ]
local updateWeightsUI = Events:WaitForChild("UpdateWeightsUI")
updateWeightsUI.OnClientEvent:Connect(function(weightName: string)
	unlockedWeights[weightName] = true
	equippedWeight = weightName -- Mark this as the newly active weight

	updateButtonStates() -- Refresh the colors and text of all buttons
end)

-- ## ADDED: Handle Rebirth Wipes ##
local resetWeightsUI = Events:WaitForChild("ResetWeightsUI")
resetWeightsUI.OnClientEvent:Connect(function()
	unlockedWeights = {}
	equippedWeight = nil
	updateButtonStates()
end)