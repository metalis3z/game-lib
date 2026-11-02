-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Bunni.lol Decompiler

local v_replicatedstorage = game:GetService("ReplicatedStorage")
local v_u1 = require(v_replicatedstorage.Datas.Rebirth)
local v_u2 = require(v_replicatedstorage.UserGenerated.ABTests)
return function(arg1, arg2)
	-- upvalues: (copy) v_u2, (copy) v_u1
	return v_u2.GetAttribute(arg1, ("Rebirth.Cost.%*"):format(arg2), v_u1[arg2].Requirements.Cash)
end