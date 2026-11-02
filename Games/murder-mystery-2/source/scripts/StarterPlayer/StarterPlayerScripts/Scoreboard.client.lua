local LocalPlayer = game.Players.LocalPlayer;
local Phone = game:GetService("UserInputService").TouchEnabled
local ServerSettings = game.ReplicatedStorage.GetServerSettings:InvokeServer();
local CodeImages = require(game.ReplicatedStorage.CodeImages);
local ItemsDB = game.ReplicatedStorage.GetSyncData:InvokeServer("Item");
local EffectsDB = game.ReplicatedStorage.GetSyncData:InvokeServer("Effects");
local RarityColors = game.ReplicatedStorage.GetSyncData:InvokeServer("Rarity");

local SyncedData = {};
function GetSyncData(DataName) 
	if SyncedData[DataName] == nil then
		SyncedData[DataName] = game.ReplicatedStorage.GetSyncData:InvokeServer(DataName);
	end
	return SyncedData[DataName];
end
function GetData(DataName)
	return game.ReplicatedStorage.GetData:InvokeServer(DataName)
end
function GetLevel(XP)
	return math.floor((25 + math.sqrt(625 + 300 * XP))/50);
end

local function u9(p3)
	for v7, v8 in pairs(p3) do
		v8:Play();
	end;
end;
--pc
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
local u8 = {
	Commafy = function(p2)
		local v4 = p2;
		while true do
			local v5, v6 = string.gsub(v4, "^(-?%d+)(%d%d%d)", "%1,%2");
			v4 = v5;
			k = v6;
			if k == 0 then
				break;
			end;		
		end;
		return v4;
	end
};
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

local Remote=game.ReplicatedStorage;

local Database = {
	
	Weapons 	= Remote.GetSyncData:InvokeServer("Item");
	Effects 	= Remote.GetSyncData:InvokeServer("Effects");
	Perks 		= Remote.GetSyncData:InvokeServer("Perks");
	Emotes 		= Remote.GetSyncData:InvokeServer("Emotes");
	Radios		= Remote.GetSyncData:InvokeServer("Radios");
	Toys		= Remote.GetSyncData:InvokeServer("Toys");
	Pets 		= Remote.GetSyncData:InvokeServer("Pets");
	Materials 	= Remote.GetSyncData:InvokeServer("Materials");
	
};

local RoleColors = {
	["Innocent"] = Color3.new(1,1,1);
	["Sheriff"] = Color3.new(0,0,1);
	["Hero"] = Color3.new(1,1,0);
	["Murderer"] = Color3.new(1,0,0);
};


local function u12(p11)
	local v15 = math.floor(p11 / 60);
	return (v15 > 0 and v15 .. "m and " or "") .. p11 - v15 * 60 .. "s";
end;

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
		KnifeFrame.Parent.ItemName.Label.Text = KnifeData.ItemName;
        KnifeFrame.Parent.ItemName.BackgroundColor3 = RarityColors[KnifeData.Rarity];
        KnifeFrame.Parent.Tags.Chroma.Visible = false
        KnifeFrame.Parent.Tags.Christmas.Visible = false 
        
        if KnifeData.Rarity == "Common" then
			KnifeFrame.Parent.ItemName.BackgroundColor3 = Color3.new(0.372549, 0.372549, 0.372549)
        end;
        
        if KnifeData.Chroma ~= nil then
            KnifeFrame.Parent.Tags.Chroma.Visible = true;
        end
        if KnifeData.YearTagHW ~= nil then
            KnifeFrame.Parent.Tags.Halloween.Visible = true;
            KnifeFrame.Parent.Tags.Halloween.Year.Text = KnifeData.Year
        end
        if KnifeData.YearTag ~= nil then
            KnifeFrame.Parent.Tags.Christmas.Visible = true;
            KnifeFrame.Parent.Tags.Christmas.Year.Text = KnifeData.Year
        end	
	end;
end;

	
local u11 = TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false, 0);
game.ReplicatedStorage.GameOver.OnClientEvent:connect(function(PlayerData,GameTime,GameMode,XPText,WinText,WinTextColor,Frame1,Frame2,Frame3,Winner,TitleText,TitleTextColor,TotalXP,TimeSurvived,InnosSaved,Eliminations)		
	local ScoreboardFrame = (Phone and script:WaitForChild("Scoreboard_Phone"):Clone()) or script:WaitForChild("Scoreboard"):Clone()
	if GameMode ~= "Classic" and Phone then
		return
	end
	local LevelIcon = ScoreboardFrame[GameMode].Container.LevelUp.Level;
	function UpdateLevel()
		local XP = GetData("XP")
		local Bar = LevelIcon:WaitForChild("XPBar").XP;
		LevelIcon.Level.LevelText.Text = GetLevel(XP);
		LevelIcon.Level.LevelText.Text = LevelIcon.Level.LevelText.Text + 1
		local Progress = ((25 + math.sqrt(625 + 300 * XP))/50)%1/1
		Bar.Size = UDim2.new(Progress,Bar.Size.X.Offset,Bar.Size.Y.Scale,Bar.Size.Y.Offset)
		if LevelIcon.Level.LevelText.Text + 1 > 100 then
			LevelIcon.Level.LevelText.Text = GetLevel(XP);
		end
	end
	ScoreboardFrame.Parent = LocalPlayer.PlayerGui
	local ScoreFrame = ScoreboardFrame[GameMode];	
	ScoreFrame.Container.LevelUp.Coins.CoinIcon.TextLabel.Text = _G.Coins
	

	
	
	if GameMode == "Classic" then
		local Murderer;
		local Sheriff;
		local Hero;
		for PlayerName,Data in pairs(PlayerData) do
			if Data["Role"] == "Murderer" then
				Murderer = PlayerName; end;
			if Data["Role"] == "Sheriff" then
				Sheriff = PlayerName; end;
			if Data["Role"] == "Hero" and Winner == "Hero" and not Data["Dead"] then
				Hero = PlayerName; end;
		end
		if Phone then
			ScoreFrame.Container.VersusFrame.Title.MurdererWin.Text = TitleText;
			ScoreFrame.Container.VersusFrame.Title.MurdererWin.TextColor3 = TitleTextColor;
		else
			ScoreFrame.Container.Title.Title.Text = TitleText;
			ScoreFrame.Container.Title.Title.TextColor3 = TitleTextColor;
		end

		CreateMurdererFrame(PlayerData,Murderer,ScoreFrame.Container.VersusFrame.Container.Murderer.Container,ScoreFrame.Container.VersusFrame.Container.KnifeFrame.Container);
		
		local GunFrame = ScoreFrame.Container.VersusFrame.Container.GunFrame;
		local SheriffFrame = ScoreFrame.Container.VersusFrame.Container.Sheriff.Container;
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
		GunFrame.Container.Icon.Image = GetImage(GunData.Image);
		GunFrame.ItemName.Label.Text = GunData.ItemName;
        GunFrame.ItemName.BackgroundColor3 = RarityColors[GunData.Rarity];
        GunFrame.Tags.Chroma.Visible = false
        GunFrame.Tags.Christmas.Visible = false
        
        if GunData.Chroma ~= nil then
            GunFrame.Tags.Chroma.Visible = true;
        end
        if GunData.YearTagHW ~= nil then
            GunFrame.Tags.Halloween.Visible = true;
            GunFrame.Tags.Halloween.Year.Text = GunData.Year
        end
        if GunData.YearTag ~= nil then
            GunFrame.Tags.Christmas.Visible = true;
            GunFrame.Tags.Christmas.Year.Text = GunData.Year
        end

        if GunData.Rarity == "Common" then
		GunFrame.ItemName.BackgroundColor3 = Color3.new(0.372549, 0.372549, 0.372549)
		ScoreFrame.Container.LevelUp.Coins.CoinIcon.TextLabel.Text = "" .. _G.Coins .. "";
		end
		ScoreboardFrame.Enabled = true;
		ScoreFrame.Visible = true
		UpdateLevel();
		wait(1)
		if Phone then
			for i = 1,1 do
				if Frame1 == "VictoryMurderer" then
					ScoreFrame.Container.RewardContainer.MurdererVictory.Visible = true
					wait(0.5)
				end
				if Frame1 == "SherifWon" then
					ScoreFrame.Container.RewardContainer.SheriffVictory.Visible = true
					wait(0.5)
				end
				if InnosSaved then
					ScoreFrame.Container.RewardContainer.SaviorBonus.Visible = true
					ScoreFrame.Container.RewardContainer.SaviorBonus.Container.TextLabel.Text = "Saved "..InnosSaved.." Innocents!"
					ScoreFrame.Container.RewardContainer.SaviorBonus.Container.XPIcon.TextLabel.Text = "+"..50+(InnosSaved*10)
					wait(0.5)
				end
				if Frame1 == "SherifLost" then
					ScoreFrame.Container.RewardContainer.SheriffDefeat.Visible = true
					wait(0.5)
				end
				if Frame1 == "HeroBonus" then
					ScoreFrame.Container.RewardContainer.HeroShootingBonus.Visible = true
					wait(0.5)
				end
				if Frame1 == "PersonWon" then
					ScoreFrame.Container.RewardContainer.SheriffSurvival.Visible = true
					wait(0.5)
				end
				if Frame1 == "InnocentWins" then
					ScoreFrame.Container.RewardContainer.InnocentVictory.Visible = true
					wait(0.5)
				end
				if WinText == "Defeat" then
					ScoreFrame.Container.RewardContainer.SheriffDefeat.Visible = true
					wait(0.5)
				end
				if WinText == "Survived" then
					ScoreFrame.Container.RewardContainer.SheriffSurvival.Visible = true
					wait(0.5)
				end
				if TimeSurvived then
					ScoreFrame.Container.RewardContainer.SurvivalXP.Visible = true
					ScoreFrame.Container.RewardContainer.SurvivalXP.Container.TextLabel.Text = "Survived for "..u12(TimeSurvived)
					ScoreFrame.Container.RewardContainer.SurvivalXP.Container.XPIcon.TextLabel.Text = "+"..TimeSurvived*2
					wait(0.5)
				end
				if _G.Coins >= 50 and game.ReplicatedStorage.AmElite:InvokeServer() then
					ScoreFrame.Container.RewardContainer.CoinBagReward.Visible = true
					TotalXP += 400
					wait(0.5)
				end
				if _G.Coins >= 40 and not game.ReplicatedStorage.AmElite:InvokeServer() then
					ScoreFrame.Container.RewardContainer.CoinBagReward.Visible = true
					TotalXP += 400
					wait(0.5)
				end
				if game.ReplicatedStorage.AmElite:InvokeServer() then
					ScoreFrame.Container.RewardContainer.Elite.Visible = true
				end
			end
		else
			for i = 1,1 do
				if Frame1 == "VictoryMurderer" then
					ScoreFrame.Container.MurdererVictory.Visible = true
					wait(0.5)
				end
				if Eliminations then
					ScoreFrame.Container.Eliminations.Container.TextLabel.Text = "Eliminated "..Eliminations.." Innocents"
					ScoreFrame.Container.Eliminations.Container.XPIcon.TextLabel.Text = "+"..Eliminations*5
					ScoreFrame.Container.Eliminations.Visible = true
					wait(0.5)
				end
				if Frame1 == "SherifWon" then
					ScoreFrame.Container.SheriffVictory.Visible = true
					wait(0.5)
				end
				if InnosSaved then
					ScoreFrame.Container.SaviorBonus.Visible = true
					ScoreFrame.Container.SaviorBonus.Container.TextLabel.Text = "Saved "..InnosSaved.." Innocents!"
					ScoreFrame.Container.SaviorBonus.Container.XPIcon.TextLabel.Text = "+"..50+(InnosSaved*10)
					wait(0.5)
				end
				if Frame1 == "SherifLost" then
					ScoreFrame.Container.SheriffDefeat.Visible = true
					wait(0.5)
				end
				if Frame1 == "HeroBonus" then
					ScoreFrame.Container.HeroShootingBonus.Visible = true
					wait(0.5)
				end
				if Frame1 == "PersonWon" then
					ScoreFrame.Container.SheriffSurvival.Visible = true
					wait(0.5)
				end
				if Frame1 == "InnocentWins" then
					ScoreFrame.Container.InnocentVictory.Visible = true
					wait(0.5)
				end
				if WinText == "Defeat" then
					ScoreFrame.Container.SheriffDefeat.Visible = true
					wait(0.5)
				end
				if WinText == "Survived" then
					ScoreFrame.Container.SheriffSurvival.Visible = true
					wait(0.5)
				end
				if TimeSurvived then
					ScoreFrame.Container.SurvivalXP.Visible = true
					ScoreFrame.Container.SurvivalXP.Container.TextLabel.Text = "Survived for "..u12(TimeSurvived)
					ScoreFrame.Container.SurvivalXP.Container.XPIcon.TextLabel.Text = "+"..TimeSurvived*2
					wait(0.5)
				end
				if _G.Coins >= 50 and game.ReplicatedStorage.AmElite:InvokeServer() then
					ScoreFrame.Container.CoinBagReward.Visible = true
					TotalXP += 400
					wait(0.5)
				end
				if _G.Coins >= 40 and not game.ReplicatedStorage.AmElite:InvokeServer() then
					ScoreFrame.Container.CoinBagReward.Visible = true
					TotalXP += 400
					wait(0.5)
				end
				if game.ReplicatedStorage.AmElite:InvokeServer() then
					ScoreFrame.Container.Elite.Visible = true
				end
			end
		end
	elseif GameMode == "Assassin" then
		TotalXP = 50
		ScoreFrame.Container.Title.MurdererWin.Text = WinTextColor;
		ScoreFrame.Container.Title.MurdererWin.TextColor3 = Frame1;
		if WinTextColor ~= "Time's Up" then
			CreateMurdererFrame(PlayerData,WinText,ScoreFrame.Container.VersusFrame.Container.Murderer.Container,ScoreFrame.Container.VersusFrame.Container.KnifeFrame.Container);
		else
			CreateMurdererFrame(PlayerData,game.Players.LocalPlayer.Name,ScoreFrame.Container.VersusFrame.Container.Murderer.Container,ScoreFrame.Container.VersusFrame.Container.KnifeFrame.Container);
		end
		ScoreboardFrame.Enabled = true;
		ScoreFrame.Visible = true
		UpdateLevel();
		wait(1)
		if WinText == game.Players.LocalPlayer.Name then
			ScoreFrame.Container.AssassinVictory.Visible = true
			TotalXP += 550
			wait(0.5)
		end
		if _G.Coins >= 50 and game.ReplicatedStorage.AmElite:InvokeServer() then
			ScoreFrame.Container.CoinBagReward.Visible = true
			TotalXP += 400
			wait(0.5)
		end
		if _G.Coins >= 40 and not game.ReplicatedStorage.AmElite:InvokeServer() then
			ScoreFrame.Container.CoinBagReward.Visible = true
			TotalXP += 400
			wait(0.5)
		end
		if game.ReplicatedStorage.AmElite:InvokeServer() then
			ScoreFrame.Container.Elite.Visible = true
			TotalXP = TotalXP * 1.5
			wait(0.5)
		end
	end
	
	
	wait(0.5)
	_G.Coins = 0;
	local l__TweenValue__51 = ScoreFrame.Container.LevelUp.TotalXP.XPIcon.TextLabel.TweenValue;
	l__TweenValue__51.Value = 0;
	l__TweenValue__51.Changed:connect(function()
		ScoreFrame.Container.LevelUp.TotalXP.XPIcon.TextLabel.Text = "+" .. u8.Commafy(math.floor(l__TweenValue__51.Value));
	end);
	u9({ game:GetService("TweenService"):Create(l__TweenValue__51, u11, {
		Value = TotalXP
	}) });
	wait(12);
	ScoreboardFrame.Enabled = false;
	ScoreboardFrame:Destroy()
 end)
