-- Saved by anthu decompiler gui script (used universalsynsaveinstance) (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v1 = game:GetService("ReplicatedStorage")
require(v1.Registries.BrainrotRegistry)
require(v1.Registries.FuseMachineRegistry)
require(v1.Registries.RarityRegistry)
require(v1.Types.ItemSchemas)
return function(p2)
	local v3 = 1
	for _, v4 in p2 do
		v3 = v3 + (v4.Metadata.Level - 1) * 0.002
	end
	return v3
end
