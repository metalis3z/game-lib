-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:17:14
-- Luau version 6, Types version 3
-- Time taken: 0.000538 seconds

return function(arg1) -- Line 9
	local function _(arg1_2) -- Line 10, Named "format"
		return string.format("%02i", arg1_2)
	end
	local var2 = (arg1 - arg1 % 60) / 60
	local var3 = (var2 - var2 % 60) / 60
	return string.format("%02i", var3)..':'..string.format("%02i", var2 - var3 * 60)..':'..string.format("%02i", arg1 - var2 * 60)
end