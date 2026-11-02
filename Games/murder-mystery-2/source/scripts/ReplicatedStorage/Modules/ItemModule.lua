local Module = {}
local AssetURL = "http://www.roblox.com/Thumbs/Asset.ashx?format=png&width=250&height=250&assetId="
while true do
	wait()
	if _G.Database ~= nil then
		break
	end
end
local function GetImage(Image) 
	local Return
	if _G.Cache[Image] ~= nil then 
		return _G.Cache[Image]
	else
		local NewImage = (tonumber(Image) and AssetURL .. Image) or Image 
		NewImage = NewImage .. "&bust=" .. math.random(1, 10000)
		_G.Cache[Image] = NewImage
		return NewImage 
	end
end
Module.GetImage = GetImage
function Module.GetImageSmall(Image)
	local Return
	if _G.SmallCache[Image] ~= nil then 
		return _G.SmallCache[Image]
	else
		local NewImage = (tonumber(Image) and AssetURL .. Image) or Image 
		NewImage = NewImage .. "&bust=" .. math.random(1, 10000)
		_G.SmallCache[Image] = NewImage
		return NewImage 
	end
end
local GridFunctions = {
	Chroma = function(Frame, Index)
		Frame.Tags.Chroma.Visible = Index.Chroma == true
	end, 
	Evo = function(Frame, Index)
		Frame.Tags.Evo.Visible = Index.EvoBaseID ~= nil
	end
}
local StuffTypes = {
	Weapons = true, 
	Pets = true
}
function GridFunctions.Halloween(Frame, Index)
	if not StuffTypes[Index.DataType] then
		Frame.Tags.Halloween.Visible = Index.Event == "Halloween"
		Frame.Tags.Halloween.Year.Text = Index.Year or ""
	end
end
function GridFunctions.Christmas(Frame, Index)
	if not StuffTypes[Index.DataType] then
		Frame.Tags.Christmas.Visible = Index.Event == "Christmas"
		Frame.Tags.Christmas.Year.Text = Index.Year or ""
	end
end
local Rarities = _G.Database.Rarity
function Module.DisplayItem(Frame, ItemData, Amount, Index)
	if ItemData == nil then
		Frame.ItemName.Label.Text = ""
		Frame.Container.Icon.Image = ""
		Frame.ItemName.BackgroundColor3 = Color3.fromRGB(95, 95, 95)
		return
	end
	Frame.ItemName.Label.Text = ItemData.ItemName or ItemData.Name
	ItemData.Rarity = ItemData.Rarity or "Common"
	local RarityColors = Rarities[ItemData.Rarity]
	local ColoredBackground = Color3.new(1, 1, 1)
	Frame.ItemName.BackgroundColor3 = ColoredBackground
	Frame.Container.Icon.Image = GetImage(ItemData.Image)
	if Frame.Container:FindFirstChild("Amount") then
		local ItemAmount = Amount or ItemData.Amount
		local CurrentItemAmount
		if ItemAmount then
			CurrentItemAmount = ItemAmount > 1 and "x" .. ItemAmount or ""
		else
			CurrentItemAmount = ""
		end
		Frame.Container.Amount.Text = CurrentItemAmount
	end
	if Frame.Container:FindFirstChild("Classic") then
		Frame.Container.Classic.Visible = ItemData.Classic ~= nil
	end
	if Frame.ItemName:FindFirstChild("ColoredName") then
		Frame.ItemName.ColoredName.Text = ItemData.ItemName or ItemData.Name
		local ItemBG = ColoredBackground
		if ItemData.Rarity == "Common" then
			ItemBG = Color3.new(1, 1, 1)
		end
		Frame.ItemName.ColoredName.TextColor3 = ItemBG
		Frame.ItemName.RarityBar.BackgroundColor3 = ItemBG
	end
	for i, CreateGrid in pairs(GridFunctions) do
		if Frame.Tags:FindFirstChild(i) then
			CreateGrid(Frame, ItemData)
		end
	end
	if ItemData.Signature then
		local PlayerName = ItemData.Signature
		if PlayerName ~= "" then
			Frame.Tags.Unique.PlayerName.Text = PlayerName .. "'s"
			Frame.Tags.Unique.Visible = true
			if tonumber(PlayerName) then
				spawn(function()
					Frame.Tags.Unique.PlayerName.Text = game.Players:GetNameFromUserIdAsync(math.abs(ItemData.Signature)) .. "'s"
				end)
			end
		end
		Frame.Container.Amount.Text = ItemData.Rank and "#" .. ItemData.Rank or ""
	end
	if Index then end
end
function Module.Commafy(amount)
	local formatted = amount
	while true do
		formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", "%1,%2")
		if (k==0) then
			break
		end	
	end
	return formatted
end
function Module.AnimateItemIconIntoInventory(item, itemSize, inventory)
	local smallItem = item:Clone()
	local AbsoluteSize1 = item.AbsoluteSize.X
	local AbsoluteSize2 = item.AbsoluteSize.Y
	smallItem.Size = UDim2.new(0, AbsoluteSize1, 0, AbsoluteSize2)
	smallItem.BackgroundTransparency = 1
	smallItem.Position = UDim2.new(0, item.AbsolutePosition.X + AbsoluteSize1 / 2, 0, item.AbsolutePosition.Y + AbsoluteSize2 / 2)
	smallItem.AnchorPoint = Vector2.new(0.5, 0.5)
	smallItem.ZIndex = 10
	smallItem.Parent = inventory
	spawn(function()
		smallItem:TweenSizeAndPosition(UDim2.new(0, 25, 0, 25), UDim2.new(0, itemSize.AbsolutePosition.X + itemSize.AbsoluteSize.X / 2 - 3, 0, itemSize.AbsolutePosition.Y + itemSize.AbsoluteSize.Y / 2 - 20), "InOut", "Sine", 0.5)
		wait(0.5)
		smallItem:Destroy()
	end)
end
return Module
