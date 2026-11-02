-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:16:47
-- Luau version 6, Types version 3
-- Time taken: 0.001705 seconds

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ActiveEvents_upvr = require(ReplicatedStorage.Shared.List.Items.ActiveEvents)
local _Core_upvr = require(script.Parent._Core)
local module_upvr = {}
module_upvr.__index = module_upvr
setmetatable(module_upvr, {
	__index = _Core_upvr;
	__call = function(arg1, ...) -- Line 16, Named "__call"
		return arg1.new(...)
	end;
})
local Functions_upvr = require(ReplicatedStorage.Shared.Functions)
function module_upvr.new(arg1) -- Line 21
	--[[ Upvalues[3]:
		[1]: _Core_upvr (readonly)
		[2]: module_upvr (readonly)
		[3]: Functions_upvr (readonly)
	]]
	local any_new_result1 = _Core_upvr.new()
	any_new_result1.cl = "activeEvent"
	any_new_result1.nm = arg1
	setmetatable(any_new_result1, module_upvr)
	if not any_new_result1:directory()[any_new_result1:getName()] then
		Functions_upvr.print(`Class {any_new_result1:getClass()} has invalid name: {any_new_result1:getName()}! {debug.traceback()}`, warn)
	end
	return any_new_result1
end
function module_upvr.directory(arg1) -- Line 36
	--[[ Upvalues[1]:
		[1]: ActiveEvents_upvr (readonly)
	]]
	return ActiveEvents_upvr
end
function module_upvr.getMultiplier(arg1) -- Line 40
	--[[ Upvalues[1]:
		[1]: ActiveEvents_upvr (readonly)
	]]
	return ActiveEvents_upvr[arg1:getName()].multiplier
end
function module_upvr.getSeconds(arg1) -- Line 44
	--[[ Upvalues[1]:
		[1]: ActiveEvents_upvr (readonly)
	]]
	return ActiveEvents_upvr[arg1:getName()].seconds
end
function module_upvr.getColor(arg1) -- Line 48
	--[[ Upvalues[1]:
		[1]: ActiveEvents_upvr (readonly)
	]]
	return ActiveEvents_upvr[arg1:getName()].color
end
function module_upvr.getRealName(arg1) -- Line 52
	--[[ Upvalues[1]:
		[1]: ActiveEvents_upvr (readonly)
	]]
	return ActiveEvents_upvr[arg1:getName()].name
end
function module_upvr.getDescription(arg1) -- Line 55
	--[[ Upvalues[1]:
		[1]: ActiveEvents_upvr (readonly)
	]]
	return ActiveEvents_upvr[arg1:getName()].description
end
function module_upvr.isUntradeable(arg1) -- Line 59
	--[[ Upvalues[1]:
		[1]: ActiveEvents_upvr (readonly)
	]]
	return ActiveEvents_upvr[arg1:getName()].untradeable
end
function module_upvr.isUnusable(arg1) -- Line 62
	--[[ Upvalues[1]:
		[1]: ActiveEvents_upvr (readonly)
	]]
	return ActiveEvents_upvr[arg1:getName()].unusable
end
function module_upvr.getLayoutOrder(arg1) -- Line 66
	--[[ Upvalues[1]:
		[1]: ActiveEvents_upvr (readonly)
	]]
	return ActiveEvents_upvr[arg1:getName()].layoutOrder
end
function module_upvr.getIcon(arg1) -- Line 70
	--[[ Upvalues[1]:
		[1]: ActiveEvents_upvr (readonly)
	]]
	return ActiveEvents_upvr[arg1:getName()].icon
end
function module_upvr.getRarity(arg1) -- Line 74
	--[[ Upvalues[1]:
		[1]: ActiveEvents_upvr (readonly)
	]]
	return ActiveEvents_upvr[arg1:getName()].rarity
end
return module_upvr