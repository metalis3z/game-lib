-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:22:15
-- Luau version 6, Types version 3
-- Time taken: 0.006618 seconds

local Knit_upvr = require(game:GetService("ReplicatedStorage").Packages.Knit)
local any_new_result1 = require(Knit_upvr.Util.Component).new({
	Tag = "ClansProfileFrame";
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
local var13_upvw
local LocalPlayer_upvr = game:GetService("Players").LocalPlayer
local ClansProfileFrame_upvr = LocalPlayer_upvr:WaitForChild("PlayerGui"):WaitForChild("MainUI"):WaitForChild("Menus"):WaitForChild("ClansProfileFrame")
local Main_upvr = ClansProfileFrame_upvr:WaitForChild("Main")
local PlayerIcon = Main_upvr:WaitForChild("PlayerIcon")
local Kick_upvr = Main_upvr:WaitForChild("Kick")
local Promotion_upvr = Main_upvr:WaitForChild("Promotion")
local Promote_upvr = Promotion_upvr:WaitForChild("Promote")
local Demote_upvr = Promotion_upvr:WaitForChild("Demote")
function any_new_result1.getTrove(arg1) -- Line 64
	--[[ Upvalues[1]:
		[1]: var13_upvw (read and write)
	]]
	local _trove = arg1._trove
	if not _trove then
		_trove = var13_upvw.new()
		arg1._trove = _trove
	end
	return _trove
end
local PlayerDisplayName_upvr = Main_upvr:WaitForChild("PlayerDisplayName")
local PlayerUsername_upvr = Main_upvr:WaitForChild("PlayerUsername")
local Status_upvr = PlayerIcon:WaitForChild("Status")
local Icon_upvr = PlayerIcon:WaitForChild("Icon")
local Joined_upvr = Main_upvr:WaitForChild("Joined")
local Amount_upvr = Main_upvr:WaitForChild("HatchingPoints"):WaitForChild("Amount")
local Amount_upvr_2 = Main_upvr:WaitForChild("Rebirths"):WaitForChild("Amount")
local Holder_upvr = Main_upvr:WaitForChild("ItemsDonated"):WaitForChild("List"):WaitForChild("Holder")
function any_new_result1.update(arg1) -- Line 74
	--[[ Upvalues[19]:
		[1]: var5_upvw (read and write)
		[2]: LocalPlayer_upvr (readonly)
		[3]: PlayerDisplayName_upvr (readonly)
		[4]: PlayerUsername_upvr (readonly)
		[5]: Status_upvr (readonly)
		[6]: Icon_upvr (readonly)
		[7]: var9_upvw (read and write)
		[8]: Joined_upvr (readonly)
		[9]: Amount_upvr (readonly)
		[10]: Amount_upvr_2 (readonly)
		[11]: var11_upvw (read and write)
		[12]: Kick_upvr (readonly)
		[13]: Promotion_upvr (readonly)
		[14]: Promote_upvr (readonly)
		[15]: Demote_upvr (readonly)
		[16]: Holder_upvr (readonly)
		[17]: var10_upvw (read and write)
		[18]: var4_upvw (read and write)
		[19]: Main_upvr (readonly)
	]]
	-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
	local any_getViewProfileData_result1_3 = var5_upvw:getViewProfileData()
	local clanData = any_getViewProfileData_result1_3.clanData
	local userId_upvr = any_getViewProfileData_result1_3.userId
	local userInfo = any_getViewProfileData_result1_3.userInfo
	local var51 = clanData.members[`{LocalPlayer_upvr.UserId}`]
	local var52 = clanData.members[`{userId_upvr}`]
	local var53
	local function INLINED() -- Internal function, doesn't exist in bytecode
		var53 = `{userInfo.DisplayName}{utf8.char(57344)}`
		return var53
	end
	if not userInfo.HasVerifiedBadge or not INLINED() then
		var53 = `{userInfo.DisplayName}`
	end
	PlayerDisplayName_upvr.Text = var53
	PlayerUsername_upvr.Text = `@{userInfo.Username}`
	local serverTime = workspace:GetServerTimeNow()
	local lastOnline = var52.lastOnline
	local isOnline = (serverTime - lastOnline < 180)
	Status_upvr.Visible = isOnline
	task.spawn(function()
		--[[ Upvalues[3]:
			[1]: Icon_upvr (copied, readonly)
			[2]: var9_upvw (copied, read and write)
			[3]: userId_upvr (readonly)
		]]
		Icon_upvr.Image = var9_upvw.getUserHeadshot(userId_upvr)
	end)
	Joined_upvr.Text = `📅  Joined: {var9_upvw.formatUnix(DateTime.fromUnixTimestamp(var52.joinedAt))}`
	local weekly = var52.weekly
	local var57 = false
	if weekly and weekly.week and weekly.week == var9_upvw.getWeekNumber() then
		var57 = true
	end
	local hatchingPoints = 0
	local rebirths = 0
	if var57 and weekly.hatching then
		hatchingPoints = weekly.hatching
	end
	if var57 and weekly.rebirths then
		rebirths = weekly.rebirths
	end
	Amount_upvr.Text = var9_upvw.suffixes(hatchingPoints)
	Amount_upvr_2.Text = var9_upvw.suffixes(rebirths)
	Kick_upvr.Visible = false
	Promotion_upvr.Visible = false
	if table.find(var11_upvw.allowedToModify, var51.rank) then
		if var52.rank ~= 1 then
			Kick_upvr.Visible = true
		end
	end
	if table.find(var11_upvw.allowedToPromote, var51.rank) then
		if var52.rank ~= 1 then
			Promotion_upvr.Visible = true
		end
	end
	Promote_upvr.Visible = (var52.rank ~= 3)
	Demote_upvr.Visible = (var52.rank == 2)
	for _, v in Holder_upvr:GetChildren() do
		if v:GetAttribute("isItemUI") then
			v:Destroy()
		end
	end
	for _, v_2 in var52.itemsDonated do
		local any_createItemFromData_result1 = var10_upvw.itemUtils.createItemFromData(v_2)
		local any_item_result1 = var4_upvw.uis.item(any_createItemFromData_result1)
		any_item_result1.Parent = Holder_upvr
		var4_upvw:createInfoHoverOnGuiStateChange(any_item_result1.Main.Click, {
			item = any_createItemFromData_result1;
			unusable = true;
		})
	end
	arg1:getTrove():Add(var4_upvw:createInfoHoverOnGuiStateChange(Main_upvr.HatchingPoints.Icon.Click, {
		hoverType = "hatchingPoints";
	}))
end
local Dark_upvr = ClansProfileFrame_upvr:WaitForChild("Dark")
function any_new_result1.buttons(arg1) -- Line 139
	--[[ Upvalues[13]:
		[1]: var8_upvw (read and write)
		[2]: Kick_upvr (readonly)
		[3]: var6_upvw (read and write)
		[4]: var4_upvw (read and write)
		[5]: var5_upvw (read and write)
		[6]: Promotion_upvr (readonly)
		[7]: var12_upvw (read and write)
		[8]: ClansProfileFrame_upvr (readonly)
		[9]: Dark_upvr (readonly)
		[10]: var7_upvw (read and write)
		[11]: Promote_upvr (readonly)
		[12]: Demote_upvr (readonly)
		[13]: Main_upvr (readonly)
	]]
	var8_upvw.new(Kick_upvr):buttonUp(function() -- Line 141
		--[[ Upvalues[4]:
			[1]: var6_upvw (copied, read and write)
			[2]: var4_upvw (copied, read and write)
			[3]: arg1 (readonly)
			[4]: var5_upvw (copied, read and write)
		]]
		if var6_upvw:getFFlag("clansKick") == false then
			var4_upvw:createMessagePopup({
				fFlagDisabled = true;
				reOpen = "ClansFrame";
			})
		else
			if arg1._buttonsDisabled then return end
			local any_getViewProfileData_result1_2 = var5_upvw:getViewProfileData()
			var5_upvw:setConfirmData({
				confirmType = "kick";
				userId = any_getViewProfileData_result1_2.userId;
				username = any_getViewProfileData_result1_2.userInfo.Username;
				tag = any_getViewProfileData_result1_2.clanData.tag;
			})
			var4_upvw:openFrame("ClansConfirmFrame")
		end
	end)
	var8_upvw.new(Promotion_upvr):buttonUp(function() -- Line 163
		--[[ Upvalues[10]:
			[1]: var6_upvw (copied, read and write)
			[2]: var4_upvw (copied, read and write)
			[3]: arg1 (readonly)
			[4]: var12_upvw (copied, read and write)
			[5]: ClansProfileFrame_upvr (copied, readonly)
			[6]: Dark_upvr (copied, readonly)
			[7]: var5_upvw (copied, read and write)
			[8]: var7_upvw (copied, read and write)
			[9]: Promote_upvr (copied, readonly)
			[10]: Demote_upvr (copied, readonly)
		]]
		if var6_upvw:getFFlag("clansPromote") == false then
			var4_upvw:createMessagePopup({
				fFlagDisabled = true;
				reOpen = "ClansFrame";
			})
		else
			if arg1._buttonsDisabled then return end
			arg1._buttonsDisabled = true
			local any_new_result1_2 = var12_upvw.new(ClansProfileFrame_upvr)
			any_new_result1_2:run()
			Dark_upvr.Visible = true
			local any_getViewProfileData_result1 = var5_upvw:getViewProfileData()
			local any_updateRank_result1, any_updateRank_result2 = var7_upvw:updateRank(any_getViewProfileData_result1.userId)
			local var76
			if any_updateRank_result1 == "success" then
				local members = any_getViewProfileData_result1.clanData.members
				members[`{any_getViewProfileData_result1.userId}`].rank = any_updateRank_result2
				Promote_upvr.Visible = (any_updateRank_result2 ~= 3)
				Demote_upvr.Visible = (any_updateRank_result2 == 2)
			else
				var4_upvw:createMessagePopup({
					message = `Something went wrong, please try again! ({any_updateRank_result1})`;
					reOpen = "ClansProfileFrame";
				})
			end
			end
			Dark_upvr.Visible = false
			arg1._buttonsDisabled = false
			any_new_result1_2:remove()
		end
	end)
	var8_upvw.new(Main_upvr.Back):buttonUp(function() -- Line 200
		--[[ Upvalues[2]:
			[1]: var5_upvw (copied, read and write)
			[2]: var4_upvw (copied, read and write)
		]]
		var5_upvw:setForceUpdate("yourClan")
		var4_upvw:openFrame("ClansFrame")
	end)
end
function any_new_result1.opened(arg1) -- Line 206
	arg1:update()
end
function any_new_result1.closed(arg1) -- Line 210
	arg1:getTrove():Clean()
end
function any_new_result1.Start(arg1) -- Line 214
	--[[ Upvalues[1]:
		[1]: var4_upvw (read and write)
	]]
	arg1:buttons()
	arg1:opened()
	var4_upvw:listenToOpen("ClansProfileFrame"):Connect(function() -- Line 218
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:opened()
	end)
	var4_upvw:listenToClose("ClansProfileFrame"):Connect(function() -- Line 221
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:closed()
	end)
end
local var80_upvw
local var81_upvw
local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
function any_new_result1.Construct(arg1) -- Line 226
	--[[ Upvalues[14]:
		[1]: var7_upvw (read and write)
		[2]: Knit_upvr (readonly)
		[3]: var80_upvw (read and write)
		[4]: var4_upvw (read and write)
		[5]: var81_upvw (read and write)
		[6]: var5_upvw (read and write)
		[7]: var6_upvw (read and write)
		[8]: var8_upvw (read and write)
		[9]: var9_upvw (read and write)
		[10]: ReplicatedStorage_upvr (readonly)
		[11]: var10_upvw (read and write)
		[12]: var11_upvw (read and write)
		[13]: var12_upvw (read and write)
		[14]: var13_upvw (read and write)
	]]
	var7_upvw = Knit_upvr.GetService("ClanService")
	var80_upvw = Knit_upvr.GetController("DataController")
	var4_upvw = Knit_upvr.GetController("UIController")
	var81_upvw = Knit_upvr.GetController("SoundController")
	var5_upvw = Knit_upvr.GetController("ClanController")
	var6_upvw = Knit_upvr.GetController("FFlagController")
	var8_upvw = require(Knit_upvr.Modules.Button)
	var9_upvw = require(ReplicatedStorage_upvr.Shared.Functions)
	var10_upvw = require(ReplicatedStorage_upvr.Shared.Util)
	var11_upvw = require(ReplicatedStorage_upvr.Shared.List.Clans.Config)
	var12_upvw = require(Knit_upvr.Modules.LoadingSpinner)
	var13_upvw = require(ReplicatedStorage_upvr.Packages.Trove)
end
return any_new_result1