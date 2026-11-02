local Module = {}
local AssetURL = "http://www.roblox.com/Thumbs/Asset.ashx?format=png&width=250&height=250&assetId=";
function Module.GetImage(Image) 
	local Return;
	if _G.Cache[Image] ~= nil then 
		return _G.Cache[Image];
	else
		local NewImage = (tonumber(Image) and AssetURL..Image) or Image; 
		NewImage = NewImage .. "&bust="..math.random(1,10000);
		_G.Cache[Image] = NewImage;
		return NewImage; 
	end;
end
local function deepcopy(original)
	local copy = {}
	for k, v in pairs(original) do
		-- as before, but if we find a table, make sure we copy that too
		if type(v) == "table" then
			v = deepcopy(v)
		end
		copy[k] = v
	end
	return copy
end
local RarityOrder = {
	Classic = 1, 
	Common = 2, 
	Uncommon = 3, 
	Rare = 4, 
	Legendary = 5, 
	Godly = 6, 
	Victim = 7, 
	Unique = 7,
	Christmas = 1.5, 
	Halloween = 1.6, 
	Ancient = 6.5
}
function Module.GetSortedInventory()
	local WeaponsTable = {}
	for ID, Amount in pairs(deepcopy(_G.PlayerData.Weapons).Owned) do
		if _G.Database.Weapons[ID] ~= nil then
			table.insert(WeaponsTable, {
				ItemID = ID, 
				Amount = Amount
			})
		end
	end
	table.sort(WeaponsTable, function(a, b)
		local ID = { a.ItemID, b.ItemID }
		local Amount = { a.Amount, b.Amount }
		local Data = { _G.Database.Weapons[ID[1]], _G.Database.Weapons[ID[2]] }
		local Rarity = { RarityOrder[Data[1].Rarity], RarityOrder[Data[2].Rarity] }		if ID[1] == "DefaultKnife" then
			return true
		end
		if ID[2] == "DefaultKnife" then
			return false
		end
		if ID[1] == "DefaultGun" then
			return true
		end
		if ID[2] == "DefaultGun" then
			return false
		end
		if Rarity[1] ~= Rarity[2] then
			return Rarity[2] < Rarity[1]
		end
		if Amount[1] ~= Amount[2] then
			return Amount[2] < Amount[1]
		end
		return Data[1].ItemName < Data[2].ItemName
	end)
	return WeaponsTable
end
function Module.CreateFrame(ItemImage, ItemData, CreateItem, item, id, rarity, ItemRarityFrame, ItemDataFrame)
	local ItemFrame = item:Clone()
	ItemFrame.Name = ItemDataFrame or (ItemData.ID or (ItemData.ItemID or tostring(item.Name .. rarity)))
	CreateItem(ItemFrame, ItemData, ItemImage)
	return ItemFrame
end
function Module.CreateGrid(Rarity, AbsoluteSize, Index, Frame)
	local i = 0
	local Container = Frame.Container
	local Size = AbsoluteSize.Size.X.Scale
	Container:ClearAllChildren()
	for Item, Database in pairs(Index) do
		if not Item then end
		local DefaultItem = true
		if Database.ItemID ~= "DefaultKnife" then
			DefaultItem = Database.ItemID == "DefaultGun"
		end
		if not DefaultItem then
			local Row = math.floor(i / math.floor(1 / Size))
			local NewFrame = Module.CreateFrame(Item, Database, Rarity, AbsoluteSize, Frame, i, Row)
			NewFrame.Parent = Container
			NewFrame.Position = UDim2.new(NewFrame.Size.X.Scale * (i % math.floor(1 / Size)), 0, 0, NewFrame.AbsoluteSize.Y * Row)
			if Frame:IsA("ScrollingFrame") then
				Frame.CanvasSize = UDim2.new(0, 0, 0, (Row + 1) * NewFrame.AbsoluteSize.Y)
			end
			i = i + 1
		end	
	end
end
function Module.CreateList(Rarity, Size, Index, Frame)
	local i = 0
	local Container = Frame.Container
	Container:ClearAllChildren()
	for Item, Database in pairs(Index) do
		local Row = math.floor(i / 1)
		local NewFrame = Module.CreateFrame(Item, Database, Rarity, Size, Frame, i, Row)
		NewFrame.Parent = Container
		NewFrame.Position = UDim2.new(0, 0, 0, NewFrame.AbsoluteSize.Y * Row)
		Frame.CanvasSize = UDim2.new(0, 0, 0, (Row + 1) * NewFrame.AbsoluteSize.Y)
		i = i + 1
	end
end
function Module.CreatePass(NewFrame, Data, BattlePass, PassGui, PassPage)
	local i = 0
	for PassFrame = 1, BattlePass.TotalTiers do
		local Reward = tostring(PassFrame)
		local Row = math.floor(i / 5)
		local ItemFrame = i % 5
		local Page = PassGui:FindFirstChild("Page" .. Row)
		if not Page then
			Page = PassPage:Clone()
			Page.Name = "Page" .. Row
			Page.Parent = PassGui
		end
		local RewardFrame = BattlePass.Rewards[Reward] or {}
		local Tier = Page:FindFirstChild("Tier" .. Reward)
		if not Tier then
			local PassFrame = Module.CreateFrame(PassFrame, RewardFrame, NewFrame, Data, nil, ItemFrame, nil, "Tier" .. Reward)
			PassFrame.Parent = Page
			PassFrame.Position = UDim2.new(0, PassFrame.AbsoluteSize.X * ItemFrame, 0, 0)
		else
			NewFrame(Tier, RewardFrame, PassFrame)
		end
		i = i + 1
	end
end
local RarityColors = game.ReplicatedStorage.GetSyncData:InvokeServer("Rarity")
function Module.MakeItemFrame(Database, Index, Value)
	local ID = Index.ItemID
	local Amount = Index.Amount
	if Database:FindFirstChild("Container") then
		Database = Database.Container
	end
	local ItemName = Database.Icon:FindFirstChild("ItemName") or Database.ItemName
	local ItemData = (_G.Database[Index.ItemType] or _G.Database.Item)[ID] or (ID or {
		Image = "", 
		ItemName = "", 
		Rarity = "Common"
	})
	Database.Icon.Image = ItemData.Image
	ItemName.Text = ItemData.ItemName or ItemData.Name
	ItemName.TextColor3 = RarityColors[ItemData.Rarity or "Common"]
	if Amount then
		Database.Rarity.Text = ItemData.Rarity
		Database.Rarity.TextColor3 = RarityColors[ItemData.Rarity]
		Database.Year.Text = ItemData.Year or ""
		Database.Event.Text = ItemData.Event or ""
		Database.Event.TextColor3 = ItemData.Event and RarityColors[ItemData.Event] or Color3.new()
		if Amount > 1 then
			Database.Amount.Text = "x" .. math.floor(Amount)
		end
		if Value == nil then
			Database.MouseEnter:connect(function()
				Database.Rarity.Visible = true
				Database.Year.Visible = true
				Database.Event.Visible = true
			end)
			Database.MouseLeave:connect(function()
				Database.Rarity.Visible = false
				Database.Year.Visible = false
				Database.Event.Visible = false
			end)
		end
	end
end
function Module.Commafy(amount)
	local formatted = amount
	if formatted == nil then
		return 0
	end
	while true do
		formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", "%1,%2")
		if (k==0) then
			break
		end
	end
	return formatted
end
return Module