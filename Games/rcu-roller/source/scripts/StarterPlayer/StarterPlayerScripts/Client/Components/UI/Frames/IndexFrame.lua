-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:21:43
-- Luau version 6, Types version 3
-- Time taken: 0.011620 seconds

local Knit_upvr = require(game:GetService("ReplicatedStorage").Packages.Knit)
local any_new_result1 = require(Knit_upvr.Util.Component).new({
	Tag = "IndexFrame";
	_isShowingMissing = false;
	_currentSection = "";
})
local var4_upvw
local var5_upvw
local var6_upvw
local var7_upvw
local var8_upvw
local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local var10_upvw
local var11_upvw
local var12_upvw
local var13_upvw
local var14_upvw
local var15_upvw
local var16_upvw
local var17_upvw
local IndexFrame = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("MainUI"):WaitForChild("Menus"):WaitForChild("IndexFrame")
local SearchBar_upvr = IndexFrame:WaitForChild("SearchBar")
local TextBox_upvr = SearchBar_upvr:WaitForChild("TextBox")
local List_2_upvr = IndexFrame:WaitForChild("Utility"):WaitForChild("Displays"):WaitForChild("List")
local List_upvr = IndexFrame:WaitForChild("Utility"):WaitForChild("Tools"):WaitForChild("List")
local List = IndexFrame:WaitForChild("Main"):WaitForChild("List")
local Collected_upvr = List:WaitForChild("Collected")
local Rewards_upvr = List:WaitForChild("Rewards")
local Inventory_upvr = Collected_upvr:WaitForChild("Inventory")
function any_new_result1.getIsShowingMissing(arg1) -- Line 73
	return arg1._isShowingMissing
end
function any_new_result1.setLocked(arg1, arg2) -- Line 77
	local Main_3 = arg2.Main
	Main_3.BackgroundColor3 = Color3.fromRGB(113, 113, 113)
	Main_3.IconContainer.ImageLabel.ImageColor3 = Color3.fromRGB(0, 0, 0)
	Main_3.Multiplier.Visible = false
	arg2:SetAttribute("isLocked", true)
end
function any_new_result1.createCategory(arg1, arg2) -- Line 94
	--[[ Upvalues[8]:
		[1]: var4_upvw (read and write)
		[2]: var12_upvw (read and write)
		[3]: var10_upvw (read and write)
		[4]: var5_upvw (read and write)
		[5]: Inventory_upvr (readonly)
		[6]: var14_upvw (read and write)
		[7]: var11_upvw (read and write)
		[8]: var7_upvw (read and write)
	]]
	for i, _ in var12_upvw do
		local any_setTier_result1_2_upvr = var10_upvw.pet(i):setTier(arg2)
		local var33
		if not any_setTier_result1_2_upvr:isTemporary() then
			local any_pet_result1 = var5_upvw.uis.pet(any_setTier_result1_2_upvr, {
				searchParams = true;
				ignoreAnimateIconHover = true;
			})
			local Main_2 = any_pet_result1.Main
			Main_2.Amount.Visible = false
			any_pet_result1.LayoutOrder = -any_pet_result1.LayoutOrder
			any_pet_result1.Parent = Inventory_upvr
			local any_hasIndex_result1 = arg1:hasIndex(var14_upvw.petUtils.getPetDescriptor(any_setTier_result1_2_upvr))
			if any_hasIndex_result1 then
				if arg1:getIsShowingMissing() then
					any_pet_result1.Visible = false
					any_pet_result1:SetAttribute("invisible", true)
				end
			else
				arg1:setLocked(any_pet_result1)
			end
			local tbl_2 = {"Eternal", "Secret"}
			local tbl = {}
			var33 = "pet"
			tbl.hoverType = var33
			var33 = true
			tbl.ignoreExist = var33
			var33 = not any_hasIndex_result1
			tbl.hideStats = var33
			tbl.item = any_setTier_result1_2_upvr
			var33 = any_hasIndex_result1
			if var33 then
				var33 = table.find(tbl_2, any_setTier_result1_2_upvr:getRarity())
			end
			tbl.clickToReplay = var33
			var5_upvw:createInfoHoverOnGuiStateChange(any_pet_result1.Main.Click, tbl)
			if any_hasIndex_result1 and table.find(tbl_2, any_setTier_result1_2_upvr:getRarity()) then
				var11_upvw.new(Main_2):buttonUp(function() -- Line 141
					--[[ Upvalues[3]:
						[1]: var14_upvw (copied, read and write)
						[2]: any_setTier_result1_2_upvr (readonly)
						[3]: var7_upvw (copied, read and write)
					]]
					var7_upvw:eggAnimation(var14_upvw.eggUtils.getEggNameFromPetName(any_setTier_result1_2_upvr:getName()) or "Basic", {any_setTier_result1_2_upvr}, 1)
				end)
			end
		end
	end
	arg1:updateCollectedAmount(arg2)
end
function any_new_result1.removeCategory(arg1) -- Line 159
	--[[ Upvalues[1]:
		[1]: Inventory_upvr (readonly)
	]]
	for _, v_2 in Inventory_upvr:GetChildren() do
		if v_2:GetAttribute("isItemUI") then
			v_2:Destroy()
		end
	end
end
function any_new_result1.hasIndex(arg1, arg2) -- Line 167
	--[[ Upvalues[1]:
		[1]: var4_upvw (read and write)
	]]
	for i_3, _ in var4_upvw:getData().index do
		if i_3:find(arg2) then
			return true
		end
	end
end
local Label_upvr = Collected_upvr:WaitForChild("Collected"):WaitForChild("Label")
function any_new_result1.updateCollectedAmount(arg1, arg2) -- Line 176
	--[[ Upvalues[7]:
		[1]: var4_upvw (read and write)
		[2]: var12_upvw (read and write)
		[3]: var10_upvw (read and write)
		[4]: var14_upvw (read and write)
		[5]: var13_upvw (read and write)
		[6]: Label_upvr (readonly)
		[7]: var15_upvw (read and write)
	]]
	-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
	local var58 = 0
	local totalInTier = 0
	for i_4, _ in var12_upvw do
		local any_setTier_result1 = var10_upvw.pet(i_4):setTier(arg2)
		if not any_setTier_result1:isTemporary() then
			totalInTier += 1
			if arg1:hasIndex(var14_upvw.petUtils.getPetDescriptor(any_setTier_result1):gsub(":s", "")) then
				var58 += 1
			end
		end
	end
	Label_upvr.Text = `{var13_upvw[arg2].name} Collected ({var15_upvw.suffixes(var58)}/{var15_upvw.suffixes(totalInTier)})`
end
function any_new_result1.toggleShowMissing(arg1) -- Line 202
	--[[ Upvalues[2]:
		[1]: List_upvr (readonly)
		[2]: Inventory_upvr (readonly)
	]]
	arg1._isShowingMissing = not arg1:getIsShowingMissing()
	List_upvr.ShowMissing.ON.Visible = arg1:getIsShowingMissing()
	List_upvr.ShowMissing.OFF.Visible = not arg1:getIsShowingMissing()
	for _, v_5 in Inventory_upvr:GetChildren() do
		if v_5:GetAttribute("isItemUI") then
			if arg1._isShowingMissing then
				v_5.Visible = v_5:GetAttribute("isLocked")
				v_5:SetAttribute("invisible", not v_5:GetAttribute("isLocked"))
			else
				v_5.Visible = true
			end
		end
	end
end
function any_new_result1.setRewardFramePromptInfo(arg1, arg2, arg3, arg4) -- Line 220
	--[[ Upvalues[3]:
		[1]: var4_upvw (read and write)
		[2]: var16_upvw (read and write)
		[3]: var14_upvw (read and write)
	]]
	local data = var4_upvw.data
	local var70 = var16_upvw[arg3]
	local PromptInfo = arg2.Main.PromptInfo
	local NeedPets = PromptInfo.NeedPets
	local claimedIndexRewards = data.claimedIndexRewards
	local canClaim
	if var70.required > var14_upvw.indexUtils.countIndex(data, true) then
		canClaim = false
	else
		canClaim = true
	end
	for _, v_6 in PromptInfo:GetChildren() do
		v_6.Visible = false
	end
	if table.find(claimedIndexRewards, arg3) or arg4 then
		PromptInfo.Claimed.Visible = true
	else
		if canClaim then
			PromptInfo.ClickToClaim.Visible = true
			return
		end
		NeedPets.Visible = true
		NeedPets.Text = `{var70.required - var14_upvw.indexUtils.countIndex(data, true)} More Pets Needed!`
	end
end
function any_new_result1.setRewardFrameRequired(arg1, arg2, arg3) -- Line 252
	--[[ Upvalues[1]:
		[1]: var16_upvw (read and write)
	]]
	arg2.Main.CollectAmount.Text = `Collect {var16_upvw[arg3].required} Pets`
end
function any_new_result1.setRewardFrameParent(arg1, arg2, arg3, arg4) -- Line 261
	--[[ Upvalues[3]:
		[1]: var4_upvw (read and write)
		[2]: var16_upvw (read and write)
		[3]: Rewards_upvr (readonly)
	]]
	if table.find(var4_upvw.data.claimedIndexRewards, arg3) or arg4 then
		arg2.Parent = Rewards_upvr.Claimed
	else
		arg2.Parent = Rewards_upvr.Collected
	end
end
local Assets_upvr = ReplicatedStorage_upvr:WaitForChild("Assets")
function any_new_result1.createRewardFrame(arg1, arg2) -- Line 274
	--[[ Upvalues[8]:
		[1]: var4_upvw (read and write)
		[2]: var16_upvw (read and write)
		[3]: Assets_upvr (readonly)
		[4]: var5_upvw (read and write)
		[5]: var11_upvw (read and write)
		[6]: var14_upvw (read and write)
		[7]: var8_upvw (read and write)
		[8]: var6_upvw (read and write)
	]]
	local var82_upvr = var16_upvw[arg2]
	local clone_upvr = Assets_upvr.UI.IndexReward:Clone()
	local Main = clone_upvr.Main
	for _, v_7 in var82_upvr.rewards do
		local var85
		if v_7:getClass() == "pet" then
			var85 = var5_upvw.uis.pet(v_7)
		else
			var85 = var5_upvw.uis.item(v_7)
		end
		var5_upvw:createInfoHoverOnGuiStateChange(var85.Main.Click, {
			ignoreExist = true;
			item = v_7;
			unusable = true;
		})
		var85.Parent = Main.Rewards
	end
	arg1:setRewardFramePromptInfo(clone_upvr, arg2)
	arg1:setRewardFrameRequired(clone_upvr, arg2)
	arg1:setRewardFrameParent(clone_upvr, arg2)
	clone_upvr.Visible = true
	var11_upvw.new(Main, Main.Click, {
		enter = 1.025;
		up = 1.025;
		down = 0.975;
	}):buttonUp(function() -- Line 310
		--[[ Upvalues[9]:
			[1]: var4_upvw (copied, read and write)
			[2]: arg2 (readonly)
			[3]: var5_upvw (copied, read and write)
			[4]: var14_upvw (copied, read and write)
			[5]: var82_upvr (readonly)
			[6]: var8_upvw (copied, read and write)
			[7]: var6_upvw (copied, read and write)
			[8]: arg1 (readonly)
			[9]: clone_upvr (readonly)
		]]
		local data_2 = var4_upvw.data
		if table.find(data_2.claimedIndexRewards, arg2) then
			var5_upvw:createMessagePopup({
				message = "You have already claimed this!";
				reOpen = "IndexFrame";
			})
		else
			if var14_upvw.indexUtils.countIndex(data_2, true) < var82_upvr.required then
				var5_upvw:createMessagePopup({
					message = `You need {var82_upvr.required - var14_upvw.indexUtils.countIndex(data_2, true)} more pets to claim this!`;
					reOpen = "IndexFrame";
				})
				return
			end
			if var8_upvw:claimIndexReward(arg2) == "success" then
				var6_upvw:play("Index Reward")
				arg1:setRewardFramePromptInfo(clone_upvr, arg2, true)
				arg1:setRewardFrameParent(clone_upvr, arg2, true)
				arg1:hideCollectedIfEmpty()
			end
		end
	end)
end
function any_new_result1.createRewards(arg1) -- Line 341
	--[[ Upvalues[1]:
		[1]: var16_upvw (read and write)
	]]
	for i_8, _ in var16_upvw do
		arg1:createRewardFrame(i_8)
	end
	arg1:updateRewardsCollectedAmount()
	arg1:hideCollectedIfEmpty()
end
function any_new_result1.removeRewardsInParent(arg1, arg2) -- Line 350
	for _, v_9 in arg2:GetChildren() do
		if v_9:IsA("Frame") then
			v_9:Destroy()
		end
	end
end
function any_new_result1.removeRewards(arg1) -- Line 358
	--[[ Upvalues[1]:
		[1]: Rewards_upvr (readonly)
	]]
	arg1:removeRewardsInParent(Rewards_upvr.Collected)
	arg1:removeRewardsInParent(Rewards_upvr.Claimed)
end
local Label_upvr_2 = Rewards_upvr:WaitForChild("Tag_Collected"):WaitForChild("Label")
function any_new_result1.updateRewardsCollectedAmount(arg1) -- Line 363
	--[[ Upvalues[6]:
		[1]: var4_upvw (read and write)
		[2]: var15_upvw (read and write)
		[3]: var14_upvw (read and write)
		[4]: var12_upvw (read and write)
		[5]: var13_upvw (read and write)
		[6]: Label_upvr_2 (readonly)
	]]
	Label_upvr_2.Text = `Total Collected ({var15_upvw.suffixes(var14_upvw.indexUtils.countIndex(var4_upvw.data, true))}/{var15_upvw.suffixes(var15_upvw.getAmountInTable(var12_upvw) * #var13_upvw)})`
end
function any_new_result1.hideCollectedIfEmpty(arg1) -- Line 372
	--[[ Upvalues[2]:
		[1]: var4_upvw (read and write)
		[2]: Rewards_upvr (readonly)
	]]
	local var107 = 0
	for _, v_10 in Rewards_upvr.Collected:GetChildren() do
		if v_10:IsA("Frame") then
			var107 += 1
		end
	end
	Rewards_upvr.Collected.Visible = var107 > 0
end
local InfoIndicator_upvr = List_2_upvr:WaitForChild("Rewards"):WaitForChild("InfoIndicator")
function any_new_result1.updateInfoIndicator(arg1) -- Line 389
	--[[ Upvalues[4]:
		[1]: var4_upvw (read and write)
		[2]: var16_upvw (read and write)
		[3]: var14_upvw (read and write)
		[4]: InfoIndicator_upvr (readonly)
	]]
	local data_3 = var4_upvw.data
	local var114 = false
	for i_11, _ in var16_upvw do
		if var14_upvw.indexUtils.countIndex(data_3, true) >= var16_upvw[i_11].required and not table.find(data_3.claimedIndexRewards, i_11) then
			var114 = true
		end
	end
	InfoIndicator_upvr.Visible = var114
end
local TagLabel_upvr = IndexFrame:WaitForChild("TagLabel")
local TagIcon_upvr = IndexFrame:WaitForChild("TagIcon")
function any_new_result1.toggleSection(arg1, arg2) -- Line 409
	--[[ Upvalues[5]:
		[1]: TagLabel_upvr (readonly)
		[2]: var17_upvw (read and write)
		[3]: TagIcon_upvr (readonly)
		[4]: Collected_upvr (readonly)
		[5]: Rewards_upvr (readonly)
	]]
	TagLabel_upvr.Text = var17_upvw[arg2].name
	TagIcon_upvr.Image = var17_upvw[arg2].icon
	local icon = var17_upvw[arg2].icon
	TagIcon_upvr.Shadow.Image = icon
	if arg2 ~= "collected" then
		icon = false
	else
		icon = true
	end
	Collected_upvr.Visible = icon
	if arg2 ~= "rewards" then
		icon = false
	else
		icon = true
	end
	Rewards_upvr.Visible = icon
	arg1._currentSection = arg2
end
function any_new_result1.buttons(arg1) -- Line 421
	--[[ Upvalues[6]:
		[1]: List_upvr (readonly)
		[2]: var11_upvw (read and write)
		[3]: Inventory_upvr (readonly)
		[4]: var5_upvw (read and write)
		[5]: var13_upvw (read and write)
		[6]: List_2_upvr (readonly)
	]]
	for _, v_12 in List_upvr:GetChildren() do
		if v_12:GetAttribute("isCategory") then
			local tier_upvr = v_12:GetAttribute("tier")
			var11_upvw.new(v_12):buttonUp(function() -- Line 427
				--[[ Upvalues[3]:
					[1]: arg1 (readonly)
					[2]: tier_upvr (readonly)
					[3]: Inventory_upvr (copied, readonly)
				]]
				arg1:toggleSection("collected")
				arg1:removeCategory()
				arg1:createCategory(tier_upvr)
				arg1:setSearchVisible(true)
				arg1:showFramesOnSearch(Inventory_upvr)
			end)
			var5_upvw:createTooltipOnHover(v_12, var13_upvw[tier_upvr].name)
		end
	end
	var11_upvw.new(List_upvr.ShowMissing):buttonUp(function() -- Line 444
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:toggleShowMissing()
	end)
	var5_upvw:createTooltipOnHover(List_upvr.ShowMissing, "Show Missing")
	var11_upvw.new(List_2_upvr.Pets):buttonUp(function() -- Line 450
		--[[ Upvalues[2]:
			[1]: arg1 (readonly)
			[2]: Inventory_upvr (copied, readonly)
		]]
		arg1:toggleSection("collected")
		arg1:removeCategory()
		arg1:createCategory(1)
		arg1:setSearchVisible(true)
		arg1:showFramesOnSearch(Inventory_upvr)
	end)
	var5_upvw:createTooltipOnHover(List_2_upvr.Pets, "Index")
	local function rewardsCallback() -- Line 462
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:toggleSection("rewards")
		arg1:removeRewards()
		arg1:createRewards()
		arg1:setSearchVisible(false)
	end
	var11_upvw.new(List_2_upvr.Rewards):buttonUp(rewardsCallback)
	var5_upvw:createTooltipOnHover(List_2_upvr.Rewards, "Rewards")
end
function any_new_result1.setSearchVisible(arg1, arg2) -- Line 473
	--[[ Upvalues[1]:
		[1]: SearchBar_upvr (readonly)
	]]
	SearchBar_upvr.Visible = arg2
end
function any_new_result1.setCurrentSearch(arg1, arg2) -- Line 477
	--[[ Upvalues[1]:
		[1]: TextBox_upvr (readonly)
	]]
	TextBox_upvr.Text = arg2
end
local HttpService_upvr = game:GetService("HttpService")
function any_new_result1.showFramesOnSearch(arg1, arg2) -- Line 481
	--[[ Upvalues[2]:
		[1]: TextBox_upvr (readonly)
		[2]: HttpService_upvr (readonly)
	]]
	local Text = TextBox_upvr.Text
	for _, v_13 in arg2:GetDescendants() do
		if v_13:GetAttribute("isItemUI") then
			local var154
			if not var154 then
				var154 = false
				for _, v_14 in HttpService_upvr:JSONDecode(v_13:GetAttribute("searchParams")) do
					if string.match(string.lower(v_14), string.lower(Text)) then
						var154 = true
					end
				end
				if var154 or Text == nil or Text == "" then
					v_13.Visible = true
				else
					v_13.Visible = false
				end
			end
		end
	end
end
function any_new_result1.search(arg1) -- Line 509
	--[[ Upvalues[2]:
		[1]: TextBox_upvr (readonly)
		[2]: Inventory_upvr (readonly)
	]]
	TextBox_upvr:GetPropertyChangedSignal("Text"):Connect(function() -- Line 510
		--[[ Upvalues[2]:
			[1]: arg1 (readonly)
			[2]: Inventory_upvr (copied, readonly)
		]]
		arg1:showFramesOnSearch(Inventory_upvr)
	end)
end
function any_new_result1.opened(arg1) -- Line 515
	--[[ Upvalues[1]:
		[1]: Inventory_upvr (readonly)
	]]
	local var156 = arg1._currentSection or "collected"
	arg1:toggleSection(var156)
	if var156 == "collected" then
		arg1:createCategory(1)
		arg1:setSearchVisible(true)
		arg1:showFramesOnSearch(Inventory_upvr)
	else
		arg1:createRewards()
		arg1:setSearchVisible(false)
	end
end
function any_new_result1.closed(arg1) -- Line 529
	arg1:removeCategory()
	arg1:removeRewards()
end
function any_new_result1.valuesChanged(arg1) -- Line 534
	--[[ Upvalues[1]:
		[1]: var4_upvw (read and write)
	]]
	var4_upvw.replica:OnSet({"index"}, function(arg1_2) -- Line 535
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:updateInfoIndicator()
	end)
	var4_upvw.replica:OnSet({"claimedIndexRewards"}, function(arg1_3) -- Line 538
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:updateInfoIndicator()
		arg1:hideCollectedIfEmpty()
	end)
end
function any_new_result1.Start(arg1) -- Line 544
	--[[ Upvalues[1]:
		[1]: var5_upvw (read and write)
	]]
	arg1:buttons()
	arg1:search()
	arg1:valuesChanged()
	arg1:updateInfoIndicator()
	arg1:opened()
	var5_upvw:listenToOpen("IndexFrame"):Connect(function() -- Line 552
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:opened()
	end)
	var5_upvw:listenToClose("IndexFrame"):Connect(function() -- Line 555
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:closed()
	end)
end
local var163_upvw
function any_new_result1.Construct(arg1) -- Line 560
	--[[ Upvalues[16]:
		[1]: var8_upvw (read and write)
		[2]: Knit_upvr (readonly)
		[3]: var4_upvw (read and write)
		[4]: var5_upvw (read and write)
		[5]: var6_upvw (read and write)
		[6]: var163_upvw (read and write)
		[7]: var7_upvw (read and write)
		[8]: var11_upvw (read and write)
		[9]: var10_upvw (read and write)
		[10]: ReplicatedStorage_upvr (readonly)
		[11]: var12_upvw (read and write)
		[12]: var13_upvw (read and write)
		[13]: var14_upvw (read and write)
		[14]: var15_upvw (read and write)
		[15]: var16_upvw (read and write)
		[16]: var17_upvw (read and write)
	]]
	var8_upvw = Knit_upvr.GetService("IndexService")
	var4_upvw = Knit_upvr.GetController("DataController")
	var5_upvw = Knit_upvr.GetController("UIController")
	var6_upvw = Knit_upvr.GetController("SoundController")
	var163_upvw = Knit_upvr.GetController("FFlagController")
	var7_upvw = Knit_upvr.GetController("HatchingController")
	var11_upvw = require(Knit_upvr.Modules.Button)
	var10_upvw = require(ReplicatedStorage_upvr.Shared.Items)
	var12_upvw = require(ReplicatedStorage_upvr.Shared.List.Pets.Pets)
	var13_upvw = require(ReplicatedStorage_upvr.Shared.List.Pets.Tiers)
	var14_upvw = require(ReplicatedStorage_upvr.Shared.Util)
	var15_upvw = require(ReplicatedStorage_upvr.Shared.Functions)
	var16_upvw = require(ReplicatedStorage_upvr.Shared.List.IndexRewards)
	var17_upvw = require(script.Sections)
end
return any_new_result1