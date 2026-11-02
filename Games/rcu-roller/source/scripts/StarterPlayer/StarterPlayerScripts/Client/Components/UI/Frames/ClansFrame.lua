-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw


-- Decompiler will be improved VERY SOON!

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)

-- Decompiled on 2025-03-27 06:22:07

-- Luau version 6, Types version 3

-- Time taken: 0.051922 seconds


local Knit_upvr = require(game:GetService("ReplicatedStorage").Packages.Knit)

local any_new_result1_3 = require(Knit_upvr.Util.Component).new({

	Tag = "ClansFrame";

	_createClan = {};

})

local var4_upvw

local var5_upvw

local var6_upvw

local var7_upvw

local var8_upvw

local var9_upvw

local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")

local var11_upvw

local var12_upvw

local var13_upvw

local var14_upvw

local var15_upvw

local var16_upvw

local var17_upvw

local var18_upvw

local var19_upvw

local var20_upvw

local var21_upvw

local var22_upvw

local LocalPlayer_upvr = game:GetService("Players").LocalPlayer

local ClansFrame_upvr = LocalPlayer_upvr:WaitForChild("PlayerGui"):WaitForChild("MainUI"):WaitForChild("Menus"):WaitForChild("ClansFrame")

local Main_2 = ClansFrame_upvr:WaitForChild("Main")

local Dark_upvr = Main_2:WaitForChild("Dark")

local List_upvr_2 = Main_2:WaitForChild("List")

local PromptFrames_upvr = Main_2:WaitForChild("PromptFrames")

local ItemDonatePrompt_upvr = PromptFrames_upvr:WaitForChild("ItemDonatePrompt")

local TextBox_upvr_5 = ItemDonatePrompt_upvr:WaitForChild("Input"):WaitForChild("TextBox")

local RebirthPrompt_upvr = PromptFrames_upvr:WaitForChild("RebirthPrompt")

local TextBox_upvr_9 = RebirthPrompt_upvr:WaitForChild("Input"):WaitForChild("TextBox")

local QuestionPrompt_upvr = PromptFrames_upvr:WaitForChild("QuestionPrompt")

local TextBox_upvr_6 = QuestionPrompt_upvr:WaitForChild("Input"):WaitForChild("TextBox")

local List_upvr = ClansFrame_upvr:WaitForChild("Displays"):WaitForChild("List")

local Clans_upvr_2 = List_upvr_2:WaitForChild("Clans")

local Invites_upvr = List_upvr_2:WaitForChild("Invites")

local CreateClan_upvr = List_upvr_2:WaitForChild("CreateClan")

local Steps_upvr = CreateClan_upvr:WaitForChild("Steps")

local ChangeClanIcon_upvr = List_upvr_2:WaitForChild("ChangeClanIcon")

local CheckYourClan_upvr = List_upvr_2:WaitForChild("CheckYourClan")

local Main_5_upvr = CheckYourClan_upvr:WaitForChild("MainClanInformation"):WaitForChild("Main")

local Buttons_upvr = CheckYourClan_upvr:WaitForChild("Buttons")

local CheckOtherClan_upvr = List_upvr_2:WaitForChild("CheckOtherClan")

local Main_9_upvr = CheckOtherClan_upvr:WaitForChild("MainClanInformation"):WaitForChild("Main")

local ClanInvites_upvr = List_upvr_2:WaitForChild("ClanInvites")

local ClanSettings_upvr = List_upvr_2:WaitForChild("ClanSettings")

local TextBox_upvr_2 = ClanSettings_upvr:WaitForChild("ClanDescription"):WaitForChild("Main"):WaitForChild("Input"):WaitForChild("TextBox")

local Main_7 = ClanSettings_upvr:WaitForChild("ClanImage"):WaitForChild("Main")

local TextBox_upvr_4 = Main_7:WaitForChild("Input"):WaitForChild("TextBox")

local ClanIcon_upvr = Main_7:WaitForChild("ClanIcon")

local Icon_upvr = ClanIcon_upvr:WaitForChild("Icon")

local State_upvr_2 = ClanSettings_upvr:WaitForChild("RequestSettings"):WaitForChild("Main"):WaitForChild("State")

local State_upvr = ClanSettings_upvr:WaitForChild("Question1"):WaitForChild("Main"):WaitForChild("State")

local State_upvr_3 = ClanSettings_upvr:WaitForChild("Question2"):WaitForChild("Main"):WaitForChild("State")

local ClanInventory_upvr = List_upvr_2:WaitForChild("ClanInventory")

local Holder_upvr = ClanInventory_upvr:WaitForChild("ItemsDonated"):WaitForChild("List"):WaitForChild("Holder")

local ClanItemConfirmation_upvr = List_upvr_2:WaitForChild("ClanItemConfirmation")

local ClanPlayerRequest_upvr = List_upvr_2:WaitForChild("ClanPlayerRequest")

local StatsFrame = ClanPlayerRequest_upvr:WaitForChild("StatsFrame")

local Numbers_upvr_2 = StatsFrame:WaitForChild("Numbers")

local Main_6_upvr = ClanPlayerRequest_upvr:WaitForChild("Question1"):WaitForChild("Main")

local Main_4_upvr = ClanPlayerRequest_upvr:WaitForChild("Question2"):WaitForChild("Main")

local TextBox_upvr = Main_6_upvr:WaitForChild("Input"):WaitForChild("TextBox")

local TextBox_upvr_8 = Main_4_upvr:WaitForChild("Input"):WaitForChild("TextBox")

local ClanPlayerApplication_upvr = List_upvr_2:WaitForChild("ClanPlayerApplication")

local Question1_upvr = ClanPlayerApplication_upvr:WaitForChild("Question1")

local Question2_upvr = ClanPlayerApplication_upvr:WaitForChild("Question2")

local StatsFrame_2 = ClanPlayerApplication_upvr:WaitForChild("StatsFrame")

local Numbers_upvr = StatsFrame_2:WaitForChild("Numbers")

local Assets_upvr = ReplicatedStorage_upvr.Assets

local Clans_upvr = Assets_upvr.UI.Clans

function any_new_result1_3.getTopClansLayoutOrders(arg1, arg2) -- Line 139

	-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments

	local tbl_3 = {}

	local module = {}

	for i, v in arg2 do

		if not tbl_3[v.level] then

			tbl_3[v.level] = {}

		end

		local var115 = 0

		for _, v_2 in v.members do

			var115 += v_2.rebirths

		end

		tbl_3[v.level][#tbl_3[v.level] + 1] = {

			index = i;

			rebirths = var115;

			level = v.level;

		}

	end

	for _, v_3 in tbl_3 do

		if 1 < #v_3 then

			table.sort(v_3, function(arg1_2, arg2_2) -- Line 158

				local var118

				if arg2_2.rebirths >= arg1_2.rebirths then

					var118 = false

				else

					var118 = true

				end

				return var118

			end)

		end

	end

	for _, v_4 in tbl_3 do

		for i_5, v_5 in v_4 do

			module[v_5.index] = {

				order = -((v_5.level + 1) * 1000) + i_5;

				place = 1;

				index = v_5.index;

			}



	end

	table.sort(module, function(arg1_3, arg2_3) -- Line 172

		local var122

		if arg1_3.order >= arg2_3.order then

			var122 = false

		else

			var122 = true

		end

		return var122

	end)

	return module

end

local var123_upvw = 0

function any_new_result1_3.updateTopClans(arg1, arg2) -- Line 179

	--[[ Upvalues[12]:

		[1]: var123_upvw (read and write)

		[2]: var14_upvw (read and write)

		[3]: var18_upvw (read and write)

		[4]: ClansFrame_upvr (readonly)

		[5]: Dark_upvr (readonly)

		[6]: Clans_upvr_2 (readonly)

		[7]: var9_upvw (read and write)

		[8]: Clans_upvr (readonly)

		[9]: var17_upvw (read and write)

		[10]: var13_upvw (read and write)

		[11]: var11_upvw (read and write)

		[12]: CheckOtherClan_upvr (readonly)

	]]

	-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments

	arg1:openCategory("topClans")

	if os.time() - var123_upvw < var14_upvw.updateTopClansUI and not arg2 then

	else

		local any_new_result1_13 = var18_upvw.new(ClansFrame_upvr)

		any_new_result1_13:run()

		Dark_upvr.Visible = true

		for _, v_15 in Clans_upvr_2:GetChildren() do

			if v_15:IsA("Frame") then

				v_15:Destroy()

			end

		end

		local any_getTopClans_result1 = var9_upvw:getTopClans()

		if not any_getTopClans_result1 then

			Dark_upvr.Visible = false

			any_new_result1_13:remove()

			return

		end

		var123_upvw = os.time()

		local any_getTopClansLayoutOrders_result1 = arg1:getTopClansLayoutOrders(any_getTopClans_result1)


		for i_16, v_16_upvr in any_getTopClans_result1 do

			local clone_3 = Clans_upvr.ClanTop:Clone()

			local Main_17 = clone_3.Main

			local ClanStats = Main_17.ClanStats

			clone_3.LayoutOrder = i_16

			-- Fixed: var198 was uninitialized before iteration; var197 summed members rebirths
			-- Fixed: var200 was declared inside loop body used outside (always nil)
			local totalRebirths = 0
			for _, v_17 in v_16_upvr.members do
				totalRebirths += v_17.rebirths
			end

			local rankOrder = 999
			for i_18, v_18 in any_getTopClansLayoutOrders_result1 do

				if i_16 == v_18.index then

					rankOrder = i_18

				end

			end

			Main_17.ClanRank.Text = '#'..rankOrder

			local var199 = var17_upvw.top[rankOrder]

			if var199 then

				Main_17.UIStroke.Color = var199.uiStroke

				Main_17.UIStroke.UIGradient.Color = var199.gradient

				Main_17.UIGradient.Color = var199.gradient

				Main_17.ClanTag.UIGradient.Color = var199.gradientTag

				Main_17.ClanTag.UIStroke.Color = var199.uiStrokeTag

				Main_17.ClanMembers.Icon.ImageColor3 = Color3.new(0, 0, 0)

				Main_17.ClanMembers.Amount.TextColor3 = Color3.new(0, 0, 0)

				Main_17.ClanMembers.Icon.ImageTransparency = 0.4

				Main_17.ClanMembers.Amount.TextTransparency = 0.4

		end

			-- Fixed: v_20 was a for-loop variable used outside loop scope; use rankOrder and layout orders table
			local layoutEntry = any_getTopClansLayoutOrders_result1[rankOrder]
			if layoutEntry then
				clone_3.LayoutOrder = layoutEntry.order
			else
				clone_3.LayoutOrder = rankOrder
			end

			Main_17.ClanTag.Text = `[{v_16_upvr.tag}]`

			Main_17.ClanMembers.Amount.Text = `{var13_upvw.getAmountInTable(v_16_upvr.members)}/{var14_upvw.maxMembers + 1}`

			Main_17.ClanIcon.Icon.Image = "rbxassetid://"..(v_16_upvr.image or "16987069167")

			ClanStats.LevelAmount.Text = `Level {v_16_upvr.level}`

			-- Fixed: var200 was declared inside loop body, used outside (nil); use totalRebirths
			ClanStats.RebirthAmount.Text = `{var13_upvw.suffixes(totalRebirths)}`

			clone_3.Parent = Clans_upvr_2

			var11_upvw.new(clone_3.Main, clone_3.Main.Click, {

				enter = 1.01;

				up = 1.01;

				down = 0.99;

			}):buttonUp(function() -- Line 275

				--[[ Upvalues[3]:

					[1]: v_16_upvr (readonly)

					[2]: arg1 (readonly)

					[3]: CheckOtherClan_upvr (copied, readonly)

				]]

				print(v_16_upvr.clanId)

				arg1._viewClanId = v_16_upvr.clanId

				arg1:hideOtherClanFrames()

				arg1:updateOtherClan(v_16_upvr)

				CheckOtherClan_upvr.Visible = true

			end)

			if DateTime.now().UnixTimestampMillis % 2 == 0 then

				task.wait()

			end

		end

		for _, v_22 in Clans_upvr_2:GetChildren() do

			if v_22:IsA("Frame") then

				v_22.Visible = true

			end

		end

		Dark_upvr.Visible = false

		any_new_result1_13:remove()

	end

end

local UserService_upvr = game:GetService("UserService")

function any_new_result1_3.getUserInfos(arg1, arg2) -- Line 301

	--[[ Upvalues[2]:

		[1]: UserService_upvr (readonly)

		[2]: var13_upvw (read and write)

	]]

	local var211_upvw

	local pcall_result1, pcall_result2 = pcall(function() -- Line 303

		--[[ Upvalues[3]:

			[1]: var211_upvw (read and write)

			[2]: UserService_upvr (copied, readonly)

			[3]: arg2 (readonly)

		]]

		var211_upvw = UserService_upvr:GetUserInfosByUserIdsAsync(arg2)

	end)

	if not pcall_result1 then

		var13_upvw.print(`Kunde inte f\xE5 user infos: {pcall_result2}`, warn)

		return

	end

	-- Fixed: ({})[v_6.Id] = v_6 assigned to a discarded table (no-op)
	-- Fixed: var216 declared inside loop body then returned outside (always nil)
	local userInfoMap = {}

	for _, v_6 in var211_upvw do

		userInfoMap[v_6.Id] = v_6

	end

	return userInfoMap

end

function any_new_result1_3.memberLayoutOrder(arg1, arg2, arg3) -- Line 320

	local var217 = math.log10(arg2 + 1) * 1000

	if arg3 == 1 then

		return -var217 - 100000

	end

	if arg3 == 2 then

		return -var217 - 10000

	end

	return -var217

end

function any_new_result1_3.createPlayerFrame(arg1, arg2, arg3) -- Line 335

	--[[ Upvalues[3]:

		[1]: var4_upvw (read and write)

		[2]: Clans_upvr (readonly)

		[3]: var13_upvw (read and write)

	]]

	-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments

	local clone_5 = Clans_upvr.Player:Clone()

	local Main_18 = clone_5.Main

	local var220 = arg3.userInfos[tonumber(arg2)]

	if not var220 then

		var220 = {

			DisplayName = "Failed";

			Username = "Failed";

			HasVerifiedBadge = false;

		}

	end

	-- Fixed: empty if/else body for verified badge — decompiler lost the display name assignment
	-- Intent: show badge icon suffix in display name if player is verified
	local displayNameText
	if var220.HasVerifiedBadge then
		displayNameText = `{var220.DisplayName}{utf8.char(57344)}`
	else
		displayNameText = `{var220.DisplayName}`
	end

	Main_18.PlayerInfo.PlayerDisplayName.Text = displayNameText

	Main_18.PlayerUsername.Text = `@{var220.Username}`

	local PlayerIcon_upvr = Main_18.PlayerIcon

	task.spawn(function() -- Line 354

		--[[ Upvalues[3]:

			[1]: PlayerIcon_upvr (readonly)

			[2]: var13_upvw (copied, read and write)

			[3]: arg2 (readonly)

		]]

		PlayerIcon_upvr.Icon.Image = var13_upvw.getUserHeadshot(arg2)

	end)

	clone_5:SetAttribute("isPlayerFrame", true)

	clone_5.Visible = true

	clone_5.Parent = arg3.parent

	return clone_5

end

function any_new_result1_3.removePlayerFrames(arg1, arg2) -- Line 365

	for _, v_7 in arg2:GetChildren() do

		if v_7:GetAttribute("isPlayerFrame") then

			v_7:Destroy()

		end

	end

end

local var229_upvw = 0

function any_new_result1_3.updateYourClan(arg1, arg2) -- Line 373

	--[[ Upvalues[16]:

		[1]: var229_upvw (read and write)

		[2]: var14_upvw (read and write)

		[3]: var4_upvw (read and write)

		[4]: var18_upvw (read and write)

		[5]: ClansFrame_upvr (readonly)

		[6]: Dark_upvr (readonly)

		[7]: var9_upvw (read and write)

		[8]: var7_upvw (read and write)

		[9]: LocalPlayer_upvr (readonly)

		[10]: Buttons_upvr (readonly)

		[11]: Main_5_upvr (readonly)

		[12]: CheckYourClan_upvr (readonly)

		[13]: var15_upvw (read and write)

		[14]: var13_upvw (read and write)

		[15]: var11_upvw (read and write)

		[16]: var5_upvw (read and write)

	]]

	-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments

	arg1:openCategory("yourClan")

	local var262_upvr

	if os.time() - var229_upvw < var14_upvw.updateUI and not arg2 then

	else

		local any_getData_result1_5 = var4_upvw:getData()

		if any_getData_result1_5.clanId == "" then return end

		var262_upvr = var18_upvw

		var262_upvr = ClansFrame_upvr

		local any_new_result1_8 = var262_upvr.new(var262_upvr)

		var262_upvr = any_new_result1_8.run

		var262_upvr(any_new_result1_8)

		var262_upvr = Dark_upvr

		var262_upvr.Visible = true

		var262_upvr = var9_upvw:getClanData(any_getData_result1_5.clanId)

		if not var262_upvr then

			var262_upvr = var7_upvw:getClanCache()

		end

		if not var262_upvr then

			Dark_upvr.Visible = false

			any_new_result1_8:remove()

			return

		end

		var229_upvw = os.time()

		local rank = var262_upvr.members[tostring(LocalPlayer_upvr.UserId)].rank

		arg1._yourClanStored.data = var262_upvr

		local _yourClanStored = arg1._yourClanStored

		_yourClanStored.rank = rank

		if table.find(var14_upvw.allowedToModify, rank) then

			_yourClanStored = true

		else

			_yourClanStored = false

		end

		Buttons_upvr.Invites.Visible = _yourClanStored

		Buttons_upvr.Invite.Visible = _yourClanStored

		Main_5_upvr.ClanSettings.Visible = _yourClanStored

		Main_5_upvr.Description.Text = var262_upvr.description or ""

		Main_5_upvr.ClanTag.Text = '['..var262_upvr.tag..']'

		Main_5_upvr.Icon.Amount.Text = var262_upvr.level

		Main_5_upvr.ClanIcon.Icon.Image = "rbxassetid://"..(var262_upvr.image or "16987069167")


		local tbl_2 = {}

		for i_23, _ in var262_upvr.members do

			tbl_2[#tbl_2 + 1] = tonumber(i_23)

		end

		-- Fixed: var268 was loop-local (nil outside loop), should pass tbl_2
		local any_getUserInfos_result1_4_upvr = arg1:getUserInfos(tbl_2)

		if not any_getUserInfos_result1_4_upvr then

			Dark_upvr.Visible = false

			any_new_result1_8:remove()

			return

		end

		arg1:removePlayerFrames(CheckYourClan_upvr)

		for i_24_upvr, v_24 in var262_upvr.members do

			local any_createPlayerFrame_result1_6 = arg1:createPlayerFrame(i_24_upvr, {

				userInfos = any_getUserInfos_result1_4_upvr;

				parent = CheckYourClan_upvr;

			})

			local Main_16 = any_createPlayerFrame_result1_6.Main

			local serverTime = workspace:GetServerTimeNow()

			-- Fixed: var reuse — serverTime was boolean then overwritten with GetChildren() result
			local isOnline
			if serverTime - v_24.lastOnline >= 180 then

				isOnline = false

			else

				isOnline = true

			end

			Main_16.PlayerInfo.Status.Visible = isOnline

			-- Fixed: broken ipairs decomposition — GetChildren() used directly
			for _, v_25 in Main_16.PlayerRank:GetChildren() do

				v_25.Visible = false

			end

			children_11 = Main_16.PlayerRank[var15_upvw[v_24.rank]]

			children_11.Visible = true

			children_11 = Main_16[var15_upvw[v_24.rank]]

			children_11.Enabled = true

			local function INLINED() -- Internal function, doesn't exist in bytecode

				children_11 = any_getData_result1_5.rebirths

				return children_11

			end

			if tonumber(i_24_upvr) ~= LocalPlayer_upvr.UserId or not INLINED() then

				children_11 = v_24.rebirths

			end

			Main_16.Rebirths.Amount.Text = var13_upvw.suffixes(children_11)

			Main_16.Rebirths.Visible = true

			any_createPlayerFrame_result1_6.LayoutOrder = arg1:memberLayoutOrder(v_24.rebirths, v_24.rank)

			var11_upvw.new(any_createPlayerFrame_result1_6.Main, any_createPlayerFrame_result1_6.Main.Click, {

				enter = 1.01;

				up = 1.01;

				down = 0.99;

			}):buttonUp(function() -- Line 460

				--[[ Upvalues[5]:

					[1]: var7_upvw (copied, read and write)

					[2]: var262_upvr (readonly)

					[3]: i_24_upvr (readonly)

					[4]: any_getUserInfos_result1_4_upvr (readonly)

					[5]: var5_upvw (copied, read and write)

				]]

				var7_upvw:setViewProfileData({

					clanData = var262_upvr;

					userId = tonumber(i_24_upvr);

					userInfo = any_getUserInfos_result1_4_upvr[tonumber(i_24_upvr)];

				})

				var5_upvw:openFrame("ClansProfileFrame")

			end)

		end

		for i_26, _ in var262_upvr.buildings do

			if i_26:find("clanSeat") then

			end

		end

		Main_5_upvr.ClanMembers.Amount.Text = `{var13_upvw.getAmountInTable(var262_upvr.members)}/{var14_upvw.maxMembers + 1}`

		Dark_upvr.Visible = false

		any_new_result1_8:remove()

	end

end

function any_new_result1_3.updateOtherClan(arg1, arg2) -- Line 483

	--[[ Upvalues[9]:

		[1]: var4_upvw (read and write)

		[2]: var18_upvw (read and write)

		[3]: ClansFrame_upvr (readonly)

		[4]: Dark_upvr (readonly)

		[5]: var14_upvw (read and write)

		[6]: var13_upvw (read and write)

		[7]: Main_9_upvr (readonly)

		[8]: CheckOtherClan_upvr (readonly)

		[9]: var15_upvw (read and write)

	]]


	local any_getData_result1 = var4_upvw:getData()

	local any_new_result1_4 = var18_upvw.new(ClansFrame_upvr)

	any_new_result1_4:run()

	Dark_upvr.Visible = true

	local var393 = 0

	for i_8, _ in arg2.buildings do

		if i_8:find("clanSeat") then

			var393 += 1

		end

	end

	local rebirths_3 = arg2.requests.rebirths

	-- Only show join button if the local player is not already in a clan
	if any_getData_result1.clanId == "" then

		local hasFreeSeat = var393 > var13_upvw.getAmountInTable(arg2.members)

		local meetsRebirthReq = (not rebirths_3) or (any_getData_result1.rebirths >= rebirths_3)

		Main_9_upvr.RequestJoin.Visible = hasFreeSeat and meetsRebirthReq

		Main_9_upvr.RequestRequired.Visible = false

		if rebirths_3 and hasFreeSeat and not meetsRebirthReq then

			Main_9_upvr.RequestRequired.Visible = true

			Main_9_upvr.RequestRequired.Label.Text = `{var13_upvw.suffixes(rebirths_3)} Required`

		end

	else

		Main_9_upvr.RequestJoin.Visible = false

		Main_9_upvr.RequestRequired.Visible = false

	end

	Main_9_upvr.Description.Text = arg2.description or ""

	Main_9_upvr.ClanTag.Text = '['..arg2.tag..']'

	Main_9_upvr.ClanMembers.Amount.Text = `{var13_upvw.getAmountInTable(arg2.members)}/{var393}`

	Main_9_upvr.Icon.Amount.Text = arg2.level

	Main_9_upvr.ClanIcon.Icon.Image = "rbxassetid://"..(arg2.image or "16987069167")

	Main_9_upvr.ClanMembers.Amount.Text = `{var13_upvw.getAmountInTable(arg2.members)}/{var393}`

	Main_9_upvr.Icon.Amount.Text = arg2.level

	Main_9_upvr.ClanIcon.Icon.Image = "rbxassetid://"..(arg2.image or "16987069167")

	local tbl = {}

	for i_9, _ in arg2.members do

		tbl[#tbl + 1] = tonumber(i_9)

	end

	local any_getUserInfos_result1_2 = arg1:getUserInfos(tbl)

	if not any_getUserInfos_result1_2 then

		Dark_upvr.Visible = false

		any_new_result1_4:remove()

	else

		arg1:removePlayerFrames(CheckOtherClan_upvr)

		for i_27, v_27 in arg2.members do

			local any_createPlayerFrame_result1 = arg1:createPlayerFrame(i_27, {

				userInfos = any_getUserInfos_result1_2;

				parent = CheckOtherClan_upvr;

			})

			local Main = any_createPlayerFrame_result1.Main

			local PlayerRank = Main.PlayerRank

			local workspace_GetServerTimeNow_result1_4 = workspace:GetServerTimeNow()

			if workspace_GetServerTimeNow_result1_4 - v_27.lastOnline >= 180 then

				workspace_GetServerTimeNow_result1_4 = false

			else

				workspace_GetServerTimeNow_result1_4 = true

			end

			Main.PlayerInfo.Status.Visible = workspace_GetServerTimeNow_result1_4

			for _, v_28 in PlayerRank:GetChildren() do

				v_28.Visible = false

			end

			PlayerRank[var15_upvw[v_27.rank]].Visible = true

			Main[var15_upvw[v_27.rank]].Enabled = true

			Main.Rebirths.Amount.Text = var13_upvw.suffixes(v_27.rebirths)

			Main.Rebirths.Visible = true

			any_createPlayerFrame_result1.LayoutOrder = arg1:memberLayoutOrder(v_27.rebirths, v_27.rank)

		end

		Dark_upvr.Visible = false

		any_new_result1_4:remove()


	end

end

function any_new_result1_3.updateYourInvites(arg1) -- Line 559

	--[[ Upvalues[13]:

		[1]: var4_upvw (read and write)

		[2]: Invites_upvr (readonly)

		[3]: var13_upvw (read and write)

		[4]: var18_upvw (read and write)

		[5]: ClansFrame_upvr (readonly)

		[6]: var9_upvw (read and write)

		[7]: Clans_upvr (readonly)

		[8]: var14_upvw (read and write)

		[9]: var11_upvw (read and write)

		[10]: Dark_upvr (readonly)

		[11]: var6_upvw (read and write)

		[12]: CheckYourClan_upvr (readonly)

		[13]: var5_upvw (read and write)

	]]

	arg1:openCategory("invites")

	local any_getData_result1_4 = var4_upvw:getData()

	local tbl_7 = {}

	local var426 = any_getData_result1_4.clanInvites

	for i_10, _ in var426 do

		if not Invites_upvr:FindFirstChild(i_10) then

			tbl_7[#tbl_7 + 1] = i_10

		end

	end

	for _, v_11 in Invites_upvr:GetChildren() do

		if v_11:GetAttribute("isInvite") and not any_getData_result1_4.clanInvites[v_11.Name] then

			v_11:Destroy()

		end

	end

	if 0 >= var13_upvw.getAmountInTable(any_getData_result1_4.clanInvites) then

		children_3 = false

	else

		children_3 = true

	end

	Invites_upvr.INVITES.Visible = children_3

	Invites_upvr.NOT_INVITED.Visible = not children_3

	if #tbl_7 == 0 then

	else

		local any_new_result1_12 = var18_upvw.new(ClansFrame_upvr)

		any_new_result1_12:run()

		for _, v_29_upvr in tbl_7 do

			local var431 = var9_upvw:getMultiClanData(tbl_7)[v_29_upvr]

			local var432

			if var431 then

				local clone_2 = Clans_upvr.ClanInvite:Clone()

				local Main_11 = clone_2.Main

				var432 = var14_upvw.maxMembers

				for i_30, _ in var431.buildings do

					if i_30:find("clanSeat") then

						var432 += 1

					end

				end

				Main_11.ClanTag.Text = `[{var431.tag}]`

				Main_11.ClanLevel.Amount.Text = `Level {var431.level}`

				Main_11.ClanIcon.Icon.Image = "rbxassetid://"..(var431.image or "16987069167")

				Main_11.ClanMembers.Amount.Text = `{var13_upvw.getAmountInTable(var431.members)}/{var432}`

				clone_2:SetAttribute("isInvite", true)

				clone_2.Name = v_29_upvr

				clone_2.Visible = true

				clone_2.Parent = Invites_upvr

				var11_upvw.new(Main_11.Accept):buttonUp(function() -- Line 624

					--[[ Upvalues[10]:

						[1]: var4_upvw (copied, read and write)

						[2]: arg1 (readonly)

						[3]: var18_upvw (copied, read and write)

						[4]: ClansFrame_upvr (copied, readonly)

						[5]: Dark_upvr (copied, readonly)

						[6]: var9_upvw (copied, read and write)

						[7]: v_29_upvr (readonly)

						[8]: var6_upvw (copied, read and write)

						[9]: CheckYourClan_upvr (copied, readonly)

						[10]: var5_upvw (copied, read and write)

					]]


					if arg1._buttonsDisabled then return end

					var18_upvw.new(ClansFrame_upvr):run()

					Dark_upvr.Visible = true

					arg1._buttonsDisabled = true

					local any_acceptInvite_result1 = var9_upvw:acceptInvite(v_29_upvr)

					if any_acceptInvite_result1 == "success" then

						var6_upvw:play("Join Clan")

						arg1:hideOtherClanFrames()

						arg1:updateYourClan()

						CheckYourClan_upvr.Visible = true

						arg1._buttonsDisabled = false

						return

					end

					if any_acceptInvite_result1 == "inviteNoLongerAvailable" then

						var5_upvw:createMessagePopup({

							message = "Sorry, this invite is no longer valid!";

							reOpen = "ClansFrame";

						})

					elseif any_acceptInvite_result1 == "maxMembers" then

						var5_upvw:createMessagePopup({

							message = "This clan has reached the member limit!";

							reOpen = "ClansFrame";

						})

					elseif any_acceptInvite_result1 == "debounce" then

						var5_upvw:createMessagePopup({

							message = "You're doing this too fast!";

							reOpen = "ClansFrame";

						})

					else

						var5_upvw:createMessagePopup({

							message = `Something went wrong, please try again! ({any_acceptInvite_result1})`;

							reOpen = "ClansFrame";

						})

					end

					Dark_upvr.Visible = false

					arg1._buttonsDisabled = false


				end)

				var11_upvw.new(Main_11.Cancel):buttonUp(function() -- Line 671

					--[[ Upvalues[6]:

						[1]: arg1 (readonly)

						[2]: var18_upvw (copied, read and write)

						[3]: ClansFrame_upvr (copied, readonly)

						[4]: Dark_upvr (copied, readonly)

						[5]: var9_upvw (copied, read and write)

						[6]: v_29_upvr (readonly)

					]]

					if arg1._buttonsDisabled then

					else

						local any_new_result1 = var18_upvw.new(ClansFrame_upvr)

						any_new_result1:run()

						Dark_upvr.Visible = true

						arg1._buttonsDisabled = true

						if var9_upvw:declineInvite(v_29_upvr) ~= "success" then

						end

						Dark_upvr.Visible = false

						arg1._buttonsDisabled = false

						any_new_result1:remove()

					end

				end)

			end

		end

		any_new_result1_12:remove()

	end

end

local var443_upvw = 0

function any_new_result1_3.updateClansInvites(arg1, arg2) -- Line 696

	--[[ Upvalues[13]:

		[1]: var443_upvw (read and write)

		[2]: var14_upvw (read and write)

		[3]: var4_upvw (read and write)

		[4]: var18_upvw (read and write)

		[5]: ClansFrame_upvr (readonly)

		[6]: Dark_upvr (readonly)

		[7]: var9_upvw (read and write)

		[8]: ClanInvites_upvr (readonly)

		[9]: var13_upvw (read and write)

		[10]: var11_upvw (read and write)

		[11]: ClanPlayerApplication_upvr (readonly)

		[12]: var6_upvw (read and write)

		[13]: var5_upvw (read and write)

	]]

	-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments

	if os.time() - var443_upvw < var14_upvw.updateUI and not arg2 then

	else

		local any_new_result1_2 = var18_upvw.new(ClansFrame_upvr)

		any_new_result1_2:run()

		Dark_upvr.Visible = true

		local any_getClanData_result1_2 = var9_upvw:getClanData(var4_upvw:getData().clanId)

		if not any_getClanData_result1_2 then

			Dark_upvr.Visible = false

			any_new_result1_2:remove()

			return

		end

		local any_getRequestsData_result1 = var9_upvw:getRequestsData()

		if not any_getRequestsData_result1 then

			Dark_upvr.Visible = false

			any_new_result1_2:remove()

			return

		end

		var443_upvw = os.time()

		local tbl_10 = {}

		for i_31, _ in any_getClanData_result1_2.invites do

			tbl_10[#tbl_10 + 1] = tonumber(i_31)

		end

		local tbl_11 = {}

		for i_32, _ in any_getRequestsData_result1 do

			tbl_11[#tbl_11 + 1] = tonumber(i_32)

		end

		local allUserIds = {}

		for _, uid in tbl_10 do allUserIds[#allUserIds + 1] = uid end

		for _, uid in tbl_11 do allUserIds[#allUserIds + 1] = uid end

		local any_getUserInfos_result1_3 = arg1:getUserInfos(allUserIds)

		if not any_getUserInfos_result1_3 then

			Dark_upvr.Visible = false

			any_new_result1_2:remove()

			return

		end

		arg1:removePlayerFrames(ClanInvites_upvr)

		local hasRequests = var13_upvw.getAmountInTable(any_getRequestsData_result1) > 0

		ClanInvites_upvr.JOIN_REQUESTS.Visible = hasRequests

		for i_33_upvr, v_33_upvr in any_getRequestsData_result1 do

			local any_createPlayerFrame_result1_4 = arg1:createPlayerFrame(i_33_upvr, {

				userInfos = any_getUserInfos_result1_3;

				parent = ClanInvites_upvr;

			})

			local Main_12 = any_createPlayerFrame_result1_4.Main

			Main_12.Check.Visible = true

			any_createPlayerFrame_result1_4.LayoutOrder = 999999999

			var11_upvw.new(Main_12.Check):buttonUp(function() -- Line 755

				--[[ Upvalues[4]:

					[1]: arg1 (readonly)

					[2]: i_33_upvr (readonly)

					[3]: v_33_upvr (readonly)

					[4]: ClanPlayerApplication_upvr (copied, readonly)

				]]

				arg1._requestUserId = i_33_upvr

				arg1:hideOtherClanFrames()

				arg1:updateClanPlayerApplication(tonumber(i_33_upvr), v_33_upvr)

				ClanPlayerApplication_upvr.Visible = true

			end)

		end

		for i_34_upvr, v_34 in any_getClanData_result1_2.invites do

			local any_createPlayerFrame_result1_5_upvr = arg1:createPlayerFrame(i_34_upvr, {

				userInfos = any_getUserInfos_result1_3;

				parent = ClanInvites_upvr;

			})

				parent = ClanInvites_upvr;

			})

			any_createPlayerFrame_result1_5_upvr.Main.Cancel.Visible = true

			any_createPlayerFrame_result1_5_upvr.LayoutOrder = tick() - v_34.invitedAt

			var11_upvw.new(any_createPlayerFrame_result1_5_upvr.Main.Cancel):buttonUp(function() -- Line 776

				--[[ Upvalues[9]:

					[1]: arg1 (readonly)

					[2]: var18_upvw (copied, read and write)

					[3]: ClansFrame_upvr (copied, readonly)

					[4]: Dark_upvr (copied, readonly)

					[5]: var9_upvw (copied, read and write)

					[6]: i_34_upvr (readonly)

					[7]: any_createPlayerFrame_result1_5_upvr (readonly)

					[8]: var6_upvw (copied, read and write)

					[9]: var5_upvw (copied, read and write)

				]]


				if arg1._buttonsDisabled then return end

				var18_upvw.new(ClansFrame_upvr):run()

				Dark_upvr.Visible = true

				arg1._buttonsDisabled = true

				local any_cancelInvite_result1 = var9_upvw:cancelInvite(i_34_upvr)

				if any_cancelInvite_result1 == "success" then

					any_createPlayerFrame_result1_5_upvr:Destroy()

					var6_upvw:play("Clan Cancel", {

						volume = 0.3;

					})

					Dark_upvr.Visible = false

					arg1._buttonsDisabled = false

					return

				end

				if any_cancelInvite_result1 == "debounce" then

					var5_upvw:createMessagePopup({

						message = "You're doing this too fast!";

						reOpen = "ClansFrame";

					})

				else

					var5_upvw:createMessagePopup({

						message = `Something went wrong, please try again! ({any_cancelInvite_result1})`;

						reOpen = "ClansFrame";

					})

				end

				Dark_upvr.Visible = false

				arg1._buttonsDisabled = false

			end)

		end

		Dark_upvr.Visible = false

		any_new_result1_2:remove()

	end

end

function any_new_result1_3.updateClanSettings(arg1) -- Line 815

	--[[ Upvalues[12]:

		[1]: var4_upvw (read and write)

		[2]: var18_upvw (read and write)

		[3]: ClansFrame_upvr (readonly)

		[4]: Dark_upvr (readonly)

		[5]: var9_upvw (read and write)

		[6]: TextBox_upvr_2 (readonly)

		[7]: TextBox_upvr_4 (readonly)

		[8]: Icon_upvr (readonly)

		[9]: State_upvr_2 (readonly)

		[10]: var13_upvw (read and write)

		[11]: State_upvr (readonly)

		[12]: State_upvr_3 (readonly)

	]]

	-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments

	local any_new_result1_9 = var18_upvw.new(ClansFrame_upvr)

	any_new_result1_9:run()

	Dark_upvr.Visible = true

	local any_getClanData_result1 = var9_upvw:getClanData(var4_upvw:getData().clanId)

	local var499

	if not any_getClanData_result1 then

		var499 = false

		Dark_upvr.Visible = var499

		any_new_result1_9:remove()

	else

		var499 = any_getClanData_result1.description or ""

		TextBox_upvr_2.Text = var499

		var499 = any_getClanData_result1.image or "16987069167"

		TextBox_upvr_4.Text = var499

		local var500 = Icon_upvr

		var499 = "rbxassetid://"..(any_getClanData_result1.image or "16987069167")

		var500.Image = var499

		var499 = any_getClanData_result1.requests.rebirths

		if var499 == false then

			var500 = false

		else

			var500 = true

		end

		var499 = State_upvr_2.OFF

		var499.Visible = not var500

		var499 = State_upvr_2.Required

		var499.Visible = var500

		if var500 then

			var499 = State_upvr_2.Required.Label

			var499.Text = `{var13_upvw.suffixes(any_getClanData_result1.requests.rebirths)}+ Rebirths`

		end

		if any_getClanData_result1.requests.question1 == false then

			var499 = false

		else

			var499 = true

		end

		local var499_q2
		if any_getClanData_result1.requests.question2 == false then

			var499_q2 = false

		else

			var499_q2 = true

		end

		State_upvr.OFF.Visible = not var499

		State_upvr.Edit.Visible = var499

		State_upvr_3.OFF.Visible = not var499_q2

		State_upvr_3.Edit.Visible = var499_q2

		arg1._storedQuestion1 = any_getClanData_result1.requests.question1

		arg1._storedQuestion2 = any_getClanData_result1.requests.question2

		Dark_upvr.Visible = false

		any_new_result1_9:remove()

	end

end

function any_new_result1_3.setupDonatePrompt(arg1) -- Line 860

	--[[ Upvalues[1]:

		[1]: TextBox_upvr_5 (readonly)

	]]

	TextBox_upvr_5.FocusLost:Connect(function() -- Line 861

		--[[ Upvalues[1]:

			[1]: TextBox_upvr_5 (copied, readonly)

		]]

		local Text_4 = TextBox_upvr_5.Text

		if Text_4 == "" or not tonumber(Text_4) then

			TextBox_upvr_5.Text = ""

		else

			TextBox_upvr_5.Text = math.floor(Text_4)

		end

	end)

end

function any_new_result1_3.updateClanInventory(arg1, arg2) -- Line 872

	--[[ Upvalues[13]:

		[1]: var4_upvw (read and write)

		[2]: var18_upvw (read and write)

		[3]: ClansFrame_upvr (readonly)

		[4]: Dark_upvr (readonly)

		[5]: var9_upvw (read and write)

		[6]: Holder_upvr (readonly)

		[7]: ClanInventory_upvr (readonly)

		[8]: var19_upvw (read and write)

		[9]: var12_upvw (read and write)

		[10]: var5_upvw (read and write)

		[11]: var11_upvw (read and write)

		[12]: ItemDonatePrompt_upvr (readonly)

		[13]: TextBox_upvr_5 (readonly)

	]]

	arg1:openCategory("inventory")

	local any_getData_result1_6 = var4_upvw:getData()

	local any_new_result1_11 = var18_upvw.new(ClansFrame_upvr)

	any_new_result1_11:run()

	Dark_upvr.Visible = not arg2

	local any_getClanData_result1_4 = var9_upvw:getClanData(any_getData_result1_6.clanId)

	local var523

	if not any_getClanData_result1_4 then

		var523 = Dark_upvr

		var523.Visible = false

		var523 = any_new_result1_11.remove

		var523(any_new_result1_11)

	else

		for _, v_35 in Holder_upvr:GetChildren() do

			if v_35:GetAttribute("isItemUI") then

				v_35:Destroy()

			end

		end

		children_10 = Holder_upvr

		children_10.Visible = true

		children_10 = ClanInventory_upvr.Donate

		children_10.Visible = not arg2

		children_10 = ClanInventory_upvr.Cancel

		children_10.Visible = arg2

		children_10 = ClanInventory_upvr.Warning

		children_10.Visible = arg2

		if arg2 then

			children_10 = "Select items to donate!"

		else

			children_10 = "Clan Inventory"

		end

		ClanInventory_upvr.CLAN_INVENTORY.Label.Text = children_10

		if arg2 then

			for i_36, v_36 in any_getData_result1_6.inventory do

				if var19_upvw[i_36] then

					for i_37_upvr, v_37 in v_36 do

						local any_createItemFromData_result1_2 = var12_upvw.itemUtils.createItemFromData(v_37)

						if typeof(var19_upvw[i_36]) ~= "table" or var19_upvw[i_36][any_createItemFromData_result1_2:getName()] then

							local any_item_result1_3 = var5_upvw.uis.item(any_createItemFromData_result1_2)

							var11_upvw.new(any_item_result1_3.Main.IconContainer, any_item_result1_3.Main.Click):buttonUp(function() -- Line 917

								--[[ Upvalues[6]:

									[1]: arg1 (readonly)

									[2]: i_37_upvr (readonly)

									[3]: Dark_upvr (copied, readonly)

									[4]: ItemDonatePrompt_upvr (copied, readonly)

									[5]: TextBox_upvr_5 (copied, readonly)

									[6]: Holder_upvr (copied, readonly)

								]]

								arg1._donateItemId = i_37_upvr

								Dark_upvr.Visible = true

								ItemDonatePrompt_upvr.Visible = true

								TextBox_upvr_5.Text = ""

								Holder_upvr.Visible = false

							end)

							var5_upvw:createInfoHoverOnGuiStateChange(any_item_result1_3.Main.Click, {

								itemId = i_37_upvr;

								unusable = true;

							})

							any_item_result1_3.Parent = Holder_upvr

						end

					end

				end

			end

		else

		for _, var515 in any_getClanData_result1_4.inventory do

			local any_createItemFromData_result1 = var12_upvw.itemUtils.createItemFromData(var515)

			local any_item_result1_2 = var5_upvw.uis.item(any_createItemFromData_result1)

			any_item_result1_2.Parent = Holder_upvr

			var5_upvw:createInfoHoverOnGuiStateChange(any_item_result1_2.Main.Click, {

				item = any_createItemFromData_result1;

				unusable = true;

			})

		end
			end

		end

		Dark_upvr.Visible = false

		any_new_result1_11:remove()

	end

end

function any_new_result1_3.updateClanItemConfirmation(arg1) -- Line 952

	--[[ Upvalues[5]:

		[1]: var4_upvw (read and write)

		[2]: TextBox_upvr_5 (readonly)

		[3]: var12_upvw (read and write)

		[4]: var5_upvw (read and write)

		[5]: ClanItemConfirmation_upvr (readonly)

	]]

	local tonumber_result1 = tonumber(TextBox_upvr_5.Text)

	if not tonumber_result1 then

	else

		if tonumber_result1 <= 0 then return end

		local any_getItemFromId_result1_2 = var12_upvw.itemUtils.getItemFromId(var4_upvw:getData(), arg1._donateItemId)

		any_getItemFromId_result1_2:setAmount(tonumber_result1)

		local any_item_result1 = var5_upvw.uis.item(any_getItemFromId_result1_2)

		var5_upvw:createInfoHoverOnGuiStateChange(any_item_result1.Main.Click, {

			item = any_getItemFromId_result1_2;

			unusable = true;

		})

		local _itemUI = ClanItemConfirmation_upvr:FindFirstChild("_itemUI")

		if _itemUI then

			_itemUI:Destroy()

		end

		any_item_result1.Name = "_itemUI"

		any_item_result1.AnchorPoint = Vector2.new(0.5, 0.5)

		any_item_result1.Size = UDim2.fromScale(0.177, 0.297)

		any_item_result1.Position = UDim2.fromScale(0.5, 0.555)

		any_item_result1.Parent = ClanItemConfirmation_upvr

	end

end

local Next_upvr_2 = StatsFrame:WaitForChild("Next")

function any_new_result1_3.updateClanPlayerRequest(arg1) -- Line 986

	--[[ Upvalues[17]:

		[1]: var4_upvw (read and write)

		[2]: var18_upvw (read and write)

		[3]: ClansFrame_upvr (readonly)

		[4]: Dark_upvr (readonly)

		[5]: var9_upvw (read and write)

		[6]: Next_upvr_2 (readonly)

		[7]: Numbers_upvr_2 (readonly)

		[8]: var13_upvw (read and write)

		[9]: var20_upvw (read and write)

		[10]: LocalPlayer_upvr (readonly)

		[11]: var21_upvw (read and write)

		[12]: var12_upvw (read and write)

		[13]: var5_upvw (read and write)

		[14]: Assets_upvr (readonly)

		[15]: Main_6_upvr (readonly)

		[16]: Main_4_upvr (readonly)

		[17]: ClanPlayerRequest_upvr (readonly)

	]]

	local any_getData_result1_7_upvr = var4_upvw:getData()

	local any_new_result1_10 = var18_upvw.new(ClansFrame_upvr)

	any_new_result1_10:run()

	Dark_upvr.Visible = true

	local any_getClanData_result1_3 = var9_upvw:getClanData(arg1._viewClanId)

	local var553

	if not any_getClanData_result1_3 then

		var553 = false

		Dark_upvr.Visible = var553

		any_new_result1_10:remove()

	else

		for _, v_38 in Next_upvr_2.Pets:GetChildren() do

			if v_38:GetAttribute("isItemUI") then

				v_38:Destroy()

			end

		end

		for _, v_39 in Next_upvr_2.Gamepasses:GetChildren() do

			if v_39:IsA("Frame") or v_39:IsA("ImageLabel") then

				v_39:Destroy()

			end

		end

		Numbers_upvr_2.TimePlayed.Amount.Text = var13_upvw.formatTime2(any_getData_result1_7_upvr.stats.timePlayed)

		Numbers_upvr_2.Rebirths.Amount.Text = var13_upvw.suffixes(any_getData_result1_7_upvr.rebirths)

		Numbers_upvr_2.EggsOpened.Amount.Text = var13_upvw.suffixes(any_getData_result1_7_upvr.stats.eggsOpened)

		Numbers_upvr_2.PetEquip.Amount.Text = var20_upvw.petsEquipped(LocalPlayer_upvr, any_getData_result1_7_upvr)

		Numbers_upvr_2.BestMap.Amount.Text = var21_upvw[#any_getData_result1_7_upvr.maps].name

		Numbers_upvr_2.Joined.Amount.Text = var13_upvw.formatUnix(DateTime.fromUnixTimestampMillis(any_getData_result1_7_upvr.profileCreateTime), {

			shortMonth = true;

		})

		local any_getPetsSorted_result1 = var12_upvw.petUtils.getPetsSorted(any_getData_result1_7_upvr)

		for i_40 = 1, 10 do

			if not any_getPetsSorted_result1[i_40] then break end

			var5_upvw.uis.pet(any_getPetsSorted_result1[i_40].item).Parent = Next_upvr_2.Pets

		end

		local maxPassesShown = (7 <= var13_upvw.getAmountInTable(any_getData_result1_7_upvr.passes)) and 6 or 7

		local var563_upvw = 0

		task.spawn(function() -- Line 1028

			--[[ Upvalues[6]:

				[1]: any_getData_result1_7_upvr (readonly)

				[2]: var563_upvw (read and write)

				[3]: NONE_16_upvr (readonly)

				[4]: Assets_upvr (copied, readonly)

				[5]: Next_upvr_2 (copied, readonly)

				[6]: var13_upvw (copied, read and write)

			]]

			for i_41, _ in any_getData_result1_7_upvr.passes do

			if maxPassesShown > var563_upvw then

					local clone_6 = Assets_upvr.UI.Clans.Gamepass:Clone()

					clone_6.Parent = Next_upvr_2.Gamepasses

					clone_6.Image = `rbxassetid://{var13_upvw.getProductInfo(i_41).IconImageAssetId}`

					var563_upvw += 1

				end

			end

		end)

		if 7 <= var13_upvw.getAmountInTable(any_getData_result1_7_upvr.passes) then

			local clone_8 = Assets_upvr.UI.Clans.MoreGamepasses:Clone()

			clone_8.LayoutOrder = 999

			clone_8.Parent = Next_upvr_2.Gamepasses

			var5_upvw:createInfoHoverOnGuiStateChange(clone_8.Click, {

				hoverType = "clanMorePasses";

				passes = any_getData_result1_7_upvr.passes;

			})

		end

		local question1_2 = any_getClanData_result1_3.requests.question1

		local question2 = any_getClanData_result1_3.requests.question2

		Main_6_upvr.QuestionName.Text = `{any_getClanData_result1_3.requests.question1}`

		Main_4_upvr.QuestionName.Text = `{any_getClanData_result1_3.requests.question2}`

		ClanPlayerRequest_upvr.Question1.Visible = question1_2

		ClanPlayerRequest_upvr.Question2.Visible = question2

		ClanPlayerRequest_upvr.CLAN_QUESTIONS.Visible = question1_2 or question2

		Dark_upvr.Visible = false

		any_new_result1_10:remove()

	end

end

local Main_10_upvr = ClanPlayerApplication_upvr:WaitForChild("PlayerProfile"):WaitForChild("Main")

local Label_upvr = Question1_upvr:WaitForChild("Main"):WaitForChild("Input"):WaitForChild("Label")

local Label_upvr_2 = Question2_upvr:WaitForChild("Main"):WaitForChild("Input"):WaitForChild("Label")

local Next_upvr = StatsFrame_2:WaitForChild("Next")

function any_new_result1_3.updateClanPlayerApplication(arg1, arg2, arg3) -- Line 1071

	--[[ Upvalues[12]:

		[1]: Main_10_upvr (readonly)

		[2]: var13_upvw (read and write)

		[3]: ClanPlayerApplication_upvr (readonly)

		[4]: Question1_upvr (readonly)

		[5]: Question2_upvr (readonly)

		[6]: Label_upvr (readonly)

		[7]: Label_upvr_2 (readonly)

		[8]: Numbers_upvr (readonly)

		[9]: Next_upvr (readonly)

		[10]: var12_upvw (read and write)

		[11]: var5_upvw (read and write)

		[12]: Assets_upvr (readonly)

	]]

	-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments

	local tbl_5 = {}

	tbl_5[1] = arg2

	local any_getUserInfos_result1 = arg1:getUserInfos(tbl_5)

	local var599

	if not any_getUserInfos_result1 then

	else

		print(arg3)

		local var598 = any_getUserInfos_result1[arg2]

		local var598 = any_getUserInfos_result1[arg2]

		Main_10_upvr.PlayerUsername.Text = var598.Username

		local displayName
		if var598.HasVerifiedBadge then
			displayName = `{var598.DisplayName}{utf8.char(57344)}`
		else
			displayName = `{var598.DisplayName}`
		end

		Main_10_upvr.PlayerDisplayName.Text = displayName

		local function loadIcon() -- Line 1082

			--[[ Upvalues[3]:

				[1]: Main_10_upvr (copied, readonly)

				[2]: var13_upvw (copied, read and write)

				[3]: arg2 (readonly)

			]]

			Main_10_upvr.PlayerIcon.Icon.Image = var13_upvw.getUserHeadshot(arg2)

		end

		task.spawn(loadIcon)

		ClanPlayerApplication_upvr.APPLICATION.Label.Text = `{var598.Username}'s Application`

		ClanPlayerApplication_upvr.PLAYER_STATS.Label.Text = `{var598.Username}'s Stats`

		local question1 = arg3.question1

		var599 = arg3.question2

		Question1_upvr.Visible = question1

		Question1_upvr.Main.QuestionName.Text = `{question1}`

		Question2_upvr.Visible = var599

		Question2_upvr.Main.QuestionName.Text = `{var599}`

		if question1 then

			Label_upvr.Text = `{arg3.question1Answer}`

		end

		if var599 then

			Label_upvr_2.Text = `{arg3.question2Answer}`

		end

		Numbers_upvr.TimePlayed.Amount.Text = var13_upvw.formatTime2(arg3.stats.timePlayed)

		Numbers_upvr.Rebirths.Amount.Text = var13_upvw.suffixes(arg3.stats.rebirths)

		Numbers_upvr.EggsOpened.Amount.Text = var13_upvw.suffixes(arg3.stats.eggsOpened)

		Numbers_upvr.PetEquip.Amount.Text = arg3.stats.petEquip

		Numbers_upvr.BestMap.Amount.Text = arg3.stats.bestMap

		Numbers_upvr.Joined.Amount.Text = var13_upvw.formatUnix(DateTime.fromUnixTimestampMillis(arg3.stats.joined), {

			shortMonth = true;

		})

		for _, v_41 in Next_upvr.Pets:GetChildren() do

			if v_41:GetAttribute("isItemUI") then

				v_41:Destroy()

			end

		end

		for _, v_42 in Next_upvr.Gamepasses:GetChildren() do

			if v_42:IsA("Frame") or v_42:IsA("ImageLabel") then

				v_42:Destroy()

			end

		end

		for i_44 = 1, #arg3.bestPets do

			var5_upvw.uis.pet(var12_upvw.itemUtils.createItemFromData(arg3.bestPets[i_44].item)).Parent = Next_upvr.Pets

		end

		if 7 <= var13_upvw.getAmountInTable(arg3.passes) then

		else

		end

		local var609_upvw = 0

		local const_number_upvr = 7

		task.spawn(function() -- Line 1130

			--[[ Upvalues[6]:

				[1]: arg3 (readonly)

				[2]: var609_upvw (read and write)

				[3]: const_number_upvr (readonly)

				[4]: Assets_upvr (copied, readonly)

				[5]: Next_upvr (copied, readonly)

				[6]: var13_upvw (copied, read and write)

			]]

			for i_45, _ in arg3.passes do

				if const_number_upvr > var609_upvw then

					local clone_4 = Assets_upvr.UI.Clans.Gamepass:Clone()

					clone_4.Parent = Next_upvr.Gamepasses

					clone_4.Image = `rbxassetid://{var13_upvw.getProductInfo(i_45).IconImageAssetId}`

					var609_upvw += 1

				end

			end

		end)

		if 7 <= var13_upvw.getAmountInTable(arg3.passes) then

			local clone_7 = Assets_upvr.UI.Clans.MoreGamepasses:Clone()

			clone_7.LayoutOrder = 999

			clone_7.Parent = Next_upvr.Gamepasses

			var5_upvw:createInfoHoverOnGuiStateChange(clone_7.Click, {

				hoverType = "clanMorePasses";

				passes = arg3.passes;

			})

		end

	end

end

function any_new_result1_3.setCreateClanData(arg1, arg2, arg3) -- Line 1159

	if not arg1._createClan then

		arg1._createClan = {}

	end

	arg1._createClan[arg2] = arg3

end

function any_new_result1_3.getValidTag(arg1, arg2) -- Line 1167

	if #arg2 < 2 or 4 < #arg2 or not arg2:match("^[%w]+$") then

		return false

	end

	return true

end

function any_new_result1_3.sanitizeClanTag(arg1, arg2) -- Line 1174

	local var616 = arg2

	if 4 < #arg2 then

		var616 = arg2:sub(1, 4)

	end

	var616 = var616:gsub("[^%w]", "")

	return var616:upper()

end

function any_new_result1_3.resetCreateClan(arg1) -- Line 1184

	--[[ Upvalues[1]:

		[1]: Steps_upvr (readonly)

	]]

	local _ = Steps_upvr['2']

	arg1._createClan = {}

	_.Main.ClanIcon.ImageContainer.Image = ""

	_.Main.ClanIcon.ImageContainer.Visible = true

	_.Main.ClanIcon.SearchIcon.Visible = false

	Steps_upvr['1'].Main.InputTag.TextBox.Text = ""

	_.Main.InputImage.TextBox.Text = ""

	Steps_upvr['3'].Main.Tag.Text = ""

end

function any_new_result1_3.createYourOwn(arg1) -- Line 1201

	--[[ Upvalues[2]:

		[1]: Steps_upvr (readonly)

		[2]: var9_upvw (read and write)

	]]

	local Main_15 = Steps_upvr['1'].Main

	local Main_14_upvr = Steps_upvr['2'].Main

	local TextBox_upvr_3 = Main_15.InputTag.TextBox

	local TextBox_upvr_7 = Main_14_upvr.InputImage.TextBox

	local Callback_upvr = Main_15.Callback

	TextBox_upvr_3:GetPropertyChangedSignal("Text"):Connect(function() -- Line 1217

		--[[ Upvalues[3]:

			[1]: TextBox_upvr_3 (readonly)

			[2]: arg1 (readonly)

			[3]: Callback_upvr (readonly)

		]]

		if not TextBox_upvr_3:IsFocused() then

		else

			local Text_2 = TextBox_upvr_3.Text

			local any_getValidTag_result1 = arg1:getValidTag(Text_2)

			Callback_upvr.Success.Visible = any_getValidTag_result1

			Callback_upvr.Err.Visible = not any_getValidTag_result1

			Callback_upvr.Check.Visible = false

			TextBox_upvr_3.Text = arg1:sanitizeClanTag(Text_2)

		end

	end)

	local Tag_upvr = Steps_upvr['3'].Main.Tag

	TextBox_upvr_3.FocusLost:Connect(function() -- Line 1233

		--[[ Upvalues[5]:

			[1]: TextBox_upvr_3 (readonly)

			[2]: arg1 (readonly)

			[3]: Callback_upvr (readonly)

			[4]: Tag_upvr (readonly)

			[5]: var9_upvw (copied, read and write)

		]]

		local any_sanitizeClanTag_result1 = arg1:sanitizeClanTag(TextBox_upvr_3.Text)

		if any_sanitizeClanTag_result1 == "" or #any_sanitizeClanTag_result1 < 2 then

			Callback_upvr.Success.Visible = false

			Callback_upvr.Err.Visible = false

			Callback_upvr.Check.Visible = true

			TextBox_upvr_3.Text = ""

			Tag_upvr.Text = ""

		else

			TextBox_upvr_3.Text = "..."

			local any_getTagAvailability_result1, any_getTagAvailability_result2 = var9_upvw:getTagAvailability(any_sanitizeClanTag_result1)

			local var632 = '['..any_sanitizeClanTag_result1..']'

			if any_getTagAvailability_result2 == "tagFiltered" then

				var632 = '['..any_sanitizeClanTag_result1:gsub('.', '#')..']'

			end

			TextBox_upvr_3.Text = var632

			Tag_upvr.Text = var632

			Callback_upvr.Success.Visible = any_getTagAvailability_result1

			Callback_upvr.Err.Visible = not any_getTagAvailability_result1

			arg1:setCreateClanData("tag", any_sanitizeClanTag_result1)

		end

	end)

	TextBox_upvr_7.FocusLost:Connect(function() -- Line 1266

		--[[ Upvalues[3]:

			[1]: TextBox_upvr_7 (readonly)

			[2]: Main_14_upvr (readonly)

			[3]: arg1 (readonly)

		]]

		local Text = TextBox_upvr_7.Text

		if Text == "" then

		else

			if not tonumber(Text) then return end

			Main_14_upvr.ClanIcon.ImageContainer.Image = "rbxassetid://"..Text

			Main_14_upvr.ClanIcon.ImageContainer.Visible = true

			Main_14_upvr.ClanIcon.SearchIcon.Visible = false

			arg1:setCreateClanData("image", tonumber(Text))

		end

	end)

end

function any_new_result1_3.setupSettings(arg1) -- Line 1283

	--[[ Upvalues[3]:

		[1]: TextBox_upvr_2 (readonly)

		[2]: TextBox_upvr_4 (readonly)

		[3]: Icon_upvr (readonly)

	]]

	TextBox_upvr_2:GetPropertyChangedSignal("Text"):Connect(function() -- Line 1284

		--[[ Upvalues[1]:

			[1]: TextBox_upvr_2 (copied, readonly)

		]]

		local Text_3 = TextBox_upvr_2.Text

		if 60 < #Text_3 then

			Text_3 = Text_3:sub(1, 60)

		end

		TextBox_upvr_2.Text = Text_3

	end)

	TextBox_upvr_4.FocusLost:Connect(function() -- Line 1293

		--[[ Upvalues[3]:

			[1]: TextBox_upvr_4 (copied, readonly)

			[2]: Icon_upvr (copied, readonly)

			[3]: arg1 (readonly)

		]]

		local Text_5 = TextBox_upvr_4.Text

		if Text_5 == "" then

		else

			if not tonumber(Text_5) then return end

			Icon_upvr.Image = "rbxassetid://"..Text_5

			arg1._selectedImage = tonumber(Text_5)

		end

	end)

end

function any_new_result1_3.setupItemDonatePrompt(arg1) -- Line 1308

	--[[ Upvalues[3]:

		[1]: TextBox_upvr_5 (readonly)

		[2]: var4_upvw (read and write)

		[3]: var12_upvw (read and write)

	]]

	TextBox_upvr_5:GetPropertyChangedSignal("Text"):Connect(function() -- Line 1309

		--[[ Upvalues[4]:

			[1]: var4_upvw (copied, read and write)

			[2]: var12_upvw (copied, read and write)

			[3]: arg1 (readonly)

			[4]: TextBox_upvr_5 (copied, readonly)

		]]

		local any_getItemFromId_result1 = var12_upvw.itemUtils.getItemFromId(var4_upvw:getData(), arg1._donateItemId)

		local var641 = tonumber(TextBox_upvr_5.Text)

		if not var641 or var641 <= 0 then

			TextBox_upvr_5.Text = ""

		else

			if any_getItemFromId_result1:getAmount() < var641 then

				var641 = any_getItemFromId_result1:getAmount()

			end

			TextBox_upvr_5.Text = var641

		end
		end

	end)

end

function any_new_result1_3.setupRebirthPrompt(arg1) -- Line 1329

	--[[ Upvalues[2]:

		[1]: TextBox_upvr_9 (readonly)

		[2]: var13_upvw (read and write)

	]]

	TextBox_upvr_9:GetPropertyChangedSignal("Text"):Connect(function() -- Line 1330

		--[[ Upvalues[2]:

			[1]: TextBox_upvr_9 (copied, readonly)

			[2]: var13_upvw (copied, read and write)

		]]

		if not TextBox_upvr_9:IsFocused() then

		else

			local any_suffixToNumber_result1_2 = var13_upvw.suffixToNumber(TextBox_upvr_9.Text)

			if not tonumber(any_suffixToNumber_result1_2) or tonumber(any_suffixToNumber_result1_2) <= 0 then

				TextBox_upvr_9.Text = ""

				return

			end

		end

	end)

	TextBox_upvr_9.FocusLost:Connect(function() -- Line 1343

		--[[ Upvalues[3]:

			[1]: var13_upvw (copied, read and write)

			[2]: TextBox_upvr_9 (copied, readonly)

			[3]: arg1 (readonly)

		]]

		local any_suffixToNumber_result1 = var13_upvw.suffixToNumber(TextBox_upvr_9.Text)

		if not any_suffixToNumber_result1 then

			TextBox_upvr_9.Text = ""

		else

			TextBox_upvr_9.Text = var13_upvw.suffixes(any_suffixToNumber_result1)

			arg1._requestRebirths = any_suffixToNumber_result1

		end

	end)

end

function any_new_result1_3.setupQuestionPrompt(arg1) -- Line 1355

	--[[ Upvalues[1]:

		[1]: TextBox_upvr_6 (readonly)

	]]

	TextBox_upvr_6:GetPropertyChangedSignal("Text"):Connect(function() -- Line 1356

		--[[ Upvalues[1]:

			[1]: TextBox_upvr_6 (copied, readonly)

		]]

		if not TextBox_upvr_6:IsFocused() then return end

	end)

	TextBox_upvr_6.FocusLost:Connect(function() -- Line 1362

		--[[ Upvalues[2]:

			[1]: arg1 (readonly)

			[2]: TextBox_upvr_6 (copied, readonly)

		]]

		arg1[`_requestQuestion{arg1._questionId}`] = TextBox_upvr_6.Text

	end)

end

function any_new_result1_3.setupRequestInputs(arg1) -- Line 1367

	--[[ Upvalues[3]:

		[1]: TextBox_upvr (readonly)

		[2]: var9_upvw (read and write)

		[3]: TextBox_upvr_8 (readonly)

	]]

	TextBox_upvr.FocusLost:Connect(function() -- Line 1368

		--[[ Upvalues[2]:

			[1]: TextBox_upvr (copied, readonly)

			[2]: var9_upvw (copied, read and write)

		]]

		TextBox_upvr.Text = var9_upvw:filter(TextBox_upvr.Text)

	end)

	TextBox_upvr_8.FocusLost:Connect(function() -- Line 1371

		--[[ Upvalues[2]:

			[1]: TextBox_upvr (copied, readonly)

			[2]: var9_upvw (copied, read and write)

		]]

		TextBox_upvr.Text = var9_upvw:filter(TextBox_upvr.Text)

	end)

end

function any_new_result1_3.setupImages(arg1) -- Line 1376

	--[[ Upvalues[9]:

		[1]: Steps_upvr (readonly)

		[2]: var16_upvw (read and write)

		[3]: Clans_upvr (readonly)

		[4]: ChangeClanIcon_upvr (readonly)

		[5]: var11_upvw (read and write)

		[6]: CreateClan_upvr (readonly)

		[7]: Icon_upvr (readonly)

		[8]: TextBox_upvr_4 (readonly)

		[9]: ClanSettings_upvr (readonly)

	]]

	local Main_3_upvr = Steps_upvr['2'].Main

	for _, v_12_upvr in var16_upvw do

		local clone = Clans_upvr.ClanIcon:Clone()

		clone.ImageContainer.Image = "rbxassetid://"..v_12_upvr

		clone.Visible = true

		clone.Parent = ChangeClanIcon_upvr

		var11_upvw.new(clone.ImageContainer, clone.Click):buttonUp(function() -- Line 1389

			--[[ Upvalues[7]:

				[1]: arg1 (readonly)

				[2]: Main_3_upvr (readonly)

				[3]: v_12_upvr (readonly)

				[4]: CreateClan_upvr (copied, readonly)

				[5]: Icon_upvr (copied, readonly)

				[6]: TextBox_upvr_4 (copied, readonly)

				[7]: ClanSettings_upvr (copied, readonly)

			]]

			arg1:hideOtherClanFrames()

			if arg1._selectImageState == "create" then

				Main_3_upvr.ClanIcon.ImageContainer.Image = "rbxassetid://"..v_12_upvr

				Main_3_upvr.ClanIcon.ImageContainer.Visible = true

				Main_3_upvr.ClanIcon.SearchIcon.Visible = false

				Main_3_upvr.InputImage.TextBox.Text = v_12_upvr

				CreateClan_upvr.Visible = true

				arg1:setCreateClanData("image", v_12_upvr)

			elseif arg1._selectImageState == "edit" then

				Icon_upvr.Image = "rbxassetid://"..v_12_upvr

				TextBox_upvr_4.Text = v_12_upvr

				ClanSettings_upvr.Visible = true

			end

			arg1._selectedImage = v_12_upvr

		end)

	end

end

function any_new_result1_3.hideOtherClanFrames(arg1) -- Line 1413

	--[[ Upvalues[2]:

		[1]: List_upvr_2 (readonly)

		[2]: PromptFrames_upvr (readonly)

	]]

	for _, v_13 in List_upvr_2:GetChildren() do

		v_13.Visible = false

	end

	for _, v_14 in PromptFrames_upvr:GetChildren() do

		v_14.Visible = false

	end

end

function any_new_result1_3.tooltips(arg1) -- Line 1422

	--[[ Upvalues[3]:

		[1]: var5_upvw (read and write)

		[2]: Numbers_upvr_2 (readonly)

		[3]: Numbers_upvr (readonly)

	]]

	var5_upvw:createTooltipOnHover(Numbers_upvr_2.BestMap.Icon.Click, "Best Map")

	var5_upvw:createTooltipOnHover(Numbers_upvr_2.EggsOpened.Icon.Click, "Eggs Opened")

	var5_upvw:createTooltipOnHover(Numbers_upvr_2.Joined.Icon.Click, "Date Joined")

	var5_upvw:createTooltipOnHover(Numbers_upvr_2.PetEquip.Icon.Click, "Max Pets Equipped")

	var5_upvw:createTooltipOnHover(Numbers_upvr_2.Rebirths.Icon.Click, "Rebirths")

	var5_upvw:createTooltipOnHover(Numbers_upvr_2.TimePlayed.Icon.Click, "Time Played")

	var5_upvw:createTooltipOnHover(Numbers_upvr.BestMap.Icon.Click, "Best Map")

	var5_upvw:createTooltipOnHover(Numbers_upvr.EggsOpened.Icon.Click, "Eggs Opened")

	var5_upvw:createTooltipOnHover(Numbers_upvr.Joined.Icon.Click, "Date Joined")

	var5_upvw:createTooltipOnHover(Numbers_upvr.PetEquip.Icon.Click, "Max Pets Equipped")

	var5_upvw:createTooltipOnHover(Numbers_upvr.Rebirths.Icon.Click, "Rebirths")

	var5_upvw:createTooltipOnHover(Numbers_upvr.TimePlayed.Icon.Click, "Time Played")

end

local Buttons_upvr_3 = ClanSettings_upvr:WaitForChild("Buttons")

local Buttons_upvr_2 = ClanPlayerRequest_upvr:WaitForChild("Buttons")

local Buttons_upvr_4 = ClanPlayerApplication_upvr:WaitForChild("Buttons")

function any_new_result1_3.buttons(arg1) -- Line 1438

	--[[ Upvalues[44]:

		[1]: var11_upvw (read and write)

		[2]: List_upvr (readonly)

		[3]: Clans_upvr_2 (readonly)

		[4]: var5_upvw (read and write)

		[5]: CheckYourClan_upvr (readonly)

		[6]: Invites_upvr (readonly)

		[7]: ClanInventory_upvr (readonly)

		[8]: var8_upvw (read and write)

		[9]: CreateClan_upvr (readonly)

		[10]: var7_upvw (read and write)

		[11]: ChangeClanIcon_upvr (readonly)

		[12]: var4_upvw (read and write)

		[13]: var13_upvw (read and write)

		[14]: var18_upvw (read and write)

		[15]: ClansFrame_upvr (readonly)

		[16]: Dark_upvr (readonly)

		[17]: var9_upvw (read and write)

		[18]: var6_upvw (read and write)

		[19]: Buttons_upvr (readonly)

		[20]: var14_upvw (read and write)

		[21]: ClanInvites_upvr (readonly)

		[22]: Main_5_upvr (readonly)

		[23]: ClanSettings_upvr (readonly)

		[24]: ClanIcon_upvr (readonly)

		[25]: State_upvr_2 (readonly)

		[26]: TextBox_upvr_9 (readonly)

		[27]: RebirthPrompt_upvr (readonly)

		[28]: State_upvr (readonly)

		[29]: TextBox_upvr_6 (readonly)

		[30]: QuestionPrompt_upvr (readonly)

		[31]: State_upvr_3 (readonly)

		[32]: Buttons_upvr_3 (readonly)

		[33]: TextBox_upvr_2 (readonly)

		[34]: TextBox_upvr_4 (readonly)

		[35]: ItemDonatePrompt_upvr (readonly)

		[36]: TextBox_upvr_5 (readonly)

		[37]: ClanItemConfirmation_upvr (readonly)

		[38]: Holder_upvr (readonly)

		[39]: Main_9_upvr (readonly)

		[40]: ClanPlayerRequest_upvr (readonly)

		[41]: Buttons_upvr_2 (readonly)

		[42]: TextBox_upvr (readonly)

		[43]: TextBox_upvr_8 (readonly)

		[44]: Buttons_upvr_4 (readonly)

	]]

	var11_upvw.new(List_upvr.Clans):buttonUp(function() -- Line 1441

		--[[ Upvalues[2]:

			[1]: arg1 (readonly)

			[2]: Clans_upvr_2 (copied, readonly)

		]]

		if arg1._buttonsDisabled then

		else

			arg1._buttonsDisabled = true

			arg1:hideOtherClanFrames()

			arg1:updateTopClans()

			Clans_upvr_2.Visible = true

			arg1._buttonsDisabled = false

		end

	end)

	var5_upvw:createTooltipOnHover(List_upvr.Clans, "Top Clans")

	var11_upvw.new(List_upvr.YourClan):buttonUp(function() -- Line 1456

		--[[ Upvalues[2]:

			[1]: arg1 (readonly)

			[2]: CheckYourClan_upvr (copied, readonly)

		]]

		if arg1._buttonsDisabled then

		else

			arg1._buttonsDisabled = true

			arg1:hideOtherClanFrames()

			arg1:updateYourClan()

			CheckYourClan_upvr.Visible = true

			arg1._buttonsDisabled = false

		end

	end)

	var5_upvw:createTooltipOnHover(List_upvr.YourClan, "Your Clan")

	var11_upvw.new(List_upvr.Invites):buttonUp(function() -- Line 1471

		--[[ Upvalues[2]:

			[1]: arg1 (readonly)

			[2]: Invites_upvr (copied, readonly)

		]]

		if arg1._buttonsDisabled then

		else

			arg1._buttonsDisabled = true

			arg1:hideOtherClanFrames()

			arg1:updateYourInvites()

			Invites_upvr.Visible = true

			arg1._buttonsDisabled = false

		end

	end)

	var5_upvw:createTooltipOnHover(List_upvr.Invites, "Invites")

	var11_upvw.new(List_upvr.Inventory):buttonUp(function() -- Line 1486

		--[[ Upvalues[2]:

			[1]: arg1 (readonly)

			[2]: ClanInventory_upvr (copied, readonly)

		]]

		if arg1._buttonsDisabled then

		else

			arg1._buttonsDisabled = true

			arg1:hideOtherClanFrames()

			arg1:updateClanInventory()

			ClanInventory_upvr.Visible = true

			arg1._buttonsDisabled = false

		end

	end)

	var5_upvw:createTooltipOnHover(List_upvr.Inventory, "Inventory")

	var11_upvw.new(Invites_upvr.CreateYourOwnClan.Main.Create):buttonUp(function() -- Line 1502

		--[[ Upvalues[5]:

			[1]: var8_upvw (copied, read and write)

			[2]: var5_upvw (copied, read and write)

			[3]: arg1 (readonly)

			[4]: CreateClan_upvr (copied, readonly)

			[5]: var7_upvw (copied, read and write)

		]]

		if var8_upvw:getFFlag("clansCreate") == false then

			var5_upvw:createMessagePopup({

				fFlagDisabled = true;

				reOpen = "ClansFrame";

			})

		else

			arg1:hideOtherClanFrames()

			arg1:openCategory("create")

			CreateClan_upvr.Visible = true

			var7_upvw:setIsCreating(true)

		end

	end)

	var11_upvw.new(CreateClan_upvr.Steps['2'].Main.ClanIcon):buttonUp(function() -- Line 1515

		--[[ Upvalues[2]:

			[1]: arg1 (readonly)

			[2]: ChangeClanIcon_upvr (copied, readonly)

		]]

		arg1:hideOtherClanFrames()

		arg1._selectImageState = "create"

		ChangeClanIcon_upvr.Visible = true

	end)

	var11_upvw.new(CreateClan_upvr.Steps['3'].Main.Cancel):buttonUp(function() -- Line 1522

		--[[ Upvalues[3]:

			[1]: arg1 (readonly)

			[2]: Invites_upvr (copied, readonly)

			[3]: var7_upvw (copied, read and write)

		]]

		arg1:hideOtherClanFrames()

		arg1:resetCreateClan()

		arg1:openCategory("invites")

		Invites_upvr.Visible = true

		var7_upvw:setIsCreating(false)

	end)

	var11_upvw.new(CreateClan_upvr.Steps['3'].Main.Buy):buttonUp(function() -- Line 1532

		--[[ Upvalues[11]:

			[1]: arg1 (readonly)

			[2]: var4_upvw (copied, read and write)

			[3]: var5_upvw (copied, read and write)

			[4]: var13_upvw (copied, read and write)

			[5]: var18_upvw (copied, read and write)

			[6]: ClansFrame_upvr (copied, readonly)

			[7]: Dark_upvr (copied, readonly)

			[8]: var9_upvw (copied, read and write)

			[9]: var6_upvw (copied, read and write)

			[10]: CheckYourClan_upvr (copied, readonly)

			[11]: var7_upvw (copied, read and write)

		]]


		if arg1._buttonsDisabled then

		else

			if not arg1._createClan then return end

			if not arg1._createClan.tag then return end

			if not arg1._createClan.image then return end

			local any_getData_result1_3 = var4_upvw:getData()

			if any_getData_result1_3.gems < 1000000000 then

				var5_upvw:createMessagePopup({

					message = `You need {var13_upvw.suffixes(1000000000 - any_getData_result1_3.gems)} more gems to create a clan!`;

					reOpen = "ClansFrame";

				})

				return

			end

			local any_new_result1_upvr = var18_upvw.new(ClansFrame_upvr)

			any_new_result1_upvr:run()

			Dark_upvr.Visible = true

			arg1._buttonsDisabled = true

			local any_createClan_result1, _ = var9_upvw:createClan(arg1._createClan.tag, arg1._createClan.image or 16987069167)

			if any_createClan_result1 == "success" then

				task.delay(0.5, function() -- Line 1565

					--[[ Upvalues[6]:

						[1]: var6_upvw (copied, read and write)

						[2]: arg1 (copied, readonly)

						[3]: Dark_upvr (copied, readonly)

						[4]: any_new_result1_upvr (readonly)

						[5]: CheckYourClan_upvr (copied, readonly)

						[6]: var7_upvw (copied, read and write)

					]]

					var6_upvw:play("Create Clan")

					arg1:hideOtherClanFrames()

					arg1:resetCreateClan()

					Dark_upvr.Visible = false

					arg1._buttonsDisabled = false

					any_new_result1_upvr:remove()

					CheckYourClan_upvr.Visible = true

					arg1:updateYourClan(true)

					var7_upvw:setIsCreating(false)

				end)

				return

			end

			if any_createClan_result1 == "invalidTag" then

				var5_upvw:createMessagePopup({

					message = "Tag ["..arg1._createClan.tag.."] is no longer available!";

					reOpen = "ClansFrame";

				})

			elseif any_createClan_result1 == "debounce" then

				var5_upvw:createMessagePopup({

					message = "You're doing this too fast!";

					reOpen = "ClansFrame";

				})

			else

				var5_upvw:createMessagePopup({

					message = `Something went wrong, please try again! ({any_createClan_result1})`;

					reOpen = "ClansFrame";

				})

			end

			Dark_upvr.Visible = false

			arg1._buttonsDisabled = false

			any_new_result1_upvr:remove()

		end

	end)

	var11_upvw.new(Buttons_upvr.Invite):buttonUp(function() -- Line 1604

		--[[ Upvalues[4]:

			[1]: var8_upvw (copied, read and write)

			[2]: var5_upvw (copied, read and write)

			[3]: var14_upvw (copied, read and write)

			[4]: arg1 (readonly)

		]]

		if var8_upvw:getFFlag("clansInvite") == false then

			var5_upvw:createMessagePopup({

				fFlagDisabled = true;

				reOpen = "ClansFrame";

			})

		else

			local canModify = table.find(var14_upvw.allowedToModify, arg1._yourClanStored.rank)

			if not canModify then return end

			if arg1._buttonsDisabled then return end

			var5_upvw:openFrame("ClansInviteFrame")

		end

	end)

	var11_upvw.new(Buttons_upvr.Invites):buttonUp(function() -- Line 1622

		--[[ Upvalues[5]:

			[1]: var8_upvw (copied, read and write)

			[2]: var5_upvw (copied, read and write)

			[3]: var14_upvw (copied, read and write)

			[4]: arg1 (readonly)

			[5]: ClanInvites_upvr (copied, readonly)

		]]

		if var8_upvw:getFFlag("clansInvites") == false then

			var5_upvw:createMessagePopup({

				fFlagDisabled = true;

				reOpen = "ClansFrame";

			})

		else

			local canModify = table.find(var14_upvw.allowedToModify, arg1._yourClanStored.rank)

			if not canModify then return end

			if arg1._buttonsDisabled then return end

			arg1:hideOtherClanFrames()

			arg1:updateClansInvites()

			ClanInvites_upvr.Visible = true

		end

	end)

	var11_upvw.new(Buttons_upvr.Leave):buttonUp(function() -- Line 1641

		--[[ Upvalues[5]:

			[1]: var8_upvw (copied, read and write)

			[2]: var5_upvw (copied, read and write)

			[3]: arg1 (readonly)

			[4]: var13_upvw (copied, read and write)

			[5]: var7_upvw (copied, read and write)

		]]

		if var8_upvw:getFFlag("clansLeave") == false then

			var5_upvw:createMessagePopup({

				fFlagDisabled = true;

				reOpen = "ClansFrame";

			})

		else

			if arg1._buttonsDisabled then return end

			arg1._buttonsDisabled = true

			if arg1._yourClanStored.rank == 1 and 1 < var13_upvw.getAmountInTable(arg1._yourClanStored.data.members) then

				var5_upvw:createMessagePopup({

					message = "You need to kick all members in order to leave!";

					reOpen = "ClansFrame";

				})

				arg1._buttonsDisabled = false

				return

			end

			var7_upvw:setConfirmData({

				confirmType = "leave";

			})

			var5_upvw:openFrame("ClansConfirmFrame")

			arg1._buttonsDisabled = false

		end

	end)

	var11_upvw.new(Main_5_upvr.ClanSettings):buttonUp(function() -- Line 1674

		--[[ Upvalues[3]:

			[1]: var14_upvw (copied, read and write)

			[2]: arg1 (readonly)

			[3]: ClanSettings_upvr (copied, readonly)

		]]

		if not table.find(var14_upvw.allowedToModify, arg1._yourClanStored.rank) then

		else

			if arg1._buttonsDisabled then return end

			arg1:hideOtherClanFrames()

			arg1:updateClanSettings()

			ClanSettings_upvr.Visible = true

		end

	end)

	var11_upvw.new(ClanIcon_upvr):buttonUp(function() -- Line 1689

		--[[ Upvalues[2]:

			[1]: arg1 (readonly)

			[2]: ChangeClanIcon_upvr (copied, readonly)

		]]

		arg1:hideOtherClanFrames()

		arg1._selectImageState = "edit"

		ChangeClanIcon_upvr.Visible = true

	end)

	var11_upvw.new(State_upvr_2):buttonUp(function() -- Line 1696

		--[[ Upvalues[3]:

			[1]: TextBox_upvr_9 (copied, readonly)

			[2]: RebirthPrompt_upvr (copied, readonly)

			[3]: Dark_upvr (copied, readonly)

		]]

		TextBox_upvr_9.Text = ""

		RebirthPrompt_upvr.Visible = true

		Dark_upvr.Visible = true

	end)

	var11_upvw.new(RebirthPrompt_upvr.Confirm):buttonUp(function() -- Line 1703

		--[[ Upvalues[5]:

			[1]: arg1 (readonly)

			[2]: Dark_upvr (copied, readonly)

			[3]: RebirthPrompt_upvr (copied, readonly)

			[4]: State_upvr_2 (copied, readonly)

			[5]: var13_upvw (copied, read and write)

		]]

		if not arg1._requestRebirths then

		else

			Dark_upvr.Visible = false

			RebirthPrompt_upvr.Visible = false

			State_upvr_2.OFF.Visible = false

			State_upvr_2.Required.Visible = true

			State_upvr_2.Required.Label.Text = `{var13_upvw.suffixes(arg1._requestRebirths)}+ Rebirths`

		end

	end)

	var11_upvw.new(RebirthPrompt_upvr.Cancel):buttonUp(function() -- Line 1717

		--[[ Upvalues[4]:

			[1]: Dark_upvr (copied, readonly)

			[2]: RebirthPrompt_upvr (copied, readonly)

			[3]: State_upvr_2 (copied, readonly)

			[4]: arg1 (readonly)

		]]

		Dark_upvr.Visible = false

		RebirthPrompt_upvr.Visible = false

		State_upvr_2.OFF.Visible = true

		State_upvr_2.Required.Visible = false

		arg1._requestRebirths = false

	end)

	var11_upvw.new(State_upvr):buttonUp(function() -- Line 1728

		--[[ Upvalues[4]:

			[1]: arg1 (readonly)

			[2]: TextBox_upvr_6 (copied, readonly)

			[3]: QuestionPrompt_upvr (copied, readonly)

			[4]: Dark_upvr (copied, readonly)

		]]

		arg1._questionId = 1

		TextBox_upvr_6.Text = arg1._storedQuestion1 or ""

		QuestionPrompt_upvr.Visible = true

		Dark_upvr.Visible = true

	end)

	var11_upvw.new(State_upvr_3):buttonUp(function() -- Line 1737

		--[[ Upvalues[4]:

			[1]: arg1 (readonly)

			[2]: TextBox_upvr_6 (copied, readonly)

			[3]: QuestionPrompt_upvr (copied, readonly)

			[4]: Dark_upvr (copied, readonly)

		]]

		arg1._questionId = 2

		TextBox_upvr_6.Text = arg1._storedQuestion2 or ""

		QuestionPrompt_upvr.Visible = true

		Dark_upvr.Visible = true

	end)

	var11_upvw.new(QuestionPrompt_upvr.Confirm):buttonUp(function() -- Line 1746

		--[[ Upvalues[6]:

			[1]: Dark_upvr (copied, readonly)

			[2]: QuestionPrompt_upvr (copied, readonly)

			[3]: arg1 (readonly)

			[4]: State_upvr (copied, readonly)

			[5]: State_upvr_3 (copied, readonly)

			[6]: TextBox_upvr_6 (copied, readonly)

		]]

		Dark_upvr.Visible = false

		QuestionPrompt_upvr.Visible = false

		if not arg1[`_requestQuestion{arg1._questionId}`] then

		else

			local var706 = State_upvr

			if arg1._questionId == 2 then

				var706 = State_upvr_3

			end

			var706.OFF.Visible = false

			var706.Edit.Visible = true

			arg1[`_storedQuestion{arg1._questionId}`] = TextBox_upvr_6.Text

		end

	end)

	var11_upvw.new(QuestionPrompt_upvr.Cancel):buttonUp(function() -- Line 1766

		--[[ Upvalues[5]:

			[1]: Dark_upvr (copied, readonly)

			[2]: QuestionPrompt_upvr (copied, readonly)

			[3]: State_upvr (copied, readonly)

			[4]: arg1 (readonly)

			[5]: State_upvr_3 (copied, readonly)

		]]

		Dark_upvr.Visible = false

		QuestionPrompt_upvr.Visible = false

		local var708 = State_upvr

		if arg1._questionId == 2 then

			var708 = State_upvr_3

		end

		var708.OFF.Visible = true

		var708.Edit.Visible = false

		arg1[`_requestQuestion{arg1._questionId}`] = false

	end)

	var11_upvw.new(Buttons_upvr_3.Apply):buttonUp(function() -- Line 1782

		--[[ Upvalues[10]:

			[1]: var8_upvw (copied, read and write)

			[2]: var5_upvw (copied, read and write)

			[3]: arg1 (readonly)

			[4]: var18_upvw (copied, read and write)

			[5]: ClansFrame_upvr (copied, readonly)

			[6]: Dark_upvr (copied, readonly)

			[7]: TextBox_upvr_2 (copied, readonly)

			[8]: TextBox_upvr_4 (copied, readonly)

			[9]: var9_upvw (copied, read and write)

			[10]: CheckYourClan_upvr (copied, readonly)

		]]


		if var8_upvw:getFFlag("clansUpdate") == false then

			var5_upvw:createMessagePopup({

				fFlagDisabled = true;

				reOpen = "ClansFrame";

			})

			return

		end

		if arg1._buttonsDisabled then return end

		var18_upvw.new(ClansFrame_upvr):run()

		Dark_upvr.Visible = true

		arg1._buttonsDisabled = true

		local any_updateClan_result1 = var9_upvw:updateClan(TextBox_upvr_2.Text, tonumber(TextBox_upvr_4.Text) or 16987069167, arg1._requestRebirths, arg1._requestQuestion1, arg1._requestQuestion2)

		if any_updateClan_result1 == "success" then

			arg1._requestRebirths = nil

			arg1._requestQuestion1 = nil

			arg1._requestQuestion2 = nil

			arg1._storedQuestion1 = nil

			arg1._storedQuestion2 = nil

			arg1:hideOtherClanFrames()

			arg1:updateYourClan(true)

			CheckYourClan_upvr.Visible = true

			Dark_upvr.Visible = false

			arg1._buttonsDisabled = false

			return

		end

		if any_updateClan_result1 == "filtered" then

			var5_upvw:createMessagePopup({

				message = "Your question was filtered! Please try again";

				reOpen = "ClansFrame";

			})

		else

			var5_upvw:createMessagePopup({

				message = `Something went wrong, please try again! ({any_updateClan_result1})`;

				reOpen = "ClansFrame";

			})

		end

		Dark_upvr.Visible = false

		arg1._buttonsDisabled = false

	end)

	var11_upvw.new(Buttons_upvr_3.Cancel):buttonUp(function() -- Line 1831

		--[[ Upvalues[2]:

			[1]: arg1 (readonly)

			[2]: CheckYourClan_upvr (copied, readonly)

		]]

		if arg1._buttonsDisabled then

		else

			arg1._requestRebirths = nil

			arg1._requestQuestion1 = nil

			arg1._requestQuestion2 = nil

			arg1._storedQuestion1 = nil

			arg1._storedQuestion2 = nil

			arg1:hideOtherClanFrames()

			CheckYourClan_upvr.Visible = true

		end

	end)

	var11_upvw.new(ClanInventory_upvr.Donate):buttonUp(function() -- Line 1847

		--[[ Upvalues[4]:

			[1]: var8_upvw (copied, read and write)

			[2]: var5_upvw (copied, read and write)

			[3]: arg1 (readonly)

			[4]: ClanInventory_upvr (copied, readonly)

		]]

		if var8_upvw:getFFlag("clansDonate") == false then

			var5_upvw:createMessagePopup({

				fFlagDisabled = true;

				reOpen = "ClansFrame";

			})

		else

			if arg1._buttonsDisabled then return end

			arg1:updateClanInventory(true)

			ClanInventory_upvr.Visible = true

		end

	end)

	var11_upvw.new(ClanInventory_upvr.Cancel):buttonUp(function() -- Line 1862

		--[[ Upvalues[2]:

			[1]: arg1 (readonly)

			[2]: ClanInventory_upvr (copied, readonly)

		]]

		arg1:updateClanInventory()

		ClanInventory_upvr.Visible = true

	end)

	var11_upvw.new(ItemDonatePrompt_upvr.Confirm):buttonUp(function() -- Line 1868

		--[[ Upvalues[4]:

			[1]: arg1 (readonly)

			[2]: TextBox_upvr_5 (copied, readonly)

			[3]: ClanItemConfirmation_upvr (copied, readonly)

			[4]: Dark_upvr (copied, readonly)

		]]

		if arg1._buttonsDisabled then

		else

			if not tonumber(TextBox_upvr_5.Text) then return end

			arg1:updateClanItemConfirmation()

			arg1:hideOtherClanFrames()

			ClanItemConfirmation_upvr.Visible = true

			Dark_upvr.Visible = false

		end

	end)

	var11_upvw.new(ItemDonatePrompt_upvr.Cancel):buttonUp(function() -- Line 1882

		--[[ Upvalues[3]:

			[1]: Dark_upvr (copied, readonly)

			[2]: ItemDonatePrompt_upvr (copied, readonly)

			[3]: Holder_upvr (copied, readonly)

		]]

		Dark_upvr.Visible = false

		ItemDonatePrompt_upvr.Visible = false

		Holder_upvr.Visible = true

	end)

	var11_upvw.new(ClanItemConfirmation_upvr.Confirm):buttonUp(function() -- Line 1889

		--[[ Upvalues[9]:

			[1]: arg1 (readonly)

			[2]: var18_upvw (copied, read and write)

			[3]: ClansFrame_upvr (copied, readonly)

			[4]: Dark_upvr (copied, readonly)

			[5]: TextBox_upvr_5 (copied, readonly)

			[6]: var9_upvw (copied, read and write)

			[7]: var6_upvw (copied, read and write)

			[8]: ClanInventory_upvr (copied, readonly)

			[9]: var5_upvw (copied, read and write)

		]]


		if arg1._buttonsDisabled then return end

		var18_upvw.new(ClansFrame_upvr):run()

		Dark_upvr.Visible = true

		arg1._buttonsDisabled = true

		local any_donateItem_result1 = var9_upvw:donateItem(arg1._donateItemId, tonumber(TextBox_upvr_5.Text))

		if any_donateItem_result1 == "success" then

			var6_upvw:play("Clan Donate Item")

			arg1:hideOtherClanFrames()

			arg1:updateClanInventory()

			ClanInventory_upvr.Visible = true

			Dark_upvr.Visible = false

			arg1._buttonsDisabled = false

			return

		end

		if any_donateItem_result1 == "debounce" then

			var5_upvw:createMessagePopup({

				message = "You're doing this too fast!";

				reOpen = "ClansFrame";

			})

		else

			var5_upvw:createMessagePopup({

				message = `Something went wrong, please try again! ({any_donateItem_result1})`;

				reOpen = "ClansFrame";

			})

		end

		Dark_upvr.Visible = false

		arg1._buttonsDisabled = false

	end)

	var11_upvw.new(ClanItemConfirmation_upvr.Cancel):buttonUp(function() -- Line 1929

		--[[ Upvalues[2]:

			[1]: arg1 (readonly)

			[2]: ClanInventory_upvr (copied, readonly)

		]]

		if arg1._buttonsDisabled then

		else

			arg1:hideOtherClanFrames()

			arg1:updateClanInventory()

			ClanInventory_upvr.Visible = true

		end

	end)

	var11_upvw.new(Main_9_upvr.RequestJoin):buttonUp(function() -- Line 1940

		--[[ Upvalues[2]:

			[1]: arg1 (readonly)

			[2]: ClanPlayerRequest_upvr (copied, readonly)

		]]

		if arg1._buttonsDisabled then

		else

			arg1:hideOtherClanFrames()

			arg1:updateClanPlayerRequest()

			ClanPlayerRequest_upvr.Visible = true

		end

	end)

	var11_upvw.new(Main_9_upvr.RequestRequired):buttonUp(function() -- Line 1951

	end)

	var11_upvw.new(Buttons_upvr_2.Send):buttonUp(function() -- Line 1956

		--[[ Upvalues[10]:

			[1]: arg1 (readonly)

			[2]: var18_upvw (copied, read and write)

			[3]: ClansFrame_upvr (copied, readonly)

			[4]: Dark_upvr (copied, readonly)

			[5]: var9_upvw (copied, read and write)

			[6]: TextBox_upvr (copied, readonly)

			[7]: TextBox_upvr_8 (copied, readonly)

			[8]: var6_upvw (copied, read and write)

			[9]: var5_upvw (copied, read and write)

			[10]: Clans_upvr_2 (copied, readonly)

		]]

		if arg1._buttonsDisabled then

		else

			local any_new_result1_6 = var18_upvw.new(ClansFrame_upvr)

			any_new_result1_6:run()

			Dark_upvr.Visible = true

			arg1._buttonsDisabled = true

			local any_requestToJoin_result1 = var9_upvw:requestToJoin(arg1._viewClanId, TextBox_upvr.Text, TextBox_upvr_8.Text)

			if any_requestToJoin_result1 == "success" then

				var6_upvw:play("Request Clan", {

					volume = 0.8;

				})

				var5_upvw:createNotification("Default", "You requested to join the clan!")

				arg1:hideOtherClanFrames()

				Clans_upvr_2.Visible = true

				TextBox_upvr.Text = ""

				TextBox_upvr_8.Text = ""

			elseif any_requestToJoin_result1 == "filtered" then

				var5_upvw:createMessagePopup({

					message = "Your question answer was filtered! Please try again";

					reOpen = "ClansFrame";

				})

			else

				var5_upvw:createMessagePopup({

					message = `Something went wrong, please try again! ({any_requestToJoin_result1})`;

					reOpen = "ClansFrame";

				})

			end

			Dark_upvr.Visible = false

			arg1._buttonsDisabled = false

			any_new_result1_6:remove()

		end

	end)

	var11_upvw.new(Buttons_upvr_2.Cancel):buttonUp(function() -- Line 1998

		--[[ Upvalues[2]:

			[1]: arg1 (readonly)

			[2]: Clans_upvr_2 (copied, readonly)

		]]

		if arg1._buttonsDisabled then

		else

			arg1:hideOtherClanFrames()

			Clans_upvr_2.Visible = true

		end

	end)

	var11_upvw.new(Buttons_upvr_4.Invite):buttonUp(function() -- Line 2008

		--[[ Upvalues[8]:

			[1]: arg1 (readonly)

			[2]: var18_upvw (copied, read and write)

			[3]: ClansFrame_upvr (copied, readonly)

			[4]: Dark_upvr (copied, readonly)

			[5]: var9_upvw (copied, read and write)

			[6]: var6_upvw (copied, read and write)

			[7]: ClanInvites_upvr (copied, readonly)

			[8]: var5_upvw (copied, read and write)

		]]


		if arg1._buttonsDisabled then return end

		var18_upvw.new(ClansFrame_upvr):run()

		Dark_upvr.Visible = true

		arg1._buttonsDisabled = true

		local any_acceptRequest_result1 = var9_upvw:acceptRequest(arg1._requestUserId)

		if any_acceptRequest_result1 == "success" then

			var6_upvw:play("Invite To Clan")

			arg1:hideOtherClanFrames()

			arg1:updateClansInvites(true)

			ClanInvites_upvr.Visible = true

			Dark_upvr.Visible = false

			arg1._buttonsDisabled = false

			return

		end

		if any_acceptRequest_result1 == "debounce" then

			var5_upvw:createMessagePopup({

				message = "You're doing this too fast!";

				reOpen = "ClansFrame";

			})

		elseif any_acceptRequest_result1 == "alreadyInClan" then

			var5_upvw:createMessagePopup({

				message = "Player is already in a clan!";

				reOpen = "ClansFrame";

			})

		elseif any_acceptRequest_result1 == "alreadyInvited" then

			var5_upvw:createMessagePopup({

				message = "Player is already invited!";

				reOpen = "ClansFrame";

			})

		elseif any_acceptRequest_result1 == "notUnlocked" then

			var5_upvw:createMessagePopup({

				message = "Player hasn't unlocked the Kingdom map!";

				reOpen = "ClansFrame";

			})

		else

			var5_upvw:createMessagePopup({

				message = `Something went wrong, please try again! ({any_acceptRequest_result1})`;

				reOpen = "ClansFrame";

			})

		end

		Dark_upvr.Visible = false

		arg1._buttonsDisabled = false

	end)

	var11_upvw.new(Buttons_upvr_4.Decline):buttonUp(function() -- Line 2059

		--[[ Upvalues[8]:

			[1]: arg1 (readonly)

			[2]: var18_upvw (copied, read and write)

			[3]: ClansFrame_upvr (copied, readonly)

			[4]: Dark_upvr (copied, readonly)

			[5]: var9_upvw (copied, read and write)

			[6]: var6_upvw (copied, read and write)

			[7]: ClanInvites_upvr (copied, readonly)

			[8]: var5_upvw (copied, read and write)

		]]

		if arg1._buttonsDisabled then

		else

			local any_new_result1_5 = var18_upvw.new(ClansFrame_upvr)

			any_new_result1_5:run()

			Dark_upvr.Visible = true

			arg1._buttonsDisabled = true

			local any_declineRequest_result1 = var9_upvw:declineRequest(arg1._requestUserId)

			if any_declineRequest_result1 == "success" then

				var6_upvw:play("Clan Cancel", {

					volume = 0.3;

				})

				arg1:hideOtherClanFrames()

				arg1:updateClansInvites(true)

				ClanInvites_upvr.Visible = true

			else

				var5_upvw:createMessagePopup({

					message = `Something went wrong, please try again! ({any_declineRequest_result1})`;

					reOpen = "ClansFrame";

				})

			end

			Dark_upvr.Visible = false

			arg1._buttonsDisabled = false

			any_new_result1_5:remove()

		end

	end)

end

function any_new_result1_3.update(arg1) -- Line 2092

	--[[ Upvalues[2]:

		[1]: var4_upvw (read and write)

		[2]: List_upvr (readonly)

	]]

	local var746

	if var4_upvw:getData().clanId == "" then

		var746 = false

	else

		var746 = true

	end

	List_upvr.Invites.Visible = not var746

	List_upvr.YourClan.Visible = var746

	List_upvr.Inventory.Visible = var746

end

function any_new_result1_3.openCategory(arg1, arg2) -- Line 2102

	--[[ Upvalues[2]:

		[1]: var22_upvw (read and write)

		[2]: ClansFrame_upvr (readonly)

	]]

	local var747 = var22_upvw[arg2]

	ClansFrame_upvr.TagIcon.Image = var747.icon

	ClansFrame_upvr.TagIcon.Shadow.Image = var747.icon

	ClansFrame_upvr.TagLabel.Text = var747.name

end

function any_new_result1_3.onSet(arg1) -- Line 2110

	--[[ Upvalues[3]:

		[1]: var4_upvw (read and write)

		[2]: CheckYourClan_upvr (readonly)

		[3]: Invites_upvr (readonly)

	]]

	var4_upvw.replica:OnSet({"clanId"}, function() -- Line 2111

		--[[ Upvalues[2]:

			[1]: CheckYourClan_upvr (copied, readonly)

			[2]: arg1 (readonly)

		]]

		if CheckYourClan_upvr.Visible then

			arg1:updateYourClan()

		end

		arg1:update()

	end)

	var4_upvw.replica:OnSet({"clanInvites"}, function() -- Line 2117

		--[[ Upvalues[2]:

			[1]: Invites_upvr (copied, readonly)

			[2]: arg1 (readonly)

		]]

		if not Invites_upvr.Visible then

		else

			arg1:updateYourInvites()

		end

	end)

end

function any_new_result1_3.opened(arg1) -- Line 2126

	--[[ Upvalues[6]:

		[1]: ClansFrame_upvr (readonly)

		[2]: Dark_upvr (readonly)

		[3]: Clans_upvr_2 (readonly)

		[4]: var7_upvw (read and write)

		[5]: CheckYourClan_upvr (readonly)

		[6]: ClanInvites_upvr (readonly)

	]]

	local _loadingSpinner = ClansFrame_upvr:FindFirstChild("_loadingSpinner")

	if _loadingSpinner then

		_loadingSpinner:Destroy()

		Dark_upvr.Visible = false

	end

	arg1._buttonsDisabled = false

	if Clans_upvr_2.Visible then

		arg1:updateTopClans()

	end

	local any_getForceUpdate_result1 = var7_upvw:getForceUpdate()

	if not any_getForceUpdate_result1 then

	else

		var7_upvw:setForceUpdate(nil)

		if any_getForceUpdate_result1 == "yourClan" then

			arg1:hideOtherClanFrames()

			arg1:updateYourClan(true)

			CheckYourClan_upvr.Visible = true

			return

		end

		if any_getForceUpdate_result1 == "clanInvites" then

			arg1:hideOtherClanFrames()

			arg1:updateClansInvites(true)

			ClanInvites_upvr.Visible = true

			return

		end

		if any_getForceUpdate_result1 == "topClans" then

			arg1:hideOtherClanFrames()

			arg1:updateTopClans()

			Clans_upvr_2.Visible = true

		end

	end

end

function any_new_result1_3.Start(arg1) -- Line 2161

	--[[ Upvalues[3]:

		[1]: Clans_upvr_2 (readonly)

		[2]: var5_upvw (read and write)

		[3]: var6_upvw (read and write)

	]]

	arg1:onSet()

	arg1:update()

	arg1:buttons()

	arg1:tooltips()

	arg1:createYourOwn()

	arg1:setupImages()

	arg1:setupSettings()

	arg1:setupItemDonatePrompt()

	arg1:setupRebirthPrompt()

	arg1:setupQuestionPrompt()

	arg1:setupDonatePrompt()

	arg1:setupRequestInputs()

	arg1:opened()

	arg1:updateTopClans()

	Clans_upvr_2.Visible = true

	var5_upvw:listenToOpen("ClansFrame"):Connect(function() -- Line 2183

		--[[ Upvalues[1]:

			[1]: arg1 (readonly)

		]]

		arg1:opened()

	end)

	var6_upvw:preloadSounds({"Join Clan", "Create Clan", "Clan Donate Item", "Request Clan", "Clan Cancel", "Invite To Clan"})

end

local var756_upvw

function any_new_result1_3.Construct(arg1) -- Line 2197

	--[[ Upvalues[21]:

		[1]: var9_upvw (read and write)

		[2]: Knit_upvr (readonly)

		[3]: var4_upvw (read and write)

		[4]: var5_upvw (read and write)

		[5]: var6_upvw (read and write)

		[6]: var7_upvw (read and write)

		[7]: var8_upvw (read and write)

		[8]: var11_upvw (read and write)

		[9]: var18_upvw (read and write)

		[10]: var14_upvw (read and write)

		[11]: ReplicatedStorage_upvr (readonly)

		[12]: var15_upvw (read and write)

		[13]: var12_upvw (read and write)

		[14]: var13_upvw (read and write)

		[15]: var16_upvw (read and write)

		[16]: var17_upvw (read and write)

		[17]: var756_upvw (read and write)

		[18]: var19_upvw (read and write)

		[19]: var20_upvw (read and write)

		[20]: var21_upvw (read and write)

		[21]: var22_upvw (read and write)

	]]

	var9_upvw = Knit_upvr.GetService("ClanService")

	var4_upvw = Knit_upvr.GetController("DataController")

	var5_upvw = Knit_upvr.GetController("UIController")

	var6_upvw = Knit_upvr.GetController("SoundController")

	var7_upvw = Knit_upvr.GetController("ClanController")

	var8_upvw = Knit_upvr.GetController("FFlagController")

	var11_upvw = require(Knit_upvr.Modules.Button)

	var18_upvw = require(Knit_upvr.Modules.LoadingSpinner)

	var14_upvw = require(ReplicatedStorage_upvr.Shared.List.Clans.Config)

	var15_upvw = require(ReplicatedStorage_upvr.Shared.List.Clans.Ranks)

	var12_upvw = require(ReplicatedStorage_upvr.Shared.Util)

	var13_upvw = require(ReplicatedStorage_upvr.Shared.Functions)

	var16_upvw = require(script.Images)

	var17_upvw = require(script.Colors)

	var756_upvw = require(ReplicatedStorage_upvr.Shared.Items)

	var19_upvw = require(ReplicatedStorage_upvr.Shared.List.Clans.ItemClasses)

	var20_upvw = require(ReplicatedStorage_upvr.Shared.Values)

	var21_upvw = require(ReplicatedStorage_upvr.Shared.List.Maps)

	var22_upvw = require(script.Categories)

	arg1._yourClanStored = {}

end

return any_new_result1_3
