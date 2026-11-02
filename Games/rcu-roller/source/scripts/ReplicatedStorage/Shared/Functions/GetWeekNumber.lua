-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:17:25
-- Luau version 6, Types version 3
-- Time taken: 0.000303 seconds

return function(arg1) -- Line 7
	return math.floor(((os.time()) - (144000 + (arg1 or 0))) / 60 / 60 / 24 / 7) + 1
end