-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:17:19
-- Luau version 6, Types version 3
-- Time taken: 0.000474 seconds

return function(arg1) -- Line 7
	local tostring_result1 = tostring(arg1)
	local any_match_result1, any_match_result2 = tostring_result1:match("^(%d*%.?%d+)(%a*)$")
	if any_match_result1 and any_match_result2 then
		return string.rep('?', #any_match_result1)..any_match_result2
	end
	return tostring_result1
end