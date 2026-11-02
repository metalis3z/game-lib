-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:17:48
-- Luau version 6, Types version 3
-- Time taken: 0.000419 seconds

local UpgradeUtils_upvr = require(game:GetService("ReplicatedStorage").Shared.Util.UpgradeUtils)
return function(arg1, arg2) -- Line 12
	--[[ Upvalues[1]:
		[1]: UpgradeUtils_upvr (readonly)
	]]
	return 1 + UpgradeUtils_upvr.getAllUpgradeMultipliers(arg2, "rebirthsMultiplier")
end