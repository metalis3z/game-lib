-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:16:56
-- Luau version 6, Types version 3
-- Time taken: 0.000799 seconds

return function(arg1) -- Line 7
	local module_2 = {}
	for i in debug.traceback():gmatch("[^\n]+") do
		local any_match_result1_4 = i:match("([^:]+):")
		if any_match_result1_4 then
			local any_match_result1 = any_match_result1_4:match("%w+$")
			if table.find(module_2, any_match_result1) == nil then
				table.insert(module_2, any_match_result1)
			end
		end
	end
	return module_2[arg1]
end