--credit to prince games studio
local LocalPlayer = game.Players.LocalPlayer
local ScrollingFrame = LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("SeedShop"):WaitForChild("Frame"):WaitForChild("ScrollingFrame")
local ItemTemplate = ScrollingFrame:WaitForChild("ItemTemplate")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local SeedData = require(ReplicatedStorage.SharedModules.SeedData)
local NumberUtils = require(ReplicatedStorage.SharedModules.NumberUtils)
local Networking = require(ReplicatedStorage.SharedModules.Networking)
local DevProducts = require(ReplicatedStorage.SharedModules.DevProducts)
local DevProductsClient = require(ReplicatedStorage.ClientModules.DevProductsClient)
local PlayerStateClient = require(ReplicatedStorage.ClientModules.PlayerStateClient)
local DevProductController = require(LocalPlayer.PlayerScripts.Controllers.DevProductController)
local Gradients = ReplicatedStorage.SharedModules.RarityData.Gradients
local Items = ReplicatedStorage.StockValues.SeedShop.Items
local Shelf = script.Parent:WaitForChild("Shelf")
local Robux = Shelf.Main_Frame.Buttons.Robux
local GiftButton = Shelf.Main_Frame.Buttons.GiftButton
local v1 = PlayerStateClient:WaitForLocalReplica(30)

ItemTemplate.Visible = false

local t = {}
local t2 = {}
local v2 = nil
local v3 = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local v4 = Color3.new(0.0784314, 0.188235, 0)
local v5 = Color3.new(0.188235, 0, 0)

local function SetStockAppearance(p1, p2) --[[ SetStockAppearance | Line: 36 | Upvalues: v4 (copy), v5 (copy) ]]
	for v1, v2 in p1:GetChildren() do
		if v2:IsA("UIGradient") or v2:IsA("UIStroke") then
			if v2.Name == "NoStock" then
				v2.Enabled = not p2

				continue
			end

			if v2:IsA("UIStroke") then
				v2.Enabled = true
				v2.Color = if p2 then v4 else v5

				continue
			end

			v2.Enabled = p2
		end
	end
end

local function CanAfford(p1) --[[ CanAfford | Line: 51 | Upvalues: t2 (copy), v1 (copy) ]]
	local v12 = t2[p1]

	if not v12 then
		return false
	end

	if not v1 then
		return false
	end

	return (v1.Data.Sheckles or 0) >= v12.price
end

local function UpdateShelf(p1) --[[ UpdateShelf | Line: 58 | Upvalues: Shelf (copy), t2 (copy), v1 (copy), SetStockAppearance (copy), Robux (copy), DevProductController (copy), v2 (ref) ]]
	local Sheckles = Shelf.Main_Frame.Buttons.Sheckles
	local Text = p1.Cost_Text.Text
	local v12 = Text ~= "NO STOCK"
	local v22 = p1.Parent.Name
	local v3 = t2[v22]
	local v4 = if v3 then if v3.devProductKey == nil then false else true else v3
	local v5

	if v12 then
		local v6 = t2[v22]

		v5 = if v6 and v1 then if (v1.Data.Sheckles or 0) >= v6.price then true else false else false
	else
		v5 = v12
	end

	Sheckles.TextLabel.Text = Text
	Sheckles.TextLabel.TextLabel.Text = Text
	SetStockAppearance(Sheckles, v5)
	SetStockAppearance(Sheckles.TextLabel.TextLabel, v5)
	Robux.Visible = v4

	if not v4 then
		return
	end

	SetStockAppearance(Robux, true)

	local TextLabel = Robux:FindFirstChild("TextLabel")
	local v7 = TextLabel and TextLabel:FindFirstChild("TextLabel")

	if v7 then
		SetStockAppearance(v7, true)
	end

	local function setRobuxText(p1) --[[ setRobuxText | Line: 82 | Upvalues: TextLabel (copy), v7 (copy) ]]
		if TextLabel then
			TextLabel.Text = p1
		end

		if not v7 then
			return
		end

		v7.Text = p1
	end

	local v8 = DevProductController:GetPreloadedProductInfo(v3.devProductKey)

	if v8 and type(v8.PriceInRobux) == "number" then
		local v9 = "\238\128\130" .. tostring(v8.PriceInRobux)

		if TextLabel then
			TextLabel.Text = v9
		end

		if v7 then
			v7.Text = v9
		end

		return
	end

	if TextLabel then
		TextLabel.Text = "\238\128\130..."
	end

	if v7 then
		v7.Text = "\238\128\130..."
	end

	task.spawn(function() --[[ Line: 96 | Upvalues: DevProductController (ref), v3 (copy), v2 (ref), v22 (copy), TextLabel (copy), v7 (copy) ]]
		local v1 = DevProductController:WaitForPreloadedProductInfo(v3.devProductKey, 5)

		if not v1 then
			return
		end

		if type(v1.PriceInRobux) ~= "number" or (not v2 or v2.Name ~= v22) then
			return
		end

		local v23 = "\238\128\130" .. tostring(v1.PriceInRobux)

		if TextLabel then
			TextLabel.Text = v23
		end

		if not v7 then
			return
		end

		v7.Text = v23
	end)
end

local function GetRemainingStock(p1) --[[ GetRemainingStock | Line: 106 | Upvalues: t2 (copy), v1 (copy) ]]
	local v12 = t2[p1]

	if not v12 then
		return 0
	end

	return math.max(v12.maxStock - (if v1 and (v1.Data.PurchasedThisRestock and v1.Data.PurchasedThisRestock.Seeds) then v1.Data.PurchasedThisRestock.Seeds[p1] or 0 else 0), 0)
end

local function RefreshSeedStock(p1) --[[ RefreshSeedStock | Line: 116 | Upvalues: t2 (copy), v1 (copy), SetStockAppearance (copy), v2 (ref), UpdateShelf (copy) ]]
	local v12 = t2[p1]

	if not v12 then
		return
	end

	local v22 = t2[p1]
	local v3 = if v22 then math.max(v22.maxStock - (if v1 and (v1.Data.PurchasedThisRestock and v1.Data.PurchasedThisRestock.Seeds) then v1.Data.PurchasedThisRestock.Seeds[p1] or 0 else 0), 0) else 0
	local v7 = if v3 >= 1 then true else false

	v12.mainFrame.Cost_Text.Text = if v7 then v12.costText else "NO STOCK"
	v12.mainFrame.Cost_Text.TextLabel.Text = if v7 then v12.costText else "NO STOCK"
	v12.mainFrame.Stock_Text.Text = "x" .. tostring(v3) .. " in Stock"
	SetStockAppearance(v12.mainFrame.Cost_Text.TextLabel, v7)

	if not v2 or v2.Name ~= p1 then
		return
	end

	UpdateShelf(v12.mainFrame)
end

local t3 = {}

local function QueueRefresh(p1) --[[ QueueRefresh | Line: 135 | Upvalues: t3 (copy), RefreshSeedStock (copy) ]]
	if not t3[p1] then
		t3[p1] = true
		task.defer(function() --[[ Line: 138 | Upvalues: t3 (ref), p1 (copy), RefreshSeedStock (ref) ]]
			t3[p1] = nil
			RefreshSeedStock(p1)
		end)
	end
end

local list = {}

for i, v in ipairs(SeedData) do
	if v.RestockShop then
		table.insert(list, v)
	end
end

table.sort(list, function(p1, p2) --[[ Line: 150 ]]
	return p1.PurchasePrice < p2.PurchasePrice
end)

for i, v in ipairs(list) do
	local v6
	local v7 = ItemTemplate:Clone()

	v7.Name = v.SeedName
	v7.LayoutOrder = i * 3
	v7.Visible = true
	v7.Parent = ScrollingFrame

	local Main_Frame = v7.Main_Frame

	Main_Frame.Seed_Text.Text = v.SeedName
	Main_Frame.Seed_Text.TextLabel.Text = v.SeedName

	if v.SeedImage then
		Main_Frame.ImageDisplay.Vector.Image = v.SeedImage.Value
	end

	local Rarity = Main_Frame.Rarity

	for v8, v9 in Rarity:GetChildren() do
		if v9:IsA("UIGradient") then
			v9:Destroy()
		end
	end

	if v.Rarity == nil then
		return
	end

	local v10 = Gradients:FindFirstChild(v.Rarity)

	if v10 then
		v10:Clone().Parent = Rarity
	end

	Rarity.Rarity_Text.Text = v.Rarity
	Rarity.Rarity_Text.TextLabel.Text = v.Rarity

	local v11 = NumberUtils.Abbreviate(v.PurchasePrice) .. "\194\162"
	local v12 = Items:FindFirstChild(v.SeedName)
	local t4 = {
		frame = v7,
		mainFrame = Main_Frame,
		costText = v11,
		price = v.PurchasePrice
	}

	t4.maxStock = v12 and v12.Value or 0
	v6 = if type(v.DevProduct) == "table" then if type(v.DevProduct[1]) == "number" then DevProducts.GetSeedProductKey(v.SeedName) else nil else nil
	t4.devProductKey = v6
	t2[v.SeedName] = t4
	RefreshSeedStock(v.SeedName)
	table.insert(t, v7)
end

if v1 then
	v1:OnChange(function(p1, p2) --[[ Line: 205 | Upvalues: t3 (copy), RefreshSeedStock (copy), t2 (copy), v2 (ref), UpdateShelf (copy) ]]
		if p2 and (p2[1] == "PurchasedThisRestock" and p2[2] == "Seeds") then
			if p2[3] == nil then
				for k in pairs(t2) do
					if not t3[k] then
						t3[k] = true
						task.defer(function() --[[ Line: 138 | Upvalues: t3 (ref), k (copy), RefreshSeedStock (ref) ]]
							t3[k] = nil
							RefreshSeedStock(k)
						end)
					end
				end
			else
				local v22 = tostring(p2[3])

				if not t3[v22] then
					t3[v22] = true
					task.defer(function() --[[ Line: 138 | Upvalues: t3 (ref), v22 (copy), RefreshSeedStock (ref) ]]
						t3[v22] = nil
						RefreshSeedStock(v22)
					end)
				end
			end
		else
			if not p2 or (p2[1] ~= "Sheckles" or not v2) then
				return
			end

			local v3 = t2[v2.Name]

			if not v3 then
				return
			end

			UpdateShelf(v3.mainFrame)
		end
	end)
end

local function WatchStockValue(p1) --[[ WatchStockValue | Line: 225 | Upvalues: t2 (copy), t3 (copy), RefreshSeedStock (copy) ]]
	p1:GetPropertyChangedSignal("Value"):Connect(function() --[[ Line: 226 | Upvalues: t2 (ref), p1 (copy), t3 (ref), RefreshSeedStock (ref) ]]
		local v1 = t2[p1.Name]

		if not v1 then
			return
		end

		v1.maxStock = p1.Value

		local v2 = p1.Name

		if t3[v2] then
			return
		end

		t3[v2] = true
		task.defer(function() --[[ Line: 138 | Upvalues: t3 (ref), v2 (copy), RefreshSeedStock (ref) ]]
			t3[v2] = nil
			RefreshSeedStock(v2)
		end)
	end)
end

for v15, v16 in Items:GetChildren() do
	v16:GetPropertyChangedSignal("Value"):Connect(function() --[[ Line: 226 | Upvalues: t2 (copy), v16 (copy), t3 (copy), RefreshSeedStock (copy) ]]
		local v1 = t2[v16.Name]

		if not v1 then
			return
		end

		v1.maxStock = v16.Value

		local v2 = v16.Name

		if t3[v2] then
			return
		end

		t3[v2] = true
		task.defer(function() --[[ Line: 138 | Upvalues: t3 (ref), v2 (copy), RefreshSeedStock (ref) ]]
			t3[v2] = nil
			RefreshSeedStock(v2)
		end)
	end)
end

Items.ChildAdded:Connect(function(p1) --[[ Line: 239 | Upvalues: t2 (copy), t3 (copy), RefreshSeedStock (copy) ]]
	local v1 = t2[p1.Name]

	if v1 then
		v1.maxStock = p1.Value

		local v2 = p1.Name

		if not t3[v2] then
			t3[v2] = true
			task.defer(function() --[[ Line: 138 | Upvalues: t3 (ref), v2 (copy), RefreshSeedStock (ref) ]]
				t3[v2] = nil
				RefreshSeedStock(v2)
			end)
		end
	end

	p1:GetPropertyChangedSignal("Value"):Connect(function() --[[ Line: 226 | Upvalues: t2 (ref), p1 (copy), t3 (ref), RefreshSeedStock (ref) ]]
		local v1 = t2[p1.Name]

		if not v1 then
			return
		end

		v1.maxStock = p1.Value

		local v2 = p1.Name

		if t3[v2] then
			return
		end

		t3[v2] = true
		task.defer(function() --[[ Line: 138 | Upvalues: t3 (ref), v2 (copy), RefreshSeedStock (ref) ]]
			t3[v2] = nil
			RefreshSeedStock(v2)
		end)
	end)
end)

local t4 = {}

for v17, v18 in t do
	table.insert(t4, v18)
end

table.sort(t4, function(p1, p2) --[[ Line: 251 ]]
	return p1.LayoutOrder < p2.LayoutOrder
end)

for v19, v20 in t do
	v20.Main_Frame.TextButton.Activated:Connect(function() --[[ Line: 256 | Upvalues: v2 (ref), v20 (copy), Shelf (copy), UpdateShelf (copy), t4 (copy), TweenService (copy), ScrollingFrame (copy), v3 (copy) ]]
		if v2 == v20 then
			Shelf.Visible = false
			v2 = nil

			return
		end

		Shelf.Visible = true
		Shelf.LayoutOrder = v20.LayoutOrder + 1
		v2 = v20
		UpdateShelf(v20.Main_Frame)

		local v1 = 1

		for i, v in ipairs(t4) do
			if v == v20 then
				v1 = i

				break
			end
		end

		local v22 = TweenService:Create(ScrollingFrame, v3, {
			CanvasPosition = Vector2.new(0, v20.AbsoluteSize.Y * (v1 - 1))
		})

		v22:Play()
		game.Debris:AddItem(v22, v3.Time)
	end)
end

local v21 = false

Shelf.Main_Frame.Buttons.Sheckles.Activated:Connect(function() --[[ Line: 285 | Upvalues: v21 (ref), v2 (ref), t2 (copy), v1 (copy), Networking (copy) ]]
	if v21 then
		return
	end

	if not v2 then
		return
	end

	local v12 = v2.Name
	local v22 = t2[v12]

	if not ((if v22 then math.max(v22.maxStock - (if v1 and (v1.Data.PurchasedThisRestock and v1.Data.PurchasedThisRestock.Seeds) then v1.Data.PurchasedThisRestock.Seeds[v12] or 0 else 0), 0) else 0) < 1) then
		v21 = true
		Networking.SeedShop.PurchaseSeed:Fire(v12)
		task.wait()
		v21 = false
	end
end)
Robux.Activated:Connect(function() --[[ Line: 298 | Upvalues: v21 (ref), v2 (ref), t2 (copy), DevProductsClient (copy) ]]
	if v21 then
		return
	end

	if not v2 then
		return
	end

	local v1 = t2[v2.Name]

	if v1 and v1.devProductKey then
		v21 = true
		DevProductsClient.PromptPurchase(v1.devProductKey)
		task.wait()
		v21 = false
	end
end)