-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:17:34
-- Luau version 6, Types version 3
-- Time taken: 0.000547 seconds

return function(arg1) -- Line 7
	local var2_upvw
	local pcall_result1, pcall_result2 = pcall(function() -- Line 10
		--[[ Upvalues[2]:
			[1]: var2_upvw (read and write)
			[2]: arg1 (readonly)
		]]
		var2_upvw = arg1:IsInGroup(5522949)
	end)
	if not pcall_result1 then
		warn(`[{script.Name}]: Kunde inte f\xE5 om {arg1.Name} \xE4r i grupp: {pcall_result2}`)
		return
	end
	return var2_upvw
end