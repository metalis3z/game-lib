-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:22:23
-- Luau version 6, Types version 3
-- Time taken: 0.002981 seconds

local Knit_upvr = require(game:GetService("ReplicatedStorage").Packages.Knit)
local any_new_result1 = require(Knit_upvr.Util.Component).new({
	Tag = "GiftingFrame";
	_userId = 0;
})
local var4_upvw
local var5_upvw
local var6_upvw
local var7_upvw
local Players_upvr = game:GetService("Players")
local var9_upvw
local var10_upvw
local LocalPlayer_upvr = Players_upvr.LocalPlayer
local GiftingFrame_upvr = LocalPlayer_upvr:WaitForChild("PlayerGui"):WaitForChild("MainUI"):WaitForChild("Menus"):WaitForChild("GiftingFrame")
local TextBox_upvr = GiftingFrame_upvr:WaitForChild("SearchBar"):WaitForChild("TextBox")
function any_new_result1.setToDefault(arg1) -- Line 42
	--[[ Upvalues[3]:
		[1]: GiftingFrame_upvr (readonly)
		[2]: var10_upvw (read and write)
		[3]: TextBox_upvr (readonly)
	]]
	task.defer(function() -- Line 43
		--[[ Upvalues[2]:
			[1]: GiftingFrame_upvr (copied, readonly)
			[2]: var10_upvw (copied, read and write)
		]]
		GiftingFrame_upvr.PlayerIcon.Icon.Image = var10_upvw.getUserHeadshot(-1)
	end)
	GiftingFrame_upvr.IsFriend.Visible = false
	TextBox_upvr.Text = ""
	arg1._userId = nil
end
function any_new_result1.input(arg1) -- Line 52
	--[[ Upvalues[5]:
		[1]: TextBox_upvr (readonly)
		[2]: Players_upvr (readonly)
		[3]: var10_upvw (read and write)
		[4]: LocalPlayer_upvr (readonly)
		[5]: GiftingFrame_upvr (readonly)
	]]
	TextBox_upvr.FocusLost:Connect(function() -- Line 53
		--[[ Upvalues[6]:
			[1]: TextBox_upvr (copied, readonly)
			[2]: arg1 (readonly)
			[3]: Players_upvr (copied, readonly)
			[4]: var10_upvw (copied, read and write)
			[5]: LocalPlayer_upvr (copied, readonly)
			[6]: GiftingFrame_upvr (copied, readonly)
		]]
		if TextBox_upvr.Text == "" then
			arg1:setToDefault()
		else
			local pcall_result1, pcall_result2_upvr = pcall(function() -- Line 59
				--[[ Upvalues[2]:
					[1]: Players_upvr (copied, readonly)
					[2]: TextBox_upvr (copied, readonly)
				]]
				return Players_upvr:GetUserIdFromNameAsync(string.gsub(TextBox_upvr.Text, '@', ""))
			end)
			if not pcall_result1 then
				arg1:setToDefault()
				var10_upvw.print(`Kunde inte f\xE5 userId: {pcall_result2_upvr}`, warn)
				return
			end
			local pcall_result1_2, pcall_result2 = pcall(function() -- Line 68
				--[[ Upvalues[2]:
					[1]: LocalPlayer_upvr (copied, readonly)
					[2]: pcall_result2_upvr (readonly)
				]]
				return LocalPlayer_upvr:IsFriendsWith(pcall_result2_upvr)
			end)
			if not pcall_result1_2 then
				var10_upvw.print(`Kunde inte f\xE5 om v\xE4nner: {pcall_result2}`, warn)
			end
			GiftingFrame_upvr.IsFriend.Visible = true
			local isFriendText
			if pcall_result2 then
				isFriendText = "You are friends!"
			else
				isFriendText = "You are not friends!"
			end
			GiftingFrame_upvr.IsFriend.Text = isFriendText
			task.defer(function() -- Line 78
				--[[ Upvalues[3]:
					[1]: GiftingFrame_upvr (copied, readonly)
					[2]: var10_upvw (copied, read and write)
					[3]: pcall_result2_upvr (readonly)
				]]
				GiftingFrame_upvr.PlayerIcon.Icon.Image = var10_upvw.getUserHeadshot(pcall_result2_upvr)
			end)
			arg1._userId = pcall_result2_upvr
		end
	end)
end
function any_new_result1.buttons(arg1) -- Line 86
	--[[ Upvalues[6]:
		[1]: var9_upvw (read and write)
		[2]: GiftingFrame_upvr (readonly)
		[3]: var6_upvw (read and write)
		[4]: var4_upvw (read and write)
		[5]: var7_upvw (read and write)
		[6]: var5_upvw (read and write)
	]]
	var9_upvw.new(GiftingFrame_upvr.Confirm):buttonUp(function() -- Line 88
		--[[ Upvalues[5]:
			[1]: var6_upvw (copied, read and write)
			[2]: var4_upvw (copied, read and write)
			[3]: arg1 (readonly)
			[4]: var7_upvw (copied, read and write)
			[5]: var5_upvw (copied, read and write)
		]]
		if var6_upvw:getFFlag("shopGifting") == false then
			var4_upvw:createMessagePopup({
				fFlagDisabled = true;
				reOpen = "GiftingFrame";
			})
		else
			if not arg1._userId then return end
			local _userId = arg1._userId
			local any_giftToUser_result1, any_giftToUser_result2, any_giftToUser_result3, any_giftToUser_result4 = var7_upvw:giftToUser(_userId)
			if any_giftToUser_result1 == "success" then
				var5_upvw:setGiftingTo(_userId, any_giftToUser_result2, any_giftToUser_result3, any_giftToUser_result4)
				var4_upvw:openFrame("ShopFrame")
				arg1:setToDefault()
				return
			end
			if any_giftToUser_result1 == "error" then
				var4_upvw:createMessagePopup({
					message = "Sorry! You cannot gift to this user";
					reOpen = "GiftingFrame";
				})
			end
		end
	end)
	var9_upvw.new(GiftingFrame_upvr.Cancel):buttonUp(function() -- Line 114
		--[[ Upvalues[1]:
			[1]: var4_upvw (copied, read and write)
		]]
		var4_upvw:openFrame("ShopFrame")
	end)
end
function any_new_result1.opened(arg1) -- Line 119
	arg1:setToDefault()
end
function any_new_result1.Start(arg1) -- Line 123
	--[[ Upvalues[1]:
		[1]: var4_upvw (read and write)
	]]
	arg1:buttons()
	arg1:input()
	arg1:opened()
	var4_upvw:listenToOpen("GiftingFrame"):Connect(function() -- Line 128
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:opened()
	end)
end
local var34_upvw
local var35_upvw
local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local var37_upvw
function any_new_result1.Construct(arg1) -- Line 133
	--[[ Upvalues[11]:
		[1]: var7_upvw (read and write)
		[2]: Knit_upvr (readonly)
		[3]: var34_upvw (read and write)
		[4]: var4_upvw (read and write)
		[5]: var35_upvw (read and write)
		[6]: var5_upvw (read and write)
		[7]: var6_upvw (read and write)
		[8]: var9_upvw (read and write)
		[9]: var10_upvw (read and write)
		[10]: ReplicatedStorage_upvr (readonly)
		[11]: var37_upvw (read and write)
	]]
	var7_upvw = Knit_upvr.GetService("ShopService")
	var34_upvw = Knit_upvr.GetController("DataController")
	var4_upvw = Knit_upvr.GetController("UIController")
	var35_upvw = Knit_upvr.GetController("SoundController")
	var5_upvw = Knit_upvr.GetController("ShopController")
	var6_upvw = Knit_upvr.GetController("FFlagController")
	var9_upvw = require("../../../Modules/Button")
	var10_upvw = require(ReplicatedStorage_upvr.Shared.Functions)
	var37_upvw = require(ReplicatedStorage_upvr.Shared.List.Upgrades)
end
return any_new_result1