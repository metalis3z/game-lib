-- // I hate how they handle the classes (Characters etc...)

local SecurityGuard = {}
SecurityGuard.__index = SecurityGuard

-- <- Modules -> --
local AssetManager = require('@game/ServerStorage/Modules/Managers/AssetManager');

-- <- Public Functions -> --

-- // Normal on spawn. (Its mostly asset apply)
function SecurityGuard:OnSpawn_Normal(): ()
	if not self.Player then 
		return
	end

	local PlayerAssetMeta = AssetManager.Player[self.Player]
	if not PlayerAssetMeta then
		warn(`{self.Player} assetmeta wasn't found / is invalid.`);
		
		return
	end
	
	local FAZTAZER: Model = PlayerAssetMeta:RequestAsset('FAZ-TAZER', true);
	if not FAZTAZER then
		return
	end
	
	local WeldTo = FAZTAZER:GetAttribute('WeldTo');
	if not WeldTo then
		return
	end

	local Torso: BasePart = self.Character:FindFirstChild('Torso');
	if not Torso then
		return
	end

	local WeldPart: BasePart = self.Character:FindFirstChild(WeldTo);
	if not WeldPart then
		return
	end

	local TorsoWeld: Weld = FAZTAZER:FindFirstChild('TorsoWeld');
	if not TorsoWeld then
		return
	end

	local Weld: Weld = FAZTAZER:FindFirstChild('Weld');
	if not Weld then
		return
	end

	FAZTAZER.Parent = self.Character

	Weld.Part0 = WeldPart
	Weld.Enabled = true

	TorsoWeld.Part0 = Torso

	task.wait(.1);

	TorsoWeld.Enabled = false
end

function SecurityGuard.new(Player: Player): ()
	local self = setmetatable({}, SecurityGuard);
	self.Player = Player
	self.Character = Player.Character
	self.Humanoid = self.Character:FindFirstChildOfClass('Humanoid');
	self.Animator = self.Humanoid:FindFirstChildOfClass('Animator');

	return self
end

-- <- Return -> --
return SecurityGuard