local GameGUI = script.Parent.Parent.Game;
local InventoryFrame = GameGUI.ViewProfile;
local Navigation = InventoryFrame.Nav;
local Main = InventoryFrame.Main;
local Remote = game.ReplicatedStorage;
local Remotes = Remote.Remotes;
local AssetURL = "http://www.roblox.com/Thumbs/Asset.ashx?format=png&width=250&height=250&assetId=";
local HasRadio,CanUseRadio = game.ReplicatedStorage.HasRadio:InvokeServer();
local Player = game.Players.LocalPlayer 
local membershipType = Player.MembershipType
local GroupID = 17363526
local DataTable = {};
local Data;

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

local RankIcons = require(game.ReplicatedStorage.RankIconsEmpty);

local PrestigeTexts = {
	[0]	= "";
	[1]	= "I";
	[2]	= "II";
	[3]	= "III";
	[4]	= "IV";
	[5]	= "V";
	[6]	= "VI";
	[7]	= "VII";
	[8]	= "VIII";
	[9]	= "IX";
	[10]= "X";
};


local Database = {

	Weapons = Remote.GetSyncData:InvokeServer("Item");
	Effects = Remote.GetSyncData:InvokeServer("Effects");
	Perks 	= Remote.GetSyncData:InvokeServer("Perks");
	Emotes 	= Remote.GetSyncData:InvokeServer("Emotes");
	Radios	= Remote.GetSyncData:InvokeServer("Radios");
	Pets 	= Remote.GetSyncData:InvokeServer("Pets");
	Outfits = Remote.GetSyncData:InvokeServer("Outfits");
};
local RarityColors = Remote.GetSyncData:InvokeServer("Rarity");
local RarityOrder = {Classic=1;Common=2;Uncommon=3;Rare=4;Legendary=5;Godly=6;Custom=10;Dream=6.8;Victim=7;Giveaways=8;Christmas=1.5;Halloween=1.6;Ancient=6.5;Mythic=6.7;Bussiness=12;ChampulseV=999};

local MyStuff = {
	Weapons = nil;
	Effects = nil;
	Perks = nil;
	Emotes = nil;
	Radios = nil;
	Pets = nil;
	Outfits = nil;
};
local Stuff = {"Weapons","Emotes","Effects","Perks","Radios","Pets","Outfits"};
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
			Frame.Item.BackgroundColor3 = Color3.new(0.415686, 0.415686, 0.415686);
			Frame.Parent.Starburst.ImageColor3 = Color3.new(0.415686, 0.415686, 0.415686);
			if tonumber(Amount) and Frame:FindFirstChild("Amount") then
				Frame.Amount.Text = "x" .. Amount;
			end
		end;
	end;
end;

local LevelData = {}

local PlayerTable = {}
for _,Player in pairs(game.Players:GetPlayers()) do
	if not LevelData[Player.Name] then
		local Level,Prestige,Elite = game.ReplicatedStorage.GetPlayerLevel:InvokeServer(Player);
		if Level~=nil and Prestige ~=nil and Elite ~= nil then
			LevelData[Player.Name] = {};
			LevelData[Player.Name].Level = Level;
			LevelData[Player.Name].Prestige = Prestige;
			LevelData[Player.Name].Elite = Elite;
		end;
	end

	if LevelData[Player.Name] ~= nil and LevelData[Player.Name].Level ~= nil and LevelData[Player.Name].Prestige ~=nil and LevelData[Player.Name].Elite ~= nil then
		table.insert(PlayerTable,{
			Player = Player;
			LD = LevelData[Player.Name];
		});
	end;
end	
table.sort(PlayerTable,function(a,b)
	if a.Elite and not b.Elite then
		return true;
	elseif b.Elite and not a.Elite then
		return false;
	else
		local SortLevelA = (a.LD.Prestige*100)+a.LD.Level;
		local SortLevelB = (b.LD.Prestige*100)+b.LD.Level;
		return SortLevelA > SortLevelB;
	end;
end)

local function SortData()
	for _,DataName in pairs(Stuff) do
		--local Table = Remote.GetData:InvokeServer(DataName);
		local Table = CopyTable(MyStuff[DataName]);
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
		local Data1 = CopyTable(MyStuff[Type]);
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

local container = Main.Profile.Container.Profile.Trophies.Container

local GridFunctions = {
	Weapons = {
		FrameFunction = function(Frame,Index,Table)
			local ItemData = Database.Weapons[Table.ItemID];
			Frame.Icon.Image = GetImage(ItemData.Image);
			Frame.Parent.ItemName.Label.Text = ItemData.ItemName;
			Frame.Parent.ItemName.BackgroundColor3 = RarityColors[ItemData.Rarity];
			if Table.Amount > 1 then
				Frame.Amount.Text = "x" .. Table.Amount;
			end
			if ItemData.Rarity == "Common" then
				Frame.Parent.ItemName.BackgroundColor3 = Color3.new(0.415686, 0.415686, 0.415686);
			end
			if ItemData.Chroma ~= nil then
				Frame.Parent.Tags.Chroma.Visible = true;
			end
			if ItemData.CustomAward then
				Frame.Parent.Tags.Unique.Visible = true;
				Frame.Parent.Tags.Unique.PlayerName.Text = _G.MenuPlayer.Name .. "'s"
				Frame.Amount.Text = "#1"
				container.Parent.Visible = true
			end
			if ItemData.Leaderboard then
				Frame.Parent.Tags.Unique.Visible = true;
				Frame.Parent.Tags.Unique.PlayerName.Text = _G.MenuPlayer.Name .. "'s"
				Frame.Amount.Text = "#" .. Data[ItemData.Leaderboard].Rank
				container.Parent.Visible = true
				local GridLayout = script["UIGridLayout"]:Clone()
				local NewItem = script["NewItem"]:Clone()

				NewItem.ItemName.Label.Text = "Rank #" .. Data[ItemData.Leaderboard].Rank
				NewItem.Container.Year.TagName.Text = ItemData.Year
				NewItem.Container.Icon.Image = GetImage(ItemData.Image)
				NewItem.ItemName.BackgroundColor3 = Data[ItemData.Leaderboard].Rank == 1 and RarityColors[ItemData.Rarity] or Color3.fromRGB(106, 106, 106)

				GridLayout.Parent = container
				NewItem.Parent = container
			end
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
			if Table.Amount > 1 then
				Frame.Amount.Text = "x" .. Table.Amount;
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
		local Size = (GridFunctions[Type] and GridFunctions[Type].Size) or 0.25;
		local FrameFunction = (GridFunctions[Type] and GridFunctions[Type].FrameFunction) or function()end;
		Container:ClearAllChildren();
		local GridLayout = script.ItemGridLayout:Clone()
		GridLayout.Parent = Container
		local function CreateFrame(Index,Value)
			if Value ~= "None" then
				local ItemData = Database[Type][Value.ItemID];
				local Row = math.floor(i/(1/Size)); local Column = i%(1/Size);
				local NewFrame = (Value == "GetMore" and script.GetMore:Clone()) or script.Item:Clone();
				pcall(function() if Value.ReleaseTime then NewFrame.LayoutOrder = Value.ReleaseTime end end)
				NewFrame.Parent = Container;

				if type(Value) == "string" then
					NewFrame.Name = Value;
				elseif type(Value) == "table" and Value.ItemID then
					NewFrame.Name = Value.ItemID;
				end;

				if Index and Value then 
					FrameFunction(NewFrame.Container,Index,Value); 
				end;
				i = i + 1;
			end;
		end
		if Main[Type]:FindFirstChild("BuyRadio") and HasRadio then
			Main[Type].BuyRadio.Visible = false;
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
		local Size = (GridFunctions[Type] and GridFunctions[Type].Size) or 0.25;
		local FrameFunction = (GridFunctions[Type] and GridFunctions[Type].FrameFunction) or function()end;

		local function CreateFrame(Index,Value)
			if Value ~= "None" then
				local ScrollFrame
				local ItemData = Database.Weapons[Value.ItemID];
				if ItemData.Season ~= nil then
					ScrollFrame = Main[Type].Items.Container.Current;
				elseif ItemData.Holidays ~= nil then
					if ItemData.Christmas then
						ScrollFrame = Main[Type].Items.Container.Holiday.Container.Christmas;
					else
						ScrollFrame = Main[Type].Items.Container.Holiday.Container.Halloween;
					end
				else
					ScrollFrame = Main[Type].Items.Container.Classic;
				end

				local Container = ScrollFrame.Container;
				local Row = math.floor(i/(1/Size)); local Column = i%(1/Size);
				local NewFrame = (Value == "GetMore" and script.GetMore:Clone()) or script.Item:Clone();

				NewFrame.Parent = Container;

				if type(Value) == "string" then
					NewFrame.Name = Value;
				elseif type(Value) == "table" and Value.ItemID then
					NewFrame.Name = Value.ItemID;
				end;

				if Index and Value then 
					FrameFunction(NewFrame.Container,Index,Value); 
				end;
				i = i + 1;
			end;
		end
		if Main[Type]:FindFirstChild("BuyRadio") and HasRadio then
			Main[Type].BuyRadio.Visible = false;
		end		
		for Index,Value in pairs(MyStuff[Type].Owned) do
			CreateFrame(Index,Value);
		end
	end
end

GameGUI.Leaderboard.Inspect.Profile.MouseButton1Click:connect(function()
	container.Parent.Visible = false
	container:ClearAllChildren()
	GameGUI.Leaderboard.Inspect.Visible = false
	InventoryFrame.Main.Weapons.Title.Username.Text = _G.MenuPlayer.Name .. "'s Stuff";
	InventoryFrame.Main.Outfits.Title.Username.Text = _G.MenuPlayer.Name .. "'s Stuff";
	InventoryFrame.Main.Radios.Title.Username.Text = _G.MenuPlayer.Name .. "'s Stuff";
	InventoryFrame.Main.Pets.Title.Username.Text = _G.MenuPlayer.Name .. "'s Stuff";
	InventoryFrame.Main.Perks.Title.Username.Text = _G.MenuPlayer.Name .. "'s Stuff";
	InventoryFrame.Main.Emotes.Title.Username.Text = _G.MenuPlayer.Name .. "'s Stuff";
	InventoryFrame.Main.Effects.Title.Username.Text = _G.MenuPlayer.Name .. "'s Stuff";

	if _G.MenuPlayer.Name == game.Players.LocalPlayer.Name then
		local v5 = " (You)";
		InventoryFrame.Main.Profile.Container.Username.Text = _G.MenuPlayer.Name .. v5
	else
		local v5 = "";
		InventoryFrame.Main.Profile.Container.Username.Text = _G.MenuPlayer.Name .. v5
	end;
	InventoryFrame.Main.Profile.Container.Character.CharacterIcon.Image = game.Players:GetUserThumbnailAsync(game.Players:GetUserIdFromNameAsync(_G.MenuPlayer.Name), Enum.ThumbnailType.AvatarBust, Enum.ThumbnailSize.Size352x352)
	InventoryFrame.Nav.Profile.Icon.Image = game.Players:GetUserThumbnailAsync(game.Players:GetUserIdFromNameAsync(_G.MenuPlayer.Name), Enum.ThumbnailType.AvatarBust, Enum.ThumbnailSize.Size352x352)

	InventoryFrame.Main.Profile.Container.Profile.Season1Stats.Container.Eliminations.Amount.Text = game.Players:FindFirstChild(_G.MenuPlayer.Name).leaderstats.MW.Value
	InventoryFrame.Main.Profile.Container.Profile.Season1Stats.Container.Saves.Amount.Text = game.Players:FindFirstChild(_G.MenuPlayer.Name).leaderstats.SherifWins.Value
	InventoryFrame.Main.Profile.Container.Profile.Season1Stats.Container.Survivals.Amount.Text = game.Players:FindFirstChild(_G.MenuPlayer.Name).leaderstats.IW.Value


	if game.ReplicatedStorage.AmElite:InvokeServer(_G.MenuPlayer) then
		InventoryFrame.Main.Profile.Container.Character.Elite.Visible = true
	else
		InventoryFrame.Main.Profile.Container.Character.Elite.Visible = false
	end
	if _G.MenuPlayer.Name == "IJayd_nBeast" then
		InventoryFrame.Main.Profile.Container.Character.MM2Creator.Visible = true
	else
		InventoryFrame.Main.Profile.Container.Character.MM2Creator.Visible = false
	end
	if _G.MenuPlayer.Name == "RhavizinNxtrixz" then
		InventoryFrame.Main.Profile.Container.Character.MM2Creator.Visible = true
	else
		InventoryFrame.Main.Profile.Container.Character.MM2Creator.Visible = false
	end
	if _G.MenuPlayer.Name == "BxJ524" then
		InventoryFrame.Main.Profile.Container.Character.CoOwner2.Visible = true
	else
		InventoryFrame.Main.Profile.Container.Character.CoOwner2.Visible = false
	end
	if _G.MenuPlayer.UserId == 1971231464 then
		InventoryFrame.Main.Profile.Container.Character.Builder.Visible = true
	else
		InventoryFrame.Main.Profile.Container.Character.Builder.Visible = false
	end
	if _G.MenuPlayer.UserId == 1971231464 then
		InventoryFrame.Main.Profile.Container.Character.CoOwner2.Visible = true
	else
		InventoryFrame.Main.Profile.Container.Character.CoOwner2.Visible = false
	end
	if _G.MenuPlayer.UserId == 1971231464 then
		InventoryFrame.Main.Profile.Container.Character.BetaTester.Visible = true
	else
		InventoryFrame.Main.Profile.Container.Character.BetaTester.Visible = false
	end
	if _G.MenuPlayer.UserId == 1971231464 then
		InventoryFrame.Main.Profile.Container.Character.BetaTester.Visible = true
	else
		InventoryFrame.Main.Profile.Container.Character.BetaTester.Visible = false
	end
	if Player.MembershipType == Enum.MembershipType.Premium then 
		InventoryFrame.Main.Profile.Container.Character.Premium.Visible = true
	else
		InventoryFrame.Main.Profile.Container.Character.Premium.Visible = false
	end
	if Player.MembershipType == Enum.MembershipType.Premium then
		InventoryFrame.Main.Profile.Container.Character.Group_Member.Visible = true
	else
		InventoryFrame.Main.Profile.Container.Character.Group_Member.Visible = false
	end
	if _G.MenuPlayer.UserId == 188353816 then
		InventoryFrame.Main.Profile.Container.Character.YouTuber.Visible = true
	else
		InventoryFrame.Main.Profile.Container.Character.YouTuber.Visible = false
	end

	if _G.MenuPlayer.Name == "legoguy8110jr" then
		InventoryFrame.Main.Profile.Container.Character.Alt.Visible = true
	else
		InventoryFrame.Main.Profile.Container.Character.Alt.Visible = false
	end

	--[[if _G.MenuPlayer.Name == "Mintify_YT" then
		InventoryFrame.Main.Profile.Container.Character.c5.Visible = false
	else
		InventoryFrame.Main.Profile.Container.Character.c5.Visible = false
	end]]

	--[[if _G.MenuPlayer.Name == "C546S" then
		InventoryFrame.Main.Profile.Container.Character.Clown.Visible = true
	else
		InventoryFrame.Main.Profile.Container.Character.Clown.Visible = false
	end

	if _G.MenuPlayer.Name == "ShadowXIVII" then
		InventoryFrame.Main.Profile.Container.Character.BetaTester.Visible = false
	else
		InventoryFrame.Main.Profile.Container.Character.BetaTester.Visible = false
	end]]

	if _G.MenuPlayer.Name == "LegoBrickMissing" then
		InventoryFrame.Main.Profile.Container.Character.CoOwner.Visible = true
	else
		InventoryFrame.Main.Profile.Container.Character.CoOwner.Visible = false
	end

	-- ChampulseV Service 


	-- ChampulseV Service 


	--[[if _G.MenuPlayer.Name == "LegoBrickMissing" or _G.MenuPlayer.Name == "legoguy8110jr" or _G.MenuPlayer.Name == "MM2CisGroupHolder" then
		InventoryFrame.Main.Profile.Container.Character.MM2Creator.Visible = true
	else
		InventoryFrame.Main.Profile.Container.Character.Chap1.Visible = false
		InventoryFrame.Main.Profile.Container.Character.Chap2.Visible = false
		InventoryFrame.Main.Profile.Container.Character.MM2Creator.Visible = false
	end]]


	--------------------------------------


	local LD = LevelData[_G.MenuPlayer.Name];

	InventoryFrame.Main.Profile.Container.Character.CharacterIcon.LevelFrame.LevelContainer.Icon.Image = RankIcons[LD.Level];
	InventoryFrame.Main.Profile.Container.Character.CharacterIcon.LevelFrame.LevelContainer.Icon.Level.Text = LD.Level
	InventoryFrame.Main.Profile.Container.Character.CharacterIcon.LevelFrame.LevelContainer.Prestige.Text = PrestigeTexts[LD.Prestige];

	Data = game.ReplicatedStorage.GetFullInventory:InvokeServer(_G.MenuPlayer);
	for _,Type in pairs(Stuff) do
		MyStuff[Type] = Data[Type];
	end
	SortData();
	for _,Type in pairs(Stuff) do
		CreateGrid(Type);
	end
	GameGUI.Shop.Visible = false;
	GameGUI.Inventory.Visible = false;
	_G.Windows.ViewFrame(InventoryFrame);
end)
