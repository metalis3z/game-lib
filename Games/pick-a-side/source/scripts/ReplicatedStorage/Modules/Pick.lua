-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-17 20:45:19
-- Luau version 6, Types version 3
-- Time taken: 0.001326 seconds

local random_state_upvr = Random.new()
return function(arg1, arg2, arg3) -- Line 4
	--[[ Upvalues[1]:
		[1]: random_state_upvr (readonly)
	]]
	-- KONSTANTERROR: [0] 1. Error Block 16 start (CF ANALYSIS FAILED)
	local var7 = 0
	for _, v in arg2 do
		var7 += v
	end
	local var8 = arg3
	if not var8 then
		var8 = random_state_upvr:NextNumber()
	end
	-- KONSTANTERROR: [0] 1. Error Block 16 end (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [26] 24. Error Block 8 start (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [26] 24. Error Block 8 end (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [21] 20. Error Block 6 start (CF ANALYSIS FAILED)
	-- KONSTANTERROR: Expression was reused, decompilation is incorrect
	-- KONSTANTERROR: [21] 20. Error Block 6 end (CF ANALYSIS FAILED)
end