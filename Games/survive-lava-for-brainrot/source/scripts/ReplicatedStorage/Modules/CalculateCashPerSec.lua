-- Saved by anthu decompiler gui script (used universalsynsaveinstance) (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("ServerStorage")
require(v2.Services._DataService)
local v_u_3 = require(v1.Registries.MutationRegistry)
local v_u_4 = require(v2.Services.TraitsService)
return function(p5, p6, _, p7)
	-- upvalues: (copy) v_u_3, (copy) v_u_4
	local v8 = v_u_3[p6].Multiplier
	if v8 then
		p5 = p5 * v8
	end
	local v9 = p5 * v_u_4.CalculateTraitsMulti(p7)
	return math.round(v9)
end
