local LocalPlayer = game.Players.LocalPlayer;
local MainGUI = script.Parent.Parent;
local PlayerGui = MainGUI.Parent;
local LobbyGUI = MainGUI.Lobby;
local Dock = LobbyGUI.Dock;
local Screens = LobbyGUI.Screens;
local UserInputService = game:GetService("UserInputService")

local Mode = "Lobby";

game.ReplicatedStorage.Fade.OnClientEvent:connect(function()
	Mode = "Game";
end);

_G.ReturnGUI = function()
	if Mode == "Lobby" then
		for _,Screen in pairs(Screens:GetChildren()) do
			Screen.Visible = (Screen.Name == "Waiting");
		end
		for _,Frame in pairs(MainGUI:GetChildren()) do
			if Frame:IsA("Frame") then Frame.Visible = (Frame.Name == "Lobby"); end;
		end
		PlayerGui:SetTopbarTransparency(0.5); 
		Dock.BackgroundTransparency = 0.5;
		UserInputService.ModalEnabled = false;
	elseif Mode == "Game" then
		for _,Frame in pairs(MainGUI:GetChildren()) do
			if Frame:IsA("Frame") then Frame.Visible = (Frame.Name == "Game"); end;
		end
		UserInputService.ModalEnabled = false;
		PlayerGui:SetTopbarTransparency(0.5); 
	end;
	
end

local DockVisible = true;
local TweeningDock = false;
local D,S,T="Out","Quad",0.2;
Screens.Waiting.Hide.MouseButton1Click:connect(function()
	if TweeningDock then return; end;
	DockVisible = not DockVisible;
	Dock:TweenPosition( UDim2.new(0, (DockVisible and 0) or -100,0,0),D,S,T )
	Screens:TweenSizeAndPosition(
		UDim2.new(1,(DockVisible and -100) or 0,1,0),
		UDim2.new(0,(DockVisible and 100) or 0,0,0),
		D,S,T
	);
	Screens.Waiting.Hide.Text = (DockVisible and "<  <") or ">  >";
	wait(T);
	TweeningDock = false;
end)

_G.ViewLobbyFrame = function(ButtonName)
	if ButtonName == "Spectate" then
		UserInputService.ModalEnabled = not UserInputService.ModalEnabled;
		--[[local PlayerData = game.ReplicatedStorage.GetPlayerData:InvokeServer(); local Length = 0;
		for _,_ in pairs(PlayerData) do Length = Length + 1 end;
		if not (PlayerData ~= nil and Length > 1 and (PlayerData[LocalPlayer.Name]==nil or PlayerData[LocalPlayer.Name].Dead == true)) then
			return;
		end;]]
	else
		Screens[ButtonName].Visible = not Screens[ButtonName].Visible;
		_G.CancelSpectate();
	end;
	
	for _,Screen in pairs(Screens:GetChildren()) do
		if Screen.Name ~= ButtonName then Screen.Visible = false; end;
	end
	
	if not Screens[ButtonName].Visible then 
		Screens.Waiting.Visible = true; 
		PlayerGui:SetTopbarTransparency(0.5); 
		Dock.BackgroundTransparency = 0.5;
		UserInputService.ModalEnabled = false;
	else 
		PlayerGui:SetTopbarTransparency(0); 
		Dock.BackgroundTransparency = 0; 
		UserInputService.ModalEnabled = true;
	end;
end;

for _,Button in pairs(Dock:GetChildren()) do
	Button.MouseButton1Click:connect(function()
		if DockVisible and not TweeningDock then
			_G.ViewLobbyFrame(Button.Name);
		end;
	end)
end;
