-- // I hate how they handle the classes (Characters etc...)

local FighterModule = {}
FighterModule.__index = FighterModule

-- <- Modules -> --
local AssetManager = require('@game/ServerStorage/Modules/Managers/AssetManager');

-- <- Public Functions -> --

-- // The spawn function for the skin American.
function FighterModule:OnSpawn_American(): ()
	if not self.Player then 
		return
	end

	local PlayerAssetMeta = AssetManager.Player[self.Player]
	if not PlayerAssetMeta then
		warn(`{self.Player} assetmeta wasn't found / is invalid.`);

		return
	end

	local MP5: Model = PlayerAssetMeta:RequestAsset('MP5', true);
	if not MP5 then
		return
	end

	local WeldTo = MP5:GetAttribute('WeldTo');
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

	local TorsoWeld: Weld = MP5:FindFirstChild('TorsoWeld');
	if not TorsoWeld then
		return
	end

	local Weld: Weld = MP5:FindFirstChild('Weld');
	if not Weld then
		return
	end

	MP5.Parent = self.Character

	Weld.Part0 = WeldPart
	Weld.Enabled = true

	TorsoWeld.Part0 = Torso

	task.wait(.1);

	TorsoWeld.Enabled = false
end

-- // Normal on spawn. (Its mostly asset apply)
function FighterModule:OnSpawn_Normal(): ()
	if not self.Player then 
		return
	end

	local PlayerAssetMeta = AssetManager.Player[self.Player]
	if not PlayerAssetMeta then
		warn(`{self.Player} assetmeta wasn't found / is invalid.`);
		
		return
	end
	
	local Axe: Model = PlayerAssetMeta:RequestAsset('Axe', true);
	if not Axe then
		return
	end
	
	local WeldTo = Axe:GetAttribute('WeldTo');
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
	
	local TorsoWeld: Weld = Axe:FindFirstChild('TorsoWeld');
	if not TorsoWeld then
		return
	end
	
	local Weld: Weld = Axe:FindFirstChild('Weld');
	if not Weld then
		return
	end
	
	Axe.Parent = self.Character
	
	Weld.Part0 = WeldPart
	Weld.Enabled = true

	TorsoWeld.Part0 = Torso
	
	task.wait(.1);
	
	TorsoWeld.Enabled = false
end

function FighterModule.new(Player: Player): ()
	local self = setmetatable({}, FighterModule);
	self.Player = Player
	self.Character = Player.Character
	self.Humanoid = self.Character:FindFirstChildOfClass('Humanoid');
	self.Animator = self.Humanoid:FindFirstChildOfClass('Animator');

	return self
end

function FighterModule.getFighterByCharacter(Character: Model): any	
	local self = setmetatable({}, FighterModule)

	self.Character = Character
	self.Player = game.Players:GetPlayerFromCharacter(Character);

	self.Abilites = {}

	return self
end

-- <- Return -> --
return FighterModule