-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:16:53
-- Luau version 6, Types version 3
-- Time taken: 0.001660 seconds

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local _Core_upvr = require(script.Parent._Core)
local module_upvr = {}
module_upvr.__index = module_upvr
setmetatable(module_upvr, {
	__index = _Core_upvr;
	__call = function(arg1, ...) -- Line 17, Named "__call"
		return arg1.new(...)
	end;
})
local Functions_upvr = require(ReplicatedStorage.Shared.Functions)
function module_upvr.new(arg1) -- Line 22
	--[[ Upvalues[3]:
		[1]: _Core_upvr (readonly)
		[2]: module_upvr (readonly)
		[3]: Functions_upvr (readonly)
	]]
	local any_new_result1 = _Core_upvr.new()
	any_new_result1.cl = "gamepass"
	any_new_result1.nm = arg1
	setmetatable(any_new_result1, module_upvr)
	if not any_new_result1:directory()[any_new_result1:getName()] then
		Functions_upvr.print(`Class {any_new_result1:getClass()} has invalid name: {any_new_result1:getName()}! {debug.traceback()}`, warn)
	end
	return any_new_result1
end
local IDs_upvr = require(ReplicatedStorage.Shared.List.Shop.IDs)
function module_upvr.directory(arg1) -- Line 37
	--[[ Upvalues[1]:
		[1]: IDs_upvr (readonly)
	]]
	return IDs_upvr
end
local MarketplaceService_upvr = game:GetService("MarketplaceService")
function module_upvr.getGamePassInfo(arg1) -- Line 41
	--[[ Upvalues[1]:
		[1]: MarketplaceService_upvr (readonly)
	]]
	local pcall_result1, pcall_result2 = pcall(function() -- Line 42
		--[[ Upvalues[2]:
			[1]: MarketplaceService_upvr (copied, readonly)
			[2]: arg1 (readonly)
		]]
		return MarketplaceService_upvr:GetProductInfo(arg1:directory()[arg1:getName()].gamePassId, Enum.InfoType.GamePass)
	end)
	if pcall_result1 then
		return pcall_result2
	end
	warn("[Gamepass]: Kunde inte f\xE5 Product Info")
	return {}
end
function module_upvr.getRealName(arg1) -- Line 55
	return arg1:getGamePassInfo().Name or '?'
end
function module_upvr.getDescription(arg1) -- Line 59
	return arg1:getGamePassInfo().Description or '?'
end
function module_upvr.isUntradeable(arg1) -- Line 63
	return false
end
function module_upvr.isUnusable(arg1) -- Line 66
	return true
end
function module_upvr.getLayoutOrder(arg1) -- Line 70
	return 1000000
end
function module_upvr.getIcon(arg1) -- Line 74
	return `rbxassetid://{arg1:getGamePassInfo().IconImageAssetId or '0'}`
end
function module_upvr.getRarity(arg1) -- Line 78
	return "Exclusive"
end
return module_upvr