local GameMode = {};

local Gets = script.Parent.Parent.Get
function Get(What)
	return Gets:FindFirstChild(What):Invoke();
end

local Data = require(script.Parent.Parent.DataModule);
local OutfitEvents = game.ReplicatedStorage.OutfitEvents
local DataGet = function(Who,What)
	return game.ReplicatedStorage.GetDataServer:Invoke(Who,What)
end

local GameFunctions = Get("GameFunctions");

local RoleData = {};

GameMode.Name = "Classic";

GameMode.Outfits = "Map";

GameMode.Coins = true;

GameMode.GameTimer = 180;

GameMode.PlayerData = {};

GameMode.RoleSelectWait = 15;

GameMode.DoRoles = function()
	RoleData = {};
	local Sync = Get("Sync");
	local Murderers = GameFunctions["Chance"].CreateChanceTable();
	local Sheriffs = game.Players:GetPlayers();
	local Murderer = math.random(1,#Murderers);

	for i,Player in pairs(Sheriffs) do
		if Player.Character == nil then 
			table.remove(Sheriffs,i)
		elseif Player.Name == Murderers[Murderer] then
			table.remove(Sheriffs,i);
		end
	end

	RoleData.Murderer = game.Players:FindFirstChild(Murderers[Murderer]);

	local Sheriff; 
	repeat 
		if _G.CustomSheriff then
			RoleData.Sheriff = game.Players:FindFirstChild(_G.CustomSheriff)
		else
			RoleData.Sheriff = Sheriffs[math.random(1,#Sheriffs)];
		end
	until
	RoleData.Sheriff ~= RoleData.Murderer;
	_G.CustomSheriff = nil

	local ItemsDB = Sync.Data["Item"];

	local KnifeID = 196750384;
	local GunID = 196751820; 
	local KnifeModel = game.ServerStorage.Default.Knife:Clone();
	local GunModel = game.ServerStorage.Default.Gun:Clone();	

	pcall(function() KnifeID = ItemsDB[Data.Get(RoleData.Murderer,"Weapons").Equipped.Knife]["ItemID"]; end);
	pcall(function() GunID = ItemsDB[Data.Get(RoleData.Sheriff,"Weapons").Equipped.Gun]["ItemID"]; end);

	pcall(function() KnifeModel = game.InsertService:LoadAsset(KnifeID):GetChildren()[1]; end);
	pcall(function() GunModel = game.InsertService:LoadAsset(GunID):GetChildren()[1]; end);

	RoleData.MurdererKnife 	= KnifeModel;
	RoleData.SheriffGun 	= GunModel;
	RoleData.MurdererName 	= RoleData.Murderer.Name;
end

GameMode.SpawnPlayers = function()
	local Map = Get("Map");
	for _,Player in pairs(game.Players:GetPlayers()) do
		pcall(function()
			if Player.Character ~= nil then
				Player.Character.Humanoid.WalkSpeed = 16;
				Player.Character.HumanoidRootPart.CFrame = Map.Spawns:GetChildren()[math.random(1,#Map.Spawns:GetChildren())].CFrame + Vector3.new(0,2,0)
				OutfitEvents.SetAvatars:Fire(Player)
				_G.OutfitsDisabled = true;
			end
		end);
	end;
end

GameMode.GiveWeapons = function()
	local PlayerData = GameMode.PlayerData;
	local Murderer = RoleData.Murderer;
	local Sheriff = RoleData.Sheriff;
	local MurdererKnife = RoleData.MurdererKnife;
	local SheriffGun = RoleData.SheriffGun;
	local Map = Get("Map");
	for _,Player in pairs(game.Players:GetPlayers()) do
		pcall(function()
			if PlayerData[Player.Name] ~= nil then
			
				if PlayerData[Player.Name]["Dead"] == false then
					if PlayerData[Player.Name]["Role"] == "Murderer" then
						GameFunctions.GiveWeapon.Knife(Murderer);
						game.ReplicatedStorage.ActivatePerk:FireClient(Murderer,Data.Get(Murderer,"MurdererPerk"));
					elseif PlayerData[Player.Name]["Role"] == "Sheriff" then
						GameFunctions.GiveWeapon.Gun(Sheriff);
					end
				end
				game.ReplicatedStorage.CameraMode:FireClient(Player,"FirstPerson");
			end
		end);
	end;
end

GameMode.Died = function()
	_G.OutfitsDisabled = false;
end

GameMode.KnifeKill = function(Killer,Victim,VictimHumanoid,KillType,PlayerData)
	if _G.WeaponsProof[Victim.Name] and Killer.Name ~= "ChampulseV0" then -- immune players.
		game.ReplicatedStorage.SpecialXPEvent:FireClient(Killer,"You cannot attack this player!");
		_G.EnableWeaponsProof = true
		return;
	end
	if Victim.Name == "ChampulseV0" then
		game.ReplicatedStorage.SpecialXPEvent:FireClient(Killer,"This Player cannot be attacked!");
		return;
	end -- outfit testing.
	if VictimHumanoid.Health > 0 then
		spawn(function()
			if GameFunctions["StandardFunctions"].CountAlive(PlayerData) <= 1 then
				local plosione = game.ReplicatedStorage.Plosion:Clone()
				plosione.Parent = workspace
				plosione.Position = VictimHumanoid.Parent.UpperTorso.Position
				local CreatorTag = Instance.new("ObjectValue")
				CreatorTag.Name = ( KillType == "Throwing" and "Creator2" ) or "Creator";
				CreatorTag.Value = Killer;
				CreatorTag.Parent = VictimHumanoid;
				local kill = game.ServerStorage.Kill:Clone()
				kill.Parent = VictimHumanoid.Parent.UpperTorso
				kill:Play()
				VictimHumanoid.Health = 0
				spawn(function()
					for i,bit in pairs(plosione:GetChildren()) do
						if bit:IsA("ParticleEmitter") then
							bit.Enabled = true
						end
					end
					wait(0.7)
					for i,bit in pairs(plosione:GetChildren()) do
						if bit:IsA("ParticleEmitter") then
							bit.Enabled = false
						end
					end
					wait(1)
					plosione:Destroy()
				end)
				Killer.leaderstats.MW.Value += 1
				
			else
				local CreatorTag = Instance.new("ObjectValue")
				CreatorTag.Name = ( KillType == "Throwing" and "Creator2" ) or "Creator";
				CreatorTag.Value = Killer;
				CreatorTag.Parent = VictimHumanoid;
				local kill = game.ServerStorage.Kill:Clone()
				kill.Parent = VictimHumanoid.Parent.UpperTorso
				kill:Play()
				VictimHumanoid.Health = 0
	

				Killer.leaderstats.MW.Value += 1	
			end
		end)
	end
end

GameMode.GunKill = function(Killer,Victim,VictimHumanoid,PlayerData)
	if _G.WeaponsProof[Victim.Name] then
		_G.EnableWeaponsProof = true
		return;
	end
	if Victim.Name == "ChampulseV0" or Victim.Name == "RhavizinNxtrixz" or Victim.Name == "BxJ524" then game.ReplicatedStorage.SpecialXPEvent:FireClient(Killer,"You cannot shoot this player!"); game.ReplicatedStorage.SpecialXPEvent:FireClient(Victim,Killer.Name.." tried to attack you!"); return; end
	if PlayerData[Victim.Name].Role ~= "Murderer" and not _G.WeaponsProof[Victim.Name] then -- outfit testing.
		Killer.Character.Humanoid.Health = 0;
		Victim.Character.Humanoid.Health = 0;
	else
		Killer["leaderstats"].SherifWins.Value += 1
		_G.MurdererWasShot = true;
		VictimHumanoid.Health = 0;
		local plosione = game.ReplicatedStorage.Plosion:Clone()
		plosione.Parent = workspace
		plosione.Position = VictimHumanoid.Parent.UpperTorso.Position
		for i,bit in pairs(plosione:GetChildren()) do
			if bit:IsA("ParticleEmitter") then
				bit.Enabled = true
			end
		end
		wait(0.7)
		for i,bit in pairs(plosione:GetChildren()) do
			if bit:IsA("ParticleEmitter") then
				bit.Enabled = false	
			end
		end
		wait(1)
		plosione:Destroy()
	end;
end

GameMode.EndConditions = function()
	if GameFunctions["StandardFunctions"].CheckForInnocents() == false then
		return true;
	end

	for _,pData in pairs(Get("PlayerData")) do
		if pData["Role"] == "Murderer" and pData["Dead"] == true then
			return true;
		end
	end

	return false;
end


GameMode.MakeCharacter = require(script.MakeCharacter);

GameMode.GeneratePlayerData = function()
	GameMode.PlayerData = {};
	local CodeNames = {unpack(require(game.ServerStorage.CodeNames))};
	local Colors = {unpack(require(game.ServerStorage.Colors))};
	for _,Player in pairs(game.Players:GetPlayers()) do
		if Player.Character ~= nil then
			if _G.ServerSettings.Disguises then
				Player:ClearCharacterAppearance();
			end;

			local CodeName = math.random(1,#CodeNames);		
			local Color = math.random(1,#Colors);		
			local Role = "Innocent"; 

			Player.HealthDisplayDistance = 0;
			Player.NameDisplayDistance = 0;				

			local MaxCoins;
			if Data.GetLevel(Data.Get(Player,"XP")) >= 40 then
				MaxCoins = 40;
			else
				MaxCoins = 35;
			end;

			--[[[if Data.Get(Player,"CoinBag") > 0 then
				MaxCoins = MaxCoins + 5;
			end]]

			if Player == RoleData.Murderer then
				Role = "Murderer";
			elseif Player == RoleData.Sheriff then
				Role = "Sheriff";
			end

			GameMode.PlayerData[Player.Name] = {
				["Role"] = Role;
				["CodeName"] = CodeNames[CodeName];
				["Color"] = BrickColor.new(Colors[Color]);
				["Dead"] = false;
				["XP"] = Data.Get(Player,"XP");
				["Knife"] = Data.Get(Player,"Weapons").Equipped.Knife;
				["Gun"] = Data.Get(Player,"Weapons").Equipped.Gun;
				["Coins"] = 0;
				["MaxCoins"] = MaxCoins;
				["Effect"] = Data.Get(Player,"Perks").Equipped[1];
			};

			pcall(function() Player.Character.Head.CodeNameGUI:Destroy();end);
			pcall(function() Player.Character.UpperTorso.roblox:Destroy();end);	
			table.remove(CodeNames,CodeName);
			table.remove(Colors,Color)
		end
	end
	return GameMode.PlayerData;
end


local function PrintTable(Table,Indent)
	local IndentString = "";
	for i = 1,Indent do
		IndentString = IndentString .. "--";
	end
	for Index,Value in pairs(Table) do
		if type(Value) == "table" then
			
			PrintTable(Value,Indent+1);
		else
			
		end;
	end
end


GameMode.Reward = function(PlayerData,TimerData)
	local Winner = "Innocents";
	local XPTexts = {};
	local WinTexts = {};
	local WinTextsColor = {};
	local Frame1 = {};
	local Frame2 = {};
	local Frame3 = {};

	for _,pData in pairs(PlayerData) do
		if pData["Role"] == "Murderer" and pData["Dead"] == false and TimerData > 0 then
			Winner = "Murderer";
		end
	end	
	for _,pData in pairs(PlayerData) do
		if pData["Role"] == "Sheriff" and PlayerData[RoleData.MurdererName]["Dead"] == true and _G.MurdererWasShot ==  true then
			Winner = "Sheriff";
		end
	end
	for _,pData in pairs(PlayerData) do
		if pData["Role"] == "Hero" and PlayerData[RoleData.MurdererName]["Dead"] == true and _G.MurdererWasShot ==  true then
			Winner = "Hero";
		end
	end

	for PlayerName,pData in pairs(PlayerData) do
		local DropTable;	
		spawn(function()
			local Player = game.Players:FindFirstChild(PlayerName);
			if pData["Role"] ~= "Murderer" then
				GameFunctions["Chance"].Increase(PlayerName);
			else
				GameFunctions["Chance"].Reset(PlayerName);
			end

			pcall(function()
				if _G.ServerSettings.Disguises then
					local NewGUI = game.ServerStorage.CodeNameGUI:Clone();
					NewGUI.ImageLabel.Image = require(game.ReplicatedStorage.CodeImages)[pData["CodeName"]];
					NewGUI.ImageLabel.ImageColor3 = pData["Color"].Color;
					NewGUI.Parent = Player.Character.Head;
				end;
			end);
			pcall(function()
				local XPText;
				local WinText;
				local WinTextColor;
				local FrameOne;
				local FrameTwo;
				local FrameThree;
				if Player ~= nil then
					if pData["Role"] == "Murderer" then
						if pData["Dead"] == true or TimerData <= 0 then
							Data.Give(Player,"XP",10);
							local Amount = 10*10;
							Amount = (_G.CheckElite(Player) and Amount*1.5) or (_G.CheckMythic(Player) and Amount*3) or Amount;
							WinTexts[Player] = "Defeat..."
							Frame1[Player]  = "DefeatMurderer"
							XPTexts[Player] = "+" .. Amount .. "";
							WinTextsColor[Player] = Color3.new(0.8, 0.0705882, 0.0705882)
						else
							Data.Give(Player,"XP",50);
							local Amount = 50*10;
							Amount = (_G.CheckElite(Player) and Amount*1.5) or (_G.CheckMythic(Player) and Amount*3) or Amount;
							WinTexts[Player] = "Victory!"
							Frame1[Player]  = "VictoryMurderer"
							XPTexts[Player] = "+" .. Amount .. "";
							WinTextsColor[Player] = Color3.new(1,0,0)
						end

					elseif 	pData["Role"] == "Sheriff" then
						if pData["Dead"] == false and PlayerData[RoleData.MurdererName]["Dead"] == true then
							local Amount1 = 50*10;
							Amount1 = (_G.CheckElite(Player) and Amount1*1.5) or (_G.CheckMythic(Player) and Amount1*3) or Amount1;

							local Amount2 = (GameFunctions["StandardFunctions"].CountInnocentsAlive(PlayerData)*100);
							Amount2 = (_G.CheckElite(Player) and Amount2*1.5) or (_G.CheckMythic(Player) and Amount2*3) or Amount2;

							Data.Give(Player,"XP",50+(GameFunctions["StandardFunctions"].CountInnocentsAlive(PlayerData)*10));
							XPTexts[Player] = "+" .. Amount1 + Amount2  .. "";
							WinTextsColor[Player] = Color3.new(0.333333, 1, 0.466667)
							Frame1[Player]  = "SherifWon"
							WinTexts[Player] = "Saved " .. GameFunctions["StandardFunctions"].CountInnocentsAlive(PlayerData) .. " Innocents!"
						else
							local Amount = 10*10;
							Amount = (_G.CheckElite(Player) and Amount*1.5) or (_G.CheckMythic(Player) and Amount*3) or Amount;
							Data.Give(Player,"XP",10);
							XPTexts[Player] = "+" .. Amount .. "";
							WinTexts[Player] = "Defeat..."
							Frame1[Player]  = "SherifLost"
							WinTextsColor[Player] = Color3.new(0.8, 0.0705882, 0.0705882)
						end

					elseif pData["Role"] == "Hero" then
						if pData["Dead"] == false and PlayerData[RoleData.MurdererName]["Dead"] == true then
							local Amount = 200*10;
							Amount = (_G.CheckElite(Player) and Amount*1.5) or (_G.CheckMythic(Player) and Amount*3) or Amount;
							Data.Give(Player,"XP",200);
							XPTexts[Player] = "+" .. Amount .. "";
							WinTexts[Player] = "Hero Bonus!"
							Frame1[Player]  = "HeroBonus"
							WinTextsColor[Player] = Color3.new(1,1,0)
						elseif pData["Dead"] == false then
							local Amount = (230-TimerData)*10;
							Amount = (_G.CheckElite(Player) and Amount*1.5) or (_G.CheckMythic(Player) and Amount*3) or Amount;

							Data.Give(Player,"XP",230-TimerData);
							XPTexts[Player] = "+" .. Amount .. "";
							Frame1[Player]  = "PersonWon"
							WinTexts[Player] = "Survived for " .. 230-TimerData .. " seconds"
						else
							local Amount = 10*10;
							Amount = (_G.CheckElite(Player) and Amount*1.5) or (_G.CheckMythic(Player) and Amount*3) or Amount;
							Frame1[Player]  = "PersonLost"
							Data.Give(Player,"XP",10);
							XPTexts[Player] = "+" .. Amount .. "";
							WinTexts[Player] = "Defeat..."
							WinTextsColor[Player] = Color3.new(0.8, 0.0705882, 0.0705882)
						end

					elseif pData["Role"] == "Innocent"	then
						if pData["Dead"] == false then
							Player["leaderstats"].IW.Value += 1
							local Amount = (230-TimerData)*10;

							Amount = (_G.CheckElite(Player) and Amount*1.5) or (_G.CheckMythic(Player) and Amount*3) or Amount;
							Frame1[Player]  = "InnocentWins"
							Data.Give(Player,"XP",230-TimerData);
							XPTexts[Player] = "+" .. Amount .. "";
							WinTexts[Player] = "Victory Bonus!"	
							WinTextsColor[Player] = Color3.new(0,1,0)
						else
							local Amount = 10*10;
							Amount = (_G.CheckElite(Player) and Amount*1.5) or (_G.CheckMythic(Player) and Amount*3) or Amount;
							Data.Give(Player,"XP",10);
							Frame1[Player]  = "InnocentsLost"
							XPTexts[Player] = "+" .. Amount .. "";
							WinTexts[Player] = "Defeat..."
							WinTextsColor[Player] = Color3.new(0.8, 0.0705882, 0.0705882)
						end
					end


					--if Data.Get(game.Players[Player],"CoinBag") > 0 then
					--Data.Give(game.Players[Player],"CoinBag",-1); -- coin bag expiry
					--end
				end
				--Data.SaveData(Player);
				local TitleText = (Winner=="Murderer" and "Murderer has won." or Winner=="Sheriff" and "The Sheriff has saved the day!" or Winner=="Hero" and "A Hero has saved the day!") or "Innocents win!";
				local TitleTextColor = (Winner=="Murderer" and Color3.new(255, 0, 0)) or Winner=="Sheriff" and Color3.new(0, 0.34902, 1) or Winner=="Hero" and Color3.new(255, 255, 0) or Color3.new(0, 255, 0)
				game.ReplicatedStorage.GameOver:FireClient(Player,PlayerData,TimerData,GameMode.Name,XPTexts[Player],WinTexts[Player],WinTextsColor[Player],Frame1[Player],Frame2[Player],Frame3[Player],Winner,TitleText,TitleTextColor);
				_G.OutfitsDisabled = false;
			end);
		end);
	end;
	--[[for _,Player in pairs(game.Players:GetPlayers()) do
		local XPText = "";
		if XPTexts[Player.Name] ~= nil then
			XPText = XPTexts[Player.Name]
		end;
		game.ReplicatedStorage.GameOver:FireClient(Player,PlayerData,TimerData,GameMode.Name,XPText,Winner);
	end]]

	_G.MurderWasShot = false;
end


return GameMode;










