-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:16:40
-- Luau version 6, Types version 3
-- Time taken: 0.004730 seconds

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Pets_upvr = require(ReplicatedStorage.Shared.List.Pets.Pets)
local Functions_upvr = require(ReplicatedStorage.Shared.Functions)
local Special_upvr = require(ReplicatedStorage.Shared.List.Pets.Special)
local _Core_upvr = require(script.Parent._Core)
local module_upvr = {}
module_upvr.__index = module_upvr
setmetatable(module_upvr, {
	__index = _Core_upvr;
	__call = function(arg1, ...) -- Line 17, Named "__call"
		return arg1.new(...)
	end;
})
function module_upvr.new(arg1) -- Line 22
	--[[ Upvalues[3]:
		[1]: _Core_upvr (readonly)
		[2]: module_upvr (readonly)
		[3]: Functions_upvr (readonly)
	]]
	local any_new_result1 = _Core_upvr.new()
	any_new_result1.cl = "pet"
	any_new_result1.nm = arg1
	any_new_result1.ti = 1
	setmetatable(any_new_result1, module_upvr)
	if not any_new_result1:directory()[any_new_result1:getName()] then
		Functions_upvr.print(`Class {any_new_result1:getClass()} has invalid name: {any_new_result1:getName()}! {debug.traceback()}`, warn)
	end
	return any_new_result1
end
function module_upvr.directory(arg1) -- Line 38
	--[[ Upvalues[1]:
		[1]: Pets_upvr (readonly)
	]]
	return Pets_upvr
end
function module_upvr.setSerial(arg1, arg2) -- Line 42
	arg1.sl = arg2
end
function module_upvr.getSerial(arg1) -- Line 46
	return arg1.sl
end
function module_upvr.getSerialUsername(arg1) -- Line 50
	return arg1:getSerial().un
end
function module_upvr.getSerialNumber(arg1) -- Line 53
	return arg1:getSerial().nr
end
function module_upvr.setShiny(arg1, arg2) -- Line 57
	arg1.sh = arg2
	return arg1
end
function module_upvr.isShiny(arg1) -- Line 61
	return arg1.sh
end
function module_upvr.setLocked(arg1, arg2) -- Line 65
	arg1.lk = arg2
	return arg1
end
function module_upvr.getLocked(arg1) -- Line 70
	return arg1.lk
end
function module_upvr.setTier(arg1, arg2) -- Line 74
	arg1.ti = arg2
	return arg1
end
function module_upvr.getTier(arg1) -- Line 79
	return arg1.ti or 1
end
function module_upvr.getSpecial(arg1) -- Line 83
	--[[ Upvalues[1]:
		[1]: Pets_upvr (readonly)
	]]
	return Pets_upvr[arg1:getName()].special
end
function module_upvr.isUntradeable(arg1) -- Line 87
	--[[ Upvalues[1]:
		[1]: Pets_upvr (readonly)
	]]
	return Pets_upvr[arg1:getName()].untradeable
end
function module_upvr.getLayoutOrder(arg1) -- Line 91
	local var9
	local function INLINED() -- Internal function, doesn't exist in bytecode
		var9 = arg1:getSpecial() * 5
		return var9
	end
	if not arg1:getSpecial() or not INLINED() then
		var9 = 1
	end
	return -math.log(arg1:getMultiplier()) * var9 * 100
end
function module_upvr.getSpecialPercentage(arg1) -- Line 95
	--[[ Upvalues[1]:
		[1]: Special_upvr (readonly)
	]]
	local var10
	local function INLINED_2() -- Internal function, doesn't exist in bytecode
		var10 = Special_upvr.shiny - 1
		return var10
	end
	if not arg1:isShiny() or not INLINED_2() then
		var10 = 0
	end
	return (arg1:getSpecial()) + (Special_upvr.tiers[arg1:getTier()] - 1) + var10
end
local RunService_upvr = game:GetService("RunService")
function module_upvr.getMultiplier(arg1, arg2, arg3) -- Line 104 (self, data, ignoreServer)
	local baseMultiplier = Pets_upvr[arg1:getName()].multiplier

	if arg1:getSpecial() and (RunService_upvr:IsServer() or arg3) then
		-- Special pet: use special tier multiplier
		local tierMult = Special_upvr.tiers[arg1:getTier()]
		if arg1:isShiny() then
			tierMult = tierMult * Special_upvr.shiny
		end
		return baseMultiplier * tierMult
	end

	-- Normal path: tier doubling + shiny bonus
	local tierMult = 2 ^ (arg1:getTier() - 1)
	baseMultiplier = baseMultiplier * tierMult
	if arg1:isShiny() then
		baseMultiplier = baseMultiplier * 1.5
	end
	return baseMultiplier
end
function module_upvr.getAverageMultiplier(arg1, arg2) -- Line 127
	--[[ Upvalues[2]:
		[1]: Functions_upvr (readonly)
		[2]: module_upvr (readonly)
	]]
	-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
	local pet = arg2.inventory.pet
	if not pet then
		pet = {}
	end
	local tbl = {}
	for i, v in Functions_upvr.deepCopy(pet), nil do
		local any_setData_result1 = module_upvr.new(v.nm):setData(v)
		if not any_setData_result1:getSpecial() then
			tbl[#tbl + 1] = {
				itemId = i;
				item = any_setData_result1;
			}
		end
	end
	table.sort(tbl, function(arg1_2, arg2_2) -- Line 140
		local var33
		if arg2_2.item:getMultiplier() >= arg1_2.item:getMultiplier() then
			var33 = false
		else
			var33 = true
		end
		return var33
	end)
	while true do
		i = 10
		if i <= 0 then break end
		i = tbl[1]
		local var35
		if not i then
			var35 += 1
		else
			v = i.item:getAmount()
			for _ = 1, v do
				if 10 <= var35 then break end
				var35 += 1
			end
		end
	end
	return (0 + 1 + i.item:getMultiplier()) / var35
end
function module_upvr.getDescription(arg1) -- Line 176
	--[[ Upvalues[1]:
		[1]: Pets_upvr (readonly)
	]]
	return Pets_upvr[arg1:getName()].desc
end
function module_upvr.getIcon(arg1) -- Line 180
	--[[ Upvalues[1]:
		[1]: Pets_upvr (readonly)
	]]
	return Pets_upvr[arg1:getName()].images[arg1:getTier()]
end
function module_upvr.getRarity(arg1) -- Line 184
	--[[ Upvalues[1]:
		[1]: Pets_upvr (readonly)
	]]
	return Pets_upvr[arg1:getName()].rarity
end
function module_upvr.isPaid(arg1) -- Line 188
	--[[ Upvalues[1]:
		[1]: Pets_upvr (readonly)
	]]
	return Pets_upvr[arg1:getName()].isPaid
end
return module_upvr