-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:17:58
-- Luau version 6, Types version 3
-- Time taken: 0.000563 seconds

local SpinSpeed_upvr = require(game:GetService("ReplicatedStorage").Shared.List.SpinSpeed)
return function(arg1, arg2) -- Line 11
	--[[ Upvalues[1]:
		[1]: SpinSpeed_upvr (readonly)
	]]
	local var5
	for i = #SpinSpeed_upvr, 1, -1 do
		if arg2.stats.ancientWheelSpins >= SpinSpeed_upvr[i].amount then
			var5 = i
			return var5
		end
	end
	return var5 or 1
end