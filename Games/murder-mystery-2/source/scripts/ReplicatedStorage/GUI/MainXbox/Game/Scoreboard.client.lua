local GameGUI = script.Parent.Parent;
local LocalPlayer = game.Players.LocalPlayer;

local ServerSettings = game.ReplicatedStorage.GetServerSettings:InvokeServer();
local CodeImages = require(game.ReplicatedStorage.CodeImages);
local ItemsDB = game.ReplicatedStorage.GetSyncData:InvokeServer("Item");
local RarityColors = game.ReplicatedStorage.GetSyncData:InvokeServer("Rarity");



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


local RoundEndFrame = GameGUI.RoundEnd;

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

if not _G.Coins then _G.Coins = 0; end;
game.ReplicatedStorage.GetCoin.OnClientEvent:connect(function() _G.Coins = _G.Coins + 1; end);

local Time = 0.2;
local Style = "Quad";
local Direction = "Out";

local Song;
local function FadeSong()
	for i = 1,20 do
		Song.Volume = Song.Volume-0.05;
		wait(0.05);
	end;		
end

local RoleColors = {
	["Hero"] = Color3.new(1,1,0); 
	["Sheriff"] = Color3.new(40/255,120/255,220/255);
	["Murderer"] = Color3.new(220/255,0,0);
	["Innocent"] = Color3.new(1,1,1);
	["Zombie"] = Color3.new(25/255,172/255,0);
	["Survivor"] = Color3.new(43/255,154/255,238/255);
	["Red"] = Color3.new(217/255, 35/255, 35/255);
	["Blue"] = Color3.new(63/255, 176/255, 224/255);
};

local function GenerateViewAll(ScoreFrame,PlayerData)
	local Index = 0;
	local PlayerTable = {};
	for PlayerName,Data in pairs(PlayerData) do
		table.insert(PlayerTable,{PlayerName=PlayerName,Data=Data});
	end
	table.sort(PlayerTable,function(a,b)
		
		if a.Data.Role == "Murderer" then
			return true;
		elseif b.Data.Role == "Murderer" then
			return false;
		elseif a.Data.Role == "Sheriff" then
			return true;
		elseif b.Data.Role == "Sheriff" then
			return false;
		elseif a.Data.Role == "Hero" then
			return true;
		elseif b.Data.Role == "Hero" then
			return false;
		elseif a.Data.Dead ~= b.Data.Dead then
			return (a.Data.Dead==false and true) or false;
		end;
		return a.PlayerName < b.PlayerName;
	end)
	for _,Table in pairs(PlayerTable) do
		local PlayerName = Table.PlayerName; local Data=Table.Data;
		local NewFrame = script.PlayerFrame:Clone();
		NewFrame.Parent = ScoreFrame.ViewAll.Container;
		local Row = 0; local Column = Index%12;
		local Size = NewFrame.AbsoluteSize.X;
		NewFrame.Position = UDim2.new(0,Size*Column,0,100*Row);
		
		local PlayerImage =  (string.sub(PlayerName, 1,6) == "Guest " and "http://www.roblox.com/asset/?id=65732094" ) or  game.ReplicatedStorage.GetPlayerImage:Invoke(PlayerName);
		
		NewFrame.Container.PlayerIcon.Image = GetImage(PlayerImage);
		NewFrame.Container.PlayerIcon.ImageColor3 = (Data.Dead and Color3.new(50/255,50/255,50/255)) or Color3.new(1,1,1);
		NewFrame.Container.PlayerName.Text = PlayerName;

		NewFrame.Container.PlayerName.BackgroundColor3 =  RoleColors[Data.Role]; -- (Data.Role=="Hero" and Color3.new(1,1,0)) or (Data.Role=="Sheriff" and Color3.new(40/255,120/255,220/255)) or (Data.Role=="Murderer" and Color3.new(220/255,0,0)) or  Color3.new(1,1,1);
		NewFrame.Container.Dead.Visible = Data.Dead;
		
		--if ServerSettings.Disguises then
		NewFrame.Container.CodeName.Text = Data.CodeName --.Image = CodeImages[Data.CodeName];
		NewFrame.Container.CodeName.TextColor3 = Data.Color.Color; --ImageColor3 = Data.Color.Color;
		--end
		
		Index = Index + 1;
	end
end

local function CreateMurdererFrame(PlayerData,Name,MurdererFrame,KnifeFrame)
	local MurdererImage =  (string.sub(Name, 1,6) == "Guest " and "http://www.roblox.com/asset/?id=65732094" ) or game.ReplicatedStorage.GetPlayerImage:Invoke(Name);
	MurdererFrame.PlayerIcon.Image = MurdererImage;
	MurdererFrame.PlayerIcon.ImageColor3 = (PlayerData[Name].Dead and Color3.new(50/255,50/255,50/255)) or Color3.new(1,1,1);
	MurdererFrame.PlayerName.Text = Name;
	MurdererFrame.Dead.Visible = PlayerData[Name].Dead;
	if ServerSettings.Disguises then
		MurdererFrame.CodeName.Image = CodeImages[PlayerData[Name].CodeName];
		MurdererFrame.CodeName.ImageColor3 = PlayerData[Name].Color.Color;
	end
	
	if KnifeFrame then
		local Knife = PlayerData[Name].Knife;
		local KnifeData = ItemsDB[Knife];
		KnifeFrame.Icon.Image = GetImage(KnifeData.Image);
		KnifeFrame.ItemName.Text = KnifeData.ItemName;
		KnifeFrame.ItemName.TextColor3 = RarityColors[KnifeData.Rarity];
	end;
end

local function Pop()
	script.Pop:Play();
end

game.ReplicatedStorage.GameOver.OnClientEvent:connect(function(PlayerData,GameTime,GameMode,XPText,Winner,TitleText,TitleTextColor)

	local ScoreFrame = RoundEndFrame;
	ScoreFrame.Title.Text = TitleText;
	ScoreFrame.Title.TextColor3 = TitleTextColor;
	--ScoreFrame.Main.Close.MouseButton1Click:connect(function() ScoreFrame.Visible = false end);
	
	if GameMode == "Classic" then
		--ScoreFrame.ViewAll.Close.MouseButton1Click:connect(function() ScoreFrame.Visible = false end);
		
		local Murderer;
		local Sheriff;
		local Hero;
		for PlayerName,Data in pairs(PlayerData) do if Data["Role"] == "Murderer" then Murderer = PlayerName; end; if Data["Role"] == "Sheriff" then Sheriff = PlayerName; end; if Data["Role"] == "Hero" and not Data["Dead"] then Hero = PlayerName; end; end
		
		--CreateMurdererFrame(PlayerData,Murderer,ScoreFrame.Main.Murderer.Container,ScoreFrame.Main.Knife.Container);
		
		--[[local GunFrame = ScoreFrame.Main.Gun.Container;
		local SheriffFrame = ScoreFrame.Main.Sheriff.Container;
		local SheriffImage =  (string.sub(Sheriff, 1,6) == "Guest " and "http://www.roblox.com/asset/?id=65732094" ) or  game.ReplicatedStorage.GetPlayerImage:Invoke(Hero or Sheriff);
		local GunnerData = (Hero and PlayerData[Hero]) or PlayerData[Sheriff];
		
		SheriffFrame.PlayerIcon.Image = GetImage(SheriffImage);
		SheriffFrame.PlayerIcon.ImageColor3 = (GunnerData.Dead and Color3.new(50/255,50/255,50/255)) or Color3.new(1,1,1);
		SheriffFrame.PlayerName.Text = (Hero or Sheriff);
		SheriffFrame.Dead.Visible = GunnerData.Dead;
		SheriffFrame.Role.Text = (Hero and "Hero") or "Sheriff";
		SheriffFrame.Role.TextColor3 = (Hero and Color3.new(1,1,0)) or Color3.new(40/255,120/255,220/255);
		if ServerSettings.Disguises then
			SheriffFrame.CodeName.Image = CodeImages[PlayerData[Hero or Sheriff].CodeName];
			SheriffFrame.CodeName.ImageColor3 = PlayerData[Hero or Sheriff].Color.Color;
		end
		local Gun = GunnerData.Gun;
		local GunData = ItemsDB[Gun];
		GunFrame.Icon.Image = GetImage(GunData.Image);
		GunFrame.ItemName.Text = GunData.ItemName;
		GunFrame.ItemName.TextColor3 = RarityColors[GunData.Rarity];]]
		ScoreFrame.Coins.Text = "You collected " .. _G.Coins .. " coins";
	end
	
	--GenerateViewAll(ScoreFrame,PlayerData);

	--[[local ScoreFrameSize = ScoreFrame.Size;
	local ScoreFramePosition = ScoreFrame.Position;
	
	ScoreFrame.Main.ViewAll.MouseButton1Click:connect(function()
		ScoreFrame:TweenSizeAndPosition(
			UDim2.new(0,615,0,380),
			UDim2.new(0.5,-307,0.5,-190),
			Direction,Style,Time
		);
		ScoreFrame.Main:TweenPosition(UDim2.new(-1,0,0,45),Direction,Style,Time);
		ScoreFrame.ViewAll:TweenPosition(UDim2.new(0,0,0,45),Direction,Style,Time);
	end)
	ScoreFrame.ViewAll.Back.MouseButton1Click:connect(function()
		ScoreFrame:TweenSizeAndPosition(
			ScoreFrameSize,
			ScoreFramePosition,
			Direction,Style,Time
		);
		ScoreFrame.Main:TweenPosition(UDim2.new(0,0,0,45),Direction,Style,Time);
		ScoreFrame.ViewAll:TweenPosition(UDim2.new(1,0,0,45),Direction,Style,Time);
	end)]]
	
	GenerateViewAll(ScoreFrame,PlayerData);
	
	ScoreFrame.XP.Text = XPText;
	
	_G.Coins = 0;	
	
	local EndMusic = {
		"http://www.roblox.com/asset/?id=320394794";
		"http://www.roblox.com/asset/?id=320396686";
		"http://www.roblox.com/asset/?id=320397765";
		"http://www.roblox.com/asset/?id=320403652";
	};

	Song = Instance.new("Sound",script.Parent.Parent);
	Song.SoundId = EndMusic[math.random(1,#EndMusic)];
	Song.Volume = 0.4;
	Song.Looped = false;
	Song.PlayOnRemove = false;
	Song:Play();
	
	local D,S,T = "Out","Quad",0.2;
	ScoreFrame.Visible = true;
	ScoreFrame:TweenPosition( UDim2.new(0,0,0.4,0),D,S,T);
	wait(0.8);
	
	ScoreFrame.Title.Visible = true;
	Pop();
	
	wait(0.4);
	
	ScoreFrame.Coins.Visible = true;
	Pop();
	
	wait(0.4);
	
	ScoreFrame.XP.Visible = true;
	Pop();
	
	wait(0.8);

	Bind("CloseScoreboard",Enum.KeyCode.ButtonB,function()
		ScoreFrame:TweenPosition( UDim2.new(0,0,1,0), D,S,T);
		Unbind("CloseScoreboard");
		Unbind("ViewPlayers");
		wait(T);
		ScoreFrame.Visible = false;
	end);
	
	Bind("ViewPlayers",Enum.KeyCode.ButtonX,function()
		Unbind("ViewPlayer");
		
		ScoreFrame.ViewAll:TweenPosition(UDim2.new(0,0,0,0),		D,S,T);
		ScoreFrame.Coins:TweenPosition(	UDim2.new(1,0,0.5,-3),  	D,S,T);
		ScoreFrame.Title:TweenPosition(	UDim2.new(1,0,0,3),   		D,S,T);
		ScoreFrame.XP:TweenPosition(	UDim2.new(1,0,0.75,-6),   	D,S,T);
		
		ScoreFrame.PlayersTip.Visible = false;
		ScoreFrame.CloseTip:TweenPosition( UDim2.new(0.4,0,1,0),	D,S,T);
		
	end)
	
	
	ScoreFrame.PlayersTip.Visible = true;
	ScoreFrame.CloseTip.Visible = true;

	print("Done");
	--[[wait(10);
	FadeSong();
	wait(10);
	ScoreFrame.Visible = false;]]
end)

game.Players.LocalPlayer.Character.Humanoid.Died:connect(function()
	GameGUI.Dead.Visible = true;
	wait(0.15)
	GameGUI.Dead.Visible = false;
	
	local Raggy;
	for i = 1,50 do
		for _,Part in pairs(game.Workspace:GetChildren()) do
			if Part:FindFirstChild(LocalPlayer.Name) then
				Raggy = Part;
				break;
			end;
		end
		if Raggy then break; end;
		wait();
	end;
	
	if Raggy then
		game.Workspace.CurrentCamera.CameraType = "Scriptable";
		while wait(0.05) do
			game.Workspace.CurrentCamera:Interpolate(game.Workspace.CurrentCamera.CFrame,Raggy.Torso.CFrame,0.05)
		end;
	end
end)
game.Workspace.CurrentCamera.CameraType = "Custom";
game.Workspace.CurrentCamera.CameraSubject = LocalPlayer.Character.Humanoid;
