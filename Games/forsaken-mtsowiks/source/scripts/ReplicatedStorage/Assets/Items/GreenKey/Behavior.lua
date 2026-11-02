-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled by Krnl

local v_u_1 = {}
v_u_1.__index = v_u_1
local v2 = game:GetService("RunService")
local v_u_3 = v2:IsClient()
local v_u_4 = v2:IsServer()
function v_u_1.Created(_) end
function v_u_1.Destroyed(p5)
	-- upvalues: (copy) v_u_1
	v_u_1.Unequipped(p5)
end
function v_u_1.Equipped(_) end
function v_u_1.Unequipped(p6)
	-- upvalues: (copy) v_u_4, (copy) v_u_3
	local v7 = require(game.ReplicatedStorage.Modules.Actors).CurrentActors[p6.Player]
	if v7 and v_u_4 then
		v7:ChangeExpression("Default")
	end
	if p6.SpeedMultiplier then
		p6.SpeedMultiplier:Destroy()
		p6.SpeedMultiplier = nil
	end
	if v_u_3 then
		require(game.ReplicatedStorage.Modules.Network):FireConnection("DisableSprinting", "BloxyColaItem", false)
	end
	p6.Cooldown = nil
	if p6.Threads and not p6.Completed then
		for _, v8 in pairs(p6.Threads) do
			task.cancel(v8)
		end
		p6.Threads = nil
	end
	if p6.SFX then
		p6.SFX:Destroy()
		p6.SFX = nil
	end
end
function v_u_1.Deactivated(_) end
return v_u_1
