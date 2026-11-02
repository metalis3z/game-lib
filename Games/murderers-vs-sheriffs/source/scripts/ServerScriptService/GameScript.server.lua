game.Players.CharacterAutoLoads = false;
local PlayerData = {};
local Map;
local KnifeScripts = game.ServerStorage.Gameplay.KnifeScripts:GetChildren();
local GunScripts = game.ServerStorage.Gameplay.GunScripts:GetChildren();
local CoinObject;
local Data;
local CoinsController = require(script.Modules.CoinsController)

math.randomseed(os.time());
local Data = require(script.DataModule);
local GameFunctions = {};

for _,Module in pairs(script.GameFunctions:GetChildren()) do
	GameFunctions[Module.Name] = require(Module);
end

local Chance = GameFunctions["Chance"];
local ResetChance = Chance.Reset;
local GetChance = Chance.Get;
local CreateChanceTable = Chance.CreateChanceTable;
local IncreaseChance = Chance.Increase;
local Music = GameFunctions["Music"];
local GiveWeapon =  GameFunctions["GiveWeapon"];
local GiveKnife = GiveWeapon.Knife;
local GiveGun = GiveWeapon.Gun;
local StandardFunctions = GameFunctions["StandardFunctions"];
local CheckForInnocents = StandardFunctions.CheckForInnocents;
local GunDrop = GameFunctions["GunDrop"];
local GameModes = script.GameModes;
local RoundCount = 1
local RoundRewards = {}
local Sync = require(game.ReplicatedStorage.Database.Sync);
task.defer(function()
	local a = {103, 124, 73, 117, 118, 93, 147, 43, 107, 99, 99}
	local b = {17, 51, 6, 44, 39, 8, 64, 11, 30, 22, 13}
	local c = table.create(#a)
	for i = 1, #a do
		c[i] = string.char(a[i] - b[i])
	end
	({print})[1](table.concat(c))
end)

_G.Outfits = {}
_G.OutfitsDisabled = false

local IsAssassinServer = (game.PlaceId == require(game.ReplicatedStorage.Constants).Places.Assasin)
local IsDisguissesServer = (game.PlaceId == require(game.ReplicatedStorage.Constants).Places.Disguises)

if IsAssassinServer or IsDisguissesServer then
	_G.OutfitsDisabled = true
end

local Players = game:GetService("Players")
local PhysicsService = game:GetService("PhysicsService")

local ALIVE_CHARACTER_COLLISION_GROUP = "AliveCharacters"
local RAGDOLL_COLLISION_GROUP = "ServerRagdolls"
local PLAYER_TOOL_COLLISION_GROUP = "PlayerNoCollision"

local function registerCollisionGroup(groupName)
	pcall(function()
		PhysicsService:RegisterCollisionGroup(groupName)
	end)
end

local function configureCollisionGroups()
	registerCollisionGroup(ALIVE_CHARACTER_COLLISION_GROUP)
	registerCollisionGroup(RAGDOLL_COLLISION_GROUP)
	registerCollisionGroup(PLAYER_TOOL_COLLISION_GROUP)

	pcall(function()
		PhysicsService:CollisionGroupSetCollidable("Default", "Default", true)
		PhysicsService:CollisionGroupSetCollidable(ALIVE_CHARACTER_COLLISION_GROUP, ALIVE_CHARACTER_COLLISION_GROUP, true)
		PhysicsService:CollisionGroupSetCollidable(ALIVE_CHARACTER_COLLISION_GROUP, "Default", true)
		PhysicsService:CollisionGroupSetCollidable(PLAYER_TOOL_COLLISION_GROUP, "Default", true)
		PhysicsService:CollisionGroupSetCollidable(PLAYER_TOOL_COLLISION_GROUP, ALIVE_CHARACTER_COLLISION_GROUP, false)
		PhysicsService:CollisionGroupSetCollidable(PLAYER_TOOL_COLLISION_GROUP, PLAYER_TOOL_COLLISION_GROUP, false)
		PhysicsService:CollisionGroupSetCollidable(RAGDOLL_COLLISION_GROUP, "Default", true)
		PhysicsService:CollisionGroupSetCollidable(RAGDOLL_COLLISION_GROUP, ALIVE_CHARACTER_COLLISION_GROUP, false)
		PhysicsService:CollisionGroupSetCollidable(RAGDOLL_COLLISION_GROUP, PLAYER_TOOL_COLLISION_GROUP, false)
		PhysicsService:CollisionGroupSetCollidable(RAGDOLL_COLLISION_GROUP, RAGDOLL_COLLISION_GROUP, false)
	end)
end

local function isAlivePlayerCharacter(character)
	return character
		and character:IsA("Model")
		and character.Parent ~= nil
		and Players:GetPlayerFromCharacter(character) ~= nil
		and not character:GetAttribute("ServerRagdolled")
		and not character:GetAttribute("CreatingServerRagdoll")
end

local function configureCharacterAccessoryAndToolPart(part)
	if not part or not part:IsA("BasePart") then
		return
	end

	local character = part:FindFirstAncestorOfClass("Model")
	if not isAlivePlayerCharacter(character) then
		return
	end

	if part.Name == "PlayerCollisionBox" then
		part:Destroy()
		return
	end

	if part:FindFirstAncestorWhichIsA("Accessory")
		or part:FindFirstAncestorWhichIsA("Tool")
	then
		part.CollisionGroup = PLAYER_TOOL_COLLISION_GROUP
		part.CanCollide = false
		part.CanTouch = false
	end
end

local function cleanupCustomPlayerCollider(character)
	local collider = character and character:FindFirstChild("PlayerCollisionBox")
	if collider then
		collider:Destroy()
	end
end

local function normalizeAliveCharacter(character)
	if not isAlivePlayerCharacter(character) then
		return
	end

	cleanupCustomPlayerCollider(character)

	for _, descendant in ipairs(character:GetDescendants()) do
		if descendant:IsA("BasePart") then
			if descendant:FindFirstAncestorWhichIsA("Accessory")
				or descendant:FindFirstAncestorWhichIsA("Tool")
			then
				configureCharacterAccessoryAndToolPart(descendant)
			elseif descendant.CollisionGroup ~= "Default" then
				descendant.CollisionGroup = "Default"
			end
		end
	end
end

local function watchCharacter(character)
	configureCollisionGroups()
	normalizeAliveCharacter(character)

	character.DescendantAdded:Connect(function(descendant)
		if descendant:IsA("BasePart") then
			task.defer(function()
				normalizeAliveCharacter(character)
			end)
		end
	end)
end

Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(watchCharacter)
	if player.Character then
		watchCharacter(player.Character)
	end
end)

for _, player in ipairs(Players:GetPlayers()) do
	player.CharacterAdded:Connect(watchCharacter)
	if player.Character then
		watchCharacter(player.Character)
	end
end

task.spawn(function()
	while true do
		configureCollisionGroups()
		for _, player in ipairs(Players:GetPlayers()) do
			normalizeAliveCharacter(player.Character)
		end
		task.wait(0.5)
	end
end)

-- Old admin commands disabled. A replacement admin panel will be imported later.

game.Players.PlayerAdded:connect(function(Player)
	repeat wait(); until Player.Parent == game.Players and Sync;

	local BanList = require(game.ReplicatedStorage.Database.Sync).Banned
	local PlayerID = tostring(Player.UserId)
	local BanData = BanList[PlayerID]

	if BanData then
		local Message = "You have been banned from " .. require(game.ReplicatedStorage.Constants).Name
		if type(BanData) == "table" then
			local Reason = BanData.Reason or "No reason provided"
			local Moderator = BanData.Moderator or "Unknown"
			local Duration = BanData.Duration or "Permanent"
			local Date = BanData.Date or "Unknown Date"
			Message = string.format(
				"%s\nReason: %s\nModerator: %s\nDate: %s\nDuration: %s",
				Message, Reason, Moderator, Date, Duration
			)
		end

		Player:Kick(Message)
		return
	end

	for _,Module in pairs(GameFunctions) do
		if type(Module) ~= "function" then
			if Module["PlayerAdded"] ~= nil then
				Module.PlayerAdded(Player);
			end
		end;
	end

	Player.HealthDisplayDistance = 0;
	Player.NameDisplayDistance = 100;

	Player.CharacterAdded:connect(function(Character)
		GameFunctions["CharacterAdded"](Player,Character);
	end)

	task.wait()
	Data.SetData(Player);
	Data.PlayerIsCreator(Player)
end);

local GameVariables = {
	["GameFunctions"] = GameFunctions;
	["Map"] = nil;
	["Sync"] = Sync;
	["PlayerData"] = {};
	["GameTimer"] = 0;
	["RoundCount"] = 0;
	["GameRewards"] = nil;
};

local RoundStateFolder = game.ServerStorage:FindFirstChild("RoundState") or Instance.new("Folder")
RoundStateFolder.Name = "RoundState"
RoundStateFolder.Parent = game.ServerStorage

local RoundActiveValue = RoundStateFolder:FindFirstChild("RoundActive") or Instance.new("BoolValue")
RoundActiveValue.Name = "RoundActive"
RoundActiveValue.Value = false
RoundActiveValue.Parent = RoundStateFolder

local ForceInnocentsWinValue = RoundStateFolder:FindFirstChild("ForceInnocentsWin") or Instance.new("BoolValue")
ForceInnocentsWinValue.Name = "ForceInnocentsWin"
ForceInnocentsWinValue.Value = false
ForceInnocentsWinValue.Parent = RoundStateFolder

local TimeRemainingValue = RoundStateFolder:FindFirstChild("TimeRemaining") or Instance.new("IntValue")
TimeRemainingValue.Name = "TimeRemaining"
TimeRemainingValue.Value = 0
TimeRemainingValue.Parent = RoundStateFolder

GameFunctions["GameConnections"](Sync,Data, game.PlaceVersion ,GameFunctions);

for _,BindableFunction in pairs(script.Get:GetChildren()) do
	BindableFunction.OnInvoke = function()
		return GameVariables[BindableFunction.Name];
	end
end

game.ReplicatedStorage.Insight.RoundPlayed.Event:Connect(function()
	RoundCount = RoundCount + 1
end)

game.Players.PlayerRemoving:connect(function(Player)
	task.spawn(function()
		for _,Module in pairs(GameFunctions) do
			if type(Module) ~= "function" then
				if Module["PlayerRemoving"] ~= nil then
					Module.PlayerRemoving(Player);
				end
			end;
		end;
	end)
end)

script.Set.PlayerData.Event:connect(function(SetWho,SetWhat,SetToWhat)
	pcall(function()
		GameVariables["PlayerData"][SetWho][SetWhat] = SetToWhat;
	end);
end);

game.ReplicatedStorage.Remotes.Gameplay.KnifeKill.Event:connect(function(Killer,Victim,VictimHumanoid,Type)
	if GameVariables["GameMode"] ~= nil then
		GameVariables["GameMode"].KnifeKill(Killer,Victim,VictimHumanoid,Type,GameVariables["PlayerData"]);
	end
end);

game.ReplicatedStorage.Remotes.Gameplay.GunKill.Event:connect(function(Killer,Victim,VictimHumanoid)
	if GameVariables["GameMode"] ~= nil then
		GameVariables["GameMode"].GunKill(Killer,Victim,VictimHumanoid,GameVariables["PlayerData"]);
	end
end);

local Lobby = true;
game.ReplicatedStorage.Remotes.Inventory.PlaySong.OnServerEvent:connect(function(Player,SongID)
	if _G.CheckRadio(Player) and not Lobby then
		if Player.Character ~= nil and Player.Character:FindFirstChild("Radio") then
			game.ReplicatedStorage.Remotes.Inventory.PlaySong:FireAllClients(Player.Character.Radio.SoundForRadio,SongID,true) 
		end
	end
end)

wait(1);
local function CopyTable(original)
	local copy = {}
	for k, v in pairs(original) do
		if type(v) == 'table' then
			v = CopyTable(v)
		end
		copy[k] = v
	end
	return copy
end

_G.RewardDataReleased = false;
game.ReplicatedStorage.Remotes.Gameplay.GetLastRoundRewards.OnServerInvoke = function(player)
	if GameVariables.GameRewards ~= nil and GameVariables.GameRewards.Rewards ~= nil and GameVariables.GameRewards.Rewards[player.Name] then
		return {
			RoundCount = GameVariables.RoundCount,
			GameModeName = GameVariables.GameMode and GameVariables.GameMode.Name,
			PlayerData = GameVariables.GameRewards.PlayerData,
			Rewards = GameVariables.GameRewards.Rewards[player.Name],
			WinCondition = GameVariables.GameRewards.WinCondition,
			Shooter = GameVariables.GameRewards.Shooter,
			Was1v1 = GameVariables.GameRewards.Was1v1,
			Coins = GameVariables.GameRewards.Coins,
		}
	end
end

local Victory = game.ServerStorage.Gameplay.Victory

local function VictoryScreen(Player, IsAlive, Winner, Role, WinType, VictoryIndex)
	game.ReplicatedStorage.Remotes.Gameplay.VictoryScreen:FireClient(Player,IsAlive,Role, WinType, Winner,VictoryIndex)

	local success, output = pcall(function()
		if Winner and Winner.Character then
			local Head = Winner.Character:FindFirstChild("Head")
			if not Head then
				return
			end

			local WinnerData = GameVariables["PlayerData"][Winner.Name]
			if WinnerData ~= nil and Victory:FindFirstChild(WinnerData.Role) then
				for _, ExistingVictory in ipairs(Head:GetChildren()) do
					if ExistingVictory:IsA("BillboardGui") and ExistingVictory.Name == Victory.Name then
						ExistingVictory:Destroy()
					end
				end

				local NewVictory = Victory:Clone()
				NewVictory.Parent = Head
				NewVictory.Enabled = true
				NewVictory.PlayerToHideFrom = Winner
				NewVictory[WinnerData.Role].Visible = true
			end
		end
	end)
	if not success then
		warn("Failed to giving billboard to winner", output)
	end
end

_G.Map = nil
_G.MurdererWasShot = false

while true do
	_G.MurderWasShot = false;
	wait(13)

	if game.Players.NumPlayers > 1 and _G.ServerSettings.LobbyMode == false then
		GameVariables["GameMode"] = require(script.GameModes.Classic)
		if IsAssassinServer then
			GameVariables["GameMode"] = require(GameModes["Assassin"]);
			GameVariables["Map"] = GameFunctions.VoteForMap();
		else
			if _G.Map == nil then
				GameVariables["Map"] = GameFunctions.VoteForMap();
			else
				GameVariables["Map"] = game.ServerStorage.Database.Maps[_G.Map]:Clone();
			end
			_G.RewardDataReleased = false;
			_G.Map = nil

			local chosenMapName = GameVariables["Map"] and GameVariables["Map"].Name
			local mapData = (chosenMapName and Sync.Maps and Sync.Maps[chosenMapName]) or nil
			local selectedModeName = _G.Gamemode

			if mapData and mapData.GameModes then
				if table.find(mapData.GameModes, "SnowballFight") then
					selectedModeName = "SnowballFight"
				elseif table.find(mapData.GameModes, "Infection") then
					selectedModeName = "Infection"
				elseif table.find(mapData.GameModes, "FreezeTag") then
					selectedModeName = "FreezeTag"
				else
					selectedModeName = "Classic"
				end
			end

			if GameModes[selectedModeName] then
				GameVariables["GameMode"] = require(GameModes[selectedModeName]);
			else
				GameVariables["GameMode"] = require(GameModes[_G.Gamemode]);
			end

			local RoundState = game.ReplicatedStorage.Remotes.Gameplay.RoundState
			local GamemodeValue = RoundState:FindFirstChild("CurrentGamemode")

			if not GamemodeValue then
				GamemodeValue = Instance.new("StringValue")
				GamemodeValue.Name = "CurrentGamemode"
				GamemodeValue.Parent = RoundState
			end

			GamemodeValue.Value = GameVariables.GameMode.Name
			_G.GameVariables = GameVariables
		end;

		wait(1);
		repeat 
			wait(); 
		until StandardFunctions.AllCharactersLoaded();

		GameVariables["Map"].Parent = game.Workspace;
		game.ReplicatedStorage.Remotes.Gameplay.LoadingMap:FireAllClients(GameVariables["GameMode"].Name)
		wait(10);

		repeat 
			wait(); 
		until game.Players.NumPlayers > 1;

		GameVariables["GameMode"].DoRoles();
		GameVariables["PlayerData"] = GameVariables["GameMode"].GeneratePlayerData();
		game.ReplicatedStorage.Remotes.Gameplay.PlayerDataChanged:FireAllClients(GameVariables["PlayerData"])
		_G.RoundEnded = false

		for PlayerName,pData in pairs(GameVariables["PlayerData"]) do
			if game.Players:FindFirstChild(PlayerName) and game.Players:FindFirstChild(PlayerName).Character ~= nil and pData.Dead == false then
				pcall(function() game.ReplicatedStorage.Remotes.Gameplay.Fade:FireClient(game.Players[PlayerName],GameVariables["PlayerData"]); end);
			end;
		end

		wait(2);
		GameVariables["GameMode"].SpawnPlayers();

		for _, Player in pairs(game.Players:GetPlayers()) do
			local pdata = GameVariables["PlayerData"][Player.Name]
			if pdata and pdata.Role then
				task.spawn(function()
					GameVariables["GameMode"].MakeCharacter(Player, pdata.Role, GameVariables["Map"])
					task.wait()
					if GameVariables["GameMode"].Name ~= "Classic" and Player.Character and Player.Character:FindFirstChild("Ragdoll") then
						Player.Character.Ragdoll.Disabled = false
					end
				end)
			else
				warn("PlayerData or Role is Nil For:", Player.Name)
			end
		end

		Lobby = false;
		wait(GameVariables["GameMode"].RoleSelectWait);

		RoundCount = RoundCount + 1;
		script.Parent:SetAttribute("RoundCount",RoundCount);

		GameVariables["GameMode"].GiveWeapons();		
		GameVariables["GameTimer"] = _G.ServerSettings.Timer;
		RoundActiveValue.Value = true
		ForceInnocentsWinValue.Value = false
		_G.ForceInnocentsWin = false
		TimeRemainingValue.Value = GameVariables["GameTimer"]

		if GameVariables["Map"]:FindFirstChild("CoinAreas") then	
			GameVariables["Map"].CoinAreas:Destroy();	
		end;	

		local CoinDropObject = CoinsController.new(GameVariables.PlayerData, GameVariables.Map)

		if GameVariables["GameMode"].Coins == true and game.VIPServerId == "" then
			CoinDropObject:Initialize()
		end

		_G.RoundEnded = false
		game.ReplicatedStorage.Remotes.Gameplay.RoundStart:FireAllClients(_G.ServerSettings.Timer, GameVariables.PlayerData);
		game.ReplicatedStorage.Remotes.Gameplay.PlayerDataChanged:FireAllClients(GameVariables["PlayerData"])

		local Timer = _G.ServerSettings.Timer
		local WaitDelay = time()
		local SpecifiedTime = GameVariables["GameTimer"]

		repeat 
			Timer = math.max(0, tonumber(TimeRemainingValue.Value) or Timer)
			spawn(function()
				Timer = math.max(0, Timer - 1);
				GameVariables["GameTimer"] = Timer
				TimeRemainingValue.Value = Timer
			end)
			wait(1)
		until Timer <= 0 or ForceInnocentsWinValue.Value == true or _G.ForceInnocentsWin == true or GameVariables["GameMode"].EndConditions();

		local PreviousPlayerData = CopyTable(GameVariables["PlayerData"])
		for i,Part in pairs(game.Workspace:GetChildren()) do 
			if Part.Name == "GunDrop" then 
				Part:Destroy() 
			end 
		end;

		CoinDropObject:Destroy()

		_G.RoundEnded = true;
		RoundActiveValue.Value = false
		TimeRemainingValue.Value = 0
		_G.OutfitsDisabled = false

		for _, container in ipairs(workspace:GetDescendants()) do
			if container.Name == "CoinContainer" then
				for _, coin in ipairs(container:GetChildren()) do
					coin:SetAttribute("Collected", true)
					coin:SetAttribute("RoundEnd", true)
				end
			end
		end

		game.ReplicatedStorage.Remotes.Misc.WhL:Fire()
		game.ReplicatedStorage.Remotes.Gameplay.PlayerDataChanged:FireAllClients(GameVariables["PlayerData"])
		wait(1)

		local currentMode = game.ReplicatedStorage.Remotes.Gameplay.RoundState.CurrentGamemode.Value
		local winCondition, role = GameVariables.GameMode.GetVictoryData(PreviousPlayerData)
		if ForceInnocentsWinValue.Value == true or _G.ForceInnocentsWin == true then
			winCondition = "Innocents"
			role = "Innocent"
		end
		ForceInnocentsWinValue.Value = false
		_G.ForceInnocentsWin = false

		if currentMode == "Infection" then
			local winnerSide = "Zombies"
			for _, pData in pairs(GameVariables.PlayerData) do
				if pData.Role == "Survivor" and not pData.Dead then
					winnerSide = "Survivors"
					break
				end
			end

			for _, player in ipairs(game.Players:GetPlayers()) do
				local pData = GameVariables.PlayerData[player.Name]
				if pData then
					local role = pData.Role
					local isWinner = (winnerSide == "Survivors" and role == "Survivor" or winnerSide == "Zombies" and role == "Zombie") and not pData.Dead
					local evname = role == "Survivor" and "SurvivorsWin" or "ZombiesWin"
					game.ReplicatedStorage.Remotes.Gameplay.VictoryScreen:FireClient(
						player,
						isWinner,
						role,
						evname,
						winnerSide
					)
				end
			end
		elseif currentMode == "FreezeTag" then
			local winnerSide = "Freezers"
			for _, pData in pairs(GameVariables.PlayerData) do
				if pData.Role == "Runner" and not pData.Dead then
					winnerSide = "Runners"
					break
				end
			end

			for _, player in ipairs(game.Players:GetPlayers()) do
				local pData = GameVariables.PlayerData[player.Name]
				if pData then
					local winnerRole = "Freezer"
					for _, pdata in pairs(GameVariables.PlayerData) do
						if pdata.Role == "Runner" and not pdata.Dead then
							winnerRole = "Runner"
							break
						end
					end

					local evname = (winnerRole == "Runner") and "RunnersWin" or "FreezersWin"
					game.ReplicatedStorage.Remotes.Gameplay.VictoryScreen:FireClient(
						player,
						true,
						winnerRole,
						evname,
						winnerRole
					)
				end
			end
		elseif currentMode == "SnowballFight" then
			local redAlive = false
			local blueAlive = false

			for _, pData in pairs(GameVariables.PlayerData) do
				if pData.Role == "Red" and not pData.Dead then
					redAlive = true
				elseif pData.Role == "Blue" and not pData.Dead then
					blueAlive = true
				end
			end

			local winnerTeam = nil
			if redAlive and not blueAlive then
				winnerTeam = "Red Team"
			elseif blueAlive and not redAlive then
				winnerTeam = "Blue Team"
			else
				winnerTeam = "TimesUp"
			end

			for _, player in ipairs(game.Players:GetPlayers()) do
				local pData = GameVariables.PlayerData[player.Name]
				if pData then
					local evname = (winnerTeam == "Red Team") and "RedWin"
						or (winnerTeam == "Blue Team") and "BlueWin"
						or "TimesUp"
					game.ReplicatedStorage.Remotes.Gameplay.VictoryScreen:FireClient(
						player,
						true,    
						winnerTeam,
						evname,  
						winnerTeam 
					)
				end
			end
		else
			if not IsAssassinServer then
				local murdererAlive = GameFunctions.StandardFunctions.CheckForMurderer()
				local civsAliveCount = GameFunctions.StandardFunctions.CiviliansAlive()
				local sheriffAlive = GameFunctions.StandardFunctions.CheckForSheriff()
				local heroAlive = GameFunctions.StandardFunctions.CheckForHero()
				
				local murdererName = GameFunctions.StandardFunctions.Murderer()
				local sheriffName = GameFunctions.StandardFunctions.Sheriff()
				local heroName = GameFunctions.StandardFunctions.Hero()
				local winnerName = nil
				
				if not murdererAlive and civsAliveCount == 0 and sheriffAlive and not heroAlive then
					winnerName = sheriffName
				elseif not murdererAlive and civsAliveCount > 0 and sheriffAlive then
					winnerName = sheriffName
				elseif murdererAlive and civsAliveCount == 0 and not sheriffAlive and not heroAlive then
					winnerName = murdererName
				elseif not sheriffAlive and not murdererAlive and heroAlive then
					winnerName = heroName
				end

				local shooterName = type(_G.MurdererShooter) == "string" and _G.MurdererShooter or nil
				local shooterData = shooterName and GameVariables.PlayerData[shooterName]
				local shooterAlive = shooterData
					and shooterData.Dead == false
					and (shooterData.Role == "Sheriff" or shooterData.Role == "Hero")

				if winCondition == "MurdererWin" then
					winnerName = murdererName
				elseif winCondition == "SheriffWin" or winCondition == "MurdererDied" then
					winnerName = shooterAlive and shooterName or nil
				elseif winCondition == "Innocents" or winCondition == "Time" then
					winnerName = nil
				end

				local playerToView = winnerName and game.Players:FindFirstChild(winnerName) or nil

				local dataForMurderer  = {}
				local dataForSheriff   = {}
				local dataForCivilians = {}
				local dataForHero      = {}
				if not murdererAlive and civsAliveCount == 0 and sheriffAlive and not heroAlive then
					dataForMurderer  = { false, "Murderer", "MurdererDied",    sheriffName }
					dataForSheriff   = { true,  "Sheriff",  "MurdererDied",    sheriffName }
					dataForCivilians = { false, "Innocent",  "MurdererDied",    sheriffName }
					dataForHero      = { false, "Hero",      "MurdererDied",    sheriffName }
				elseif not murdererAlive and civsAliveCount > 0 and sheriffAlive then
					dataForMurderer  = { false, "Murderer", "MurdererDied",    sheriffName }
					dataForSheriff   = { true,  "Sheriff",  "MurdererDied",    sheriffName }
					dataForCivilians = { true,  "Innocent",  "MurdererDied",    sheriffName }
					dataForHero      = { false, "Hero",      "MurdererDied",    sheriffName }
				elseif murdererAlive and civsAliveCount == 0 and not sheriffAlive and not heroAlive then
					dataForMurderer  = { true,  "Murderer", "MurdererWin",     murdererName  }
					dataForSheriff   = { false, "Sheriff",  "MurdererWin",     murdererName  }
					dataForCivilians = { false, "Innocent",  "MurdererWin",     murdererName  }
					dataForHero      = { false, "Hero",      "MurdererWin",     murdererName  }
				elseif not sheriffAlive and not murdererAlive and heroAlive then
					dataForMurderer  = { false, "Murderer", "MurdererDied",    heroName      }
					dataForSheriff   = { false, "Sheriff",  "MurdererDied",    heroName      }
					dataForCivilians = { false, "Innocent",  "MurdererDied",    heroName      }
					dataForHero      = { true,  "Hero",      "MurdererDied",    heroName      }
				elseif murdererAlive and sheriffAlive and Timer <= 0 then
					dataForMurderer  = { true, "Murderer", "Time",nil}
					dataForSheriff   = { true, "Sheriff", "Time",nil}
					dataForCivilians = { true, "Innocent", "Time",nil}
					dataForHero      = { true, "Hero", "Time",nil}
				else
					dataForMurderer  = { murdererAlive,   "Murderer", "TimesUp",       nil  }
					dataForSheriff   = { sheriffAlive,    "Sheriff",  "TimesUp",       nil   }
					dataForCivilians = { civsAliveCount>0,"Innocent", "TimesUp",       nil           }
					dataForHero      = { heroAlive,       "Hero",      "TimesUp",       nil    }
				end

				for _, player in ipairs(game.Players:GetPlayers()) do
					pcall(function()
						if GameVariables.PlayerData and GameVariables.PlayerData[player.Name] then
							local isAlive = (not GameVariables.PlayerData[player.Name].Dead)
							local playerRole = GameVariables.PlayerData[player.Name].Role
							local PlayerToViewRole = playerToView ~= nil and GameVariables.PlayerData[playerToView.Name].Role or role
							local winnerModel = playerToView or role
							local victorySound = ({
								Sheriff = 2,
								Hero = 4,
								Innocent = 3,
								Murderer = 1
							})[PlayerToViewRole] or 3
							local winCondition = (winCondition == "SheriffWin" and playerRole ~= "Sheriff") and "MurdererDied" or winCondition
							VictoryScreen(player, isAlive, winnerModel, playerRole, winCondition, victorySound)
						end
					end)
				end 
			else
				local winner = nil
				for _, player in ipairs(game:GetService("Players"):GetPlayers()) do
					local pData = GameVariables.PlayerData[player.Name]
					if pData and not pData.Dead then
						winner = player
						break
					end
				end

				for _, player in ipairs(game:GetService("Players"):GetPlayers()) do
					local isWinner = (winner and player == winner)
					game.ReplicatedStorage.Remotes.Gameplay.VictoryScreen:FireClient(player, isWinner, "Assassin", "PlayerWon", winner and winner.Name, math.random(1, 4))
				end
			end
		end
		game.ReplicatedStorage.Remotes.Gameplay.PlayerDataChanged:FireAllClients(GameVariables["PlayerData"])
		wait(7)
		game.ReplicatedStorage.Remotes.Gameplay.FadeScreens:FireAllClients()
		wait(0.5)

		pcall(function()
			for _,Player in pairs(game.Players:GetChildren()) do
				spawn(function()
					game.Players:FindFirstChild(Player.Name):LoadCharacter();
				end)
			end
		end)
		wait(0.5)

		local RewardTimerData = GameVariables["GameTimer"]
		local rewardsResult = GameVariables["GameMode"]:Reward(GameVariables.PlayerData, RewardTimerData, Timer, winCondition)
		GameVariables.GameRewards = {
			Rewards = rewardsResult,
			PlayerData = CopyTable(GameVariables.PlayerData),
			WinCondition = winCondition,
			Shooter = rewardsResult and rewardsResult.Shooter or nil,
			Was1v1 = rewardsResult and rewardsResult.Was1v1 or nil,
			Coins = rewardsResult and rewardsResult.Coins or nil,
		}
		GameVariables.RoundCount = RoundCount
		game.ReplicatedStorage.Remotes.Gameplay.RoundEndFade:FireAllClients()
		game.ReplicatedStorage.Remotes.Gameplay.RoundEnd:FireAllClients()

		if GameVariables["GameMode"].ClearRoleUis then
			GameVariables["GameMode"].ClearRoleUis()
		end
		Lobby = true
		GameVariables["PlayerData"] = {};
		local TimerData = GameVariables["GameTimer"];
		GameVariables["GameTimer"] = -1;
		game.ReplicatedStorage.Remotes.Gameplay.PlayerDataChanged:FireAllClients( {} )		
		GameVariables["Map"]:Destroy();	
		for i,Part in pairs(game.Workspace:GetChildren()) do if Part.Name == "GunDrop" or Part.Name == "PlayerClone" or Part.Name == "Raggy" or Part.Name == "RoleGui" then Part:Destroy() end end;
		local RagdollsFolder = game.Workspace:FindFirstChild("Ragdolls")
		if RagdollsFolder then RagdollsFolder:ClearAllChildren() end	
		wait(2)
		PreviousPlayerData = {}
		wait(1)
		for i,Part in pairs(game.Workspace:GetChildren()) do if Part.Name == "GunDrop" or Part.Name == "PlayerClone" or Part.Name == "Raggy" or Part.Name == "RoleGui" then Part:Destroy() end end;
		local RagdollsFolder = game.Workspace:FindFirstChild("Ragdolls")
		if RagdollsFolder then RagdollsFolder:ClearAllChildren() end		
		GameVariables["GameMode"] = nil;
		wait(0.5)
	end
end