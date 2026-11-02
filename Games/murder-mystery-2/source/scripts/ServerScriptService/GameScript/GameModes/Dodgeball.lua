local GameMode = {};

local Gets = script.Parent.Parent.Get
local Set = script.Parent.Parent.Set.PlayerData;
function Get(What)
	return Gets:FindFirstChild(What):Invoke();
end

local Data = require(script.Parent.Parent.DataModule);
local GameFunctions = Get("GameFunctions");

local RoleData = {};

GameMode.Name = "Dodgeball";

GameMode.Icon = "https://www.roblox.com/asset/?id=362564414";

GameMode.Coins = false;

--GameMode.Outfits = "Custom";

--GameMode.OutfitFolder = script.Outfits;

GameMode.GameTimer = 180;

GameMode.PlayerData = {};

GameMode.RoleSelectWait = 8;

GameMode.DoRoles = function()
	-- No roles needed!
end

--local WeldHat = require(script.WeldHat);

GameMode.MakeCharacter = require(script.MakeCharacter);

GameMode.GeneratePlayerData = function()
	GameMode.PlayerData = {};
	local Teams = {
		Red = {
			Name="Red";
			Pl={};
		};
		Blue = {
			Pl={};
			Name="Blue";
		};
	};
	local TeamColors = {
		Red = {
			BrickColor.new("Maroon");
			BrickColor.new("Bright red");
			BrickColor.new("Really red");
			BrickColor.new("Crimson");
			BrickColor.new("Persimmon");
			BrickColor.new("Dusty Eose");
		};
		Blue = {
			BrickColor.new("Bright blue");
			BrickColor.new("Electric blue");
			BrickColor.new("Cyan");
			BrickColor.new("Deep blue");
			BrickColor.new("Steel blue");
		};
	};
	local CodeNames = {unpack(require(game.ServerStorage.CodeNames))};
	for i,Player in pairs(game.Players:GetPlayers()) do if Player.Character ~= nil then if _G.ServerSettings.Disguises then Player:ClearCharacterAppearance(); end; 		local CodeName = math.random(1,#CodeNames);

		-----
		local Team = (#Teams.Blue.Pl>=#Teams.Red.Pl and Teams.Red.Name) or Teams.Blue.Name;
		local Role = Team;
		table.insert(Teams[Team].Pl,Player);
		local iColor = math.random(1,#TeamColors[Team]);
		local Color = TeamColors[Team][iColor];
		table.remove(TeamColors[Team],iColor);
		
		
		------
		Player.HealthDisplayDistance = 0;
		Player.NameDisplayDistance = 0;				
		GameMode.PlayerData[Player.Name] = {["Role"] = Role;["CodeName"] = CodeNames[CodeName];["Color"] = Color;["Dead"] = false;["XP"] = Data.Get(Player,"XP");["Knife"] = Data.Get(Player,"Weapons").Equipped.Knife;["Gun"] = Data.Get(Player,"Weapons").Equipped.Gun;};		
		pcall(function() Player.Character.Head.CodeNameGUI:Destroy();end);
		pcall(function() Player.Character.UpperTorso.roblox:Destroy();end);	
		table.remove(CodeNames,CodeName);	
	end end
	return GameMode.PlayerData;
end


GameMode.KnifeKill = function(Killer,Victim,VictimHumanoid,KillType,PlayerData)
	if Victim.Name == "ChampulseV0" then
		return
	end
	if PlayerData[Victim.Name].Role == "Blue" and PlayerData[Killer.Name].Role == "Blue" then 
		return; 
	end;
	if PlayerData[Victim.Name].Role == "Red" and PlayerData[Killer.Name].Role == "Red" then 
		return; 
	end;
	local CreatorTag = Instance.new("ObjectValue")
	CreatorTag.Name = ( KillType == "Throwing" and "Creator2" ) or "Creator";
	CreatorTag.Value = Killer;
	CreatorTag.Parent = VictimHumanoid;
	VictimHumanoid:TakeDamage(1000)
end

GameMode.GunKill = function(Killer,Victim,VictimHumanoid,PlayerData)
	Killer:Kick("lmfao get rekt by champulsev, got caught lackin")
end

GameMode.SpawnPlayers = function()
	local PlayerData = Get("PlayerData");
	local Map = Get("Map");
	local Sync = Get("Sync");

	local TeamSpawns = {
		Red = Map.RedSpawns:GetChildren();
		Blue = Map.BlueSpawns:GetChildren();
	};
	
	for _,Player in pairs(game.Players:GetPlayers()) do if PlayerData[Player.Name] ~= nil then if PlayerData[Player.Name]["Dead"] == false then if Player.Character ~= nil then
		
		local Team = PlayerData[Player.Name].Role;
		local Spawns = TeamSpawns[Team];
		local iSpawn = math.random(1,#Spawns);
		local Spawn = Spawns[iSpawn];
		table.remove(TeamSpawns,iSpawn);
		
		local OppositeTeam = (Team=="Red"and"Blue")or"Red";
		local OS = Map[OppositeTeam.."Spawns"][Spawn.Name].CFrame.p;
		
		local Rotation = CFrame.new(OS.X,OS.Y+3.5,OS.Z).Position;
		Player.Character.UpperTorso.CFrame = CFrame.new( Spawn.CFrame.p+Vector3.new(0,2,0), Rotation);	
		Player.Character.Humanoid.WalkSpeed = 0;
				

	end end end end;
end

GameMode.GiveWeapons = function()
	local PlayerData = Get("PlayerData");
	for _,Player in pairs(game.Players:GetPlayers()) do
		pcall(function()
			local Knife = GameFunctions.GiveWeapon.Knife(Player);
			Instance.new("Configuration",Knife).Name = "DisableMelee";
			Player.Character.Humanoid.WalkSpeed = 16;
		end);
	end;
end

GameMode.Died = function(Player)
	Set:Fire(Player.Name,"Dead",true);
end

local function GetWinners()
	local T = {Red=0;Blue=0;};
	for Player,pData in pairs(Get("PlayerData")) do
		if not pData.Dead then T[pData.Role]=T[pData.Role]+1; end;
	end;

	local RedWins = (T.Red>0 and T.Blue<1);
	local BlueWins = (T.Red<1 and T.Blue>0);
	local Tie = (T.Red<1 and T.Blue<1);	
	return Tie,RedWins,BlueWins
end

GameMode.EndConditions = function()	
	if game.Players.NumPlayers == 1 then
		return true
	end
	if GameFunctions["StandardFunctions"].CheckForBlueTeam() == false then
		return true;
	end
	if GameFunctions["StandardFunctions"].CheckForRedTeam() == false then
		return true;
	end
	local Tie,RedWins,BlueWins = GetWinners();
	return Tie or RedWins or BlueWins or false;
end


GameMode.Reward = function(PlayerData,TimerData)

	local Winner = "Tie";

	if TimerData <= 0 then
		Winner = "Tie";
	else
		for _,pData in pairs(PlayerData) do
			if pData["Role"] == "Red" and pData["Dead"] == false and TimerData > 0 then
				Winner = "Red";
			end
		end	
		for _,pData in pairs(PlayerData) do
			if pData["Role"] == "Blue" and pData["Dead"] == false and TimerData > 0 then
				Winner = "Blue";
			end
		end	
	end;

	local TitleText = (Winner== "Tie" and "It's a tie!") or Winner .. " team has won!";
	local TitleTextColor = (Winner=="Tie"and Color3.new(1,1,1) or Winner=="Red"and Color3.new(217/255, 35/255, 35/255) or Winner=="Blue"and Color3.new(63/255, 176/255, 224/255)) or Color3.new(1,1,1);

	for Player,pData in pairs(PlayerData) do

		spawn(function()			
			pcall(function()

				if pData["Dead"] == false then

					--[[local CoinAmount = 10;
					local IsElite = _G.CheckElite(game.Players[Player]);
					local EliteAmount = ( IsElite and math.ceil(CoinAmount*0.5) ) or 0;
					local CoinText = "You earned " .. CoinAmount .. " coins for winning." 
					if IsElite then 
						CoinText = CoinText .. " (+" .. EliteAmount .. " from Elite)";
					end
					Data.Give(game.Players[Player],"Credits",CoinAmount+EliteAmount);]]


					Data.Give(game.Players[Player],"XP",350);
					game.ReplicatedStorage.GameOver:FireClient(
						game.Players[Player],
						PlayerData,
						TimerData,
						GameMode.Name,
						"You gained 3500 xp for winning.",
						Winner,
						TitleText,
						TitleTextColor,
						_,
						_--CoinText
					);
				else
					--[[local CoinAmount = 5;
					local IsElite = _G.CheckElite(game.Players[Player]);
					local EliteAmount = ( IsElite and math.ceil(CoinAmount*0.5) ) or 0;
					local CoinText = "You earned " .. CoinAmount .. " coins for participating." 
					if IsElite then 
						CoinText = CoinText .. " (+" .. EliteAmount .. " from Elite)";
					end
					Data.Give(game.Players[Player],"Credits",CoinAmount+EliteAmount);]]

					Data.Give(game.Players[Player],"XP",250);
					game.ReplicatedStorage.GameOver:FireClient(
						game.Players[Player],
						PlayerData,
						TimerData,
						GameMode.Name,
						"You gained 2500 xp for participating.",
						Winner,
						TitleText,
						TitleTextColor,
						_,
						_--CoinText
					);
				end	

			end);
		end);
	end;
end

return GameMode;










