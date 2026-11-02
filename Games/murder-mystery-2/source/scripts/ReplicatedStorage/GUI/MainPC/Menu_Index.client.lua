local l__main__1 = script.Parent:WaitForChild("EventMain")
local v1 = {};
v1.Item = script:FindFirstChild("MapItem")
v1.Frames = l__main__1:WaitForChild("Frames")
v1.Buttons = v1.Frames:FindFirstChild("Buttons")
v1.Database = {
	Weapons = game.ReplicatedStorage.GetItemData:InvokeServer("Weapons");
	Effects = game.ReplicatedStorage.GetSyncData:InvokeServer("Effects");
	Perks = game.ReplicatedStorage.GetSyncData:InvokeServer("Perks");
	Emotes = game.ReplicatedStorage.GetSyncData:InvokeServer("Emotes");
	Radios = game.ReplicatedStorage.GetSyncData:InvokeServer("Radios");
	Pets = game.ReplicatedStorage.GetSyncData:InvokeServer("Pets");
	Recipes = game.ReplicatedStorage.GetSyncData:InvokeServer("Recipes");
	Maps = game.ReplicatedStorage.GetSyncData:InvokeServer("Map");
	Rarity = game.ReplicatedStorage.GetSyncData:InvokeServer("Rarity");
	Codes = game.ReplicatedStorage.GetSyncData:InvokeServer("Codes");
	Materials = game.ReplicatedStorage.GetSyncData:InvokeServer("Materials");
};
local function GetImage(Image) 
	local Return
	if _G.Cache[Image] ~= nil then 
		return _G.Cache[Image]
	else
		local NewImage = (tonumber(Image) and AssetURL..Image) or Image 
		NewImage = NewImage .. "&bust="..math.random(1,10000)
		_G.Cache[Image] = NewImage
		return NewImage 
	end
end
v1.Menus = v1.Frames:WaitForChild("Scrollables")
_G.HideAllIndexes = function()
	for index2, foundframes in pairs(v1.Frames:GetChildren()) do
		foundframes.Visible = true
		v1.Frames.Buttons.Visible = true
	end
	for index3, v32 in pairs(v1.Menus:GetChildren()) do
		v32.Visible = false
	end
	for _, foundbuttons in pairs(v1.Buttons:GetChildren()) do
		if not foundbuttons:IsA("UIGridLayout") then
			if foundbuttons:IsA("GuiButton") then
				foundbuttons.Style = Enum.ButtonStyle.RobloxRoundButton
			end
		end
	end

end
v1.Buttons.Maps.MouseButton1Click:Connect(function()
	_G.HideAllIndexes()
	v1.Menus:WaitForChild("Maps").Visible = true
	v1.Buttons.Maps.Style = Enum.ButtonStyle.RobloxRoundDefaultButton
end)
v1.Buttons.Effects.MouseButton1Click:Connect(function()
	_G.HideAllIndexes()
	v1.Menus:WaitForChild("Effects").Visible = true
	v1.Buttons.Effects.Style = Enum.ButtonStyle.RobloxRoundDefaultButton
end)
v1.Buttons.Perks.MouseButton1Click:Connect(function()
	_G.HideAllIndexes()
	v1.Menus:WaitForChild("Perks").Visible = true
	v1.Buttons.Perks.Style = Enum.ButtonStyle.RobloxRoundDefaultButton
end)
v1.Buttons.Emotes.MouseButton1Click:Connect(function()
	_G.HideAllIndexes()
	v1.Menus:WaitForChild("Emotes").Visible = true
	v1.Buttons.Emotes.Style = Enum.ButtonStyle.RobloxRoundDefaultButton
end)
v1.Buttons.Radios.MouseButton1Click:Connect(function()
	_G.HideAllIndexes()
	v1.Menus:WaitForChild("Radios").Visible = true
	v1.Buttons.Radios.Style = Enum.ButtonStyle.RobloxRoundDefaultButton
end)
v1.Buttons.Pets.MouseButton1Click:Connect(function()
	_G.HideAllIndexes()
	v1.Menus:WaitForChild("Pets").Visible = true
	v1.Buttons.Pets.Style = Enum.ButtonStyle.RobloxRoundDefaultButton
end)
v1.Buttons.Materials.MouseButton1Click:Connect(function()
	_G.HideAllIndexes()
	v1.Menus:WaitForChild("Materials").Visible = true
	v1.Buttons.Materials.Style = Enum.ButtonStyle.RobloxRoundDefaultButton
end)
v1.Buttons.Craftables.MouseButton1Click:Connect(function()
	_G.HideAllIndexes()
	v1.Menus:WaitForChild("Recipes").Visible = true
	v1.Buttons.Craftables.Style = Enum.ButtonStyle.RobloxRoundDefaultButton
end)
v1.Buttons.Codes.MouseButton1Click:Connect(function()
	_G.HideAllIndexes()
	v1.Menus:WaitForChild("Codes").Visible = true
	v1.Buttons.Codes.Style = Enum.ButtonStyle.RobloxRoundDefaultButton
end)
function v1.CreateMaps()
	for index, foundmaps in pairs(v1.Database.Maps) do
		if foundmaps.HideIndex then
			return
		end
		local Item = script.MapItem:Clone()
		Item.ItemName.Text = foundmaps.IndexName
		Item.ItemName.Visible = false
		Item.Icon.Image = foundmaps.MapImage
		Item.Name = foundmaps.IndexName
		Item.Parent = v1.Frames.Scrollables.Maps
	end
end
function v1.CreateEffects()
	for index, foundeffects in pairs(v1.Database.Effects) do
		if foundeffects.HideIndex then
			return
		end
		local Item = script.Item:Clone()
		Item.ItemName.Text = foundeffects.Name
		Item.Icon.Image = foundeffects.Image
		Item.Name = foundeffects.Name
		if foundeffects.Rarity == "Common" then
			Item.ItemName.TextColor3 = Color3.new(0.67451, 0.67451, 0.67451);
		elseif foundeffects.Rarity == "Uncommon" then
			Item.ItemName.TextColor3 = Color3.new(0, 1, 1);
		elseif foundeffects.Rarity == "Rare" then
			Item.ItemName.TextColor3 = Color3.new(0, 1, 0);
		elseif foundeffects.Rarity == "Legendary" then
			Item.ItemName.TextColor3 = Color3.new(1, 0, 0);
		elseif foundeffects.Rarity == "Godly" then
			Item.ItemName.TextColor3 = Color3.new(1, 0, 1);
		elseif foundeffects.Rarity == "Ancient" then
			Item.ItemName.TextColor3 = Color3.new(0.513725, 0, 0.772549);
		elseif foundeffects.Rarity == "Victim" then
			Item.ItemName.TextColor3 = Color3.new(1, 0.666667, 0);
		elseif foundeffects.Rarity == "Classic" then
			Item.ItemName.TextColor3 = Color3.new(1, 1, 0);
		elseif foundeffects.Rarity == "Halloween" then
			Item.ItemName.TextColor3 = Color3.new(0.866667, 0.290196, 0);
		elseif foundeffects.Rarity == "Christmas" then
			Item.ItemName.TextColor3 = Color3.new(0, 0.847059, 0.847059);
		end
		Item.Parent = v1.Frames.Scrollables.Effects
	end
end
function v1.CreatePerks()
	for index, foundperks in pairs(v1.Database.Perks) do
		if foundperks.HideIndex then
			return
		end
		local Item = script.Item:Clone()
		Item.ItemName.Text = foundperks.Name
		Item.Icon.Image = foundperks.Image
		Item.Name = foundperks.Name
		Item.Parent = v1.Frames.Scrollables.Perks
	end
end
function v1.CreateEmotes()
	for index, foundemotes in pairs(v1.Database.Emotes) do
		if foundemotes.HideIndex then
			return
		end
		local Item = script.Item:Clone()
		Item.ItemName.Text = foundemotes.Name
		Item.Icon.Image = foundemotes.Image
		Item.Name = foundemotes.Name
		if foundemotes.Rarity == "Common" then
			Item.ItemName.TextColor3 = Color3.new(0.67451, 0.67451, 0.67451);
		elseif foundemotes.Rarity == "Uncommon" then
			Item.ItemName.TextColor3 = Color3.new(0, 1, 1);
		elseif foundemotes.Rarity == "Rare" then
			Item.ItemName.TextColor3 = Color3.new(0, 1, 0);
		elseif foundemotes.Rarity == "Legendary" then
			Item.ItemName.TextColor3 = Color3.new(1, 0, 0);
		elseif foundemotes.Rarity == "Godly" then
			Item.ItemName.TextColor3 = Color3.new(1, 0, 1);
		elseif foundemotes.Rarity == "Ancient" then
			Item.ItemName.TextColor3 = Color3.new(0.513725, 0, 0.772549);
		elseif foundemotes.Rarity == "Victim" then
			Item.ItemName.TextColor3 = Color3.new(1, 0.666667, 0);
		elseif foundemotes.Rarity == "Classic" then
			Item.ItemName.TextColor3 = Color3.new(1, 1, 0);
		elseif foundemotes.Rarity == "Halloween" then
			Item.ItemName.TextColor3 = Color3.new(0.866667, 0.290196, 0);
		elseif foundemotes.Rarity == "Christmas" then
			Item.ItemName.TextColor3 = Color3.new(0, 0.847059, 0.847059);
		end
		Item.Parent = v1.Frames.Scrollables.Emotes
	end
end
l__main__1.Title.Close.MouseButton1Click:Connect(function()
	l__main__1.Visible = false
end)
function v1.CreateRadios()
	for index, foundradios in pairs(v1.Database.Radios) do
		if foundradios.HideIndex then
			return
		end
		local Item = script.Item:Clone()
		Item.ItemName.Text = foundradios.Name
		Item.Icon.Image = GetImage(foundradios.Image)
		Item.Name = foundradios.Name
		if foundradios.Rarity == "Common" then
			Item.ItemName.TextColor3 = Color3.new(0.67451, 0.67451, 0.67451);
		elseif foundradios.Rarity == "Uncommon" then
			Item.ItemName.TextColor3 = Color3.new(0, 1, 1);
		elseif foundradios.Rarity == "Rare" then
			Item.ItemName.TextColor3 = Color3.new(0, 1, 0);
		elseif foundradios.Rarity == "Legendary" then
			Item.ItemName.TextColor3 = Color3.new(1, 0, 0);
		elseif foundradios.Rarity == "Godly" then
			Item.ItemName.TextColor3 = Color3.new(1, 0, 1);
		elseif foundradios.Rarity == "Ancient" then
			Item.ItemName.TextColor3 = Color3.new(0.513725, 0, 0.772549);
		elseif foundradios.Rarity == "Victim" then
			Item.ItemName.TextColor3 = Color3.new(1, 0.666667, 0);
		elseif foundradios.Rarity == "Classic" then
			Item.ItemName.TextColor3 = Color3.new(1, 1, 0);
		elseif foundradios.Rarity == "Halloween" then
			Item.ItemName.TextColor3 = Color3.new(0.866667, 0.290196, 0);
		elseif foundradios.Rarity == "Christmas" then
			Item.ItemName.TextColor3 = Color3.new(0, 0.847059, 0.847059);
		end
		Item.Parent = v1.Frames.Scrollables.Radios
	end
end
function v1.CreatePets()
	for index, foundradios in pairs(v1.Database.Pets) do
		if foundradios.HideIndex then
			return
		end
		local Item = script.Item:Clone()
		Item.ItemName.Text = foundradios.Name
		Item.Icon.Image = "http://www.roblox.com/asset/?id="..foundradios.Image
		Item.Name = foundradios.Name
		if foundradios.Rarity == "Common" then
			Item.ItemName.TextColor3 = Color3.new(0.67451, 0.67451, 0.67451);
		elseif foundradios.Rarity == "Uncommon" then
			Item.ItemName.TextColor3 = Color3.new(0, 1, 1);
		elseif foundradios.Rarity == "Rare" then
			Item.ItemName.TextColor3 = Color3.new(0, 1, 0);
		elseif foundradios.Rarity == "Legendary" then
			Item.ItemName.TextColor3 = Color3.new(1, 0, 0);
		elseif foundradios.Rarity == "Godly" then
			Item.ItemName.TextColor3 = Color3.new(1, 0, 1);
		elseif foundradios.Rarity == "Ancient" then
			Item.ItemName.TextColor3 = Color3.new(0.513725, 0, 0.772549);
		elseif foundradios.Rarity == "Victim" then
			Item.ItemName.TextColor3 = Color3.new(1, 0.666667, 0);
		elseif foundradios.Rarity == "Classic" then
			Item.ItemName.TextColor3 = Color3.new(1, 1, 0);
		elseif foundradios.Rarity == "Halloween" then
			Item.ItemName.TextColor3 = Color3.new(0.866667, 0.290196, 0);
		elseif foundradios.Rarity == "Christmas" then
			Item.ItemName.TextColor3 = Color3.new(0, 0.847059, 0.847059);
		end
		Item.Parent = v1.Frames.Scrollables.Pets
	end
end
function v1.CreateMaterials()
	for index, foundmaterials in pairs(v1.Database.Materials) do
		if foundmaterials.HideIndex then
			return
		end
		local Item = script.Item:Clone()
		Item.ItemName.Text = foundmaterials.Name
		Item.Icon.Image = foundmaterials.Image
		Item.Name = foundmaterials.Name
		if foundmaterials.Rarity == "Common" then
			Item.ItemName.TextColor3 = Color3.new(0.67451, 0.67451, 0.67451);
		elseif foundmaterials.Rarity == "Uncommon" then
			Item.ItemName.TextColor3 = Color3.new(0, 1, 1);
		elseif foundmaterials.Rarity == "Rare" then
			Item.ItemName.TextColor3 = Color3.new(0, 1, 0);
		elseif foundmaterials.Rarity == "Legendary" then
			Item.ItemName.TextColor3 = Color3.new(1, 0, 0);
		elseif foundmaterials.Rarity == "Godly" then
			Item.ItemName.TextColor3 = Color3.new(1, 0, 1);
		elseif foundmaterials.Rarity == "Ancient" then
			Item.ItemName.TextColor3 = Color3.new(0.513725, 0, 0.772549);
		elseif foundmaterials.Rarity == "Victim" then
			Item.ItemName.TextColor3 = Color3.new(1, 0.666667, 0);
		elseif foundmaterials.Rarity == "Classic" then
			Item.ItemName.TextColor3 = Color3.new(1, 1, 0);
		elseif foundmaterials.Rarity == "Halloween" then
			Item.ItemName.TextColor3 = Color3.new(0.866667, 0.290196, 0);
		elseif foundmaterials.Rarity == "Christmas" then
			Item.ItemName.TextColor3 = Color3.new(0, 0.847059, 0.847059);
		end
		Item.Parent = v1.Frames.Scrollables.Materials
	end
end
function v1.CreateRecipes()
	for index, foundmaterials in pairs(v1.Database.Recipes) do
		if foundmaterials.HideIndex then
			return
		end
		local Item = script.Recipe:Clone()
		Item.RecipeName.Text = foundmaterials.Name
		Item.Result.Container.Icon.Image = foundmaterials.Image
		Item.Name = foundmaterials.Name
		if foundmaterials.Rarity == "Common" then
			Item.RecipeName.TextColor3 = Color3.new(0.67451, 0.67451, 0.67451);
		elseif foundmaterials.Rarity == "Uncommon" then
			Item.RecipeName.TextColor3 = Color3.new(0, 1, 1);
		elseif foundmaterials.Rarity == "Rare" then
			Item.RecipeName.TextColor3 = Color3.new(0, 1, 0);
		elseif foundmaterials.Rarity == "Legendary" then
			Item.RecipeName.TextColor3 = Color3.new(1, 0, 0);
		elseif foundmaterials.Rarity == "Godly" then
			Item.RecipeName.TextColor3 = Color3.new(1, 0, 1);
		elseif foundmaterials.Rarity == "Ancient" then
			Item.RecipeName.TextColor3 = Color3.new(0.513725, 0, 0.772549);
		elseif foundmaterials.Rarity == "Victim" then
			Item.RecipeName.TextColor3 = Color3.new(1, 0.666667, 0);
		elseif foundmaterials.Rarity == "Classic" then
			Item.RecipeName.TextColor3 = Color3.new(1, 1, 0);
		elseif foundmaterials.Rarity == "Halloween" then
			Item.RecipeName.TextColor3 = Color3.new(0.866667, 0.290196, 0);
		elseif foundmaterials.Rarity == "Christmas" then
			Item.RecipeName.TextColor3 = Color3.new(0, 0.847059, 0.847059);
		end
		Item.Parent = v1.Frames.Scrollables.Recipes
	end
end
function v1.CreateCodes()
	for index, foundcodes in pairs(v1.Database.Codes) do
		if foundcodes.HideIndex then
			return
		end
		if foundcodes.Index and foundcodes.IndexCode then
			local Item = script.CodeItem:Clone()
			Item.RewardText.Text = v1.Database.Weapons[foundcodes.Prize].ItemName
			Item.Result.Container.Icon.Image = v1.Database.Weapons[foundcodes.Prize].Image
			Item.CodeText.Text = foundcodes.IndexCode
			Item.Parent = v1.Frames.Scrollables.Codes
		end
	end
end
function v1.CreateWeapons()
	for index, foundweapons in pairs(v1.Database.Weapons) do
		if foundweapons.HideIndex then
			return
		end
		local Item = script.Item:Clone()
		Item.ItemName.Text = foundweapons.ItemName
		Item.Icon.Image = foundweapons.Image
		Item.Name = foundweapons.ItemName
		if foundweapons.Rarity == "Common" then
			Item.ItemName.TextColor3 = Color3.new(0.67451, 0.67451, 0.67451);
		elseif foundweapons.Rarity == "Uncommon" then
			Item.ItemName.TextColor3 = Color3.new(0, 1, 1);
		elseif foundweapons.Rarity == "Rare" then
			Item.ItemName.TextColor3 = Color3.new(0, 1, 0);
		elseif foundweapons.Rarity == "Legendary" then
			Item.ItemName.TextColor3 = Color3.new(1, 0, 0);
		elseif foundweapons.Rarity == "Godly" then
			Item.ItemName.TextColor3 = Color3.new(1, 0, 1);
		elseif foundweapons.Rarity == "Ancient" then
			Item.ItemName.TextColor3 = Color3.new(0.513725, 0, 0.772549);
		elseif foundweapons.Rarity == "Victim" then
			Item.ItemName.TextColor3 = Color3.new(1, 0.666667, 0);
		elseif foundweapons.Rarity == "Classic" then
			Item.ItemName.TextColor3 = Color3.new(1, 1, 0);
		elseif foundweapons.Rarity == "Halloween" then
			Item.ItemName.TextColor3 = Color3.new(0.866667, 0.290196, 0);
		elseif foundweapons.Rarity == "Christmas" then
			Item.ItemName.TextColor3 = Color3.new(0, 0.847059, 0.847059);
		end
		Item.Parent = v1.Frames.Scrollables.Weapons
	end
end
v1.CreateMaps()
v1.CreateEffects()
v1.CreatePerks()
v1.CreateEmotes()
v1.CreateRadios()
v1.CreatePets()
v1.CreateMaterials()
v1.CreateRecipes()
v1.CreateCodes()
v1.CreateWeapons()
return v1