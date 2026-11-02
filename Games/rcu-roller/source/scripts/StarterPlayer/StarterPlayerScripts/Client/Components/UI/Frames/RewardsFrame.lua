-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:22:17
-- Luau version 6, Types version 3
-- Time taken: 0.011682 seconds

local Knit_upvr = require(game:GetService("ReplicatedStorage").Packages.Knit)
local any_new_result1 = require(Knit_upvr.Util.Component).new({
	Tag = "RewardsFrame";
})
local var4_upvw
local var5_upvw
local var6_upvw
local var7_upvw
local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local var9_upvw
local var10_upvw
local var11_upvw
local var12_upvw
local var13_upvw
local MainUI = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("MainUI")
local RewardsFrame_upvr = MainUI:WaitForChild("Menus"):WaitForChild("RewardsFrame")
local List_upvr = RewardsFrame_upvr:WaitForChild("Displays"):WaitForChild("List")
local Displays_upvr = RewardsFrame_upvr:WaitForChild("Main"):WaitForChild("Displays")
local Playtime_upvr = Displays_upvr:WaitForChild("Playtime")
local Holder_upvr_2 = Playtime_upvr:WaitForChild("Holder")
local Holder_upvr_3 = Displays_upvr:WaitForChild("Daily"):WaitForChild("List"):WaitForChild("Holder")
local Achievements_upvw = Displays_upvr:WaitForChild("Achievements")
local Holder_upvr = Achievements_upvw:WaitForChild("List"):WaitForChild("Holder")
function any_new_result1.setupPlaytime(arg1) -- Line 60
	--[[ Upvalues[6]:
		[1]: var11_upvw (read and write)
		[2]: Holder_upvr_2 (readonly)
		[3]: var9_upvw (read and write)
		[4]: var4_upvw (read and write)
		[5]: var7_upvw (read and write)
		[6]: var6_upvw (read and write)
	]]
	for i_upvr, v_upvr in var11_upvw do
		var9_upvw.new(Holder_upvr_2[i_upvr].Main):buttonUp(function() -- Line 66
			--[[ Upvalues[5]:
				[1]: var4_upvw (copied, read and write)
				[2]: v_upvr (readonly)
				[3]: i_upvr (readonly)
				[4]: var7_upvw (copied, read and write)
				[5]: var6_upvw (copied, read and write)
			]]
			local any_getData_result1_6 = var4_upvw:getData()
			if 0 < v_upvr.required - any_getData_result1_6.sessionTime then
			else
				if table.find(any_getData_result1_6.claimedPlaytimeRewards, i_upvr) then return end
				-- ServicePromises=true: call returns a Promise, use :andThen() to handle result
				var7_upvw:claimPlaytimeReward(i_upvr):andThen(function(result)
					if result == "success" then
						var6_upvw:play("Reward")
					end
				end)
			end
		end)
	end
end
function any_new_result1.updatePlaytime(arg1) -- Line 86
	--[[ Upvalues[5]:
		[1]: var4_upvw (read and write)
		[2]: var11_upvw (read and write)
		[3]: Holder_upvr_2 (readonly)
		[4]: var10_upvw (read and write)
		[5]: Playtime_upvr (readonly)
	]]
	local any_getData_result1_7 = var4_upvw:getData()
	for i_2, v_2 in var11_upvw do
		local sessionTime = any_getData_result1_7.sessionTime
		local var34 = v_2.required - sessionTime
		if 0 < var34 then
			sessionTime = var10_upvw.formatTime2(var34)
			Holder_upvr_2[i_2].Main.Timer.Text = sessionTime
		else
			-- KONSTANTERROR: Expression was reused, decompilation is incorrect
			if table.find(any_getData_result1_7.claimedPlaytimeRewards, i_2) then
				sessionTime = "Claimed!"
			else
				sessionTime = "Claim"
			end
			Holder_upvr_2[i_2].Main.Timer.Text = sessionTime
		end
	end
	Playtime_upvr.Claimed.Text = `{#any_getData_result1_7.claimedPlaytimeRewards}/{#var11_upvw} Rewards Claimed`
end
function any_new_result1.setupDaily(arg1) -- Line 105
	--[[ Upvalues[6]:
		[1]: ReplicatedStorage_upvr (readonly)
		[2]: Holder_upvr_3 (readonly)
		[3]: var9_upvw (read and write)
		[4]: var4_upvw (read and write)
		[5]: var7_upvw (read and write)
		[6]: var6_upvw (read and write)
	]]
	for i_3 = 1, 5 do
		local clone = ReplicatedStorage_upvr.Assets.UI.DailyReward:Clone()
		clone.Name = i_3
		clone.Parent = Holder_upvr_3
		var9_upvw.new(clone.Main.State):buttonUp(function() -- Line 114
			--[[ Upvalues[3]:
				[1]: var4_upvw (copied, read and write)
				[2]: var7_upvw (copied, read and write)
				[3]: var6_upvw (copied, read and write)
			]]
			if workspace:GetServerTimeNow() - var4_upvw:getData().dayReset < 86400 then
			else
				-- ServicePromises=true: call returns a Promise, use :andThen() to handle result
				var7_upvw:claimDailyReward():andThen(function(result)
					if result == "success" then
						var6_upvw:play("Reward")
					end
				end)
			end
		end)
	end
end
function any_new_result1.getDailyRewardsRange(arg1) -- Line 130
	--[[ Upvalues[2]:
		[1]: var4_upvw (read and write)
		[2]: var12_upvw (read and write)
	]]
	-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
	local any_getData_result1_5 = var4_upvw:getData()
	local var43 = any_getData_result1_5.day + 1
	if #var12_upvw < any_getData_result1_5.day + 5 then
		var43 = #var12_upvw - 5 + 1
	end
	local var45 = {}
	for i_4 = var43, math.min(var43 + 5 - 1, #var12_upvw) do
		table.insert(var45, i_4)
	end
	return var45
end
function any_new_result1.getDailyGradient(arg1, arg2) -- Line 151
	if arg2 == 2 then
		return ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 96, 130)), ColorSequenceKeypoint.new(1, Color3.fromRGB(230, 23, 85))})
	end
	if arg2 == 8 then
		return ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 139, 249)), ColorSequenceKeypoint.new(1, Color3.fromRGB(168, 47, 255))})
	end
	return ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(170, 244, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(46, 204, 240))})
end
function any_new_result1.updateDaily(arg1) -- Line 170
	--[[ Upvalues[5]:
		[1]: var4_upvw (read and write)
		[2]: Holder_upvr_3 (readonly)
		[3]: var12_upvw (read and write)
		[4]: var10_upvw (read and write)
		[5]: var5_upvw (read and write)
	]]
	local any_getData_result1 = var4_upvw:getData()
	arg1._trove:Clean()
	for i_5, v_3 in arg1:getDailyRewardsRange() do
		local Main = Holder_upvr_3[i_5].Main
		local var55 = var12_upvw[v_3]
		Main.Label.Text = var55:getRealName()
		Main.Icon.Image = var55:getIcon()
		Main.Amount.Text = `x{var55:getAmount()}`
		Main.State.Waiting.Label.Text = `Day {v_3}`
		Main.UIGradient.Color = arg1:getDailyGradient(v_3)
		if v_3 <= any_getData_result1.day then
			Main.State.Claim.Label.Text = "Claimed"
			Main.State.Claim.Visible = true
			Main.State.Waiting.Visible = false
		elseif v_3 - 1 == any_getData_result1.day then
			local any_formatTime2_result1 = var10_upvw.formatTime2(any_getData_result1.dayReset - os.time() + 86400)
			if any_getData_result1.dayReset - os.time() + 86400 <= 0 then
				any_formatTime2_result1 = "Claim"
			end
			Main.State.Claim.Label.Text = any_formatTime2_result1
			Main.State.Claim.Visible = true
			Main.State.Waiting.Visible = false
		else
			Main.State.Waiting.Visible = true
		end
		arg1._trove:Add(var5_upvw:createInfoHoverOnGuiStateChange(Main.Icon.Click, {
			item = var55;
			ignoreExist = true;
			unusable = true;
		}))
	end
end
local Assets_upvr = ReplicatedStorage_upvr.Assets
function any_new_result1.setupAchievements(arg1) -- Line 219
	--[[ Upvalues[7]:
		[1]: var4_upvw (read and write)
		[2]: Achievements_upvw (read and write)
		[3]: Assets_upvr (readonly)
		[4]: Holder_upvr (readonly)
		[5]: var9_upvw (read and write)
		[6]: var7_upvw (read and write)
		[7]: var6_upvw (read and write)
	]]
	for i_6_upvr, v_4 in Achievements_upvw do
		local clone_2 = Assets_upvr.UI.Achievement:Clone()
		clone_2.AchivementIcon.Image = v_4.icon
		local iconSize = v_4.iconSize
		if not iconSize then
			iconSize = UDim2.fromScale(0.186, 0.875)
		end
		clone_2.AchivementIcon.Size = iconSize
		clone_2.LayoutOrder = v_4.layoutOrder
		clone_2.Name = i_6_upvr
		clone_2.Parent = Holder_upvr
		var9_upvw.new(clone_2.State):buttonUp(function()
			-- BUG FIX 1: Server expects key format "categoryN" (e.g. "rebirths3"), not just "rebirths".
			-- Compute the next unclaimed tier index from current data at click time.
			-- BUG FIX 2: ServicePromises=true means this returns a Promise — use :andThen().
			local claimData = var4_upvw:getData()
			local claimedCount = 0
			for claimedKey, _ in claimData.claimedAchievements do
				if claimedKey:find(i_6_upvr, 1, true) == 1 then
					claimedCount += 1
				end
			end
			local tierIndex = claimedCount + 1
			local achievementKey = i_6_upvr .. tierIndex
			var7_upvw:claimAchievement(achievementKey):andThen(function(result)
				if result == "success" then
					var6_upvw:play("Reward")
				end
			end)
		end)
	end
end
function any_new_result1.updateAchievements(arg1) -- Line 242
	--[[ Upvalues[4]:
		[1]: var4_upvw (read and write)
		[2]: Achievements_upvw (read and write)
		[3]: Holder_upvr (readonly)
		[4]: var5_upvw (read and write)
	]]
	-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
	local any_getData_result1_3 = var4_upvw:getData()
	for i_7, v_5 in Achievements_upvw do
		local var99 = Holder_upvr[i_7]
		local var100 = 0
		for i_8, _ in any_getData_result1_3.claimedAchievements do
			-- BUG FIX: Use plain exact-prefix match (position 1, plain mode) to avoid
			-- pattern interpretation and false substring matches across category names.
			if i_8:find(i_7, 1, true) == 1 then
				var100 += 1
			end
		end
		local var102 = false
		local tierIndex = var100 + 1
		local var101 = v_5.list[tierIndex]
		if tierIndex > #v_5.list then
			var101 = v_5.list[#v_5.list]
			var102 = true
		end
		local amount = var101.amount
		local any_getValue_result1 = v_5.getValue(any_getData_result1_3)
		var99.AchivementName.Text = var101.name
		var99.AchivementDescription.Text = v_5.getDescription(v_5.getProgress(amount))
		var99.Progress.Bar.Size = UDim2.fromScale(math.min(1, any_getValue_result1 / amount), 1)
		var99.Progress.Amount.Text = `{v_5.getProgress(any_getValue_result1)}/{v_5.getProgress(amount)}`
		local var105 = false
		if amount <= any_getValue_result1 then
			var105 = not var102
		end
		var99.State.Claim.Visible = var105
		local var106 = true
		if any_getValue_result1 >= amount then
			var106 = var102
		end
		var99.State.Waiting.Visible = var106
		for _, v_7 in var99.Rewards:GetChildren() do
			if v_7:GetAttribute("isItemUI") then
				v_7:Destroy()
			end
		end
		for _, v_8 in var101.rewards do
			local any_item_result1 = var5_upvw.uis.item(v_8)
			any_item_result1.Parent = var99.Rewards
			var5_upvw:createInfoHoverOnGuiStateChange(any_item_result1.Main.Click, {
				item = v_8;
				unusable = true;
			})
		end
	end
end
function any_new_result1.setupFrames(arg1) -- Line 295
	arg1:setupPlaytime()
	arg1:setupDaily()
	arg1:setupAchievements()
end
function any_new_result1.hideCategories(arg1) -- Line 301
	--[[ Upvalues[1]:
		[1]: Displays_upvr (readonly)
	]]
	for _, v_9 in Displays_upvr:GetChildren() do
		v_9.Visible = false
	end
end
function any_new_result1.openCategory(arg1, arg2) -- Line 307
	--[[ Upvalues[4]:
		[1]: var13_upvw (read and write)
		[2]: Displays_upvr (readonly)
		[3]: var10_upvw (read and write)
		[4]: RewardsFrame_upvr (readonly)
	]]
	arg1:hideCategories()
	local var117 = var13_upvw[arg2]
	Displays_upvr:FindFirstChild(var10_upvw.toPascal(arg2)).Visible = true
	RewardsFrame_upvr.TagIcon.Image = var117.icon
	RewardsFrame_upvr.TagIcon.Shadow.Image = var117.icon
	RewardsFrame_upvr.TagLabel.Text = var117.name
end
function any_new_result1.buttons(arg1) -- Line 320
	--[[ Upvalues[3]:
		[1]: var9_upvw (read and write)
		[2]: List_upvr (readonly)
		[3]: var5_upvw (read and write)
	]]
	var9_upvw.new(List_upvr.Playtime):buttonUp(function() -- Line 321
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:openCategory("playtime")
		arg1:updatePlaytime()
	end)
	var5_upvw:createTooltipOnHover(List_upvr.Playtime, "Playtime")
	var9_upvw.new(List_upvr.Daily):buttonUp(function() -- Line 327
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:openCategory("daily")
		arg1:updateDaily()
	end)
	var5_upvw:createTooltipOnHover(List_upvr.Daily, "Daily")
	var9_upvw.new(List_upvr.Achievements):buttonUp(function() -- Line 333
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:openCategory("achievements")
		arg1:updateAchievements()
	end)
	var5_upvw:createTooltipOnHover(List_upvr.Achievements, "Achievements")
end
local Right_upvr = MainUI:WaitForChild("HUD"):WaitForChild("Bars"):WaitForChild("Right")
function any_new_result1.updateInfoIndicator(arg1) -- Line 340
	--[[ Upvalues[5]:
		[1]: var4_upvw (read and write)
		[2]: var11_upvw (read and write)
		[3]: Achievements_upvw (read and write)
		[4]: List_upvr (readonly)
		[5]: Right_upvr (readonly)
	]]
	local any_getData_result1_4 = var4_upvw:getData()

	-- Count unclaimed playtime rewards
	local var191 = 0
	for i_12, v_10 in var11_upvw do
		if v_10.required - any_getData_result1_4.sessionTime <= 0 and not table.find(any_getData_result1_4.claimedPlaytimeRewards, i_12) then
			var191 += 1
		end
	end

	-- Count claimable daily reward
	local var191_daily = 0
	for _, v_11 in arg1:getDailyRewardsRange() do
		if v_11 - 1 == any_getData_result1_4.day and any_getData_result1_4.dayReset - os.time() + 86400 <= 0 then
			var191_daily += 1
		end
	end

	-- Count claimable achievements
	local var191_ach = 0
	for i_14, v_12 in Achievements_upvw do
		local var192 = 0
		for i_15, _ in any_getData_result1_4.claimedAchievements do
			-- BUG FIX: Use plain exact-prefix match (position 1, plain mode)
			if i_15:find(i_14, 1, true) == 1 then
				var192 += 1
			end
		end
		local var193 = v_12.list[var192 + 1]
		if var193 then
			if v_12.getValue(any_getData_result1_4) >= var193.amount then
				var191_ach += 1
			end
		end
	end

	-- Update playtime indicator
	List_upvr.Playtime.InfoIndicator.Visible = var191 > 0
	List_upvr.Playtime.InfoIndicator.Amount.Text = var191

	-- Update daily indicator
	List_upvr.Daily.InfoIndicator.Visible = var191_daily > 0
	List_upvr.Daily.InfoIndicator.Amount.Text = var191_daily

	-- Update achievements indicator
	List_upvr.Achievements.InfoIndicator.Visible = var191_ach > 0
	List_upvr.Achievements.InfoIndicator.Amount.Text = var191_ach

	-- Update HUD notification dot
	local totalPending = var191 + var191_daily + var191_ach
	Right_upvr.Rewards.InfoIndicator.Visible = totalPending > 0
end
function any_new_result1.update(arg1) -- Line 403
	--[[ Upvalues[2]:
		[1]: var5_upvw (read and write)
		[2]: RewardsFrame_upvr (readonly)
	]]
	arg1:updateInfoIndicator()
	if not var5_upvw:isFrameOpen() then
	else
		if not RewardsFrame_upvr.Visible then return end
		arg1:updatePlaytime()
		arg1:updateDaily()
		arg1:updateAchievements()
	end
end
function any_new_result1.opened(arg1) -- Line 418
	arg1:update()
end
function any_new_result1.onSet(arg1) -- Line 422
	--[[ Upvalues[1]:
		[1]: var4_upvw (read and write)
	]]
	var4_upvw.replica:OnSet({"claimedPlaytimeRewards"}, function() -- Line 423
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:update()
	end)
	var4_upvw.replica:OnSet({"claimedAchievements"}, function() -- Line 426
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:update()
	end)
	var4_upvw.replica:OnSet({"dayReset"}, function() -- Line 429
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:update()
	end)
end
function any_new_result1.Start(arg1) -- Line 434
	--[[ Upvalues[3]:
		[1]: var4_upvw (read and write)
		[2]: var5_upvw (read and write)
		[3]: Knit_upvr (readonly)
	]]
	task.spawn(function() -- Line 435
		--[[ Upvalues[4]:
			[1]: var4_upvw (copied, read and write)
			[2]: arg1 (readonly)
			[3]: var5_upvw (copied, read and write)
			[4]: Knit_upvr (copied, readonly)
		]]
		var4_upvw:waitForData()
		arg1:onSet()
		arg1:openCategory("playtime")
		arg1:setupFrames()
		arg1:buttons()
		arg1:opened()
		var5_upvw:listenToOpen("RewardsFrame"):Connect(function() -- Line 445
			--[[ Upvalues[1]:
				[1]: arg1 (copied, readonly)
			]]
			arg1:opened()
		end)
		Knit_upvr.listenToUpdate:Connect(function() -- Line 449
			--[[ Upvalues[1]:
				[1]: arg1 (copied, readonly)
			]]
			arg1:updatePlaytime()
			arg1:updateDaily()
			arg1:updateInfoIndicator()
		end)
	end)
end
local var203_upvw
local var204_upvw
function any_new_result1.Construct(arg1) -- Line 457
	--[[ Upvalues[14]:
		[1]: var7_upvw (read and write)
		[2]: Knit_upvr (readonly)
		[3]: var4_upvw (read and write)
		[4]: var5_upvw (read and write)
		[5]: var6_upvw (read and write)
		[6]: var203_upvw (read and write)
		[7]: var9_upvw (read and write)
		[8]: var10_upvw (read and write)
		[9]: ReplicatedStorage_upvr (readonly)
		[10]: var11_upvw (read and write)
		[11]: var12_upvw (read and write)
		[12]: Achievements_upvw (read and write)
		[13]: var13_upvw (read and write)
		[14]: var204_upvw (read and write)
	]]
	var7_upvw = Knit_upvr.GetService("RewardService")
	var4_upvw = Knit_upvr.GetController("DataController")
	var5_upvw = Knit_upvr.GetController("UIController")
	var6_upvw = Knit_upvr.GetController("SoundController")
	var203_upvw = Knit_upvr.GetController("ItemController")
	var9_upvw = require(Knit_upvr.Modules.Button)
	var10_upvw = require(ReplicatedStorage_upvr.Shared.Functions)
	var11_upvw = require(ReplicatedStorage_upvr.Shared.List.PlaytimeRewards)
	var12_upvw = require(ReplicatedStorage_upvr.Shared.List.DailyRewards)
	Achievements_upvw = require(ReplicatedStorage_upvr.Shared.List.Achievements)
	var13_upvw = require(script.Categories)
	var204_upvw = require(ReplicatedStorage_upvr.Packages.Trove)
	arg1._trove = var204_upvw.new()
end
return any_new_result1