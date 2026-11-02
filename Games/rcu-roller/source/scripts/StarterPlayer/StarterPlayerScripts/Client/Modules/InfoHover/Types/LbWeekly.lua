-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:20:58
-- Luau version 6, Types version 3
-- Time taken: 0.001104 seconds

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local tbl_upvr = {
	["1-1"] = 0.35;
	["2-3"] = 0.25;
	["4-10"] = 0.2;
}
local Assets_upvr = ReplicatedStorage.Assets
function getComponent(arg1) -- Line 23
	--[[ Upvalues[1]:
		[1]: Assets_upvr (readonly)
	]]
	return Assets_upvr.UI.InfoHover.Components[arg1]:Clone()
end
function addComponent(arg1, arg2) -- Line 27
	arg1[#arg1 + 1] = arg2
end
local any_GetController_result1_upvr = require(game:GetService("ReplicatedStorage").Packages.Knit).GetController("DataController")
local Functions_upvr = require(ReplicatedStorage.Shared.Functions)
return function() -- Line 31
	--[[ Upvalues[3]:
		[1]: any_GetController_result1_upvr (readonly)
		[2]: Functions_upvr (readonly)
		[3]: tbl_upvr (readonly)
	]]
	local module = {}
	local getComponent_result1_2 = getComponent("HoverName")
	getComponent_result1_2.Text = "Weekly Boost"
	addComponent(module, getComponent_result1_2)
	addComponent(module, getComponent("LineInvisible"))
	for i, v in tbl_upvr do
		if any_GetController_result1_upvr:getData().weeklyLeaderboardBoosts[`{Functions_upvr.getWeekNumber(7200) - 1}-{i}`] then
			local getComponent_result1 = getComponent("Description")
			getComponent_result1.Text = `+{Functions_upvr.floatingPoint(v * 100)}% Luck`
			getComponent_result1.Size = UDim2.fromScale(0.787, 0.072)
			addComponent(module, getComponent_result1)
		end
	end
	return module
end