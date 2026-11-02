local GameGUI = script.Parent.Parent;
local ShopFrame = GameGUI.Shop;
local TitleFrame = ShopFrame.Title;
local Main = ShopFrame.Main;

local ViewContents = Main.ViewContents
local ViewContentsInfo = ShopFrame.Info;
local ViewContentsItems = ViewContents.Items.ScrollFrame.Container;
---local ViewConnection = ViewContents.Info.Buy.MouseButton1Click:connect(function()end);
local _,_,HasElite = game.ReplicatedStorage.GetPlayerLevel:InvokeServer(game.Players.LocalPlayer);

local Dock = GameGUI.Dock;
local Remote = game.ReplicatedStorage;
local Remotes = Remote.Remotes;
local AssetURL = "http://www.roblox.com/Thumbs/Asset.ashx?format=png&width=250&height=250&assetId=";

local Actions = game:GetService("ContextActionService");

local Bind = function(Name,Button,Function)
	local F = function(_,State)
		if State == Enum.UserInputState.Begin and (not _G.PauseBinds) then
			Function();
		end
	end
	Actions:BindAction(Name,F,false,Button);
end

local Unbind = function(Name,Button,Function)
	Actions:UnbindAction(Name);
end


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

local OpenCrate = require(script.OpenCrate);

local GridObjectFrame = script.Item;
local Items = Remote.GetSyncData:InvokeServer("Item");
local Pets = Remote.GetSyncData:InvokeServer("Pets");
local RarityColors = Remote.GetSyncData:InvokeServer("Rarity");

local Time = 0.2;
local Style = "Quad";
local Direction = "Out";

local TestServerID = 13027726810;
local MM2ID = 13085716426;
local CasualID = (game.PlaceId == MM2ID and 13085716426) or 13085716426;
local IsHardcore = (game.PlaceId == TestServerID or game.PlaceId == MM2ID);

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
	Toys = Remote.GetSyncData:InvokeServer("Toys");
	Pets = Remote.GetSyncData:InvokeServer("Pets");
	Featured = Remote.GetSyncData:InvokeServer("XboxFeatured");
	--Recipes = Remote.GetSyncData:InvokeServer("Recipe");
};

local Crates = Remote.GetSyncData:InvokeServer("MysteryBox");
local Stuff = {"Featured","Weapons","Perks","Effects","Pets"};

local MyStuff = {
	Weapons = nil;
	Effects = nil;
	Perks = nil;
	Emotes = nil;
	Radios = nil;
	Pets = nil;
};

local function CopyTable(original) local copy = {} for k, v in pairs(original) do if type(v) == 'table' then v = CopyTable(v) end copy[k] = v end return copy end

local function CheckForItem(ItemName,DataName)
	--print(ItemName,DataName);
	if MyStuff[ (DataName == "Item" and "Weapons") or DataName].Owned[ItemName] then
		return true;
	end
	for Index,Item in pairs(MyStuff[DataName].Owned) do
		if Item == ItemName or (Index==ItemName and Item>0) then
			return true;
		end
	end
	return false;
end

for _,DataName in pairs(Stuff) do
	if DataName ~= "Featured" then
		MyStuff[DataName] = CopyTable(_G.PlayerData[DataName]);
	end;
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

	if DataName ~= "XboxFeatured" then
		table.sort(NewTable,Sort);
	end;
	
	Database[DataName] = {
		Sorted = NewTable;
		Original = Data;
	};
end;

for Index,Data in pairs(Database.Featured.Sorted) do
	Database.Featured.Sorted[Index].ItemData.ItemData = Database[ Data.ItemData.ItemType ].Original[ Data.ItemData.Name ] or Items[Data.ItemData.Name] ;
end

local SelectFunctions = {};

--[[game:GetService("RunService"):BindToRenderStep("Selection",0,function()
	local Obj = game:GetService("GuiService").SelectedObject
	if Obj and Obj.Name == "Button" and Obj.Parent and Obj.Parent.Parent then
		local SlotName = Obj.Parent.Parent.Name;
		local DataName = Obj.Parent.Parent.Parent.Parent.Parent.Parent.Name;
		if SelectFunctions[DataName] and SelectFunctions[DataName][SlotName] then
			SelectFunctions[DataName][SlotName].Select();
		end;
	end
end)]]

--[[_G.XboxBuy = function()
	print("Buy1");
	local Obj = game:GetService("GuiService").SelectedObject
	if Obj and Obj.Name == "Button" and Obj.Parent and Obj.Parent.Parent then
		print("Buy2");
		local SlotName = Obj.Parent.Parent.Name;
		local DataName = Obj.Parent.Parent.Parent.Parent.Parent.Parent.Name;
		SelectFunctions[DataName][SlotName].Buy();
	end
end]]

--for DataName,DatabaseTable in pairs(Database) do
for _,DataName in pairs(Stuff) do
	local Data = Database[DataName].Sorted;
	
	local i = 0;
	local ScrollFrame = Main[DataName].Items.ScrollFrame;
	local InfoFrame = ShopFrame.Info;
	local Container = ScrollFrame.Container;
	local Size = GridObjectFrame.Size.Y.Scale; 
	local AxisLength = math.floor(1/Size)
	
	if Main[DataName]:FindFirstChild("Casual") then
		Main[DataName].Casual.Visible = IsHardcore;
	end
	
	local AbsoluteSize1;
	local AbsoluteSize2;
	local GetSizeFrame = GridObjectFrame:Clone(); 
	Container.Size = UDim2.new(1,0,1,0);
	GetSizeFrame.Parent = Container;
	AbsoluteSize1 = GetSizeFrame.AbsoluteSize.Y;
	Container.Size = UDim2.new(1,-ScrollFrame.ScrollBarThickness-1,1,0);
	AbsoluteSize2 = GetSizeFrame.AbsoluteSize.Y;
	GetSizeFrame:Destroy();
	
	local MaxRow = math.floor( (#Data) / AxisLength);
	local ScrollSize = ((MaxRow+1)*AbsoluteSize1)-1;
	local ShowScroll = (ScrollSize > ScrollFrame.AbsoluteSize.Y);
	if ShowScroll then 
		ScrollSize = (MaxRow+1)*AbsoluteSize2;
		--ShowScroll = (ScrollSize >= ScrollFrame.AbsoluteSize.Y);
	end
	Container.Size = (ShowScroll and UDim2.new(1,-ScrollFrame.ScrollBarThickness-1,1,0)) or UDim2.new(1,0,1,0);
	ScrollFrame.CanvasSize = UDim2.new(0,0,0,ScrollSize); 
	
	local LastS = ScrollFrame.CanvasPosition.Y;
	
	local D = false;
	ScrollFrame.Changed:connect(function()
		if D then return; end;
		
		if ScrollFrame.CanvasPosition.Y > LastS then --and (ScrollFrame.CanvasPosition.Y-LastS)>3 then
			D = true;
			ScrollFrame.CanvasPosition = Vector2.new(0,ScrollFrame.CanvasPosition.Y + 20);
			game:GetService("RunService").RenderStepped:wait();
			D = false;
		end
		
		LastS = ScrollFrame.CanvasPosition.Y;
	end)
	
	SelectFunctions[DataName] = {};	
	
	--[[
	
	Container:ClearAllChildren();
	--print(ScrollSize);]]
	
	local iLast = 0;
	local function CreateFrame(Index,ItemTable)
		local Row = math.floor(i/AxisLength); local Column = i%AxisLength;
		local NewFrame = GridObjectFrame:Clone();
		local FrameContainer = NewFrame.Container;
		local ItemID = (ItemTable.ItemData.ItemType and ItemTable.ItemData.Name) or ItemTable.ItemID; local ItemData = ItemTable.ItemData.ItemData or ItemTable.ItemData;
		NewFrame.Parent = Container;
		NewFrame.Size = UDim2.new(Size,0,Size,0);
		NewFrame.Position = UDim2.new(NewFrame.Size.X.Scale*Column,0,0,NewFrame.AbsoluteSize.Y*Row);
		NewFrame.Name = "Slot"..i;
		--for i,v in pairs(ItemData) do print(i,v); end;
		FrameContainer.Icon.Image = GetImage(ItemData.Image);
		FrameContainer.ItemName.Text = ItemData.Name or ItemData.ItemName;
		InfoFrame.Icon.Type.Text = (ItemTable.Type) or ItemData.Type or (ItemData.ItemName and ItemData.Rarity) or "/e " .. ItemData.Command;
		SelectFunctions[DataName]["Slot"..i] = {};
		local EliteLocked = false;
		if ItemTable.Type == "Weapon Crate" then
			local ReleaseTime = ItemData.Released;
			if os.time()-ReleaseTime < 86400 then
				EliteLocked = true;
			end
		end;
		
		FrameContainer.CoinIcon.Visible = (ItemData.Price~=nil and not ItemData.Gems);
		FrameContainer.GemsIcon.Visible = (ItemData.Price~=nil and ItemData.Gems);	
		--[[if DataName == "Featured" then
			print(ItemID,ItemTable.ItemData.ItemType,CheckForItem(ItemID, ItemTable.ItemData.ItemType or DataName));
		end;]]
		if ItemData.Price and not CheckForItem(ItemID, ItemTable.ItemData.ItemType or DataName) then
			FrameContainer.CoinIcon.Image = (Index == "ItemPack" and "rbxasset://textures/ui/RobuxIcon.png") or "https://www.roblox.com/asset/?id=197012173";
			FrameContainer.Price.TextColor3 = (Index == "ItemPack" and Color3.new( 0, 150 /255, 50 /255 )) or Color3.new(1,1,1);
			if ItemData.Price == "Elite" or EliteLocked then
				FrameContainer.Price.Visible = false;
				FrameContainer.CoinIcon.Visible = false;
				FrameContainer.GemsIcon.Visible = false;
				FrameContainer.Elite.Visible = true;
			elseif tonumber(ItemData.Price) and ItemData.Price > 0 then
				FrameContainer.Price.Text = ItemData.Price;
			else
				FrameContainer.Price.Text = "";
				FrameContainer.GemsIcon.Visible = false;
				FrameContainer.CoinIcon.Visible = false;
			end;
		else
			FrameContainer.Price.Visible = false;
			FrameContainer.CoinIcon.Visible = false;
			FrameContainer.GemsIcon.Visible = false;
			FrameContainer.Owned.Visible = CheckForItem(ItemID,ItemTable.ItemData.ItemType or DataName)
		end;
				
		local CanBuy = not CheckForItem(ItemID,(ItemTable.ItemData.ItemData and ItemTable.ItemData.ItemType) or DataName);
	
		SelectFunctions[DataName]["Slot"..i].Select = function()
			InfoFrame.Title.Text = ItemData.Name or ItemData.ItemName;
			InfoFrame.Icon.Image = GetImage(ItemData.Image);
			InfoFrame.Icon.Type.Text = (ItemData.Type) or (ItemTable.Type) or (ItemData.ItemName and ItemData.Rarity) or "/e " .. ItemData.Command;
			InfoFrame.Buy.Visible = (not ( CheckForItem(ItemID,ItemTable.ItemData.ItemType or DataName) ) );
			
			if ItemData.Description then
				InfoFrame.Icon.Description.Text = ItemData.Description;
			else
				InfoFrame.Icon.Description.Text = "";
			end;
		end;
		
		FrameContainer.Button.SelectionGained:connect(function()
			InfoFrame.Title.Text = ItemData.Name or ItemData.ItemName;
			InfoFrame.Icon.Image = GetImage(ItemData.Image);
			InfoFrame.Icon.Type.Text = (ItemData.Type) or (ItemTable.Type) or (ItemData.ItemName and ItemData.Rarity) or "/e " .. ItemData.Command;
			InfoFrame.Buy.Visible = (not ( CheckForItem(ItemID,ItemTable.ItemData.ItemType or DataName) ) );
			InfoFrame.Buy.ButtonIcon.Title.Text = ((ItemTable.Type=="Crate" or ItemTable.Type=="Bundle") and "View") or "Buy";
			InfoFrame.Icon.CurrencyIcon.Image = "";
			if ItemData.Description then
				InfoFrame.Icon.Description.Text = ItemData.Description;
			else
				InfoFrame.Icon.Description.Text = "";
			end;
		end)
				
		if (DataName == "Weapons" or (DataName=="Pets" and ItemTable.Type=="Crate")) and Index ~= "ItemPack" then
			FrameContainer.Button.MouseButton1Click:connect(function()
				if not _G.Tweening then
					local IsBundle = (DataName == "Weapons" and ItemTable.Type~="Crate");
					local IsCrate = (ItemTable.Type=="Crate");	
					local Price;
					if IsBundle then
						local TotalPrice = 0;
						for _,Table in pairs(ItemData.Contents) do
							TotalPrice = TotalPrice + Table.Price;
						end
						Price = math.floor(TotalPrice*0.85);
						ViewContentsInfo.OldPrice.Text = TotalPrice;
						ViewContentsInfo.OldPrice.Visible = true;
					else
						Price = ItemData.Price;
						ViewContentsInfo.OldPrice.Visible = false;
					end;
					
					ViewContentsInfo.Buy.ButtonIcon.Image = ItemTable.Type == "Bundle" and "rbxasset://textures/ui/Settings/Help/YButtonDark@2x.png"
					or "rbxasset://textures/ui/Settings/Help/AButtonDark@2x.png"
					ViewContentsInfo.Buy.ButtonIcon.Title.Text = "Buy";
					
					local BuyWait = false;
					Bind("BuyCrateBundle",(ItemTable.Type == "Bundle" and Enum.KeyCode.ButtonY) or Enum.KeyCode.ButtonA,function()
						local EliteBuy = (EliteLocked==true and HasElite==true) or (EliteLocked==false);
						if _G.PlayerData.Credits >= Price and not BuyWait then
							BuyWait = true;
							_G.PlayerData.Credits = _G.PlayerData.Credits - Price;
							
							if ItemTable.Type == "Bundle" then
								script.Parent.Ching:Play();
								for _,Table in pairs(ItemData.Contents) do
									local OwnedWeapons = _G.PlayerData.Weapons.Owned;
									local ID = Table.ItemName;
									_G.PlayerData.Weapons.Owned[ID] = (OwnedWeapons[ID] and OwnedWeapons[ID]+1) or 1;
								end
								game.ReplicatedStorage.BuyBundle:FireServer(ItemID);
							else
								if EliteBuy then
									--ShopFrame.Visible = false;
									_G.Process("Unboxing");
	
	
									Main[DataName]:TweenPosition(
										UDim2.new(0,0,0,0),
										Direction,Style,Time
									);
									ViewContents:TweenPosition(
										UDim2.new(1,0,0,0),
										Direction,Style,Time
									);
									game:GetService("GuiService").SelectedObject = FrameContainer.Button;
									ViewContentsInfo.OldPrice.Visible = false;
									ViewContentsInfo.CoinIcon.Visible = false;
									ViewContentsInfo.Price.Visible = false;
									ViewContentsInfo.Buy.ButtonIcon.Image = "rbxasset://textures/ui/Settings/Help/AButtonDark@2x.png"
									ViewContentsInfo.Buy.ButtonIcon.Title.Text = "View";
									Unbind("ViewBack");Unbind("NoRight");Unbind("NoLeft");Unbind("BuyCrateBundle");	
									
									_G.ResetDock();
									GameGUI.Dock.Visible = false;								
									
									
									local StartTime = time();
									local OpenedItem = Remotes.Shop.OpenCrate:InvokeServer(ItemID);
									wait( 0.75-(time()-StartTime));
									--InventoryFrame.Overlay.Visible = false;
									if OpenedItem then
										OpenCrate(ItemID,OpenedItem);
									end;
								else
									ShopFrame.Visible = false;
									GameGUI.GetElite.Visible = true;
								end;
							end;
							game.ReplicatedStorage.UpdateDataClient:Fire();
							wait(1);
							BuyWait = false;
						else
							_G.GetCredits();
						end;
					end);
					ViewContentsInfo.Price.Text = Price;
					ViewContentsInfo.Icon.Image = GetImage(ItemData.Image);
					ViewContentsInfo.Title.Text = ItemData.Name;
					ViewContentsInfo.Price.Visible = true;
					ViewContentsInfo.CoinIcon.Visible = true;
					
					ViewContentsItems:ClearAllChildren();
					
					local Index = 1;
					for _,Item in pairs(ItemData.Contents) do
						
						local MinimumRarity = false;
						if ItemData.Chances then
							MinimumRarity = ItemData.MinimumRarity;						
						end
						
						local Size = script.Content.Size.Y.Scale;
						local Row = math.floor( (Index-1) / (1/Size) ); local Column = (Index-1)%(1/Size);
						local ItemData = Items[Item] or Items[Item.ItemName] or Pets[Item] or Pets[Item.ItemName];
						
						if (not MinimumRarity) or (ItemData.Rarity == MinimumRarity) then
							local ContentFrame = script.Content:Clone();
							ContentFrame.Name = "Slot"..Index;
							local ContentFrameContainer = ContentFrame.Container;
							ContentFrameContainer.Icon.Image = GetImage(ItemData.Image);
							ContentFrameContainer.ItemName.Text = ItemData.ItemName or ItemData.Name;
							ContentFrameContainer.ItemName.TextColor3 = RarityColors[ItemData.Rarity];
							ContentFrame.Parent = ViewContentsItems;
							ContentFrame.Position = UDim2.new(ContentFrame.Size.X.Scale*Column,0,0,ContentFrame.AbsoluteSize.Y*Row)
							ContentFrameContainer.Button.Selectable = ItemTable.Type == "Bundle";
							if ItemTable.Type == "Bundle" then
								---ContentFrameContainer.MouseEnter:connect(function() ContentFrameContainer.Buy.Visible = true; end)
								--ContentFrameContainer.MouseLeave:connect(function() ContentFrameContainer.Buy.Visible = false; end)
								ContentFrameContainer.Buy.MouseButton1Click:connect(function()
									if _G.PlayerData.Credits >= Item.Price then
										script.Parent.Ching:Play();
										ContentFrameContainer.Buy.Visible = false;
	
										local OwnedWeapons = _G.PlayerData.Weapons.Owned;
										_G.PlayerData.Credits = _G.PlayerData.Credits - Item.Price;
										_G.PlayerData.Weapons.Owned[Item.ItemName] = (OwnedWeapons[Item.ItemName] and OwnedWeapons[Item.ItemName]+1) or 1;
	
										game.ReplicatedStorage.UpdateDataClient:Fire();
										game.ReplicatedStorage.Buy:FireServer(Item.ItemName,"Weapons");
									else
										_G.GetCredits();
									end;
								end)
								ContentFrameContainer.Price.Text = Item.Price;
								ContentFrameContainer.Price.Visible = true;
								ContentFrameContainer.CoinIcon.Visible = true;
							end
							Index = Index + 1;
						end;
						
					end
					
					game:GetService("GuiService").SelectedObject = (ItemTable.Type == "Bundle" and ViewContentsItems.Slot1.Container.Button) or nil;
					
					_G.CurrentFrame = "ViewContents";
					_G.Tweening = true;
					
					Bind("NoRight",Enum.KeyCode.ButtonR1,function()end);
					Bind("NoLeft",Enum.KeyCode.ButtonL1,function()end);
					Bind("ViewBack",Enum.KeyCode.ButtonB,function()end);
					
					ViewContents.Position = UDim2.new(1,0,0,0)
					Main[DataName]:TweenPosition(
						UDim2.new(-1,0,0,0),
						Direction,Style,Time
					);
					ViewContents:TweenPosition(
						UDim2.new(0,0,0,0),
						Direction,Style,Time
					)
	
					wait(Time);
					Bind("ViewBack",Enum.KeyCode.ButtonB,function()
						Main[DataName]:TweenPosition(
							UDim2.new(0,0,0,0),
							Direction,Style,Time
						);
						
						ViewContents:TweenPosition(
							UDim2.new(1,0,0,0),
							Direction,Style,Time
						);
						game:GetService("GuiService").SelectedObject = FrameContainer.Button;
						ViewContentsInfo.OldPrice.Visible = false;
						ViewContentsInfo.CoinIcon.Visible = false;
						ViewContentsInfo.Price.Visible = false;
						ViewContentsInfo.Buy.ButtonIcon.Image = "rbxasset://textures/ui/Settings/Help/AButtonDark@2x.png"
						ViewContentsInfo.Buy.ButtonIcon.Title.Text = "View";
						Unbind("ViewBack");Unbind("NoRight");Unbind("NoLeft");Unbind("BuyCrateBundle");
					end);
					
					_G.Tweening = false;
				end;
			end);
		else
			
			FrameContainer.Button.MouseButton1Click:connect(function()
				if ItemData.Price == "Elite" then
					game.ReplicatedStorage.GetElite:FireServer();
				elseif ItemTable.ItemData.PassID then
					game.ReplicatedStorage.GetPack:FireServer(ItemTable.ItemData.PassID);
				else
					local Currency = (ItemData.Gems and "Gems") or "Credits";
					local Amount = _G.PlayerData[Currency];
					if Amount >= ItemData.Price and CanBuy then
						CanBuy = false;
						script.Parent.Ching:Play();
						FrameContainer.Price.Visible = false;
						FrameContainer.CoinIcon.Visible = false;
						FrameContainer.GemsIcon.Visible = false;
						FrameContainer.Owned.Visible = true;
						table.insert(_G.PlayerData[ItemTable.ItemData.ItemType or DataName].Owned,ItemID);
						FrameContainer.Buy.Visible = false;
						_G.PlayerData[Currency] = _G.PlayerData[Currency] - ItemData.Price;
						game.ReplicatedStorage.UpdateDataClient:Fire();
						game.ReplicatedStorage.Buy:FireServer(ItemID,ItemTable.ItemData.ItemType or DataName);
					elseif CanBuy then
						--_G.GetCredits();
					end;
				end;
			end)

		end;
		
		i = i + 1;
	end
	
	local ItemPackIcon = "https://www.roblox.com/asset/?id=410316704";
	
	if DataName ~= "Weapons" then
		for Index,Value in pairs(Data) do
			if Value.ItemData.Price ~= "NotForSale" then
				CreateFrame(Index,Value);
			end
		end;
	else
		--CreateFrame("ItemPack",{ItemID="";ItemData={ Price=(_G.ShowItemPack and 899) or 1299; Image=ItemPackIcon; Name="Futuristic"; Type="Item Pack";  };});
		for Index,Value in pairs(Data) do
			if Value.ItemData.Type ~= "Bundle" then
				CreateFrame(Index,Value);
			end;
		end
	end;

	for Index = 0,i-1 do
		--local Index = i - 1;
		local Slot = Container["Slot"..Index];
		local Under = Container:FindFirstChild("Slot" .. Index+AxisLength+1 );
		if Under == nil then
			local Column = Index%AxisLength;
			local StartOfLastRow = Index+(AxisLength-Column);
			local LastFrame;
			if StartOfLastRow <= #Data then
				for e = StartOfLastRow,#Data do
					LastFrame = Container:FindFirstChild("Slot"..e-1);
				end
				if LastFrame then
					Slot.Container.Button.NextSelectionDown = LastFrame.Container.Button;
				end
			end;
		end
	end

end

if _G.UnfinishedItem ~= nil then
	_G.NewItem(_G.UnfinishedItem,"You unboxed...",GameGUI.Inventory);
end



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

function UpdateCash()
	local Credits = _G.PlayerData.Credits;
	local Gems = _G.PlayerData.Gems;
	--MainGUI.Inventory.Equipped.CreditsLabel.Text = comma_value(Credits);
	ShopFrame.Cash.Amount.Text = comma_value(Credits);
	ShopFrame.Gems.Amount.Text = comma_value(Gems);
end

game.ReplicatedStorage.UpdateDataClient.Event:connect(UpdateCash);
game.ReplicatedStorage.UpdateData.OnClientEvent:connect(function(DataName) wait(); UpdateCash(); end)
UpdateCash();


local Coins = 0;
local Elite = game.ReplicatedStorage.AmElite:InvokeServer();
game.ReplicatedStorage.GetCoin.OnClientEvent:connect(function()
	local MaxCoins = (Elite and 15) or 10;
	if Coins < MaxCoins then
		Coins = Coins + 1;
	end
	if Coins >= MaxCoins then
		GameGUI.CashBag.Image = "http://www.roblox.com/asset/?id=197073328";
		GameGUI.CashBag.Full.Visible = true;
		if not Elite then GameGUI.CashBag.Elite.Visible = true; end;
	end	
	GameGUI.CashBag.Coins.Text = Coins;
end)


local CurrencyGrid = {
	
	{	Amount = "50";		Robux="50R";		Image="https://www.roblox.com/asset/?id=414299552";	Type = "Gems";	Color=Color3.new(38/255, 170/255, 150/255);	};
	{	Amount = "250";		Robux="250R";		Image="https://www.roblox.com/asset/?id=414314810";	Type = "Gems";	Color=Color3.new(38/255, 170/255, 150/255);	};
	{	Amount = "700";		Robux="625R";		Image="https://www.roblox.com/asset/?id=414327203";	Type = "Gems";	Color=Color3.new(38/255, 170/255, 150/255);	};
	{	Amount = "1400";	Robux="1000R";		Image="https://www.roblox.com/asset/?id=414526680";	Type = "Gems";	Color=Color3.new(38/255, 170/255, 150/255);	};--Color=Color3.new(50/255, 156/255, 212/255);	};
	{	Amount = "3000";	Robux="2000R";		Image="https://www.roblox.com/asset/?id=414559278";	Type = "Gems";	Color=Color3.new(38/255, 170/255, 150/255);	};--Color=Color3.new(50/255, 156/255, 212/255);	};
	{	Amount = "8000";	Robux="5000R";		Image="https://www.roblox.com/asset/?id=414571160";	Type = "Gems";	Color=Color3.new(38/255, 170/255, 150/255);	};--Color=Color3.new(36/255, 102/255, 173/255);	};
	
	{	Amount = "50";		Robux="25R";		Image="http://www.roblox.com/asset/?id=308370179";	Type = "Coins";	Color=Color3.new(189/255, 148/255, 0/255);	};
	{	Amount = "100";		Robux="50R";		Image="http://www.roblox.com/asset/?id=308376244";	Type = "Coins";	Color=Color3.new(189/255, 148/255, 0/255);	};
	{	Amount = "200";		Robux="90R";		Image="http://www.roblox.com/asset/?id=308387128";	Type = "Coins";	Color=Color3.new(189/255, 148/255, 0/255);	};
	{	Amount = "500";		Robux="220R";		Image="http://www.roblox.com/asset/?id=308403841";	Type = "Coins";	Color=Color3.new(189/255, 148/255, 0/255);	};--Color=Color3.new(31/255,  143/255, 0/255);	};
	{	Amount = "1500";	Robux="650R";		Image="http://www.roblox.com/asset/?id=308417339";	Type = "Coins";	Color=Color3.new(189/255, 148/255, 0/255);	};--Color=Color3.new(31/255,  143/255, 0/255);	};
	{	Amount = "3500";	Robux="1450R";		Image="http://www.roblox.com/asset/?id=308454315";	Type = "Coins";	Color=Color3.new(189/255, 148/255, 0/255);	};--Color=Color3.new(128/255, 47/255,  208/255);};
};

local function UpdateCurrency()
	local ScrollFrame = ShopFrame.Main.Currency.Items.ScrollFrame;
	local Container = ScrollFrame.Container;
	local InfoFrame = ShopFrame.Info;
	local Size = GridObjectFrame.Size.Y.Scale;
	local AxisLength = math.floor(1/Size)
	local MaxRow = math.floor( (#CurrencyGrid) / AxisLength);
	local AbsoluteSize1;
	local AbsoluteSize2;
	local GetSizeFrame = GridObjectFrame:Clone(); 
	Container.Size = UDim2.new(1,0,1,0);
	GetSizeFrame.Parent = Container;
	AbsoluteSize1 = GetSizeFrame.AbsoluteSize.Y;
	Container.Size = UDim2.new(1,-ScrollFrame.ScrollBarThickness-1,1,0);
	AbsoluteSize2 = GetSizeFrame.AbsoluteSize.Y;
	GetSizeFrame:Destroy();
	local ScrollSize = ((MaxRow+1)*AbsoluteSize1)-1;
	local ShowScroll = (ScrollSize > ScrollFrame.AbsoluteSize.Y);
	if ShowScroll then 
		ScrollSize = (MaxRow+1)*AbsoluteSize2;
		--ShowScroll = (ScrollSize >= ScrollFrame.AbsoluteSize.Y);
	end
	Container.Size = (ShowScroll and UDim2.new(1,-ScrollFrame.ScrollBarThickness-1,1,0)) or UDim2.new(1,0,1,0);
	ScrollFrame.CanvasSize = UDim2.new(0,0,0,ScrollSize)
		
		
	for i,Data in pairs(CurrencyGrid) do
		local Row = math.floor( (i-1)/AxisLength); local Column = (i-1) %AxisLength;
		local NewFrame = script.CurrencyItem:Clone();
		local FrameContainer = NewFrame.Container;
		NewFrame.Parent = Container;
		NewFrame.Size = UDim2.new(Size,0,Size,0);
		NewFrame.Position = UDim2.new(NewFrame.Size.X.Scale*Column,0,0,NewFrame.AbsoluteSize.Y*Row);
		
		FrameContainer.Amount.Text = Data.Amount;
		FrameContainer.Robux.Text = Data.Robux;
		FrameContainer.Icon.Image = Data.Image;
		FrameContainer.BG.ImageColor3 = Data.Color;
		
		FrameContainer.Button.MouseButton1Click:connect(function()
			game.ReplicatedStorage.PurchaseProduct:FireServer(Data.Amount,Data.Type);
		end)
		
		FrameContainer.Button.SelectionGained:connect(function()
			InfoFrame.Title.Text = "+"..Data.Amount;
			InfoFrame.Icon.Type.Text = Data.Robux;
			InfoFrame.Buy.Visible = true;
			InfoFrame.Icon.Image = "";
			InfoFrame.Icon.CurrencyIcon.Image = Data.Image;
			InfoFrame.Icon.Description.Text = "";
		end)
		
		NewFrame.Name = "Slot"..i-1;
	end
end;
UpdateCurrency()



--[[
local function UpdateFeatured()

	local ScrollFrame = ShopFrame.Main.Featured.Items.ScrollFrame;
	local Container = ScrollFrame.Container;
	
	local Size = GridObjectFrame.Size.Y.Scale;
	local AxisLength = math.floor(1/Size)
	local MaxRow = math.floor( (#CurrencyGrid) / AxisLength);
	local AbsoluteSize1;
	local AbsoluteSize2;
	local GetSizeFrame = GridObjectFrame:Clone(); 
	Container.Size = UDim2.new(1,0,1,0);
	GetSizeFrame.Parent = Container;
	AbsoluteSize1 = GetSizeFrame.AbsoluteSize.Y;
	Container.Size = UDim2.new(1,-ScrollFrame.ScrollBarThickness-1,1,0);
	AbsoluteSize2 = GetSizeFrame.AbsoluteSize.Y;
	GetSizeFrame:Destroy();
	local ScrollSize = ((MaxRow+1)*AbsoluteSize1)-1;
	local ShowScroll = (ScrollSize > ScrollFrame.AbsoluteSize.Y);
	if ShowScroll then 
		ScrollSize = (MaxRow+1)*AbsoluteSize2;
		--ShowScroll = (ScrollSize >= ScrollFrame.AbsoluteSize.Y);
	end
	Container.Size = (ShowScroll and UDim2.new(1,-ScrollFrame.ScrollBarThickness-1,1,0)) or UDim2.new(1,0,1,0);
	ScrollFrame.CanvasSize = UDim2.new(0,0,0,ScrollSize)
		
		
	for i,Data in pairs(FeaturedItems) do
		local Row = math.floor( (i-1)/AxisLength); local Column = (i-1) %AxisLength;
		local NewFrame = script.Item:Clone();
		local FrameContainer = NewFrame.Container;
		NewFrame.Parent = Container;
		NewFrame.Size = UDim2.new(Size,0,Size,0);
		NewFrame.Position = UDim2.new(NewFrame.Size.X.Scale*Column,0,0,NewFrame.AbsoluteSize.Y*Row);
		
		FrameContainer.Amount.Text = Data.Amount;
		FrameContainer.Robux.Text = Data.Robux;
		FrameContainer.Icon.Image = Data.Image;
		FrameContainer.BG.ImageColor3 = Data.Color;
		
		NewFrame.Name = "Slot"..i-1;
	end

end
UpdateFeatured();]]

--[[while true do
	wait();
	print("Object: " .. tostring(game:GetService("GuiService").SelectedObject) );
end]]

