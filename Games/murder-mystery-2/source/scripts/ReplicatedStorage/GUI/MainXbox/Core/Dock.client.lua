local Actions = game:GetService("ContextActionService");
local Main = script.Parent.Parent;
local Dock = Main.Dock;
local Inventory = Main.Inventory;
game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false)
--game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, false)
pcall(function() game.Workspace.Lobby.RadioGamepass:Destroy() end);

game:GetService("GuiService").AutoSelectGuiEnabled = false;
_G.PauseBinds = false;

local D,S,T = "Out","Quad",0.2;

local CurrentSpectate = 1;
local CurrentPlayer;


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


local Icon1 = Dock.Tip.Icon1;
local Icon2 = Icon1.Icon2;
local Icon3 = Icon2.Icon3;

local function ChangeDockButton(Button)
	local Image = "rbxasset://textures/ui/Settings/Help/".. Button.."ButtonDark@2x.png";
	Icon1.Image = Image;
	Icon2.Image = Image;
	Icon3.Image = Image;
end

local Frames = {
	{"Inventory",Enum.KeyCode.ButtonA,{"Weapons","Perks","Effects","Pets"},1};
	{"Shop",Enum.KeyCode.ButtonX,{"Featured","Currency","Weapons","Perks","Effects","Pets"},1};
	{"Spectate",Enum.KeyCode.ButtonY};
};

local PlayerData = game.ReplicatedStorage.GetPlayerData:InvokeServer();
local Spectating = false;

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
				Main.Spectate.Title.PlayerName.Text = CurrentPlayer.Name;
				game.Workspace.CurrentCamera.CameraSubject = CurrentPlayer.Character.Humanoid;
			else
				game.Workspace.CurrentCamera.CameraSubject = game.Players.LocalPlayer.Character.Humanoid;
				_G.ResetDock();
			end;
		end
	else
		game.Workspace.CurrentCamera.CameraSubject = game.Players.LocalPlayer.Character.Humanoid;
		_G.ResetDock();
	end;
	
end);

local CanNavigate = true;
local function Navigate(Frame,Direction)
	if not CanNavigate then return end;
	CanNavigate = false;
	local FData = Frames[Frame];
	
	if FData[1] ~= "Spectate" then
		local NavTable = FData[3];
		local CurrentFrame = Main[FData[1]].Main[ FData[3][FData[4]] ];
	
		Frames[Frame][4] = FData[4] + Direction;
		local NextIndex = ((FData[4]-1)%#FData[3])+1
		local NextFrame = Main[FData[1]].Main[FData[3][NextIndex]];
		
		for _,Button in pairs(Main[FData[1]].Title.Nav:GetChildren()) do
			Button.Style = (Button.Name == NextFrame.Name and Enum.ButtonStyle.RobloxRoundDefaultButton) or Enum.ButtonStyle.RobloxRoundButton;
		end
	
		Main[FData[1]].Title.Title.Text = NextFrame.Name;
		
		if FData[1] == "Shop" then
			if NextFrame.Name == "Weapons" then
				Main.Shop.Info.Buy.ButtonIcon.Title.Text = "View";
			else
				Main.Shop.Info.Buy.ButtonIcon.Title.Text = "Buy";
			end;
		end
	
		NextFrame.Position = UDim2.new(Direction,0,0,0);
		CurrentFrame:TweenPosition(UDim2.new(-Direction,0,0,0),D,S,T,false);
		NextFrame:TweenPosition(UDim2.new(0,0,0,0),D,S,T,false);
		Frames[Frame][4] = NextIndex;
		game:GetService("GuiService").SelectedObject = (NextFrame.Items.ScrollFrame.Container:FindFirstChild("Slot0") and NextFrame.Items.ScrollFrame.Container:FindFirstChild("Slot0").Container.Button) or nil;
		wait(T);
	else
			
		if GetSpectatePlayers() and #GetSpectatePlayers()>0 then
			CurrentSpectate = CurrentSpectate + Direction;
			if CurrentSpectate < 1 then CurrentSpectate = #GetSpectatePlayers() elseif CurrentSpectate > #GetSpectatePlayers() then CurrentSpectate = 1 end;
			CurrentPlayer = GetSpectatePlayers()[CurrentSpectate];
			game.Workspace.CurrentCamera.CameraSubject = CurrentPlayer.Character.Humanoid;
			Main.Spectate.Title.PlayerName.Text = CurrentPlayer.Name;
		else
			_G.ResetDock();
			game.Workspace.CurrentCamera.CameraSubject = game.Players.LocalPlayer.Character.Humanoid;
		end;
	end;
	
	CanNavigate = true;
end

local function BindDockButtons()
	if not Dock.Visible then return; end;
	
	for Index,FrameData in pairs(Frames) do
		local Frame = Main[FrameData[1]];
		Bind("Open"..FrameData[1],FrameData[2],function()
			
			if FrameData[1] == "Spectate" then
				if GetSpectatePlayers() and #GetSpectatePlayers()>0 then
					CurrentSpectate = 1;
					CurrentPlayer = GetSpectatePlayers()[CurrentSpectate];
					game.Workspace.CurrentCamera.CameraSubject = CurrentPlayer.Character.Humanoid;
					Main.Spectate.Title.PlayerName.Text = CurrentPlayer.Name;
					Spectating = true;
				else
					return;
				end;
			end
			
			for _,F in pairs(Frames) do Unbind("Open"..F[1]); end;
			local CurrentFrame = (FrameData[1] == "Spectate" and "") or  Main[FrameData[1]].Main[ FrameData[3][FrameData[4]] ];
			
			if FrameData[1] ~= "Spectate" then
				game:GetService("GuiService").SelectedObject = (CurrentFrame.Items.ScrollFrame.Container:FindFirstChild("Slot0") and CurrentFrame.Items.ScrollFrame.Container:FindFirstChild("Slot0").Container.Button) or nil;
			end;
			
			Frame:TweenPosition(UDim2.new(0,0,0,0),D,S,T,false);
			Dock:TweenPosition( UDim2.new(0.5,-(Dock.AbsoluteSize.X/2),1,100),D,S,T,false);
			Bind("NoX",Enum.KeyCode.ButtonX,function()end);
			Bind("NoB",Enum.KeyCode.ButtonB,function()end);
			game.Players.LocalPlayer:WaitForChild("PlayerGui"):SetTopbarTransparency(0)
			
			Bind("NavRight",Enum.KeyCode.ButtonR1,function() Navigate(Index,1) end)
			Bind("NavLeft",Enum.KeyCode.ButtonL1,function() Navigate(Index,-1) end)
			
			Main.Leaderboard.Visible = false;
			Main.Chat.Visible = false;
			
			Main.CashBag:TweenPosition(UDim2.new(1.12,0,0.7,0),D,S,T);
			Main.Perk:TweenPosition(UDim2.new(1.25,0,0.99,0),D,S,T);
			Main.Weapon:TweenPosition(UDim2.new(-0.51,0,0.8,-5),D,S,T);
			
			wait(T);
			Unbind("NoB");
			Bind("Close",Enum.KeyCode.ButtonB,function()
				Unbind("NoX");Unbind("NoB");Unbind("NavLeft");Unbind("NavRight");Unbind("BuyCrateBundle");
				
				Main.CashBag:TweenPosition(UDim2.new(0.99,0,0.7,0),D,S,T);
				Main.Perk:TweenPosition(UDim2.new(0.99,0,0.99,0),D,S,T);
				Main.Weapon:TweenPosition(UDim2.new(0,5,0.8,-5),D,S,T);
			
				Frame:TweenPosition(UDim2.new(0,0,-1,-36),D,S,T,false);
				
				if Dock.Visible then
					Dock:TweenPosition( UDim2.new(0.5,-(Dock.AbsoluteSize.X/2),1,-Dock.AbsoluteSize.Y-10),D,S,T,false);
				end;
				
				game.Workspace.CurrentCamera.CameraSubject = game.Players.LocalPlayer.Character.Humanoid;
				Spectating = false;
				
				game.Players.
				LocalPlayer:WaitForChild("PlayerGui"):SetTopbarTransparency(0.5)
				
				Main.Leaderboard.Visible = true;
				Main.Chat.Visible = true;	
				
				wait(T);
				
				Unbind("Close");
				game:GetService("GuiService").SelectedObject = nil;
				BindDockButtons();
			end);
			
		end)
	end
end

game.ReplicatedStorage.RoleSelect.OnClientEvent:connect(function(Role,Color,CodeName,LockFirstPerson,GameMode)
	Dock.Frame.Spectate.Icon.Image = "http://www.roblox.com/asset/?id=189764018";
	Dock.Frame.Spectate.Icon.ImageColor3 = Color3.new(0.25,0.25,0.25);
	Dock.Frame.Spectate.ButtonIcon.ButtonIcon.ButtonIcon.ImageColor3 = Color3.new(44/255,44/255,44/255);
	--[[Dock.Visible = false;
	for _,F in pairs(Frames) do Unbind("Open"..F[1]); end;
	Unbind("OpenMenu");]]
end);

Bind("OpenMenu",Enum.KeyCode.ButtonX,function()
	
	Dock:TweenPosition( UDim2.new(0.5,-(Dock.AbsoluteSize.X/2),1,-Dock.AbsoluteSize.Y-10),D,S,T,false);
	Dock.Tip.TipText.Text = "CLOSE";
	ChangeDockButton("B");
	
	wait(T);

	BindDockButtons();
	
	Bind("CloseMenu",Enum.KeyCode.ButtonB,function()
		ChangeDockButton("X");
		Dock:TweenPosition( UDim2.new(0.5,-(Dock.AbsoluteSize.X/2),1,0),D,S,T,false);
		Dock.Tip.TipText.Text = "MENU";
		for _,F in pairs(Frames) do Unbind("Open"..F[1]); end;
		wait(T);
		Unbind("CloseMenu");
	end);
	
end);


_G.ResetDock = function()

	Unbind("NoX");Unbind("NoB");Unbind("NavLeft");Unbind("NavRight");Unbind("BuyCrateBundle");
	Spectating = false;
	Main.Shop:TweenPosition(UDim2.new(0,0,-1,-36),D,S,T,false);
	Main.Inventory:TweenPosition(UDim2.new(0,0,-1,-36),D,S,T,false);
	Main.Spectate:TweenPosition(UDim2.new(0,0,-1,-36),D,S,T,false);
	game.Players.LocalPlayer:WaitForChild("PlayerGui"):SetTopbarTransparency(0.5)
	Unbind("Close");
	game:GetService("GuiService").SelectedObject = nil;
	BindDockButtons();
	
	ChangeDockButton("X");
	Dock:TweenPosition( UDim2.new(0.5,-(Dock.AbsoluteSize.X/2),1,0),D,S,0,false);
	Dock.Tip.TipText.Text = "MENU";
	for _,F in pairs(Frames) do Unbind("Open"..F[1]); end;
	Unbind("CloseMenu");
	Dock.Visible = true;
end




