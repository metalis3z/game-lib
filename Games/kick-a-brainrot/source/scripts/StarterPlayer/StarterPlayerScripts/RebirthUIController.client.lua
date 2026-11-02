--!strict
-- LOCATION: StarterPlayerScripts/RebirthUIController

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MarketplaceService = game:GetService("MarketplaceService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local Modules = ReplicatedStorage:WaitForChild("Modules", 10)
if not Modules then return end
local ProductConfigurations = require(Modules:WaitForChild("ProductConfigurations"))
local NumberFormatter = require(Modules:WaitForChild("NumberFormatter")) 

local Events = ReplicatedStorage:WaitForChild("Events", 10)
local RequestRebirth = Events:WaitForChild("RequestRebirth")
local UpdateEvent = Events:WaitForChild("UpdateRebirthUI")

local function getGUI(parent: Instance, name: string): Instance?
	local element = parent:WaitForChild(name, 10)
	if not element then
		warn("[RebirthUIController] Missing UI Element: " .. name .. " inside " .. parent.Name)
	end
	return element
end

local gui = getGUI(playerGui, "GUI")
if not gui then return end

local hud = getGUI(gui, "HUD")
local hudLeft = hud and getGUI(hud, "Left")
local hudLeftBtns = hudLeft and getGUI(hudLeft, "Buttons")

local hudRebirthBtn = hudLeftBtns and getGUI(hudLeftBtns, "Rebirth") :: TextButton
local notificationDot = hudRebirthBtn and hudRebirthBtn:FindFirstChild("Notification") :: Frame

local frames = getGUI(gui, "Frames")
local rebirthFrame = frames and getGUI(frames, "Rebirth")
local contentFrame = rebirthFrame and getGUI(rebirthFrame, "Frame") 

local statsFrame = contentFrame and getGUI(contentFrame, "Stats")
local beforeFrame = statsFrame and getGUI(statsFrame, "Before")
local afterFrame = statsFrame and getGUI(statsFrame, "After")

local beforeMoney = beforeFrame and getGUI(beforeFrame, "Money")
local afterMoney = afterFrame and getGUI(afterFrame, "Money")
local beforeLabel = beforeMoney and getGUI(beforeMoney, "Text") :: TextLabel
local afterLabel = afterMoney and getGUI(afterMoney, "Text") :: TextLabel

-- ## NEW: Power Label References ##
local beforePower = beforeFrame and getGUI(beforeFrame, "Power")
local afterPower = afterFrame and getGUI(afterFrame, "Power")
local beforePowerLabel = beforePower and getGUI(beforePower, "Text") :: TextLabel
local afterPowerLabel = afterPower and getGUI(afterPower, "Text") :: TextLabel

local barFrame = contentFrame and getGUI(contentFrame, "Bar")
local progressFill = barFrame and getGUI(barFrame, "Progress") :: Frame
local progressText = barFrame and getGUI(barFrame, "Text") :: TextLabel

local rebirthButton = rebirthFrame and getGUI(rebirthFrame, "Rebirth") :: TextButton
local skipButton = rebirthFrame and getGUI(rebirthFrame, "Skip") :: TextButton

if not (beforeLabel and afterLabel and progressFill and progressText and rebirthButton) then
	return
end

local BASE_POWER_COST = 1000 
local TWEEN_INFO = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

local function getRebirthCost(rebirths: number): number
	return BASE_POWER_COST * (math.pow(2, rebirths))
end

local function updateUI()
	local leaderstats = player:FindFirstChild("leaderstats")

	if not leaderstats then return end

	local powerStat = leaderstats:FindFirstChild("Power") :: NumberValue
	if not powerStat then return end
	local currentPower = powerStat.Value

	local rebirthsStat = leaderstats:FindFirstChild("Rebirths") :: NumberValue
	if not rebirthsStat then return end
	local rebirths = rebirthsStat.Value

	local cost = getRebirthCost(rebirths)

	-- Calculate both Multipliers
	local currentCashMult = 1 + (rebirths * 0.5)
	local nextCashMult = 1 + ((rebirths + 1) * 0.5)
	local currentPowerMult = 1 + (rebirths * 0.25)
	local nextPowerMult = 1 + ((rebirths + 1) * 0.25)

	-- %g intelligently removes trailing zeroes while keeping decimals precise (e.g. 1.25, 1.5, 2)
	beforeLabel.Text = "x" .. string.format("%g", currentCashMult)
	afterLabel.Text = "x" .. string.format("%g", nextCashMult)

	if beforePowerLabel then beforePowerLabel.Text = "x" .. string.format("%g", currentPowerMult) end
	if afterPowerLabel then afterPowerLabel.Text = "x" .. string.format("%g", nextPowerMult) end

	local percentage = math.clamp(currentPower / cost, 0, 1)

	progressText.Text = "Power " .. NumberFormatter.Format(currentPower) .. " / " .. NumberFormatter.Format(cost)
	TweenService:Create(progressFill, TWEEN_INFO, {Size = UDim2.fromScale(percentage, 1)}):Play()

	if notificationDot then
		notificationDot.Visible = (currentPower >= cost)
	end

	if currentPower >= cost then
		rebirthButton.AutoButtonColor = true
		rebirthButton.BackgroundColor3 = Color3.fromRGB(0, 170, 0) 
	else
		rebirthButton.AutoButtonColor = false
		rebirthButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100) 
	end
end

rebirthButton.MouseButton1Click:Connect(function()
	RequestRebirth:FireServer()
end)

if skipButton then
	skipButton.MouseButton1Click:Connect(function()
		local productId = ProductConfigurations.Products["SkipRebirth"]
		if productId then MarketplaceService:PromptProductPurchase(player, productId) end
	end)
end

local function hookLeaderstats()
	local leaderstats = player:WaitForChild("leaderstats", 10)

	if not leaderstats then return end

	local powerStat = leaderstats:WaitForChild("Power", 10)
	local rebirthsStat = leaderstats:WaitForChild("Rebirths", 10)

	if powerStat then 
		powerStat.Changed:Connect(updateUI) 
	end

	if rebirthsStat then 
		rebirthsStat.Changed:Connect(updateUI) 
	end

	updateUI()
end

task.spawn(hookLeaderstats)
UpdateEvent.OnClientEvent:Connect(updateUI)

print("[RebirthUIController] Loaded (Dual Multipliers)")