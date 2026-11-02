-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:20:52
-- Luau version 6, Types version 3
-- Time taken: 0.007473 seconds

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
local Util_upvr = require(ReplicatedStorage.Shared.Util)
local Functions_upvr = require(ReplicatedStorage.Shared.Functions)
local any_GetController_result1_upvr = require(game:GetService("ReplicatedStorage").Packages.Knit).GetController("AuraController")
local PreferredInput_upvr = require(ReplicatedStorage.Packages.Input).PreferredInput
return function(arg1) -- Line 28
	--[[ Upvalues[4]:
		[1]: Util_upvr (readonly)
		[2]: Functions_upvr (readonly)
		[3]: any_GetController_result1_upvr (readonly)
		[4]: PreferredInput_upvr (readonly)
	]]
	-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
	local module_2 = {}
	local item = arg1.item
	local getComponent_result1_14 = getComponent("HoverName")
	getComponent_result1_14.Text = item:getRealName()
	addComponent(module_2, getComponent_result1_14)
	local var26_upvr
	if arg1.amountInName then
		local mult
		if item:getShowRealNumber() then
			mult = 1
		else
			mult = 100
		end
		if not item:getHidePercentage() then
			getComponent_result1_14.Text = `{`+{item:getAmount() * mult}{'%'}`} {getComponent_result1_14.Text}`
		end
	end
	if 14 <= #item:getRealName() then
		getComponent_result1_14.Size += UDim2.fromScale(0, 0.095)
		local getComponent_result1_4 = getComponent("LineInvisible")
		getComponent_result1_4.Size = UDim2.fromScale(getComponent_result1_4.Size.X.Scale, 0)
		addComponent(module_2, getComponent_result1_4)
	end
	local getComponent_result1_13 = getComponent("Rarity")
	local any_getRarityData_result1 = Util_upvr.itemUtils.getRarityData(Util_upvr.itemUtils.getRarityId(item:getRarity()))
	getComponent_result1_13.UIGradient.Color = any_getRarityData_result1.gradient
	getComponent_result1_13.UIStroke.Color = any_getRarityData_result1.stroke
	if any_getRarityData_result1.strokeGradient then
		getComponent_result1_13.UIStroke.UIGradient.Color = any_getRarityData_result1.gradient
	end
	getComponent_result1_13.Text = item:getRarity()
	if item:getClass() == "upgrade" or item:getClass() == "gamepass" then
		getComponent_result1_13.Text = Functions_upvr.toPascal(item:getClass())
	end
	addComponent(module_2, getComponent_result1_13)
	addComponent(module_2, getComponent("Line"))
	if item:getDescription() then
		local getComponent_result1_11 = getComponent("Description")
		getComponent_result1_11.Text = item:getDescription()
		addComponent(module_2, getComponent_result1_11)
	end
	addComponent(module_2, getComponent("LineInvisible"))
	if item.getSerial and item:getSerial() then
		var26_upvr = getComponent("Line")
		addComponent(module_2, var26_upvr)
		local getComponent_result1_12 = getComponent("Serial")
		var26_upvr = `#{item:getSerialNumber()} - @{item:getSerialUsername()}`
		getComponent_result1_12.Text = var26_upvr
		var26_upvr = module_2
		addComponent(var26_upvr, getComponent_result1_12)
	end
	if item:getClass() == "aura" then
		local tbl_2 = {}
		var26_upvr = 7
		tbl_2[1] = 6
		tbl_2[2] = var26_upvr
		tbl_2[3] = 8
		tbl_2[4] = 9
		tbl_2[5] = 10
		tbl_2[6] = 11
		var26_upvr = tbl_2
		if table.find(var26_upvr, Util_upvr.itemUtils.getRarityId(item:getRarity())) then
			var26_upvr = "Exists"
			local getComponent_result1_2_upvr = getComponent(var26_upvr)
			var26_upvr = Util_upvr.auraUtils.getAuraDescriptor(item)
			local any_getExist_result1 = any_GetController_result1_upvr:getExist(var26_upvr)
			if not any_getExist_result1 then
				task.delay(0.25, function() -- Line 98
					--[[ Upvalues[3]:
						[1]: getComponent_result1_2_upvr (readonly)
						[2]: any_GetController_result1_upvr (copied, readonly)
						[3]: var26_upvr (readonly)
					]]
					if not getComponent_result1_2_upvr.Parent then
					else
						getComponent_result1_2_upvr.Text = `{any_GetController_result1_upvr:getExist(var26_upvr) or "???"} Exists`
					end
				end)
			end
			getComponent_result1_2_upvr.Text = `{any_getExist_result1 or "???"} Exists`
			addComponent(module_2, getComponent_result1_2_upvr)
		end
	end
	if not item:isUnusable() and not arg1.unusable then
		local getComponent_result1_8 = getComponent("GenericText")
		getComponent_result1_2_upvr = PreferredInput_upvr
		if getComponent_result1_2_upvr.Current == "Touch" then
			getComponent_result1_2_upvr = "Tap to Use!"
		else
			getComponent_result1_2_upvr = "Click to Use!"
		end
		getComponent_result1_8.Text = getComponent_result1_2_upvr
		getComponent_result1_2_upvr = UDim2.fromScale
		var26_upvr = getComponent_result1_8.Size.X.Scale
		getComponent_result1_2_upvr = getComponent_result1_2_upvr(var26_upvr, 0.075)
		getComponent_result1_8.Size = getComponent_result1_2_upvr
		getComponent_result1_2_upvr = addComponent
		var26_upvr = module_2
		getComponent_result1_2_upvr(var26_upvr, getComponent_result1_8)
	end
	if item:isUntradeable() then
		getComponent_result1_2_upvr = module_2
		var26_upvr = getComponent("Untradeable")
		addComponent(getComponent_result1_2_upvr, var26_upvr)
	end
	if item:isTemporary() or arg1.isTemporary then
		getComponent_result1_2_upvr = module_2
		var26_upvr = getComponent("Temporary")
		addComponent(getComponent_result1_2_upvr, var26_upvr)
	end
	return module_2
end