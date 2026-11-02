local v1 = {
	GUI = {}
}

local v2 = require(game.ReplicatedStorage.Modules.BoxModule)
local v3 = require(game.ReplicatedStorage.Modules.XboxModule)

function v1.CheckOwned(p1, p2)
	if p2 ~= "Weapons" and p2 ~= "Pets" and p2 ~= "MysteryBox" and p2 ~= "Eggs" and p2 ~= "Item" then
		if _G.PlayerData[p2].Owned[p1] then
			return true
		else
			for v4, v5 in pairs(_G.PlayerData[p2].Owned) do
				if v5 == p1 then
					return true
				end
			end
			return false
		end
	end
	return false
end

function v1.SelectObject()
	-- TODO: Implement this function
end

local l__Shop__1 = _G.Database.Shop

function v1.BuyItem(p3, p4, p5, p6)
	local v6 = l__Shop__1[p4][p3]
	local v7 = v6.DataType and p4
	local l__Price__8 = v6.Price
	local v9
	if p5 == "Coins" or p5 == "Gems" then
		v9 = l__Price__8[p5] <= _G.PlayerData[p5]
	else
		v9 = l__Price__8[p5] <= (_G.PlayerData.Materials.Owned[p5] and 0)
	end

	if v9 then
		local v10
		if v7 ~= "Weapons" and v7 ~= "Pets" and v7 ~= "MysteryBox" and v7 ~= "Eggs" and v7 ~= "Item" then
			if _G.PlayerData[v7].Owned[p3] then
				v10 = true
			else
				local v11, v12, v13 = pairs(_G.PlayerData[v7].Owned)
				while true do
					local v14, v15 = v11(v12, v13)
					if not v14 then
						v10 = false
						break
					end
					v13 = v14
					if v15 == p3 then
						v10 = true
						break
					end
				end
			end
		else
			v10 = false
		end

		if not v10 then
			p6.PriceFrame[p5].Visible = false
			p6.PriceFrame.PurchaseLoading.LayoutOrder = p6.PriceFrame[p5].LayoutOrder
			p6.PriceFrame.PurchaseLoading.Visible = true
			spawn(function()
				while p6.PriceFrame.PurchaseLoading.Visible == true do
					p6.PriceFrame.PurchaseLoading.Container.Spinner.Rotation = p6.PriceFrame.PurchaseLoading.Container.Spinner.Rotation + 5
					game:GetService("RunService").RenderStepped:wait()
				end
			end)
			print(v7)
			p6.PriceFrame.PurchaseLoading.Visible = false
			if game.ReplicatedStorage.Remotes.Shop.BuyItem:InvokeServer(p3, p4, p5) then
				if v6.ExchangeAmount then
					p3 = "CoinVisual"
				end
				_G.NewItem(p3, "You Got...", v1.GUI.ShopFrame, v7)
				v1.UpdateShopFrames()
			end
			v1.SelectObject(true)
			return
		end
	end

	local v16
	if v7 ~= "Weapons" and v7 ~= "Pets" and v7 ~= "MysteryBox" and v7 ~= "Eggs" and v7 ~= "Item" then
		if _G.PlayerData[v7].Owned[p3] then
			v16 = true
		else
			local v17, v18, v19 = pairs(_G.PlayerData[v7].Owned)
			while true do
				local v20, v21 = v17(v18, v19)
				if not v20 then
					v16 = false
					break
				end
				v19 = v20
				if v21 == p3 then
					v16 = true
					break
				end
			end
		end
	else
		v16 = false
	end

	if not v16 then
		if v6.ExchangeAmount then
			p3 = "CoinVisual"
		end
		v1.GUI.BuyFrame.Description.Text = v6.Description
		v1.GUI.BuyFrame.ItemImage.Image = v6.ImageId
		if v6.Price.CurrencyType == "Coins" or v6.Price.CurrencyType == "Gems" then
			v1.GUI.BuyFrame.CostText.Text = v6.Price[v6.Price.CurrencyType]
		else
			v1.GUI.BuyFrame.CostText.Text = "??"
		end
		v1.GUI.BuyFrame.Buy.Visible = v6.Price[v6.Price.CurrencyType] <= (_G.PlayerData.Materials.Owned[v6.Price.CurrencyType] and 0)
		v1.GUI.BuyFrame.ItemType.Text = v6.DataType
		v1.GUI.BuyFrame.ItemId.Text = p3
		v1.GUI.BuyFrame.Visible = true
		v1.GUI.BuyFrame.LayoutOrder = p6.PriceFrame[p5].LayoutOrder
	end
end

function v1.GenerateHotItems()
	for v22, v23 in ipairs(l__Shop__1.HotItems) do
		local v24 = l__Shop__1[v23.Category][v23.Name]
		local v25 = v24 and v24.Price and (v24.Price.CurrencyType == "Coins" or v24.Price.CurrencyType == "Gems") and v24.Price[v24.Price.CurrencyType] <= (_G.PlayerData[v24.Price.CurrencyType] and 0)
		if not v25 then
			v1.GUI.HotFrame.ItemName.Text = v24.Description
			v1.GUI.HotFrame.ItemPrice.Text = v24.Price.CurrencyType == "Coins" or v24.Price.CurrencyType == "Gems" and v24.Price[v24.Price.CurrencyType] or "?"
			v1.GUI.HotFrame.ItemImage.Image = v24.ImageId
			v1.GUI.HotFrame.Visible = true
			v1.GUI.HotFrame.ItemType.Text = v23.Category
			v1.GUI.HotFrame.ItemId.Text = v23.Name
		end
	end
end

function v1.SelectItemToPurchase(p7, p8, p9, p10, p11)
	local v26 = l__Shop__1[p7][p8]
	v1.GUI.BuyFrame.Description.Text = v26.Description
	v1.GUI.BuyFrame.ItemImage.Image = v26.ImageId
	if v26.Price.CurrencyType == "Coins" or v26.Price.CurrencyType == "Gems" then
		v1.GUI.BuyFrame.CostText.Text = v26.Price[v26.Price.CurrencyType]
	else
		v1.GUI.BuyFrame.CostText.Text = "??"
	end
	v1.GUI.BuyFrame.Buy.Visible = v26.Price[v26.Price.CurrencyType] <= (_G.PlayerData.Materials.Owned[v26.Price.CurrencyType] and 0)
	v1.GUI.BuyFrame.ItemType.Text = p7
	v1.GUI.BuyFrame.ItemId.Text = p8
	v1.GUI.BuyFrame.Visible = true
	v1.GUI.BuyFrame.LayoutOrder = p9.LayoutOrder
end

function v1.BuyButtonPressed(p12)
	local v27 = v1.GUI.BuyFrame.ItemType.Text
	local v28 = v1.GUI.BuyFrame.ItemId.Text
	v1.BuyItem(v28, v27, p12, v1.GUI.BuyFrame)
end

function v1.BuyFrameClosing()
	v1.GUI.BuyFrame.Visible = false
end

function v1.SetupShop(p13)
	v1.GUI.ShopFrame.ItemName.Text = l__Shop__1[p13][1].Description
	v1.GUI.ShopFrame.ItemImage.Image = l__Shop__1[p13][1].ImageId
	v1.GUI.ShopFrame.ItemType.Text = p13
	v1.GUI.ShopFrame.ItemId.Text = 1
	v1.GUI.ShopFrame.Visible = true
	v1.GUI.ShopFrame.Next.Visible = true
	v1.GUI.ShopFrame.Prev.Visible = false
	v1.GUI.ShopFrame.Buy.Visible = true
	v1.GUI.ShopFrame.BuyMore.Visible = false
	v1.GUI.ShopFrame.PurchaseLoading.Visible = false
	v1.GUI.ShopFrame.Buy:AddConnection(function()
		v1.BuyButtonPressed(p13)
	end)
end

function v1.UpdateShopFrames()
	v1.GUI.HotFrame.Visible = false
	v1.GUI.ShopFrame.Visible = false
	v1.GenerateHotItems()
	v1.SetupShop("Weapons")
end

function v1.Init(p14)
	local v29 = Instance.new("ScreenGui")
	v29.Parent = p14.StarterGui
	v29.Name = "MainGui"
	v1.GUI.MainFrame = Instance.new("Frame")
	v1.GUI.MainFrame.Position = UDim2.new(0.1, 0, 0.1, 0)
	v1.GUI.MainFrame.Size = UDim2.new(0.8, 0, 0.8, 0)
	v1.GUI.MainFrame.Parent = v29
	v1.GUI.MainFrame.Visible = true
	v1.GUI.MainFrame.BackgroundColor3 = Color3.new(0, 0, 0)
	v1.GUI.HotFrame = Instance.new("ImageButton")
	v1.GUI.HotFrame.Position = UDim2.new(0, 0, 0.15, 0)
	v1.GUI.HotFrame.Size = UDim2.new(0.5, 0, 0.3, 0)
	v1.GUI.HotFrame.Visible = false
	v1.GUI.HotFrame.BackgroundTransparency = 1
	v1.GUI.HotFrame.ImageTransparency = 1
	v1.GUI.HotFrame.Image = "rbxassetid://2790387308"
	v1.GUI.HotFrame.Parent = v1.GUI.MainFrame
	v1.GUI.HotFrame.ItemImage = Instance.new("ImageLabel")
	v1.GUI.HotFrame.ItemImage.Position = UDim2.new(0.05, 0, 0.05, 0)
	v1.GUI.HotFrame.ItemImage.Size = UDim2.new(0.35, 0, 0.9, 0)
	v1.GUI.HotFrame.ItemImage.Parent = v1.GUI.HotFrame
	v1.GUI.HotFrame.ItemName = Instance.new("TextLabel")
	v1.GUI.HotFrame.ItemName.Position = UDim2.new(0.425, 0, 0.05, 0)
	v1.GUI.HotFrame.ItemName.Size = UDim2.new(0.525, 0, 0.4, 0)
	v1.GUI.HotFrame.ItemName.TextColor3 = Color3.new(1, 1, 1)
	v1.GUI.HotFrame.ItemName.TextSize = 14
	v1.GUI.HotFrame.ItemName.TextXAlignment = Enum.TextXAlignment.Left
	v1.GUI.HotFrame.ItemName.Parent = v1.GUI.HotFrame
	v1.GUI.HotFrame.ItemPrice = Instance.new("TextLabel")
	v1.GUI.HotFrame.ItemPrice.Position = UDim2.new(0.425, 0, 0.55, 0)
	v1.GUI.HotFrame.ItemPrice.Size = UDim2.new(0.525, 0, 0.4, 0)
	v1.GUI.HotFrame.ItemPrice.TextColor3 = Color3.new(1, 1, 1)
	v1.GUI.HotFrame.ItemPrice.TextSize = 14
	v1.GUI.HotFrame.ItemPrice.TextXAlignment = Enum.TextXAlignment.Left
	v1.GUI.HotFrame.ItemPrice.Parent = v1.GUI.HotFrame
	v1.GUI.HotFrame.ItemType = Instance.new("TextLabel")
	v1.GUI.HotFrame.ItemType.Position = UDim2.new(0.425, 0, 0.425, 0)
	v1.GUI.HotFrame.ItemType.Size = UDim2.new(0.525, 0, 0.15, 0)
	v1.GUI.HotFrame.ItemType.TextColor3 = Color3.new(1, 1, 1)
	v1.GUI.HotFrame.ItemType.TextSize = 14
	v1.GUI.HotFrame.ItemType.TextXAlignment = Enum.TextXAlignment.Left
	v1.GUI.HotFrame.ItemType.Parent = v1.GUI.HotFrame
	v1.GUI.HotFrame.ItemId = Instance.new("TextLabel")
	v1.GUI.HotFrame.ItemId.Position = UDim2.new(0.425, 0, 0.7, 0)
	v1.GUI.HotFrame.ItemId.Size = UDim2.new(0.525, 0, 0.15, 0)
	v1.GUI.HotFrame.ItemId.TextColor3 = Color3.new(1, 1, 1)
	v1.GUI.HotFrame.ItemId.TextSize = 14
	v1.GUI.HotFrame.ItemId.TextXAlignment = Enum.TextXAlignment.Left
	v1.GUI.HotFrame.ItemId.Parent = v1.GUI.HotFrame
	v1.GUI.ShopFrame = Instance.new("ImageButton")
	v1.GUI.ShopFrame.Position = UDim2.new(0.5, 0, 0.15, 0)
	v1.GUI.ShopFrame.Size = UDim2.new(0.5, 0, 0.3, 0)
	v1.GUI.ShopFrame.Visible = false
	v1.GUI.ShopFrame.BackgroundTransparency = 1
	v1.GUI.ShopFrame.ImageTransparency = 1
	v1.GUI.ShopFrame.Image = "rbxassetid://2790387308"
	v1.GUI.ShopFrame.Parent = v1.GUI.MainFrame
	v1.GUI.ShopFrame.ItemImage = Instance.new("ImageLabel")
	v1.GUI.ShopFrame.ItemImage.Position = UDim2.new(0.05, 0, 0.05, 0)
	v1.GUI.ShopFrame.ItemImage.Size = UDim2.new(0.35, 0, 0.9, 0)
	v1.GUI.ShopFrame.ItemImage.Parent = v1.GUI.ShopFrame
	v1.GUI.ShopFrame.ItemName = Instance.new("TextLabel")
	v1.GUI.ShopFrame.ItemName.Position = UDim2.new(0.425, 0, 0.05, 0)
	v1.GUI.ShopFrame.ItemName.Size = UDim2.new(0.525, 0, 0.4, 0)
	v1.GUI.ShopFrame.ItemName.TextColor3 = Color3.new(1, 1, 1)
	v1.GUI.ShopFrame.ItemName.TextSize = 14
	v1.GUI.ShopFrame.ItemName.TextXAlignment = Enum.TextXAlignment.Left
	v1.GUI.ShopFrame.ItemName.Parent = v1.GUI.ShopFrame
	v1.GUI.ShopFrame.ItemType = Instance.new("TextLabel")
	v1.GUI.ShopFrame.ItemType.Position = UDim2.new(0.425, 0, 0.425, 0)
	v1.GUI.ShopFrame.ItemType.Size = UDim2.new(0.525, 0, 0.15, 0)
	v1.GUI.ShopFrame.ItemType.TextColor3 = Color3.new(1, 1, 1)
	v1.GUI.ShopFrame.ItemType.TextSize = 14
	v1.GUI.ShopFrame.ItemType.TextXAlignment = Enum.TextXAlignment.Left
	v1.GUI.ShopFrame.ItemType.Parent = v1.GUI.ShopFrame
	v1.GUI.ShopFrame.ItemId = Instance.new("TextLabel")
	v1.GUI.ShopFrame.ItemId.Position = UDim2.new(0.425, 0, 0.7, 0)
	v1.GUI.ShopFrame.ItemId.Size = UDim2.new(0.525, 0, 0.15, 0)
	v1.GUI.ShopFrame.ItemId.TextColor3 = Color3.new(1, 1, 1)
	v1.GUI.ShopFrame.ItemId.TextSize = 14
	v1.GUI.ShopFrame.ItemId.TextXAlignment = Enum.TextXAlignment.Left
	v1.GUI.ShopFrame.ItemId.Parent = v1.GUI.ShopFrame
	v1.GUI.ShopFrame.Buy = Instance.new("TextButton")
	v1.GUI.ShopFrame.Buy.Position = UDim2.new(0.425, 0, 0.9, 0)
	v1.GUI.ShopFrame.Buy.Size = UDim2.new(0.15, 0, 0.1, 0)
	v1.GUI.ShopFrame.Buy.Text = "Buy"
	v1.GUI.ShopFrame.Buy.Parent = v1.GUI.ShopFrame
	v1.GUI.ShopFrame.BuyMore = Instance.new("TextButton")
	v1.GUI.ShopFrame.BuyMore.Position = UDim2.new(0.625, 0, 0.9, 0)
	v1.GUI.ShopFrame.BuyMore.Size = UDim2.new(0.15, 0, 0.1, 0)
	v1.GUI.ShopFrame.BuyMore.Text = "Buy More"
	v1.GUI.ShopFrame.BuyMore.Parent = v1.GUI.ShopFrame
	v1.GUI.ShopFrame.Buy:AddConnection(function()
		v1.BuyButtonPressed(v1.GUI.ShopFrame)
	end)
	v1.GUI.ShopFrame.BuyMore:AddConnection(function()
		v1.BuyButtonPressed(v1.GUI.ShopFrame)
	end)
	v1.GUI.ShopFrame.BuyMore.Visible = false
	v1.GUI.ShopFrame.Prev = Instance.new("ImageButton")
	v1.GUI.ShopFrame.Prev.Position = UDim2.new(0, 0, 0.475, 0)
	v1.GUI.ShopFrame.Prev.Size = UDim2.new(0.1, 0, 0.05, 0)
	v1.GUI.ShopFrame.Prev.Visible = false
	v1.GUI.ShopFrame.Prev.Image = "rbxassetid://2790387201"
	v1.GUI.ShopFrame.Prev.Parent = v1.GUI.ShopFrame
	v1.GUI.ShopFrame.Next = Instance.new("ImageButton")
	v1.GUI.ShopFrame.Next.Position = UDim2.new(0.9, 0, 0.475, 0)
	v1.GUI.ShopFrame.Next.Size = UDim2.new(0.1, 0, 0.05, 0)
	v1.GUI.ShopFrame.Next.Visible = false
	v1.GUI.ShopFrame.Next.Image = "rbxassetid://2790387190"
	v1.GUI.ShopFrame.Next.Parent = v1.GUI.ShopFrame
	v1.GUI.ShopFrame.Next.MouseButton1Click:AddConnection(function()
		v1.NextItem(v1.GUI.ShopFrame)
	end)
	v1.GUI.ShopFrame.Prev.MouseButton1Click:AddConnection(function()
		v1.PrevItem(v1.GUI.ShopFrame)
	end)
	v1.GUI.ShopFrame.Visible = true
	v1.GenerateHotItems()
	v1.SetupShop("Weapons")
end

return v1
