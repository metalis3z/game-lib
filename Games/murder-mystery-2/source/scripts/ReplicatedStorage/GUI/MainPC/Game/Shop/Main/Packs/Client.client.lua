local v1 = {};
v1.PackageMain = script.Parent
v1.PopUp = v1.PackageMain.BuyPopup
v1.Player = game.Players.LocalPlayer
v1.ItemParent = v1.PackageMain.ScrollFrame.Container
local AssetURL = "http://www.roblox.com/Thumbs/Asset.ashx?format=png&width=250&height=250&assetId=";
v1.Database = {
	PackModule = game.ReplicatedStorage.GetSyncData:InvokeServer("Gamepasses");
	Rarity = game.ReplicatedStorage.GetSyncData:InvokeServer("Rarity");
};
local function GetImage(Image) 
	local Return;
	if _G.Cache[Image] ~= nil then 
		return _G.Cache[Image];
	else
		local NewImage = (tonumber(Image) and AssetURL..Image) or Image; 
		NewImage = NewImage .. "&bust="..math.random(1,10000); 
		_G.Cache[Image] = NewImage;
		return NewImage; 
	end;
end;
local l__market__1 = game:GetService("MarketplaceService")
for v2, v3 in pairs(v1.ItemParent:GetChildren()) do
	if not v3:IsA("UIGridLayout") or v3:IsA("Frame") then
		v3:Destroy()
	end
end
function v1.u1()
	for v4,v5 in pairs(v1.Database.PackModule) do
		local Item = script.Item:Clone()
		Item.Container.Icon.Image = GetImage(v5.Image)
		Item.ItemName.Label.Text = v5.Name
		Item.ItemName.BackgroundColor3 = v1.Database.Rarity[v5.Rarity]
		Item.Tags.Robux.Container.PriceFrame.PriceLabel.Text = v5.RobuxPrice
		Item.Container.ActionButton.MouseButton1Click:Connect(function()
			v1.PopUp.Container.Close.MouseButton1Click:Connect(function()
				v1.PopUp.Visible = false
			end)
			if v5.Description then
				v1.PopUp.Container.Description.TextLabel.Text = v5.Description;else v1.PopUp.Container.Description.Visible = false;end;
			
			v1.PopUp.Container.PriceFrame.Robux.Container.PriceFrame.PriceLabel.Text = v5.RobuxPrice
			v1.PopUp.Container.ItemFrame.ItemContainer.ItemName.Label.Text = v5.Name
			v1.PopUp.Container.ItemFrame.ItemContainer.ItemName.BackgroundColor3 = v1.Database.Rarity[v5.Rarity];
			v1.PopUp.Container.ItemFrame.ItemContainer.Container.Icon.Image = GetImage(v5.Image);
			v1.PopUp.Container.PriceFrame.Robux.Buy.MouseButton1Click:Connect(function()
				if v5.Type == "Gamepass" then
					l__market__1:PromptGamePassPurchase(v1.Player, v5.GamepassID)
				elseif v5.Type == "TShirt" then
					l__market__1:PromptPurchase(v1.Player, v5.GamepassID)
				elseif v5.Type == "DevProduct" then
					l__market__1:PromptProductPurchase(v1.Player, v5.GamepassID)
				end
			end)
			v1.PopUp.Visible = true
		end)
		Item.Parent = v1.ItemParent
	end
end
v1.u1()
return v1;