-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw


-- Decompiler will be improved VERY SOON!

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)

-- Decompiled on 2025-03-27 06:22:20

-- Luau version 6, Types version 3

-- Time taken: 0.003405 seconds


local Knit_upvr = require(game:GetService("ReplicatedStorage").Packages.Knit)

local any_new_result1 = require(Knit_upvr.Util.Component).new({

	Tag = "ExclusiveEggConfirmFrame";

})

local var4_upvw

local var5_upvw

local var6_upvw

local var7_upvw

local var8_upvw

local var9_upvw

local var10_upvw

local LocalPlayer_upvr = game:GetService("Players").LocalPlayer

local ExclusiveEggConfirmFrame_upvr = LocalPlayer_upvr:WaitForChild("PlayerGui"):WaitForChild("MainUI"):WaitForChild("Menus"):WaitForChild("ExclusiveEggConfirmFrame")

local Buttons_upvr = ExclusiveEggConfirmFrame_upvr:WaitForChild("Buttons")

function any_new_result1.getTrove(arg1) -- Line 41

	--[[ Upvalues[1]:

		[1]: var10_upvw (read and write)

	]]

	local _trove = arg1._trove

	if not _trove then

		_trove = var10_upvw.new()

		arg1._trove = _trove

	end

	return _trove

end

function any_new_result1.hasEnoughOfSame(arg1, arg2) -- Line 51

	--[[ Upvalues[3]:

		[1]: var4_upvw (read and write)

		[2]: ExclusiveEggConfirmFrame_upvr (readonly)

		[3]: var9_upvw (read and write)

	]]

	local any_getData_result1 = var4_upvw:getData()

	if var9_upvw.itemUtils.getAmountOfSameItem(any_getData_result1, var9_upvw.itemUtils.getItemFromId(any_getData_result1, ExclusiveEggConfirmFrame_upvr:GetAttribute("itemId")), any_getData_result1.inventory.exclusiveEgg) < arg2 then

		return false

	end

	return true

end

function any_new_result1.hasReachedLimit(arg1) -- Line 65

	--[[ Upvalues[2]:

		[1]: var6_upvw (read and write)

		[2]: LocalPlayer_upvr (readonly)

	]]

	local var16 = var6_upvw._playersExclusiveEggs[LocalPlayer_upvr]

	if not var16 then return end

	if var16 <= 32 then return end

	return true

end

local Main_upvr = ExclusiveEggConfirmFrame_upvr:WaitForChild("Info"):WaitForChild("Main")

function any_new_result1.update(arg1) -- Line 78

	--[[ Upvalues[6]:

		[1]: var4_upvw (read and write)

		[2]: ExclusiveEggConfirmFrame_upvr (readonly)

		[3]: var9_upvw (read and write)

		[4]: Main_upvr (readonly)

		[5]: Buttons_upvr (readonly)

		[6]: var5_upvw (read and write)

	]]

	local any_getData_result1_2 = var4_upvw:getData()
	if not any_getData_result1_2 then return end

	local itemId = ExclusiveEggConfirmFrame_upvr:GetAttribute("itemId")
	if not itemId then return end

	local any_getItemFromId_result1 = var9_upvw.itemUtils.getItemFromId(any_getData_result1_2, itemId)
	if not any_getItemFromId_result1 then return end

	local any_getAmountOfSameItem_result1 = var9_upvw.itemUtils.getAmountOfSameItem(any_getData_result1_2, any_getItemFromId_result1, any_getData_result1_2.inventory.exclusiveEgg)

	Main_upvr.Amount.Text = `x{any_getAmountOfSameItem_result1}`

	Main_upvr.IconContainer.ImageLabel.Image = any_getItemFromId_result1:getIcon()

	ExclusiveEggConfirmFrame_upvr.HoverName.Text = `Open {any_getItemFromId_result1:getRealName()}`

	-- Open3 button lock state
	local open3Locked = any_getAmountOfSameItem_result1 < 3
	Buttons_upvr.Open3.Locked.Visible = open3Locked

	-- Open8 button lock state
	local open8Locked = any_getAmountOfSameItem_result1 < 8
	Buttons_upvr.Open8.Locked.Visible = open8Locked

	arg1:getTrove():Add(var5_upvw:createInfoHoverOnGuiStateChange(Main_upvr.IconContainer, {
		item = any_getItemFromId_result1;
		unusable = true;
	}))

end

function any_new_result1.buttons(arg1) -- Line 102

	--[[ Upvalues[5]:

		[1]: var8_upvw (read and write)

		[2]: Buttons_upvr (readonly)

		[3]: ExclusiveEggConfirmFrame_upvr (readonly)

		[4]: var7_upvw (read and write)

		[5]: var5_upvw (read and write)

	]]

	var8_upvw.new(Buttons_upvr.Open1):buttonUp(function() -- Line 104

		--[[ Upvalues[4]:

			[1]: arg1 (readonly)

			[2]: ExclusiveEggConfirmFrame_upvr (copied, readonly)

			[3]: var7_upvw (copied, read and write)

			[4]: var5_upvw (copied, read and write)

		]]

		if not arg1:hasEnoughOfSame(1) then

		else

			if arg1:hasReachedLimit() then return end

			var7_upvw.openExclusiveEgg:Fire(ExclusiveEggConfirmFrame_upvr:GetAttribute("itemId"), 1)

			var5_upvw:closeAllFrames()

		end

	end)

	var8_upvw.new(Buttons_upvr.Open3):buttonUp(function() -- Line 119

		--[[ Upvalues[4]:

			[1]: arg1 (readonly)

			[2]: ExclusiveEggConfirmFrame_upvr (copied, readonly)

			[3]: var7_upvw (copied, read and write)

			[4]: var5_upvw (copied, read and write)

		]]

		if not arg1:hasEnoughOfSame(3) then

		else

			if arg1:hasReachedLimit() then return end

			var7_upvw.openExclusiveEgg:Fire(ExclusiveEggConfirmFrame_upvr:GetAttribute("itemId"), 3)

			var5_upvw:closeAllFrames()

		end

	end)

	var8_upvw.new(Buttons_upvr.Open8):buttonUp(function() -- Line 134

		--[[ Upvalues[4]:

			[1]: arg1 (readonly)

			[2]: ExclusiveEggConfirmFrame_upvr (copied, readonly)

			[3]: var7_upvw (copied, read and write)

			[4]: var5_upvw (copied, read and write)

		]]

		if not arg1:hasEnoughOfSame(8) then

		else

			if arg1:hasReachedLimit() then return end

			var7_upvw.openExclusiveEgg:Fire(ExclusiveEggConfirmFrame_upvr:GetAttribute("itemId"), 8)

			var5_upvw:closeAllFrames()

		end

	end)

end

function any_new_result1.opened(arg1) -- Line 149

	arg1:update()

end

function any_new_result1.closed(arg1) -- Line 153

	arg1:getTrove():Clean()

end

function any_new_result1.Start(arg1) -- Line 157

	--[[ Upvalues[1]:

		[1]: var5_upvw (read and write)

	]]

	arg1:buttons()

	-- Don't call opened() here — itemId attribute isn't set yet at Start time
	-- opened() will be called by listenToOpen when the frame actually opens

	var5_upvw:listenToOpen("ExclusiveEggConfirmFrame"):Connect(function()

		arg1:opened()

	end)

	var5_upvw:listenToClose("ExclusiveEggConfirmFrame"):Connect(function()

		arg1:closed()

	end)

end

local var28_upvw

local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")

local var30_upvw

local var31_upvw

function any_new_result1.Construct(arg1) -- Line 169

	--[[ Upvalues[12]:

		[1]: var7_upvw (read and write)

		[2]: Knit_upvr (readonly)

		[3]: var4_upvw (read and write)

		[4]: var5_upvw (read and write)

		[5]: var28_upvw (read and write)

		[6]: var6_upvw (read and write)

		[7]: var8_upvw (read and write)

		[8]: var9_upvw (read and write)

		[9]: ReplicatedStorage_upvr (readonly)

		[10]: var30_upvw (read and write)

		[11]: var31_upvw (read and write)

		[12]: var10_upvw (read and write)

	]]

	var7_upvw = Knit_upvr.GetService("EggService")

	var4_upvw = Knit_upvr.GetController("DataController")

	var5_upvw = Knit_upvr.GetController("UIController")

	var28_upvw = Knit_upvr.GetController("SoundController")

	var6_upvw = Knit_upvr.GetController("ExclusiveEggController")

	var8_upvw = require(Knit_upvr.Modules.Button)

	var9_upvw = require(ReplicatedStorage_upvr.Shared.Util)

	var30_upvw = require(ReplicatedStorage_upvr.Shared.Functions)

	var31_upvw = require(ReplicatedStorage_upvr.Shared.List.Items.ExclusiveEggs)

	var10_upvw = require(ReplicatedStorage_upvr.Packages.Trove)

end

return any_new_result1
