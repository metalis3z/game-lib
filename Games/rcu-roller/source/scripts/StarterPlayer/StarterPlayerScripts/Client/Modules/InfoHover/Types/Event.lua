-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:21:03
-- Luau version 6, Types version 3
-- Time taken: 0.001345 seconds

local Knit = require(game:GetService("ReplicatedStorage").Packages.Knit)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Assets_upvr = ReplicatedStorage.Assets
function getComponent(arg1) -- Line 20
	--[[ Upvalues[1]:
		[1]: Assets_upvr (readonly)
	]]
	return Assets_upvr.UI.InfoHover.Components[arg1]:Clone()
end
function addComponent(arg1, arg2) -- Line 24
	arg1[#arg1 + 1] = arg2
end
local any_GetController_result1_upvr_2 = Knit.GetController("DataController")
local any_GetController_result1_upvr = Knit.GetController("FFlagController")
local FFlags_upvr = require(ReplicatedStorage.Shared.List.FFlags)
return function(arg1) -- Line 28
	--[[ Upvalues[3]:
		[1]: any_GetController_result1_upvr_2 (readonly)
		[2]: any_GetController_result1_upvr (readonly)
		[3]: FFlags_upvr (readonly)
	]]
	local module = {}
	local getComponent_result1 = getComponent("HoverName")
	local var10
	if arg1.fFlag == "extraEggs" then
		var10 = `+{any_GetController_result1_upvr:getFFlag(arg1.fFlag)}`
	else
		var10 = `x{any_GetController_result1_upvr:getFFlag(arg1.fFlag)}`
	end
	getComponent_result1.Text = `{var10} {FFlags_upvr[arg1.fFlag].name}`
	addComponent(module, getComponent_result1)
	if 14 <= #getComponent_result1.Text then
		getComponent_result1.Size += UDim2.fromScale(0, 0.095)
	end
	return module
end