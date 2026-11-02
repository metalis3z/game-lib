local MainGUI = script.Parent.Game;

local Dock = MainGUI.Dock;
local SpectateButton = Dock.Spectate;
local SpectateFrame = MainGUI.Spectate;
local LocalPlayer = game.Players.LocalPlayer;

local CodeImages = require(game.ReplicatedStorage.CodeImages);
local Spectating = false;

local SpectatingConnections = {};

local TestServerID = 13027726810;
local MM2ID = 13085716426;
local HardcoreID = 335132309;
local HardcoreTestID = 345345;

local IsHardcore = (game.PlaceId == HardcoreTestID or game.PlaceId == HardcoreID);


function Spectate()
	Spectating = true;
	local SpectatablePlayers = {};
	local PlayerData = game.ReplicatedStorage.GetPlayerData:InvokeServer();
	local TargetIndex = 1;
	local TargetName;
	local TargetCodeName;
	
	local function NewSpectateTable()
		SpectatablePlayers = {};
		PlayerData = game.ReplicatedStorage.GetPlayerData:InvokeServer();
		for PlayerName,DataTable in pairs(PlayerData) do
			if DataTable["Dead"] == false then
				table.insert(SpectatablePlayers,PlayerName);
			end
		end
	end
	local function ChangeTarget()
		TargetName = SpectatablePlayers[TargetIndex];
		TargetCodeName = PlayerData[TargetName]["CodeName"];	
		if IsHardcore then
			SpectateFrame.CodeImage.Image = CodeImages[TargetCodeName];
			SpectateFrame.CodeImage.ImageColor3 = PlayerData[TargetName]["Color"].Color;
		else
			SpectateFrame.CodeImage.PlayerName.Text = TargetName;
		end;
		game.Workspace.CurrentCamera.CameraSubject = (game:GetService("UserInputService").TouchEnabled and game.Players[TargetName].Character.Humanoid) or game.Players[TargetName].Character.Head; --Head;
	end
	local function Right()
		NewSpectateTable();
		for i,PlayerName in pairs(SpectatablePlayers) do
			if PlayerName == TargetName then
				TargetIndex = i+1;
				if SpectatablePlayers[TargetIndex] == nil then
					TargetIndex = 1;
				end
			end
		end
		ChangeTarget();
	end
	
	local function Left()
		NewSpectateTable();
		for i,PlayerName in pairs(SpectatablePlayers) do
			if PlayerName == TargetName then
				TargetIndex = i-1;
				if SpectatablePlayers[TargetIndex] == nil then
					TargetIndex = #SpectatablePlayers;
				end
			end
		end
		ChangeTarget();
	end
	
	local RightButtonCon;
	local LeftButtonCon;
	local KeyboardCon;
	local ButtonCon;
	RightButtonCon = SpectateFrame.Right.MouseButton1Click:connect(Right);
	LeftButtonCon = SpectateFrame.Left.MouseButton1Click:connect(Right);
	KeyboardCon = LocalPlayer:GetMouse().KeyDown:connect(function(Key)
		if Key == 'e' then
			Right();
		elseif Key == 'q' then
			Left();
		end
	end)
	ButtonCon = game:GetService("UserInputService").InputBegan:connect(function(Input)
		local B = Input.KeyCode;
		if B == Enum.KeyCode.ButtonR1 then
			Right();
		elseif B == Enum.KeyCode.ButtonR2 then
			Left();
		end;
	end)
	
	
	table.insert(SpectatingConnections,RightButtonCon);
	table.insert(SpectatingConnections,KeyboardCon);
	
	NewSpectateTable();
	
	if not game:GetService("UserInputService").TouchEnabled then
		game.Workspace.CurrentCamera.CameraType = "Track";
	end;
	ChangeTarget();
	
	SpectateFrame.Visible = true;
	
	MainGUI.Waiting.Image = "http://www.roblox.com/asset/?id=189842948";
	
end

function StopSpectating()
	for i,Connection in pairs(SpectatingConnections) do 
		Connection:disconnect();
	end
	Spectating = false;
	SpectateFrame.Visible = false;
	game.Workspace.CurrentCamera.CameraSubject = LocalPlayer.Character.Humanoid;
	game.Workspace.CurrentCamera.CameraType = "Custom";
	MainGUI.Waiting.Image = "http://www.roblox.com/asset/?id=189761558";
end

local function TableIsEmpty(Table)
	for _,_ in pairs(Table) do
		return false;
	end
	return true;
end

local function ClickSpectate()
	local PlayerData = game.ReplicatedStorage.GetPlayerData:InvokeServer();
	if PlayerData ~= nil and not TableIsEmpty(PlayerData) then
		if PlayerData[LocalPlayer.Name] == nil then
			Spectate();
		else
			if PlayerData[LocalPlayer.Name]["Dead"] == true then
				Spectate();
			end
		end
	end
end
SpectateButton.MouseButton1Click:connect(function()
	if Spectating then
		StopSpectating();
	else
		ClickSpectate();
	end
end)
script.Parent.SpectateClicked.Event:connect(ClickSpectate)

repeat wait() until LocalPlayer.Character ~= nil;
StopSpectating();
