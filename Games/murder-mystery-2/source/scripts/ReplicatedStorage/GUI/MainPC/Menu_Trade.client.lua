local pService = game:GetService("PolicyService");
local SyncedData = {};
local Size;
local Position;
local LocalPlayer = game.Players.LocalPlayer;
function GetSyncData(DataName) 
	if SyncedData[DataName] == nil then
		SyncedData[DataName] = game.ReplicatedStorage.GetSyncData:InvokeServer(DataName);
	end
	return SyncedData[DataName];
end
game.ReplicatedStorage.UpdateSyncedData.OnClientEvent:connect(function(DataName,Data)
	SyncedData[DataName] = Data;
end)

local ItemData = GetSyncData("Item");
local PetData = GetSyncData("Pets");
local Rarity = GetSyncData("Rarity");

local Database = {
	Weapons = ItemData;
	Pets = PetData;
};

local function PrintTable(Table,Indent)
	local IndentString = "";
	for i = 1,Indent do
		IndentString = IndentString .. "--";
	end
	for Index,Value in pairs(Table) do
		if type(Value) == "table" then
			
			PrintTable(Value,Indent+1);
		else
			
		end;
	end
end

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

local success, err = pcall(function()
	return pService:GetPolicyInfoForPlayerAsync(LocalPlayer);
end)
if not success then

else
	local IsPaidItemTradingAllowed = err.IsPaidItemTradingAllowed;

	if not IsPaidItemTradingAllowed then
		return "Trading Not Allowed";
	end;
end;
----------------------------------------------------------------------

local MainGUI = script.Parent.Game;
local MainGUI2 = game.Players.LocalPlayer.PlayerGui
local TradeEvents = game.ReplicatedStorage.Trade;
local RequestFrame = MainGUI.Leaderboard.Container.TradeRequest;
local TradeGUI = MainGUI2.Trade
local InventoryFrame = TradeGUI.Container.Items.Main.Weapons.Items.Container.Current.Container;
local PetsFrame = TradeGUI.Container.Items.Main.Pets.Items.Container.Current.Container;

local function GetTradePlayers(Trade)
	if Trade["Player1"]["Player"] == game.Players.LocalPlayer then
		return "Player1","Player2";
	elseif Trade["Player2"]["Player"] == game.Players.LocalPlayer then
		return "Player2","Player1";
	end;
end

----------------------------

local function ShowRequest(Player2Name,IsSending)
	if not IsSending then
		RequestFrame.Accepting.Visible = false;
		RequestFrame.Sending.Visible = true;
		RequestFrame.Sending.Username.Text = Player2Name 
		TradeGUI.Container.Trade.Offer2.Username.Text = "("..Player2Name .. ")"
        MainGUI.Leaderboard.Inspect.Username.Text = Player2Name
	else
		RequestFrame.Accepting.Visible = true;
		RequestFrame.Sending.Visible = false;
		RequestFrame.Accepting.Username.Text = Player2Name
		TradeGUI.Container.Trade.Offer2.Username.Text = "("..Player2Name .. ")"
	end;
	RequestFrame.Visible = true;
	TradeGUI.Container.Trade.Offer2.Username.Text = "("..Player2Name .. ")"
end





local Connections = {};
local CooldownRunning = false;
local Cooldown = 6;
function ResetCooldown()
	TradeGUI.Container.Trade.Offer2.Accepted.Visible = false;
	Cooldown = 6;
	TradeGUI.Container.Trade.Actions.Accept.Cooldown.Title.Text = " Please wait (" .. Cooldown .. ") before accepting.";
	if not CooldownRunning then
		TradeGUI.Container.Trade.Actions.Accept.Cooldown.Visible = true;
		CooldownRunning = true;
		repeat 
			wait(1)
			Cooldown = Cooldown - 1;
			TradeGUI.Container.Trade.Actions.Accept.Cooldown.Title.Text = " Please wait (" .. Cooldown .. ") before accepting.";
		until Cooldown <= 0;
		CooldownRunning = false;
		TradeGUI.Container.Trade.Actions.Accept.Cooldown.Visible = false;
	else
		Cooldown = 6;
	end
end



local function UpdateTrade(Trade)
	RequestFrame.Visible = false;
	TradeGUI.Container.Trade.Actions.Accept.Cancel.Visible = false
	MainGUI2.Trade.Container.Trade.Offer2.Accepted.Visible = false;
	MainGUI2.Trade.Container.Trade.Offer1.Accepted.Visible = false;

	for _,Frame in pairs(TradeGUI.Container.Trade.Offer1.Container:GetChildren()) do 	if Frame:IsA("Frame") then Frame.Container.Icon.Image = ""; Frame.ItemName.Label.Text = ""; Frame.Container.Amount.Text = ""; Frame.ItemName.Visible = false; Frame.Visible = false; end end
	for _,Frame in pairs(TradeGUI.Container.Trade.Offer2.Container:GetChildren()) do 	if Frame:IsA("Frame") then Frame.Container.Icon.Image = ""; Frame.ItemName.Label.Text = ""; Frame.Container.Amount.Text = ""; Frame.ItemName.Visible = false; Frame.Visible = false; end end
    	
	for _,Con in pairs(Connections) do Con:disconnect() end;
		
	
	if Trade then
		TradeGUI.Enabled = true;
      --[[ local Layout = script.OfferLayout:Clone()
        Layout.Parent = TradeGUI.Container.Trade.Offer1.Container
        local Layout2 = script.OfferLayout:Clone()
        Layout2.Parent = TradeGUI.Container.Trade.Offer2.Container[[]]
		local MyPlayer,TheirPlayer = GetTradePlayers(Trade);
		local MyOffers = Trade[MyPlayer]["Offer"];
		local TheirOffers = Trade[TheirPlayer]["Offer"];
		
		for i,OfferTable in pairs(MyOffers) do
			local DB = Database[OfferTable[3]];
			TradeGUI.Container.Trade.Offer1.Container["NewItem" .. i].Visible = true
			TradeGUI.Container.Trade.Offer1.Container["NewItem" .. i].Container.Icon.Image = GetImage( DB[OfferTable[1]]["Image"] );
			TradeGUI.Container.Trade.Offer1.Container["NewItem" .. i].ItemName.Label.Text = DB[OfferTable[1]]["ItemName"] or DB[OfferTable[1]]["Name"];
			TradeGUI.Container.Trade.Offer1.Container["NewItem" .. i].ItemName.BackgroundColor3 = Rarity[DB[OfferTable[1]]["Rarity"]];
			TradeGUI.Container.Trade.Offer1.Container["NewItem" .. i].Container.Amount.Text = "x" .. OfferTable[2];
            TradeGUI.Container.Trade.Offer1.Container["NewItem" .. i].ItemName.Visible = true;
			if DB[OfferTable[1]]["Chroma"] ~= nil then
				TradeGUI.Container.Trade.Offer1.Container["NewItem" .. i].Tags.Chroma.Visible = true
            else
				TradeGUI.Container.Trade.Offer1.Container["NewItem" .. i].Tags.Chroma.Visible = false;
            end
			if DB[OfferTable[1]]["Common"] ~= nil then
				TradeGUI.Container.Trade.Offer1.Container["NewItem" .. i].ItemName.BackgroundColor3 = Color3.new(0.415686, 0.415686, 0.415686)
			end
			if OfferTable[2] == 1 or OfferTable[2] == "1"  then
				TradeGUI.Container.Trade.Offer1.Container["NewItem" .. i].Container.Amount.Text = ""
			end
                
			table.insert(Connections,TradeGUI.Container.Trade.Offer1.Container["NewItem" .. i].Container.ActionButton.MouseButton1Click:connect(function()
				TradeEvents.RemoveOffer:FireServer(OfferTable[1],OfferTable[3]);
                TradeGUI.Container.Trade.Offer1.Container["NewItem" .. i].Visible = false;
				TradeGUI.Container.Trade.Offer1.Container["NewItem" .. i].Tags.Chroma.Visible = false;

				if Rarity[DB[OfferTable[1]]["Rarity"]] == "Common" then
					TradeGUI.Container.Trade.Offer1.Container["NewItem" .. i].ItemName.BackgroundColor3 = Color3.new(0.415686, 0.415686, 0.415686)
				end
				if OfferTable[1] == 1 then
					TradeGUI.Container.Trade.Offer1.Container["NewItem" .. i].Container.Amount.Text = ""
				end
			end));
		end
		
		for i,OfferTable in pairs(TheirOffers) do
			local DB = Database[OfferTable[3]];
			TradeGUI.Container.Trade.Offer2.Container["NewItem" .. i].Container.Icon.Image = GetImage(DB[OfferTable[1]]["Image"]);
			TradeGUI.Container.Trade.Offer2.Container["NewItem" .. i].ItemName.Label.Text = DB[OfferTable[1]]["ItemName"] or DB[OfferTable[1]]["Name"];
			TradeGUI.Container.Trade.Offer2.Container["NewItem" .. i].ItemName.BackgroundColor3 = Rarity[DB[OfferTable[1]]["Rarity"]];
			TradeGUI.Container.Trade.Offer2.Container["NewItem" .. i].Container.Amount.Text = "x" .. OfferTable[2];
            TradeGUI.Container.Trade.Offer2.Container["NewItem" .. i].Visible = true;
            TradeGUI.Container.Trade.Offer2.Container["NewItem" .. i].ItemName.Visible = true;
			if DB[OfferTable[1]]["Chroma"] ~= nil then
				TradeGUI.Container.Trade.Offer2.Container["NewItem" .. i].Tags.Chroma.Visible = true
            else
				TradeGUI.Container.Trade.Offer2.Container["NewItem" .. i].Tags.Chroma.Visible = false;
			end
			if DB[OfferTable[1]]["Common"] ~= nil then
				TradeGUI.Container.Trade.Offer2.Container["NewItem" .. i].ItemName.BackgroundColor3 = Color3.new(0.415686, 0.415686, 0.415686)
			end
			--0.415686, 0.415686, 0.415686
			if Rarity[DB[OfferTable[1]]["Rarity"]] == "Common" or TradeGUI.Container.Trade.Offer2.Container["NewItem" .. i].ItemName.BackgroundColor3 == Color3.new(255,255,255) then
				TradeGUI.Container.Trade.Offer2.Container["NewItem" .. i].ItemName.BackgroundColor3 = Color3.new(0.415686, 0.415686, 0.415686)
            end
			if OfferTable[2] == 1 then
				TradeGUI.Container.Trade.Offer2.Container["NewItem" .. i].Container.Amount.Text = ""
		end
	end	
     
		spawn(ResetCooldown);
	else
		_G.DisplayOrder = game.Players.LocalPlayer.PlayerGui.Chat.DisplayOrder
		_G.Size = game.Players.LocalPlayer.PlayerGui.Chat.Frame.Size
		_G.Position = game.Players.LocalPlayer.PlayerGui.Chat.Frame.Position
		game.Players.LocalPlayer.PlayerGui.Chat.DisplayOrder = TradeGUI.DisplayOrder + 1
		game.Players.LocalPlayer.PlayerGui.Chat.Frame.Size = UDim2.new(0,TradeGUI.Container.Chat.AbsoluteSize.X,0,TradeGUI.Container.Chat.AbsoluteSize.Y)
		game.Players.LocalPlayer.PlayerGui.Chat.Frame.Position = UDim2.new(0,TradeGUI.Container.Chat.AbsolutePosition.X,0,TradeGUI.Container.Chat.AbsolutePosition.Y)
		TradeGUI.Enabled = true;
		UpdateInventory();
	end;
end

TradeEvents.DeclineTrade.OnClientEvent:connect(function()
	game.Players.LocalPlayer.PlayerGui.Chat.Frame.Size = _G.Size
	game.Players.LocalPlayer.PlayerGui.Chat.Frame.Position = _G.Position
	game.Players.LocalPlayer.PlayerGui.Chat.DisplayOrder = _G.DisplayOrder
	TradeGUI.Enabled = false;
end)



RequestFrame.Accepting.Accept.MouseButton1Click:connect(function()
	TradeEvents.AcceptRequest:FireServer();
end)

RequestFrame.Accepting.Decline.MouseButton1Click:connect(function()
	TradeEvents.DeclineRequest:FireServer();
	RequestFrame.Visible = false;
end)

TradeEvents.DeclineRequest.OnClientEvent:connect(function()
	RequestFrame.Visible = false;
end)

RequestFrame.Sending.Cancel.MouseButton1Click:connect(function()
	TradeEvents.CancelRequest:FireServer();
	RequestFrame.Visible = false;
end)

TradeEvents.CancelRequest.OnClientEvent:connect(function()
	RequestFrame.Visible = false;
end)

TradeGUI.Container.Trade.Actions.Accept.Cancel.ActionButton.MouseButton1Click:connect(function()
	    TradeGUI.Container.Trade.Offer1.Accepted.Visible = false;
		TradeGUI.Container.Trade.Actions.Accept.Confirm.Visible = false;
		TradeGUI.Container.Trade.Actions.Accept.Confirm.Active = false;
	    TradeGUI.Container.Trade.Actions.Accept.Cancel.Visible = false;
		TradeEvents.CancelTrade:FireServer();
end)


TradeEvents.CancelTrade.OnClientEvent:connect(function()
	TradeGUI.Container.Trade.Actions.Accept.Cancel.Visible = false;
end)


game:GetService("UserInputService").InputBegan:connect(function(Input)
	local B = Input.KeyCode;
	if B == Enum.KeyCode.DPadRight and MainGUI.Leaderboard.Inspect.Visible then
		if _G.MenuPlayer ~= game.Players.LocalPlayer then
			local IsBusy = TradeEvents.SendRequest:InvokeServer(_G.MenuPlayer);
			if not IsBusy then
				ShowRequest(_G.MenuPlayer.Name,false);
			end
		end;
	end
end)

function game.ReplicatedStorage.CheckClient.OnClientInvoke()
	return 5;
end;

MainGUI.Leaderboard.Inspect.Trade.MouseButton1Click:connect(function()
	MainGUI.Leaderboard.Inspect.Visible = false
	if _G.MenuPlayer ~= game.Players.LocalPlayer then
		local IsBusy = TradeEvents.SendRequest:InvokeServer(_G.MenuPlayer);
		if not IsBusy then
			ShowRequest(_G.MenuPlayer.Name,false);
		end
	end;
end)

function TradeEvents.SendRequest.OnClientInvoke(Player1)
	if _G.RequestsEnabled then
		ShowRequest(Player1.Name,true);
	end;
	return _G.RequestsEnabled;
end;


TradeEvents.UpdateTrade.OnClientEvent:connect(UpdateTrade);

TradeEvents.StartTrade.OnClientEvent:connect(function()
	UpdateTrade();
end)

TradeEvents.AcceptTrade.OnClientEvent:connect(function(TradeComplete)
	if TradeComplete then
		game.Players.LocalPlayer.PlayerGui.Chat.Frame.Size = _G.Size
		game.Players.LocalPlayer.PlayerGui.Chat.Frame.Position = _G.Position
		game.Players.LocalPlayer.PlayerGui.Chat.DisplayOrder = _G.DisplayOrder
		TradeGUI.Enabled = false;
	else
		TradeGUI.Container.Trade.Offer2.Accepted.Visible = true;
	end;
end)

TradeGUI.Container.Trade.Actions.Decline.ActionButton.MouseButton1Click:connect(function()
	TradeEvents.DeclineTrade:FireServer();
end)



local LastAccept = time();
TradeGUI.Container.Trade.Actions.Accept.ActionButton.MouseButton1Click:connect(function()
	if CooldownRunning == false and time()-LastAccept >=1 and not MainGUI2.Trade.Container.Trade.Actions.Accept.Cooldown.Visible then
		LastAccept = time();
		TradeGUI.Container.Trade.Actions.Accept.Confirm.Visible = true;
		TradeGUI.Container.Trade.Actions.Accept.Confirm.Active = true;
	end;
end)

TradeGUI.Container.Trade.Actions.Accept.Confirm.ActionButton.MouseButton1Click:connect(function() 
	if CooldownRunning == false and time()-LastAccept >=1 and not MainGUI2.Trade.Container.Trade.Actions.Accept.Cooldown.Visible and TradeGUI.Container.Trade.Actions.Accept.Confirm.Visible then
		LastAccept = time();
		MainGUI2.Trade.Container.Trade.Offer1.Accepted.Visible = true;
		TradeGUI.Container.Trade.Actions.Accept.Confirm.Visible = false;
		TradeGUI.Container.Trade.Actions.Accept.Confirm.Active = false;
		TradeGUI.Container.Trade.Actions.Accept.Cancel.Active = true;
		TradeGUI.Container.Trade.Actions.Accept.Cancel.Visible = true;
		TradeEvents.AcceptTrade:FireServer();
	end;
end)


local TradeStatus,Data = game.ReplicatedStorage.GetTradeStatus:InvokeServer();
if TradeStatus == "StartTrade" then
	UpdateTrade(Data);
elseif TradeStatus == "ShowRequest" then
	ShowRequest(Data,false);
elseif TradeStatus == "SendRequest" then
	ShowRequest(Data,true)
end




local RarityValue = {
	["Classic"] = 1;
	["Common"] = 2;
	["Uncommon"] = 3; 
	["Rare"] = 4;
	["Legendary"] = 5;
	["Godly"] = 6;
	["GodIy"] = 6;
	["Victim"] = 7;
	["Giveaways"] = 8;
	["Ancient"] = 6.5;
	["Mythic"] = 6.6;
	["Dream"] = 6.8;
	["Custom"] = 10;
	["Unique"] = 11;
	["Christmas"] = 1.6;
	["Halloween"] = 1.5;
	["Bussiness"] = 12;
};



function UpdateInventory()
	local SyncItems = GetSyncData("Item");
	local Pets = GetSyncData("Pets");

    InventoryFrame:ClearAllChildren();
	PetsFrame:ClearAllChildren();
	local InventoryTable = _G.PlayerData.Weapons;
	local Inventory = {};
	
	local PetTable = _G.PlayerData.Pets;
	local PetInventory = {};
	
	for ItemName,Amount in pairs(InventoryTable.Owned) do 
		table.insert(Inventory,{
			["ItemName"] = ItemName;
			["Amount"] = Amount;
		})
	end
	
	for ItemName,Amount in pairs(PetTable.Owned) do 
		table.insert(PetInventory,{
			["ItemName"] = ItemName;
			["Amount"] = Amount;
		})
	end


	
	table.sort(PetInventory,function(Item1,Item2)
		if RarityValue[Pets[Item1["ItemName"]]["Rarity"]] ~= RarityValue[Pets[Item2["ItemName"]]["Rarity"]] then
			return (RarityValue[Pets[Item1["ItemName"]]["Rarity"]] > RarityValue[Pets[Item2["ItemName"]]["Rarity"]]);
		else
			return (Item1["Amount"] > Item2["Amount"]);
		end
	end)
	
	table.sort(Inventory,function(Item1,Item2)
		if Item1["ItemName"] == "DefaultKnife" then
			return true;
		elseif Item2["ItemName"] == "DefaultKnife" then
			return false;
		elseif Item1["ItemName"] == "DefaultGun" then
			return true;
		elseif Item2["ItemName"] == "DefaultGun" then
			return false;
		end;
		
		if RarityValue[SyncItems[Item1["ItemName"]]["Rarity"]] ~= RarityValue[SyncItems[Item2["ItemName"]]["Rarity"]] then
			return (RarityValue[SyncItems[Item1["ItemName"]]["Rarity"]] > RarityValue[SyncItems[Item2["ItemName"]]["Rarity"]]);
		else
			return (Item1["Amount"] > Item2["Amount"]);
		end
	end)
	
	for _,iData in pairs(Inventory) do
		local ItemName = iData["ItemName"];
		local Amount = iData["Amount"];
		local CurrentItemData = GetSyncData("Item")[ItemName];

       local gridLayout = script.TradeGridLayout:Clone()
        gridLayout.Parent = InventoryFrame
		local NewSlot = script.Item:Clone();
		NewSlot.Parent = InventoryFrame
		NewSlot.Container.Icon.Image = CurrentItemData["Image"];
		NewSlot.ItemName.Label.Text = GetSyncData("Item")[ItemName]["ItemName"];
		NewSlot.Name = GetSyncData("Item")[ItemName]["ItemName"];
		NewSlot.ItemName.BackgroundColor3 = GetSyncData("Rarity")[CurrentItemData["Rarity"]];
		if CurrentItemData.Rarity == "Common" then 
			NewSlot.ItemName.BackgroundColor3 = Color3.new(0.415686, 0.415686, 0.415686)
		end
		if CurrentItemData.Leaderboard then
			NewSlot.Tags.Unique.PlayerName.Text = game.Players.LocalPlayer.Name .. "'s"
		end
		if NewSlot.Name == "NERFGUN2" or NewSlot.Name == "NERFGUN" then
           NewSlot.Tags.Unique.PlayerName.Text = game.Players.LocalPlayer.Name .. "'s"
        end
        if CurrentItemData.Chroma ~= nil then
			NewSlot.Tags.Chroma.Visible = true
		end
		if Amount > 1 then
			NewSlot.Container.Amount.Text = "x" .. Amount;
			NewSlot.Visible = true;
		elseif Amount == 1 then
			NewSlot.Container.Amount.Text = "";
			NewSlot.Visible = true;
		end
	

		NewSlot.Container.Button.MouseButton1Click:connect(function()
			TradeEvents.OfferItem:FireServer(ItemName,"Weapons");
			TradeGUI.Container.Trade.Actions.Accept.Confirm.Visible = false;
			TradeGUI.Container.Trade.Actions.Accept.Confirm.Active = false;
           
		end)
		InventoryFrame.Parent.CanvasSize = UDim2.new(0, 0, 0, gridLayout.AbsoluteContentSize.Y)
	end

	for _,iData in pairs(PetInventory) do
		local ItemName = iData["ItemName"];
		local Amount = iData["Amount"];
		local CurrentItemData = Pets[ItemName];

		local gridLayout = script.TradeGridLayout:Clone()
		gridLayout.Parent = PetsFrame
		local NewSlot = script.Item:Clone();
		NewSlot.Parent = PetsFrame;
		NewSlot.Container.Icon.Image = GetImage(CurrentItemData["Image"]);
		NewSlot.ItemName.Label.Text = Pets[ItemName].Name
		NewSlot.Name = Pets[ItemName].Name
		NewSlot.ItemName.BackgroundColor3 = GetSyncData("Rarity")[CurrentItemData["Rarity"]];
		if CurrentItemData.Rarity == "Common" then 
			NewSlot.ItemName.BackgroundColor3 = Color3.new(0.415686, 0.415686, 0.415686)
		end
		if CurrentItemData.Chroma ~= nil then
			NewSlot.Tags.Chroma.Visible = true
		end
		if CurrentItemData.EvoBaseID ~= nil then
			NewSlot.Tags.Evo.Visible = true
		end
		if Amount > 1 then
		NewSlot.Container.Amount.Text = "x" .. Amount;
        NewSlot.Visible = true;
		elseif Amount == 1 then
         NewSlot.Container.Amount.Text = "";
         NewSlot.Visible = true;
        end
		NewSlot.Container.Button.MouseButton1Click:connect(function()
			TradeEvents.OfferItem:FireServer(ItemName,"Pets");
			TradeGUI.Container.Trade.Actions.Accept.Confirm.Visible = false;
			TradeGUI.Container.Trade.Actions.Accept.Confirm.Active = false;
		end)
	end
end

local PetsButton = TradeGUI.Container.Items.Tabs.Pets.View;
local WeaponsButton = TradeGUI.Container.Items.Tabs.Weapons.View;

local RequestsFrame = MainGUI.Leaderboard.Container.ToggleRequests
if _G.RequestsEnabled == nil then
	_G.RequestsEnabled = true;
end

RequestsFrame.On.Visible = _G.RequestsEnabled;
RequestsFrame.Off.Visible = (not _G.RequestsEnabled);

RequestsFrame.On.MouseButton1Click:connect(function()
	RequestsFrame.On.Visible = false;
	RequestsFrame.Off.Visible = true;
	_G.RequestsEnabled = false;
	TradeEvents.DeclineRequest:FireServer();
	RequestFrame.Visible = false;
end)
RequestsFrame.Off.MouseButton1Click:connect(function()
	RequestsFrame.On.Visible = true;
	RequestsFrame.Off.Visible = false;
	_G.RequestsEnabled = true;
	TradeEvents.DeclineRequest:FireServer();
	RequestFrame.Visible = false;
end)



PetsButton.MouseButton1Click:connect(function()
	PetsButton.Parent.ViewBorder.Visible = true;
	WeaponsButton.Parent.DontView.Visible = true;
    WeaponsButton.Parent.ViewBorder.Visible = false;
	PetsFrame.Parent.Visible = true;
	InventoryFrame.Parent.Visible = false;
end)
WeaponsButton.MouseButton1Click:connect(function()
	WeaponsButton.Parent.ViewBorder.Visible = true;
    PetsButton.Parent.ViewBorder.Visible = false;
    PetsButton.Parent.DontView.Visible = true;
	PetsFrame.Parent.Visible = false;
	InventoryFrame.Parent.Visible = true;
end)


local searchBar = TradeGUI.Container.Items.Tabs.Search.Container.SearchText
local items = InventoryFrame.Parent

local scrollingframe=InventoryFrame.Parent
local searchbar= TradeGUI.Container.Items.Tabs.Search.Container.SearchText
function UpdateInputOfSearchText()
	local InputText=string.upper(searchbar.Text)
	for _,button in pairs(scrollingframe.Container:GetChildren())do
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


local searchBar = TradeGUI.Container.Items.Tabs.Search.Container.SearchText
local items = InventoryFrame.Parent

local scrollingframe=PetsFrame.Parent
local searchbar= TradeGUI.Container.Items.Tabs.Search.Container.SearchText
function UpdateInputOfSearchTextPets()
	local InputText=string.upper(searchbar.Text)
	for _,button in pairs(scrollingframe.Container:GetChildren())do
		if button:IsA("Frame")then
			if InputText==""or string.find(string.upper(button.Name),InputText)~=nil then
				button.Visible=true
				PetsFrame.Parent.CanvasPosition = Vector2.new(0, 0);
			else
				button.Visible=false
				PetsFrame.Parent.CanvasPosition = Vector2.new(0, 0);
			end
		end
	end
end
searchbar.Changed:Connect(UpdateInputOfSearchTextPets)

UpdateInventory();
