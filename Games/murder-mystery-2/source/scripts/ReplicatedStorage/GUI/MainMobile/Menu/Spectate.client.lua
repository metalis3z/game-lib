local PlayerData = game.ReplicatedStorage.GetPlayerData:InvokeServer();
local Spectating = false;
local CodeImages = require(game.ReplicatedStorage.CodeImages);
local MainGUI = script.Parent.Parent;
local SpectateButton = MainGUI.Lobby.Dock.Spectate;

repeat wait() until game.Players.LocalPlayer.Character;

local TestServerID = 13027726810;
local MM2ID = 13085716426;
local HardcoreID = 335132309;
local HardcoreTestID = 345345;
local IsHardcore = (game.PlaceId == HardcoreTestID or game.PlaceId == HardcoreID);
local SpectateFrame = MainGUI.Lobby.Screens.Spectate;



local CurrentSpectate = 1;
local CurrentPlayer;

local function GetSpectatePlayers()
	local Players = {};
	if PlayerData then
		for PlayerName,Data in pairs(PlayerData) do
			local Player = game.Players:FindFirstChild(PlayerName);
			if Player == game.Players.LocalPlayer then
				if (not Data.Dead) then 
					return {}; 
				end
			else				
				if not Data.Dead and Player and Player.Character and Player.Character:FindFirstChild("Humanoid") then
					table.insert(Players,Player);
				end
			end;
		end
	end;
	return Players;
end


game.ReplicatedStorage.UpdatePlayerData.OnClientEvent:connect(function(PData)

	PlayerData = PData; 	
	if not Spectating then return; end;
	
	if GetSpectatePlayers() and #GetSpectatePlayers()>0 then
		if CurrentPlayer ~= GetSpectatePlayers()[CurrentPlayer] then
			
			for Index,Player in pairs(GetSpectatePlayers()) do
				if Player == CurrentPlayer then
					CurrentSpectate = Index;
					return;
				end
			end			
			
			repeat 
				CurrentSpectate = CurrentSpectate + 1; 
			until GetSpectatePlayers()[CurrentSpectate] or CurrentSpectate > #GetSpectatePlayers();
			
			if CurrentSpectate >  #GetSpectatePlayers() then
				CurrentSpectate = 1;
			end


			CurrentPlayer = GetSpectatePlayers()[CurrentSpectate];			
			
			if CurrentPlayer then
				if IsHardcore then
					SpectateFrame.PlayerName.Text = CodeImages[PData[CurrentPlayer.Name].CodeName];
					SpectateFrame.PlayerName.TextColor3 = PData[CurrentPlayer.Name]["Color"].Color;
				else
					SpectateFrame.PlayerName.Text = CurrentPlayer.Name;
				end;
				game.Workspace.CurrentCamera.CameraSubject = CurrentPlayer.Character.Humanoid;
				SpectateFrame.Visible = true;
				Spectating = true;
			else
				game.Workspace.CurrentCamera.CameraSubject = game.Players.LocalPlayer.Character.Humanoid;
				game.Workspace.CurrentCamera.CameraType = "Custom";
				SpectateFrame.Visible = false;
				Spectating = false;
			end;
		end
	else
		game.Workspace.CurrentCamera.CameraSubject = game.Players.LocalPlayer.Character.Humanoid;
		game.Workspace.CurrentCamera.CameraType = "Custom";
		SpectateFrame.Visible = false;
		Spectating = false;
	end;
	
end);


local function ChangeSpectate(Direction)
	if GetSpectatePlayers() and #GetSpectatePlayers()>0 then
		CurrentSpectate = CurrentSpectate + Direction;
		if CurrentSpectate < 1 then CurrentSpectate = #GetSpectatePlayers() elseif CurrentSpectate > #GetSpectatePlayers() then CurrentSpectate = 1 end;
		CurrentPlayer = GetSpectatePlayers()[CurrentSpectate];
		game.Workspace.CurrentCamera.CameraSubject = CurrentPlayer.Character.Humanoid;
		if IsHardcore then
			SpectateFrame.PlayerName.Text = CodeImages[PlayerData[CurrentPlayer.Name].CodeName];
			SpectateFrame.PlayerName.TextColor3 = PlayerData[CurrentPlayer.Name]["Color"].Color;
		else
			SpectateFrame.PlayerName.Text = CurrentPlayer.Name;
		end;
	else
		game.Workspace.CurrentCamera.CameraSubject = game.Players.LocalPlayer.Character.Humanoid;
		game.Workspace.CurrentCamera.CameraType = "Custom";
		SpectateFrame.Visible = false;
		Spectating = false;
	end;
end

SpectateFrame.Right.MouseButton1Click:connect(function()
	ChangeSpectate(1);
end)

SpectateFrame.Left.MouseButton1Click:connect(function()
	ChangeSpectate(-1)
end)



SpectateButton.MouseButton1Click:connect(function()
	if not (game.Players.LocalPlayer.Character) then return; end;
	if not (game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")) then return; end;
	if Spectating then
		game.Workspace.CurrentCamera.CameraSubject = game.Players.LocalPlayer.Character.Humanoid;
		game.Workspace.CurrentCamera.CameraType = "Custom";
		SpectateFrame.Visible = false;
		Spectating = false;
	else
		if GetSpectatePlayers() and #GetSpectatePlayers()>0 then
			CurrentSpectate = 1;
			CurrentPlayer = GetSpectatePlayers()[CurrentSpectate];
			game.Workspace.CurrentCamera.CameraSubject = CurrentPlayer.Character.Humanoid;
			
			if IsHardcore then
				SpectateFrame.PlayerName.Text = CodeImages[PlayerData[CurrentPlayer.Name].CodeName];
				SpectateFrame.PlayerName.TextColor3 = PlayerData[CurrentPlayer.Name]["Color"].Color;
			else
				SpectateFrame.PlayerName.Text = CurrentPlayer.Name;
			end;
			
			SpectateFrame.Visible = true;
			Spectating = true;
		end;
	end;
	
end)

_G.CancelSpectate = function()
	game.Workspace.CurrentCamera.CameraSubject = game.Players.LocalPlayer.Character.Humanoid;
	game.Workspace.CurrentCamera.CameraType = "Custom";
	SpectateFrame.Visible = false;
	Spectating = false;
end


SpectateFrame.Left.MouseButton1Click:connect(function()
	if not Spectating then return end;
	ChangeSpectate(-1);
end)

SpectateFrame.Right.MouseButton1Click:connect(function()
	if not Spectating then return end;
	ChangeSpectate(1);
end)


