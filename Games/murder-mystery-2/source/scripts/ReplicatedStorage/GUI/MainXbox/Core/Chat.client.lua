local LocalPlayer = game.Players.LocalPlayer;
local MainGUI = script.Parent.Parent;
local PlayerGui = MainGUI.Parent;
local ChatFrame = MainGUI.Chat;
local LobbyChatFrame = MainGUI.Chat.Container;

local Items = game.ReplicatedStorage.GetSyncData:InvokeServer("Item");
local Rarities = game.ReplicatedStorage.GetSyncData:InvokeServer("Rarity");
local UpdateLobbyChat;

local Actions = game:GetService("ContextActionService");
local Main = script.Parent.Parent;
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

local ChatTableLength = 8;
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

_G.Chatted = Chatted;

local ServerColor = Color3.new(0.8,0.8,0.8);


UpdateLobbyChat = function()
	LobbyChatFrame:ClearAllChildren();
	for i,MData in pairs(_G.ChatTable) do
		local NewMessageFrame = script:WaitForChild("ChatMessage"):Clone();
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
		NewMessageFrame.Message.Position = UDim2.new(0,NewMessageFrame.PlayerName.TextBounds.X+10,0,3);
		NewMessageFrame.Position = UDim2.new(0,0,0.125*(ChatTableLength-i),0)
	end
end

UpdateLobbyChat();

local function OpenChat()
	Unbind("Chat");
	
	ChatFrame.Container.BackgroundTransparency = 0.3;
	ChatFrame.Title.BackgroundTransparency = 0.3;
	ChatFrame.Control.Visible = true;

	local function Close()
		Unbind("CloseChat");Unbind("CloseChat2");Unbind("Emotes");Unbind("ChatType");
		Bind("Chat",Enum.KeyCode.ButtonL3,OpenChat);
		ChatFrame.Container.BackgroundTransparency = 1;
		ChatFrame.Control.Visible = false;
		ChatFrame.Title.BackgroundTransparency = 1;
		if ChatFrame.Emotes.Visible then
			game:GetService("GuiService").SelectedObject = nil;
		end;
		ChatFrame.Emotes.Visible = false;
	end
	
	Bind("ChatType",Enum.KeyCode.DPadLeft, function()
		Close();
		ChatFrame.ChatBox:CaptureFocus();
	end)
	
	Bind("Emotes",Enum.KeyCode.DPadRight, function()
		if not MainGUI.Trade.Visible then
			Unbind("Emotes");Unbind("ChatType");
			ChatFrame.Emotes.Visible = not ChatFrame.Emotes.Visible;
			game:GetService("GuiService").SelectedObject = ChatFrame.Emotes.Slot0;
		end;
	end)
	
	Bind("CloseChat", Enum.KeyCode.ButtonB,Close)
	Bind("CloseChat2", Enum.KeyCode.ButtonL3,Close)
	
end

ChatFrame.ChatBox.FocusLost:connect(function(Enter,Input)
	if Enter then
		Chatted(LocalPlayer,ChatFrame.ChatBox.Text);
		game.ReplicatedStorage.Chatted:FireServer(ChatFrame.ChatBox.Text);
	end;
end)

Bind("Chat",Enum.KeyCode.ButtonL3,OpenChat);











