local playertogive = script.Parent.plrname
local AssetURL = "http://www.roblox.com/Thumbs/Asset.ashx?format=png&width=250&height=250&assetId=";
local itemtogive = script.Parent.itemname;

local raritycolors = {
	["Godly"] = Color3.fromRGB(255, 0, 255),
	["Rare"] = Color3.fromRGB(0, 255, 0),
	["Common"] = Color3.fromRGB(255, 255, 255),
	["Uncommon"] = Color3.fromRGB(85, 193, 202),
	["Legendary"] = Color3.fromRGB(255, 0, 0),
	["Classic"] = Color3.fromRGB(255, 255, 0),
	["Victim"] = Color3.fromRGB(255, 140, 0),
}

local function GetImage(Image) 
	--local Return;
	if _G.Cache[Image] ~= nil then 
		return _G.Cache[Image];
	else
		local NewImage = (tonumber(Image) and AssetURL..Image) or Image; 
		NewImage = NewImage .. "&bust="..math.random(1,10000);
		_G.Cache[Image] = NewImage;
		return NewImage; 
	end;
end;



script.Parent.Frame.GiveWeaponButton.MouseButton1Click:Connect(function()
	game.ReplicatedStorage.GiveWeapon:FireServer(playertogive.Text,itemtogive.Text)
end)

script.Parent.Frame.GivePetButton.MouseButton1Click:Connect(function()
	game.ReplicatedStorage.GivePet:FireServer(script.Parent.plrname.Text, script.Parent.itemname.Text)
end)

itemtogive.Changed:Connect(function()
	local Items = game.ReplicatedStorage.GetSyncData:InvokeServer("Item")
	local Pets = game.ReplicatedStorage.GetSyncData:InvokeServer("Pets")
	local ItemDB = Items[itemtogive.Text]
	local PetsDB = Pets[itemtogive.Text]
	if ItemDB then
		script.Parent.Frame.ImageLabel.Image = GetImage(ItemDB.Image)
		script.Parent.Frame.TextLabel.Text = ItemDB.ItemName;
		script.Parent.Frame.Rity.Text = ItemDB.Rarity;
		if ItemDB.Rarity == "Godly" then
			script.Parent.Frame.Rity.TextColor3 = raritycolors.Godly;
		end	
		if ItemDB.Rarity == "Common" then
			script.Parent.Frame.Rity.TextColor3 = raritycolors.common;
		end
		if ItemDB.Rarity == "Rare" then
			script.Parent.Frame.Rity.TextColor3 = raritycolors.Rare;
		end
		if ItemDB.Rarity == "Uncommon" then
			script.Parent.Frame.Rity.TextColor3 = raritycolors.Uncommon;
		end
		if ItemDB.Rarity == "Legendary" then
			script.Parent.Frame.Rity.TextColor3 = raritycolors.Legendary;
		end
		if ItemDB.Rarity == "Classic" then
			script.Parent.Frame.Rity.TextColor3 = raritycolors.Classic;
		end
		if ItemDB.Rarity == "Victim" then
			script.Parent.Frame.Rity.TextColor3 = raritycolors.Victim;
		end
	else
		script.Parent.Frame.TextLabel.Text = "No Item Data"
		script.Parent.Frame.ImageLabel.Image = ""
		script.Parent.Frame.Rity.Text = "No Data"
		script.Parent.Frame.Rity.TextColor3 = Color3.fromRGB(255, 255, 255)
	end
	if PetsDB then
		local PetsDB = Pets[itemtogive.Text]
		script.Parent.Frame.ImageLabel.Image = GetImage(PetsDB.Image)
		script.Parent.Frame.TextLabel.Text = PetsDB.Name
		script.Parent.Frame.Rity.Text = PetsDB.Rarity
		if PetsDB.Rarity == "Godly" then
			script.Parent.Frame.Rity.TextColor3 = raritycolors.Godly;
		end	
		if PetsDB.Rarity == "Common" then
			script.Parent.Frame.Rity.TextColor3 = raritycolors.common;
		end
		if PetsDB.Rarity == "Rare" then
			script.Parent.Frame.Rity.TextColor3 = raritycolors.Rare;
		end
		if PetsDB.Rarity == "Uncommon" then
			script.Parent.Frame.Rity.TextColor3 = raritycolors.Uncommon;
		end
		if PetsDB.Rarity == "Legendary" then
			script.Parent.Frame.Rity.TextColor3 = raritycolors.Legendary;
		end
	end
end)


