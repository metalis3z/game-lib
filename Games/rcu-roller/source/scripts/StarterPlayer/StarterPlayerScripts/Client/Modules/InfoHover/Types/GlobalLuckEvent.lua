-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:20:56
-- Luau version 6, Types version 3
-- Time taken: 0.000982 seconds

local Knit = require(game:GetService("ReplicatedStorage").Packages.Knit)
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
local any_GetController_result1_upvr_2 = Knit.GetController("DataController")
local Functions_upvr = require(ReplicatedStorage.Shared.Functions)
local any_GetController_result1_upvr = Knit.GetController("EggController")
return function(arg1) -- Line 26
	--[[ Upvalues[3]:
		[1]: any_GetController_result1_upvr_2 (readonly)
		[2]: Functions_upvr (readonly)
		[3]: any_GetController_result1_upvr (readonly)
	]]
	local module = {}
	local getComponent_result1_3 = getComponent("HoverName")
	getComponent_result1_3.Text = "Global Luck Event"
	getComponent_result1_3.Size += UDim2.fromScale(0, 0.095)
	addComponent(module, getComponent_result1_3)
	local getComponent_result1_2 = getComponent("LineInvisible")
	getComponent_result1_2.Size = UDim2.fromScale(getComponent_result1_2.Size.X.Scale, 0)
	addComponent(module, getComponent_result1_2)
	local getComponent_result1 = getComponent("Description")
	getComponent_result1.Text = `Increases your luck multiplier by {Functions_upvr.floatingPoint(any_GetController_result1_upvr._globalLuckEventAmount * 100)}% while hatching eggs!`
	addComponent(module, getComponent_result1)
	return module
end