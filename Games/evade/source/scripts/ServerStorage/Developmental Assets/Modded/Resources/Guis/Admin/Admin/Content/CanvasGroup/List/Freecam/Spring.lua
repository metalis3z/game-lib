-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v_u_1 = {}
v_u_1.__index = v_u_1
function v_u_1.new(p2, p3)
	-- upvalues: (copy) v_u_1
	local v4 = v_u_1
	local v5 = setmetatable({}, v4)
	v5.f = p2
	v5.p = p3
	v5.v = p3 * 0
	return v5
end
function v_u_1.Update(p6, p7, p8)
	local v9 = p6.f * 2 * 3.141592653589793
	local v10 = p6.p
	local v11 = p6.v
	local v12 = p8 - v10
	local v13 = -v9 * p7
	local v14 = math.exp(v13)
	local v15 = p8 + (v11 * p7 - v12 * (v9 * p7 + 1)) * v14
	local v16 = (v9 * p7 * (v12 * v9 - v11) + v11) * v14
	p6.p = v15
	p6.v = v16
	return v15
end
function v_u_1.Reset(p17, p18)
	p17.p = p18
	p17.v = p18 * 0
end
return v_u_1
