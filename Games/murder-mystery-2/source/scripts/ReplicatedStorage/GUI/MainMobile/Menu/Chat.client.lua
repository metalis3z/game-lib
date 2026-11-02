local LocalPlayer = game.Players.LocalPlayer;
local MainGUI = script.Parent.Parent;
local PlayerGui = MainGUI.Parent;
local LobbyGUI = MainGUI.Lobby;
local Screens = LobbyGUI.Screens;
local LobbyChatFrame = Screens.Waiting.Chat;

local Items = game.ReplicatedStorage.GetSyncData:InvokeServer("Item");
local Rarities = game.ReplicatedStorage.GetSyncData:InvokeServer("Rarity");
local UpdateLobbyChat;

local ChatTableLength = 5;
if not _G.ChatTable then _G.ChatTable = {} end;

local function Chatted(Player,Message,Item)
	--print(tostring(CodeName));
	local _,_,Elite = game.ReplicatedStorage.GetPlayerLevel:InvokeServer(Player);
	table.insert(_G.ChatTable,1,{
		["PlayerName"] = (Player=="Server" and "Server") or (((Elite and "[ELITE] ") or "") .. Player.Name);
		["Message"] = Message;
		["Server"] = (Player=="Server");
		["Item"] = (Item and Item.ItemName) or nil;
		["Color"] = (Elite and Color3.new(232/255,42/255,42/255)) or Color3.new(230/255,230/255,230/255);
		["RarityColor"] = (Item and Item.RarityColor) or nil;
	});

	table.remove(_G.ChatTable,ChatTableLength+1);
	UpdateLobbyChat();
end


local MyColor,MyCodeName;
game.ReplicatedStorage.RoleSelect.OnClientEvent:connect(function(Role,Color,CodeName) MyColor = Color; MyCodeName = CodeName; end);

LocalPlayer.Chatted:connect(function(Message)
	Chatted(LocalPlayer,Message,nil,MyColor,MyCodeName);
end)

game.ReplicatedStorage.Chatted.OnClientEvent:connect(function(Player,Message,Item)
	if not (Player.Name==LocalPlayer.Name) then
		Chatted(Player,Message,Item);
	end;
end);

local ServerColor = Color3.new(0.6,0.6,0.6);


UpdateLobbyChat = function()
	LobbyChatFrame:ClearAllChildren();
	Screens.Spectate.Chat:ClearAllChildren();
	for i,MData in pairs(_G.ChatTable) do
		local NewMessageFrame = script:WaitForChild("MessageFrame"):Clone();
		NewMessageFrame.Parent = LobbyChatFrame;
		if not MData.Server then
			NewMessageFrame.Message.Text = MData.Message;
			NewMessageFrame.PlayerName.Text = MData.PlayerName .. ": ";
			NewMessageFrame.PlayerName.TextColor3 = MData.Color;
		else
			NewMessageFrame.PlayerName.Font = Enum.Font.SourceSansItalic;
			NewMessageFrame.PlayerName.TextColor3 = ServerColor;
			if MData.Item then
				NewMessageFrame.Message.Font = Enum.Font.SourceSansBold;
				NewMessageFrame.PlayerName.Text = MData.Message .. " ";
				NewMessageFrame.Message.Text = MData.Item;
				NewMessageFrame.Message.TextColor3 = MData.RarityColor--Rarities[Items[MData.Item].Rarity];
			else
				NewMessageFrame.PlayerName.Text = MData.Message;
				NewMessageFrame.Message.Text = "";
			end;	
		end;
		NewMessageFrame.Message.Position = UDim2.new(0,NewMessageFrame.PlayerName.TextBounds.X,0,0);
		NewMessageFrame.Position = UDim2.new(0.01,0,0.2*(ChatTableLength-i),0)
		--NewMessageFrame:Clone().Parent = MainGUI.Game.Chat;
		NewMessageFrame:Clone().Parent = Screens.Spectate.Chat;
	end
end


UpdateLobbyChat()