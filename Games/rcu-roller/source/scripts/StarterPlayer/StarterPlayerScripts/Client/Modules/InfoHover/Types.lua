-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:20:50
-- Luau version 6, Types version 3
-- Time taken: 0.006497 seconds

local Knit = require(game:GetService("ReplicatedStorage").Packages.Knit)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local module = {
	pet = require(script.Pet);
	item = require(script.Item);
	boost = require(script.Boost);
	dailyBoost = require(script.DailyBoost);
	friendBoost = require(script.FriendBoost);
	globalLuckEvent = require(script.GlobalLuckEvent);
	lbAura = require(script.LbAura);
	lbWeekly = require(script.LbWeekly);
	clanBoost = require(script.ClanBoost);
	clanMorePasses = require(script.ClanMorePasses);
	hatchingPoints = require(script.HatchingPoints);
	event = require(script.Event);
	premiumBoost = require(script.PremiumBoost);
}
local Assets_upvr = ReplicatedStorage.Assets
function getComponent(arg1) -- Line 47
	--[[ Upvalues[1]:
		[1]: Assets_upvr (readonly)
	]]
	return Assets_upvr.UI.InfoHover.Components[arg1]:Clone()
end
local Util_upvr = require(ReplicatedStorage.Shared.Util)
local Items_upvr = require(ReplicatedStorage.Shared.Items)
local any_GetController_result1_upvr = Knit.GetController("UIController")
local Variables_upvr = require(ReplicatedStorage.Shared.Variables)
function module.exclusiveEgg(arg1) -- Line 51
	--[[ Upvalues[4]:
		[1]: Util_upvr (readonly)
		[2]: Items_upvr (readonly)
		[3]: any_GetController_result1_upvr (readonly)
		[4]: Variables_upvr (readonly)
	]]
	-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
	local module_upvr = {}
	local item = arg1.item
	local function addComponent(arg1_2) -- Line 57
		--[[ Upvalues[1]:
			[1]: module_upvr (readonly)
		]]
		module_upvr[#module_upvr + 1] = arg1_2
	end
	local getComponent_result1_17 = getComponent("HoverName")
	getComponent_result1_17.Text = item:getRealName()
	module_upvr[#module_upvr + 1] = getComponent_result1_17
	if 14 <= #item:getName() then
		getComponent_result1_17.Size += UDim2.fromScale(0, 0.095)
		local getComponent_result1_13 = getComponent("LineInvisible")
		getComponent_result1_13.Size = UDim2.fromScale(getComponent_result1_13.Size.X.Scale, 0)
		module_upvr[#module_upvr + 1] = getComponent_result1_13
	end
	local getComponent_result1_6 = getComponent("Rarity")
	local any_getRarityData_result1 = Util_upvr.petUtils.getRarityData(Util_upvr.itemUtils.getRarityId(item:getRarity()))
	getComponent_result1_6.UIGradient.Color = any_getRarityData_result1.gradient
	getComponent_result1_6.UIStroke.Color = any_getRarityData_result1.stroke
	if any_getRarityData_result1.strokeGradient then
		getComponent_result1_6.UIStroke.UIGradient.Color = any_getRarityData_result1.gradient
	end
	getComponent_result1_6.Text = item:getRarity()
	module_upvr[#module_upvr + 1] = getComponent_result1_6
	module_upvr[#module_upvr + 1] = getComponent("Line")
	local getComponent_result1_7 = getComponent("PetsList")
	local tbl = {}
	for i, v in item:getPets() do
		tbl[#tbl + 1] = {
			pet = i;
			chance = v;
		}
		end
	local var46 = tbl
	table.sort(var46, function(arg1_3, arg2) -- Line 97
		local var48
		if arg2.chance >= arg1_3.chance then
			var48 = false
		else
			var48 = true
		end
		return var48
	end)
	for i_2, v_2 in var46 do
		local any_pet_result1 = any_GetController_result1_upvr.uis.pet(Items_upvr.pet(v_2.pet))
		local Main = any_pet_result1.Main
		Main.Amount.Visible = false
		Main.Multiplier.Text = `{v_2.chance}%`
		any_pet_result1.LayoutOrder = -any_pet_result1.LayoutOrder
		any_pet_result1.Visible = true
		any_pet_result1.Size = UDim2.fromScale(1, 1)
		for _, v_3 in any_pet_result1:GetDescendants() do
			if v_3:IsA("GuiObject") then
				v_3.ZIndex += 1000
			end
		end
		any_pet_result1.Parent = getComponent_result1_7[`Row{math.floor(i_2 / 3.01) + 1}`]
	end
	module_upvr[#module_upvr + 1] = getComponent_result1_7
	module_upvr[#module_upvr + 1] = getComponent("Line")
	if Variables_upvr.currentExclusiveEgg.name ~= item:getName() then
		local getComponent_result1_22 = getComponent("GenericText")
		getComponent_result1_22.Text = "Limited"
		getComponent_result1_22.TextColor3 = Color3.fromRGB(230, 38, 83)
		getComponent_result1_22.Size = UDim2.fromScale(0.823, 0.073)
		module_upvr[#module_upvr + 1] = getComponent_result1_22
	end
	return module_upvr
end
local any_GetController_result1_upvr_2 = Knit.GetController("TradeController")
local LocalPlayer_upvr = game:GetService("Players").LocalPlayer
local Functions_upvr = require(ReplicatedStorage.Shared.Functions)
function module.tradeList(arg1) -- Line 137
	--[[ Upvalues[3]:
		[1]: any_GetController_result1_upvr_2 (readonly)
		[2]: LocalPlayer_upvr (readonly)
		[3]: Functions_upvr (readonly)
	]]
	local module_3_upvr = {}
	local any_getPlayerInfo_result1_upvr = any_GetController_result1_upvr_2:getPlayerInfo(arg1.username)
	if not any_getPlayerInfo_result1_upvr then
		return {}
	end
	local function addComponent(arg1_4) -- Line 145
		--[[ Upvalues[1]:
			[1]: module_3_upvr (readonly)
		]]
		module_3_upvr[#module_3_upvr + 1] = arg1_4
	end
	local getComponent_result1_2 = getComponent("PlayerName")
	getComponent_result1_2.PlayerName.Text = `@{any_getPlayerInfo_result1_upvr.username}`
	getComponent_result1_2.DisplayName.Text = `{any_getPlayerInfo_result1_upvr.displayName}`
	module_3_upvr[#module_3_upvr + 1] = getComponent_result1_2
	local getComponent_result1_21_upvr = getComponent("FriendStatus")
	getComponent_result1_21_upvr.Text = "???"
	getComponent_result1_21_upvr.TextColor3 = Color3.fromRGB(0, 32, 54)
	module_3_upvr[#module_3_upvr + 1] = getComponent_result1_21_upvr
	task.spawn(function() -- Line 161
		--[[ Upvalues[4]:
			[1]: LocalPlayer_upvr (copied, readonly)
			[2]: any_getPlayerInfo_result1_upvr (readonly)
			[3]: getComponent_result1_21_upvr (readonly)
			[4]: Functions_upvr (copied, readonly)
		]]
		local pcall_result1, pcall_result2 = pcall(function() -- Line 162
			--[[ Upvalues[2]:
				[1]: LocalPlayer_upvr (copied, readonly)
				[2]: any_getPlayerInfo_result1_upvr (copied, readonly)
			]]
			return LocalPlayer_upvr:IsFriendsWith(any_getPlayerInfo_result1_upvr.userId)
		end)
		if pcall_result1 then
			if pcall_result2 then
				getComponent_result1_21_upvr.Text = "Friends!"
				getComponent_result1_21_upvr.TextColor3 = Color3.fromRGB(51, 218, 39)
			else
				getComponent_result1_21_upvr.Text = "Not Friends"
				getComponent_result1_21_upvr.TextColor3 = Color3.fromRGB(230, 38, 83)
			end
		end
		if not pcall_result1 then
			Functions_upvr.print(`Kunde inte f\xE5 om player \xE4r v\xE4n med {any_getPlayerInfo_result1_upvr.userId}: ({pcall_result2})`, warn)
		end
	end)
	if any_getPlayerInfo_result1_upvr.clanTag then
		module_3_upvr[#module_3_upvr + 1] = getComponent("LineInvisible")
		local getComponent_result1_18 = getComponent("ClanInfo")
		getComponent_result1_18.ClanTag.Text = `[{any_getPlayerInfo_result1_upvr.clanTag}]`
		module_3_upvr[#module_3_upvr + 1] = getComponent_result1_18
	end
	module_3_upvr[#module_3_upvr + 1] = getComponent("Line")
	if any_getPlayerInfo_result1_upvr.disabled then
		local getComponent_result1_4 = getComponent("GenericText")
		getComponent_result1_4.Text = "Player's stats are hidden!"
		getComponent_result1_4.Size = UDim2.fromScale(0.85, 0.15)
		getComponent_result1_4.TextColor3 = Color3.fromRGB(230, 38, 83)
		module_3_upvr[#module_3_upvr + 1] = getComponent_result1_4
		return module_3_upvr
	end
	if any_getPlayerInfo_result1_upvr.tradeTokens then
		local getComponent_result1_20 = getComponent("SmallText")
		getComponent_result1_20.Text = "Trade Tokens"
		module_3_upvr[#module_3_upvr + 1] = getComponent_result1_20
		local getComponent_result1_5 = getComponent("TradeTokens")
		getComponent_result1_5.Amount.Text = Functions_upvr.comma(any_getPlayerInfo_result1_upvr.tradeTokens)
		module_3_upvr[#module_3_upvr + 1] = getComponent_result1_5
	end
	module_3_upvr[#module_3_upvr + 1] = getComponent("Line")
	if any_getPlayerInfo_result1_upvr.rarities then
		for i_4, v_4 in any_getPlayerInfo_result1_upvr.rarities do
			if v_4 > 0 then
				local getComponent_result1_19 = getComponent("TradeInfoAmount")
				getComponent_result1_19.Label.Text = `{Functions_upvr.toPascal(i_4)}:`
				getComponent_result1_19.Amount.Text = Functions_upvr.comma(v_4)
				getComponent_result1_19.Amount.TextColor3 = ({
					mythicals = Color3.fromRGB(255, 171, 35);
					eternals = Color3.fromRGB(107, 228, 255);
					secrets = Color3.fromRGB(255, 62, 107);
					supremes = Color3.fromRGB(255, 221, 51);
					ultimates = Color3.fromRGB(186, 66, 255);
				})[i_4]
				module_3_upvr[#module_3_upvr + 1] = getComponent_result1_19
			end
		end
	end
	if any_getPlayerInfo_result1_upvr.mounts and 0 < any_getPlayerInfo_result1_upvr.mounts then
		local getComponent_result1_23 = getComponent("TradeInfoAmount")
		getComponent_result1_23.Label.Text = "Mounts:"
		i_4 = Functions_upvr
		i_4 = any_getPlayerInfo_result1_upvr.mounts
		getComponent_result1_23.Amount.Text = i_4.comma(i_4)
		i_4 = 98
		v_4 = 255
		getComponent_result1_23.Amount.TextColor3 = Color3.fromRGB(i_4, v_4, 116)
		module_3_upvr[#module_3_upvr + 1] = getComponent_result1_23
	end
	if any_getPlayerInfo_result1_upvr.exclusiveEggs and 0 < any_getPlayerInfo_result1_upvr.exclusiveEggs then
		local getComponent_result1_3 = getComponent("TradeInfoAmount")
		getComponent_result1_3.Label.Text = "Exclusive Eggs:"
		i_4 = Functions_upvr
		i_4 = any_getPlayerInfo_result1_upvr.exclusiveEggs
		getComponent_result1_3.Amount.Text = i_4.comma(i_4)
		i_4 = 255
		v_4 = 130
		getComponent_result1_3.Amount.TextColor3 = Color3.fromRGB(i_4, v_4, 238)
		module_3_upvr[#module_3_upvr + 1] = getComponent_result1_3
	end
	return module_3_upvr
end
local Activities_upvr = require(ReplicatedStorage.Shared.List.Prestige.Activities)
function module.prestige(arg1) -- Line 254
	--[[ Upvalues[1]:
		[1]: Activities_upvr (readonly)
	]]
	local module_2_upvr = {}
	local function _(arg1_5) -- Line 257, Named "addComponent"
		--[[ Upvalues[1]:
			[1]: module_2_upvr (readonly)
		]]
		module_2_upvr[#module_2_upvr + 1] = arg1_5
	end
	local getComponent_result1_16 = getComponent("GenericText")
	getComponent_result1_16.Text = `Open Egg - {Activities_upvr.openEgg}XP`
	getComponent_result1_16.Size = UDim2.fromScale(0.871, 0.06)
	local getComponent_result1_14 = getComponent("GenericText")
	getComponent_result1_14.Text = `Use Aura Roll - {Activities_upvr.useAuraRoll}XP`
	getComponent_result1_14.Size = UDim2.fromScale(0.871, 0.06)
	local getComponent_result1_15 = getComponent("GenericText")
	getComponent_result1_15.Text = `Play for 1 Minute - {Activities_upvr.playMinute}XP`
	getComponent_result1_15.Size = UDim2.fromScale(0.871, 0.06)
	local getComponent_result1_12 = getComponent("GenericText")
	getComponent_result1_12.Text = `Craft Golden Pet - {Activities_upvr.craftGoldenPet}XP`
	getComponent_result1_12.Size = UDim2.fromScale(0.871, 0.06)
	local getComponent_result1_11 = getComponent("GenericText")
	getComponent_result1_11.Text = `Craft Toxic Pet - {Activities_upvr.craftToxicPet}XP`
	getComponent_result1_11.Size = UDim2.fromScale(0.871, 0.06)
	local getComponent_result1_10 = getComponent("GenericText")
	getComponent_result1_10.Text = `Spend 1 Robux - {Activities_upvr.spendOneRobux}XP`
	getComponent_result1_10.Size = UDim2.fromScale(0.871, 0.06)
	local getComponent_result1 = getComponent("GenericText")
	getComponent_result1.Text = `Eat 1 Fruit - {Activities_upvr.eatOneFruit}XP`
	getComponent_result1.Size = UDim2.fromScale(0.871, 0.06)
	local getComponent_result1_9 = getComponent("GenericText")
	getComponent_result1_9.Text = `Use 1 Potion - {Activities_upvr.useOnePotion}XP`
	getComponent_result1_9.Size = UDim2.fromScale(0.871, 0.06)
	local getComponent_result1_8 = getComponent("GenericText")
	getComponent_result1_8.Text = `Destroy 1 Tree - {Activities_upvr.destroyOneTree}XP`
	getComponent_result1_8.Size = UDim2.fromScale(0.871, 0.06)
	module_2_upvr[#module_2_upvr + 1] = getComponent_result1_16
	module_2_upvr[#module_2_upvr + 1] = getComponent_result1_14
	module_2_upvr[#module_2_upvr + 1] = getComponent_result1_15
	module_2_upvr[#module_2_upvr + 1] = getComponent_result1_12
	module_2_upvr[#module_2_upvr + 1] = getComponent_result1_11
	module_2_upvr[#module_2_upvr + 1] = getComponent_result1_10
	module_2_upvr[#module_2_upvr + 1] = getComponent_result1
	module_2_upvr[#module_2_upvr + 1] = getComponent_result1_9
	module_2_upvr[#module_2_upvr + 1] = getComponent_result1_8
	return module_2_upvr
end
return module