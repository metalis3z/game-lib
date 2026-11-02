-- pcs
local GameGUI = script.Parent.Parent.Game;
local InventoryFrame = GameGUI.Inventory;
local Navigation = InventoryFrame.Nav;
local Main = InventoryFrame.Main;
local CodeFrame = Main.Weapons.Equipped.Container.Codes;
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

local Update;

local Database = {

	Weapons 	= Remote.GetSyncData:InvokeServer("Item");
	Effects 	= Remote.GetSyncData:InvokeServer("Effects");
	Perks 		= Remote.GetSyncData:InvokeServer("Perks");
	Emotes 		= Remote.GetSyncData:InvokeServer("Emotes");
	Radios		= Remote.GetSyncData:InvokeServer("Radios");
	Toys		= Remote.GetSyncData:InvokeServer("Toys");
	Pets 		= Remote.GetSyncData:InvokeServer("Pets");
	Materials 	= Remote.GetSyncData:InvokeServer("Materials");
	Outfits = Remote.GetSyncData:InvokeServer("Outfits");

	Codes = Remote.GetSyncData:InvokeServer("Codes");
	Recyclable = Remote.GetSyncData:InvokeServer("Recyclable");
	SlotInfo = Remote.GetSyncData:InvokeServer("SlotInfo");

};

local RarityColors = Remote.GetSyncData:InvokeServer("Rarity");
local RarityOrder = {Classic=1;Common=2;Uncommon=3;Rare=4;Legendary=5;Godly=6;GodIy=6;Mythic=6.6;Dream=6.8;Unique=7;Custom=10;Christmas=1.5;Halloween=1.6;Ancient=6.5;Clown=10;Victim=11;Bussiness=12;ChampulseV=999;};

local MyStuff = {
	Weapons = nil;
	Effects = nil;
	Perks = nil;
	Emotes = nil;
	Radios = nil;
	Pets = nil;
	Outfits = nil;
};
local Stuff = {"Weapons","Emotes","Toys","Effects","Perks","Radios","Pets","Outfits"};
local CurrentAction = "Equip";


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
		if Frame:FindFirstChild("ItemName") then
			Frame.ItemName.Text = "";
		end
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
			Frame.Item.BackgroundColor3 = Color3.new(0.415686, 0.415686, 0.415686);
			Frame.Parent.Starburst.ImageColor3 = Color3.new(0.415686, 0.415686, 0.415686);
			if tonumber(Amount) and Frame:FindFirstChild("Amount") then
				Frame.Amount.Text = "x" .. Amount;
			end
		end;
		if ItemData.CustomAward then
			Frame.Parent.Amount.Visible = true;
			Frame.Parent.Amount.Text = "#1"
			Frame.Tags.Unique.Visible = true;
			Frame.Tags.Unique.PlayerName.Text = game.Players.LocalPlayer.Name .. "'s"
		end
		if ItemData.Leaderboard then
			Frame.Parent.Amount.Visible = true;
			Frame.Parent.Amount.Text = "#" .. _G.PlayerData[ItemData.Leaderboard].Rank
			Frame.Tags.Unique.Visible = true;
			Frame.Tags.Unique.PlayerName.Text = game.Players.LocalPlayer.Name .. "'s"
		end
	end;
end;
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

local RarityIndex = {
	["Common"] = "Uncommon";
	["Uncommon"] = "Rare";
	["Rare"] = "Legendary";
};


local function UpdateEquip()
	for _,StuffName in pairs(Stuff) do
		if StuffName ~= "Weapons" and MyStuff[StuffName].Equipped then
			local EquipFrame = Main[StuffName].Equipped;
			for Index,ItemName in pairs(MyStuff[StuffName].Equipped) do
				local Slot = EquipFrame["Item1"];
				local ItemData = Database[StuffName][ItemName];
				local CanEquip = true;
				Slot.Container.Visible = true
				if ItemData.UserId then
					Slot.Container.Container.Icon.Image =  GetImage(game.Players:GetUserThumbnailAsync(ItemData.UserId,Enum.ThumbnailType.AvatarThumbnail,Enum.ThumbnailSize.Size352x352))
				else
					Slot.Container.Container.Icon.Image = Database[StuffName][ItemName].Image and GetImage(Database[StuffName][ItemName].Image)
				end
				Slot.Container.ItemName.Label.Text = Database[StuffName][ItemName].Name
				if ItemData.Rarity ~= nil then
					Slot.Container.ItemName.BackgroundColor3 = RarityColors[ItemData.Rarity];
				end
				game.ReplicatedStorage.RoleSelect.OnClientEvent:connect(function(Role)
					GameGUI.Inventory.Main.Outfits.Wait.Visible = true
					GameGUI.Inventory.Main.Outfits.Items.Visible = false
					GameGUI.Inventory.Main.Outfits.Equipped.Visible = false
					CanEquip = false;
				end)
				Slot.Container.Container.Button.MouseButton1Click:connect(function()
					if Database.SlotInfo[StuffName] and Database.SlotInfo[StuffName].Unequip then
						table.remove(_G.PlayerData[StuffName].Equipped,Index);
						if StuffName == "Outfits" then
							table.remove(_G.PlayerData["Outfits"].Equipped,Index);
							Slot.Container.Visible = false
							Update();
							Remotes.Inventory.Unequip:FireServer(Index,"Outfits");
							return
						end
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

-- toys

local function UpdateToyEquip()
	for _,StuffName in pairs(Stuff) do
		if StuffName ~= "Toys" and MyStuff[StuffName].Equipped then
			local EquipFrame = Main[StuffName].Equipped;
			for Index,ItemName in pairs(MyStuff[StuffName].Equipped) do
				local Slot = EquipFrame["Item1"];
				local ItemData = Database[StuffName][ItemName];
				Slot.Container.Visible = true
				Slot.Container.Container.Icon.Image = GetImage(Database[StuffName][ItemName].Image);
				Slot.Container.ItemName.Label.Text = Database[StuffName][ItemName].Name; 
				if ItemData.Rarity ~= nil then
					Slot.Container.ItemName.BackgroundColor3 = RarityColors[ItemData.Rarity];
				end
				Slot.Container.Container.Button.MouseButton1Click:connect(function()
					if StuffName == "Toys" then
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
			if Table.Amount > 1 and not ItemData.Leaderboard then
				Frame.Amount.Text = "x" .. Table.Amount;
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
			if ItemData.Leaderboard  then
				Frame.Parent.Tags.Unique.Visible = true;
				Frame.Parent.Tags.Unique.PlayerName.Text = game.Players.LocalPlayer.Name .. "'s"
				Frame.Amount.Text = "#" .. _G.PlayerData[ItemData.Leaderboard].Rank
			end
			if ItemData.CustomAward  then
				Frame.Parent.Tags.Unique.Visible = true;
				Frame.Parent.Tags.Unique.PlayerName.Text = game.Players.LocalPlayer.Name .. "'s"
				Frame.Amount.Text = "#1"
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
	Perks = {
		FrameFunction = function(Frame,Index,PerkName)
			local ItemData = Database.Perks[PerkName];
			Frame.Icon.Image = GetImage(ItemData.Image);
			Frame.Parent.ItemName.Label.Text = ItemData.Name;
			--Frame.Type.Text = ItemData.EffectType;
		end;
	};
	Emotes = {
		FrameFunction = function(Frame,Index,Name)
			local ItemData = Database.Emotes[Name];
			Frame.Parent.ItemName.Label.Text = ItemData.Name;
			Frame.Icon.Image = GetImage(ItemData.Image);
			if ItemData.Rarity == "Common" or ItemData.Rarity ~= nil then
				Frame.Parent.ItemName.BackgroundColor3 = Color3.new(0.415686, 0.415686, 0.415686);
			end
			if ItemData.Rarity ~= nil then
				Frame.Parent.ItemName.BackgroundColor3 = RarityColors[ItemData.Rarity];
			end
		end;
	};
	Radios = {
		FrameFunction = function(Frame,Index,Name)
			local ItemData = Database.Radios[Name];
			Frame.Parent.ItemName.Label.Text = ItemData.Name;
			Frame.Icon.Image = GetImage(ItemData.Image);
			if ItemData.Rarity == "Common" or ItemData.Rarity ~= nil then
				Frame.Parent.ItemName.BackgroundColor3 = Color3.new(0.415686, 0.415686, 0.415686);
			end
			if ItemData.Rarity ~= nil then
				Frame.Parent.ItemName.BackgroundColor3 = RarityColors[ItemData.Rarity];
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
		FrameFunction = function(Frame,Index,Table)
			local ItemData = Database.Pets[Table.ItemID];
			Frame.Icon.Image = GetImage(ItemData.Image);
			Frame.Parent.ItemName.Label.Text = ItemData.Name;
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
			if ItemData.Rarity == "Divine" and ItemData.Name == "Swirly Axe" then
				Frame.Parent.Tags.Unique.Visible = true;
				Frame.Parent.Tags.Unique.PlayerName.Text = game.Players.LocalPlayer.Name
			end
			if Table.Amount > 1 then
				Frame.Amount.Text = "x" .. Table.Amount;
			end
			Frame.Button.MouseButton1Click:connect(function()
				UpdateEquip(Table.ItemID,Table.Amount,ItemData,true);
			end)
		end
	};
	Outfits = {
		FrameFunction = function(Frame,Index,OutfitName)
			local ItemData = Database.Outfits[OutfitName];
			local PlayerIcon = GetImage(game.Players:GetUserThumbnailAsync(ItemData.UserId,Enum.ThumbnailType.AvatarThumbnail,Enum.ThumbnailSize.Size352x352))
			Frame.Parent.ItemName.Label.Text = ItemData.Name;
			if ItemData.Rarity == "Common" or ItemData.Rarity ~= nil then
				Frame.Parent.ItemName.BackgroundColor3 = Color3.new(0.415686, 0.415686, 0.415686);
			end
			if ItemData.Rarity ~= nil then
				Frame.Parent.ItemName.BackgroundColor3 = RarityColors[ItemData.Rarity];
			elseif ItemData.Rarity ~= nil and ItemData.Rarity == "Common" then
				Frame.Parent.ItemName.BackgroundColor3 = Color3.new(0.415686, 0.415686, 0.415686);
			end
			Frame.Icon.Image = PlayerIcon
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
				local ItemData = Database.Weapons[Value.ItemID];
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

	if Main[Type]:FindFirstChild("NoRadioCover") and HasRadio then
		Main[Type].NoRadioCover.Visible = false;
	end

	--end;
end

local allowedInventory = true

local u1 = 1
local u3 = 1

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

local NewItemFrame = GameGUI.NewItem;
local LastFrame;

local ItemQueue = {};

local function ShowItem()
	local Item = ItemQueue[1];
	game.Lighting.NewItemBlur.Enabled = true
	CreateWeaponFrame(NewItemFrame.Container:WaitForChild("Item"),Item.ItemName or Item.Name,nil,Item.Type);
	NewItemFrame.Container.Title.Text = Item.TitleText;
	if Item.LFrame then
		LastFrame = Item.LFrame;
		LastFrame.Visible = false;
		u1 = 1;
		u3 = 1;
	end;
	NewItemFrame.Visible = true;
end
local function u8()
	if not (u1 > 1) then
		NewItemFrame.Container.Claim.Text = "Claim";
		return;
	end;
	NewItemFrame.Container.Claim.Text = "Claim (" .. u3 .. "/" .. u1 .. ")";
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
		u1 = #ItemQueue;
	else
		u1 = u1 + 1;
	end;
	u8()
end

game.ReplicatedStorage.ItemGift.OnClientEvent:connect(function(Prize,Type)
	GameGUI.ItemPack.Visible = false;
	GameGUI.Inventory.Visible = false;
	_G.NewItem(Prize,"You Got...",nil,Type);
end);

_G.Process = function(TitleText)
	ProcessingFrame.Title.Text = TitleText;
	spawn(function() while ProcessingFrame.Visible == true do ProcessingFrame.Spinner.Rotation = ProcessingFrame.Spinner.Rotation + 5; game:GetService("RunService").RenderStepped:wait(); end; end)
	spawn(function() while ProcessingFrame.Visible == true do wait(0.2); ProcessingFrame.Title.Text = ProcessingFrame.Title.Text .. ".";  end; end)
	ProcessingFrame.Visible = true;
end

NewItemFrame.Container.Claim.MouseButton1Click:connect(function()
	local v1 = require(game.ReplicatedStorage.Modules.ItemAnimationModule)
	v1.AnimateItemIconIntoInventory(NewItemFrame.Container.Item.Detail.Icon,GameGUI.Dock.Inventory,GameGUI)
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


local PetNaming = Main.Pets.Equipped.NameYourPet.Container2;
PetNaming.PetNameBox.Text = _G.PlayerData.PetName;
PetNaming.Confirm.MouseButton1Click:connect(function()
	local NewName =  PetNaming.PetNameBox.Text;
	if string.len(NewName)<= 20 then
		_G.PlayerData.PetName = NewName; 
		game.ReplicatedStorage.RenamePet:FireServer(NewName)
	else
		PetNaming.PetNameBox.Text = "Name too long";
	end;
end)


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
