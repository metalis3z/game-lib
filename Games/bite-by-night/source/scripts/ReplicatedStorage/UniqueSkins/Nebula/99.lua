-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = {}
local v2 = game:GetService("ServerStorage")
local v3 = game:GetService("ReplicatedStorage")
game:GetService("Players")
local v_u_4 = require(v2.Modules.Abilities.Ability)
require(v2.Modules.Types)
require(v3.Modules.Warp)
require(v3.Modules.Maid)
require(game:GetService("ServerStorage").Modules.General.Fighter)
require(v2.Modules["Hitbox Settings"])
require(v2.Modules.General.PlayerData)
require(v3.Modules.BezierProjectileUtil)
require(v3.Modules.VFXHandler)
function v1.new()
	-- upvalues: (copy) v_u_4
	local v_u_5 = v_u_4.new("Antlers", "HitPassive", script.Name)
	v_u_5.Icon = "rbxassetid://0"
	v_u_5.Keybind = ""
	function v_u_5.OnSpawn(p6)
		-- upvalues: (copy) v_u_5
		v_u_5.Cooldown = 0
		v_u_5:ResetCooldown(p6)
		require(script.LoadHat).Load(p6)
	end
	function v_u_5.AbilityFunc(_, _) end
	return v_u_5
end
return v1