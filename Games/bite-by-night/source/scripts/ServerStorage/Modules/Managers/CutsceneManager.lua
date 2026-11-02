local CutsceneManager = {}
CutsceneManager.__index = CutsceneManager

-- <- Services -> --
local ReplicatedStorage = game:GetService('ReplicatedStorage');
local Players = game:GetService('Players');

-- <- Modules -> --
local PlayerDataModule = require('@game/ServerStorage/Modules/General/PlayerData');
local ServerUtil = require('@game/ServerStorage/Modules/ServerUtil');
local Warp = require('@game/ReplicatedStorage/Modules/Warp');
local Cutscenes = require('@game/ReplicatedStorage/Modules/Cutscenes');

-- <- Private Variables -> --
local CutsceneThingy = Warp.Server('Cutscene');
local SecondThingy = Warp.Server('WhattMe');

local CutscenePatterns = {
	'Intro',
	'Outro',
	'Win',
	'KillLMS%-Cam',
	'Axeless',
	'LMS',
}

-- <- Public Variables -> --
local CutsceneFolder = ReplicatedStorage.Modules.CutscenesFolder

-- <- Public Functions -> --


function CutsceneManager:Play(): ()	
	task.wait(1);
	
	local CutsceneActualInformation = require(self.CutsceneModule);
	if not CutsceneActualInformation then
		return
	end
	
	local CutsceneTime = CutsceneActualInformation.Duration + 5 or 0
	
	warn('Sending goontrap to your server :3');
	warn(self);
	
	if self.Type == ('Intro' or 'Outro') then
		ServerUtil.SendChange(self.Player, {
			self.Player.PlayerGui.UI.UI.LobbyUIContainer,
			'Visible',
			false
		});
		
		ServerUtil.SendChange(self.Player, {
			self.Player.PlayerGui.UI.UI.RoundKiller.Holder.Information.Killer.Text,
			'Text',
			self.KillerCharacter
		});
		
		ServerUtil.SendChange(self.Player, {
			self.Player.PlayerGui.UI.UI.RoundKiller.Holder.Information.User.Text,
			'Text',
			`@{self.KillerName}`
		});
	end	
	
	CutsceneThingy:Fire(true, self.Player, self.IntroName, self.SpawnPosition, CFrame.identity, 'none', 2.5);

	ServerUtil.SendChange(self.Player, {
		'Module',
		self.CutsceneModule,
		'Activate'
	});
	
	task.wait(CutsceneTime);
	
	return true
end

-- // Used for Intro / Outros. DO NOT USE FOR ANYTHING ELSE.
function CutsceneManager.new(Player: Player, IntroName: string, KillerName: string, KillerSkin: string)	
	local Character = Player.Character or Player.CharacterAdded:Wait();
	local SubbedName = IntroName
	for _, Pattern in CutscenePatterns do 
		SubbedName = string.gsub(SubbedName, Pattern, '');
	end
	
	local PlayerData = PlayerDataModule.GetPlayerData(Player);
	if not PlayerData then
		return
	end
		
	local CutsceneInformation = Cutscenes[IntroName]
	if not CutsceneInformation then
		return
	end
	
	local CutsceneType = string.gsub(IntroName, SubbedName, '');
	local CutsceneTypeFolder = CutsceneFolder:FindFirstChild(CutsceneType);
	if not CutsceneTypeFolder then
		return
	end

	local CutsceneModule = CutsceneTypeFolder:FindFirstChild(`{SubbedName}-{KillerSkin}`) or CutsceneTypeFolder:FindFirstChild(`{SubbedName}-Normal`);
	if not CutsceneModule then
		return
	end

	local FolderModel = CutsceneModule:FindFirstChild('FolderModel');
	if not FolderModel then
		return
	end

	local CamPosition: BasePart = FolderModel:FindFirstChild('CamPosition');
	if not CamPosition then
		return
	end
	
	warn(CutsceneInformation)
	
	local self = setmetatable({}, CutsceneManager);
	self.Player = Player
	self.IntroName = IntroName
	self.CharacterName = SubbedName
	self.TypeFolder = CutsceneTypeFolder
	self.Type = CutsceneType
	self.SpawnPosition = CamPosition:GetPivot() * CFrame.Angles(0, math.rad(180), 0);
	self.CutsceneModule = CutsceneModule
	self.KillerName = KillerName
	self.KillerCharacter = SubbedName
	
	return self
end

-- <- Return -> --
return CutsceneManager