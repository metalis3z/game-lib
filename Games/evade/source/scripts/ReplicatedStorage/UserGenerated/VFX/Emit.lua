---------------------------------------------------
-- Saved by Angelus Decompiles | With Script + GUI
-- Discord: https://discord.gg/nDWm6PkFrT
---------------------------------------------------

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v_u_1 = require(game.ReplicatedStorage.UserGenerated.VFX.EmitOnce)
local function v_u_7(p2)
	-- upvalues: (copy) v_u_1, (copy) v_u_7
	local v3 = 0
	if p2:IsA("ParticleEmitter") then
		local v4 = v_u_1
		v3 = math.max(v3, v4(p2))
	end
	for _, v5 in ipairs(p2:GetChildren()) do
		local v6 = v_u_7
		v3 = math.max(v3, v6(v5))
	end
	return v3
end
return v_u_7
