-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:20:54
-- Luau version 6, Types version 3
-- Time taken: 0.005923 seconds

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
local any_GetController_result1_upvr = Knit.GetController("DataController")
local Util_upvr = require(ReplicatedStorage.Shared.Util)
local Functions_upvr = require(ReplicatedStorage.Shared.Functions)
local any_GetController_result1_upvr_2 = Knit.GetController("PetController")
return function(arg1) -- Line 28
	--[[ Upvalues[4]:
		[1]: any_GetController_result1_upvr (readonly)
		[2]: Util_upvr (readonly)
		[3]: Functions_upvr (readonly)
		[4]: any_GetController_result1_upvr_2 (readonly)
	]]
	local module_2 = {}
	local itemId_upvr = arg1.itemId
	local item_upvr_2 = arg1.item
	local getComponent_result1_12 = getComponent("HoverName")
	getComponent_result1_12.Text = item_upvr_2:getName()
	addComponent(module_2, getComponent_result1_12)
	local var29_upvr
	if 14 <= #item_upvr_2:getName() then
		getComponent_result1_12.Size += UDim2.fromScale(0, 0.095)
		local getComponent_result1_10 = getComponent("LineInvisible")
		getComponent_result1_10.Size = UDim2.fromScale(getComponent_result1_10.Size.X.Scale, 0)
		addComponent(module_2, getComponent_result1_10)
	end
	local getComponent_result1_11 = getComponent("Rarity")
	local any_getRarityData_result1_2 = Util_upvr.petUtils.getRarityData(Util_upvr.petUtils.getRarityId(item_upvr_2:getRarity()))
	getComponent_result1_11.UIGradient.Color = any_getRarityData_result1_2.textColor.gradient
	getComponent_result1_11.UIGradient.Rotation = any_getRarityData_result1_2.textColor.gradientRotation
	getComponent_result1_11.UIStroke.Color = any_getRarityData_result1_2.textColor.stroke
	getComponent_result1_11.UIStroke.UIGradient.Enabled = any_getRarityData_result1_2.textColor.strokeGradient
	if any_getRarityData_result1_2.textColor.strokeGradient then
		getComponent_result1_11.UIStroke.UIGradient.Color = any_getRarityData_result1_2.textColor.gradient
		getComponent_result1_11.UIStroke.UIGradient.Rotation = any_getRarityData_result1_2.textColor.gradientRotation
	end
	local any_getTierData_result1 = Util_upvr.petUtils.getTierData(item_upvr_2:getTier())
	getComponent_result1_11.Text = item_upvr_2:getRarity()
	addComponent(module_2, getComponent_result1_11)
	local var34
	if 1 < item_upvr_2:getTier() or item_upvr_2:isShiny() then
		local getComponent_result1 = getComponent("State")
		var34 = any_getTierData_result1.name
		getComponent_result1.Craft.Text = var34
		var29_upvr = item_upvr_2:getTier()
		if 1 >= var29_upvr then
			var34 = false
		else
			var34 = true
		end
		getComponent_result1.Craft.Visible = var34
		var34 = 1
		if var34 < item_upvr_2:getTier() then
			var34 = getComponent_result1.Craft
			var34 = any_getTierData_result1.gradient
			var34.UIGradient.Color = var34
			var34 = getComponent_result1.Craft
			var34 = any_getTierData_result1.stroke
			var34.UIStroke.Color = var34
			if any_getTierData_result1.strokeGradient then
				var29_upvr = getComponent_result1.Craft
				var34 = var29_upvr.UIStroke
				var34 = any_getTierData_result1.gradient
				var34.UIGradient.Color = var34
			end
		end
		var34 = item_upvr_2:isShiny()
		getComponent_result1.Shiny.Visible = var34
		var34 = module_2
		var29_upvr = getComponent_result1
		addComponent(var34, var29_upvr)
	end
	var29_upvr = getComponent("Line")
	addComponent(module_2, var29_upvr)
	if item_upvr_2:getDescription() then
		local getComponent_result1_6 = getComponent("Description")
		getComponent_result1_6.Text = item_upvr_2:getDescription():format(Functions_upvr.floatingPoint(item_upvr_2:getSpecialPercentage() * 100))
		var29_upvr = module_2
		addComponent(var29_upvr, getComponent_result1_6)
	end
	local getComponent_result1_3 = getComponent("Multiplier")
	local function INLINED_2() -- Internal function, doesn't exist in bytecode
		local tbl_2 = {ignoreServer = true}
		var29_upvr = `x{Functions_upvr.suffixes(item_upvr_2:getMultiplier(any_GetController_result1_upvr:getData(), tbl_2))} Clicks`
		return var29_upvr
	end
	if arg1.hideStats or not INLINED_2() then
		var29_upvr = "x???"
	end
	getComponent_result1_3.Label.Text = var29_upvr
	var29_upvr = module_2
	addComponent(var29_upvr, getComponent_result1_3)
	if item_upvr_2:isUntradeable() or item_upvr_2:getSerial() or any_getRarityData_result1_2.exists then
		addComponent(module_2, getComponent("Line"))
	end
	if item_upvr_2:getSerial() then
		var29_upvr = getComponent("Serial")
		var29_upvr.Text = `#{item_upvr_2:getSerialNumber()} - @{item_upvr_2:getSerialUsername()}`
		addComponent(module_2, var29_upvr)
	end
	var29_upvr = arg1.ignoreExist
	if not var29_upvr then
		var29_upvr = item_upvr_2:isTemporary()
		if not var29_upvr then
			var29_upvr = any_getRarityData_result1_2.exists
			if var29_upvr then
				var29_upvr = getComponent("Exists")
				local any_getExist_result1_2 = any_GetController_result1_upvr_2:getExist(itemId_upvr, item_upvr_2)
				if not any_getExist_result1_2 then
					task.delay(0.3, function() -- Line 114
						--[[ Upvalues[4]:
							[1]: var29_upvr (readonly)
							[2]: any_GetController_result1_upvr_2 (copied, readonly)
							[3]: itemId_upvr (readonly)
							[4]: item_upvr_2 (readonly)
						]]
						if not var29_upvr.Parent then
						else
							var29_upvr.Text = `{any_GetController_result1_upvr_2:getExist(itemId_upvr, item_upvr_2) or "???"} Exists`
						end
					end)
				end
				var29_upvr.Text = `{any_getExist_result1_2 or "???"} Exists`
				addComponent(module_2, var29_upvr)
			end
		end
	end
	var29_upvr = item_upvr_2:isUntradeable()
	if var29_upvr then
		var29_upvr = getComponent("Untradeable")
		addComponent(module_2, var29_upvr)
	end
	var29_upvr = item_upvr_2:isTemporary()
	if var29_upvr then
		var29_upvr = getComponent("Temporary")
		addComponent(module_2, var29_upvr)
	end
	var29_upvr = arg1.clickToReplay
	if var29_upvr then
		var29_upvr = getComponent("GenericText")
		var29_upvr.Text = "Click To Replay!"
		var29_upvr.Size = UDim2.fromScale(var29_upvr.Size.X.Scale, 0.07)
		addComponent(module_2, var29_upvr)
	end
	return module_2
end