-- // I low-key have no clue what todo with this module.

local Ability = {}
Ability.__index = Ability

-- <- Public Functions -> --
function Ability:ResetCooldown(): ()
	if not self.Cooldown then
		return
	end
	
	self.Cooldown = 0
end

function Ability.new(ItemName: string, PassiveType: string, ScriptName: string)
	local self = setmetatable({}, Ability);
	self.Cooldown = 0
	self.Icon = ''
	self.Keybind = ''
	
	warn(self);
	
	return self
end

-- <- Return -> --
return Ability