-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:21:00
-- Luau version 6, Types version 3
-- Time taken: 0.001082 seconds

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
local Functions_upvr = require(ReplicatedStorage.Shared.Functions)
return function(arg1) -- Line 27
	--[[ Upvalues[2]:
		[1]: any_GetController_result1_upvr (readonly)
		[2]: Functions_upvr (readonly)
	]]
	local module = {}
	for i_upvr, _ in arg1.passes do
		local getComponent_result1_upvr = getComponent("Description")
		getComponent_result1_upvr.Text = '?'
		getComponent_result1_upvr.Size = UDim2.fromScale(0.787, 0.07)
		addComponent(module, getComponent_result1_upvr)
		task.spawn(function() -- Line 38
			--[[ Upvalues[3]:
				[1]: Functions_upvr (copied, readonly)
				[2]: i_upvr (readonly)
				[3]: getComponent_result1_upvr (readonly)
			]]
			getComponent_result1_upvr.Text = `{Functions_upvr.getProductInfo(i_upvr).Name}`
		end)
	end
	return module
end