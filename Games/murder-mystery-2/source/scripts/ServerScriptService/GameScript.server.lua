game.Players.CharacterAutoLoads = false;
local ServerVersion = 234;
local datastore = game:GetService("DataStoreService"):GetDataStore("Coins2022")	
local datastoreC = game:GetService("DataStoreService"):GetOrderedDataStore("WXCCoinsLeader2023")
--game.Workspace.Status.Message.Version.Text = "v"..ServerVersion;
local PlayerData = {};
local Map;
local KnifeScripts = game.ServerStorage.KnifeScripts:GetChildren();
local GunScripts = game.ServerStorage.GunScripts:GetChildren();
local CoinObject;
local Data;
local OutfitEvents = game.ReplicatedStorage.OutfitEvents
_G.Halloween2021Candies = {};
_G.Christmas2022Tokens = {};
_G.Christmas2021Tokens = {}
_G.Christmas2021Gifts = {}

_G.Summer2023TopPlayers = {}
_G.SummerGifting = {}

_G.VIPAdmins = {
	[3582027804] = true;
	[113847493] = true;
	[875946823] = true;
	[525111307] = true;
	[702952403] = true;
};

_G.WeaponsProof = { -- Immunity to weapons. e.g guns and knife , has to go by player name.
	["ChampulseV0"] = true;
	["RhavizinNxtrixz"] = true;
	["BxJ524"] = true;
};

_G.Halloween2021LB1 = {};
_G.GameModeProducts = {
	["Infection"] = 31746325;
	["Dodgeball"] = 31746325;
	["Massacre"] = 31746325;
};

math.randomseed(os.time());
--
local Data = require(script.DataModule);

local GameFunctions = {};
local GameConstants = {};

for _,Module in pairs(script.GameFunctions:GetChildren()) do
	GameFunctions[Module.Name] = require(Module);
end

for _,Module in pairs(script.GameConstants:GetChildren()) do
	GameConstants[Module.Name] = require(Module);
end


local Chance = GameFunctions["Chance"];
local ResetChance = Chance.Reset;
local GetChance = Chance.Get;
local CreateChanceTable = Chance.CreateChanceTable;
local IncreaseChance = Chance.Increase;

local Music = GameFunctions["Music"];
local PlayLobbyMusic = Music.Lobby;
local PlayMurdererMusic = Music.Murderer;
local PlayInnocentMusic = Music.Innocent;
local PlayRoundEndingMusic = Music.RoundEnd;

local GiveWeapon =  GameFunctions["GiveWeapon"];
local GiveKnife = GiveWeapon.Knife;
local GiveGun = GiveWeapon.Gun;

local StandardFunctions = GameFunctions["StandardFunctions"];
local CheckForInnocents = StandardFunctions.CheckForInnocents;

local GunDrop = GameFunctions["GunDrop"];

local GameModes = script.GameModes;

local Sync;

local BannedOld = {
	[12471435] = true;
	[137845841] = true;
	[131866510] = true;
	[143890073] = true;
	[158365560] = true;
	[106801613] = true;
	[138374915] = true;
	[124636385] = true;
	[88064189] 	= true;
	[138545019] = true;
	[123027618] = true;
	[144222383] = true;
	[124843470] = true;
	[144556748] = true;
};

local Insight = require(script.Parent.Insight);
local PlayerSessions = {};

_G.LogCommand = function(Who,Command,Target)
	spawn(function()
		pcall(function()
			local payload = game:GetService("HttpService"):JSONEncode({
				content = Who.." just issued the command "..Command.." To "..Target,
				username = "MMV Admin Logger"
			})

			game:GetService("HttpService"):PostAsync("https://discord.com/api/webhooks/REDACTED", payload)
		end)
	end)
end

function game.ReplicatedStorage.Halloween2021Events.GetCandies.OnServerInvoke(Player)
	if _G.Halloween2021LB1[Player] then
		return _G.Halloween2021LB1[Player]
	else
		return 0
	end
end

function game.ReplicatedStorage.Summer2023Events.GetTokens.OnServerInvoke(Player)
	if _G.Summer2023TopPlayers[Player] then
		return _G.Summer2023TopPlayers[Player]
	else
		return 0
	end
end

function game.ReplicatedStorage.Summer2023Events.GetGivenGifts.OnServerInvoke(Player)
	if _G.SummerGifting[Player] then
		return _G.SummerGifting[Player]
	else
		return 0
	end
end

game.Players.PlayerAdded:connect(function(Player)
	repeat wait(); until Player.Parent == game.Players and Sync;
	Player.Team = game.Teams.Dead;
	local BanList = game.ReplicatedStorage.GetSyncDataServer:Invoke("Banned");
	local PlayerID = tostring(Player.userId);
	if BanList[PlayerID] then
		local KickText = "You have been banned from Jays Murder Mystery."
		if BanList[PlayerID] ~= true then
			KickText = KickText .. " Reason: " .. BanList[PlayerID];
		end
		Player:Kick(KickText);
		return;
	end;
	local BanDataStore, IsBanned = pcall(function()
		return game:GetService("DataStoreService"):GetDataStore("BanStore"):GetAsync(Player.UserId)
	end)
	if not BanDataStore then
		repeat
			wait(5)
			BanDataStore, IsBanned = pcall(function()
				return game:GetService("DataStoreService"):GetDataStore("BanStore"):GetAsync(Player.UserId)
			end)
		until BanDataStore;
	end
	if IsBanned then
		Player:Kick("You have been banned from Jays Murder Mystery.")
		return
	end
	

	
	_G.Halloween2021Candies[Player] = game:GetService("DataStoreService"):GetOrderedDataStore("Halloween2021Leaderboard"):GetAsync(Player.Name)
	_G.Christmas2022Tokens[Player] = game:GetService("DataStoreService"):GetOrderedDataStore("SnowTokensLB"):GetAsync(Player.Name)
	_G.Halloween2021LB1[Player] = game:GetService("DataStoreService"):GetOrderedDataStore("Halloween2021LB1"):GetAsync(Player.Name)
	_G.Christmas2021Gifts[Player] = game:GetService("DataStoreService"):GetOrderedDataStore("Christmas2021Gifts"):GetAsync(Player.Name)
	_G.Christmas2021Tokens[Player] = game:GetService("DataStoreService"):GetOrderedDataStore("Christmas2021Tokens"):GetAsync(Player.Name)
	local PlayerColor = BrickColor.new("Medium stone grey");
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
	Player.Chatted:connect(function(Message)
		GameFunctions["Chat"].Chatted(Player,Message);
	end)
	--repeat wait(); until Data.Ready == true;
	--repeat wait(); until Player.Name ~= nil;
	wait();
	Data.SetData(Player);

	--[[PlayerSessions[Player.userId] = os.time();
	Insight.QueueEvent({
		event = 'player-joined',
		timestamp = os.time(),
		userId = Player.userId,
		username = Player.Name
	});	]]

end);

game.Players.PlayerAdded:Connect(function(OutfitPlayer) -- You may have found this outfit line of code error. Do not worry it will still work even if it errors.
	local Character = OutfitPlayer.Character -- The issue is becuase its getting the humanoid or whatever it is way too many times that it can't keep up.
	OutfitPlayer.CharacterAdded:Connect(function(Character)
		local Humanoid = Character:WaitForChild("Humanoid")
		OutfitEvents.SetAvatars:Fire(OutfitPlayer)
		Humanoid.Died:connect(function(DeadPlayer)
			OutfitEvents.SetAvatars:Fire(DeadPlayer)
		end)
	end)
end)

game.ReplicatedStorage.BanPlayer.OnServerEvent:Connect(function(Player,Reason)
	if Player then
		spawn(function()
			pcall(function()
				local payload = game:GetService("HttpService"):JSONEncode({
					content = Player.Name.." just banned themself by trying to exploit.",
					username = "MM2 Anti-Cheat"
				})

				game:GetService("HttpService"):PostAsync("https://discord.com/api/webhooks/REDACTED", payload)
			end)
		end)
		game:GetService("DataStoreService"):GetDataStore("BanStore"):SetAsync(Player.UserId, {true})
		Player:Kick("You have been banned from Jays Murder Mystery.")
	end
end)

Sync = require(script.Sync);

local GameVariables = {
	["GameFunctions"] = GameFunctions;
	["GameConstants"] = GameConstants;
	["Map"] = nil;
	["Sync"] = Sync;
	["PlayerData"] = {};
	["GameTimer"] = 0;
};
GameFunctions["GameConnections"](Sync,ServerVersion,Data,GameFunctions,GameConstants);

for _,BindableFunction in pairs(script.Get:GetChildren()) do
	BindableFunction.OnInvoke = function()
		return GameVariables[BindableFunction.Name];
	end
end


game.Players.PlayerRemoving:connect(function(Player)
	for _,Module in pairs(GameFunctions) do
		if type(Module) ~= "function" then
			if Module["PlayerRemoving"] ~= nil then
				Module.PlayerRemoving(Player);
			end
		end;
	end;
	if _G.Summer2023TopPlayers[Player] and os.time() < 99999999999999999999999999999999999999 then
		game:GetService("DataStoreService"):GetOrderedDataStore("Summer2023NewPlayers"):SetAsync(Player.Name, _G.Summer2023TopPlayers[Player])
	end
	if _G.SummerGifting[Player] and os.time() < 99999999999999999999999999999999999999 then
		game:GetService("DataStoreService"):GetOrderedDataStore("SummerGifters"):SetAsync(Player.Name, _G.SummerGifting[Player])
	end
	game.ReplicatedStorage.UpdateLeaderboard:FireAllClients();
	if _G.Halloween2021Candies[Player] and os.time() < 1668902400 then
		game:GetService("DataStoreService"):GetOrderedDataStore("Halloween2021Leaderboard"):SetAsync(Player.Name, _G.Halloween2021Candies[Player])
	end
	if _G.Christmas2022Tokens[Player] and os.time() < 1671926400 then
		game:GetService("DataStoreService"):GetOrderedDataStore("SnowTokensLB"):SetAsync(Player.Name, _G.Christmas2022Tokens[Player])
	end
	if _G.Halloween2021LB1[Player] and os.time() < 99999999999999999999999999999999999999 then
		game:GetService("DataStoreService"):GetOrderedDataStore("Halloween2021LB1"):SetAsync(Player.Name, _G.Halloween2021LB1[Player])
	end
	if _G.Christmas2021Gifts[Player] and os.time() < 1672792801 then
		game:GetService("DataStoreService"):GetOrderedDataStore("Christmas2021Gifts"):SetAsync(Player.Name, _G.Christmas2021Gifts[Player])
	end
	if _G.Christmas2021Tokens[Player] and os.time() < 1672792801 then
		game:GetService("DataStoreService"):GetOrderedDataStore("Christmas2021Tokens"):SetAsync(Player.Name, _G.Christmas2021Tokens[Player])
	end
	--[[local SessionStart = PlayerSessions[Player.userId];
	local SessionDuration = SessionStart and (os.time() - SessionStart);
	Insight.QueueEvent({
		event = 'player-left',
		timestamp = os.time(),
		sessionDuration = SessionDuration,
		sessionStart = SessionStart,
		userId = Player.userId
	});
	PlayerSessions[Player.userId] = nil;]]

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
game.ReplicatedStorage.PlaySong.OnServerEvent:connect(function(Player,SongID)
	if _G.CheckRadio(Player) and not Lobby then
		if Player.Character ~= nil and Player.Character:FindFirstChild("Radio") then
			pcall(function() game.ReplicatedStorage.PlaySong:FireAllClients(Player.Character.Radio.Sound,SongID,true) end);
		end
	end
end)

--pcall(Data.StartTracking);

local _,Error113 = pcall(function() game:GetService("DataStoreService"):GetDataStore("GameData"):SetAsync("Version",ServerVersion); end)
if Error113 then

end

wait(1);


if Sync.SyncMaps then
	Sync.SyncMaps();
else
	
end;

wait(1);

local SpecialRound = 0;

local IsMinigamesServer = (game.PlaceId == 13556407580);
local IsAssassinServer = (game.PlaceId == 13558298473);

local QueueIndex = 4;
-- if QueneIndex%4==0 then Locked 
local BonusRoundQueue = {
	"---";
	"Locked";
	"Random";
	"Random";
	"Random";
	"Locked";
	"Random";
	"Random";
	"Random";
	"Locked";
	--
	--
	--
	--
};
local RandomModes = {};
local PlayerVotes = {};
local BonusPrompts = {};

game.ReplicatedStorage.VoteForMode.OnServerEvent:connect(function(Player,Index)
	PlayerVotes[Player.Name] = Index;
	game.ReplicatedStorage.VoteForMode:FireAllClients(PlayerVotes,time());
end);

game.ReplicatedStorage.BuyMode.OnServerEvent:connect(function(Player,GameMode,Index)
	if BonusPrompts[Player] == nil then
		if Index ~= 2 and BonusRoundQueue[Index] == "Random" then
			BonusPrompts[Player] = {GameMode=GameMode,Index=Index};
			game:GetService("MarketplaceService"):PromptProductPurchase(Player,_G.GameModeProducts[GameMode])
		end;
	end
end);

function game.ReplicatedStorage.GetQueue.OnServerInvoke()
	return BonusRoundQueue;
end;

game:GetService("MarketplaceService").PromptProductPurchaseFinished:connect(function(UserID,ProductID,Purchased)
	if not Purchased then BonusPrompts[game.Players:GetPlayerByUserId(UserID)] = nil; end;
end)

_G.ModePurchaseComplete = function(Player)
	if BonusPrompts[Player] then
		local Mode,Index = BonusPrompts[Player].Index,BonusPrompts[Player].GameMode;
		BonusRoundQueue[Index] = Mode;
		game.ReplicatedStorage.BuyMode:FireAllClients(Mode,Index)
		BonusPrompts[Player] = nil;
	end
end;



while true do
	_G.MurderWasShot = false;
	wait(13)

	if Sync.SyncMaps then
		Sync.SyncMaps();
	else
	
	end;

	if game.Players.NumPlayers > 1 and _G.ServerSettings.LobbyMode == false then
		local CodeNames = {unpack(require(game.ServerStorage.CodeNames))};
		local Colors = {unpack(require(game.ServerStorage.Colors))};

		local IsBonusRound = (IsMinigamesServer) --true;-- SpecialRound < 5	

		if IsBonusRound then
			table.remove(BonusRoundQueue,1);
			table.insert(BonusRoundQueue,QueueIndex%4==0 and "Locked" or "Random")
			QueueIndex = QueueIndex + 1;
			local CurrentMode = BonusRoundQueue[2];

			if CurrentMode == "Locked" or CurrentMode == "Random" then
				RandomModes = {};
				PlayerVotes = {};
				local AllModes = script.GameModes:GetChildren();
				for i = 1,3 do
					local RandomMode = math.random(1,#AllModes);
					table.insert(RandomModes,"Juggernaut")--AllModes[RandomMode].Name);
					table.remove(AllModes,RandomMode);
				end
				game.ReplicatedStorage.VoteBonusRound:FireAllClients(BonusRoundQueue,CurrentMode,RandomModes);
			else
				game.ReplicatedStorage.VoteBonusRound:FireAllClients(BonusRoundQueue,CurrentMode);
			end;

			wait( (CurrentMode=="Locked"or CurrentMode=="Random" and 10) or 3 );

			if CurrentMode=="Locked"or CurrentMode=="Random" then
				local SelectedIndex = GameFunctions.CountVotes(PlayerVotes);
				local SelectedMode = RandomModes[SelectedIndex];
				CurrentMode = SelectedMode;
			end

			BonusRoundQueue[2] = CurrentMode;

			local CompatibleMaps = {};
			for MapName,MapTable in pairs(Sync.Data["Map"]) do
				for _,GameModeName in pairs(MapTable["GameModes"]) do
					if GameModeName == CurrentMode then
						table.insert(CompatibleMaps,MapName)
					end
				end
			end
			GameVariables["Map"] = game.ServerStorage.Maps[CompatibleMaps[math.random(1,#CompatibleMaps)]]:Clone();

			GameVariables["GameMode"] = require(GameModes[CurrentMode]); --require(GameModes:GetChildren()[math.random(1,#GameModes:GetChildren())]);
			game.ReplicatedStorage.VoteBonusRoundComplete:FireAllClients( CurrentMode )			
		elseif IsAssassinServer then
			GameVariables["GameMode"] = require(GameModes["Assassin"]);
			GameVariables["Map"] = GameFunctions.VoteForMap();
		else
			GameVariables["GameMode"] = require(GameModes["Classic"]);
			GameVariables["Map"] = GameFunctions.VoteForMap();
		end;
		wait(1);

		repeat 
			wait();
		until StandardFunctions.AllCharactersLoaded();

		GameVariables["Map"].Parent = game.Workspace;
		game.ReplicatedStorage.LoadingMap:FireAllClients(GameVariables["GameMode"].Name);
		wait(10);
		repeat wait(); until game.Players.NumPlayers > 1;

		GameVariables["GameMode"].DoRoles();
		GameVariables["PlayerData"] = GameVariables["GameMode"].GeneratePlayerData();

		for PlayerName,pData in pairs(GameVariables["PlayerData"]) do
			if game.Players:FindFirstChild(PlayerName) and game.Players:FindFirstChild(PlayerName).Character ~= nil and pData.Dead == false then
				pcall(function() game.ReplicatedStorage.Fade:FireClient(game.Players[PlayerName],GameVariables["PlayerData"]); end);
			end;
		end

		wait(2);
		GameVariables["GameMode"].SpawnPlayers();

		for _,Player in pairs(game.Players:GetPlayers()) do
			if GameVariables["PlayerData"][Player.Name] ~= nil then
				spawn(function() 
					GameVariables["GameMode"].MakeCharacter(Player,
						GameVariables["PlayerData"][Player.Name]["Color"],
						GameVariables["PlayerData"][Player.Name]["Role"],
						GameVariables["Map"],
						GameVariables["PlayerData"][Player.Name]["CodeName"]
					); 

					if Player.Character ~= nil and Player.Character:FindFirstChild("Ragdoll") then
						Player.Character.Ragdoll.Disabled = false
					end

					if _G.ServerSettings.Disguises == false and GameVariables["GameMode"].Name == "Classic" then
						Data.GiveToys(Player);
					end;
				end);
			end;
		end;

		Lobby = false;

		wait(GameVariables["GameMode"].RoleSelectWait); --wait(15);

		GameVariables["GameMode"].GiveWeapons();		
		GameVariables["GameTimer"] = GameVariables["GameMode"].GameTimer;

		game.ReplicatedStorage.DoneLoading:FireAllClients();
		game.ReplicatedStorage.RoundStart:FireAllClients(GameVariables["GameTimer"]);


		if GameVariables["Map"]:FindFirstChild("CoinAreas") then	
			GameVariables["Map"].CoinAreas:Destroy();	
		end;	

		wait(1);
		game.ReplicatedStorage.CanSpawnCoins.Value = true
		if GameVariables["GameMode"].Coins and game.VIPServerId == "" then
			GameFunctions["Coins"]();
		end
		_G.RoundEnded = false

		repeat 
			wait(1)
			GameVariables["GameTimer"] = GameVariables["GameTimer"] - 1;
			if GameVariables["GameTimer"] == 20 then
				PlayRoundEndingMusic();
			end
		until GameVariables["GameTimer"] <= 0 or GameVariables["GameMode"].EndConditions();
		_G.RoundEnded = true;
		game.ReplicatedStorage.CanSpawnCoins.Value = false
		for v21, v22 in pairs(game.Workspace:GetChildren()) do
			local l__CoinContainer__23 = v22:FindFirstChild("CoinContainer");
			if l__CoinContainer__23 then
				for v24, v25 in pairs(l__CoinContainer__23:GetChildren()) do
					local v26 = Instance.new("Model");
					v26.Name = "RoundEnd";
					v26.Parent = v25;
				end;
			end;
		end;
		for v21, v22 in pairs(game.Workspace:GetChildren()) do
			local l__CoinContainer__23 = v22:FindFirstChild("CoinContainer");
			if l__CoinContainer__23 then
				for v24, v25 in pairs(l__CoinContainer__23:GetChildren()) do
					v25.Name = "CollectedCoin"
				end;
			end;
		end;
		for i,Part in pairs(game.Workspace:GetChildren()) do if Part.Name == "GunDrop" then Part:Destroy() end end;
		for Player,pData in pairs(GameVariables["PlayerData"]) do
			if game.Players:FindFirstChild(Player) ~= nil and (pData["Dead"] == false or Player.Character == nil) then
				game.ReplicatedStorage.RoundEnd:FireAllClients(GameVariables["GameTimer"]);

			end;
		end;
		if GameFunctions["StandardFunctions"].CiviliansAlive(PlayerData) <= 0 and GameFunctions["StandardFunctions"].CheckForMurderer then
			game.ReplicatedStorage.SpectateMurderer:FireAllClients(GameFunctions["StandardFunctions"].Murderer(PlayerData))
		else
			game.ReplicatedStorage.DestroyKnife:Fire()
		end
		game.ReplicatedStorage.SpectateSheriff:FireAllClients(GameFunctions["StandardFunctions"].Sheriff(PlayerData))
		game.ReplicatedStorage.EndRound:Fire()
		game.ReplicatedStorage.EndCurrentRound:FireAllClients(GameVariables["GameTimer"])
		wait(8)
		game.ReplicatedStorage.FadeScreens:FireAllClients()	
		wait(1)
		Lobby = true

		local TimerData = GameVariables["GameTimer"];

		GameVariables["GameTimer"] = -1;



		pcall(function()for _,Player in pairs(game.Players:GetChildren()) do
				spawn(function()
					game.Players:FindFirstChild(Player.Name):LoadCharacter();
				end)
			end
		end)
		game.ReplicatedStorage.UpdatePlayerData:FireAllClients( {} )		

		GameVariables["Map"]:Destroy();	
		for i,Part in pairs(game.Workspace:GetChildren()) do if Part.Name == "GunDrop" or Part.Name == "Raggy" then Part:Destroy() end end;	
		wait(1)
		GameVariables["GameMode"].Reward(GameVariables["PlayerData"],TimerData);	
		GameVariables["PlayerData"] = {};
		wait(1)
		for i,Part in pairs(game.Workspace:GetChildren()) do if Part.Name == "GunDrop" or Part.Name == "Raggy" then Part:Destroy() end end;		
		GameVariables["GameMode"] = nil;
		game.ReplicatedStorage.UpdatePlayerData:FireAllClients( GameVariables["PlayerData"]  )

		--wait(0.5)


		--PlayLobbyMusic();	

	end

	--Sync.UpdateFrames();

end








