local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MarketplaceService = game:GetService("MarketplaceService")
local TweenService = game:GetService("TweenService")

local LocalPlayer = Players.LocalPlayer
local v1 = script.Parent
local TitleForegroundImage = v1:WaitForChild("TitleForegroundImage")
local UIStroke = TitleForegroundImage:WaitForChild("UIStroke")
local NameLabel = v1:WaitForChild("NameLabel")
local PriceRobux = v1:WaitForChild("PriceRobux")
local Icon = v1:WaitForChild("Icon")
local v2 = TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, 0, true)
local v3 = utf8.char(57346)

local SPEED_X2_GAMEPASS_ID = 1908001145

local offer = {
	name = "x2 Speed",
	price = "149",
	icon = "rbxassetid://80413302121656",
	theme = "yellow",
	gamepassId = SPEED_X2_GAMEPASS_ID
}

local function setText(p1, p2)
	p1.Text = p2
	local v1 = p1:FindFirstChild(p1.Name)
	if not (v1 and v1:IsA("TextLabel")) then
		return
	end
	v1.Text = p2
end

local function applyOffer(p1)
	local name = p1.name
	NameLabel.Text = name
	local nested = NameLabel:FindFirstChild(NameLabel.Name)
	if nested and nested:IsA("TextLabel") then
		nested.Text = name
	end

	local priceText = v3 .. p1.price
	PriceRobux.Text = priceText
	local nestedPrice = PriceRobux:FindFirstChild(PriceRobux.Name)
	if nestedPrice and nestedPrice:IsA("TextLabel") then
		nestedPrice.Text = priceText
	end

	Icon.Image = p1.icon

	local theme = p1.theme or "green"
	TitleForegroundImage.GreenGradient.Enabled = theme == "green"
	TitleForegroundImage.YellowGradient.Enabled = theme == "yellow"
	TitleForegroundImage.PurpleGradient.Enabled = theme == "purple"
	UIStroke.GreenGradient.Enabled = theme == "green"
	UIStroke.YellowGradient.Enabled = theme == "yellow"
	UIStroke.PurpleGradient.Enabled = theme == "purple"
end

local Size = v1.Size

local function bump()
	v1.Size = Size
	TweenService:Create(v1, v2, {
		Size = UDim2.new(Size.X.Scale * 1.12, Size.X.Offset * 1.12, Size.Y.Scale * 1.12, Size.Y.Offset * 1.12)
	}):Play()
end

applyOffer(offer)

v1.MouseButton1Click:Connect(function()
	if not (offer.gamepassId and offer.gamepassId > 0) then
		return
	end

	local ok, result = pcall(function()
		return ReplicatedStorage:FindFirstChild("PurchaseEffectShow")
	end)

	if ok and result then
		result:Fire()
	end

	pcall(function()
		MarketplaceService:PromptGamePassPurchase(LocalPlayer, offer.gamepassId)
	end)
end)
