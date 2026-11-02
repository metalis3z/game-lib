local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Animals = require(ReplicatedStorage.Shared.Animals)

local ShopManager = {}

function ShopManager.createItem(parent, name, price)
	local itemFrame = Instance.new("Frame")
	itemFrame.Name = "Item_" .. tostring(name)
	itemFrame.Size = UDim2.new(0, 160, 0, 155)
	itemFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
	itemFrame.BorderSizePixel = 0

	local itemCorner = Instance.new("UICorner")
	itemCorner.CornerRadius = UDim.new(0, 12)
	itemCorner.Parent = itemFrame

	local itemStroke = Instance.new("UIStroke")
	itemStroke.Color = Color3.fromRGB(100, 70, 200)
	itemStroke.Thickness = 2
	itemStroke.Parent = itemFrame

	local itemImage = Instance.new("ViewportFrame")
	itemImage.Name = "ItemImage"
	itemImage.Size = UDim2.new(0, 80, 0, 80)
	itemImage.Position = UDim2.new(0.5, -40, 0, 10)
	itemImage.BackgroundColor3 = Color3.fromRGB(50, 50, 80)
	itemImage.BorderSizePixel = 0
	itemImage.Parent = itemFrame

	local imageCorner = Instance.new("UICorner")
	imageCorner.CornerRadius = UDim.new(0, 10)
	imageCorner.Parent = itemImage

	local animalName = tostring(name)
	local animalModel = ReplicatedStorage.Models.Animals:FindFirstChild(animalName)

	if animalModel then
		Animals:AttachOnViewport(animalName, itemImage)
	else
		warn("Animal not found:", animalName)
	end

	local itemName = Instance.new("TextLabel")
	itemName.Name = "ItemName"
	itemName.Size = UDim2.new(1, 0, 0, 25)
	itemName.Position = UDim2.new(0, 0, 0, 95)
	itemName.BackgroundTransparency = 1
	itemName.Text = animalName
	itemName.TextColor3 = Color3.new(1, 1, 1)
	itemName.TextSize = 18
	itemName.Font = Enum.Font.GothamBold
	itemName.Parent = itemFrame

	local priceLabel = Instance.new("TextLabel")
	priceLabel.Name = "PriceLabel"
	priceLabel.Size = UDim2.new(0.5, 0, 0, 20)
	priceLabel.Position = UDim2.new(0, 5, 0, 120)
	priceLabel.BackgroundTransparency = 1
	priceLabel.Text = "💰 " .. tostring(price)
	priceLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
	priceLabel.TextSize = 16
	priceLabel.Font = Enum.Font.GothamSemibold
	priceLabel.TextXAlignment = Enum.TextXAlignment.Left
	priceLabel.Parent = itemFrame

	local buyButton = Instance.new("TextButton")
	buyButton.Name = "BuyButton"
	buyButton.Size = UDim2.new(0, 50, 0, 25)
	buyButton.Position = UDim2.new(1, -55, 0, 120)
	buyButton.BackgroundColor3 = Color3.fromRGB(80, 200, 120)
	buyButton.Text = "BUY"
	buyButton.TextColor3 = Color3.new(1, 1, 1)
	buyButton.TextSize = 14
	buyButton.Font = Enum.Font.GothamBold
	buyButton.Parent = itemFrame

	local buyCorner = Instance.new("UICorner")
	buyCorner.CornerRadius = UDim.new(0, 6)
	buyCorner.Parent = buyButton

	buyButton.MouseEnter:Connect(function()
		TweenService:Create(buyButton, TweenInfo.new(0.2), {
			BackgroundColor3 = Color3.fromRGB(100, 255, 150),
			Size = UDim2.new(0, 55, 0, 28)
		}):Play()
	end)

	buyButton.MouseLeave:Connect(function()
		TweenService:Create(buyButton, TweenInfo.new(0.2), {
			BackgroundColor3 = Color3.fromRGB(80, 200, 120),
			Size = UDim2.new(0, 50, 0, 25)
		}):Play()
	end)

	itemFrame.Parent = parent
	return itemFrame
end

return ShopManager