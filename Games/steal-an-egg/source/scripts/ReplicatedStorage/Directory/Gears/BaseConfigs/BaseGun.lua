-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
require(script.Parent.Parent.Types.ToolConfigs)

local v1 = setmetatable({}, {
	__index = require(script.Parent.Default)
})

v1.PROJECTILE_SPEED = 250
v1.PROJECTILE_ACCELERATION = Vector3.new(0, 0, 0)
v1.PROJECTILE_SIZE = Vector3.new(0.6, 0.2, 0.6)
v1.PROJECTILE_COLOR = Color3.new(1, 0.9, 0.2)
v1.PROJECTILE_TEMPLATE = nil
v1.MAX_RANGE = 1500
v1.DAMAGE = 25
v1.RAGDOLL_FORCE = 50
v1.RAGDOLL_DURATION = 0.8
v1.FORCE_RANDOMNESS = 0.2
v1.SHOOT_VFX = nil
v1.HIT_VFX = nil
v1.IMPACT_VFX_COLOR = Color3.new(255/255, 153/255, 0/255)
v1.IMPACT_VFX_SIZE = 4
v1.IMPACT_DECAL = "rbxassetid://0"
v1.IMPACT_LIGHT_ENABLED = true
v1.IMPACT_LIGHT_COLOR = Color3.new(255/255, 153/255, 0/255)
v1.IMPACT_LIGHT_RANGE = 12
v1.RECOIL_MAGNITUDE = 2
v1.COOLDOWN = 0.3
v1.TRAJECTORY = {
	type = "Default"
}

return v1