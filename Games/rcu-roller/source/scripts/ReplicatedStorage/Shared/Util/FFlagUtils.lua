-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:16:28
-- Luau version 6, Types version 3
-- Time taken: 0.000814 seconds

local FFlags_upvr = require(game.ReplicatedStorage.Shared.List.FFlags)
local module_upvr = {108167759}
return {
	getNameFromId = function(arg1) -- Line 15, Named "getNameFromId"
		--[[ Upvalues[1]:
			[1]: FFlags_upvr (readonly)
		]]
		assert(FFlags_upvr[arg1], `FFlag med fFlagId {arg1} finns inte`)
		return FFlags_upvr[arg1].name
	end;
	getIdFromName = function(arg1) -- Line 21, Named "getIdFromName"
		--[[ Upvalues[1]:
			[1]: FFlags_upvr (readonly)
		]]
		for i, v in FFlags_upvr do
			if v.name == arg1 then
				return i
			end
		end
	end;
	canBypass = function(arg1) -- Line 31, Named "canBypass"
		--[[ Upvalues[1]:
			[1]: module_upvr (readonly)
		]]
		return table.find(module_upvr, arg1)
	end;
}