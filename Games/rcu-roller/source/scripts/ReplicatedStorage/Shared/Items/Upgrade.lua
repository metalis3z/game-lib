-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:16:52
-- Luau version 6, Types version 3
-- Time taken: 0.001567 seconds

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Upgrades_upvr = require(ReplicatedStorage.Shared.List.Items.Upgrades)
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
	any_new_result1.cl = "upgrade"
	any_new_result1.nm = arg1
	setmetatable(any_new_result1, module_upvr)
	if not any_new_result1:directory()[any_new_result1:getName()] then
		Functions_upvr.print(`Class {any_new_result1:getClass()} has invalid name: {any_new_result1:getName()}! {debug.traceback()}`, warn)
	end
	return any_new_result1
end
function module_upvr.directory(arg1) -- Line 36
	--[[ Upvalues[1]:
		[1]: Upgrades_upvr (readonly)
	]]
	return Upgrades_upvr
end
function module_upvr.getRealName(arg1) -- Line 40
	--[[ Upvalues[1]:
		[1]: Upgrades_upvr (readonly)
	]]
	return Upgrades_upvr[arg1:getName()].name
end
function module_upvr.getDescription(arg1) -- Line 44
	--[[ Upvalues[1]:
		[1]: Upgrades_upvr (readonly)
	]]
	return Upgrades_upvr[arg1:getName()].description
end
function module_upvr.isUntradeable(arg1) -- Line 48
	return false
end
function module_upvr.isUnusable(arg1) -- Line 51
	return true
end
function module_upvr.getLayoutOrder(arg1) -- Line 55
	return 1000000
end
function module_upvr.getIcon(arg1) -- Line 59
	--[[ Upvalues[1]:
		[1]: Upgrades_upvr (readonly)
	]]
	return Upgrades_upvr[arg1.nm].icon
end
function module_upvr.getRarity(arg1) -- Line 63
	return "Exclusive"
end
function module_upvr.getShowRealNumber(arg1) -- Line 67
	--[[ Upvalues[1]:
		[1]: Upgrades_upvr (readonly)
	]]
	return Upgrades_upvr[arg1:getName()].showRealNumber
end
function module_upvr.getHidePercentage(arg1) -- Line 71
	--[[ Upvalues[1]:
		[1]: Upgrades_upvr (readonly)
	]]
	return Upgrades_upvr[arg1:getName()].hidePercentage
end
return module_upvr