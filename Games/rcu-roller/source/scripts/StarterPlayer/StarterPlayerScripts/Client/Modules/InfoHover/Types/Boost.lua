-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:20:55
-- Luau version 6, Types version 3
-- Time taken: 0.001449 seconds

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
return function(arg1) -- Line 25
	--[[ Upvalues[2]:
		[1]: any_GetController_result1_upvr (readonly)
		[2]: Functions_upvr (readonly)
	]]
	local module = {}
	local item_upvr = arg1.item
	local getComponent_result1_2_upvr = getComponent("HoverName")
	getComponent_result1_2_upvr.Text = item_upvr:getRealName()
	addComponent(module, getComponent_result1_2_upvr)
	if 14 <= #item_upvr:getRealName() then
		getComponent_result1_2_upvr.Size += UDim2.fromScale(0, 0.095)
		local getComponent_result1_3 = getComponent("LineInvisible")
		getComponent_result1_3.Size = UDim2.fromScale(getComponent_result1_3.Size.X.Scale, 0)
		addComponent(module, getComponent_result1_3)
	end
	if item_upvr:getDescription() then
		local getComponent_result1 = getComponent("Description")
		getComponent_result1.Text = item_upvr:getDescription()
		addComponent(module, getComponent_result1)
	end
	addComponent(module, getComponent("Line"))
	local getComponent_result1_upvr = getComponent("GenericText")
	getComponent_result1_upvr.Text = '?'
	getComponent_result1_upvr.Size = UDim2.fromScale(0.871, 0.065)
	addComponent(module, getComponent_result1_upvr)
	local any_getData_result1_upvr = any_GetController_result1_upvr:getData()
	task.spawn(function() -- Line 57
		--[[ Upvalues[5]:
			[1]: getComponent_result1_2_upvr (readonly)
			[2]: any_getData_result1_upvr (readonly)
			[3]: item_upvr (readonly)
			[4]: getComponent_result1_upvr (readonly)
			[5]: Functions_upvr (copied, readonly)
		]]
		task.wait()
		while getComponent_result1_2_upvr.Parent do
			task.wait()
			local var14 = any_getData_result1_upvr.activeBoosts[item_upvr:getName()]
			if not var14 then break end
			getComponent_result1_upvr.Text = Functions_upvr.formatTime(var14)
		end
	end)
	return module
end