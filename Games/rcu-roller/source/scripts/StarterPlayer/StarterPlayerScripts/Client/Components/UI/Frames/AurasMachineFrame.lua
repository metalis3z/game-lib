-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:21:56
-- Luau version 6, Types version 3
-- Time taken: 0.004478 seconds

local Knit_upvr = require(game:GetService("ReplicatedStorage").Packages.Knit)
local any_new_result1 = require(Knit_upvr.Util.Component).new({
	Tag = "AurasMachineFrame";
	_diceId = nil;
})
local var4_upvw
local var5_upvw
local var6_upvw
local var7_upvw
local var8_upvw
local var9_upvw
local var10_upvw
local var11_upvw
local var12_upvw
local Main_3_upvr = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("MainUI"):WaitForChild("Menus"):WaitForChild("AurasMachineFrame"):WaitForChild("Main")
local Holder_upvr = Main_3_upvr:WaitForChild("Holder")
local Canvas = Main_3_upvr:WaitForChild("Canvas")
local Side_upvr = Canvas:WaitForChild("Side")
local Main_upvr = Side_upvr:WaitForChild("DicePlaceholder"):WaitForChild("Main")
local Title_upvr = Side_upvr:WaitForChild("Title")
local Select_upvr = Canvas:WaitForChild("Select")
function any_new_result1.updateSide(arg1, arg2) -- Line 51
	--[[ Upvalues[8]:
		[1]: var4_upvw (read and write)
		[2]: var11_upvw (read and write)
		[3]: var9_upvw (read and write)
		[4]: Main_upvr (readonly)
		[5]: Title_upvr (readonly)
		[6]: var10_upvw (read and write)
		[7]: Side_upvr (readonly)
		[8]: Select_upvr (readonly)
	]]
	-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
	local var20 = var11_upvw[arg2]
	Main_upvr.DiceIcon.Image = var20.icon
	local var22
	local function INLINED() -- Internal function, doesn't exist in bytecode
		var22 = var9_upvw.itemUtils.getItemFromName(var4_upvw.data, arg2):getAmount()
		return var22
	end
	if not var9_upvw.itemUtils.getItemFromName(var4_upvw.data, arg2) or not INLINED() then
		var22 = 0
	end
	Main_upvr.Amount.Text = `x{var22}`
	Title_upvr.DiceName.Text = var20.name
	-- Fixed: empty if/else was decompiler artifact; DiceLuck should only show when luck > 0
	Title_upvr.DiceLuck.Visible = var20.luck > 0
	local luckDisplay = var10_upvw.comma(var20.luck * 100)
	Title_upvr.DiceLuck.Text = `+{luckDisplay}% Luck`
	Side_upvr.Visible = true
	Select_upvr.Visible = false
	arg1._diceId = arg2
end
function any_new_result1.setupFrames(arg1) -- Line 72
	--[[ Upvalues[4]:
		[1]: var11_upvw (read and write)
		[2]: Holder_upvr (readonly)
		[3]: var10_upvw (read and write)
		[4]: var8_upvw (read and write)
	]]
	for i_upvr, v in var11_upvw do
		local Main_2 = Holder_upvr[var10_upvw.toPascal(i_upvr)].Main
		Main_2.DiceIcon.Image = v.icon
		var8_upvw.new(Main_2):buttonUp(function() -- Line 80
			--[[ Upvalues[2]:
				[1]: arg1 (readonly)
				[2]: i_upvr (readonly)
			]]
			arg1:updateSide(i_upvr)
		end)
	end
end
local LevelProgress_upvr = Main_3_upvr:WaitForChild("LevelProgress")
function any_new_result1.update(arg1) -- Line 86
	--[[ Upvalues[8]:
		[1]: var4_upvw (read and write)
		[2]: var9_upvw (read and write)
		[3]: var12_upvw (read and write)
		[4]: LevelProgress_upvr (readonly)
		[5]: var10_upvw (read and write)
		[6]: Main_3_upvr (readonly)
		[7]: var11_upvw (read and write)
		[8]: Holder_upvr (readonly)
	]]
	-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
	local data = var4_upvw.data
	local any_getLevel_result1 = var9_upvw.auraUtils.getLevel(data)
	local any_getLevelProgress_result1 = var9_upvw.auraUtils.getLevelProgress(data)
	local var39 = var12_upvw[any_getLevel_result1 + 1]
	local var40
	local function INLINED_2() -- Internal function, doesn't exist in bytecode
		var40 = var39.required
		return var40
	end
	if not var39 or not INLINED_2() then
		var40 = var12_upvw[any_getLevel_result1].required
	end
	LevelProgress_upvr.Amount.Text = `{var10_upvw.suffixes(data.auraXp)}/{var10_upvw.suffixes(var40)} XP`
	LevelProgress_upvr.Bar.Size = UDim2.fromScale(any_getLevelProgress_result1, 1)
	-- Fixed: empty if/else artifact; Bar only visible when progress > 0
	LevelProgress_upvr.Bar.Visible = any_getLevelProgress_result1 > 0
	Main_3_upvr.Level.Text = `Level {any_getLevel_result1}`
	for i_2, _ in var11_upvw do
		local Main = Holder_upvr[var10_upvw.toPascal(i_2)].Main
		local any_getItemFromName_result1 = var9_upvw.itemUtils.getItemFromName(data, i_2)
		local itemAmount
		-- Fixed: INLINED_3 pattern — get amount or default 0
		if not any_getItemFromName_result1 then
			itemAmount = 0
		else
			local amt = any_getItemFromName_result1:getAmount()
			itemAmount = amt or 0
		end
		Main.Amount.Text = `x{itemAmount}`
		Main.Amount.Visible = any_getItemFromName_result1 ~= nil
		-- Fixed: KONSTANTERROR var43 reuse — use separate variable for percentage
		local chancePercent = var12_upvw[any_getLevel_result1].chances[i_2]
		Main.Percentage.Text = `{chancePercent}%`
	end
end
function any_new_result1.hasAuraDice(arg1) -- Line 115
	--[[ Upvalues[3]:
		[1]: var4_upvw (read and write)
		[2]: var9_upvw (read and write)
		[3]: var5_upvw (read and write)
	]]
	local any_getItemFromName_result1_2, any_getItemFromName_result2 = var9_upvw.itemUtils.getItemFromName(var4_upvw:getData(), arg1._diceId)
	if not any_getItemFromName_result1_2 then
		var5_upvw:createMessagePopup({
			message = "You do not have a \ndice to roll!";
			reOpen = "AurasMachineFrame";
		})
		return
	end
	return true
end
function any_new_result1.buttons(arg1) -- Line 131
	--[[ Upvalues[3]:
		[1]: var8_upvw (read and write)
		[2]: Side_upvr (readonly)
		[3]: var7_upvw (read and write)
	]]
	var8_upvw.new(Side_upvr.Roll1):buttonUp(function() -- Line 133
		--[[ Upvalues[2]:
			[1]: arg1 (readonly)
			[2]: var7_upvw (copied, read and write)
		]]
		if not arg1:hasAuraDice() then
		else
			var7_upvw:roll(arg1._diceId)
		end
	end)
	var8_upvw.new(Side_upvr.RollAll):buttonUp(function() -- Line 142
		--[[ Upvalues[2]:
			[1]: arg1 (readonly)
			[2]: var7_upvw (copied, read and write)
		]]
		if not arg1:hasAuraDice() then
		else
			var7_upvw:setIsAutoRolling(true)
			var7_upvw:roll(arg1._diceId)
		end
	end)
end
function any_new_result1.opened(arg1) -- Line 152
	arg1:update()
	if arg1._diceId then
		arg1:updateSide(arg1._diceId)
	end
end
function any_new_result1.Start(arg1) -- Line 160
	--[[ Upvalues[2]:
		[1]: var5_upvw (read and write)
		[2]: var6_upvw (read and write)
	]]
	arg1:setupFrames()
	arg1:buttons()
	arg1:opened()
	var5_upvw:listenToOpen("AurasMachineFrame"):Connect(function() -- Line 165
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:opened()
	end)
	var6_upvw:preloadSounds({"Aura Ambience", "Aura Normal", "Aura Riser", "Aura Roll"})
end
local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
function any_new_result1.Construct(arg1) -- Line 177
	--[[ Upvalues[11]:
		[1]: var4_upvw (read and write)
		[2]: Knit_upvr (readonly)
		[3]: var5_upvw (read and write)
		[4]: var6_upvw (read and write)
		[5]: var7_upvw (read and write)
		[6]: var8_upvw (read and write)
		[7]: var9_upvw (read and write)
		[8]: ReplicatedStorage_upvr (readonly)
		[9]: var10_upvw (read and write)
		[10]: var11_upvw (read and write)
		[11]: var12_upvw (read and write)
	]]
	var4_upvw = Knit_upvr.GetController("DataController")
	var5_upvw = Knit_upvr.GetController("UIController")
	var6_upvw = Knit_upvr.GetController("SoundController")
	var7_upvw = Knit_upvr.GetController("AuraController")
	var8_upvw = require(Knit_upvr.Modules.Button)
	var9_upvw = require(ReplicatedStorage_upvr.Shared.Util)
	var10_upvw = require(ReplicatedStorage_upvr.Shared.Functions)
	var11_upvw = require(ReplicatedStorage_upvr.Shared.List.Items.AuraDices)
	var12_upvw = require(ReplicatedStorage_upvr.Shared.List.AuraLevels)
end
return any_new_result1