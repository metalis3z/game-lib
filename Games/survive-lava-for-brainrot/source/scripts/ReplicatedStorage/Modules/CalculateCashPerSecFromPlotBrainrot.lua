-- Saved by anthu decompiler gui script (used universalsynsaveinstance) (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("ServerStorage")
require(v2.Services._DataService)
require(v1.Registries.MutationRegistry)
require(v2.Services.TraitsService)
local v_u_3 = require(v1.Registries.BrainrotRegistry)
local v_u_4 = require(v1.Modules.GetBrainrotDataFromModel)
local v_u_5 = require(v1.Modules.CalculateCashPerSec)
return function(p6)
	-- upvalues: (copy) v_u_4, (copy) v_u_3, (copy) v_u_5
	local v7 = v_u_4(p6)
	if not v7 then
		return 0
	end
	local v8 = v7.Metadata
	local v9 = v_u_3[v8.Name]
	return not v9 and 0 or v_u_5(v9.CashPerSec, v8.Mutation, v8.Level, v8.Traits)
end
