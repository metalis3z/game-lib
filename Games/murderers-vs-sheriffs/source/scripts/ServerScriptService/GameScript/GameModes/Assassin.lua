local GameMode = {};
local Gets = script.Parent.Parent.Get
function Get(What)
	return Gets:FindFirstChild(What):Invoke();
end
local Data = require(script.Parent.Parent.DataModule);
local DataGet = function(Who,What)
	return game.ReplicatedStorage.GetDataServer:Invoke(Who,What)
end
local GameFunctions = Get("GameFunctions");
local RoleData = {};
GameMode.Name = "Assassin";
GameMode.Coins = true;
GameMode.GameTimer = 180;
GameMode.PlayerData = {};
GameMode.RoleSelectWait = 10;
GameMode.Targets = {};
GameMode.DoRoles = function() end
GameMode.SpawnPlayers = function()
	local Map = Get("Map");
	for _,Player in pairs(game.Players:GetPlayers()) do
		_G.RoundBegan = true;
		pcall(function()
			if Player.Character ~= nil then
				Player.Character.Humanoid.WalkSpeed = 16;
				Player.Character.HumanoidRootPart.CFrame = Map.Spawns:GetChildren()[math.random(1,#Map.Spawns:GetChildren())].CFrame + Vector3.new(0,2,0)
			end
		end);
	end;
end
GameMode.GiveWeapons = function()
	local PlayerData = GameMode.PlayerData;
	local Map = Get("Map");
	
	for _,Player in pairs(game.Players:GetPlayers()) do
		pcall(function()
			if PlayerData[Player.Name] ~= nil then
				GameFunctions.GiveWeapon.Knife(Player);
			end
		end);
	end;
end

GameMode.Died = function(Victim)
	for i,PlayerName in pairs(GameMode.Targets) do
		if PlayerName == Victim.Name then
			table.remove(GameMode.Targets,i);
		end
	end
	for i,PlayerName in pairs(GameMode.Targets) do
		local Player = game.Players:FindFirstChild(PlayerName);
		if Player and GameMode.GetTarget(Player) then
			game.ReplicatedStorage.ChangeTarget:FireClient(
				Player,
				GameMode.GetTarget(Player),
				game.Players:FindFirstChild(GameMode.GetTarget(Player)).UserId,
				Data.Get(game.Players[GameMode.GetTarget(Player)],"Weapons").Equipped.Knife,
				Data.Get(game.Players[GameMode.GetTarget(Player)],"Weapons").Equipped.Gun
			);
		end;
	end;
end

game.Players.PlayerRemoving:connect(GameMode.Died);

local cooldown = false;
GameMode.KnifeKill = function(Killer,Victim,VictimHumanoid,KillType,PlayerData)
	if cooldown then
		return
	end
	local TargetKill = (GameMode.GetTarget(Killer) == Victim.Name);
	local HunterKill = (GameMode.GetTarget(Victim) == Killer.Name);

	if TargetKill or HunterKill and not cooldown then
		cooldown = true;
		local CreatorTag = Instance.new("ObjectValue")
		CreatorTag.Name = ( KillType == "Throwing" and "Creator2" ) or "Creator";
		CreatorTag.Value = Killer;
		CreatorTag.Parent = VictimHumanoid;
		VictimHumanoid:TakeDamage(1000)

		repeat wait(); until GameMode.PlayerData[Victim.Name].Dead == true or GameMode.GameTimer <=0;


	elseif GameMode.PlayerData[Victim.Name].Dead == false and not cooldown then
		cooldown = true;

		pcall(function() Killer.Backpack.Knife:Destroy(); end);
		pcall(function() Killer.Character.Knife:Destroy(); end);

		wait(3);

		if GameMode.PlayerData[Killer.Name].Dead == false then
			GameFunctions.GiveWeapon.Knife(Killer);
		end

	end;
	wait(1);
	cooldown = false;
end


GameMode.GunKill = function(Killer,Victim,VictimHumanoid,PlayerData) end
GameMode.EndConditions = function()

	local AliveCount = 0;

	for _,pData in pairs(Get("PlayerData")) do
		if pData["Dead"] == false then
			AliveCount = AliveCount+1;
		end
	end

	return (AliveCount<=1);
end


GameMode.MakeCharacter = function(Player,Color,RoleName,Map,CodeName)
	local targetName = GameMode.GetTarget(Player)
	local targetPlayer = game.Players:FindFirstChild(targetName)

	if targetPlayer then
		game.ReplicatedStorage.Remotes.Gameplay.RoleSelect:FireClient(Player,
			RoleName,
			Color, 
			CodeName,
			false,
			"Assassin",
			targetName,
			targetPlayer.UserId,
			Data.Get(targetPlayer, "Weapons").Equipped.Knife,
			Data.Get(targetPlayer, "Weapons").Equipped.Gun,
			targetPlayer.UserId
		)
	end

	
end

GameMode.GetTarget = function(Player)
	local PlayerIndex;
	for Index,iPlayer in pairs(GameMode.Targets) do
		if iPlayer == Player.Name then
			PlayerIndex = Index;
			break;
		end
	end
	if PlayerIndex then
		local Target;
		if GameMode.Targets[PlayerIndex+1] then
			Target = GameMode.Targets[PlayerIndex+1];
		elseif GameMode.Targets[1] and GameMode.Targets[1]~=Player.Name then
			Target = GameMode.Targets[1];
		end;
		print(Target);
		return Target;
	end	
end
GameMode.GeneratePlayerData = function()
	GameMode.PlayerData = {};
	GameMode.Targets = {};
	for _,Player in pairs(game.Players:GetPlayers()) do
		if Player.Character ~= nil then
			Player.HealthDisplayDistance = 0;			
			local MaxCoins;
			if Data.GetLevel(Data.Get(Player,"XP")) >= 40 then
				MaxCoins = 10;
			else
				MaxCoins = 5;
			end;
			GameMode.PlayerData[Player.Name] = {
				["Dead"] = false;
				["XP"] = Data.Get(Player,"XP");
				["Knife"] = Data.Get(Player,"Weapons").Equipped.Knife;
				["Gun"] = Data.Get(Player,"Weapons").Equipped.Gun;
				["Coins"] = 0;
				["MaxCoins"] = MaxCoins;
				["Role"] = "Murderer";
				["Eliminations"] = 0;
				["Effect"] = Data.Get(Player,"Effects").Equipped[1];
			};
		end
	end
	local PlayerTable = {};
	for Player,_ in pairs(GameMode.PlayerData) do
		local Index;
		repeat
			Index = math.random(1,100);
		until PlayerTable[Index] == nil;
		PlayerTable[Index] = Player;
	end
	for i,Player in pairs(PlayerTable) do
		table.insert(GameMode.Targets,Player);
	end
	
	return GameMode.PlayerData;
end


GameMode.Reward = function(PlayerData,TimerData)
	local Winner = "Nobody";
	if TimerData <= 0 then
		Winner = "Nobody";
	else
		for pName,pData in pairs(PlayerData) do
			if pData["Dead"] == false then
				Winner = pName;
				break;
			end
		end;
	end;
	local TitleText = (Winner=="Nobody"and"Timer ran out, no one wins...") or Winner .. " is the last one standing!";
	local TitleTextColor = (Winner=="Nobody"and Color3.new(1,1,1))or Color3.new(1,0,0);
	for Player,pData in pairs(PlayerData) do
		spawn(function()	
			
			
			--[[pcall(function()
				if pData["Dead"] == false then
					
					Data.Give(game.Players[Player],"XP",50);
					game.ReplicatedStorage.GameOver:FireClient(
						game.Players[Player],
						PlayerData,
						TimerData,
						GameMode.Name,
						"You gained 500 xp for winning.",
						Winner,
						TitleText,
						TitleTextColor,
						_,
						_--CoinText
					);
				else
					Data.Give(game.Players[Player],"XP",10);
					game.ReplicatedStorage.GameOver:FireClient(
						game.Players[Player],
						PlayerData,
						TimerData,
						GameMode.Name,
						"You gained 100 xp for participating.",
						Winner,
						TitleText,
						TitleTextColor,
						_,
						_--CoinText
					);
				end	
				
			end);]]
			
			
		end);
	end;
end


return GameMode;










