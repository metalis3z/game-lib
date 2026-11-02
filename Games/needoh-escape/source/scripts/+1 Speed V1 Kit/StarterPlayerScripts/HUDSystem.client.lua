--!strict
-- LOCATION: StarterPlayerScripts/HUDSystem

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MarketplaceService = game:GetService("MarketplaceService")

local NumberFormatter = require(ReplicatedStorage.Modules.NumberFormatter)
local MonetizationSystem = require(ReplicatedStorage.Modules.MonetizationSystem)
local ProductConfigurations = require(ReplicatedStorage.Modules.ProductConfigurations)

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local gui = playerGui:WaitForChild("GUI")
local hud = gui:WaitForChild("HUD")
local eventsFolder = ReplicatedStorage:WaitForChild("Events")

local statsConnected = false

local function setupWinsHUD()
	local leftFrame = hud:WaitForChild("Left")
	local winsFrame = leftFrame:WaitForChild("Wins")
	local winTextLabel = winsFrame:WaitForChild("Text") :: TextLabel
	local moreButton = winsFrame:WaitForChild("More") :: ImageButton

	local function updateWinsText()
		local leaderstats = player:FindFirstChild("leaderstats")
		if not leaderstats then return end
		local winsValue = leaderstats:FindFirstChild("Wins") :: IntValue
		if winsValue then
			winTextLabel.Text = NumberFormatter.Format(winsValue.Value)
		end
	end

	moreButton.MouseButton1Click:Connect(function()
		MonetizationSystem.PromptGamePass(ProductConfigurations.DoubleWinsGP)
	end)

	local leaderstats = player:WaitForChild("leaderstats", 10)
	if leaderstats then
		local wins = leaderstats:WaitForChild("Wins") :: IntValue
		wins.Changed:Connect(updateWinsText)
		updateWinsText()
	end
end

local function setupSpeedShopHUD()
	local bottomFrame = hud:WaitForChild("Bottom")
	local speedShopFrame = bottomFrame:WaitForChild("Speed")
	local products = ProductConfigurations.SpeedProducts
	if not products then return end

	for index, productInfo in ipairs(products) do
		local buttonName = "Product" .. tostring(index)
		local button = speedShopFrame:FindFirstChild(buttonName) :: TextButton
		if button then
			local textLabel = button:FindFirstChild("Text") :: TextLabel
			if textLabel then
				textLabel.Text = "+" .. NumberFormatter.Format(productInfo.Amount) .. " Speed"
			end
			button.MouseButton1Click:Connect(function()
				MonetizationSystem.PromptProduct(productInfo.Id)
			end)
		end
	end
end

local function setupCustomSpeedHUD()
	local rightFrame = hud:WaitForChild("Right")
	local customSpeedFrame = rightFrame:WaitForChild("CustomSpeed")
	local enterSpeedBox = customSpeedFrame:WaitForChild("EnterSpeed") :: TextBox
	local maxSpeedLabel = customSpeedFrame:WaitForChild("MaxSpeed") :: TextLabel

	local BASE_WALKSPEED = 8
	local SPEED_PER_LEVEL = 2.15

	-- FIX: fire to server so it actually sets WalkSpeed on the humanoid
	local setChosenSpeedEvent = eventsFolder:WaitForChild("SetChosenSpeed") :: RemoteEvent

	local isMaxSpeedMode = true

	local function getMaxSpeed(level: number): number
		-- FIX: round to avoid float display issues
		return math.round(BASE_WALKSPEED + (level - 1) * SPEED_PER_LEVEL)
	end

	local function updateDisplay()
		local leaderstats = player:FindFirstChild("leaderstats")
		if not leaderstats then return end
		local levelVal = leaderstats:FindFirstChild("Level")
		if not levelVal then return end
		local maxSpeed = getMaxSpeed(levelVal.Value)
		maxSpeedLabel.Text = "MAX: " .. NumberFormatter.Format(maxSpeed)
		if isMaxSpeedMode then
			enterSpeedBox.Text = tostring(maxSpeed)
			-- FIX: send 0 to server meaning "use max/level speed"
			setChosenSpeedEvent:FireServer(maxSpeed)
		end
	end

	enterSpeedBox.FocusLost:Connect(function()
		local leaderstats = player:FindFirstChild("leaderstats")
		if not leaderstats then return end
		local levelVal = leaderstats:FindFirstChild("Level")
		if not levelVal then return end
		local maxSpeed = getMaxSpeed(levelVal.Value)
		local inputNum = tonumber(enterSpeedBox.Text) or maxSpeed
		-- FIX: round so no decimals appear
		inputNum = math.round(math.clamp(inputNum, 0, maxSpeed))
		if inputNum >= maxSpeed then
			inputNum = maxSpeed
			isMaxSpeedMode = true
		else
			isMaxSpeedMode = false
		end
		enterSpeedBox.Text = tostring(inputNum)
		-- FIX: fire to server to actually apply WalkSpeed
		setChosenSpeedEvent:FireServer(inputNum)
	end)

	player.CharacterAdded:Connect(function()
		task.wait(0.1)
		updateDisplay()
	end)

	local leaderstats = player:WaitForChild("leaderstats", 10)
	if leaderstats then
		local level = leaderstats:WaitForChild("Level") :: IntValue
		level.Changed:Connect(updateDisplay)
		updateDisplay()
	end
end

local function setupSpeedPeakHUD()
	local rightFrame = hud:WaitForChild("Right")
	local speedPeakButton = rightFrame:WaitForChild("SpeedPeark") :: ImageButton
	local priceLabel = speedPeakButton:WaitForChild("Price") :: TextLabel
	local textLabel = speedPeakButton:WaitForChild("Text") :: TextLabel

	local currentTargetTier = nil

	local function refreshButton()
		currentTargetTier = nil
		for _, tier in ipairs(ProductConfigurations.SpeedPeakTiers) do
			-- FIX: check HiddenStats.SpeedPeakLevel to know what's owned without extra API calls
			local hiddenStats = player:FindFirstChild("HiddenStats")
			local savedLevel = hiddenStats and hiddenStats:FindFirstChild("SpeedPeakLevel")
			local isOwned = savedLevel and (tier.Level <= savedLevel.Value)
			if not isOwned then
				currentTargetTier = tier
				break
			end
		end

		if currentTargetTier then
			speedPeakButton.Visible = true
			textLabel.Text = "x" .. tostring(currentTargetTier.Level) .. " Speed"
			priceLabel.Text = "Loading..."
			task.spawn(function()
				local success, info = pcall(function()
					return MarketplaceService:GetProductInfo(currentTargetTier.Id, Enum.InfoType.GamePass)
				end)
				if success and info then
					priceLabel.Text = "ONLY " .. tostring(info.PriceInRobux)
				else
					priceLabel.Text = "Error"
				end
			end)
		else
			speedPeakButton.Visible = false
		end
	end

	speedPeakButton.MouseButton1Click:Connect(function()
		if currentTargetTier then
			MonetizationSystem.PromptGamePass(currentTargetTier.Id)
		end
	end)

	MarketplaceService.PromptGamePassPurchaseFinished:Connect(function()
		task.wait(0.5)
		refreshButton()
	end)

	-- FIX: re-check when HiddenStats.SpeedPeakLevel updates (set by server after purchase)
	local h = player:WaitForChild("HiddenStats", 10)
	if h then
		local sp = h:WaitForChild("SpeedPeakLevel", 10)
		if sp then
			sp.Changed:Connect(refreshButton)
		end
	end

	refreshButton()
end

local function init()
	if statsConnected then return end
	statsConnected = true
	task.spawn(setupWinsHUD)
	task.spawn(setupSpeedShopHUD)
	task.spawn(setupCustomSpeedHUD)
	task.spawn(setupSpeedPeakHUD)
end

init()