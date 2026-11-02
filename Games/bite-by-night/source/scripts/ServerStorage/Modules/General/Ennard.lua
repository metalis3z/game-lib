local Ennard = {}
Ennard.__index = Ennard

-- <- Services -> --
local Debris = game:GetService('Debris');

-- <- Modules -> --
local AssetManager = require('@game/ServerStorage/Modules/Managers/AssetManager');

-- <- Public Functions -> --

function Ennard.new(Player: Player): ()
	local self = setmetatable({}, Ennard);
	self.Player = Player
	self.Character = Player.Character
	self.Humanoid = self.Character:FindFirstChildOfClass('Humanoid');
	self.Animator = self.Humanoid:FindFirstChildOfClass('Animator');
	
	return self
end

-- <- Return -> --
return Ennard