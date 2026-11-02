-- mob
local GameGUI = script.Parent.Parent;
local InventoryFrame = GameGUI.Lobby.Screens.Inventory;
local Navigation = InventoryFrame.Nav;
--local CodeFrame = Navigation.Codes;
local Main = InventoryFrame.Main;
local CodeFrame = Navigation.Main.Codes
local Remote = game.ReplicatedStorage;
local Remotes = Remote.Remotes;

--local ActionsFrame = Main.Weapons.Actions;
--local CraftingFrame = ActionsFrame.ActionContainer.Craft;
--local RecyclingFrame = ActionsFrame.ActionContainer.Recycle;
--local ProcessingFrame = GameGUI.Processing;
local Remote = game.ReplicatedStorage;
local Remotes = Remote.Remotes;
local AssetURL = "http://www.roblox.com/Thumbs/Asset.ashx?format=png&width=250&height=250&assetId=";
local HasRadio,CanUseRadio = game.ReplicatedStorage.HasRadio:InvokeServer();

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

local Update;

local Database = {
	
	Weapons = Remote.GetSyncData:InvokeServer("Item");
	Effects = Remote.GetSyncData:InvokeServer("Effects");
	Perks = Remote.GetSyncData:InvokeServer("Perks");
	Emotes = Remote.GetSyncData:InvokeServer("Emotes");
	Radios = Remote.GetSyncData:InvokeServer("Radios");
	Toys = Remote.GetSyncData:InvokeServer("Toys");
	Pets = Remote.GetSyncData:InvokeServer("Pets");
	
	Recipes = Remote.GetSyncData:InvokeServer("Recipe");
	Codes = Remote.GetSyncData:InvokeServer("Codes");
	Recyclable = Remote.GetSyncData:InvokeServer("Recyclable");
	SlotInfo = Remote.GetSyncData:InvokeServer("SlotInfo");
	Outfits =  Remote.GetSyncData:InvokeServer("Outfits");
};
local RarityColors = Remote.GetSyncData:InvokeServer("Rarity");
local RarityOrder = {Classic=1;Common=2;Uncommon=3;Rare=4;Legendary=5;Godly=6;Custom=10;Mythic=6.6;Dream=6.8;Victim=7;Giveaways=8;Christmas=1.5;Halloween=1.6;Ancient=6.5;Clown=10;Bussiness=12};

local MyStuff = {
	Weapons = nil;
	Effects = nil;
	Perks = nil;
	Emotes = nil;
	Radios = nil;
	Pets = nil;
	Outfits = nil;
};
local Stuff = {"Weapons","Emotes","Effects","Perks","Radios","Pets","Outfits"};--,"Pets"};
local CurrentAction = "Equip";

local CraftingTable = {
	{ItemID=nil;Amount=0;};
	{ItemID=nil;Amount=0;};
	{ItemID=nil;Amount=0;};
	{ItemID=nil;Amount=0;};
};

local RecyclingTable = {};

local function CopyTable(original)
    local copy = {}
    for k, v in pairs(original) do
        -- as before, but if we find a table, make sure we copy that too
        if type(v) == 'table' then
            v = CopyTable(v)
        end
        copy[k] = v
    end
    return copy
end

local function CreateWeaponFrame(Frame,ItemName,Amount,Type)
	local ImageFrame = ((Frame:IsA("ImageLabel") or Frame:IsA("ImageButton")) and Frame) or Frame.Detail.Icon;
	if ItemName == nil then
		ImageFrame.Image = "";
		Frame.ItemName.Text = "";
		if Frame:FindFirstChild("Amount") then
			Frame.Amount.Text = "";
		end
	else
		local ItemData = Database[(Type or "Weapons")][ItemName];
		ImageFrame.Image = GetImage(ItemData.Image);
		Frame.Item.ItemName.Text = ItemData.ItemName or ItemData.Name;
		Frame.Item.BackgroundColor3 = (ItemData.Rarity and RarityColors[ItemData.Rarity]) or Color3.new(1,1,1);
		Frame.Parent.Starburst.ImageColor3 = (ItemData.Rarity and RarityColors[ItemData.Rarity]) or Color3.new(1,1,1);
		if ItemData.Rarity == "Common" then
			Frame.Item.BackgroundColor3 = Color3.new(0.372549, 0.372549, 0.372549);
			Frame.Parent.Starburst.ImageColor3 = Color3.new(0.372549, 0.372549, 0.372549);
			if tonumber(Amount) and Frame:FindFirstChild("Amount") then
				Frame.Amount.Text = "x" .. Amount;
			end
		end;
	end;
end;



local function Redeem()
	for Code,CodeTable in pairs(Database.Codes) do
		local Match = (CodeFrame.CodeBox.Text==Code);
		if Match then
			local OwnedWeapons = _G.PlayerData.Weapons.Owned;
			local OwnedCodes = _G.PlayerData.RedeemedCodes;
			if OwnedCodes[Code] then
				CodeFrame.CodeBox.Text = "Redeemed.";
				return;
			end
			if CodeTable["Type"] ~= "Credits" then
				if os.time() < CodeTable.Expiry then
					_G.PlayerData.Weapons.Owned[CodeTable.Prize] = (OwnedWeapons[CodeTable.Prize] and OwnedWeapons[CodeTable.Prize]+1) or 1;
					game.ReplicatedStorage.UpdateDataClient:Fire();
					_G.NewItem(CodeTable.Prize,"You Got...",InventoryFrame);
					game.ReplicatedStorage.RedeemCode:FireServer(Code);
				else
					CodeFrame.CodeBox.Text = "Code Expired :(";
				end;
			else
				if os.time() < CodeTable.Expiry then
					game.ReplicatedStorage.RedeemCode:FireServer(Code);
					game.ReplicatedStorage.UpdateDataClient:Fire()
				else
					CodeFrame.CodeBox.Text = "Code Expired :(";
				end
			end
			return;

		elseif ((string.len(CodeFrame.CodeBox.Text)==7 and string.sub(CodeFrame.CodeBox.Text,4,4) == "-") and Enum.ButtonStyle.RobloxRoundDefaultButton) then

			local Code = CodeFrame.CodeBox.Text;
			CodeFrame.CodeBox.Text = "Redeeming...";
			CodeFrame.Redeem.Style = Enum.ButtonStyle.RobloxRoundButton;


			local Text,Items = game.ReplicatedStorage.RedeemShirtCode:InvokeServer(Code);
			CodeFrame.CodeBox.Text = Text;

			if Items then

				for _,Item in pairs(Items) do

					if Item.Type == "Weapons" or Item.Type == "Item" or Item.Type == "Materials" or Item.Type == "Pets" or Item.Type == "Effects" then
						local OwnedType = _G.PlayerData[Item.Type].Owned;
						_G.PlayerData[Item.Type].Owned[Item.ID] = (OwnedType[Item.ID] and OwnedType[Item.ID]+1) or 1;
						_G.NewItem(Item.ID,"You Got...",InventoryFrame,Item.Type);
					else
						--table.insert(_G.PlayerData[Item.Type].Owned,Item.ID);
					end;
				end;
				game.ReplicatedStorage.UpdateDataClient:Fire();
			end;

		end;
	end
end


local function SortData()
	for _,DataName in pairs(Stuff) do
		--local Table = Remote.GetData:InvokeServer(DataName);
		local Table = CopyTable(_G.PlayerData[DataName]);
		if Table ~= nil then
			table.sort(Table.Owned,function(a,b)
				return a < b; -- Attempt to compare bool with table
			end)
			MyStuff[DataName] = Table;
		end;
	end
	pcall(function() 
		--local Data = Remote.GetData:InvokeServer("Weapons");
		local Data = CopyTable(_G.PlayerData.Weapons);
		local WeaponsTable = {};
		for ItemID,Amount in pairs(Data.Owned) do
			table.insert(WeaponsTable,{
				ItemID = ItemID;
				Amount = Amount;
			});
		end
		table.sort(WeaponsTable,function(a,b)
			-- if A is less than B, return true;
			local ID = {a.ItemID,b.ItemID};
			local Amount = {a.Amount,b.Amount};
			local Data = {Database.Weapons[ID[1]],Database.Weapons[ID[2]]};
			local Rarity = {RarityOrder[Data[1].Rarity],RarityOrder[Data[2].Rarity]};
			local DefaultKnife = 1;
	
			if ID[1] == "DefaultKnife" then
				return true;
			elseif ID[2] == "DefaultKnife" then 
				return false;
			elseif ID[1] == "DefaultGun" then
				return true;
			elseif ID[2] == "DefaultGun" then
				return false;
			else
				if Rarity[1] ~= Rarity[2] then
					return Rarity[1] > Rarity[2];
				elseif Amount[1] ~= Amount[2] then
					return (Amount[1] > Amount[2]);
				else
					return Data[1].ItemName < Data[2].ItemName;
				end;
			end;
		end)
		Data.Owned = WeaponsTable;
		MyStuff.Weapons = Data;
	end);
end;

local searchBar = Main.Weapons.TitleBar.Container.Search.Container.SearchText
local items = Main.Weapons.Items.Container.Current.Container

local scrollingframe = items
local searchbar = Main.Weapons.TitleBar.Container.Search.Container.SearchText
local InventoryFrame = items
function UpdateInputOfSearchText()
	local InputText=string.upper(searchbar.Text)
	for _,button in pairs(scrollingframe:GetChildren())do
		if button:IsA("Frame")then
			if InputText==""or string.find(string.upper(button.Name),InputText)~=nil then
				button.Visible=true
				InventoryFrame.Parent.CanvasPosition = Vector2.new(0, 0);
			else
				button.Visible=false
				InventoryFrame.Parent.CanvasPosition = Vector2.new(0, 0);
			end
		end
	end
end
searchbar.Changed:Connect(UpdateInputOfSearchText)



local ResultItem;
local function UpdateCrafting()
	--[[ResultItem = nil;
	local ResultButton = CraftingFrame.Result;
	for Index,Table in pairs(CraftingTable) do
		local Frame = CraftingFrame["Item"..Index];
		local ItemID = Table.ItemID;local Amount = Table.Amount;
		if ItemID ~= nil then
			local ItemData = Database.Weapons[ItemID];
			if Amount > 1 then Frame.Amount.Text = "x"..Amount; else Frame.Amount.Text = ""; end;
			Frame.Image = GetImage(ItemData.Image);
			Frame.ItemName.Text = ItemData.ItemName;
			Frame.ItemName.TextColor3 = RarityColors[ItemData.Rarity];
		else
			Frame.Image = "";
			Frame.ItemName.Text = "";
			Frame.Amount.Text = "";
		end;
	end;
	for PotentialResult,Recipe in pairs(Database.Recipes) do
		local Components = Recipe.Components;
		local Gifts = Recipe.Gifts;
		local HasCount = 0;
		local Total = 0;
		
		for _,Component in pairs(Components) do
			for _,Table in pairs(CraftingTable) do
				if Table.ItemID == Component then
					HasCount = HasCount + 1;
				end
				
			end
		end
		
		for _,Table in pairs(CraftingTable) do
			if Table.ItemID ~= nil then
				Total = Total + Table.Amount;
			end
		end
		
		if HasCount == #Components and Total == #Components then
			ResultItem = PotentialResult;
		end
		
	end
	if ResultItem then
		local ItemData = Database.Weapons[ResultItem];
		ResultButton.Image = GetImage(ItemData.Image);
		ResultButton.ItemName.Text = ItemData.ItemName;
		ResultButton.ItemName.TextColor3 = RarityColors[ItemData.Rarity];
		CraftingFrame.Confirm.Style = Enum.ButtonStyle.RobloxRoundDefaultButton;
	else
		ResultButton.Image = "";
		ResultButton.ItemName.Text = "";
		CraftingFrame.Confirm.Style = Enum.ButtonStyle.RobloxRoundButton;
	end;]]
end

local function CheckItemRecyclable(ItemID)
	local ComparedItem = RecyclingTable[1];
	local ItemData = Database.Weapons[ItemID];
	local Recyclable = false;
	for _,rID in pairs(Database.Recyclable) do
		if rID == ItemID then
			Recyclable = true;
		end
	end
	if ComparedItem and Recyclable then
		local ComparedItemData = Database.Weapons[ComparedItem];
		local RequiredType = ComparedItemData.ItemType;
		local RequiredRarity = ComparedItemData.Rarity; 
		if ItemData.Rarity == RequiredRarity and ItemData.ItemType == RequiredType then
			
			local HasAmount = 0;
			for _,Weapon in pairs(MyStuff.Weapons.Owned) do 
				if Weapon.ItemID == ItemID then 
					HasAmount = Weapon.Amount;
					break;
				end 
			end;
			for Index,rItemID in pairs(RecyclingTable) do if rItemID == ItemID then HasAmount = HasAmount - 1; end end
			
			
			
			return (HasAmount>0),"Not Enough";
		else
			return false,(ItemData.ItemType~=RequiredType and "Wrong Type") or "Wrong Rarity";
		end;
	else
		return Recyclable,"Can't Recycle";
	end;
end

local RarityIndex = {
	["Common"] = "Uncommon";
	["Uncommon"] = "Rare";
	["Rare"] = "Legendary";
};


local RecycleConnections = {};
local function UpdateRecycling()
	--[[for _,Con in pairs(RecycleConnections) do Con:disconnect() end;
	for _,Frame in pairs(RecyclingFrame:GetChildren()) do if Frame:IsA("ImageButton") then CreateWeaponFrame(Frame) end; end;
	for Index,ItemName in pairs(RecyclingTable) do
		local Frame = RecyclingFrame["Item"..Index]
		CreateWeaponFrame(Frame,ItemName);
		RecycleConnections[Index] = Frame.MouseButton1Click:connect(function()
			table.remove(RecyclingTable,Index);
			UpdateRecycling();
		end)
	end
	local Success = (#RecyclingTable >= 8);
	local Rarity = (Success and Database.Weapons[RecyclingTable[1]]--[[.Rarity) or "Common";
	local ResultRarity = RarityIndex[Rarity];
	
	RecyclingFrame.Result.QuestionMark.Visible = (Success);
	RecyclingFrame.Result.QuestionMark.TextColor3 = RarityColors[ResultRarity];
	RecyclingFrame.Result.ItemName.Text = (Success and ResultRarity) or "";
	RecyclingFrame.Result.ItemName.TextColor3 = RarityColors[ResultRarity];
	RecyclingFrame.Confirm.Style = (Success and Enum.ButtonStyle.RobloxRoundDefaultButton) or Enum.ButtonStyle.RobloxRoundButton;
	
	for _,Frame in pairs(Main.Weapons.Items.ScrollFrame.Container:GetChildren()) do
		if Frame.Name ~= "GetMore" then
			local Recylable,CheckText = CheckItemRecyclable(Frame.Name);
			Frame.Container.Cover.Text = CheckText;
			Frame.Container.Cover.Visible = (CurrentAction=="Recycle" and not Recylable);
		end;
	end]]
end


for Index,Table in pairs(CraftingTable) do
	--[[local Frame = CraftingFrame["Item"..Index];
	Frame.MouseButton1Click:connect(function()
		CraftingTable[Index].Amount = CraftingTable[Index].Amount - 1;
		if CraftingTable[Index].Amount < 1 then CraftingTable[Index].ItemID = nil; end;
		UpdateCrafting();
	end)
	Frame.MouseButton2Click:connect(function()
		local Amount = CraftingTable[Index].Amount - 10;
		Amount = (Amount>0 and Amount) or 0;
		CraftingTable[Index].Amount = Amount;
		if CraftingTable[Index].Amount < 1 then CraftingTable[Index].ItemID = nil; end;
		UpdateCrafting();
	end)]]
end

local function UpdateEquip()
	for _,StuffName in pairs(Stuff) do
		if StuffName ~= "Weapons" and MyStuff[StuffName].Equipped then
			local EquipFrame = Main[StuffName].Equipped.Container;
			for Index,ItemName in pairs(MyStuff[StuffName].Equipped) do
				local Slot = EquipFrame["Item1"];
				local ItemData = Database[StuffName][ItemName];
				local CanEquip = true;
				Slot.Container.Visible = true
				Slot.Container.Container.Icon.Image = Database[StuffName][ItemName].Image and GetImage(Database[StuffName][ItemName].Image) or game.Players:GetUserThumbnailAsync(ItemData.UserId,Enum.ThumbnailType.AvatarThumbnail,Enum.ThumbnailSize.Size352x352);
				Slot.Container.ItemName.Label.Text = Database[StuffName][ItemName].Name
				if ItemData.Rarity ~= nil then
					Slot.Container.ItemName.BackgroundColor3 = RarityColors[ItemData.Rarity];
				end
				game.ReplicatedStorage.RoleSelect.OnClientEvent:connect(function(Role)
					GameGUI.Lobby.Screens.Inventory.Main.Outfits.Text.Visible = false
					GameGUI.Lobby.Screens.Inventory.Main.Outfits.Items.Visible = false
					GameGUI.Lobby.Screens.Inventory.Main.Outfits.Equipped.Visible = false
					CanEquip = false;
				end)
				print(Index)
				print(StuffName)
				Slot.Container.Container.Button.MouseButton1Click:connect(function()
					if StuffName == "Effects" then
						print("EF")
					end
					if StuffName == "Outfits" then
						table.remove(_G.PlayerData["Outfits"].Equipped,Index);
						Slot.Container.Visible = false
						Update();
						print(Index)
						print("Outfits")
						Remotes.Inventory.Unequip:FireServer(Index,"Outfits");
						return
					end
					if Database.SlotInfo[StuffName] and Database.SlotInfo[StuffName].Unequip then
						table.remove(_G.PlayerData[StuffName].Equipped,Index);
						Slot.Container.Visible = false
						Update();
						Remotes.Inventory.Unequip:FireServer(Index,StuffName);
					end
				end)
			end;
		else
			local EquipFrame = Main.Weapons.Equipped.Container;
			for Type,Value in pairs(MyStuff.Weapons.Equipped) do
				local ItemData = Database.Weapons[Value];
				EquipFrame[Type].Container.Container.Icon.Image = GetImage(ItemData.Image);
				EquipFrame[Type].Container.ItemName.Label.Text = ItemData.ItemName;
				EquipFrame[Type].Container.ItemName.BackgroundColor3 = RarityColors[ItemData.Rarity];
				EquipFrame[Type].Container.Tags.Chroma.Visible = false;
				EquipFrame[Type].Container.Tags.Chroma.Visible = false;
				EquipFrame[Type].Container.Tags.Premium.Visible = false;
				EquipFrame[Type].Container.Tags.Christmas.Visible = false;
				EquipFrame[Type].Container.Tags.Halloween.Visible = false;
				if ItemData.Chroma ~= nil then
					EquipFrame[Type].Container.Tags.Chroma.Visible = true;
				elseif ItemData.Premium ~= nil then
					EquipFrame[Type].Container.Tags.Premium.Visible = true;
				elseif ItemData.Christmas ~= nil and ItemData.Year ~= nil then
					EquipFrame[Type].Container.Tags.Christmas.Visible = true;
					EquipFrame[Type].Container.Tags.Christmas.Year.Text = ItemData.Year
				elseif ItemData.Halloween ~= nil and ItemData.Year ~= nil then
					EquipFrame[Type].Container.Tags.Halloween.Visible = true;
					EquipFrame[Type].Container.Tags.Halloween.Year.Text = ItemData.Year
				end
				if ItemData.Rarity == "Common" then
					EquipFrame[Type].Container.ItemName.BackgroundColor3 = Color3.new(0.415686, 0.415686, 0.415686);
				end
			end
		end;
	end
end

local function Equip(Type,ItemName)
	for _,Item in pairs(MyStuff[Type].Equipped) do if Item == ItemName then return end; end;
	table.insert(MyStuff[Type].Equipped,1,ItemName);
	local EquippedAmount = #MyStuff[Type].Equipped;
	if EquippedAmount > MyStuff[Type].Slots then
		table.remove(MyStuff[Type].Equipped,EquippedAmount);
	end
	UpdateEquip();
	Remote.Equip:FireServer(ItemName,Type);
end


local function WeaponAction(ItemID,Amount,ItemData,RightClick)
	if CurrentAction == "Equip" then
		if ItemData.ItemType ~= "Misc" then
			MyStuff.Weapons.Equipped[ItemData.ItemType] = ItemID;
			UpdateEquip();
			Remote.Equip:FireServer(ItemID,"Weapons");
		end;
	end;
end

local GridFunctions = {
	Weapons = {
		Size = 0.25;
		FrameFunction = function(Frame,Index,Table)
			local ItemData = Database.Weapons[Table.ItemID];
			Frame.Icon.Image = GetImage(ItemData.Image);
			Frame.Parent.ItemName.Label.Text = ItemData.ItemName;
			Frame.Parent.ItemName.BackgroundColor3 = RarityColors[ItemData.Rarity];
			
			if ItemData.Rarity == "Common" then
				Frame.Parent.ItemName.BackgroundColor3 = Color3.new(0.415686, 0.415686, 0.415686);
			end
			if ItemData.Chroma ~= nil then
				Frame.Parent.Tags.Chroma.Visible = true;
			end
			if ItemData.Premium ~= nil then
				Frame.Parent.Tags.Premium.Visible = true;
			end
			if Table.Amount > 1 then
				Frame.Amount.Text = "x" .. Table.Amount;
			end			
			Frame.Button.MouseButton1Click:connect(function()
				WeaponAction(Table.ItemID,Table.Amount,ItemData);
			end)
			Frame.Button.MouseButton2Click:connect(function()
				WeaponAction(Table.ItemID,Table.Amount,ItemData,true);
			end)
		end
	};
	Effects = {
		FrameFunction = function(Frame,Index,EffectName)
			local ItemData = Database.Effects[EffectName];
			Frame.Icon.Image = GetImage(ItemData.Image);
			Frame.Parent.ItemName.Label.Text = ItemData.Name;
			
			if ItemData.Rarity ~= nil then
				Frame.Parent.ItemName.BackgroundColor3 = RarityColors[ItemData.Rarity];
			else
				Frame.Parent.ItemName.BackgroundColor3 = Color3.new(0.415686, 0.415686, 0.415686);
			end
			
			if ItemData.Rarity ~= nil and ItemData.Rarity == "Common" then
				Frame.Parent.ItemName.BackgroundColor3 = Color3.new(0.415686, 0.415686, 0.415686);
			end
		end;
	};
	Perks = {
		FrameFunction = function(Frame,Index,PerkName)
			local ItemData = Database.Perks[PerkName];
			Frame.Icon.Image = GetImage(ItemData.Image);
			Frame.Parent.ItemName.Label.Text = ItemData.Name;
			
			if ItemData.Rarity ~= nil then
				Frame.Parent.ItemName.BackgroundColor3 = RarityColors[ItemData.Rarity];
			else
				Frame.Parent.ItemName.BackgroundColor3 = Color3.new(0.415686, 0.415686, 0.415686);
			end

			if ItemData.Rarity ~= nil and ItemData.Rarity == "Common" then
				Frame.Parent.ItemName.BackgroundColor3 = Color3.new(0.415686, 0.415686, 0.415686);
			end
		end;
	};
	Emotes = {
		FrameFunction = function(Frame,Index,Name)
			local ItemData = Database.Emotes[Name];
			Frame.Parent.ItemName.Label.Text = ItemData.Name;
			Frame.Icon.Image = GetImage(ItemData.Image);
			
			if ItemData.Rarity ~= nil then
				Frame.Parent.ItemName.BackgroundColor3 = RarityColors[ItemData.Rarity];
			else
				Frame.Parent.ItemName.BackgroundColor3 = Color3.new(0.415686, 0.415686, 0.415686);
			end
			
			if ItemData.Rarity ~= nil and ItemData.Rarity == "Common" then
				Frame.Parent.ItemName.BackgroundColor3 = Color3.new(0.415686, 0.415686, 0.415686);
			end
		end;
	};
	Radios = {
		FrameFunction = function(Frame,Index,Name)
			local ItemData = Database.Radios[Name];
			Frame.Parent.ItemName.Label.Text = ItemData.Name;
			Frame.Icon.Image = GetImage(ItemData.Image);
			
			if ItemData.Rarity ~= nil then
				Frame.Parent.ItemName.BackgroundColor3 = RarityColors[ItemData.Rarity];
			else
				Frame.Parent.ItemName.BackgroundColor3 = Color3.new(0.415686, 0.415686, 0.415686);
			end

			if ItemData.Rarity ~= nil and ItemData.Rarity == "Common" then
				Frame.Parent.ItemName.BackgroundColor3 = Color3.new(0.415686, 0.415686, 0.415686);
			end
		end
	};
	Toys = {
		FrameFunction = function(Frame,Index,Name)
			local ItemData = Database.Toys[Name];
			Frame.Parent.ItemName.Label.Text = ItemData.Name;
			Frame.Icon.Image = GetImage(ItemData.Image);
		end
	};
	Pets = {
		FrameFunction = function(Frame,ItemID,Amount)
			local ItemData = Database.Pets[ItemID];
			if ItemData.Image ~= nil then
				Frame.Icon.Image = GetImage(ItemData.Image);
			end
			Frame.Parent.ItemName.Label.Text = ItemData.Name;
			Frame.Parent.ItemName.BackgroundColor3 = RarityColors[ItemData.Rarity];
			if Amount > 1 then
				Frame.Amount.Text = "x" .. Amount;
			end
			if ItemData.Rarity == "Common" then
				Frame.Parent.ItemName.BackgroundColor3 = Color3.new(0.415686, 0.415686, 0.415686);
			end
			if ItemData.Chroma ~= nil then
				Frame.Parent.Tags.Chroma.Visible = true;
			end
			if ItemData.Premium ~= nil then
				Frame.Parent.Tags.Premium.Visible = true;
			end
		end
	};
	
	Outfits = {
		FrameFunction = function(Frame,Index,OutfitName)
			local ItemData = Database.Outfits[OutfitName];
			Frame.Icon.Image = game.Players:GetUserThumbnailAsync(ItemData.UserId,Enum.ThumbnailType.AvatarThumbnail,Enum.ThumbnailSize.Size352x352);
			Frame.Parent.ItemName.Label.Text = ItemData.Name;
			if ItemData.Rarity == "Common" or ItemData.Rarity ~= nil then
				Frame.Parent.ItemName.BackgroundColor3 = Color3.new(0.415686, 0.415686, 0.415686);
			end
			if ItemData.Rarity ~= nil then
				Frame.Parent.ItemName.BackgroundColor3 = RarityColors[ItemData.Rarity];
			elseif ItemData.Rarity ~= nil and ItemData.Rarity == "Common" then
				Frame.Parent.ItemName.BackgroundColor3 = Color3.new(0.415686, 0.415686, 0.415686);
			end
		end;
	};
};

local function CreateGrid(Type)
	if MyStuff[Type] == nil then return end;
	if Type ~= "Weapons" then
		local i = 0;
		local ScrollFrame = Main[Type].Items.Container.Current;
		local Container = ScrollFrame.Container;
		local Size = (GridFunctions[Type] and GridFunctions[Type].Size) or 0.2;
		local FrameFunction = (GridFunctions[Type] and GridFunctions[Type].FrameFunction) or function()end;

		Container:ClearAllChildren();
		local GridLayout = script.ItemGridLayout:Clone()
		GridLayout.Parent = Container
		local function CreateFrame(Index,Value)
			if Value ~= "None" then
				local SeasonRow = nil
				local HolidaysRow = nil
				local Row = nil
			--[[if ItemData.Season then
					SeasonRow = math.floor(i/(1/Size)); local Column = i%(1/Size);
				elseif ItemData.Holidays then
					SeasonRow = math.floor(i/(1/Size)); local Column = i%(1/Size);
				else
					Row = math.floor(i/(1/Size)); local Column = i%(1/Size);
				end]]
				local NewFrame = (Value == "GetMore" and script.GetMore:Clone()) or script.Item:Clone();
				NewFrame.Parent = Container;


				if Index and Value then 
					FrameFunction(NewFrame.Container,Index,Value); 
					if Type ~= "Weapons" and Type ~= "Emotes" then
						NewFrame.Container.Button.MouseButton1Click:connect(function()
							if Type == "Pets" then
								Equip(Type,Index); 
							else
								Equip(Type,Value);
							end;
						end)
					end;
				end;

				if Value == "GetMore" then
					NewFrame.Container.Button.MouseButton1Click:connect(function()
						_G.Navigate(Type,0);
					end)
				end
				--[[if ItemData.Season then
					ScrollFrame.CanvasSize = UDim2.new(0,0,0,(SeasonRow+2)*NewFrame.AbsoluteSize.Y);
				elseif ItemData.Holidays then
					ScrollFrame.CanvasSize = UDim2.new(0,0,0,(HolidaysRow+2)*NewFrame.AbsoluteSize.Y);
				else
					ScrollFrame.CanvasSize = UDim2.new(0,0,0,(Row+2)*NewFrame.AbsoluteSize.Y);
				end]]
				i = i + 1;
			end;
		end
		for Index,Value in pairs(MyStuff[Type].Owned) do
			CreateFrame(Index,Value);
		end
	else
		local i = 0;
		for _,Frame in pairs(Main[Type].Items.Container:GetChildren()) do
			if Frame.Name == "Current" or Frame.Name == "Classic" then
				local Container = Frame.Container;
				Container:ClearAllChildren();
				local GridLayout = script.ItemGridLayout:Clone()
				GridLayout.Parent = Container
			elseif Frame.Name == "Holiday" then
				local ChristmasContainer = Frame.Container.Christmas.Container;
				ChristmasContainer:ClearAllChildren();
				local HalloweedContainer = Frame.Container.Halloween.Container;
				HalloweedContainer:ClearAllChildren();
				local XGridLayout = script.ItemGridLayout:Clone()
				XGridLayout.Parent = ChristmasContainer
				local HGridLayout = script.ItemGridLayout:Clone()
				HGridLayout.Parent = HalloweedContainer
			end
		end

		local Size = (GridFunctions[Type] and GridFunctions[Type].Size) or 0.2;
		local FrameFunction = (GridFunctions[Type] and GridFunctions[Type].FrameFunction) or function()end;



		local function CreateFrame(Index,Value)
			local ScrollFrame
			local ItemData = Database.Weapons[Value.ItemID];
			if ItemData.Season ~= nil then
				ScrollFrame = Main[Type].Items.Container.Current;
			elseif ItemData.Holidays then
				if ItemData.Christmas then
					ScrollFrame = Main[Type].Items.Container.Holiday.Container.Christmas;
				else
					ScrollFrame = Main[Type].Items.Container.Holiday.Container.Halloween;
				end
			else
				ScrollFrame = Main[Type].Items.Container.Classic;
			end

			local Container = ScrollFrame.Container;


			if Value ~= "None" then
				local SeasonRow = nil
				local HolidaysRow = nil
				local Row = nil
				if ItemData.Season then
					SeasonRow = math.floor(i/(1/Size)); local Column = i%(1/Size);
				elseif ItemData.Holidays then
					SeasonRow = math.floor(i/(1/Size)); local Column = i%(1/Size);
				else
					Row = math.floor(i/(1/Size)); local Column = i%(1/Size);
				end

				local NewFrame = (Value == "GetMore" and script.GetMore:Clone()) or script.Item:Clone();
				NewFrame.Parent = Container;

				if type(Value) == "string" then
					--NewFrame.Name = Value;
				elseif type(Value) == "table" and Value.ItemID then
					--NewFrame.Name = Value.ItemID;
				end;

				if Index and Value then 
					FrameFunction(NewFrame.Container,Index,Value); 
					if Type ~= "Weapons" and Type ~= "Emotes" then
						NewFrame.Container.Button.MouseButton1Click:connect(function()
							if Type == "Pets" then
								Equip(Type,Value.ItemID); 
							else
								Equip(Type,Value);
							end;
						end)
					end;
				end;

				if Value == "GetMore" then
					NewFrame.Container.Button.MouseButton1Click:connect(function()
						_G.Navigate(Type,0);
					end)
				end
				if ItemData.Season then
					--ScrollFrame.CanvasSize = UDim2.new(0,0,0,(SeasonRow+2)*NewFrame.AbsoluteSize.Y);
				elseif ItemData.Holidays then
					--ScrollFrame.CanvasSize = UDim2.new(0,0,0,(HolidaysRow+2)*NewFrame.AbsoluteSize.Y);
				else
					--ScrollFrame.CanvasSize = UDim2.new(0,0,0,(Row+2)*NewFrame.AbsoluteSize.Y);
				end
				i = i + 1;
			end;
		end
		for Index,Value in pairs(MyStuff[Type].Owned) do
			CreateFrame(Index,Value);
		end
	end
	
	--if Type ~= "Radios" or (Type=="Radios" and HasRadio) then
		
		if Main[Type]:FindFirstChild("BuyRadio") and HasRadio then
			Main[Type].BuyRadio.Visible = false;
		end
	
end

Update = function(CoinUpdate)
	if not CoinUpdate then
		SortData();
		for _,StuffName in pairs(Stuff) do
			CreateGrid(StuffName);
		end
		UpdateEquip();
	end;
end;
Update();
game.ReplicatedStorage.UpdateDataClient.Event:connect(Update);

--[[local Buttons = ActionsFrame:GetChildren();
for _,Button in pairs(Buttons) do
	if Button:IsA("TextButton") then Button.MouseButton1Click:connect(function() CurrentAction=Button.Name; UpdateRecycling(); end); end;
end

RecyclingFrame.Confirm.MouseButton1Click:connect(function()
	if #RecyclingTable >= 8 then
		
	
		InventoryFrame.Visible = false;
		_G.Process("Recycling");
		
		local StartTime = time();
		local Success = Remotes.Inventory.Recycle:InvokeServer(RecyclingTable);
		
		RecyclingTable = {};
		UpdateRecycling();
		
		wait( 0.75-(time()-StartTime));
		
		GameGUI.Processing.Visible = false;
		if Success then
			_G.NewItem(Success,"You Got...",InventoryFrame);
		end;
		
	end
end)

CraftingFrame.Confirm.MouseButton1Click:connect(function()
	if ResultItem then
		local Item = ResultItem;
		CraftingTable = {{ItemID=nil;Amount=0;};{ItemID=nil;Amount=0;};{ItemID=nil;Amount=0;};{ItemID=nil;Amount=0;};};
		UpdateCrafting();
		
		InventoryFrame.Visible = false;
		_G.Process("Crafting");
		
		local StartTime = time();
		local Success = Remotes.Inventory.Craft:InvokeServer(Item);
		wait( 0.75-(time()-StartTime));
		--InventoryFrame.Overlay.Visible = false;
		GameGUI.Processing.Visible = false;
		if Success then
			_G.NewItem(Item,"You Crafted...",InventoryFrame);
		end;
	end
end)

local function UpdateRecipes()
	local i = 0;
	local Size = script.Recipe.Size.Y.Offset;
	local ScrollFrame = InventoryFrame.Recipes.Container.ScrollFrame;
	local RecipeTable = {};
	for Result,Data in pairs(Database.Recipes) do
		table.insert(RecipeTable,{
			Result = Result;
			Components = Data.Components;
			Gifts = Data.Gifts;
		});
	end

	table.sort(RecipeTable,function(RecipeA,RecipeB)
		-- if A is less than B, return true;
		local ResultID = {A=RecipeA.Result,B=RecipeB.Result};
		local ItemData = {A=Database.Weapons[ResultID.A],B=Database.Weapons[ResultID.B]};
		local Rarity = {A=RarityOrder[ItemData.A.Rarity];B=RarityOrder[ItemData.B.Rarity]};
		if RecipeA.Gifts and not RecipeB.Gifts then
			return true;
		end
		if Rarity.A ~= Rarity.B then 
			return Rarity.A > Rarity.B;
		else
			return ItemData.A.ItemName < ItemData.B.ItemName;
		end;
	end)
	for _,RecipeData in pairs(RecipeTable) do
		local NewFrame = script.Recipe:Clone();
		NewFrame.Parent = ScrollFrame;
		NewFrame.Position = UDim2.new(0,0,0,Size*i);
		local Components = RecipeData.Components;
		local Last;
		for Index,Component in pairs(Components) do
			local Frame = NewFrame.Container["Item"..Index];
			CreateWeaponFrame(Frame,Component);
			Last = Index+1;
		end
		if RecipeData.Gifts then
			CreateWeaponFrame(NewFrame.Container["Item"..Last],"Gift",RecipeData.Gifts);
		end
		CreateWeaponFrame(NewFrame.Container.Result,RecipeData.Result);
		ScrollFrame.CanvasSize = UDim2.new(0,0,0,(i+1)*Size);
		i=i+1;
	end
end;
UpdateRecipes();]]

local NewItemFrame = GameGUI.NewItem;
local LastFrame;

local ItemQueue = {};

local u1 = 1
local u3 = 1

local function u8()
	if not (u1 > 1) then
		NewItemFrame.Container.Claim.Text = "Claim";
		return;
	end;
	NewItemFrame.Container.Claim.Text = "Claim (" .. u3 .. "/" .. u1 .. ")";
end;


local function ShowItem()
	local Item = ItemQueue[1];
	game.Lighting.NewItemBlur.Enabled = true
	CreateWeaponFrame(NewItemFrame.Container.NewItem,Item.ItemName,nil,Item.Type);
	NewItemFrame.Container.Title.Text = Item.TitleText;
	if Item.LFrame then
		LastFrame = Item.LFrame;
		LastFrame.Visible = false;
		u1 = 1;
		u3 = 1;
	end;
	NewItemFrame.Visible = true;
	game.Players.LocalPlayer:WaitForChild('PlayerGui'):SetTopbarTransparency(0)
end

_G.NewItem = function(ItemName,TitleText,LFrame,Type)

	table.insert(ItemQueue,
		{
			ItemName=ItemName,
			TitleText=(TitleText or "You Got..."),
			LFrame=LFrame,
			Type=(Type or "Weapons")
		}
	);

	if not NewItemFrame.Visible then
		ShowItem();
		u1 = #ItemQueue;
	else
		u1 = u1 + 1;
	end;
	u8()
end

local Lobby = script.Parent.Parent.Lobby.Screens

NewItemFrame.Container.Claim.MouseButton1Click:connect(function()
	--_G.ReturnGUI();
	local v1 = require(game.ReplicatedStorage.Modules.ItemAnimationModule)
	v1.AnimateItemIconIntoInventory(NewItemFrame.Container.NewItem.Detail.Icon,Lobby.Parent.Dock,GameGUI)
	NewItemFrame.Visible = false;
	game.Lighting.NewItemBlur.Enabled = false
	_G.UnfinishedItem = nil;
	_G.UnfinishedType = nil;
	table.remove(ItemQueue,1);
	if ItemQueue[1] ~= nil then
		ShowItem();
		u3 = u3 + 1;
		u8();
	else
		u1 = 1;
		u3 = 1;
		if LastFrame then
			LastFrame.Visible = true
		end
	end
end)

game.ReplicatedStorage.ItemGift.OnClientEvent:connect(function(Prize,Type)
	_G.NewItem(Prize,"You Got...",nil,Type);
end);

local ProcessingFrame = GameGUI.Lobby.Screens.Processing;
_G.Process = function(TitleText)
	ProcessingFrame.Title.Text = TitleText;
	spawn(function() while ProcessingFrame.Visible == true do ProcessingFrame.Container.Spinner.Rotation = ProcessingFrame.Container.Spinner.Rotation + 5; game:GetService("RunService").RenderStepped:wait(); end; end)
	spawn(function() while ProcessingFrame.Visible == true do wait(0.2); ProcessingFrame.Title.Text = ProcessingFrame.Title.Text .. ".";  end; end)
	ProcessingFrame.Visible = true;
end;

CodeFrame.CodeBox.Changed:connect(function()
	for Code,CodeTable in pairs(Database.Codes) do
		local Match = CodeFrame.CodeBox.Text==Code
		CodeFrame.Redeem.Style = (Match and Enum.ButtonStyle.RobloxRoundDefaultButton) or Enum.ButtonStyle.RobloxRoundButton;
		if Match then return end;
	end

	CodeFrame.Redeem.Style = ((string.len(CodeFrame.CodeBox.Text)==7 and string.sub(CodeFrame.CodeBox.Text,4,4) == "-") and Enum.ButtonStyle.RobloxRoundDefaultButton) or Enum.ButtonStyle.RobloxRoundButton;


end)


CodeFrame.Redeem.MouseButton1Click:connect(Redeem);
CodeFrame.CodeBox.FocusLost:connect(function(Enter) if Enter then Redeem() end; end);



--[[NewItemFrame.Claim.MouseButton1Click:connect(function()
	NewItemFrame.Visible = false;
	_G.UnfinishedItem = nil;
	table.remove(ItemQueue,1);
	if ItemQueue[1] ~= nil then
		ShowItem();
	else
		if LastFrame then LastFrame.Visible = true; end;
    end)
  end
end
local function Redeem()
	for Code,CodeTable in pairs(Database.Codes) do
		local Match = (CodeFrame.CodeBox.Text==Code);
		if Match then
			local OwnedWeapons = _G.PlayerData.Weapons.Owned;
			if OwnedWeapons[CodeTable.Prize] then
				CodeFrame.CodeBox.Text = "Redeemed.";
				return;
			end
			if os.time() < CodeTable.Expiry then
				_G.PlayerData.Weapons.Owned[CodeTable.Prize] = (OwnedWeapons[CodeTable.Prize] and OwnedWeapons[CodeTable.Prize]+1) or 1;
				game.ReplicatedStorage.UpdateDataClient:Fire();
				_G.NewItem(CodeTable.Prize,"You Got...",InventoryFrame);
				game.ReplicatedStorage.RedeemCode:FireServer(Code);
			else
				CodeFrame.CodeBox.Text = "Code Expired :(";
			end;
			return;
		end
	end
end
CodeFrame.CodeBox.Changed:connect(function()
	for Code,CodeTable in pairs(Database.Codes) do
		local Match = CodeFrame.CodeBox.Text==Code
		CodeFrame.Redeem.Style = (Match and Enum.ButtonStyle.RobloxRoundDefaultButton) or Enum.ButtonStyle.RobloxRoundButton;
		if Match then break end;
	end
end)
CodeFrame.Redeem.MouseButton1Click:connect(Redeem);
CodeFrame.CodeBox.FocusLost:connect(function(Enter) if Enter then Redeem() end; end);]]
