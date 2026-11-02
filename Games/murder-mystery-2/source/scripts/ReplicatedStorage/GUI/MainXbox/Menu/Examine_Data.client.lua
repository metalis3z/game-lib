local GameGUI = script.Parent.Parent;
local InventoryFrame = GameGUI.Examine;

local Main = InventoryFrame.Main;

local ProcessingFrame = GameGUI.Processing;
local Remote = game.ReplicatedStorage;
local Remotes = Remote.Remotes;
local AssetURL = "http://www.roblox.com/Thumbs/Asset.ashx?format=png&width=250&height=250&assetId=";
local HasRadio,CanUseRadio = game.ReplicatedStorage.HasRadio:InvokeServer();
local CurrentExamine = "";

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

local function SortData(Data)
	for _,DataName in pairs(Stuff) do
		local Table = CopyTable(Data[DataName]);
		if Table ~= nil then
			table.sort(Table.Owned,function(a,b)
				return a < b; -- Attempt to compare bool with table
			end)
			MyStuff[DataName] = Table;
		end;
	end
		local CustomTypes = {"Weapons","Pets"};
		for _,Type in pairs(CustomTypes) do
			local Data1 = CopyTable(Data[Type]);
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

	Container:ClearAllChildren();
	local function CreateFrame(Index,Value)
		if Value ~= "None" then
			local Row = math.floor(i/(1/Size)); local Column = i%(1/Size);
			local NewFrame = script.Item:Clone();
			NewFrame.Parent = Container;
			NewFrame.Size = UDim2.new(Size,0,Size,0);
			NewFrame.Position = UDim2.new(NewFrame.Size.X.Scale*Column,0,0,NewFrame.AbsoluteSize.Y*Row);
			NewFrame.Name = "Slot"..i;
			if Index and Value then 
				FrameFunction(NewFrame.Container,Index,Value); 
			end;
			ScrollFrame.CanvasSize = UDim2.new(0,0,0,(Row+1)*NewFrame.AbsoluteSize.Y);
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

local T = 0.2;
local S = "Quad";
local D = "Out";

local CanNavigate = true;
local Frames = {{"Examine",Enum.KeyCode.ButtonA,{"Weapons","Perks","Effects","Pets"},1};};

local function Navigate(Frame,Direction)
	if not CanNavigate then return end;
	CanNavigate = false;
	
	local FData = Frames[Frame];
	
	local NavTable = FData[3];
	local CurrentFrame = GameGUI[FData[1]].Main[ FData[3][FData[4]] ];

	Frames[Frame][4] = FData[4] + Direction;
	local NextIndex = ((FData[4]-1)%#FData[3])+1
	local NextFrame = GameGUI[FData[1]].Main[FData[3][NextIndex]];
	
	for _,Button in pairs(GameGUI[FData[1]].Title.Nav:GetChildren()) do
		Button.Style = (Button.Name == NextFrame.Name and Enum.ButtonStyle.RobloxRoundDefaultButton) or Enum.ButtonStyle.RobloxRoundButton;
	end

	GameGUI[FData[1]].Title.Title.Text = CurrentExamine .. "'s " .. NextFrame.Name;

	NextFrame.Position = UDim2.new(Direction,0,0,0);
	CurrentFrame:TweenPosition(UDim2.new(-Direction,0,0,0),D,S,T,false);
	NextFrame:TweenPosition(UDim2.new(0,0,0,0),D,S,T,false);
	Frames[Frame][4] = NextIndex;
	game:GetService("GuiService").SelectedObject = (NextFrame.Items.ScrollFrame.Container:FindFirstChild("Slot0") and NextFrame.Items.ScrollFrame.Container:FindFirstChild("Slot0").Container.Button) or nil;
	wait(T);
		
	CanNavigate = true;
end

_G.Examine = function(Data,PlayerName)
	CurrentExamine = PlayerName;

	local Select = game:GetService("GuiService").SelectedObject;
	local SelectName,SelectFrame;
	if Select then
		SelectName = Select.Name;
		SelectFrame = Select.Parent;
	end;
	SortData(Data);
	for _,StuffName in pairs(Stuff) do
		CreateGrid(StuffName);
	end
	if SelectName and SelectFrame then
		game:GetService("GuiService").SelectedObject = SelectFrame[SelectName];
	end
	
	InventoryFrame.Title.Title.Text = CurrentExamine .. "'s Weapons";
	
	game:GetService("GuiService").SelectedObject = (
		InventoryFrame.Main.Weapons.Items.ScrollFrame.Container:FindFirstChild("Slot0") and InventoryFrame.Main.Weapons.Items.ScrollFrame.Container:FindFirstChild("Slot0").Container.Button
	) or nil;
	
	InventoryFrame:TweenPosition(UDim2.new(0,0,0,0),D,S,T,false);
	Bind("NoX",Enum.KeyCode.ButtonX,function()end);
	Bind("NoB",Enum.KeyCode.ButtonB,function()end);
	game.Players.LocalPlayer:WaitForChild("PlayerGui"):SetTopbarTransparency(0)
	
	Bind("NavRight",Enum.KeyCode.ButtonR1,function() Navigate(1,1) end)
	Bind("NavLeft",Enum.KeyCode.ButtonL1,function() Navigate(1,-1) end)
	
	GameGUI.Leaderboard.Visible = false;
	GameGUI.Chat.Visible = false;
	
	wait(T);
	Unbind("NoB");
	Bind("Close",Enum.KeyCode.ButtonB,function()
		Unbind("NoX");Unbind("NoB");Unbind("NavLeft");Unbind("NavRight");Unbind("BuyCrateBundle");
		InventoryFrame:TweenPosition(UDim2.new(0,0,-1,-36),D,S,T,false);
		game.Players.LocalPlayer:WaitForChild("PlayerGui"):SetTopbarTransparency(0.5)
		GameGUI.Leaderboard.Visible = true;
		GameGUI.Chat.Visible = true;	
		wait(T);
		Unbind("Close");
		game:GetService("GuiService").SelectedObject = GameGUI.Leaderboard.List.Player1.Container.Button;
	end);	
	
	
end;

