--!strict
-- LOCATION: StarterPlayerScripts/LimitedItemUIController

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MarketplaceService = game:GetService("MarketplaceService")
local Workspace = game:GetService("Workspace")

local ProductConfigurations = require(ReplicatedStorage:WaitForChild("Modules"):WaitForChild("ProductConfigurations"))
local ItemConfigurations = require(ReplicatedStorage:WaitForChild("Modules"):WaitForChild("ItemConfigurations"))
local NumberFormatter = require(ReplicatedStorage:WaitForChild("Modules"):WaitForChild("NumberFormatter"))
local NotificationManager = require(ReplicatedStorage:WaitForChild("Modules"):WaitForChild("NotificationManager"))

local player = Players.LocalPlayer
local Events = ReplicatedStorage:WaitForChild("Events")
local UpdateStockEvent = Events:WaitForChild("UpdateLimitedItemStock")

-- [ CONFIGURATION ]
local MUTATION_MULTIPLIERS = {
	["Normal"] = 1,
	["Golden"] = 2,
	["Diamond"] = 3,
	["Ruby"] = 4,
	["Neon"] = 5,
}

-- [ STATE ]
local currentStock = 0
local maxStock = ProductConfigurations.LimitedItem.MaxStock
local productId = ProductConfigurations.LimitedItem.ProductId
local touchDebounce = false

-- [ GUI REFERENCES ]
local stockLabel: TextLabel?

-- [ LOGIC ]
local function updateDisplay(stock: number, max: number)
	currentStock = stock
	maxStock = max

	if stockLabel then
		if stock <= 0 then
			stockLabel.Text = "SOLD OUT"
			stockLabel.TextColor3 = Color3.fromRGB(255, 50, 50) -- Red
		else
			stockLabel.Text = "Stock: " .. tostring(stock) .. "/" .. tostring(max)
			stockLabel.TextColor3 = Color3.fromRGB(255, 255, 255) -- White
		end
	end
end

local function handleTouch(hit: BasePart)
	if touchDebounce then return end

	local character = player.Character
	if not character then return end

	-- Verify the player's character touched the part
	if hit:IsDescendantOf(character) then
		touchDebounce = true

		if currentStock > 0 then
			MarketplaceService:PromptProductPurchase(player, productId)
		else
			NotificationManager.show("Sold Out!", "Error")
		end

		-- 1.5 second cooldown to prevent spamming the purchase prompt
		task.delay(1.5, function()
			touchDebounce = false
		end)
	end
end

local function handlePlot(plot: Model)
	local isMine = (plot.Name == "Plot_" .. player.Name)

	local limitedStock = plot:WaitForChild("LimitedStock", 10)
	if not limitedStock then return end

	local limitedGui = limitedStock:WaitForChild("LimitedGUI", 5) :: BillboardGui
	if not limitedGui then return end

	-- Hide GUI on plots that do not belong to the local player
	if not isMine then
		limitedGui.Enabled = false
		return
	end

	-- Enable and setup the GUI for the local player's plot
	limitedGui.Enabled = true

	local touchPart = limitedStock:WaitForChild("Touch", 5) :: BasePart
	if not touchPart then return end

	-- Find the TextLabels frame
	local textLabelsFrame = limitedGui:WaitForChild("TextLabels", 5) :: Frame
	if not textLabelsFrame then return end

	-- Grab references to your pre-made labels
	stockLabel = textLabelsFrame:WaitForChild("Stock", 5) :: TextLabel
	local nameLabel = textLabelsFrame:WaitForChild("Name", 5) :: TextLabel
	local earningsLabel = textLabelsFrame:WaitForChild("Earnings", 5) :: TextLabel

	-- Extract configured dynamic data
	local rewardConfig = ProductConfigurations.LimitedItem.Reward
	local configuredName = rewardConfig.Name
	local configuredMutation = rewardConfig.Mutation

	-- 1. Setup Dynamic Name
	if nameLabel then
		if configuredMutation == "Normal" then
			nameLabel.Text = configuredName
		else
			nameLabel.Text = configuredMutation .. " " .. configuredName
		end
	end

	-- 2. Setup Dynamic Earnings
	if earningsLabel then
		local itemData = ItemConfigurations.GetItemData(configuredName)
		if itemData and itemData.Income then
			local baseIncome = itemData.Income
			local mutMult = MUTATION_MULTIPLIERS[configuredMutation] or 1
			local totalIncome = baseIncome * mutMult

			earningsLabel.Text = "+$" .. NumberFormatter.Format(totalIncome) .. "/s"
		else
			earningsLabel.Text = "+$???/s"
		end
	end

	-- 3. Bind the touch event to prompt purchases
	touchPart.Touched:Connect(handleTouch)

	-- 4. Force an initial visual update for the stock
	updateDisplay(currentStock, maxStock)
end

-- [ INITIALIZATION ]
UpdateStockEvent.OnClientEvent:Connect(updateDisplay)

-- Monitor for existing Plots spawning
for _, child in ipairs(Workspace:GetChildren()) do
	if child:IsA("Model") and string.sub(child.Name, 1, 5) == "Plot_" then
		task.spawn(function()
			handlePlot(child)
		end)
	end
end

-- Monitor for new Plots spawning
Workspace.ChildAdded:Connect(function(child)
	if child:IsA("Model") and string.sub(child.Name, 1, 5) == "Plot_" then
		handlePlot(child)
	end
end)

print("[LimitedItemUIController] Loaded (Dynamic Configuration & Plot Ownership Integrated)")

return {}