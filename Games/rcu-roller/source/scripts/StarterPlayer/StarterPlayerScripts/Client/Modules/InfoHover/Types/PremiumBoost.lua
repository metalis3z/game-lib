-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:21:04
-- Luau version 6, Types version 3
-- Time taken: 0.000995 seconds

local Assets_upvr = game:GetService("ReplicatedStorage").Assets
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
local LocalPlayer_upvr = game.Players.LocalPlayer
return function() -- Line 26
	--[[ Upvalues[2]:
		[1]: any_GetController_result1_upvr (readonly)
		[2]: LocalPlayer_upvr (readonly)
	]]
	local module = {}
	local getComponent_result1_2 = getComponent("HoverName")
	getComponent_result1_2.Text = "Premium Boost"
	addComponent(module, getComponent_result1_2)
	addComponent(module, getComponent("LineInvisible"))
	local getComponent_result1 = getComponent("Description")
	if LocalPlayer_upvr.MembershipType == Enum.MembershipType.Premium then
		getComponent_result1.Text = "+10% Luck"
		getComponent_result1.Size = UDim2.fromScale(0.787, 0.072)
	else
		getComponent_result1.Text = "Premium players get an extra +10% Luck!"
		getComponent_result1.Size = UDim2.fromScale(0.787, 0.145)
	end
	addComponent(module, getComponent_result1)
	return module
end