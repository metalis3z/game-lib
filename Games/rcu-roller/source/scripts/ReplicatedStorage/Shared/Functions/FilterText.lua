-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:17:23
-- Luau version 6, Types version 3
-- Time taken: 0.001228 seconds

local TextService_upvr = game:GetService("TextService")
return function(arg1, arg2) -- Line 11
	--[[ Upvalues[1]:
		[1]: TextService_upvr (readonly)
	]]
	local function _() -- Line 12, Named "getTextObject"
		--[[ Upvalues[3]:
			[1]: TextService_upvr (copied, readonly)
			[2]: arg1 (readonly)
			[3]: arg2 (readonly)
		]]
		local pcall_result1, pcall_result2 = pcall(function() -- Line 13
			--[[ Upvalues[3]:
				[1]: TextService_upvr (copied, readonly)
				[2]: arg1 (copied, readonly)
				[3]: arg2 (copied, readonly)
			]]
			return TextService_upvr:FilterStringAsync(arg1, arg2)
		end)
		if not pcall_result1 then
			warn("Error generating TextFilterResult:", pcall_result2)
			return ""
		end
		return pcall_result2
	end
	local function _(arg1_2) -- Line 25, Named "getFilteredMessage"
		local pcall_result1_3, pcall_result2_2 = pcall(function() -- Line 26
			--[[ Upvalues[1]:
				[1]: arg1_2 (readonly)
			]]
			return arg1_2:GetNonChatStringForBroadcastAsync()
		end)
		if not pcall_result1_3 then
			warn("Error filtering message:", pcall_result2_2)
			return ""
		end
		return pcall_result2_2
	end
	local pcall_result1_2, pcall_result2_3 = pcall(function() -- Line 13
		--[[ Upvalues[3]:
			[1]: TextService_upvr (copied, readonly)
			[2]: arg1 (readonly)
			[3]: arg2 (readonly)
		]]
		return TextService_upvr:FilterStringAsync(arg1, arg2)
	end)
	local var12_upvr
	if not pcall_result1_2 then
		warn("Error generating TextFilterResult:", pcall_result2_3)
		var12_upvr = ""
	else
		var12_upvr = pcall_result2_3
	end
	local pcall_result1_4, pcall_result2_4 = pcall(function() -- Line 26
		--[[ Upvalues[1]:
			[1]: var12_upvr (readonly)
		]]
		return var12_upvr:GetNonChatStringForBroadcastAsync()
	end)
	if not pcall_result1_4 then
		warn("Error filtering message:", pcall_result2_4)
		return ""
	end
	return pcall_result2_4
end