-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:16:35
-- Luau version 6, Types version 3
-- Time taken: 0.000793 seconds

local Settings_upvr = require(game.ReplicatedStorage.Shared.List.Settings)
local module_upvr = {
	getSetting = function(arg1, arg2) -- Line 13, Named "getSetting"
		--[[ Upvalues[1]:
			[1]: Settings_upvr (readonly)
		]]
		local var3 = Settings_upvr[arg2]
		if not arg1.settings[arg2] then
			if typeof(var3) == "boolean" then
				return var3
			end
			return 1
		end
		return arg1.settings[arg2]
	end;
}
function module_upvr.getSettingValue(arg1, arg2) -- Line 27
	--[[ Upvalues[2]:
		[1]: module_upvr (readonly)
		[2]: Settings_upvr (readonly)
	]]
	local any_getSetting_result1 = module_upvr.getSetting(arg1, arg2)
	local var5 = Settings_upvr[arg2][any_getSetting_result1]
	if not var5 then return end
	if not var5.value then return end
	return Settings_upvr[arg2][any_getSetting_result1].value
end
return module_upvr