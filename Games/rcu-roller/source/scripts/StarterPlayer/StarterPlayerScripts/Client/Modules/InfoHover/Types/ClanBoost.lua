-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:20:59
-- Luau version 6, Types version 3
-- Time taken: 0.002250 seconds

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Assets_upvr = ReplicatedStorage.Assets
function getComponent(arg1) -- Line 19
	--[[ Upvalues[1]:
		[1]: Assets_upvr (readonly)
	]]
	return Assets_upvr.UI.InfoHover.Components[arg1]:Clone()
end
function addComponent(arg1, arg2) -- Line 23
	arg1[#arg1 + 1] = arg2
end
local any_GetController_result1_upvr = require(game:GetService("ReplicatedStorage").Packages.Knit).GetController("DataController")
local Buildings_upvr = require(ReplicatedStorage.Shared.List.Clans.Buildings)
local Items_upvr = require(ReplicatedStorage.Shared.Items)
local Functions_upvr = require(ReplicatedStorage.Shared.Functions)
return function() -- Line 27
	--[[ Upvalues[4]:
		[1]: any_GetController_result1_upvr (readonly)
		[2]: Buildings_upvr (readonly)
		[3]: Items_upvr (readonly)
		[4]: Functions_upvr (readonly)
	]]
	-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
	local module = {}
	local getComponent_result1_2 = getComponent("HoverName")
	getComponent_result1_2.Text = "Clan Boosts"
	addComponent(module, getComponent_result1_2)
	addComponent(module, getComponent("LineInvisible"))
	local tbl = {}
	for i, v in Buildings_upvr do
		if any_GetController_result1_upvr:getData().clanBuildings[i] and v.upgrade then
			local _1 = v.upgrade[1]
			tbl[_1:getName()] = (tbl[_1:getName()] or 0) + _1:getAmount()
		end
	end
	for i_2, v_2 in tbl do
		local any_upgrade_result1 = Items_upvr.upgrade(i_2)
		local getComponent_result1 = getComponent("Description")
		local var30
		if any_upgrade_result1:getShowRealNumber() then
			var30 = 1
		else
			var30 = 100
		end
		local var31 = v_2 * var30
		var30 = any_upgrade_result1:getHidePercentage()
		if var30 then
		else
		end
		getComponent_result1.Text = `{`+{Functions_upvr.floatingPoint(var31)}{'%'}`} {any_upgrade_result1:getRealName()}`
		getComponent_result1.Size = UDim2.fromScale(0.787, 0.055)
		addComponent(module, getComponent_result1)
	end
	-- KONSTANTERROR: Expression was reused, decompilation is incorrect
	if Functions_upvr.getAmountInTable(any_GetController_result1_upvr:getData().clanBuildings) == 0 then
		local getComponent_result1_3 = getComponent("Description")
		getComponent_result1_3.Text = "You don't have any boosts yet!"
		i_2 = getComponent_result1_3
		addComponent(module, i_2)
	end
	return module
end