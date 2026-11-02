-- // I hate how they handle the classes (Characters etc...)

local Medic = {}
Medic.__index = Medic

-- <- Modules -> --
local AssetManager = require('@game/ServerStorage/Modules/Managers/AssetManager');

-- <- Public Functions -> --

-- // Normal on spawn. (Its mostly asset apply)
function Medic:OnSpawn_Normal(): ()
	if not self.Player then 
		return
	end

	local PlayerAssetMeta = AssetManager.Player[self.Player]
	if not PlayerAssetMeta then
		warn(`{self.Player} assetmeta wasn't found / is invalid.`);
		
		return
	end
	
	local Medkit: Model = PlayerAssetMeta:RequestAsset('Medkit', true);
	if not Medkit then
		return
	end
	
	local WeldTo = Medkit:GetAttribute('WeldTo');
	if not WeldTo then
		return
	end
	
	for _, Weld in Medkit:GetChildren() do 
		local AttachTo = Weld:GetAttribute('Attach') or WeldTo
		if not AttachTo then
			continue
		end
		
		local WeldPart: BasePart = self.Character:FindFirstChild(AttachTo);
		if not WeldPart then
			return
		end
		
		if Weld:IsA('Weld') or Weld:IsA('Motor6D') then
			Weld.Part0 = WeldPart
		end
	end
	
	Medkit.Parent = self.Character
end

function Medic.new(Player: Player): ()
	local self = setmetatable({}, Medic);
	self.Player = Player
	self.Character = Player.Character
	self.Humanoid = self.Character:FindFirstChildOfClass('Humanoid');
	self.Animator = self.Humanoid:FindFirstChildOfClass('Animator');

	return self
end

-- <- Return -> --
return Medic