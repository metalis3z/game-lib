local Universal = {}
Universal.__index = Universal

-- <- Services -> --
local Debris = game:GetService('Debris');
local ReplicatedStorage = game:GetService('ReplicatedStorage');

-- <- Modules -> --
local AssetManager = require('@game/ServerStorage/Modules/Managers/AssetManager');
local ServerUtil = require('@game/ServerStorage/Modules/ServerUtil');
local Warp = require('@game/ReplicatedStorage/Modules/Warp');

-- <- Private Variables -> --

-- <- Public Functions -> --

-- // Handle the on spawn stuff whenever a character spawns. (Wow)
function Universal:OnSpawn(): ()	
	if not self.Player then 
		return
	end
	
	local PlayerAssetMeta = AssetManager.Player[self.Player]
	if not PlayerAssetMeta then
		warn(`{self.Player} assetmeta wasn't found / is invalid.`);
		
		return
	end

	local SpawnAnimation: Animation = PlayerAssetMeta:RequestAsset('Spawn', false);
	if not SpawnAnimation then
		warn(`{self.Player} character doesn't have a spawn animation.`);
		
		return
	end

	local SpawnSFX: Sound = PlayerAssetMeta:RequestAsset('SpawnSFX', true);
	if not SpawnSFX then
		warn(`{self.Player} character doesn't have a spawn sound.`);

		return
	end
	
	if not self.Animator then
		self.Animator = Instance.new('Animator');
		self.Animator.Parent = self.Humanoid
	end

	local function AnchorRootPart(Bool: boolean): ()
		local PartToAnchor = self.Character:FindFirstChild('HumanoidRootPart') or self.Character.PrimaryPart
		PartToAnchor.Anchored = Bool
	end
	
	AnchorRootPart(true);

	ServerUtil.SendChange(self.Player, {
		'Module',
		ReplicatedStorage.Modules.Moves.LOAD,
		'Activate',
		{
			self.Character,
			SpawnAnimation
		}
	});

	ServerUtil.SendChange(self.Player, {
		self.Player.PlayerGui.UI.UI.LobbyUIContainer,
		'Visible',
		false
	});

	ServerUtil.SendChange(self.Player, {
		self.Player.PlayerGui.UI.Transitions.Transition,
		'GroupTransparency',
		1
	});

	SpawnSFX.Parent = self.Character
	SpawnSFX:Play();

	Debris:AddItem(SpawnSFX, SpawnSFX.TimeLength);

	task.delay(SpawnSFX.TimeLength, function(): ()
		AnchorRootPart(false);
	end)
end

function Universal.new(Player: Player): ()
	local self = setmetatable({}, Universal);
	self.Player = Player
	self.Character = Player.Character
	self.Humanoid = self.Character:FindFirstChildOfClass('Humanoid');
	self.Animator = self.Humanoid:FindFirstChildOfClass('Animator');

	return self
end

-- <- Return -> --
return Universal