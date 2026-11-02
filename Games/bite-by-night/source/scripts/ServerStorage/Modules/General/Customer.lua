-- // I hate how they handle the classes (Characters etc...)

local Customer = {}
Customer.__index = Customer

-- <- Modules -> --
local AssetManager = require('@game/ServerStorage/Modules/Managers/AssetManager');

-- <- Public Functions -> --

-- // Normal on spawn. (Its mostly asset apply)
function Customer:OnSpawn_Normal(): ()
	if not self.Player then 
		return
	end

	local PlayerAssetMeta = AssetManager.Player[self.Player]
	if not PlayerAssetMeta then
		warn(`{self.Player} assetmeta wasn't found / is invalid.`);
		
		return
	end
	
	local Assets: Model = PlayerAssetMeta:RequestAsset('Assets', true);
	if not Assets then
		return
	end
	
	local WeldTo = Assets:GetAttribute('WeldTo');
	if not WeldTo then
		return
	end
	
	local WeldPart: BasePart = self.Character:FindFirstChild(WeldTo);
	if not WeldPart then
		return
	end
	
	local Weld: Weld = Assets:FindFirstChild('Weld');
	if not Weld then
		return
	end
	
	Assets.Parent = self.Character
	
	Weld.Part0 = WeldPart
	Weld.Enabled = true	
end

function Customer.new(Player: Player): ()
	local self = setmetatable({}, Customer);
	self.Player = Player
	self.Character = Player.Character
	self.Humanoid = self.Character:FindFirstChildOfClass('Humanoid');
	self.Animator = self.Humanoid:FindFirstChildOfClass('Animator');

	return self
end

-- <- Return -> --
return Customer