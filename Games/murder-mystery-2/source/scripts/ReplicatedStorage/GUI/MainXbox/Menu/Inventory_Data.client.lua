local GameGUI = script.Parent.Parent;
local InventoryFrame = GameGUI.Inventory;

local Main = InventoryFrame.Main;

--[[local ActionsFrame = Main.Weapons.Actions;
local CraftingFrame = ActionsFrame.ActionContainer.Craft;
local RecyclingFrame = ActionsFrame.ActionContainer.Recycle;
]]
local ProcessingFrame = GameGUI.Processing;
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

local Update;

local Database = {
	
	Weapons = Remote.GetSyncData:InvokeServer("Item");
	Effects = Remote.GetSyncData:InvokeServer("Effects");
	Perks = Remote.GetSyncData:InvokeServer("Perks");
	Pets = Remote.GetSyncData:InvokeServer("Pets");
	--[[Emotes = Remote.GetSyncData:InvokeServer("Emotes");
	Radios = Remote.GetSyncData:InvokeServer("Radios");
	Toys = Remote.GetSyncData:InvokeServer("Toys");
	
	Recipes = Remote.GetSyncData:InvokeServer("Recipe");
	Codes = Remote.GetSyncData:InvokeServer("Codes");
	Recyclable = Remote.GetSyncData:InvokeServer("Recyclable");]]
	SlotInfo = Remote.GetSyncData:InvokeServer("SlotInfo");
	
};
local RarityColors = Remote.GetSyncData:InvokeServer("Rarity");
local RarityOrder = {Classic=1;Common=2;Uncommon=3;Rare=4;Legendary=5;Godly=6;Victim=7;Custom=10;Christmas=1.5;Halloween=1.6;Ancient=6.5;Mythic=6.6;};

local MyStuff = {
	Weapons = nil;
	Effects = nil;
	Perks = nil;
	Emotes = nil;
	Radios = nil;
	Pets = nil;
};
local Stuff = {"Weapons","Perks","Effects","Pets"}; --,"Emotes","Toys","Effects","Perks","Radios","Pets"};
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
	local ImageFrame = ((Frame:IsA("ImageLabel") or Frame:IsA("ImageButton")) and Frame) or Frame.Icon;
	if ItemName == nil then
		ImageFrame.Image = "";
		Frame.ItemName.Text = "";
		if Frame:FindFirstChild("Amount") then
			Frame.Amount.Text = "";
		end
	else
		--print(Type,ItemName);
		local ItemData = Database[(Type or "Weapons")][ItemName];
		ImageFrame.Image = GetImage(ItemData.Image);
		Frame.ItemName.Text = ItemData.ItemName or ItemData.Name;
		Frame.ItemName.TextColor3 = (ItemData.Rarity and RarityColors[ItemData.Rarity]) or Color3.new(1,1,1);
		if tonumber(Amount) and Frame:FindFirstChild("Amount") then
			Frame.Amount.Text = "x" .. Amount;
		end
		if Frame:FindFirstChild("Rarity") then
			Frame.Rarity.Text = (ItemData.Rarity) or "";
			Frame.Rarity.TextColor3 = ( RarityColors[ItemData.Rarity] ) or Color3.new(1,1,1);
		end
	end;
end;

--[[
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
			local Data = {Database.Weapons[ID[1],Database.Weapons[ID[2]};
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
end;]]

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
	--pcall(function() 
		--local Data = Remote.GetData:InvokeServer("Weapons");
		local CustomTypes = {"Weapons","Pets"};
		for _,Type in pairs(CustomTypes) do
			local Data1 = CopyTable(_G.PlayerData[Type]);
			local WeaponsTable = {};
			for ItemID,Amount in pairs(Data1.Owned) do
				table.insert(WeaponsTable,{
					ItemID = ItemID;
					Amount = Amount;
				});
			end
			table.sort(WeaponsTable,function(a,b)
				-- if A is less than B, return true;
				local ID = {a.ItemID,b.ItemID};
				local Amount = {a.Amount,b.Amount};
				local Data = {Database[Type][ID[1]],Database[Type][ID[2]]};
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
						return Data[1][ (Type=="Weapons"and "ItemName")or "Name" ] < Data[2][ (Type=="Weapons"and "ItemName")or "Name" ];
					end;
				end;
			end)
			Data1.Owned = WeaponsTable;
			MyStuff[Type] = Data1;
		end;
	--end);
end;

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
	--[[
	for _,Con in pairs(RecycleConnections) do Con:disconnect() end;
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
	local Rarity = (Success and Database.Weapons[RecyclingTable[1]] --[[.Rarity) or "Common";
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
	--[[
	local Frame = CraftingFrame["Item"..Index];
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

--[[
local function UpdateEquip()
	for _,StuffName in pairs(Stuff) do
		if StuffName ~= "Weapons" and MyStuff[StuffName].Equipped then
			local EquipFrame = Main[StuffName].Equipped;
			
			for _,Slot in pairs(EquipFrame:GetChildren()) do
				Slot.Image = "";
				Slot.ItemName.Text = "";
			end			
			
			for Index,ItemName in pairs(MyStuff[StuffName].Equipped) do
				local Slot = EquipFrame["Slot"..Index];
				Slot.Image = GetImage(Database[StuffName][ItemName].Image);
				Slot.ItemName.Text = Database[StuffName][ItemName].Name;
				Slot.MouseButton1Click:connect(function()
					if Database.SlotInfo[StuffName] and Database.SlotInfo[StuffName].Unequip then
						table.remove(_G.PlayerData[StuffName].Equipped,Index);
						Update();
						Remotes.Inventory.Unequip:FireServer(Index,StuffName);
					end
				end)
			end;
		else
			for Type,Value in pairs(MyStuff.Weapons.Equipped) do
				local EquipFrame = (Type == "Knife" and Main.Weapons.Equipped) or Main.Weapons.Equipped.Knife;
				local ItemData = Database.Weapons[Value];
				EquipFrame[Type].Icon.Image = GetImage(ItemData.Image);
				EquipFrame[Type].ItemName.Text = ItemData.ItemName;
				EquipFrame[Type].ItemName.TextColor3 = RarityColors[ItemData.Rarity];
			end
		end;
	end
end]]

local function UpdateEquip()
	for _,StuffName in pairs(Stuff) do
		if StuffName ~= "Weapons" and MyStuff[StuffName].Equipped then
			local EquipFrame = Main[StuffName].Equipped;
			for Index,ItemName in pairs(MyStuff[StuffName].Equipped) do
				local Slot = EquipFrame["Slot"..Index];
				--if type(ItemName) == "table" then for i,v in pairs(ItemName) do print(i,v); end; end;
				--ItemName = (type(ItemName)=="string" and ItemName) or ItemName.ItemID;
				Slot.Image = GetImage(Database[StuffName][ItemName].Image);
				Slot.ItemName.Text = Database[StuffName][ItemName].Name;
				Slot.MouseButton1Click:connect(function()
					if Database.SlotInfo[StuffName] and Database.SlotInfo[StuffName].Unequip then
						table.remove(_G.PlayerData[StuffName].Equipped,Index);
						Update();
						Remotes.Inventory.Unequip:FireServer(Index,StuffName);
					end
				end)
			end;
		else
			for Type,Value in pairs(MyStuff.Weapons.Equipped) do
				local EquipFrame = (Type == "Knife" and Main.Weapons.Equipped) or Main.Weapons.Equipped.Knife;
				local ItemData = Database.Weapons[Value];
				EquipFrame[Type].Icon.Image = GetImage(ItemData.Image);
				EquipFrame[Type].ItemName.Text = ItemData.ItemName;
				EquipFrame[Type].ItemName.TextColor3 = RarityColors[ItemData.Rarity];
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
		
	elseif CurrentAction == "Recycle" then
		if CheckItemRecyclable(ItemID) and #RecyclingTable < 8 then
			table.insert(RecyclingTable,ItemID);
			UpdateRecycling();
		end
	elseif CurrentAction == "Craft" then
		local Done = false;
		local HasAmount = 0;
		for _,Weapon in pairs(MyStuff.Weapons.Owned) do 
			if Weapon.ItemID == ItemID then 
				HasAmount = Amount;
				break;
			end 
		end;
		for Index,cTable in pairs(CraftingTable) do
			if cTable.ItemID == ItemID then
				HasAmount = HasAmount - cTable.Amount;
				break;
			end
		end
		if HasAmount > 0 then
			local PlusAmount = (RightClick and HasAmount >= 10 and 10) or (RightClick and HasAmount) or 1;
			for Index,cTable in pairs(CraftingTable) do
				if cTable.ItemID == ItemID then
					CraftingTable[Index].Amount = CraftingTable[Index].Amount + PlusAmount;
					Done = true;
				end
			end
			
			if not Done then
				for Index,cTable in pairs(CraftingTable) do
					if cTable.ItemID == nil then
						CraftingTable[Index].ItemID = ItemID;
						CraftingTable[Index].Amount = PlusAmount;
						break;
					end
				end
			end;
		end;
		UpdateCrafting();
	end;
end

local GridFunctions = {
	Weapons = {
		FrameFunction = function(Frame,Index,Table)
			local ItemData = Database.Weapons[Table.ItemID];
			Frame.Icon.Image = ItemData.Image;
			Frame.ItemName.Text = ItemData.ItemName;
 			Frame.ItemName.TextColor3 = RarityColors[ItemData.Rarity];
			Frame.Rarity.Text = ItemData.Rarity;
			Frame.Rarity.TextColor3 = RarityColors[ItemData.Rarity];
			if Table.Amount > 1 then
				Frame.Amount.Text = "x" .. Table.Amount;
			end
			--Frame.MouseEnter:connect(function() Frame.Rarity.Visible = true; end);
			--Frame.MouseLeave:connect(function() Frame.Rarity.Visible = false; end);
			Frame.Button.MouseButton1Click:connect(function()
				WeaponAction(Table.ItemID,Table.Amount,ItemData);
			end)
			--[[Frame.Button.MouseButton2Click:connect(function()
				WeaponAction(Table.ItemID,Table.Amount,ItemData,true);
			end)]]
		end
	};
	Effects = {
		FrameFunction = function(Frame,Index,EffectName)
			local ItemData = Database.Effects[EffectName];
			Frame.Icon.Image = ItemData.Image;
			Frame.Type.Text = ItemData.Type;
			Frame.ItemName.Text = ItemData.Name;
		end;
	};
	Perks = {
		FrameFunction = function(Frame,Index,PerkName)
			local ItemData = Database.Perks[PerkName];
			Frame.Icon.Image = GetImage(ItemData.Image);
			Frame.ItemName.Text = ItemData.Name;
			--Frame.Type.Text = ItemData.EffectType;
		end;
	};
	Emotes = {
		FrameFunction = function(Frame,Index,Name)
			local ItemData = Database.Emotes[Name];
			Frame.ItemName.Text = ItemData.Name;
			Frame.Icon.Image = ItemData.Image;
			Frame.Type.Text = "/e " .. ItemData.Command;
		end;
	};
	Radios = {
		FrameFunction = function(Frame,Index,Name)
			local ItemData = Database.Radios[Name];
			Frame.ItemName.Text = ItemData.Name;
			Frame.Icon.Image = AssetURL .. ItemData.Image
		end
	};
	Toys = {
		FrameFunction = function(Frame,Index,Name)
			local ItemData = Database.Toys[Name];
			Frame.ItemName.Text = ItemData.Name;
			Frame.Icon.Image = GetImage(ItemData.Image);
		end
	};
	Pets = {
		FrameFunction = function(Frame,Index,Table)
			local ItemData = Database.Pets[Table.ItemID];
			Frame.Icon.Image = GetImage(ItemData.Image);
			Frame.ItemName.Text = ItemData.Name;
 			Frame.ItemName.TextColor3 = RarityColors[ItemData.Rarity];
			Frame.Rarity.Text = ItemData.Rarity;
			Frame.Rarity.TextColor3 = RarityColors[ItemData.Rarity];
			if Table.Amount > 1 then
				Frame.Amount.Text = "x" .. Table.Amount;
			end
			Frame.MouseEnter:connect(function() Frame.Rarity.Visible = true; end);
			Frame.MouseLeave:connect(function() Frame.Rarity.Visible = false; end);
		end
	};
};

local function CreateGrid(Type)
	if MyStuff[Type] == nil then return end;
	local i = 0;
	local ScrollFrame = Main[Type].Items.ScrollFrame;
	local Container = ScrollFrame.Container;
	local Size = (GridFunctions[Type] and GridFunctions[Type].Size) or 0.2;
	local FrameFunction = (GridFunctions[Type] and GridFunctions[Type].FrameFunction) or function()end;
	
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

	
	if MyStuff[Type].Equipped and Type ~= "Weapons" then
		Main[Type].Equipped:ClearAllChildren();
		
		--for Index = 1,MyStuff[Type].Slots do
			local NewSlot = script.EquipSlot:Clone();
			NewSlot.ItemName.Text = "Empty";
			--NewSlot.Position = UDim2.new(0,0,0.5,-60);
			NewSlot.Parent = Main[Type].Equipped;
			NewSlot.Name = "Slot".. 1;
			NewSlot.Selectable = (Type == "Effects" or Type == "Pets");
		--end
		
		--[[local NextSlotIndex = MyStuff[Type].Slots + 1;
		if NextSlotIndex <= Database.SlotInfo[Type].Max then
			
			local NextSlot = script.EquipSlot:Clone();
			local Price = Database.SlotInfo[Type].Prices[NextSlotIndex];
			NextSlot.Locked.Visible = true;
			NextSlot.Locked.Price.Text = Price;
			NextSlot.Position = UDim2.new(0,7+(MyStuff[Type].Slots*130),0.5,-60);
			NextSlot.Parent = Main[Type].Equipped;
			NextSlot.Name = "Slot"..NextSlotIndex;

			NextSlot.MouseButton1Click:connect(function()
				if _G.PlayerData.Credits >= Price then
					_G.PlayerData.Credits = _G.PlayerData.Credits - Price;
					_G.PlayerData[Type].Slots = _G.PlayerData[Type].Slots + 1;
					script.Parent.Ching:Play();
					Update();
					game.ReplicatedStorage.UpdateDataClient:Fire();
					Remotes.Inventory.BuySlot:FireServer(Type);
				end
			end)
			
		end]]
	end;

	Container:ClearAllChildren();
	local function CreateFrame(Index,Value)
		if Value ~= "None" then
			local Row = math.floor(i/(1/Size)); local Column = i%(1/Size);
			local NewFrame = (Value == "GetMore" and script.GetMore:Clone()) or script.Item:Clone();
			NewFrame.Parent = Container;
			NewFrame.Size = UDim2.new(Size,0,Size,0);
			NewFrame.Position = UDim2.new(NewFrame.Size.X.Scale*Column,0,0,NewFrame.AbsoluteSize.Y*Row);
			
			NewFrame.Name = "Slot"..i;
			--[[if type(Value) == "string" then
				NewFrame.Name = "Slot"..i;
			elseif type(Value) == "table" and Value.ItemID then
				NewFrame.Name = Value.ItemID;
			end;]]
			
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
			ScrollFrame.CanvasSize = UDim2.new(0,0,0,(Row+1)*NewFrame.AbsoluteSize.Y);
			i = i + 1;
		end;
	end
	
	--if Type ~= "Radios" or (Type=="Radios" and HasRadio) then
		
		if Main[Type]:FindFirstChild("BuyRadio") and HasRadio then
			Main[Type].BuyRadio.Visible = false;
		end		
		
		for Index,Value in pairs(MyStuff[Type].Owned) do
			CreateFrame(Index,Value);
		end
		
		--CreateFrame(nil,"GetMore");
		
	--end;
	
end

Update = function(CoinUpdate)
	if not CoinUpdate then
		local Select = game:GetService("GuiService").SelectedObject;
		local SelectName,SelectFrame;
		if Select then
			SelectName = Select.Name;
			SelectFrame = Select.Parent;
		end;
		SortData();
		for _,StuffName in pairs(Stuff) do
			CreateGrid(StuffName);
		end
		UpdateEquip();
		if SelectName and SelectFrame then
			game:GetService("GuiService").SelectedObject = SelectFrame[SelectName];
		end
	end;
end;
Update();
game.ReplicatedStorage.UpdateDataClient.Event:connect(Update);

--[[local Buttons = ActionsFrame:GetChildren();
for _,Button in pairs(Buttons) do
	if Button:IsA("TextButton") then Button.MouseButton1Click:connect(function() CurrentAction=Button.Name; UpdateRecycling(); end); end;
end]]

--[[RecyclingFrame.Confirm.MouseButton1Click:connect(function()
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
end)]]

local function UpdateRecipes()
	--[[local i = 0;
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
	end]]
end;
UpdateRecipes();



---- NewItem 
local NewItemFrame = GameGUI.NewItem;
local LastFrame;

local ItemQueue = {};

local function ShowItem()
	local Item = ItemQueue[1];
	CreateWeaponFrame(NewItemFrame.Container.Item,Item.ItemName,nil,Item.Type);
	NewItemFrame.Container.Title.Text = Item.TitleText;
	if Item.LFrame then
		LastFrame = Item.LFrame;
		LastFrame.Visible = false;
	end;
	NewItemFrame.Visible = true;
	
	Bind("Claim",Enum.KeyCode.ButtonA,function()
		Unbind("Claim");
		NewItemFrame.Visible = false;
		_G.UnfinishedItem = nil;
		table.remove(ItemQueue,1);
		if ItemQueue[1] ~= nil then
			ShowItem();
		else
			if LastFrame then LastFrame.Visible = true; end;
		end;
	end)
	
end;

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
	end
	
end

game.ReplicatedStorage.ItemGift.OnClientEvent:connect(function(Prize,Type)
	_G.NewItem(Prize,"You Got...",nil,Type);
end);

---- NewItem

_G.Process = function(TitleText)
	ProcessingFrame.Title.Text = TitleText;
	spawn(function() while ProcessingFrame.Visible == true do ProcessingFrame.Frame.Spinner.Rotation = ProcessingFrame.Frame.Spinner.Rotation + 5; game:GetService("RunService").RenderStepped:wait(); end; end)
	spawn(function() while ProcessingFrame.Visible == true do wait(0.2); ProcessingFrame.Title.Text = ProcessingFrame.Title.Text .. ".";  end; end)
	ProcessingFrame.Visible = true;
end

--[[
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
