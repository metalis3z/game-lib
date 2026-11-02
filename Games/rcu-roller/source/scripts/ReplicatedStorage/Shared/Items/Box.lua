-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:16:43
-- Luau version 6, Types version 3
-- Time taken: 0.001582 seconds

local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local _Core_upvr = require(script.Parent._Core)
local module_upvr = {}
module_upvr.__index = module_upvr
setmetatable(module_upvr, {
	__index = _Core_upvr;
	__call = function(arg1, ...) -- Line 16, Named "__call"
		return arg1.new(...)
	end;
})
function module_upvr.new(arg1) -- Line 21
	--[[ Upvalues[2]:
		[1]: _Core_upvr (readonly)
		[2]: module_upvr (readonly)
	]]
	local any_new_result1 = _Core_upvr.new()
	any_new_result1.cl = "box"
	any_new_result1.nm = arg1
	setmetatable(any_new_result1, module_upvr)
	return any_new_result1
end
function module_upvr.directory(arg1) -- Line 36
	--[[ Upvalues[1]:
		[1]: ReplicatedStorage_upvr (readonly)
	]]
	return require(ReplicatedStorage_upvr.Shared.List.Items.Boxes)
end
function module_upvr.getRealName(arg1) -- Line 40
	return arg1:directory()[arg1:getName()].name
end
function module_upvr.getDescription(arg1) -- Line 43
	return arg1:directory()[arg1:getName()].description
end
function module_upvr.isUntradeable(arg1) -- Line 47
	return arg1:directory()[arg1:getName()].untradeable
end
function module_upvr.isUnusable(arg1) -- Line 50
	return arg1:directory()[arg1:getName()].unusable
end
function module_upvr.getLayoutOrder(arg1) -- Line 54
	return arg1:directory()[arg1:getName()].layoutOrder or 1
end
function module_upvr.getIcon(arg1) -- Line 58
	return arg1:directory()[arg1:getName()].icon
end
function module_upvr.getRarity(arg1) -- Line 62
	return arg1:directory()[arg1:getName()].rarity
end
function module_upvr.getRewards(arg1) -- Line 66
	return arg1:directory()[arg1:getName()].rewards
end
function module_upvr.getRewardAmount(arg1) -- Line 70
	return arg1:directory()[arg1:getName()].rewardAmount
end
return module_upvr