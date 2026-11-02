--[[
    Written by: Nextix (ne_tix)
    Date: 3/29/2026
    
    Method:
    There is no so called "Methods" here, everything should be easy to understand I'd say.
]]

local CharacterManager = {Players = setmetatable({}, {__mode = 'k'})}
CharacterManager.__index = CharacterManager

-- <- Services -> --
local ServerStorage = game:GetService('ServerStorage');
local ReplicatedStorage = game:GetService('ReplicatedStorage');
local Players = game:GetService('Players');

-- <- Modules -> --
local AbilityManager = require('@self/AbilityManager');
local MovementManager = require('@self/MovementManager')
local UniversalModule = require('@game/ServerStorage/Modules/General/Universal');
local Warps = require('@game/ReplicatedStorage/Modules/Warp');
local AssetManager = require('./AssetManager');
local ServerUtil = require('../ServerUtil');
local PlayerData = require('../General/PlayerData');

-- <- Public Variables -> --
local ServerAssets = ServerStorage.Assets

local Requests = ReplicatedStorage.Requests
local Characters = ReplicatedStorage.Characters

local Survivor = Characters.Survivor

local UniqueSkins = ReplicatedStorage.UniqueSkins

-- <- Private Variables -> --
local Escaped = Warps.Server('Escaped');
local Input = Warps.Server('Input');

local CloneExcluded = {
	'Configuration',
	'Assets',
	'Hitbox',
	'StarterCharacter'
}

-- <- Private Functions -> --
local function CheckUniqueSkins(Skin: string, Team: string): {OnSpawn: (Player: Player) -> ()} | nil
	warn(Skin, Team)

	if Team ~= 'Survivor' then
		return
	end

	local UniqueSkinFolder = UniqueSkins:FindFirstChild(Skin);
	if not UniqueSkinFolder then
		return
	end

	warn(UniqueSkinFolder)

	local UniqueModule = UniqueSkinFolder:FindFirstChildOfClass('ModuleScript');
	if not UniqueModule then
		warn(`No modulescript for UniqueSkin {Skin}.`);

		return
	else 
		UniqueModule = ServerUtil.SafeRequire(UniqueModule);	
	end
	
	if not UniqueModule then
		return
	end

	local CreateSkin = UniqueModule.new();
	return CreateSkin
end

local function GetCharacterFolder(Name: string, Team: string): Folder
	if Team == 'Killer' then
		return Characters:FindFirstChild(Name);
	else 
		local SubbedName = string.gsub(Name, 'Survivor%-', '');	
		return Survivor:FindFirstChild(SubbedName);
	end
end

local function ApplyConfiguration(Config: {}, Character: Model): ()
	for AttributeName, Attribute in Config do 
		if table.find(CloneExcluded, AttributeName) then
			continue
		end

		if typeof(Attribute) == 'table' then
			continue
		end
		
		if AttributeName == 'Speed' then
			AttributeName = 'WalkSpeed'
		end
		
		if AttributeName == 'Stamina' then
			Character:SetAttribute('MaxStamina', Attribute);
		end
		
		Character:SetAttribute(AttributeName, Attribute);
	end
end

local function ApplyAssets(AssetFolder: Folder, Character: Model): ()
	for _, Stuff in AssetFolder:GetChildren() do -- haaii :3 bleeh >w<
		if table.find(CloneExcluded, Stuff.Name) then
			continue
		end

		Stuff:Clone().Parent = Character
	end
end

local function ApplyFinalAttributes(Player: Player, Character: Model, CurrentCharacter: string, EquippedSkin: string, Team: string): ()
	Character:SetAttribute('Character', CurrentCharacter);
	Character:SetAttribute('Skin', EquippedSkin);
	Character:SetAttribute('Team', Team);
	Character:SetAttribute('IFrames', false);
	Character:SetAttribute('InAbility', false);
	Character:SetAttribute('CanRun', Team ~= 'Lobby' and true or false);

	Player:SetAttribute('TEAM', Team)
end

local function ApplyPhasesToKiller(Character: Model, CurrentCharacter: string): ()
	local ServerCharacterAsset = ServerAssets:FindFirstChild(CurrentCharacter);
	if not ServerCharacterAsset then
		return
	end

	local Phases = ServerCharacterAsset:FindFirstChild('Phases');
	if not Phases then
		return
	end

	Phases:Clone().Parent = Character
end

local function ApplyChaseTheme(Character: Model, Team: string): ()
	local ChaseThemeScript = script.Client:FindFirstChild(`ChaseThemes-{Team}`);
	if not ChaseThemeScript then
		return
	end

	ChaseThemeScript:Clone().Parent = Character
end	

local function ApplyHumanoidDescToPlayer(Character: Model, UserId: number): ()
	local Humanoid = Character:FindFirstChildOfClass('Humanoid');
	if not Humanoid then
		warn('No humanoid.')
	end
	
	local DescSuccess, HumanoidDescription = pcall(function(): ()
		return Players:GetHumanoidDescriptionFromUserIdAsync(UserId);
	end)

	if not DescSuccess then
		warn(`Couwdn't get the *boops your nose* fucking humanyoiddescwiption x3`);
	else 
		local ApplySuccess, ErrorThing = pcall(function(): ()
			return Humanoid:ApplyDescriptionAsync(HumanoidDescription);
		end)
		
		if not ApplySuccess then
			warn(`Couldn't apply humanoid description, {ErrorThing}`);
		end
	end
end

local function ApplyUniqueSkin(Player: Player, Skin: string, Team: string): ()
	local HaveUniqueSkin = CheckUniqueSkins(Skin, Team);
	if not HaveUniqueSkin then
		return
	end

	warn(HaveUniqueSkin);

	HaveUniqueSkin.OnSpawn(Player);
end

local function ApplyStarterCharacterToPlayer(Player: Player, Model: Model): Model
	local NewCharacter = Model:Clone();
	NewCharacter.Name = Player.Name
	NewCharacter.Parent = workspace
	
	return NewCharacter
end

local function ApplyOnSpawn(Player: Player, Character: string, SkinName: string): ()
	Character = string.gsub(Character, 'Survivor%-', ''); -- // Meow
	
	warn(Character);
	
	local CharacterServerModule = ServerStorage.Modules.General:FindFirstChild(Character);
	if not CharacterServerModule then
		warn(`{Character} module was not found. (Server)`);
		
		return
	end

	local RequiredCharacterServerModule = ServerUtil.SafeRequire(CharacterServerModule);
	if not (RequiredCharacterServerModule or RequiredCharacterServerModule.new) then
		warn(`{Character} module require failed or doesn't have a .new function. (Server)`);
		
		return
	end
	
	local UniversalMeta = UniversalModule.new(Player);
	local CharacterMeta = RequiredCharacterServerModule.new(Player);
	
	CharacterManager.Players[Player].UniversalMeta = UniversalMeta
	CharacterManager.Players[Player].CharacterMeta = CharacterMeta

	task.wait(.5);
	
	-- // Edit later on if each characters have their own onspawn function.
	UniversalMeta:OnSpawn();
	
	-- // Custom on spawn integration ^^
	if CharacterMeta[`OnSpawn_{SkinName}`] then
		CharacterMeta[`OnSpawn_{SkinName}`](CharacterMeta);
	elseif CharacterMeta.OnSpawn_Normal then
		CharacterMeta:OnSpawn_Normal();
	end
end

local function ApplyAbilities(Player: Player, CurrentCharacter: string): ()
	local PlayerCharacter = Player.Character
	if not PlayerCharacter then
		return
	end
	
	local CharacterMeta = CharacterManager.Players[Player]
	if not CharacterMeta then
		return
	end
	
	local CharacterAbilities = AbilityManager.GetAbilities(Player, CurrentCharacter);
	if not CharacterAbilities then
		return
	end
	
	for Index, Ability in CharacterAbilities do 
		Ability:DisplayCard();
	end
	
	CharacterMeta.Abilities = CharacterAbilities
	CharacterMeta.Connections[#CharacterMeta.Connections + 1] = PlayerCharacter.AttributeChanged:Connect(function(): ()
		AbilityManager.AttributesChanged(PlayerCharacter, CharacterAbilities);
	end)
end

-- TODO: sheit :3
local function SetPlayerToLobby(Player: Player): boolean | nil -- send dat bih to the lobby :3 // W idea
	local Character = Player.Character or Player.CharacterAdded:Wait();
	local LobbyFolder = Survivor.Lobby.Normal
	local Configuration = ServerUtil.SafeRequire(LobbyFolder.Configuration);
	if not Configuration then
		return
	end
	
	warn(Character);
	
	local Animate = Player.Character:FindFirstChild('Animate')
	if Animate then
		Animate:Destroy();
	end
	
	local PlayerMeta = CharacterManager.Players[Player]
	if PlayerMeta then
		PlayerMeta:CreateCleanUpConnections();
	end

	ApplyHumanoidDescToPlayer(Character, Player.UserId);
	ApplyConfiguration(Configuration, Character);
	ApplyAssets(LobbyFolder, Character);
	ApplyFinalAttributes(Player, Character, 'Survivor-Lobby', 'Normal', 'Lobby');
	
	ServerUtil.SendChange(Player, {
		Player.PlayerGui.UI.UI.GameUIContainer,
		'Visible',
		false
	});
		
	task.delay(2, function(): ()
		script.Client.Movement:Clone().Parent = Character
	end)
	
	return true
end

local function SetPlayerCharacter(Player: Player, Team: string, Character: string, Skin: string): boolean | nil
	local PlayerCharacter = Player.Character or Player.CharacterAdded:Wait();
	local PlayerPosition = PlayerCharacter:GetPivot();

	local PlayerMeta = CharacterManager.Players[Player]
	if not PlayerMeta then
		return
	end

	PlayerMeta:CleanUp();

	local CharacterToSetFolder = GetCharacterFolder(Character, Team);
	if not CharacterToSetFolder then
		return
	end

	local NormalCharacterFolder = CharacterToSetFolder:FindFirstChild('Normal');
	if not NormalCharacterFolder then
		return
	end

	local CharacterSkinFolder = CharacterToSetFolder:FindFirstChild(Skin) or UniqueSkins:FindFirstChild(Skin);
	if not CharacterSkinFolder then
		return
	end

	local NormalCharacterConfiguration = ServerUtil.SafeRequire(NormalCharacterFolder:FindFirstChild('Configuration'));
	if not NormalCharacterConfiguration then
		return
	end

	Player:LoadCharacterAsync();

	local NewCharacter = Player.Character
	local Animate = NewCharacter:FindFirstChild('Animate');
	if Animate then
		Animate:Destroy();
	end
	
	if Team == 'Killer' then
		NewCharacter = ApplyStarterCharacterToPlayer(Player, CharacterSkinFolder:FindFirstChild('StarterCharacter') or NormalCharacterFolder:FindFirstChild('StarterCharacter'));

		ApplyPhasesToKiller(NewCharacter, Character);
	else
		ApplyHumanoidDescToPlayer(NewCharacter, Player.UserId)
	end

	Player.Character = NewCharacter
	Player.Character.Parent = Team == 'Survivor' and workspace.PLAYERS.ALIVE or workspace.PLAYERS.KILLER

	NewCharacter:PivotTo(PlayerPosition);

	script.Client.Movement:Clone().Parent = NewCharacter

	PlayerMeta:CreateCleanUpConnections();
	PlayerMeta.Configuration = NormalCharacterConfiguration

	AssetManager.CreateAndLinkAssetFolder(Player, NormalCharacterFolder, CharacterSkinFolder);
	
	ApplyConfiguration(NormalCharacterConfiguration, NewCharacter);
	ApplyAssets(NormalCharacterFolder, NewCharacter);
	ApplyFinalAttributes(Player, NewCharacter, Character, Skin, Team);
	ApplyChaseTheme(NewCharacter, Team);
	ApplyUniqueSkin(Player, Skin, Team);
	ApplyOnSpawn(Player, Character, Skin);
	ApplyAbilities(Player, Character);
	
	return true
end

-- <- Public Functions -> --

function CharacterManager:BegingRespawnTime(): ()
	warn('Start', Players.RespawnTime)
	
	if not self.Player then
		return
	end
	
	task.delay(Players.RespawnTime + .5, function(): ()
		warn('Hi');
		
		self:SwitchCharacter('Lobby');
	end)
end

-- // Request all the clean up functions. (Easier way to manage everything than calling each one in every scripts)
function CharacterManager:CleanUp(): ()
	if not self.Player then 
		return
	end

	local PlayerAssetMeta = AssetManager.RequestPlayerMeta(self.Player);
	if PlayerAssetMeta then
		PlayerAssetMeta:RequestAssetFolderCleanUp();
	end
	
	warn(self);
	
	for _, Abilities in self.Abilities do 
		warn(Abilities);
		
		if Abilities.Cleanup then
			Abilities:Cleanup(); -- // Should cleanup the abilities cards
		end
	end

	self:RequestConnectionsCleanUp();
	self.Abilities = {}
end

function CharacterManager:CreateCleanUpConnections(): ()
	if not self.Player then 
		return
	end

	local Character: Model = self.Player.Character
	if not Character then
		return
	end

	local Humanoid = Character:FindFirstChildOfClass('Humanoid');
	if not Humanoid then
		return
	end

	self.Connections[#self.Connections + 1] = Humanoid.Died:Connect(function(): ()
		warn('Yo ?')
		
		self:BegingRespawnTime();
		self:CleanUp();
	end)

	self.Connections[#self.Connections + 1] = Character:GetPropertyChangedSignal('Parent'):Connect(function(): ()
		if Character.Parent == nil then
			self:CleanUp();
		end
	end)
end

function CharacterManager:RequestConnectionsCleanUp(): ()
	if not self.Player then 
		return
	end

	-- // Disconnect all the ScriptConnections.
	for _, Value : RBXScriptConnection in self.Connections do 
		if typeof(Value) ~= 'RBXScriptConnection' then
			continue
		end

		Value:Disconnect();
	end

	-- // Clear the table
	table.clear(self.Connections);
end

function CharacterManager:ForceCharacter(Team: string, CharacterToSet: string, Skin: string): ()
	if not self.Player then 
		return
	end

	SetPlayerCharacter(self.Player, Team, CharacterToSet, Skin);
end

function CharacterManager:SwitchCharacter(Team: string): boolean | nil
	if not self.Player then 
		return
	end

	if Team == 'Lobby' then
		return SetPlayerToLobby(self.Player);
	else 
		local Data = PlayerData.GetPlayerData(self.Player);
		local EquippedCharacter = Data.Data.Character[Team]
		if not EquippedCharacter then
			return
		end

		local EquippedSkin = Data.Data.EquippedSkins[EquippedCharacter]
		if not EquippedSkin then
			return
		end

		return SetPlayerCharacter(self.Player, Team, EquippedCharacter, EquippedSkin);
	end
end

function CharacterManager.__PlayerAdded(Player: Player): ()	
	local self = setmetatable({}, CharacterManager);
	self.Player = Player
	self.Connections = {}
	self.Abilities = {}
	
	CharacterManager.Players[Player] = self
	
	self:SwitchCharacter('Lobby');
end

function CharacterManager.__PlayerLeft(Player: Player): ()
	local PlayerMeta = CharacterManager.Players[Player]
	if not PlayerMeta then
		return
	end

	PlayerMeta:CleanUp();

	CharacterManager.Players[Player] = nil
end

function CharacterManager.Init(): ()
	-- // Handle the abilities in the module which is parented inside this module. (@self/AbilityManager)
	Input:Connect(function(Player: Player, ...): ()
		local PlayerMeta = CharacterManager.Players[Player]
		if not PlayerMeta then
			return
		end
				
		local PlayerAbilities = PlayerMeta.Abilities
		if not PlayerAbilities then
			return
		end
		
		AbilityManager.TryToUseAbility(Player, PlayerAbilities, PlayerMeta, ...);
	end)

	-- // WARNING \\
	-- // This remote is used as an AntiCheat. Do not add weird checks or you could just fuck the game. \\
	Requests.Movement.OnServerEvent:Connect(MovementManager.MovementBackend);
end

-- <- Return -> --
return CharacterManager -- ily nexy <3