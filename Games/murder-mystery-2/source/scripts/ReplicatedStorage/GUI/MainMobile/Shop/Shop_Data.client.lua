local GameGUI = script.Parent.Parent.Lobby;
local ShopFrame = GameGUI.Screens.Shop;
local TitleFrame = ShopFrame.Title;
local Main = ShopFrame.Main;
_G.PromptingPurchase = false
local Navigation = ShopFrame.Main.Featured.Nav.Container;
local FeaturedFrame = ShopFrame.Main.Featured;
local FeaturedItems = game.ReplicatedStorage.GetSyncData:InvokeServer("Featured");
local FeaturedBox = game.ReplicatedStorage.GetSyncData:InvokeServer("FeaturedBox");
local PurchasePromptFrame = ShopFrame.Main.BuyPopup.Container.PriceFrame
local HasRadio,CanUseRadio = game.ReplicatedStorage.HasRadio:InvokeServer();
local ViewContents = Main.ViewCrate
local ViewContentsInfo = ViewContents.Container.BoxFrame.RarityFrame
local ViewContentsItems = ViewContents.Container.BoxContents.ScrollingFrame.Container;
local ViewConnection = ViewContents.Container.BuyFrame.PurchaseOptions.Container.Coins.MouseButton1Click:connect(function()end);
local ViewGemsConnection = ViewContents.Container.BuyFrame.PurchaseOptions.Container.Gems.MouseButton1Click:connect(function()end);
local ViewCandiesConnection = ViewContents.Container.BuyFrame.PurchaseOptions.Container.Candies.MouseButton1Click:connect(function()end);
local ViewReaverKeysConnection = ViewContents.Container.BuyFrame.PurchaseOptions.Container.ReaverKey.MouseButton1Click:connect(function()end);
local ViewKeysConnection = ViewContents.Container.BuyFrame.PurchaseOptions.Container.Key.MouseButton1Click:connect(function()end);
local AmmountKeys = game.ReplicatedStorage.GetKeys:InvokeServer()
local _,_,HasElite = game.ReplicatedStorage.GetPlayerLevel:InvokeServer(game.Players.LocalPlayer);

local Dock = GameGUI.Dock;
local Remote = game.ReplicatedStorage;
local Remotes = Remote.Remotes;
local AssetURL = "http://www.roblox.com/Thumbs/Asset.ashx?format=png&width=250&height=250&assetId=";

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

function comma_value(amount)
	local formatted = amount
	while true do  
		formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
		if (k==0) then
			break
		end
	end
	return formatted
end

local OpenCrate = require(game.ReplicatedStorage.Modules.BoxModule);

local GridObjectFrame = script.Item;
local Items = Remote.GetSyncData:InvokeServer("Item");
local RarityColors = Remote.GetSyncData:InvokeServer("Rarity");

local Time = 0.2;
local Style = "Quad";
local Direction = "Out";

local TestServerID = 10357117595;
local MM2ID = 10571327897;
local HardcoreID = 10639318040;
local HardcorelTestID = 10190553400;
_G.CurrentItemPrompted = nil
local IsHardcore = (game.PlaceId == HardcoreID or game.PlaceId == HardcorelTestID);

local Database = {
	--[[Weapons = {
		Crates = Remote.GetSyncData:InvokeServer("MysteryBox");
		Bundles = Remote.GetSyncData:InvokeServer("Bundles");
	};]]
	Weapons = Remote.GetSyncData:InvokeServer("Bundles");
	Effects = Remote.GetSyncData:InvokeServer("Effects");
	Perks = Remote.GetSyncData:InvokeServer("Perks");
	Emotes = Remote.GetSyncData:InvokeServer("Emotes");
	Radios = Remote.GetSyncData:InvokeServer("Radios");
	Pets = Remote.GetSyncData:InvokeServer("Pets");
	Outfits = Remote.GetSyncData:InvokeServer("Outfits");
	--Recipes = Remote.GetSyncData:InvokeServer("Recipe");
};
local Crates = Remote.GetSyncData:InvokeServer("MysteryBox");

local Stuff = {"Weapons","Emotes","Effects","Perks","Radios","Pets","Outfits"};
local MyStuff = {
	Weapons = nil;
	Effects = nil;
	Perks = nil;
	Emotes = nil;
	Radios = nil;
	Pets = nil;
	Outfits = nil;
};

local function CopyTable(original) local copy = {} for k, v in pairs(original) do if type(v) == 'table' then v = CopyTable(v) end copy[k] = v end return copy end

local function CheckForItem(ItemName,DataName)
	if MyStuff[DataName].Owned[ItemName] and DataName ~= "Weapons" then
		return true;
	end
	for _,Item in pairs(MyStuff[DataName].Owned) do
		if Item == ItemName and Item ~= "Weapons" then
			return true;
		end
	end
	return false;
end

for _,DataName in pairs(Stuff) do
	MyStuff[DataName] = CopyTable(_G.PlayerData[DataName]);
end

for DataName,Data in pairs(Database) do
	local NewTable = {};
	local function Sort(A,B)
		local ItemDataA = A.ItemData;
		local ItemDataB = B.ItemData;

		--[[if ItemDataA.Price == ItemDataB.Price then
			return ItemDataA.Name < ItemDataB.Name;
		end	]]	

		local BundleA = (ItemDataA.Price==nil);
		local BundleB = (ItemDataB.Price==nil);

		if ItemDataA.Price == "NotForSale" and ItemDataB.Price ~= "NotForSale" then
			return false;
		elseif ItemDataB.Price == "NotForSale" and ItemDataA.Price ~= "NotForSale" then
			return true;
		elseif BundleA and not BundleB then
			return true;
		elseif BundleB and not BundleA then
			return false;
		elseif ItemDataA.Chances and not ItemDataB.Chances then
			return true;
		elseif ItemDataB.Chances and not ItemDataA.Chances then
			return false;
		elseif ItemDataA.Price=="Elite" and ItemDataB.Price~="Elite" then
			return true;
		elseif ItemDataB.Price=="Elite" and ItemDataA.Price~="Elite" then
			return false;			
		elseif tonumber(ItemDataA.Price) and tonumber(ItemDataB.Price) then
			if ItemDataA.Gems and not ItemDataB.Gems then
				return false;
			elseif ItemDataB.Gems and not ItemDataA.Gems then
				return true;
			else 
				return ItemDataA.Price < ItemDataB.Price;
			end;
		elseif ItemDataA.Price then
			return false;
		elseif ItemDataB.Price then
			return true;
		else
			return ItemDataA.Name < ItemDataB.Name;
		end;
	end

	--if DataName ~= "Weapons" then
	for ItemID,ItemData in pairs(Data) do
		table.insert(NewTable,{
			ItemID = ItemID;
			ItemData = ItemData;
		});
	end
	for ItemID,ItemData in pairs(Crates) do
		if ItemData.Type == DataName then

			if ItemData.Chances then

				local Contents = {};

				for Rarity,Chance in pairs(ItemData.Chances) do

					if Chance>0 then

						for _,BData in pairs(Crates) do
							if BData.Contents and BData.Type == "Weapons" and not BData.Chances then
								for _,ItemID in pairs(BData.Contents) do
									if Items[ItemID].Rarity == Rarity then							
										table.insert(Contents,ItemID);
									end;
								end
							end;
						end

					end;

				end;

				ItemData.Contents = Contents;

			end

			table.insert(NewTable,{
				ItemID = ItemID;
				ItemData = ItemData;
				Type = "Crate";
			});

		end
	end
	--else
		--[[for Type,Data2 in pairs(Data) do
			for ItemID,ItemData in pairs(Data2) do
				if ItemData.Price or Type == "Bundles" then
					table.insert(NewTable,{
						ItemID = ItemID;
						ItemData = ItemData;
						Type = (Type=="Crates" and "Weapon Crate") or "Bundle";
					});
				end;
			end
		end
	end;]]
	table.sort(NewTable,Sort);
	Database[DataName] = {
		Sorted = NewTable;
		Original = Data;
	};

end;



local function ViewContentsClick(IsBundle,ItemData,EliteLocked,DataName,ItemID)
	if not _G.Tweening then
		_G.ViewContentsDataName = DataName
		script.Parent.Click:Play();
		local Price;
		local GemsPrice;
		local OwnedCandies = _G.PlayerData.Materials.Owned.Candies

		Price = ItemData.Price;
		GemsPrice = ItemData.GemsPrice;
		ViewContentsInfo.Visible = true ---ItemData.Chances~=nil;
		local Chances = nil

		if Chances==nil then
			Chances = {
				["Common"] = 70;
				["Uncommon"] = 15;
				["Rare"] = 10;
				["Legendary"] = 5;
			};
		end

		for Rarity,Chance in pairs(Chances) do
			ViewContentsInfo[Rarity].Chance.Text = Chance.."%";
		end;
		
		if GemsPrice == 0 then
			_G.HasGems = false
		else
			_G.HasGems = true
		end

		if _G.PlayerData.Materials.Owned["SnowTokens"] and _G.PlayerData.Materials.Owned["SnowTokens"] >= Price then
			_G.HasCandies = true
		end

		--end;
		--	ViewContentsInfo.Description.Text = "Buy this crate and randomly receive one of these skins!";
		local BuyWait = false;
		ViewConnection:disconnect();
		ViewConnection = ViewContents.Container.BuyFrame.PurchaseOptions.Container.Coins.MouseButton1Click:connect(function()
			local EliteBuy = (EliteLocked==true and HasElite==true) or (EliteLocked==false);
			if _G.PlayerData.Credits >= Price --[[and not BuyWait]] then
				BuyWait = true;
				--ViewContentsInfo.Buy.Style = Enum.ButtonStyle.RobloxRoundButton;
				--ViewContentsInfo.Buy.Text = "Purchased!";
				_G.PlayerData.Credits = _G.PlayerData.Credits - Price;
				if EliteBuy then
					if ItemID ~= nil then
					ShopFrame.Visible = false;
					if ItemData.Type == "Weapons" then
						_G.Process("Unboxing");
					else
						_G.Process("Hatching");	
					end
					local StartTime = time();
					local OpenedItem = Remotes.Shop.OpenCrate:InvokeServer(ItemID,true,false,false,false,false);
					wait( 0.33-(time()-StartTime));
						--InventoryFrame.Overlay.Visible = false;
					GameGUI.Screens.Processing.Visible = false
					if OpenedItem and ItemData.Type == "Weapons" then
							game.ReplicatedStorage.Remotes.Shop.BoxController:Fire(ItemID,OpenedItem,false,"Weapons")
						elseif OpenedItem then
							game.ReplicatedStorage.Remotes.Shop.BoxController:Fire(ItemID,OpenedItem,true,"Pets")
					end
						end
				else
					ShopFrame.Visible = false;
					GameGUI.GetElite.Visible = true;
				end;
				game.ReplicatedStorage.UpdateDataClient:Fire();
				wait(1);
				BuyWait = false;

			else
				_G.GetCredits();
			end;
		end)
		ViewGemsConnection:disconnect();
		ViewGemsConnection = ViewContents.Container.BuyFrame.PurchaseOptions.Container.Gems.MouseButton1Click:connect(function()
			local EliteBuy = (EliteLocked==true and HasElite==true) or (EliteLocked==false);
			if _G.HasGems == true and _G.PlayerData.Gems >= GemsPrice --[[and not BuyWait]] then
				BuyWait = true;
				--ViewContentsInfo.Buy.Style = Enum.ButtonStyle.RobloxRoundButton;
				--ViewContentsInfo.Buy.Text = "Purchased!";
				_G.PlayerData.Gems = _G.PlayerData.Gems - GemsPrice;
				if EliteBuy then
					if ItemID ~= nil then
					ShopFrame.Visible = false;
					if ItemData.Type == "Weapons" then
						_G.Process("Unboxing");
					else
						_G.Process("Hatching");	
					end
					local StartTime = time();
					local OpenedItem = Remotes.Shop.OpenCrate:InvokeServer(ItemID,false,false,false,false,true);
					wait( 0.33-(time()-StartTime));
						--InventoryFrame.Overlay.Visible = false;
						GameGUI.Screens.Processing.Visible = false
					if OpenedItem and ItemData.Type == "Weapons" then
							game.ReplicatedStorage.Remotes.Shop.BoxController:Fire(ItemID,OpenedItem,false,"Weapons")
						elseif OpenedItem then
							game.ReplicatedStorage.Remotes.Shop.BoxController:Fire(ItemID,OpenedItem,true,"Pets")
					end
						end
				else
					ShopFrame.Visible = false;
					GameGUI.GetElite.Visible = true;
				end;
				game.ReplicatedStorage.UpdateDataClient:Fire();
				wait(1);
				BuyWait = false;
			elseif _G.HasGems == false then
				-- do nothing
			else
				_G.GetGems();
			end;

		end)
		ViewCandiesConnection:disconnect();
		ViewCandiesConnection = ViewContents.Container.BuyFrame.PurchaseOptions.Container.Candies.MouseButton1Click:connect(function()
			local EliteBuy = (EliteLocked==true and HasElite==true) or (EliteLocked==false);
			if _G.HasCandies == true and _G.PlayerData.Materials.Owned["SnowTokens"] >= Price --[[and not BuyWait]] then
				BuyWait = true;
				--ViewContentsInfo.Buy.Style = Enum.ButtonStyle.RobloxRoundButton;
				--ViewContentsInfo.Buy.Text = "Purchased!";
				_G.PlayerData.Materials.Owned["SnowTokens"] = _G.PlayerData.Materials.Owned["SnowTokens"] - Price;
				if EliteBuy then
					if ItemID ~= nil then
					ShopFrame.Visible = false;
					if ItemData.Type == "Weapons" then
						_G.Process("Unboxing");
					else
						_G.Process("Hatching");	
					end
					local StartTime = time();
					local OpenedItem = Remotes.Shop.OpenCrate:InvokeServer(ItemID,false,true,false,false,false);
					wait( 0.33-(time()-StartTime));
						--InventoryFrame.Overlay.Visible = false;
						GameGUI.Screens.Processing.Visible = false
					if OpenedItem and ItemData.Type == "Weapons" then
							game.ReplicatedStorage.Remotes.Shop.BoxController:Fire(ItemID,OpenedItem,false,"Weapons")
						elseif OpenedItem then
							game.ReplicatedStorage.Remotes.Shop.BoxController:Fire(ItemID,OpenedItem,true,"Pets")
					end
						end
				else
					ShopFrame.Visible = false;
					GameGUI.GetElite.Visible = true;
				end;
				game.ReplicatedStorage.UpdateDataClient:Fire();
				wait(1);
				BuyWait = false;
			elseif _G.HasCandies == false then
				-- do nothing
			else
				_G.ViewCandies();
			end;

		end)
		ViewReaverKeysConnection:disconnect();
		ViewReaverKeysConnection = ViewContents.Container.BuyFrame.PurchaseOptions.Container.ReaverKey.MouseButton1Click:connect(function()
			local EliteBuy = (EliteLocked==true and HasElite==true) or (EliteLocked==false);
			if game.ReplicatedStorage.GetReaverKeys:InvokeServer() then
				BuyWait = true;
				--ViewContentsInfo.Buy.Style = Enum.ButtonStyle.RobloxRoundButton;
				--ViewContentsInfo.Buy.Text = "Purchased!";
				if EliteBuy then
					if ItemID ~= nil then
					ShopFrame.Visible = false;
						if ItemData.Type == "Weapons" then
							_G.Process("Unboxing");
						else
							_G.Process("Hatching");	
						end
					_G.Unboxing = true;
					local StartTime = time();
					local OpenedItem = Remotes.Shop.OpenCrate:InvokeServer(ItemID,false,false,false,true,false);
					wait( 0.33-(time()-StartTime));
					--InventoryFrame.Overlay.Visible = false;
						--InventoryFrame.Overlay.Visible = false;
						GameGUI.Screens.Processing.Visible = false
						if OpenedItem and ItemData.Type == "Weapons" then
							game.ReplicatedStorage.Remotes.Shop.BoxController:Fire(ItemID,OpenedItem,false,"Weapons")
						elseif OpenedItem then
							game.ReplicatedStorage.Remotes.Shop.BoxController:Fire(ItemID,OpenedItem,true,"Pets")
						end
					end
				else
					ShopFrame.Visible = false;
					GameGUI.GetElite.Visible = true;
				end;
				game.ReplicatedStorage.UpdateDataClient:Fire();
				wait(1);
				BuyWait = false;

			else
			--	_G.GetCredits();
			end;

		end)
		ViewKeysConnection:Disconnect();
		ViewKeysConnection = ViewContents.Container.BuyFrame.PurchaseOptions.Container.Key.MouseButton1Click:connect(function()
			local EliteBuy = (EliteLocked==true and HasElite==true) or (EliteLocked==false);
			if game.ReplicatedStorage.GetKeys:InvokeServer() then
				BuyWait = true;
				--ViewContentsInfo.Buy.Style = Enum.ButtonStyle.RobloxRoundButton;
				--ViewContentsInfo.Buy.Text = "Purchased!";
				if EliteBuy then
					if ItemID ~= nil then
					ShopFrame.Visible = false;
						if ItemData.Type == "Weapons" then
							_G.Process("Unboxing");
						else
							_G.Process("Hatching");	
						end
					_G.Unboxing = true;
					local StartTime = time();
					local OpenedItem = Remotes.Shop.OpenCrate:InvokeServer(ItemID,false,false,true,false,false);
					wait( 0.33-(time()-StartTime));
					--InventoryFrame.Overlay.Visible = false;
						--InventoryFrame.Overlay.Visible = false;
						GameGUI.Screens.Processing.Visible = false
						if OpenedItem and ItemData.Type == "Weapons" then
							game.ReplicatedStorage.Remotes.Shop.BoxController:Fire(ItemID,OpenedItem,false,"Weapons")
						elseif OpenedItem then
							game.ReplicatedStorage.Remotes.Shop.BoxController:Fire(ItemID,OpenedItem,true,"Pets")
						end
					end
				else
					ShopFrame.Visible = false;
					GameGUI.GetElite.Visible = true;
				end;
				game.ReplicatedStorage.UpdateDataClient:Fire();
				wait(1);
				BuyWait = false;

			else
				-- Does nothing
			end;

		end)
		ViewContentsInfo.Parent.ItemContainer.Container.Icon.Image = GetImage(ItemData.Image);
		ViewContentsInfo.Parent.ItemContainer.ItemName.Label.Text = ItemData.Name;

		ViewContentsItems:ClearAllChildren();
		for Index,Item in pairs(ItemData.Contents) do
			local Size = script.Content.Size.Y.Scale;
			local Row = math.floor( (Index-1) / (1/Size) ); local Column = (Index-1)%(1/Size);
			local DB = (DataName=="Weapons"and Items) or Database[DataName].Original;
			local ItemData = DB[Item] or DB[Item.ItemName];
			local ContentFrame = script.Content:Clone();
			local ItemGrid2 = script.ContentGridLayout:Clone()
			ItemGrid2.Parent = ViewContentsItems
			local ContentFrameContainer = ContentFrame.Container;
			ContentFrameContainer.Icon.Image = GetImage(ItemData.Image);
			ContentFrameContainer.Parent.ItemName.Label.Text = ItemData.ItemName or ItemData.Name;
			if _G.PlayerData.Weapons.Owned[Item] then
				ContentFrameContainer.Parent.Tags.Owned.Visible = true
			end
			if ItemData.Halloween ~= nil and ItemData.Year ~= nil then
				ContentFrameContainer.Parent.Tags.Halloween.Visible = true
				ContentFrameContainer.Parent.Tags.Halloween.Year.Text = ItemData.Year
			end
			if ItemData.Rarity == "Common" then
				ContentFrameContainer.Parent.ItemName.BackgroundColor3 = Color3.new(0.415686, 0.415686, 0.415686)
			else
				ContentFrameContainer.Parent.ItemName.BackgroundColor3 = RarityColors[ItemData.Rarity];
			end
			ContentFrame.Parent = ViewContentsItems;
		end
		ViewContents.Container.BuyFrame.PurchaseOptions.Container.Coins.Cost.Text = comma_value(Price)
		ViewContents.Container.BuyFrame.PurchaseOptions.Container.Gems.Cost.Text = GemsPrice
		
		if ItemData.ImageRelative ~= nil then
			ViewContentsInfo.Parent.ItemContainer.Container.Icon.SizeConstraint = ItemData.ImageRelative and Enum.SizeConstraint[ItemData.ImageRelative]
		end
		if (ItemData.Price~=nil and ItemData.Candies) then
			ViewContents.Container.BuyFrame.PurchaseOptions.Container.Candies.Visible = true
			ViewContents.Container.BuyFrame.PurchaseOptions.Container.Coins.Visible = false
			ViewContents.Container.BuyFrame.PurchaseOptions.Container.Gems.Visible = false
			ViewContents.Container.BuyFrame.PurchaseOptions.Container.Key.Visible = false
		end
		if (ItemData.Price~=nil and ItemData.ReaverKey) then
			ViewContents.Container.BuyFrame.PurchaseOptions.Container.ReaverKey.Visible = true
			ViewContents.Container.BuyFrame.PurchaseOptions.Container.Coins.Visible = false
			ViewContents.Container.BuyFrame.PurchaseOptions.Container.Gems.Visible = false
			ViewContents.Container.BuyFrame.PurchaseOptions.Container.Key.Visible = false
		end
		if (ItemData.Price~=nil and ItemData.Credits) then
			ViewContents.Container.BuyFrame.PurchaseOptions.Container.Coins.Visible = true
			ViewContents.Container.BuyFrame.PurchaseOptions.Container.Gems.Visible = true
			ViewContents.Container.BuyFrame.PurchaseOptions.Container.Key.Visible = true
			ViewContents.Container.BuyFrame.PurchaseOptions.Container.Candies.Visible = false
			ViewContents.Container.BuyFrame.PurchaseOptions.Container.ReaverKey.Visible = false
		end
		if (ItemData.GemsPrice~=nil and ItemData.DoubleCurrency) then
			ViewContents.Container.BuyFrame.PurchaseOptions.Container.Coins.Visible = true
			ViewContents.Container.BuyFrame.PurchaseOptions.Container.Gems.Visible = true
			ViewContents.Container.BuyFrame.PurchaseOptions.Container.Key.Visible = true
			ViewContents.Container.BuyFrame.PurchaseOptions.Container.Candies.Visible = false
			ViewContents.Container.BuyFrame.PurchaseOptions.Container.ReaverKey.Visible = false
		end
		if ItemData.Classic ~= nil then
			ViewContentsInfo.Parent.ItemContainer.Container.Classic.Visible = true
			ViewContentsInfo.Parent.ItemContainer.Container.Halloween.Visible = false
		end
		if ItemData.ONLYGODLY ~= nil then
			ViewContentsInfo.Parent.ItemContainer.Container.ONLYGODLY.Visible = true
			ViewContentsInfo.Parent.ItemContainer.Container.Halloween.Visible = false
		end
		if ItemData.ONLYANCIENT ~= nil then
			ViewContentsInfo.Parent.ItemContainer.Container.ONLYANCIENT.Visible = true
			ViewContentsInfo.Parent.ItemContainer.Container.Halloween.Visible = false
		end
		if ItemData.ONLYVICTIM ~= nil then
			ViewContentsInfo.Parent.ItemContainer.Container.ONLYVICTIM.Visible = true
			ViewContentsInfo.Parent.ItemContainer.Container.Halloween.Visible = false
		end
		if ItemData.Halloween ~= nil then
			ViewContentsInfo.Parent.ItemContainer.Container.Classic.Visible = false
			ViewContentsInfo.Parent.ItemContainer.Container.Halloween.Visible = false
		end
		if ItemData.NoTags ~= nil then
			ViewContentsInfo.Parent.ItemContainer.Container.Halloween.Visible = false
			ViewContentsInfo.Parent.ItemContainer.Container.Classic.Visible = false
		end
		if ItemData.Price > _G.PlayerData.Credits then
			ViewContents.Container.BuyFrame.PurchaseOptions.Container.Coins.Style = Enum.ButtonStyle.RobloxRoundButton;
		end
		if not _G.PlayerData.Materials.Owned["SnowKey"] then
			ViewContents.Container.BuyFrame.PurchaseOptions.Container.ReaverKey.Visible = false
		end
		if _G.PlayerData.Materials.Owned["SnowKey"] then
			ViewContents.Container.BuyFrame.PurchaseOptions.Container.ReaverKey.Cost.Text = "x1";
		end
		_G.CurrentFrame = "ViewContents";
		_G.Tweening = true;
		Main[DataName].Visible = false
		ViewContents.Visible = true
		_G.Tweening = false;
	end
end
local function PromptPurchase(ItemData,Price,IsGems,Description,ItemID,DataName,Frame)
	if not _G.Tweening and not _G.PromptingPurchase then
		local CanBuy = not CheckForItem(ItemID,DataName);
		if ItemData.Price > _G.PlayerData.Credits then
			ShopFrame.Main.BuyPopup.Container.PriceFrame.Coins.Buy.Style = Enum.ButtonStyle.RobloxRoundButton;
		end
		if CanBuy and not Frame.Parent.Tags.Owned.Visible then
			_G.CurrentItemPrompted = ItemID
			script.Parent.Click:Play();
			ShopFrame.Main.BuyPopup.Visible = true
			ShopFrame.Main.BuyPopup.Container.ItemFrame.ItemContainer.ItemName.Label.Text = ItemData.Name
			ShopFrame.Main.BuyPopup.Container.ItemFrame.ItemContainer.Container.Icon.Image =  (ItemData.Image and GetImage(ItemData.Image)) or (game.Players:GetUserThumbnailAsync(ItemData.UserId,Enum.ThumbnailType.AvatarThumbnail,Enum.ThumbnailSize.Size352x352))
			if ItemData.Rarity then
				ShopFrame.Main.BuyPopup.Container.ItemFrame.ItemContainer.ItemName.BackgroundColor3 = RarityColors[ItemData.Rarity];
			else
				ShopFrame.Main.BuyPopup.Container.ItemFrame.ItemContainer.ItemName.BackgroundColor3 = Color3.new(0.415686, 0.415686, 0.415686)
			end
			if DataName == "Radios" or DataName == "Emotes" then
				ShopFrame.Main.BuyPopup.Container.Description.TextLabel.Text = ItemData.Name
			else
				if ItemData.Description ~= nil then
					ShopFrame.Main.BuyPopup.Container.Description.TextLabel.Text = ItemData.Description
				else
					ShopFrame.Main.BuyPopup.Container.Description.TextLabel.Text = "No description provided."
				end
			end
			ShopFrame.Main.BuyPopup.Container.PriceFrame.GetMoreGems.Visible = false
			ShopFrame.Main.BuyPopup.Container.PriceFrame.Coins.Visible = (ItemData.Price~=nil and not ItemData.Gems);
			ShopFrame.Main.BuyPopup.Container.PriceFrame.Gems.Visible = (ItemData.Price~=nil and ItemData.Gems);
			--
			ShopFrame.Main.BuyPopup.Container.PriceFrame.Coins.Visible = (ItemData.Price~=nil and not ItemData.Gems);
			if ItemData.Gems and ItemData.Price then
				ShopFrame.Main.BuyPopup.Container.PriceFrame.Gems.Visible = true
				ShopFrame.Main.BuyPopup.Container.PriceFrame.Gems.Container.PriceFrame.PriceLabel.Text = comma_value(ItemData.Price)
			elseif not ItemData.Gems and ItemData.Price then
				ShopFrame.Main.BuyPopup.Container.PriceFrame.Coins.Container.PriceFrame.PriceLabel.Text = comma_value(ItemData.Price)
			end
			--
			if ItemData.DoubleCurrency and ItemData.GemsPrice then
				ShopFrame.Main.BuyPopup.Container.PriceFrame.GetMoreGems.Visible = false
			end
			if ItemData.DoubleCurrency and ItemData.Price then
				ShopFrame.Main.BuyPopup.Container.PriceFrame.GetMoreGems.Visible = false
				ShopFrame.Main.BuyPopup.Container.PriceFrame.Coins.Container.PriceFrame.PriceLabel.Text = comma_value(ItemData.Price)
			end
			if ItemData.Gems then
				ShopFrame.Main.BuyPopup.Container.PriceFrame.GetMoreGems.Visible = true
			end
			if (ItemData.Price~=nil and ItemData.Gems) then
				if ItemData.Price > _G.PlayerData.Gems then
					ShopFrame.Main.BuyPopup.Container.PriceFrame.Gems.Visible = true
					ShopFrame.Main.BuyPopup.Container.PriceFrame.GetMoreGems.Visible = false
				end
			end
			if (ItemData.Price~=nil and ItemData.DoubleCurrency) then
				   ShopFrame.Main.ViewCrate.Container.BuyFrame.PurchaseOptions.Container.Gems.Visible = true
				end
			end
		end
		PurchasePromptFrame.Coins.Buy.MouseButton1Click:connect(function()
			if not ItemData.Gems and _G.CurrentItemPrompted == ItemID then
				local Currency = "Credits";
				--local Credits = _G.PlayerData.Credits;
				local CanBuy = not CheckForItem(ItemID,DataName);
				local Amount = _G.PlayerData.Credits;
				if tonumber(Amount) >= tonumber(ItemData.Price) and CanBuy then
					_G.PromptingPurchase = false
					if DataName ~= "Weapons" then
						CanBuy = false;
						Frame.Parent.Tags.Coins.Visible = false;
						Frame.Parent.Tags.Gems.Visible = false;
						Frame.Parent.Tags.Owned.Visible = true;
					end
					PurchasePromptFrame.Parent.Parent.Visible = false
					if DataName == "Pets" then
						local OwnedWeapons = _G.PlayerData.Pets.Owned;
						_G.PlayerData.Pets.Owned[ItemID] = (OwnedWeapons[ItemID] and OwnedWeapons[ItemID]+1) or 1;
					else
						table.insert(_G.PlayerData[DataName].Owned,ItemID);
						_G.CurrentItemPrompted = nil
					end;
					_G.PlayerData[Currency] = _G.PlayerData[Currency] - ItemData.Price;
					game.ReplicatedStorage.UpdateDataClient:Fire();
					game.ReplicatedStorage.Buy:FireServer(ItemID,DataName);
			else
				    if ItemData.Price >= _G.PlayerData.Credits then
					   ShopFrame.Main.BuyPopup.Container.PriceFrame.Coins.Buy.Style = Enum.ButtonStyle.RobloxRoundButton;
				    end
					if Currency == "Gems" then
						_G.GetGems();
					else
					if Price >= _G.PlayerData.Credits then
						ShopFrame.Main.BuyPopup.Container.PriceFrame.Coins.Buy.Style = Enum.ButtonStyle.RobloxRoundButton;
					end
					end;
				end;
			end
		end)
		PurchasePromptFrame.Gems.Buy.MouseButton1Click:connect(function()
			if ItemData.Gems and _G.CurrentItemPrompted == ItemID then
				local Currency = "Gems";
				--local Credits = _G.PlayerData.Credits;
				local CanBuy = not CheckForItem(ItemID,DataName);
				local Amount = _G.PlayerData.Gems;
				if tonumber(Amount) >= tonumber(ItemData.Price) and CanBuy then
					_G.PromptingPurchase = false
					if DataName ~= "Weapons" then
						CanBuy = false;
						Frame.Parent.Tags.Coins.Visible = false;
						Frame.Parent.Tags.Gems.Visible = false;
						Frame.Parent.Tags.Owned.Visible = true;
					end
					PurchasePromptFrame.Parent.Parent.Visible = false
					if DataName == "Pets" then
						local OwnedWeapons = _G.PlayerData.Pets.Owned;
						_G.PlayerData.Pets.Owned[ItemID] = (OwnedWeapons[ItemID] and OwnedWeapons[ItemID]+1) or 1;
				else
						table.insert(_G.PlayerData[DataName].Owned,ItemID);
						_G.CurrentItemPrompted = nil
					end;
					_G.PlayerData.Gems = _G.PlayerData.Gems - ItemData.Price;
					game.ReplicatedStorage.UpdateDataClient:Fire();
					game.ReplicatedStorage.Buy:FireServer(ItemID,DataName);
				else
					if Currency == "Gems" then
						_G.GetGems();
					end
				end;
			end
	end)
		PurchasePromptFrame.GetMoreGems.Buy.MouseButton1Click:connect(function()
			_G.GetGems(ItemData.Price)
	    end)
		PurchasePromptFrame.Parent.Close.MouseButton1Click:connect(function()
			PurchasePromptFrame.Parent.Parent.Visible = false
			_G.CurrentItemPrompted = nil
			_G.PromptingPurchase = false
	end)
--	if _G.NotEnoughCoins == true then
--		ShopFrame.Main.BuyPopup.Container.PriceFrame.Coins.Style = Enum.ButtonStyle.RobloxRoundButton;
--	end
		--end;
		--	ViewContentsInfo.Description.Text = "Buy this crate and randomly receive one of these skins!";

		_G.Tweening = false;
	end;
ShopFrame.Main.ViewCrate.Container.BuyFrame.GetKeys.MouseButton1Click:Connect(function()
	_G.Navigate("Weapons")
end)
for DataName,DatabaseTable in pairs(Database) do
	local Data = DatabaseTable.Sorted;
	local ScrollFrame;
	local i = 0;
	ScrollFrame = Main[DataName].ScrollFrame;


	local AbsoluteSize1;
	local AbsoluteSize2;

	local Container = ScrollFrame.Container;
	local BundlesContainer = Main.Bundles.ScrollFrame.Container
	local BundlesDB = game.ReplicatedStorage.GetSyncData:InvokeServer("Bundles")
	Container:ClearAllChildren();
	local ItemGrid = script.ItemGridLayout:Clone()
	ItemGrid.Framing.Disabled = false
	ItemGrid.Parent = Container

	local function CreateFrame(Index,ItemTable)
		local NewFrame = GridObjectFrame:Clone();
		local FrameContainer = NewFrame.Container;
		local ItemID = ItemTable.ItemID; local ItemData = ItemTable.ItemData;
		local ReleaseTime = ItemData.LayoutOrder;
		NewFrame.LayoutOrder = ReleaseTime
		if ItemData.Type == "Keys" then
			NewFrame.Parent = Main.Weapons.ScrollFrame
		end
		if BundlesDB[ItemID] then
			NewFrame.Parent = BundlesContainer;
			NewFrame.LayoutOrder = BundlesDB[ItemID].LayoutOrder or 0
		else
			NewFrame.Parent = Container;
		end
		if ItemData.Type == "Outfits" then
			FrameContainer.Icon.Image = game.Players:GetUserThumbnailAsync(ItemData.UserId,Enum.ThumbnailType.AvatarThumbnail,Enum.ThumbnailSize.Size352x352);
		else
			FrameContainer.Icon.Image = GetImage(ItemData.Image);
		end
		
		if ItemData.ImageRelative ~= nil then
			NewFrame.Container.Icon.SizeConstraint = ItemData.ImageRelative and Enum.SizeConstraint[ItemData.ImageRelative]
		end
		if ItemData.LayoutOrder ~= nil then
			NewFrame.LayoutOrder =  ItemData.LayoutOrder
		end

		FrameContainer.Parent.ItemName.Label.Text = ItemData.Name
		if ItemData.Rarity then
			FrameContainer.Parent.ItemName.BackgroundColor3 = RarityColors[ItemData.Rarity]
		end

		local EliteLocked = false;
		if ItemTable.Type == "Crate" then
		end;


		FrameContainer.Parent.Tags.Coins.Visible = (ItemData.Price~=nil and not ItemData.Gems);
		FrameContainer.Parent.Tags.Gems.Visible = (ItemData.Price~=nil and ItemData.Gems);		

		if ItemData.Price and not CheckForItem(ItemID,DataName) then
			if ItemData.Price == "Elite" or EliteLocked then
				FrameContainer.Parent.Tags.Coins.Visible = false;
				FrameContainer.Parent.Tags.Gems.Visible = false;
			elseif ItemData.Candies ~= nil then
				FrameContainer.Parent.Tags.Coins.Visible = false;
				FrameContainer.Parent.Tags.Gems.Visible = false;
			elseif ItemData.ONLYGODLY ~= nil then
				FrameContainer.Parent.Container.ONLYGODLY.Visible = true;
				FrameContainer.Parent.Tags.Coins.Container.PriceFrame.PriceLabel.Text = comma_value(ItemData.Price);
			elseif ItemData.ONLYANCIENT ~= nil then
				FrameContainer.Parent.Container.ONLYANCIENT.Visible = true;
				FrameContainer.Parent.Tags.Coins.Container.PriceFrame.PriceLabel.Text = comma_value(ItemData.Price);
			elseif ItemData.ONLYVICTIM ~= nil then
				FrameContainer.Parent.Container.ONLYVICTIM.Visible = true;
				FrameContainer.Parent.Tags.Coins.Container.PriceFrame.PriceLabel.Text = comma_value(ItemData.Price);
			elseif ItemData.Classic ~= nil then
				FrameContainer.Parent.Container.Classic.Visible = true;
				FrameContainer.Parent.Tags.Coins.Visible = true
				FrameContainer.Parent.Tags.Gems.Visible = true;
				FrameContainer.Parent.Tags.Gems.Container.PriceFrame.PriceLabel.Text = comma_value(ItemData.GemsPrice);
				FrameContainer.Parent.Tags.Coins.Container.PriceFrame.PriceLabel.Text = comma_value(ItemData.Price);
			elseif ItemData.DoubleCurrency ~= nil then -- currently broken
				FrameContainer.Parent.Tags.Coins.Visible = true;
				FrameContainer.Parent.Tags.Gems.Visible = true;
				FrameContainer.Parent.Tags.Gems.Container.PriceFrame.PriceLabel.Text = comma_value(ItemData.GemsPrice);
				FrameContainer.Parent.Tags.Coins.Container.PriceFrame.PriceLabel.Text = comma_value(ItemData.Price);
			elseif ItemData.Gems == nil then
				FrameContainer.Parent.Tags.Coins.Visible = true
				FrameContainer.Parent.Tags.Coins.Container.PriceFrame.PriceLabel.Text = comma_value(ItemData.Price);
			elseif ItemData.Gems ~= nil then
				FrameContainer.Parent.Tags.Coins.Visible = false
				FrameContainer.Parent.Tags.Gems.Container.PriceFrame.PriceLabel.Text = comma_value(ItemData.Price);
				FrameContainer.Parent.Tags.Coins.Container.PriceFrame.PriceLabel.Text = comma_value(ItemData.Price);
			end
		elseif ItemData.Type ~= "Bundle" then
			FrameContainer.Parent.Tags.Coins.Visible = false;
			FrameContainer.Parent.Tags.Gems.Visible = false
			FrameContainer.Parent.Tags.Owned.Visible = (CheckForItem(ItemID,DataName));
		elseif ItemData.Type == "Bundle" then
			if ItemData.Gems then
				FrameContainer.Parent.Tags.Gems.Visible = true
				FrameContainer.Parent.Tags.Gems.Container.PriceFrame.PriceLabel.Text = ItemData.Price;
			elseif not ItemData.Gems and ItemData.Price ~= "NotForSale" then
				FrameContainer.Parent.Tags.Coins.Visible = true
				if ItemData.Price ~= nil then
					FrameContainer.Parent.Tags.Coins.Container.PriceFrame.PriceLabel.Text = ItemData.Price;
				end
			end

		end

		local CanBuy = not CheckForItem(ItemID,DataName);
		FrameContainer.ActionButton.MouseButton1Click:connect(function()
			if ItemData.Price == "Elite" then
				game.ReplicatedStorage.GetElite:FireServer();
			elseif ItemTable.Type ~= "Crate" then
				local Currency = (ItemData.Gems and "Gems") or "Credits";
				--local Credits = _G.PlayerData.Credits;

				local Amount = _G.PlayerData[Currency];
				if CanBuy then
					if ItemData.Type ~= "Radio"  then
						PromptPurchase(ItemData,ItemData.Price,ItemData.Price,ItemData.Description,ItemID,DataName,FrameContainer)
					elseif ItemData.Type == "Radio" and HasRadio then
						PromptPurchase(ItemData,ItemData.Price,ItemData.Price,ItemData.Description,ItemID,DataName,FrameContainer)
					end
					--[[CanBuy = false;
					script.Parent.Ching:Play();
					FrameContainer.Parent.Tags.CoinPrice.Visible = false;
					FrameContainer.Parent.Tags.GemPrice.Visible = false;
					if DataName == "Pets" then
						local OwnedWeapons = _G.PlayerData.Pets.Owned;
						_G.PlayerData.Pets.Owned[ItemID] = (OwnedWeapons[ItemID] and OwnedWeapons[ItemID]+1) or 1;
					else
						table.insert(_G.PlayerData[DataName].Owned,ItemID);
					end;
					_G.PlayerData[Currency] = _G.PlayerData[Currency] - ItemData.Price;
					game.ReplicatedStorage.UpdateDataClient:Fire();
					game.ReplicatedStorage.Buy:FireServer(ItemID,DataName);]]

				else
				end;
			end;
		end)


		local IsCrate = (ItemTable.Type=="Crate");		

		if IsCrate then
			FrameContainer.ActionButton.MouseButton1Click:connect(function()
				ViewContentsClick(IsCrate,ItemData,EliteLocked,DataName,ItemID)
			end)
		end;


		--- Test
		i = i + 1;
	end

	if DataName ~= "Weapons" then
		for Index,Value in pairs(Data) do
			if Value.ItemData.Price ~= "NotForSale" then
				CreateFrame(Index,Value);
			end
		end;
	else
		for Index,Value in pairs(Data) do
			CreateFrame(Index,Value);
		end
	end;

end

if _G.UnfinishedItem ~= nil then
	--_G.NewItem(_G.UnfinishedItem,"You unboxed...",GameGUI.Inventory,_G.UnfinishedType);
end


-- Featured
FeaturedFrame.Offers.PrismaticCover.Image = FeaturedItems.Cover;

if FeaturedItems.CoverID then
	FeaturedFrame.Offers.PrismaticCover.BuyItem.MouseButton1Click:connect(function()
		game.ReplicatedStorage.GetPack:FireServer(FeaturedItems.CoverID);
	end)
end

for i = 1,4 do
	local HotItem = FeaturedItems.HotItems[i];
	local HotBox = FeaturedItems.HotItems[5];
	local Frame = FeaturedFrame.HotItems.Container["Item"..i];
	local BoxFrame = FeaturedFrame.Box.ItemFrame.ItemContainer.Container
	if HotItem then
		if HotItem.Name ~= nil then
			local HotID = HotItem.Name;
			local DataName = HotItem.Type;

			local HotType = HotItem.Type;
			local IsNew = HotItem.New;
			local HotItemData;
			local HotBoxItemData;
			local HotBoxID = HotBox.Name;
			local DataBoxName = HotBox.Type;
			local HotBoxType = HotBox.Type;
			if IsNew then
				Frame.Container.New.Visible = true
			else
				Frame.Container.New.Visible = false
			end
			if HotType == "Item" then
				HotItemData = Items[HotID];
				
			else
				for _,ItemTable in pairs(Database[HotType].Sorted) do
					if ItemTable.ItemID == HotID then
						HotItemData = ItemTable.ItemData;
						HotType = ItemTable.Type or HotType;
					end
				end;
			end;
			if HotBoxType == "Item" then
				HotBoxItemData = Items[HotBoxID];
				
			else
				for _,ItemTable in pairs(Database[HotBoxType].Sorted) do
					if ItemTable.ItemID == HotBoxID then
						HotBoxItemData = ItemTable.ItemData;
						HotBoxType = ItemTable.Type or HotBoxType;
					end
				end;
			end;


			--local HotItemData = Database[HotType].Original[HotID];

			local HotFrame = Frame.Container

			local Price = (HotItemData.Price and HotItemData.Price~="NotForSale" and HotItemData.Price) or nil;		

			HotFrame.Icon.Image = GetImage(HotItemData.Image);
			HotFrame.Parent.ItemName.Label.Text = HotItemData.Name or HotItemData.ItemName or"";
			HotFrame.Parent.ItemName.BackgroundColor3 = RarityColors[HotItemData.Rarity] or Color3.new(1,1,1);
			HotFrame.Parent.Tags.Price.PriceFrame.TagName.Text = comma_value(Price or "");
			HotFrame.Parent.Tags.Price.Visible = (Price~=nil);
			BoxFrame.Icon.Image = GetImage(HotBoxItemData.Image)
			BoxFrame.Parent.ItemName.Label.Text = HotBoxItemData.Name or HotBoxItemData.ItemName or"";
			--HotFrame.Parent.Tags.Price.Icon.Image = (Price~=nil and not HotItemData.Gems and "rbxassetid://3150319038");
			if Price~=nil then
				if not HotItemData.Gems then
					HotFrame.Parent.Tags.Price.Icon.Image = "rbxassetid://197012173"
				elseif HotItemData.Gems then
					HotFrame.Parent.Tags.Price.Icon.Image = "rbxassetid://377010926"
				end
			end
			if HotItemData.Rarity == "Common" then
				HotFrame.Parent.ItemName.BackgroundColor3 = Color3.new(0.415686, 0.415686, 0.415686)
			end
			if not HotItemData.Rarity then
				HotFrame.Parent.ItemName.BackgroundColor3 = Color3.new(0.415686, 0.415686, 0.415686)
			end


			local EliteLocked = false;
			if HotType == "Crate" then local ReleaseTime = HotItemData.Released; if os.time()-ReleaseTime < 86400 then EliteLocked = true; end end;

			HotFrame.ActionButton.MouseButton1Click:connect(function()
				if HotType=="Bundle"or HotType=="Crate"then
					Main.Featured.Visible = false
					ShopFrame.Nav.Container.Weapons.Back.Visible = true
					ShopFrame.Nav.Container.Weapons.IsSelected.Visible = false
					ShopFrame.Nav.Container.Weapons.NotSelected.Visible = false
					ViewContentsClick(HotType=="Bundle",HotItemData,EliteLocked,DataName,HotID);
					PromptPurchase(HotItemData,HotItemData.Price,HotItemData.Price,HotItemData.Description,HotID,DataName,script.Item)
				elseif HotItem.PackID then
					game.ReplicatedStorage.GetPack:FireServer(HotItem.PackID); -- ClockworkPack
				else
					_G.Navigate(DataName)
				end;
			end)
			BoxFrame.ActionButton.MouseButton1Click:connect(function()
				if HotBoxType=="Bundle"or HotBoxType=="Crate"then
					Main.Featured.Visible = false
					ShopFrame.Nav.Container.Weapons.Back.Visible = true
					ShopFrame.Nav.Container.Weapons.IsSelected.Visible = false
					ShopFrame.Nav.Container.Weapons.NotSelected.Visible = false
					ViewContentsClick(HotBoxType=="Bundle",HotBoxItemData,EliteLocked,DataBoxName,HotBoxID);
				elseif HotItem.PackID then
					game.ReplicatedStorage.GetPack:FireServer(HotItem.PackID); -- ClockworkPack
				else
					_G.Navigate(DataName)
				end;
			end)
			BoxFrame.Parent.Parent.Parent.Buy.MouseButton1Click:Connect(function()
				if HotBoxType=="Bundle"or HotBoxType=="Crate"then
					Main.Featured.Visible = false
					ShopFrame.Nav.Container.Weapons.Back.Visible = true
					ShopFrame.Nav.Container.Weapons.IsSelected.Visible = false
					ShopFrame.Nav.Container.Weapons.NotSelected.Visible = false
					ViewContentsClick(HotBoxType=="Bundle",HotBoxItemData,EliteLocked,DataBoxName,HotBoxID);
				elseif HotItem.PackID then
					game.ReplicatedStorage.GetPack:FireServer(HotItem.PackID); -- ClockworkPack
				else
					_G.Navigate(DataName)
				end;
			end)

		else
			Frame.Visible = false;
		end;
	else
		Frame.Visible = false;
	end
end




