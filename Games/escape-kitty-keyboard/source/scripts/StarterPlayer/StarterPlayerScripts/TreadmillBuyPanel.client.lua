local Players = game:GetService("Players")
local MarketplaceService = game:GetService("MarketplaceService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local ClientState = require(ReplicatedStorage:WaitForChild("ClientState"))

-- Remote references
local showBuyPanelRemote = Remotes:WaitForChild("ShowTreadmillBuyPanel")
local accessUpdateRemote = Remotes:WaitForChild("TreadmillAccessUpdate")
local recheckRemote = Remotes:WaitForChild("RecheckTreadmillAccess")

-- Colors for each treadmill type
local TREADMILL_COLORS = {
	Gold = Color3.fromRGB(255, 215, 0),
	Diamond = Color3.fromRGB(0, 191, 255),
	Candy = Color3.fromRGB(255, 105, 180),
	Admin = Color3.fromRGB(255, 50, 50),
}

-- Build the buy panel UI inside GamepassPromptGui
local function createBuyPanel()
	local gui = playerGui:FindFirstChild("GamepassPromptGui")
	if not gui then
		gui = Instance.new("ScreenGui")
		gui.Name = "GamepassPromptGui"
		gui.ResetOnSpawn = false
		gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
		gui.Parent = playerGui
	end

	-- Main container
	local frame = Instance.new("Frame")
	frame.Name = "BuyPanel"
	frame.Size = UDim2.new(0, 380, 0, 260)
	frame.Position = UDim2.new(0.5, -190, 0.5, -130)
	frame.AnchorPoint = Vector2.new(0, 0)
	frame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
	frame.BorderSizePixel = 0
	frame.Visible = false
	frame.ZIndex = 100

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 14)
	corner.Parent = frame

	local stroke = Instance.new("UIStroke")
	stroke.Name = "BorderStroke"
	stroke.Color = Color3.fromRGB(100, 100, 120)
	stroke.Thickness = 2
	stroke.Parent = frame

	-- Lock icon + title
	local title = Instance.new("TextLabel")
	title.Name = "Title"
	title.Size = UDim2.new(1, -50, 0, 45)
	title.Position = UDim2.new(0, 20, 0, 10)
	title.BackgroundTransparency = 1
	title.Text = "ACCESS REQUIRED"
	title.TextColor3 = Color3.fromRGB(255, 255, 255)
	title.TextSize = 20
	title.Font = Enum.Font.GothamBold
	title.TextXAlignment = Enum.TextXAlignment.Left
	title.ZIndex = frame.ZIndex + 1
	title.Parent = frame

	-- Close button
	local closeButton = Instance.new("TextButton")
	closeButton.Name = "CloseButton"
	closeButton.Size = UDim2.new(0, 32, 0, 32)
	closeButton.Position = UDim2.new(1, -42, 0, 12)
	closeButton.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
	closeButton.BorderSizePixel = 0
	closeButton.Text = "X"
	closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
	closeButton.TextSize = 16
	closeButton.Font = Enum.Font.GothamBold
	closeButton.ZIndex = frame.ZIndex + 2
	closeButton.Parent = frame

	local closeCorner = Instance.new("UICorner")
	closeCorner.CornerRadius = UDim.new(0, 8)
	closeCorner.Parent = closeButton

	-- Separator line
	local separator = Instance.new("Frame")
	separator.Name = "Separator"
	separator.Size = UDim2.new(1, -40, 0, 1)
	separator.Position = UDim2.new(0, 20, 0, 58)
	separator.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
	separator.BorderSizePixel = 0
	separator.ZIndex = frame.ZIndex + 1
	separator.Parent = frame

	-- Treadmill name label
	local treadmillName = Instance.new("TextLabel")
	treadmillName.Name = "TreadmillName"
	treadmillName.Size = UDim2.new(1, -40, 0, 40)
	treadmillName.Position = UDim2.new(0, 20, 0, 68)
	treadmillName.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
	treadmillName.BorderSizePixel = 0
	treadmillName.Text = ""
	treadmillName.TextColor3 = Color3.fromRGB(255, 215, 0)
	treadmillName.TextSize = 18
	treadmillName.Font = Enum.Font.GothamBold
	treadmillName.ZIndex = frame.ZIndex + 1
	treadmillName.Parent = frame

	local nameCorner = Instance.new("UICorner")
	nameCorner.CornerRadius = UDim.new(0, 8)
	nameCorner.Parent = treadmillName

	-- Description text
	local desc = Instance.new("TextLabel")
	desc.Name = "Description"
	desc.Size = UDim2.new(1, -40, 0, 35)
	desc.Position = UDim2.new(0, 20, 0, 118)
	desc.BackgroundTransparency = 1
	desc.Text = "You need a gamepass to use this treadmill!"
	desc.TextColor3 = Color3.fromRGB(170, 170, 200)
	desc.TextSize = 13
	desc.Font = Enum.Font.Gotham
	desc.TextWrapped = true
	desc.ZIndex = frame.ZIndex + 1
	desc.Parent = frame

	-- Buy button
	local buyButton = Instance.new("TextButton")
	buyButton.Name = "BuyButton"
	buyButton.Size = UDim2.new(0.7, 0, 0, 44)
	buyButton.Position = UDim2.new(0.15, 0, 0, 165)
	buyButton.BackgroundColor3 = Color3.fromRGB(0, 160, 0)
	buyButton.BorderSizePixel = 0
	buyButton.Text = "Buy Gamepass"
	buyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
	buyButton.TextSize = 16
	buyButton.Font = Enum.Font.GothamBold
	buyButton.ZIndex = frame.ZIndex + 2
	buyButton.AutoButtonColor = true
	buyButton.Parent = frame

	local buyCorner = Instance.new("UICorner")
	buyCorner.CornerRadius = UDim.new(0, 10)
	buyCorner.Parent = buyButton

	-- Hover effect for buy button
	buyButton.MouseEnter:Connect(function()
		TweenService:Create(buyButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(0, 200, 0)}):Play()
	end)
	buyButton.MouseLeave:Connect(function()
		TweenService:Create(buyButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(0, 160, 0)}):Play()
	end)

	-- Info text at bottom
	local info = Instance.new("TextLabel")
	info.Name = "InfoText"
	info.Size = UDim2.new(1, -40, 0, 25)
	info.Position = UDim2.new(0, 20, 0, 220)
	info.BackgroundTransparency = 1
	info.Text = "Purchase is permanent and works across all servers"
	info.TextColor3 = Color3.fromRGB(120, 120, 150)
	info.TextSize = 11
	info.Font = Enum.Font.Gotham
	info.ZIndex = frame.ZIndex + 1
	info.Parent = frame

	frame.Parent = gui
	return frame
end

local buyPanel = createBuyPanel()
local currentGamepassId = nil

-- Show buy panel
local function showBuyPanel(treadmillType, gamepassId, treadmillDisplayName)
	if not buyPanel then return end

	currentGamepassId = gamepassId

	-- Update treadmill name and colors
	local nameLabel = buyPanel:FindFirstChild("TreadmillName")
	if nameLabel then
		nameLabel.Text = treadmillDisplayName
		nameLabel.TextColor3 = TREADMILL_COLORS[treadmillType] or Color3.fromRGB(255, 255, 255)
	end

	-- Update border color
	local stroke = buyPanel:FindFirstChild("BorderStroke")
	if stroke then
		stroke.Color = TREADMILL_COLORS[treadmillType] or Color3.fromRGB(100, 100, 120)
	end

	-- Update buy button color to match treadmill theme
	local buyButton = buyPanel:FindFirstChild("BuyButton")
	if buyButton then
		local baseColor = TREADMILL_COLORS[treadmillType] or Color3.fromRGB(0, 160, 0)
		local darkerColor = Color3.new(baseColor.R * 0.6, baseColor.G * 0.6, baseColor.B * 0.6)
		buyButton.BackgroundColor3 = darkerColor
	end

	-- Show panel
	buyPanel.Visible = true
end

-- Hide buy panel
local function hideBuyPanel()
	if buyPanel then
		buyPanel.Visible = false
		currentGamepassId = nil
	end
end

-- Connect buttons
if buyPanel then
	local buyButton = buyPanel:FindFirstChild("BuyButton")
	if buyButton then
		buyButton.MouseButton1Click:Connect(function()
			if currentGamepassId then
				MarketplaceService:PromptGamePassPurchase(player, currentGamepassId)
			end
		end)
	end

	local closeButton = buyPanel:FindFirstChild("CloseButton")
	if closeButton then
		closeButton.MouseButton1Click:Connect(hideBuyPanel)
	end
end

-- Listen for show buy panel remote (from server)
showBuyPanelRemote.OnClientEvent:Connect(function(treadmillType, gamepassId, treadmillDisplayName)
	showBuyPanel(treadmillType, gamepassId, treadmillDisplayName)
end)

-- Listen for access updates from server
accessUpdateRemote.OnClientEvent:Connect(function(accessFlags)
	-- Update ClientState flags
	local data = ClientState:Get()
	if data then
		for key, value in pairs(accessFlags) do
			data[key] = value
		end
	end

	-- If we now have access, hide the buy panel
	hideBuyPanel()
end)

-- Handle gamepass purchase completion
MarketplaceService.PromptGamePassPurchaseFinished:Connect(function(purchaser, purchasedGamepassId, wasPurchased)
	if purchaser == player and wasPurchased then
		-- Request server to recheck our access
		recheckRemote:FireServer()
	end
end)