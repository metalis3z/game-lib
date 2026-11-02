-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:20:57
-- Luau version 6, Types version 3
-- Time taken: 0.001602 seconds

local Knit = require(game:GetService("ReplicatedStorage").Packages.Knit)
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
local any_GetController_result1_upvr = Knit.GetController("DataController")
local Util_upvr = require(ReplicatedStorage.Shared.Util)
local any_GetController_result1_upvr_2 = Knit.GetController("AuraController")
return function(arg1) -- Line 27
	--[[ Upvalues[3]:
		[1]: any_GetController_result1_upvr (readonly)
		[2]: Util_upvr (readonly)
		[3]: any_GetController_result1_upvr_2 (readonly)
	]]
	local module = {}
	local item = arg1.item
	local getComponent_result1_2 = getComponent("HoverName")
	getComponent_result1_2.Text = item:getRealName()
	addComponent(module, getComponent_result1_2)
	if 14 <= #item:getRealName() then
		getComponent_result1_2.Size += UDim2.fromScale(0, 0.095)
		local getComponent_result1 = getComponent("LineInvisible")
		getComponent_result1.Size = UDim2.fromScale(getComponent_result1.Size.X.Scale, 0)
		addComponent(module, getComponent_result1)
	end
	if item:getDescription() then
		local getComponent_result1_4 = getComponent("Description")
		getComponent_result1_4.Text = item:getDescription()
		addComponent(module, getComponent_result1_4)
	end
	if table.find({6, 7, 8, 9, 10, 11}, Util_upvr.itemUtils.getRarityId(item:getRarity())) then
		local getComponent_result1_3_upvr = getComponent("Exists")
		local any_getAuraDescriptor_result1_upvr = Util_upvr.auraUtils.getAuraDescriptor(item)
		local any_getExist_result1 = any_GetController_result1_upvr_2:getExist(any_getAuraDescriptor_result1_upvr)
		if not any_getExist_result1 then
			task.delay(0.25, function() -- Line 59
				--[[ Upvalues[3]:
					[1]: getComponent_result1_3_upvr (readonly)
					[2]: any_GetController_result1_upvr_2 (copied, readonly)
					[3]: any_getAuraDescriptor_result1_upvr (readonly)
				]]
				if not getComponent_result1_3_upvr.Parent then
				else
					getComponent_result1_3_upvr.Text = `{any_GetController_result1_upvr_2:getExist(any_getAuraDescriptor_result1_upvr) or "???"} Exists`
				end
			end)
		end
		getComponent_result1_3_upvr.Text = `{any_getExist_result1 or "???"} Exists`
		addComponent(module, getComponent("Line"))
		addComponent(module, getComponent_result1_3_upvr)
	end
	return module
end