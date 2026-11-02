local RoundManager = {
	Map = nil,
	RoundLoop = nil,
	CurrentPlayers = {},
	Set6AM = false
}

-- <- Types -> --
type PlayerTable = {
	PlayerInstance: Player,
	Data: {},
	FinishedIntro: boolean,
	Team: string
}

type KillerTable = {
	PlayerInstance: Player,
	CurrentChances: number,
	KillerCharacter: string,
	KillerSkin: string
}

-- <- Services -> --
local Players = game:GetService('Players');
local ServerStorage = game:GetService('ServerStorage');
local RunService = game:GetService('RunService');

-- <- Modules -> --
local CharacterManager = require('@game/ServerStorage/Modules/Managers/CharacterManager');
local CutsceneManager = require('@game/ServerStorage/Modules/Managers/CutsceneManager');
local MapManager = require('@game/ServerStorage/Modules/Managers/MapManager');
local PlayerDataModule = require('@game/ServerStorage/Modules/General/PlayerData');
local ServerUtil = require('@game/ServerStorage/Modules/ServerUtil');
local ToolKit = require('@game/ReplicatedStorage/Modules/ToolKit');

-- <- Private Variables -< --
local DefaultValues = {
	States = {
		DuringGame = 'GAME',
		Lobby = 'INTERMISSION',
		Waiting = 'WAITING'
	},
	OverTime = 30, -- // 30 seconds overtime before the match actually ends.
	IntermissionTime = 35,
	StartGameMinPlayers = 2,
	SixAmTime = 360, -- // 6 minutes ^^
	LMSForceTime = 300, -- // Force time for LMS (5 minutes)
	RoundTimeSpeed = 1.5,
	NormalTimeSpeed = 1,
	CutsceneTimeoutTime = 20,
	StudioBypass = true,
	LMSStudio = false
}

local IsStudio = RunService:IsStudio();

-- <- Public Variables -> --
local GAMEFolder = workspace.GAME

-- <- Private Functions -> --
local function GetKiller(PlayerTable: PlayerTable): KillerTable
	local KillerChosen = {
		PlayerInstance = nil,
		CurrentChances = 0,
		KillerCharacter = '',
		KillerSkin = ''
	}

	for Player, Data in PlayerTable do		
		local PlayerData = Data.Data
		if not PlayerData then			
			continue
		end

		local PlayerStats = PlayerData.Stats
		if not PlayerStats then			
			continue
		end

		local KillerChances = PlayerStats.KillerChance
		if not KillerChances then			
			continue
		end

		if KillerChances > KillerChosen.CurrentChances then
			KillerChosen.PlayerInstance = Player
			KillerChosen.CurrentChances = KillerChances
			KillerChosen.KillerCharacter = PlayerData['Character']['Killer']
			KillerChosen.KillerSkin = PlayerData['EquippedSkins'][KillerChosen.KillerCharacter] or 'Normal'
		end
	end

	if KillerChosen.PlayerInstance then
		local PlayerData = PlayerDataModule.GetPlayerData(KillerChosen.PlayerInstance);
		if not PlayerData then
			return
		end
		-- // Reset the player chances :3
		PlayerData.Data.Stats.KillerChance = 1
	end

	return KillerChosen
end

local function GetPlayers(): PlayerTable
	local PlayerTable = {}

	for _, Player in Players:GetChildren() do 
		if not Player:GetAttribute('LOADED') then
			warn(`{Player} isn't loaded`);

			continue
		end

		if Player:GetAttribute('AFK') then
			warn(`{Player} is afk`);

			continue
		end

		if Player:GetAttribute('TEAM') ~= 'Lobby' then
			warn(`{Player} isn't in the lobby`);
			
			continue
		end

		local Data = PlayerDataModule.GetPlayerData(Player);
		if not Data then
			continue
		end

		PlayerTable[Player] = {
			Data = Data.Data,
			FinishedIntro = false,
			Team = 'Survivor'
		}
	end

	return PlayerTable
end

local function PlayIntro(PlayerTable: PlayerTable, Type: string, Intro: string, KillerName: string): ()	
	local PlayersInIntro = {}
	local Time = 0

	for Player, Data in PlayerTable do
		PlayersInIntro[Player] = false
	end

	local PlayerRemovingConnection
	PlayerRemovingConnection = Players.PlayerRemoving:Connect(function(Player)
		PlayersInIntro[Player] = nil
		PlayerTable[Player] = nil
	end)

	for Player, _ in PlayersInIntro do
		task.spawn(function(): ()
			local Success, Result = pcall(function(): ()
				warn(`Playing {Type} for {Player}`);
				
				local NewCutscene = CutsceneManager.new(Player, `{Intro}{Type}`, KillerName);
				return NewCutscene:Play();
			end)

			if Success and Result and PlayersInIntro[Player] ~= nil then
				PlayersInIntro[Player] = true

				if PlayerTable[Player] then
					PlayerTable[Player].FinishedIntro = true
				end
			end
		end)
	end

	repeat task.wait(1)
		local EveryoneFinished = true
		
		Time += 1
		
		if Time >= DefaultValues.CutsceneTimeoutTime then
			Intermission();
			
			break
		end
		
		for _, HasFinished in PlayersInIntro do
			if not HasFinished then
				EveryoneFinished = false
				break
			end
		end

		if EveryoneFinished then
			break
		end
	until false

	PlayerRemovingConnection:Disconnect();

	return true
end

local function RequestCleanUp(): ()
	warn('Clean up...');
	
	if RoundManager.Map then
		RoundManager.Map:Destroy();
	end
	
	for Player: Player, Value in RoundManager.CurrentPlayers do 
		local PlayerMeta = CharacterManager.Players[Player]
		if not PlayerMeta then
			continue
		end
		
		Player:LoadCharacterAsync();
		PlayerMeta:SwitchCharacter('Lobby');
	end
	
	RoundManager.CurrentPlayers = {}
	RoundManager.RoundLoop = nil
	RoundManager.Map = nil
	RoundManager.Set6AM = false
	
	GAMEFolder.CURRENTMAP.Value = ''
	GAMEFolder.FORCEMAP.Value = ''
	GAMEFolder.Started.Value = false
	GAMEFolder.LMS.Value = false
	GAMEFolder.CAN_ESCAPE.Value = false
	GAMEFolder.RAGEMODE.Value = false -- there's a fucking rage mode?? qwq"
	GAMEFolder.TASKDONE.Value = 0
	GAMEFolder.TimeSpeed.Value = DefaultValues.NormalTimeSpeed
	
	Intermission();
end

local function SixAm(): ()
	warn('SIX AM ! (67)');
	workspace.FinalTime:Play();
	
	GAMEFolder.CAN_ESCAPE.Value = true
	
	RoundManager.Set6AM = true
	RoundManager.Map:SetupEscapePoint();
end

-- // TODO: Figure out where they store the LMS
local function LastManStanding(): ()
	GAMEFolder.TIMER.Value = DefaultValues.LMSForceTime
	GAMEFolder.LMS.Value = true
	
	for Player, _ in RoundManager.CurrentPlayers do 
		if not Player then
			continue
		end
		
		ServerUtil.SendScreenEffect(Player, {
			'LMS'
		});
	end
	
	workspace.LastManStandingSFX:Play();
end

local function SurvivorWon(): ()
	RequestCleanUp();

end

local function KillerWon(): ()
	
	RequestCleanUp();
end

local function StartRound(): ()
	RoundManager.RoundLoop = coroutine.wrap(function(): ()
		while task.wait(GAMEFolder.TimeSpeed.Value) do 
			if GAMEFolder.FROZENTIMER.Value == true then
				continue
			end
			
			GAMEFolder.TIMER.Value += 1
			
			local SurvivorAmount = #ToolKit.Character:GetAlive()
			local KillerAmount = #ToolKit.Character:GetKillers()
			
			if SurvivorAmount <= 0 and not (IsStudio and DefaultValues.StudioBypass) then
				warn(`No player left... :(`);
				
				KillerWon();
				
				break
			end
			
			if KillerAmount <= 0 and not (IsStudio and DefaultValues.StudioBypass) then
				warn(`No killer ?`);
				
				SurvivorWon();
				
				break
			end
			
			-- // Trigger the LMS if the game still haven't done it.
			if SurvivorAmount == 1 and not GAMEFolder.LMS.Value and not (IsStudio and DefaultValues.LMSStudio) then
				LastManStanding();
			end
			
			-- // 6am event. (escape)
			if GAMEFolder.TIMER.Value > DefaultValues.SixAmTime and not RoundManager.Set6AM then				
				SixAm();
			end
			
			-- // Match end.
			if GAMEFolder.TIMER.Value > DefaultValues.SixAmTime + DefaultValues.OverTime then
				KillerWon();
				
				break
			end
		end
	end)
	
	RoundManager.RoundLoop();
end

-- // Handle the player spawning
local function InitRound(): ()
	local NumberOfPlayer = 0
	local PlayerTable: PlayerTable = GetPlayers();
	for _, _ in PlayerTable do 
		NumberOfPlayer += 1
	end
	
	if NumberOfPlayer < (IsStudio and DefaultValues.StudioBypass and 1 or DefaultValues.StartGameMinPlayers) then
		return Intermission();
	end
	
	local RoundKiller = GetKiller(PlayerTable);
	if not RoundKiller then		
		return
	else
		if PlayerTable[RoundKiller.PlayerInstance] then
			PlayerTable[RoundKiller.PlayerInstance].Team = 'Killer'	
			
			GAMEFolder.Appearence.Value = RoundKiller.PlayerInstance.UserId or 3922287740;
		end
	end
		
	local IntroFinished = PlayIntro(PlayerTable, 'Intro', RoundKiller.KillerCharacter, RoundKiller.PlayerInstance.Name, RoundKiller.KillerSkin);
	if not IntroFinished then
		return
	end
	
	local Map = MapManager.new();
	if not Map or not Map.Map then
		return Intermission();
	end
	
	Map:SpawnMap();
	Map:SetupTasks();	
	
	GAMEFolder.CURRENTMAP.Value = Map.MapName
	GAMEFolder.Started.Value = true
	GAMEFolder.MODE.Value = DefaultValues.States.DuringGame
	GAMEFolder.TimeSpeed.Value = DefaultValues.RoundTimeSpeed
	
	RoundManager.Map = Map

	for Player: Player, Data in PlayerTable do
		if not Data.FinishedIntro then
			PlayerTable[Player] = nil
			
			continue
		end

		local PlayerData = Data.Data
		if not PlayerData then
			PlayerTable[Player] = nil

			continue
		end
		-- // hi -- haii ^^
		-- // How are u -- good :3
		local PlayerMeta = CharacterManager.Players[Player]
		if not PlayerMeta then
			PlayerTable[Player] = nil

			continue
		end
		
		Player:SetAttribute('FORCED_PLACEMENT', true);
		
		PlayerMeta:SwitchCharacter(Data.Team);
		
		local TeamSpawn: Folder = Map[`{Data.Team}Spawns`]
		if TeamSpawn or not TeamSpawn:IsA('Folder') then
			local AllSpawns = {}
			for _, SpawnPoint in TeamSpawn:GetChildren() do 
				if SpawnPoint:IsA('BasePart') then
					table.insert(AllSpawns, SpawnPoint);
				end
			end
			
			if #AllSpawns == 0 then
				Map:Destroy();
				
				Intermission();
				
				continue
			end
			
			local SpawnPoint = AllSpawns[math.random(1, #AllSpawns)]
			if not SpawnPoint then
				Player:SetAttribute('FORCED_PLACEMENT', false);
				
				continue
			end
			
			local SpawnPivot = SpawnPoint:GetPivot();
			
			Player.Character:PivotTo(SpawnPivot);
			
			Map:ApplyLightning(Player);
		else 
			warn('???');
		end
		
		task.delay(5, function(): ()
			Player:SetAttribute('FORCED_PLACEMENT', false);
		end)
	end
	
	RoundManager.CurrentPlayers = PlayerTable
	
	StartRound();
end

function Intermission(): ()	
	warn('Fuh');
	
	for _, Player in Players:GetChildren() do 
		ServerUtil.SendChange(Player, {
			'Lighting',
			'Lobby'
		});
	end

	GAMEFolder.MODE.Value = DefaultValues.States.Lobby -- bleeeh :3
	GAMEFolder.TIMER.Value = DefaultValues.IntermissionTime

	while task.wait(GAMEFolder.TimeSpeed.Value) do	
		if GAMEFolder.FROZENTIMER.Value == true then
			continue
		end
		
		GAMEFolder.TIMER.Value -= 1

		if GAMEFolder.TIMER.Value <= 0 then
			break
		end
	end

	InitRound();
end

-- <- Public Functions -> --
function RoundManager.Init(): ()
	coroutine.wrap(function(): ()
		Intermission();
	end)()
end

-- <- Return -> --
return RoundManager