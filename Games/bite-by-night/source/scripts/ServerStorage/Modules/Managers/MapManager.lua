local MapManager = {}
MapManager.__index = MapManager

-- <- Types -> --
type self = {
	Map: Folder,
	MapName: string,
	Spawns: Folder,
	KillerSpawns: Folder,
	SurvivorSpawns: Folder,
	Escapes: Folder,
	EscapePoint: BasePart,
	Connections: {RBXScriptConnection},
	SpawnMap: (self) -> (),
	ApplyLightning: (self, Player) -> (),
	Destroy: (self) -> (),
	SetupEscapePoint: (self) -> (),
	SetupTasks: (self) -> ()
}

-- <- Services -> --
local ReplicatedStorage = game:GetService('ReplicatedStorage');
local Players = game:GetService('Players');
local ServerStorage = game:GetService('ServerStorage');
local Lightning = game:GetService('Lighting');

-- <- Modules -> --
local Warp = require('@game/ReplicatedStorage/Modules/Warp');
local CharacterManager = require('@game/ServerStorage/Modules/Managers/CharacterManager');
local DoorManager = require('@game/ServerStorage/Modules/Managers/DoorManager');
local CutsceneManager = require('./CutsceneManager');
local ServerUtil = require('../ServerUtil');

-- <- Private Variables -> --
local MapAnnouncer = Warp.Server('MapAnnouncer');

local LightningBL = {
	'Lighting'
}

-- <- Public Variables -> --
local Assets = ServerStorage.Assets
local MapsFolder = Assets.Maps

local TasksFolder = ReplicatedStorage.Tasks
local LightningFolder = ReplicatedStorage.Lightings

local Lobby = workspace.Lobby
local LobbySpawn = Lobby["Player Position"]

local Terrain = workspace.Terrain
local GAMEFolder = workspace.GAME
local MAPS = workspace.MAPS
local GAMEMAPS = MAPS['GAME MAP']

-- <- Private Functions -> --
local function GetMap(): Folder
	local Maps = {}
	local ForcedMap = GAMEFolder.FORCEMAP.Value
	if ForcedMap ~= '' then
		return MapsFolder:FindFirstChild(ForcedMap) or MapsFolder.Forest
	else 
		for _, Map in MapsFolder:GetChildren() do 
			if not Map:IsA('Folder') then
				continue
			end

			table.insert(Maps, Map);
		end

		local MapToSpawn = Maps[math.random(1, #Maps)]
		return MapToSpawn
	end
end

-- <- Public Functions -> --

-- // Door openings are inside the map themself btw ^^
function MapManager:SetupEscapePoint(): ()
	if not self then
		return
	end
	
	warn(self);
	warn(self.EscapePoint);
	
	local EscapeHighlight = self.EscapePoint:FindFirstChildOfClass('Highlight');
	if not EscapeHighlight then
		return
	end
	
	EscapeHighlight.Enabled = true
	
	self.Connections[#self.Connections + 1] = self.EscapePoint.Touched:Connect(function(TouchedPart: BasePart): ()
		local PlayerModel = TouchedPart:FindFirstAncestorWhichIsA('Model');
		if not PlayerModel then
			return
		end
		
		local Player = Players:GetPlayerFromCharacter(PlayerModel);
		if not Player then
			return
		end
		
		local PlayerMeta = CharacterManager.Players[Player]
		if not PlayerMeta then
			return
		end
		
		-- // Just so the touched doesn't get used 2 times ^^
		if PlayerModel:GetAttribute('Escaped') then
			return
		end
		
		PlayerModel:SetAttribute('Escaped', true);
		
		-- // Reload character, set it to lobby etc will go here
		Player:SetAttribute('Donttriggerlol', true); -- // So the elevator animation doesn't get triggered ^^
		Player:LoadCharacterAsync(); -- // Reload the player
		
		PlayerMeta:SwitchCharacter('Lobby');
		
		local NewCharacter = Player.Character
		if not NewCharacter then
			return
		end
		
		NewCharacter:PivotTo(LobbySpawn:GetPivot()); -- // OMG !!! (idk bro.. I want to fuckk)
	end)
end

function MapManager:SetupTasks(): ()
	if not self then
		return
	end
	
	local GenPoints = self.Map:FindFirstChild('GenPoints');
	local function SetupGenerators(): ()
		local Amount = #GenPoints:GetChildren();
		for _, GeneratorPoint: BasePart in GenPoints:GetChildren() do 
			local GeneratorCopy = TasksFolder.Generator:Clone();
			GeneratorCopy:PivotTo(GeneratorPoint.CFrame);
			GeneratorCopy.Parent = self.Map:FindFirstChild('Generators');
			
			GeneratorPoint:Destroy();
		end
		
		GAMEFolder.Tasks.Gens.Enabled.Value = true
		GAMEFolder.Tasks.Gens.total.Value = Amount
		GAMEFolder.Tasks.Gens.count.Value = 0
	end
	
	if GenPoints then
		SetupGenerators();
	end
end

function MapManager:ApplyLightning(Player: Player): ()	
	if not self then
		return
	end
	
	ServerUtil.SendChange(Player, {
		'Lighting',
		self.MapName
	});
end

function MapManager:Destroy(): ()
	if not self then
		return
	end
	
	self.Map:Destroy();
	
	Terrain:Clear();
	-- hai :3 // Heloo
	for _, Connection: RBXScriptConnection in self.Connections do 
		if Connection and Connection.Connected then
			Connection:Disconnect();
		end
	end
	
	table.clear(self.Connections);
end

function MapManager:SpawnMap(): ()
	local RegionToLoad = self.Map:FindFirstChild('SavedTerrain') or self.Map:FindFirstChildOfClass('TerrainRegion');
	if not RegionToLoad then
		return
	end

	Terrain:PasteRegion(RegionToLoad, Terrain.MaxExtents.Min, true); -- // Should work.

	self.Map.Parent = GAMEMAPS
	
	DoorManager.LoadMap(self.Map);
end

function MapManager.new(): self
	local MapFolder: Folder = GetMap();
	if not MapFolder then
		return
	end

	local self = setmetatable({}, MapManager);
	self.Connections = {}
	self.Map = MapFolder:Clone();
	self.MapName = self.Map.Name
	self.Spawns = self.Map.Spawns
	self.KillerSpawns = self.Spawns.Killer
	self.SurvivorSpawns = self.Spawns.Survivor
	self.Escapes = self.Map.Escapes
	self.EscapePoint = self.Escapes.EscapePoint

	return self
end

-- <- Return -> --
return MapManager