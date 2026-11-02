-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:20:51
-- Luau version 6, Types version 3
-- Time taken: 0.000976 seconds

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Assets_upvr = ReplicatedStorage.Assets
function getComponent(arg1) -- Line 17
	--[[ Upvalues[1]:
		[1]: Assets_upvr (readonly)
	]]
	return Assets_upvr.UI.InfoHover.Components[arg1]:Clone()
end
function addComponent(arg1, arg2) -- Line 21
	arg1[#arg1 + 1] = arg2
end
local any_GetController_result1_upvr = require(game:GetService("ReplicatedStorage").Packages.Knit).GetController("DataController")
local Functions_upvr = require(ReplicatedStorage.Shared.Functions)
return function() -- Line 25
	--[[ Upvalues[2]:
		[1]: any_GetController_result1_upvr (readonly)
		[2]: Functions_upvr (readonly)
	]]
	local any_getData_result1 = any_GetController_result1_upvr:getData()
	local module = {}
	local getComponent_result1 = getComponent("HoverName")
	getComponent_result1.Text = "Daily Streak"
	addComponent(module, getComponent_result1)
	addComponent(module, getComponent("LineInvisible"))
	local getComponent_result1_2 = getComponent("Description")
	getComponent_result1_2.Text = `+{Functions_upvr.floatingPoint(math.clamp(any_getData_result1.day * 0.01, 0, 0.3) * 100)}% Luck\n+{Functions_upvr.floatingPoint(math.clamp(any_getData_result1.day * 0.02, 0, 0.6) * 100)}% Aura Luck`
	getComponent_result1_2.Size = UDim2.fromScale(0.787, 0.145)
	addComponent(module, getComponent_result1_2)
	return module
end