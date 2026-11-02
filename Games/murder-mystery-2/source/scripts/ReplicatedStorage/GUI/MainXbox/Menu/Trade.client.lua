local SyncedData = {};
function GetSyncData(DataName) 
	if SyncedData[DataName] == nil then
		SyncedData[DataName] = game.ReplicatedStorage.GetSyncData:InvokeServer(DataName);
	end
	return SyncedData[DataName];
end
game.ReplicatedStorage.UpdateSyncedData.OnClientEvent:connect(function(DataName,Data)
	SyncedData[DataName] = Data;
end)

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
			print(IndentString .. Index .. "{");
			PrintTable(Value,Indent+1);
		else
			print(IndentString .. Index .. ": " .. tostring(Value))
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
----------------------------------------------------------------------

local MainGUI = script.Parent.Parent;
local TradeEvents = game.ReplicatedStorage.Trade;
local RequestFrame = MainGUI.Leaderboard.Trade.Request;
local TradeGUI = MainGUI.Trade;

local function GetTradePlayers(Trade)
	if Trade["Player1"]["Player"] == game.Players.LocalPlayer then
		return "Player1","Player2";
	elseif Trade["Player2"]["Player"] == game.Players.LocalPlayer then
		return "Player2","Player1";
	end;
end
----------------------------

local HasSentRequest = false;
local function ShowRequest(Player2Name,IsSending)
	if not IsSending then
		HasSentRequest = true;
		RequestFrame.Title.Text = "Waiting for " .. Player2Name .. " to respond."
	else
		HasSentRequest = false;
		RequestFrame.Title.Text = Player2Name .. " wants to trade."
	end;
	MainGUI.Leaderboard.Trade.Request.Visible = true;
	for _,Frame in pairs(MainGUI.Leaderboard.List:GetChildren()) do
		if Frame.Container.Response.Visible then
			Frame.Container.Response.Visible = false;
		end;
	end
end

_G.ShowRequest = ShowRequest;

local Connections = {};
local CooldownRunning = false;
local Cooldown = 5;

function ResetCooldown()
	MainGUI.Trade.Offers.Accept.TradeAccepted.Visible = false;
	Cooldown = 5;
	MainGUI.Trade.Offers.Accept.Cooldown.Text = "(" .. Cooldown .. ")";
	if not CooldownRunning then
		MainGUI.Trade.Offers.Accept.Cooldown.Visible = true;
		CooldownRunning = true;
		repeat 
			wait(1)
			Cooldown = Cooldown - 1;
			MainGUI.Trade.Offers.Accept.Cooldown.Text = "(" .. Cooldown .. ")";
		until Cooldown <= 0;
		CooldownRunning = false;
		MainGUI.Trade.Offers.Accept.Cooldown.Visible = false;
	else
		Cooldown = 5;
	end
end

local ShowPets = false;

local function UpdateTrade(Trade)
	
	RequestFrame.Visible = false;	
	TradeGUI.Offers.Accept.TradeAccepted.Visible = false;
	TradeGUI.Offers.Accept.Waiting.Visible = false;

	for _,Frame in pairs(TradeGUI.Offers.OfferContainer.Offer1:GetChildren()) do if Frame.Name~="OfferLabel" then Frame.Container.Icon.Image = ""; Frame.Container.ItemName.Text = ""; Frame.Container.Amount.Text = ""; end end
	for _,Frame in pairs(TradeGUI.Offers.OfferContainer.Offer2:GetChildren()) do if Frame.Name~="OfferLabel" then Frame.Container.Icon.Image = ""; Frame.Container.ItemName.Text = ""; Frame.Container.Amount.Text = ""; end end	
	for _,Con in pairs(Connections) do Con:disconnect() end;
		
	
	if Trade then
		TradeGUI.Visible = true;

		local MyPlayer,TheirPlayer = GetTradePlayers(Trade);
		local MyOffers = Trade[MyPlayer]["Offer"];
		local TheirOffers = Trade[TheirPlayer]["Offer"];
		
		for i,OfferTable in pairs(MyOffers) do
			local DB = Database[OfferTable[3]];
			TradeGUI.Offers.OfferContainer.Offer1["Slot" .. i].Container.Icon.Image = GetImage( DB[OfferTable[1]]["Image"] );
			TradeGUI.Offers.OfferContainer.Offer1["Slot" .. i].Container.ItemName.Text = DB[OfferTable[1]]["ItemName"] or DB[OfferTable[1]]["Name"];
			TradeGUI.Offers.OfferContainer.Offer1["Slot" .. i].Container.ItemName.TextColor3 = Rarity[DB[OfferTable[1]]["Rarity"]];
			TradeGUI.Offers.OfferContainer.Offer1["Slot" .. i].Container.Amount.Text = "x" .. OfferTable[2];
			table.insert(Connections,TradeGUI.Offers.OfferContainer.Offer1["Slot" .. i].Container.Button.MouseButton1Click:connect(function()
				TradeEvents.RemoveOffer:FireServer(OfferTable[1],OfferTable[3]);
			end));
		end
		
		for i,OfferTable in pairs(TheirOffers) do
			local DB = Database[OfferTable[3]];
			TradeGUI.Offers.OfferContainer.Offer2["Slot" .. i].Container.Icon.Image = GetImage(DB[OfferTable[1]]["Image"]);
			TradeGUI.Offers.OfferContainer.Offer2["Slot" .. i].Container.ItemName.Text = DB[OfferTable[1]]["ItemName"] or DB[OfferTable[1]]["Name"];
			TradeGUI.Offers.OfferContainer.Offer2["Slot" .. i].Container.ItemName.TextColor3 = Rarity[DB[OfferTable[1]]["Rarity"]];
			TradeGUI.Offers.OfferContainer.Offer2["Slot" .. i].Container.Amount.Text = "x" .. OfferTable[2];
		end
		
		spawn(ResetCooldown);
	else
		MainGUI.Leaderboard.Visible = false;
			
		Bind("ToggleItemType",Enum.KeyCode.ButtonY,function()
			ShowPets = not ShowPets;
			TradeGUI.YourItems.Pets.Style = (ShowPets and Enum.ButtonStyle.RobloxRoundDefaultButton) or Enum.ButtonStyle.RobloxRoundButton;
			TradeGUI.TheirItems.Pets.Style = (ShowPets and Enum.ButtonStyle.RobloxRoundDefaultButton) or Enum.ButtonStyle.RobloxRoundButton;
			TradeGUI.YourItems.Weapons.Style = (ShowPets and Enum.ButtonStyle.RobloxRoundButton) or Enum.ButtonStyle.RobloxRoundDefaultButton
			TradeGUI.TheirItems.Weapons.Style = (ShowPets and Enum.ButtonStyle.RobloxRoundButton) or Enum.ButtonStyle.RobloxRoundDefaultButton
			
			TradeGUI.YourItems.PetsFrame.Visible = ShowPets;
			TradeGUI.YourItems.Items.Visible = not ShowPets;
			
			TradeGUI.TheirItems.PetsFrame.Visible = ShowPets;
			TradeGUI.TheirItems.Items.Visible = not ShowPets;
			
			game:GetService("GuiService").SelectedObject = TradeGUI.YourItems[(ShowPets and "PetsFrame") or "Items"].Container.Slot1.Container.Button;
		end);
		Bind("TradeNoB",Enum.KeyCode.ButtonB,function()end)
		Bind("TradeChat",Enum.KeyCode.ButtonL3,function() MainGUI.Chat.ChatBox:CaptureFocus(); end);
		TradeGUI.Visible = true;
		
		UpdateInventory("YourItems",_G.PlayerData.Weapons.Owned,_G.PlayerData.Pets.Owned);

		game:GetService("GuiService").SelectedObject = TradeGUI.YourItems.Items.Container.Slot1.Container.Button;
		
		local _,tData = game.ReplicatedStorage.GetTradeStatus:InvokeServer();
		local MyPlayer,TheirPlayer = GetTradePlayers(tData);
		local OtherPlayer = tData[TheirPlayer].Player;
		local OtherInv = game.ReplicatedStorage.GetFullInventory:InvokeServer(OtherPlayer);
		UpdateInventory("TheirItems",OtherInv.Weapons.Owned,OtherInv.Pets.Owned);

		
				
		
	end;
end

TradeEvents.DeclineTrade.OnClientEvent:connect(function()
	TradeGUI.Visible = false;
	MainGUI.Leaderboard.Visible = true;
	Unbind("TradeNoB")
	Unbind("TradeChat");
	game:GetService("GuiService").SelectedObject = MainGUI.Leaderboard.List.Player1.Container.Button;
end)

--[[RequestFrame.Accepting.Accept.MouseButton1Click:connect(function()
	TradeEvents.AcceptRequest:FireServer();
	MainGUI.Leaderboard.Trade.Request.Visible = false;
	MainGUI.Leaderboard.Trade.Request.Response.Visible = false;
end)

RequestFrame.Accepting.Decline.MouseButton1Click:connect(function()
	TradeEvents.DeclineRequest:FireServer();
	MainGUI.Leaderboard.Trade.Request.Visible = false;
	MainGUI.Leaderboard.Trade.Request.Response.Visible = false;
end)]]

TradeEvents.DeclineRequest.OnClientEvent:connect(function()
	MainGUI.Leaderboard.Trade.Request.Visible = false;
	MainGUI.Leaderboard.Trade.Request.Response.Visible = false;
	_G.Chatted("Server","Your trade request was declined.");
end)

--[[RequestFrame.Sending.Cancel.MouseButton1Click:connect(function()
	TradeEvents.CancelRequest:FireServer();
	MainGUI.Leaderboard.Trade.Request.Visible = false;
	MainGUI.Leaderboard.Trade.Request.Response.Visible = false;
end)]]

TradeEvents.CancelRequest.OnClientEvent:connect(function()
	MainGUI.Leaderboard.Trade.Request.Visible = false;
	MainGUI.Leaderboard.Trade.Request.Response.Visible = false;
end)


--[[game:GetService("UserInputService").InputBegan:connect(function(Input)
	local B = Input.KeyCode;
	if B == Enum.KeyCode.DPadRight and MainGUI.PlayerMenu.Visible then
		if _G.MenuPlayer ~= game.Players.LocalPlayer then
			local IsBusy = TradeEvents.SendRequest:InvokeServer(_G.MenuPlayer);
			if not IsBusy then
				ShowRequest(_G.MenuPlayer.Name,false);
			end
		end;
	end
end)]]

--[[MainGUI.PlayerMenu.Trade.MouseButton1Click:connect(function()
	if _G.MenuPlayer ~= game.Players.LocalPlayer then
		local IsBusy = TradeEvents.SendRequest:InvokeServer(_G.MenuPlayer);
		if not IsBusy then
			ShowRequest(_G.MenuPlayer.Name,false);
		end
	end;
end)]]

function TradeEvents.SendRequest.OnClientInvoke(Player1)
	if _G.RequestsEnabled then
		ShowRequest(Player1.Name,true);
		_G.Chatted("Server",Player1.Name .. " has sent you a trade request.");
	end;
	return _G.RequestsEnabled;
end;

TradeEvents.UpdateTrade.OnClientEvent:connect(UpdateTrade);

TradeEvents.StartTrade.OnClientEvent:connect(function()
	UpdateTrade();
	MainGUI.Leaderboard.Trade.Request.Visible = false;
	MainGUI.Leaderboard.Trade.Request.Response.Visible = false;
end)



TradeEvents.AcceptTrade.OnClientEvent:connect(function(TradeComplete)
	if TradeComplete then
		TradeGUI.Visible = false;
		MainGUI.Leaderboard.Visible = true;
		Unbind("TradeNoB")
		Unbind("TradeChat");
	else
		TradeGUI.Offers.Accept.TradeAccepted.Visible = true;
	end;
end)

TradeGUI.Offers.Decline.MouseButton1Click:connect(function()
	TradeEvents.DeclineTrade:FireServer();
end)

local RequestConnection;

MainGUI.Leaderboard.Trade.Toggle.SelectionGained:connect(function()
	if MainGUI.Leaderboard.Trade.Request.Visible and (not HasSentRequest) then
		
		MainGUI.Leaderboard.Trade.Request.Response.Visible = true;
		
		RequestConnection = game:GetService("UserInputService").InputBegan:connect(function(Input)
			if Input.KeyCode == Enum.KeyCode.DPadLeft and MainGUI.Leaderboard.Trade.Request.Visible and (not MainGUI.Chat.Control.Visible) then
				if RequestConnection then RequestConnection:disconnect(); end;
				MainGUI.Leaderboard.Trade.Request.Visible = false;
				MainGUI.Leaderboard.Trade.Request.Response.Visible = false;
				TradeEvents.AcceptRequest:FireServer();
				game:GetService("GuiService").SelectedObject = nil;
			elseif Input.KeyCode == Enum.KeyCode.DPadRight and MainGUI.Leaderboard.Trade.Request.Visible  and (not MainGUI.Chat.Control.Visible) then
				if RequestConnection then RequestConnection:disconnect(); end;
				game:GetService("GuiService").SelectedObject = MainGUI.Leaderboard.List.Player1.Container.Button;
				MainGUI.Leaderboard.Trade.Request.Visible = false;
				MainGUI.Leaderboard.Trade.Request.Response.Visible = false;
				TradeEvents.DeclineRequest:FireServer();
			end;
		end)
		
		--[[Bind("AcceptRequest",Enum.KeyCode.DPadLeft,function()
			MainGUI.Leaderboard.Trade.Request.Visible = false;
			MainGUI.Leaderboard.Trade.Request.Response.Visible = false;
			TradeEvents.AcceptRequest:FireServer();
		end)
		
		Bind("DeclineRequest",Enum.KeyCode.DPadRight,function()
			MainGUI.Leaderboard.Trade.Request.Visible = false;
			MainGUI.Leaderboard.Trade.Request.Response.Visible = false;
			TradeEvents.DeclineRequest:FireServer();
		end)]]
		
	elseif MainGUI.Leaderboard.Trade.Request.Visible  and HasSentRequest then
		MainGUI.Leaderboard.Trade.Request.Cancel.Visible = true;
		
		RequestConnection = game:GetService("UserInputService").InputBegan:connect(function(Input)
			if Input.KeyCode == Enum.KeyCode.DPadRight and MainGUI.Leaderboard.Trade.Request.Visible then
				if RequestConnection then RequestConnection:disconnect(); end;
				game:GetService("GuiService").SelectedObject = MainGUI.Leaderboard.List.Player1.Container.Button;
				MainGUI.Leaderboard.Trade.Request.Visible = false;
				MainGUI.Leaderboard.Trade.Request.Cancel.Visible = false;
				TradeEvents.CancelRequest:FireServer();
			end;
		end)

	end;
end)

MainGUI.Leaderboard.Trade.Toggle.SelectionLost:connect(function()
	MainGUI.Leaderboard.Trade.Request.Response.Visible = false;
	MainGUI.Leaderboard.Trade.Request.Cancel.Visible = false;
	if RequestConnection then RequestConnection:disconnect(); end;
end);


local LastAccept = time();
TradeGUI.Offers.Accept.MouseButton1Click:connect(function()
	if CooldownRunning == false and time()-LastAccept >=1 then
		LastAccept = time();
		TradeGUI.Offers.Accept.Waiting.Visible = true;
		TradeEvents.AcceptTrade:FireServer();
	end;
end)

local TradeStatus,Data = game.ReplicatedStorage.GetTradeStatus:InvokeServer();

if TradeStatus == "StartTrade" then
	UpdateTrade(Data);
	game:GetService("GuiService").SelectedObject = TradeGUI.YourItems.Items.Container.Slot1.Container.Button;
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
	["Victim"] = 7;
	["Custom"] = 10;
	["Ancient"] = 6.5;
	["Mythic"] = 6.6;
	["Christmas"] = 1.6;
	["Halloween"] = 1.5;
};
--{Classic=1;Common=2;Uncommon=3;Rare=4;Legendary=5;Godly=6;Victim=7;Christmas=1.5;Halloween=1.6;Ancient=6.5;};



function UpdateInventory(WhosItems,ItemsInv,PetsInv)
	local SyncItems = GetSyncData("Item");
	local Pets = GetSyncData("Pets");
	
	local InventoryFrame = TradeGUI[WhosItems].Items.Container;
	local PetsFrame = TradeGUI[WhosItems].PetsFrame.Container;


	InventoryFrame:ClearAllChildren();
	PetsFrame:ClearAllChildren();
	
	local InventoryTable = ItemsInv; --_G.PlayerData.Weapons;
	local Inventory = {};
	
	local PetTable = PetsInv;-- 
	local PetInventory = {};
	
	for ItemName,Amount in pairs(InventoryTable) do 
		table.insert(Inventory,{
			["ItemName"] = ItemName;
			["Amount"] = Amount;
		})
	end
	
	for ItemName,Amount in pairs(PetTable) do 
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
	
	local ItemCount = 0;
	for _,iData in pairs(Inventory) do
		local ItemName = iData["ItemName"];
		local Amount = iData["Amount"];
		ItemCount = ItemCount+1;
		local CurrentItemData = GetSyncData("Item")[ItemName];

		--local Row = math.floor((ItemCount-1)/5);
		--local Column = (ItemCount-1)%5
		local NewSlot = script.Slot:Clone();
		NewSlot.Parent = TradeGUI[WhosItems].Items.Container;
		
		local Row = math.floor((ItemCount-1)/(1/0.25)); local Column = (ItemCount-1)%(1/0.25);
		NewSlot.Position = UDim2.new(NewSlot.Size.X.Scale*Column,0,0,NewSlot.AbsoluteSize.Y*Row);
		
		NewSlot.Container.Icon.Image = CurrentItemData["Image"];
		NewSlot.Container.ItemName.Text = GetSyncData("Item")[ItemName]["ItemName"];
		NewSlot.Container.ItemName.TextColor3 = GetSyncData("Rarity")[CurrentItemData["Rarity"]];
		NewSlot.Name = "Slot"..ItemCount;
		
		if Amount > 1 then
			NewSlot.Container.Amount.Text = "x" .. Amount;
		end	
	
		if WhosItems == "YourItems" then
			NewSlot.Container.Button.MouseButton1Click:connect(function()
				TradeEvents.OfferItem:FireServer(ItemName,"Weapons");
			end)
		else
			NewSlot.Container.Button.Selectable = false;
		end;
	end
	
	local ItemCount = 0;
	for _,iData in pairs(PetInventory) do
		local ItemName = iData["ItemName"];
		local Amount = iData["Amount"];
		ItemCount = ItemCount+1;
		local CurrentItemData = Pets[ItemName];

		--local Row = math.floor((ItemCount-1)/5);
		--local Column = (ItemCount-1)%5
		local NewSlot = script.Slot:Clone();
		NewSlot.Parent = PetsFrame;
		
		local Row = math.floor((ItemCount-1)/(1/0.25)); local Column = (ItemCount-1)%(1/0.25);
		NewSlot.Position = UDim2.new(NewSlot.Size.X.Scale*Column,0,0,NewSlot.AbsoluteSize.Y*Row);

		NewSlot.Container.Icon.Image = GetImage(CurrentItemData["Image"]);
		NewSlot.Container.ItemName.Text = Pets[ItemName].Name
		NewSlot.Container.ItemName.TextColor3 = GetSyncData("Rarity")[CurrentItemData["Rarity"]];
		NewSlot.Name = "Slot"..ItemCount;
		if Amount > 1 then
			NewSlot.Container.Amount.Text = "x" .. Amount;
		end;
		
		if WhosItems == "YourItems" then
			NewSlot.Container.Button.MouseButton1Click:connect(function()
				TradeEvents.OfferItem:FireServer(ItemName,"Pets");
			end)
		else
			NewSlot.Container.Button.Selectable = false;
		end;
	end
	
end

--local PetsButton = TradeGUI.Pets;
--local WeaponsButton = TradeGUI.Weapons;

if _G.RequestsEnabled == nil then
	_G.RequestsEnabled = true;
end

MainGUI.Leaderboard.Trade.Status.BackgroundColor3 = (_G.RequestsEnabled and Color3.new(0, 179/255, 0)) or Color3.new(170/255,0,0)
MainGUI.Leaderboard.Trade.Title.Text = "Trade Requests: " .. (((_G.RequestsEnabled and "On")) or "Off");

MainGUI.Leaderboard.Trade.Toggle.MouseButton1Click:connect(function()
	if (not  MainGUI.Leaderboard.Trade.Request.Visible) then
		_G.RequestsEnabled = not _G.RequestsEnabled;
		MainGUI.Leaderboard.Trade.Status.BackgroundColor3 = (_G.RequestsEnabled and Color3.new(0, 179/255, 0)) or Color3.new(170/255,0,0)
		MainGUI.Leaderboard.Trade.Title.Text = "Trade Requests: " .. (((_G.RequestsEnabled) and "On") or "Off");
		TradeEvents.DeclineRequest:FireServer();
	end;
end)
function game.ReplicatedStorage.CheckClient.OnClientInvoke()
	return 5;
end;
--[[
PetsButton.MouseButton1Click:connect(function()
	PetsButton.Style = Enum.ButtonStyle.RobloxRoundDefaultButton;
	WeaponsButton.Style = Enum.ButtonStyle.RobloxRoundButton;
	PetsFrame.Visible = true;
	InventoryFrame.Visible = false;
end)

WeaponsButton.MouseButton1Click:connect(function()
	WeaponsButton.Style = Enum.ButtonStyle.RobloxRoundDefaultButton;
	PetsButton.Style = Enum.ButtonStyle.RobloxRoundButton;
	PetsFrame.Visible = false;
	InventoryFrame.Visible = true;
end)]]

UpdateInventory("YourItems",_G.PlayerData.Weapons.Owned,_G.PlayerData.Pets.Owned);








