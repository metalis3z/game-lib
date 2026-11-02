--!strict
-- LOCATION: StarterPlayerScripts/IngredientShopController
-- Populates the Ingredients frame (List.Template) with current stock and handles buy clicks.

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MarketplaceService = game:GetService("MarketplaceService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local Events = ReplicatedStorage:WaitForChild("Events")
local getStockRemote = Events:WaitForChild("GetIngredientShopStock")
local buyRemote = Events:WaitForChild("BuyIngredient")
local IngredientsFolder = ReplicatedStorage:WaitForChild("Ingredients")

local frame = playerGui:WaitForChild("GUI"):WaitForChild("Frames"):WaitForChild("Ingredients")
local list = frame:WaitForChild("List")
local template = list:WaitForChild("Template")

-- [ HELPERS ]
local function getIngredientImage(itemName: string): string
	local t = IngredientsFolder:FindFirstChild(itemName)
	if not t then return "" end
	local handle = t:FindFirstChild("Handle")
	if not handle then return "" end
	if handle:IsA("MeshPart") then
		return handle.TextureID
	end
	local decal = handle:FindFirstChildOfClass("Decal")
	if decal then return decal.Texture end
	local specialMesh = handle:FindFirstChildOfClass("SpecialMesh")
	if specialMesh then return specialMesh.TextureId end
	return ""
end

local function findTextLabel(parent: Instance): TextLabel?
	local label = parent:FindFirstChild("Title")
	if label and label:IsA("TextLabel") then return label end
	return parent:FindFirstChildWhichIsA("TextLabel", true)
end

local function populateStock(stock: {any})
	-- Clear previous items (keep the template and UIListLayout)
	for _, child in ipairs(list:GetChildren()) do
		if child ~= template and not child:IsA("UIListLayout") then child:Destroy() end
	end

	for index, item in ipairs(stock or {}) do
		local row = template:Clone()
		row.Name = item.Name
		row.Visible = true
		row.LayoutOrder = index

		local inner = row:FindFirstChild("Frame")
		if inner then
			-- Name
			local titleLabel = inner:FindFirstChild("Title")
			if titleLabel and titleLabel:IsA("TextLabel") then titleLabel.Text = item.Name end

			-- Rarity
			local rarityLabel = inner:FindFirstChild("Rarity")
			if rarityLabel and rarityLabel:IsA("TextLabel") then rarityLabel.Text = item.Rarity end

			-- Stock
			local stockLabel = inner:FindFirstChild("Stock")
			if stockLabel and stockLabel:IsA("TextLabel") then stockLabel.Text = "In Stock" end

			-- Icon (add an ImageLabel to show the ingredient)
			local iconFrame = inner:FindFirstChild("Icon")
			if iconFrame then
				-- Remove any previous image from earlier clones
				local existingImg = iconFrame:FindFirstChild("Image")
				if existingImg then existingImg:Destroy() end

				local img = getIngredientImage(item.Name)
				local imgLabel = Instance.new("ImageLabel")
				imgLabel.Name = "Image"
				imgLabel.Size = UDim2.new(1, 0, 1, 0)
				imgLabel.BackgroundTransparency = 1
				imgLabel.ScaleType = Enum.ScaleType.Fit
				if img ~= "" then imgLabel.Image = img end
				imgLabel.Parent = iconFrame
			end

			-- Price on the Buy button (in-game money)
			local buyBtn = inner:FindFirstChild("Buy")
			if buyBtn and buyBtn:IsA("GuiButton") then
				local priceLabel = findTextLabel(buyBtn)
				if priceLabel then priceLabel.Text = "$" .. tostring(item.Price) end

				buyBtn.MouseButton1Click:Connect(function()
					buyRemote:FireServer(item.Name)
				end)
			end

			-- Robux button: show price and connect purchase
			local robuxBtn = inner:FindFirstChild("Robux")
			if robuxBtn and robuxBtn:IsA("GuiButton") then
				local robuxPriceLabel = robuxBtn:FindFirstChild("Title")
				if robuxPriceLabel and robuxPriceLabel:IsA("TextLabel") then
					robuxPriceLabel.Text = tostring(item.RobuxPrice or 0)
				end

				robuxBtn.MouseButton1Click:Connect(function()
					local productId = item.ProductId or 0
					if productId > 0 then
						MarketplaceService:PromptProductPurchase(player, productId)
					else
						warn("[IngredientShop] ProductId not set for " .. item.Name .. ". Configure it in IngredientShopConfig.")
					end
				end)
			end
		end

		row.Parent = list
	end

	-- The List uses AutomaticCanvasSize.Y with UIListLayout,
	-- so the canvas size adjusts automatically — no manual sizing needed.
end

-- [ OPEN: fetch stock when the frame becomes visible ]
frame:GetPropertyChangedSignal("Visible"):Connect(function()
	if frame.Visible then
		local ok, stock = pcall(function() return getStockRemote:InvokeServer() end)
		if ok then populateStock(stock) end
	end
end)
