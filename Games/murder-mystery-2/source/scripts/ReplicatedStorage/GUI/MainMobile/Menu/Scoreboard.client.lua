local LobbyGUI = script.Parent.Parent:WaitForChild("Lobby");
local LocalPlayer = game.Players.LocalPlayer;

local ScoreboardFrame = LobbyGUI:WaitForChild("Screens"):WaitForChild("Waiting"):WaitForChild("Scoreboard");

local CodeImages = require(game.ReplicatedStorage.Game.Modules.CodeImages);
local ItemsDB = game.ReplicatedStorage.Game.Remotes.Data.GetSyncData:InvokeServer("Item");
local RarityColors = game.ReplicatedStorage.Game.Remotes.Data.GetSyncData:InvokeServer("Rarity");

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

local Time = 0.2;
local Style = "Quad";
local Direction = "Out";

local RoleColors = {
	["Innocent"] = Color3.new(1,1,1);
	["Sheriff"] = Color3.new(0,0,1);
	["Hero"] = Color3.new(1,1,0);
	["Murderer"] = Color3.new(1,0,0);
	["Zombie"] = Color3.new(25/255, 172/255, 0);
	["Survivor"] = Color3.new(43/255,154/255,238/255);		
	["Red"] = Color3.new(217/255, 35/255, 35/255);
	["Blue"] = Color3.new(63/255, 176/255, 224/255);
	["Juggernaut"] = Color3.new(217/255, 35/255, 35/255);
	["Gladiator"] = Color3.new(63/255, 176/255, 224/255);
};

local function CreateMurdererFrame(PlayerData,Name,MurdererFrame,KnifeFrame,EffectFrame)
	local MurdererImage =  (string.sub(Name, 1,6) == "Guest " and "http://www.roblox.com/asset/?id=65732094" ) or game.ReplicatedStorage.GetPlayerImage:Invoke(Name);
	MurdererFrame.PlayerIcon.Image = MurdererImage;
	MurdererFrame.PlayerIcon.ImageColor3 = (PlayerData[Name].Dead and Color3.new(50/255,50/255,50/255)) or Color3.new(1,1,1);
	MurdererFrame.PlayerName.Text = Name;
	MurdererFrame.Dead.Visible = PlayerData[Name].Dead;
	
	if KnifeFrame then
		local Knife = PlayerData[Name].Knife;
		local KnifeData = ItemsDB[Knife];
		KnifeFrame.Icon.Image = GetImage(KnifeData.Image);
		KnifeFrame.ItemName.Text = KnifeData.ItemName;
		KnifeFrame.ItemName.TextColor3 = RarityColors[KnifeData.Rarity];
	end;
	
end

game.ReplicatedStorage.Game.Remotes.Round.GameOver.OnClientEvent:connect(function(PlayerData,GameTime,GameMode,XPText,Winner,TitleText,TitleTextColor)

	local ScoreFrame = ScoreboardFrame;
	ScoreFrame.Title.Text = TitleText;
	ScoreFrame.Title.TextColor3 = TitleTextColor;
		
	ScoreFrame.Close.MouseButton1Click:connect(function() ScoreFrame.Visible = false end);
	
	local Murderer;
	local Sheriff;
	local Hero;
	
	for PlayerName,Data in pairs(PlayerData) do if Data["Role"] == "Murderer" then Murderer = PlayerName; end; if Data["Role"] == "Sheriff" then Sheriff = PlayerName; end; if Data["Role"] == "Hero" and not Data["Dead"] then Hero = PlayerName; end; end
	
	CreateMurdererFrame(PlayerData,Murderer,ScoreFrame.Murderer.Container,ScoreFrame.Knife.Container);
	
	local GunFrame = ScoreFrame.Gun.Container;
	local SheriffFrame = ScoreFrame.Sheriff.Container;
	local SheriffImage = (string.sub(Sheriff, 1,6) == "Guest " and "http://www.roblox.com/asset/?id=65732094" ) or  game.ReplicatedStorage.GetPlayerImage:Invoke(Hero or Sheriff);
	local GunnerData = (Hero and PlayerData[Hero]) or PlayerData[Sheriff];
	
	SheriffFrame.PlayerIcon.Image = GetImage(SheriffImage);
	SheriffFrame.PlayerIcon.ImageColor3 = (GunnerData.Dead and Color3.new(50/255,50/255,50/255)) or Color3.new(1,1,1);
	SheriffFrame.PlayerName.Text = (Hero or Sheriff);
	SheriffFrame.Dead.Visible = GunnerData.Dead;
	SheriffFrame.Role.Text = (Hero and "Hero") or "Sheriff";
	SheriffFrame.Role.TextColor3 = (Hero and Color3.new(1,1,0)) or Color3.new(40/255,120/255,220/255);
	
	local Gun = GunnerData.Gun;
	local GunData = ItemsDB[Gun];
	GunFrame.Icon.Image = GetImage(GunData.Image);
	GunFrame.ItemName.Text = GunData.ItemName;
	GunFrame.ItemName.TextColor3 = RarityColors[GunData.Rarity];
	
	ScoreFrame.Visible = true;
	
end)
