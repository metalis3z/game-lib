-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:16:12
-- Luau version 6, Types version 3
-- Time taken: 0.001193 seconds

local module = {}
local Trove_upvr = require(script.Parent.Parent.Trove)
function module.Compound(arg1, arg2) -- Line 47
	--[[ Upvalues[1]:
		[1]: Trove_upvr (readonly)
	]]
	local any_new_result1 = Trove_upvr.new()
	local any_new_result1_upvr = Trove_upvr.new()
	local var9_upvw = false
	local function _() -- Line 51, Named "Check"
		--[[ Upvalues[4]:
			[1]: var9_upvw (read and write)
			[2]: arg1 (readonly)
			[3]: arg2 (readonly)
			[4]: any_new_result1_upvr (readonly)
		]]
		if var9_upvw then
		else
			for _, v_2 in pairs(arg1) do
				if not v_2.Instance then return end
			end
			var9_upvw = true
			arg2(arg1, any_new_result1_upvr)
		end
	end
	local function Cleanup_upvr() -- Line 63, Named "Cleanup"
		--[[ Upvalues[2]:
			[1]: var9_upvw (read and write)
			[2]: any_new_result1_upvr (readonly)
		]]
		if not var9_upvw then
		else
			var9_upvw = false
			any_new_result1_upvr:Clean()
		end
	end
	for _, v in pairs(arg1) do
		any_new_result1:Add(v:Observe(function(arg1_2, arg2_2) -- Line 71
			--[[ Upvalues[5]:
				[1]: var9_upvw (read and write)
				[2]: arg1 (readonly)
				[3]: arg2 (readonly)
				[4]: any_new_result1_upvr (readonly)
				[5]: Cleanup_upvr (readonly)
			]]
			-- KONSTANTERROR: [0] 1. Error Block 12 start (CF ANALYSIS FAILED)
			if var9_upvw then
				-- KONSTANTWARNING: GOTO [20] #18
			end
			-- KONSTANTERROR: [0] 1. Error Block 12 end (CF ANALYSIS FAILED)
			-- KONSTANTERROR: [3] 4. Error Block 10 start (CF ANALYSIS FAILED)
			local _, _, _ = pairs(arg1)
			-- KONSTANTERROR: [3] 4. Error Block 10 end (CF ANALYSIS FAILED)
		end))
	end
	any_new_result1:Add(Cleanup_upvr)
	return any_new_result1
end
return module