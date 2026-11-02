local PlayerData = game.ReplicatedStorage.GetPlayerData:InvokeServer();
local Spectating = false;
local CodeImages = require(game.ReplicatedStorage.CodeImages);
local MainGUI = script.Parent.Parent.Game;
local SpectateButton = MainGUI.Dock.Spectate;


local TestServerID = 13027726810;
local MM2ID = 13085716426;
local HardcoreID = 335132309;
local HardcoreTestID = 345345;
local IsHardcore = (game.PlaceId == HardcoreTestID or game.PlaceId == HardcoreID);
local SpectateFrame = MainGUI.Spectate;



local CurrentSpectate = 1;
local CurrentPlayer;

local function GetSpectatePlayers()
	local Players = {};
	if PlayerData then
		for PlayerName,Data in pairs(PlayerData) do
			local Player = game.Players:FindFirstChild(PlayerName);
			if Player == game.Players.LocalPlayer and (not Data.Dead) then return {}; end;				
			if not Data.Dead and Player and Player.Character and Player.Character:FindFirstChild("Humanoid") then
				table.insert(Players,Player);
			end
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
					SpectateFrame.CodeImage.Image = CodeImages[PData[CurrentPlayer.Name].CodeName];
					SpectateFrame.CodeImage.ImageColor3 = PData[CurrentPlayer.Name]["Color"].Color;
				else
					SpectateFrame.CodeImage.PlayerName.Text = CurrentPlayer.Name;
				end;
				game.Workspace.CurrentCamera.CameraSubject = CurrentPlayer.Character.Humanoid;
				MainGUI.Waiting.Image = "http://www.roblox.com/asset/?id=189842948";
				SpectateFrame.Visible = true;
				Spectating = true;
			else
				game.Workspace.CurrentCamera.CameraSubject = game.Players.LocalPlayer.Character.Humanoid;
				game.Workspace.CurrentCamera.CameraType = "Custom";
				SpectateFrame.Visible = false;
				MainGUI.Waiting.Image = "http://www.roblox.com/asset/?id=189761558";
				Spectating = false;
			end;
		end
	else
		game.Workspace.CurrentCamera.CameraSubject = game.Players.LocalPlayer.Character.Humanoid;
		game.Workspace.CurrentCamera.CameraType = "Custom";
		SpectateFrame.Visible = false;
		MainGUI.Waiting.Image = "http://www.roblox.com/asset/?id=189761558";
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
			SpectateFrame.CodeImage.Image = CodeImages[PlayerData[CurrentPlayer.Name].CodeName];
			SpectateFrame.CodeImage.ImageColor3 = PlayerData[CurrentPlayer.Name]["Color"].Color;
		else
			SpectateFrame.CodeImage.PlayerName.Text = CurrentPlayer.Name;
		end;
	else
		game.Workspace.CurrentCamera.CameraSubject = game.Players.LocalPlayer.Character.Humanoid;
		game.Workspace.CurrentCamera.CameraType = "Custom";
		SpectateFrame.Visible = false;
		MainGUI.Waiting.Image = "http://www.roblox.com/asset/?id=189761558";
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
	if Spectating then
		game.Workspace.CurrentCamera.CameraSubject = game.Players.LocalPlayer.Character.Humanoid;
		game.Workspace.CurrentCamera.CameraType = "Custom";
		SpectateFrame.Visible = false;
		MainGUI.Waiting.Image = "http://www.roblox.com/asset/?id=189761558";
		Spectating = false;
	else
		if GetSpectatePlayers() and #GetSpectatePlayers()>0 then
			CurrentSpectate = 1;
			CurrentPlayer = GetSpectatePlayers()[CurrentSpectate];
			game.Workspace.CurrentCamera.CameraSubject = CurrentPlayer.Character.Humanoid;
			
			if IsHardcore then
				SpectateFrame.CodeImage.Image = CodeImages[PlayerData[CurrentPlayer.Name].CodeName];
				SpectateFrame.CodeImage.ImageColor3 = PlayerData[CurrentPlayer.Name]["Color"].Color;
			else
				SpectateFrame.CodeImage.PlayerName.Text = CurrentPlayer.Name;
			end;
			
			MainGUI.Waiting.Image = "http://www.roblox.com/asset/?id=189842948";
			SpectateFrame.Visible = true;
			Spectating = true;
		end;
	end;
	
end)


game:GetService("UserInputService").InputBegan:connect(function(Input,Processed)
	if Processed then return end;
	if not Spectating then return end;
	if Input.KeyCode == Enum.KeyCode.Q then
		ChangeSpectate(-1);
	elseif Input.KeyCode == Enum.KeyCode.E then
		ChangeSpectate(1);
	end;
end)


