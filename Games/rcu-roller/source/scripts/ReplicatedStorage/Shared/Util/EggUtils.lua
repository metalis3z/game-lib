-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:16:32
-- Luau version 6, Types version 3
-- Time taken: 0.001712 seconds

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Eggs_upvr = require(ReplicatedStorage.Shared.List.Pets.Eggs)
local Pets_upvr = require(ReplicatedStorage.Shared.List.Pets.Pets)
local module_upvr = {
	getCurrency = function(arg1) -- Line 18, Named "getCurrency"
		--[[ Upvalues[1]:
			[1]: Eggs_upvr (readonly)
		]]
		local var5 = Eggs_upvr[arg1]
		if not var5.currency then
			return "clicks"
		end
		return var5.currency
	end;
}
local Values_upvr = require(ReplicatedStorage.Shared.Values)
function module_upvr.getMaxAffordable(arg1, arg2, arg3) -- Line 28
	--[[ Upvalues[3]:
		[1]: Eggs_upvr (readonly)
		[2]: module_upvr (readonly)
		[3]: Values_upvr (readonly)
	]]
	return math.floor(math.clamp(arg2[module_upvr.getCurrency(arg3)] / Eggs_upvr[arg3].cost, 1, Values_upvr.maxEggs(arg1, arg2)))
end
function module_upvr.getAmountFromOpenType(arg1, arg2, arg3, arg4) -- Line 35
	--[[ Upvalues[1]:
		[1]: module_upvr (readonly)
	]]
	if arg4 == 1 then
		return 1
	end
	return module_upvr.getMaxAffordable(arg1, arg2, arg3)
end
function module_upvr.hasEnoughToOpen(arg1, arg2, arg3) -- Line 43
	--[[ Upvalues[2]:
		[1]: Eggs_upvr (readonly)
		[2]: module_upvr (readonly)
	]]
	local var7 = arg2
	if Eggs_upvr[arg2].cost * arg3 > arg1[module_upvr.getCurrency(var7)] then
		var7 = false
	else
		var7 = true
	end
	return var7
end
function module_upvr.getEggNameFromPetName(arg1) -- Line 50
	--[[ Upvalues[1]:
		[1]: Eggs_upvr (readonly)
	]]
	for i, v in Eggs_upvr do
		for i_2, _ in v.pets do
			if i_2 == arg1 then
				return i
			end
		end
	end
end
function module_upvr.getPityPet(arg1) -- Line 62
	--[[ Upvalues[2]:
		[1]: Eggs_upvr (readonly)
		[2]: Pets_upvr (readonly)
	]]
	for i_3, _ in Eggs_upvr[arg1].pets do
		local var14 = Pets_upvr[i_3]
		if var14.rarity == "Mythical" and var14.luck then
			return i_3
		end
	end
end
function module_upvr.getPityProgress(arg1, arg2) -- Line 76
	--[[ Upvalues[3]:
		[1]: Eggs_upvr (readonly)
		[2]: module_upvr (readonly)
		[3]: Pets_upvr (readonly)
	]]
	local var16 = arg1.pity[arg2]
	if not var16 then return end
	return (var16) / (1 / Eggs_upvr[arg2].pets[module_upvr.getPityPet(arg2)] * 50)
end
return module_upvr