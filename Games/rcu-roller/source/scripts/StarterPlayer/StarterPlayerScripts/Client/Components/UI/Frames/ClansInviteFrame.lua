-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:22:11
-- Luau version 6, Types version 3
-- Time taken: 0.002710 seconds

local Knit_upvr = require(game:GetService("ReplicatedStorage").Packages.Knit)
local any_new_result1 = require(Knit_upvr.Util.Component).new({
	Tag = "ClansInviteFrame";
})
local var4_upvw
local var5_upvw
local var6_upvw
local var7_upvw
local Players_upvr = game:GetService("Players")
local var9_upvw
local var10_upvw
local var11_upvw
local ClansInviteFrame_upvr = Players_upvr.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("MainUI"):WaitForChild("Menus"):WaitForChild("ClansInviteFrame")
local TextBox_upvr = ClansInviteFrame_upvr:WaitForChild("Input"):WaitForChild("TextBox")
function any_new_result1.getUserIdFromUsername(arg1) -- Line 42
	--[[ Upvalues[2]:
		[1]: TextBox_upvr (readonly)
		[2]: Players_upvr (readonly)
	]]
	local Text_upvr = TextBox_upvr.Text
	local pcall_result1, pcall_result2 = pcall(function() -- Line 45
		--[[ Upvalues[2]:
			[1]: Players_upvr (copied, readonly)
			[2]: Text_upvr (readonly)
		]]
		return Players_upvr:GetUserIdFromNameAsync(Text_upvr)
	end)
	if not pcall_result1 then return end
	return pcall_result2
end
function any_new_result1.getUsernameFromUserId(arg1, arg2) -- Line 56
	--[[ Upvalues[1]:
		[1]: Players_upvr (readonly)
	]]
	local pcall_result1_2, pcall_result2_2 = pcall(function() -- Line 57
		--[[ Upvalues[2]:
			[1]: Players_upvr (copied, readonly)
			[2]: arg2 (readonly)
		]]
		return Players_upvr:GetNameFromUserIdAsync(arg2)
	end)
	if not pcall_result1_2 then return end
	return pcall_result2_2
end
function any_new_result1.focusLost(arg1) -- Line 68
	--[[ Upvalues[3]:
		[1]: TextBox_upvr (readonly)
		[2]: var11_upvw (read and write)
		[3]: ClansInviteFrame_upvr (readonly)
	]]
	TextBox_upvr.FocusLost:Connect(function() -- Line 69
		--[[ Upvalues[3]:
			[1]: arg1 (readonly)
			[2]: var11_upvw (copied, read and write)
			[3]: ClansInviteFrame_upvr (copied, readonly)
		]]
		local any_getUserIdFromUsername_result1_2 = arg1:getUserIdFromUsername()
		local var23
		local function INLINED() -- Internal function, doesn't exist in bytecode
			var23 = var11_upvw.getUserHeadshot(any_getUserIdFromUsername_result1_2)
			return var23
		end
		if not any_getUserIdFromUsername_result1_2 or not INLINED() then
			var23 = "rbxassetid://112951947643512"
		end
		ClansInviteFrame_upvr.PlayerIcon.Icon.Image = var23
	end)
end
local Dark_upvr = ClansInviteFrame_upvr:WaitForChild("Dark")
function any_new_result1.buttons(arg1) -- Line 77
	--[[ Upvalues[9]:
		[1]: var9_upvw (read and write)
		[2]: ClansInviteFrame_upvr (readonly)
		[3]: TextBox_upvr (readonly)
		[4]: var4_upvw (read and write)
		[5]: var10_upvw (read and write)
		[6]: Dark_upvr (readonly)
		[7]: var7_upvw (read and write)
		[8]: var6_upvw (read and write)
		[9]: var5_upvw (read and write)
	]]
	var9_upvw.new(ClansInviteFrame_upvr.Invite):buttonUp(function() -- Line 79
		--[[ Upvalues[9]:
			[1]: TextBox_upvr (copied, readonly)
			[2]: arg1 (readonly)
			[3]: var4_upvw (copied, read and write)
			[4]: var10_upvw (copied, read and write)
			[5]: ClansInviteFrame_upvr (copied, readonly)
			[6]: Dark_upvr (copied, readonly)
			[7]: var7_upvw (copied, read and write)
			[8]: var6_upvw (copied, read and write)
			[9]: var5_upvw (copied, read and write)
		]]
		local Text = TextBox_upvr.Text
		if Text:len() <= 2 then return end
		local any_getUserIdFromUsername_result1 = arg1:getUserIdFromUsername()
		if not any_getUserIdFromUsername_result1 then
			var4_upvw:createMessagePopup({
				message = "This username is not valid!";
				reOpen = "ClansInviteFrame";
			})
			return
		end
		var10_upvw.new(ClansInviteFrame_upvr):run()
		Dark_upvr.Visible = true
		local any_invitePlayer_result1 = var7_upvw:invitePlayer(Text)
		if any_invitePlayer_result1 == "success" then
			var6_upvw:setForceUpdate("clanInvites")
			var4_upvw:openFrame("ClansFrame")
			var5_upvw:play("Invite To Clan")
			Dark_upvr.Visible = false
			return
		end
		if any_invitePlayer_result1 == "debounce" then
			var4_upvw:createMessagePopup({
				message = "You're doing this too fast!";
				reOpen = "ClansInviteFrame";
			})
		elseif any_invitePlayer_result1 == "alreadyInClan" then
			var4_upvw:createMessagePopup({
				message = `{arg1:getUsernameFromUserId(any_getUserIdFromUsername_result1) or '?'} is already in a clan!`;
				reOpen = "ClansInviteFrame";
			})
		elseif any_invitePlayer_result1 == "alreadyInvited" then
			var4_upvw:createMessagePopup({
				message = `{arg1:getUsernameFromUserId(any_getUserIdFromUsername_result1) or '?'} is already invited!`;
				reOpen = "ClansInviteFrame";
			})
		elseif any_invitePlayer_result1 == "maxMembers" then
			var4_upvw:createMessagePopup({
				message = "Your clan has reached max members!";
				reOpen = "ClansInviteFrame";
			})
		elseif any_invitePlayer_result1 == "notUnlocked" then
			var4_upvw:createMessagePopup({
				message = `{arg1:getUsernameFromUserId(any_getUserIdFromUsername_result1) or '?'} hasn't unlocked the Kingdom map!`;
				reOpen = "ClansInviteFrame";
			})
		else
			var4_upvw:createMessagePopup({
				message = `Something went wrong, please try again! ({any_invitePlayer_result1})`;
				reOpen = "ClansInviteFrame";
			})
		end
		Dark_upvr.Visible = false
	end)
end
function any_new_result1.Start(arg1) -- Line 144
	arg1:buttons()
	arg1:focusLost()
end
local var36_upvw
local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
function any_new_result1.Construct(arg1) -- Line 149
	--[[ Upvalues[10]:
		[1]: var7_upvw (read and write)
		[2]: Knit_upvr (readonly)
		[3]: var36_upvw (read and write)
		[4]: var4_upvw (read and write)
		[5]: var5_upvw (read and write)
		[6]: var6_upvw (read and write)
		[7]: var9_upvw (read and write)
		[8]: var10_upvw (read and write)
		[9]: var11_upvw (read and write)
		[10]: ReplicatedStorage_upvr (readonly)
	]]
	var7_upvw = Knit_upvr.GetService("ClanService")
	var36_upvw = Knit_upvr.GetController("DataController")
	var4_upvw = Knit_upvr.GetController("UIController")
	var5_upvw = Knit_upvr.GetController("SoundController")
	var6_upvw = Knit_upvr.GetController("ClanController")
	var9_upvw = require(Knit_upvr.Modules.Button)
	var10_upvw = require(Knit_upvr.Modules.LoadingSpinner)
	var11_upvw = require(ReplicatedStorage_upvr.Shared.Functions)
end
return any_new_result1