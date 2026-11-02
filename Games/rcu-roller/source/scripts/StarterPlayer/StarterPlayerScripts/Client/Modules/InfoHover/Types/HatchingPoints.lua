-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:21:02
-- Luau version 6, Types version 3
-- Time taken: 0.001311 seconds

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Assets_upvr = ReplicatedStorage.Assets
function getComponent(arg1) -- Line 18
	--[[ Upvalues[1]:
		[1]: Assets_upvr (readonly)
	]]
	return Assets_upvr.UI.InfoHover.Components[arg1]:Clone()
end
function addComponent(arg1, arg2) -- Line 22
	arg1[#arg1 + 1] = arg2
end
local any_GetController_result1_upvr = require(game:GetService("ReplicatedStorage").Packages.Knit).GetController("DataController")
local HatchingPoints_upvr = require(ReplicatedStorage.Shared.List.Clans.HatchingPoints)
return function() -- Line 26
	--[[ Upvalues[2]:
		[1]: any_GetController_result1_upvr (readonly)
		[2]: HatchingPoints_upvr (readonly)
	]]
	local module = {}
	local tbl = {}
	for i, v in HatchingPoints_upvr do
		tbl[#tbl + 1] = {
			rarity = i;
			amount = v;
		}
	end
	table.sort(tbl, function(arg1, arg2) -- Line 40
		local var18
		if arg1.amount >= arg2.amount then
			var18 = false
		else
			var18 = true
		end
		return var18
	end)
	for _, v_2 in tbl do
		local getComponent_result1 = getComponent("AmountInfo")
		getComponent_result1.Label.Text = v_2.rarity
		getComponent_result1.Amount.Text = v_2.amount
		getComponent_result1.Size = UDim2.fromScale(0.9, 0.07)
		addComponent(module, getComponent_result1)
	end
	return module
end