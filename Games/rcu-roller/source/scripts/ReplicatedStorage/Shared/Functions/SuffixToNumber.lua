-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:17:35
-- Luau version 6, Types version 3
-- Time taken: 0.001476 seconds

local tbl_upvr = {}
for i, v in ipairs({'K', 'M', 'B', 'T', "Qd", "Qn", "Sx", "Sp", 'O', 'N', "de", "Ud", "DD", "tdD", "qdD", "QnD", "sxD", "SpD", "OcD", "NvD", "Vgn", "UVg", "DVg", "TVg", "qtV", "QnV", "SeV", "SPG", "OVG", "NVG", "TGN", "UTG", "DTG", "tsTG", "qtTG", "QnTG", "ssTG", "SpTG", "OcTG", "NoAG", "UnAG", "DuAG", "TeAG", "QdAG", "QnAG", "SxAG", "SpAG", "OcAG", "NvAG", "CT", "Aa", "Ab", "Ac", "Ad", "Ae", "Af", "Ag", "Ah", "Ai", "Aj", "Ak", "Al", "Am", "An", "Ao", "Ap", "Aq", "Ar", "As", "At", "Au", "Av", "Aw", "Ax", "Ay", "Az", "Ba", "Bb", "Bc", "Bd", "Be", "Bf", "Bg", "Bh", "Bi", "Bj", "Bk", "Bl", "Bm", "Bn", "Bo", "Bp", "Bq", "Br", "Bs", "Bt", "Bu", "Bv", "Bw", "Bx", "By", "Bz"}) do
	tbl_upvr[v:lower()] = i
end
return function(arg1) -- Line 17
	--[[ Upvalues[1]:
		[1]: tbl_upvr (readonly)
	]]
	local any_match_result1, any_match_result2 = arg1:match("([%d%.]+)(%a*)")
	local tonumber_result1 = tonumber(any_match_result1)
	if not tonumber_result1 then
		return nil
	end
	if any_match_result2 == "" then
		return tonumber_result1
	end
	local var14 = tbl_upvr[any_match_result2:lower()]
	if var14 then
		return tonumber_result1 * 10 ^ (var14 * 3)
	end
	return nil
end