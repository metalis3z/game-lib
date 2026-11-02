-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:22:00
-- Luau version 6, Types version 3
-- Time taken: 0.003681 seconds

local Knit_upvr = require(game:GetService("ReplicatedStorage").Packages.Knit)
local any_new_result1 = require(Knit_upvr.Util.Component).new({
	Tag = "ItemConfirmFrame";
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
local ItemConfirmFrame = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("MainUI"):WaitForChild("Menus"):WaitForChild("ItemConfirmFrame")
function any_new_result1.sendUse(arg1) -- Line 47
	--[[ Upvalues[5]:
		[1]: var4_upvw (read and write)
		[2]: var10_upvw (read and write)
		[3]: var7_upvw (read and write)
		[4]: var5_upvw (read and write)
		[5]: var8_upvw (read and write)
	]]
	local itemId_upvr = arg1.Instance:GetAttribute("itemId")
	local any_getItemFromId_result1_2_upvr = var10_upvw.itemUtils.getItemFromId(var4_upvw:getData(), itemId_upvr)
	if not any_getItemFromId_result1_2_upvr then return end
	if any_getItemFromId_result1_2_upvr:getName() == "globalLuckyEgg" then
		local tbl = {
			message = "A lucky egg will be spawned at your current location for 15 minutes.\nSpawn now?";
			button = "Yes!";
			buttonNegative = "No";
			noSound = true;
			messageSize = UDim2.fromScale(1, 0.73);
		}
		local any_getCurrentMap_result1_upvr = var7_upvw:getCurrentMap(true)
		function tbl.positive() -- Line 66
			--[[ Upvalues[6]:
				[1]: var8_upvw (copied, read and write)
				[2]: itemId_upvr (readonly)
				[3]: any_getCurrentMap_result1_upvr (readonly)
				[4]: arg1 (readonly)
				[5]: any_getItemFromId_result1_2_upvr (readonly)
				[6]: var5_upvw (copied, read and write)
			]]
		local any_useItem_result1_2, any_useItem_result2_2 = var8_upvw:useItem(itemId_upvr, any_getItemFromId_result1_2_upvr:getClass(), {
				mapId = any_getCurrentMap_result1_upvr;
			})
			if any_useItem_result1_2 == "success" then
				arg1:playItemUseSound(any_getItemFromId_result1_2_upvr)
				var5_upvw:closeAllFrames()
			elseif any_useItem_result1_2 == "error" then
				var5_upvw:createMessagePopup({
					message = any_useItem_result2_2;
					reOpen = "InventoryFrame";
				})
			end
		end
		function tbl.negative() -- Line 83
			--[[ Upvalues[1]:
				[1]: var5_upvw (copied, read and write)
			]]
			var5_upvw:openFrame("ItemConfirmFrame")
		end
		var5_upvw:createMessagePopup(tbl)
	else
		var5_upvw:closeAllFrames()
		local any_useItem_result1, any_useItem_result2 = var8_upvw:useItem(itemId_upvr, any_getItemFromId_result1_2_upvr:getClass())
		if any_useItem_result1 == "success" then
			arg1:playItemUseSound(any_getItemFromId_result1_2_upvr)
			return
		end
		if any_useItem_result1 == "error" then
			var5_upvw:createMessagePopup({
				message = any_useItem_result2;
				reOpen = "InventoryFrame";
			})
		end
	end
end
local Buttons_upvr = ItemConfirmFrame:WaitForChild("Buttons")
function any_new_result1.buttons(arg1) -- Line 103
	--[[ Upvalues[3]:
		[1]: var9_upvw (read and write)
		[2]: Buttons_upvr (readonly)
		[3]: var5_upvw (read and write)
	]]
	var9_upvw.new(Buttons_upvr.Use):buttonUp(function() -- Line 105
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:sendUse()
	end)
	var9_upvw.new(Buttons_upvr.Cancel):buttonUp(function() -- Line 110
		--[[ Upvalues[1]:
			[1]: var5_upvw (copied, read and write)
		]]
		var5_upvw:closeAllFrames("InventoryFrame")
		var5_upvw:openFrame("InventoryFrame")
	end)
end
local UserInputService_upvr = game:GetService("UserInputService")
function any_new_result1.input(arg1) -- Line 116
	--[[ Upvalues[2]:
		[1]: UserInputService_upvr (readonly)
		[2]: var5_upvw (read and write)
	]]
	UserInputService_upvr.InputEnded:Connect(function(arg1_2, arg2) -- Line 117
		--[[ Upvalues[3]:
			[1]: UserInputService_upvr (copied, readonly)
			[2]: var5_upvw (copied, read and write)
			[3]: arg1 (readonly)
		]]
		if UserInputService_upvr:GetFocusedTextBox() then
		else
			if arg1_2.KeyCode ~= Enum.KeyCode.ButtonA then return end
			if var5_upvw:getTimeSinceFrameOpened() < 0.5 then return end
			if var5_upvw:getCurrentFrameOpen() ~= "ItemConfirmFrame" then return end
			arg1:sendUse()
		end
	end)
end
local SoundService_upvr = game:GetService("SoundService")
function any_new_result1.playItemUseSound(arg1, arg2) -- Line 138
	--[[ Upvalues[3]:
		[1]: SoundService_upvr (readonly)
		[2]: var11_upvw (read and write)
		[3]: var6_upvw (read and write)
	]]
	local SOME = SoundService_upvr.SFX:FindFirstChild(`Use Item {var11_upvw.toPascal(arg2:getClass())}`)
	local SOME_2 = SoundService_upvr.SFX:FindFirstChild(`Use Item {var11_upvw.toPascal(arg2:getName())}`)
	if SOME_2 then
		var6_upvw:play(SOME_2.Name)
	elseif SOME then
		var6_upvw:play(SOME.Name, {
			volume = 0.4;
		})
	end
end
local Holder_upvr = ItemConfirmFrame:WaitForChild("Holder")
local ConfirmLabel_upvr = ItemConfirmFrame:WaitForChild("ConfirmLabel")
local GradientBG_upvr = ItemConfirmFrame:WaitForChild("Canvas"):WaitForChild("GradientBG")
function any_new_result1.update(arg1) -- Line 151
	local any_getItemFromId_result1 = var10_upvw.itemUtils.getItemFromId(var4_upvw:getData(), arg1.Instance:GetAttribute("itemId"))
	if not any_getItemFromId_result1 then return end
	local var38 = var12_upvw[any_getItemFromId_result1:getClass()]
	Holder_upvr:ClearAllChildren()
	local any_item_result1 = var5_upvw.uis.item(any_getItemFromId_result1)
	any_item_result1.Size = UDim2.fromScale(1, 1)
	any_item_result1.Parent = Holder_upvr
	var5_upvw:createInfoHoverOnGuiStateChange(any_item_result1.Main.Click, {
		item = any_getItemFromId_result1;
		unusable = true;
	})
	ConfirmLabel_upvr.Text = `Are you sure you want to use {any_getItemFromId_result1:getRealName()}?`
	if var38 then
		ConfirmLabel_upvr.UIStroke.Color = var38.stroke
		GradientBG_upvr.UIGradient.Color = var38.gradient
	end
end
function any_new_result1.opened(arg1) -- Line 176
	arg1:update()
end
function any_new_result1.Start(arg1) -- Line 180
	--[[ Upvalues[2]:
		[1]: var5_upvw (read and write)
		[2]: var6_upvw (read and write)
	]]
	arg1:buttons()
	arg1:input()
	arg1:opened()
	var5_upvw:listenToOpen("ItemConfirmFrame"):Connect(function() -- Line 185
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:opened()
	end)
	var6_upvw:preloadSounds({"Use Item GlobalLuck", "Use Item GlobalLuckyEgg"})
end
local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
function any_new_result1.Construct(arg1) -- Line 195
	--[[ Upvalues[11]:
		[1]: var8_upvw (read and write)
		[2]: Knit_upvr (readonly)
		[3]: var4_upvw (read and write)
		[4]: var5_upvw (read and write)
		[5]: var6_upvw (read and write)
		[6]: var7_upvw (read and write)
		[7]: var9_upvw (read and write)
		[8]: var10_upvw (read and write)
		[9]: ReplicatedStorage_upvr (readonly)
		[10]: var11_upvw (read and write)
		[11]: var12_upvw (read and write)
	]]
	var8_upvw = Knit_upvr.GetService("InventoryService")
	var4_upvw = Knit_upvr.GetController("DataController")
	var5_upvw = Knit_upvr.GetController("UIController")
	var6_upvw = Knit_upvr.GetController("SoundController")
	var7_upvw = Knit_upvr.GetController("MapController")
	var9_upvw = require(Knit_upvr.Modules.Button)
	var10_upvw = require(ReplicatedStorage_upvr.Shared.Util)
	var11_upvw = require(ReplicatedStorage_upvr.Shared.Functions)
	var12_upvw = require(script.Categories)
end
return any_new_result1