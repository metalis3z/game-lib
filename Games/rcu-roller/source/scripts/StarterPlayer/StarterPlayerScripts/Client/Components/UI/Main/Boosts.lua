-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:22:42
-- Luau version 6, Types version 3
-- Time taken: 0.006523 seconds

local Knit_upvr = require(game:GetService("ReplicatedStorage").Packages.Knit)
local any_new_result1 = require(Knit_upvr.Util.Component).new({
	Tag = "Boosts";
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
local var14_upvw
local LocalPlayer_upvr = game:GetService("Players").LocalPlayer
local Boosts_upvr = LocalPlayer_upvr:WaitForChild("PlayerGui"):WaitForChild("MainUI"):WaitForChild("HUD"):WaitForChild("Bars"):WaitForChild("Boosts")
local Assets_upvr = ReplicatedStorage_upvr.Assets
function any_new_result1.createItem(arg1, arg2, arg3) -- Line 49
	--[[ Upvalues[4]:
		[1]: Assets_upvr (readonly)
		[2]: Boosts_upvr (readonly)
		[3]: var5_upvw (read and write)
		[4]: var10_upvw (read and write)
	]]
	for i, v in arg2 do
		local clone = Assets_upvr.UI.Boost:Clone()
		local Main = clone.Main
		Main.Icon.Image = v.icon
		clone.Name = i
		clone.Visible = false
		clone.Parent = Boosts_upvr
		var5_upvw:createInfoHoverOnGuiStateChange(Main, {
			item = var10_upvw[arg3](i);
			hoverType = "boost";
		})
	end
end
function any_new_result1.updateItem(arg1, arg2) -- Line 67
	--[[ Upvalues[3]:
		[1]: var4_upvw (read and write)
		[2]: Boosts_upvr (readonly)
		[3]: var9_upvw (read and write)
	]]
	local data = var4_upvw.data
	for i_2, _ in arg2 do
		local var28 = Boosts_upvr[i_2]
		local var29
		if not data.activeBoosts[i_2] then
			var28.Visible = false
		else
			local var30 = data.activeBoosts[i_2]
			var28.Visible = true
			local function INLINED() -- Internal function, doesn't exist in bytecode
				var29 = var9_upvw.formatTime(var30)
				return var29
			end
			if var30 > 3600 or not INLINED() then
				var29 = var9_upvw.formatTime2(var30, 1)
			end
			var28.Main.Amount.Text = var29
			arg1._currentActive += 1
		end
	end
end
function any_new_result1.updateDaily(arg1) -- Line 88
	--[[ Upvalues[2]:
		[1]: var4_upvw (read and write)
		[2]: Boosts_upvr (readonly)
	]]
	local any_getData_result1 = var4_upvw:getData()
	local isActive = any_getData_result1.day > 0
	Boosts_upvr.Daily.Visible = isActive
	if isActive then
		arg1._currentActive += 1
	end
end
function any_new_result1.updateFriend(arg1) -- Line 95
	--[[ Upvalues[3]:
		[1]: var4_upvw (read and write)
		[2]: Boosts_upvr (readonly)
		[3]: var9_upvw (read and write)
	]]
	local data = var4_upvw:getData()
	if not data then return end
	local friendCount = data.friendsInServer or 0
	local pct = friendCount * 5
	local isActive = pct > 0
	Boosts_upvr.Friend.Visible = isActive
	if isActive then
		Boosts_upvr.Friend.Main.Amount.Text = "+" .. var9_upvw.floatingPoint(pct) .. "%"
		arg1._currentActive += 1
	end
end
function any_new_result1.updateGlobalLuckEvent(arg1) -- Line 105
	--[[ Upvalues[3]:
		[1]: Boosts_upvr (readonly)
		[2]: var6_upvw (read and write)
		[3]: var9_upvw (read and write)
	]]
	local amount = var6_upvw:getGlobalLuckEventAmount()
	local isActive = amount > 0
	Boosts_upvr.GlobalLuckEvent.Visible = isActive
	if isActive then
		Boosts_upvr.GlobalLuckEvent.Main.Amount.Text = "+" .. var9_upvw.floatingPoint(amount * 100) .. "%"
		arg1._currentActive += 1
	end
end
function any_new_result1.updateWeeklyLeaderboard(arg1)
	-- CF ANALYSIS FAILED — stub: hide boost, do not crash
	local var36 = Boosts_upvr
	if not pcall(function()
		local data = var4_upvw:getData()
		local rank = data and data.weeklyLeaderboardRank
		if rank and rank >= 1 and rank <= 3 then
			Boosts_upvr.WeeklyLeaderboard.Visible = true
			Boosts_upvr.WeeklyLeaderboard.Main.Amount.Text = "#" .. tostring(rank)
			arg1._currentActive += 1
		else
			Boosts_upvr.WeeklyLeaderboard.Visible = false
		end
	end) then
		Boosts_upvr.WeeklyLeaderboard.Visible = false
	end
end
function any_new_result1.updateClans(arg1) -- Line 130
	local data = var4_upvw:getData()
	local isInClan = data.clanId ~= nil and data.clanId ~= ""
	Boosts_upvr.Clan.Visible = isInClan
	if isInClan then
		arg1._currentActive += 1
	end
end
function any_new_result1.updateEvents(arg1) -- Line 135
	--[[ Upvalues[2]:
		[1]: Boosts_upvr (readonly)
		[2]: var7_upvw (read and write)
	]]
	local clicksMultiplier = var7_upvw:getFFlag("clicksMultiplier")
	local luckMultiplier = var7_upvw:getFFlag("luckMultiplier")
	local gemsMultiplier = var7_upvw:getFFlag("gemsMultiplier")
	local hatchSpeed = var7_upvw:getFFlag("hatchSpeed")
	local extraEggs = var7_upvw:getFFlag("extraEggs")

	Boosts_upvr.EventClicks.Visible = clicksMultiplier > 1
	if clicksMultiplier > 1 then
		Boosts_upvr.EventClicks.Main.Amount.Text = "x" .. clicksMultiplier
		arg1._currentActive += 1
	end

	Boosts_upvr.EventLuck.Visible = luckMultiplier > 1
	if luckMultiplier > 1 then
		Boosts_upvr.EventLuck.Main.Amount.Text = "x" .. luckMultiplier
		arg1._currentActive += 1
	end

	Boosts_upvr.EventGems.Visible = gemsMultiplier > 1
	if gemsMultiplier > 1 then
		Boosts_upvr.EventGems.Main.Amount.Text = "x" .. gemsMultiplier
		arg1._currentActive += 1
	end

	Boosts_upvr.EventHatchSpeed.Visible = hatchSpeed > 1
	if hatchSpeed > 1 then
		Boosts_upvr.EventHatchSpeed.Main.Amount.Text = "x" .. hatchSpeed
		arg1._currentActive += 1
	end

	Boosts_upvr.EventExtraEggs.Visible = extraEggs > 1
	if extraEggs > 1 then
		Boosts_upvr.EventExtraEggs.Main.Amount.Text = "x" .. extraEggs
		arg1._currentActive += 1
	end
end
function any_new_result1.updatePremium(arg1)
	local PremiumMain = Boosts_upvr.Premium.Main
	local premiumText
	if LocalPlayer_upvr.MembershipType == Enum.MembershipType.Premium then
		premiumText = "+10%"
	else
		premiumText = "+0%"
	end
	PremiumMain.Amount.Text = premiumText
	arg1._currentActive += 1
end
function any_new_result1.updateOther(arg1) -- Line 162
	arg1:updateDaily()
	arg1:updateFriend()
	arg1:updateGlobalLuckEvent()
	arg1:updateWeeklyLeaderboard()
	arg1:updateClans()
	arg1:updateEvents()
	arg1:updatePremium()
end
local UIGridLayout_upvr = Boosts_upvr:WaitForChild("UIGridLayout")
function any_new_result1.updateGridLayout(arg1) -- Line 172
	--[[ Upvalues[1]:
		[1]: UIGridLayout_upvr (readonly)
	]]
	local var40
	local function INLINED_2() -- Internal function, doesn't exist in bytecode
		var40 = UDim2.fromScale(0.15, 0.5)
		return var40
	end
	if arg1._currentActive >= 15 or not INLINED_2() then
		var40 = UDim2.fromScale(0.114, 0.38)
	end
	UIGridLayout_upvr.CellSize = var40
	if arg1._currentActive < 15 then
		var40 = 5
	else
		var40 = 7
	end
	UIGridLayout_upvr.FillDirectionMaxCells = var40
end
function any_new_result1.setup(arg1) -- Line 177
	--[[ Upvalues[4]:
		[1]: var4_upvw (read and write)
		[2]: Boosts_upvr (readonly)
		[3]: var5_upvw (read and write)
		[4]: var10_upvw (read and write)
	]]
	Boosts_upvr.Visible = not var4_upvw:getData().settings.hideBoosts
	var5_upvw:createInfoHoverOnGuiStateChange(Boosts_upvr.Daily, {
		hoverType = "dailyBoost";
	})
	var5_upvw:createInfoHoverOnGuiStateChange(Boosts_upvr.Friend, {
		hoverType = "friendBoost";
	})
	var5_upvw:createInfoHoverOnGuiStateChange(Boosts_upvr.epicLuck, {
		item = var10_upvw.exclusive("epicLuck");
		hoverType = "boost";
	})
	var5_upvw:createInfoHoverOnGuiStateChange(Boosts_upvr.GlobalLuckEvent, {
		hoverType = "globalLuckEvent";
	})
	var5_upvw:createInfoHoverOnGuiStateChange(Boosts_upvr.WeeklyLeaderboard, {
		hoverType = "lbWeekly";
	})
	var5_upvw:createInfoHoverOnGuiStateChange(Boosts_upvr.Clan, {
		hoverType = "clanBoost";
	})
	var5_upvw:createInfoHoverOnGuiStateChange(Boosts_upvr.EventClicks, {
		hoverType = "event";
		fFlag = "clicksMultiplier";
	})
	var5_upvw:createInfoHoverOnGuiStateChange(Boosts_upvr.EventLuck, {
		hoverType = "event";
		fFlag = "luckMultiplier";
	})
	var5_upvw:createInfoHoverOnGuiStateChange(Boosts_upvr.EventGems, {
		hoverType = "event";
		fFlag = "gemsMultiplier";
	})
	var5_upvw:createInfoHoverOnGuiStateChange(Boosts_upvr.EventHatchSpeed, {
		hoverType = "event";
		fFlag = "hatchSpeed";
	})
	var5_upvw:createInfoHoverOnGuiStateChange(Boosts_upvr.EventExtraEggs, {
		hoverType = "event";
		fFlag = "extraEggs";
	})
	var5_upvw:createInfoHoverOnGuiStateChange(Boosts_upvr.Premium, {
		hoverType = "premiumBoost";
	})
end
function any_new_result1.update(arg1) -- Line 228
	--[[ Upvalues[4]:
		[1]: var4_upvw (read and write)
		[2]: var12_upvw (read and write)
		[3]: var13_upvw (read and write)
		[4]: var14_upvw (read and write)
	]]
	arg1._currentActive = 0
	arg1:updateItem(var12_upvw)
	arg1:updateItem(var13_upvw)
	arg1:updateItem(var14_upvw)
	arg1:updateItem({
		epicLuck = true;
	})
	arg1:updateOther()
	arg1:updateGridLayout()
end
local MarketplaceService_upvr = game:GetService("MarketplaceService")
local SocialService_upvr = game:GetService("SocialService")
function any_new_result1.buttons(arg1) -- Line 242
	--[[ Upvalues[5]:
		[1]: var11_upvw (read and write)
		[2]: Boosts_upvr (readonly)
		[3]: LocalPlayer_upvr (readonly)
		[4]: MarketplaceService_upvr (readonly)
		[5]: SocialService_upvr (readonly)
	]]
	var11_upvw.new(Boosts_upvr.Premium.Main):buttonUp(function() -- Line 244
		--[[ Upvalues[2]:
			[1]: LocalPlayer_upvr (copied, readonly)
			[2]: MarketplaceService_upvr (copied, readonly)
		]]
		if LocalPlayer_upvr.MembershipType == Enum.MembershipType.Premium then
		else
			MarketplaceService_upvr:PromptPremiumPurchase(LocalPlayer_upvr)
		end
	end)
	var11_upvw.new(Boosts_upvr.Friend.Main):buttonUp(function() -- Line 252
		--[[ Upvalues[2]:
			[1]: SocialService_upvr (copied, readonly)
			[2]: LocalPlayer_upvr (copied, readonly)
		]]
		local pcall_result1, pcall_result2 = pcall(function() -- Line 253
			--[[ Upvalues[2]:
				[1]: SocialService_upvr (copied, readonly)
				[2]: LocalPlayer_upvr (copied, readonly)
			]]
			return SocialService_upvr:CanSendGameInviteAsync(LocalPlayer_upvr)
		end)
		if not pcall_result1 then
		else
			if not pcall_result2 then return end
			local ExperienceInviteOptions = Instance.new("ExperienceInviteOptions")
			ExperienceInviteOptions.PromptMessage = "Invite to get extra boosts!"
			SocialService_upvr:PromptGameInvite(LocalPlayer_upvr, ExperienceInviteOptions)
			ExperienceInviteOptions:Destroy()
		end
	end)
end
function any_new_result1.valuesChanged(arg1) -- Line 273
	--[[ Upvalues[1]:
		[1]: var4_upvw (read and write)
	]]
	var4_upvw.replica:OnSet({"activeBoosts"}, function(arg1_2) -- Line 274
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:update()
	end)
end
function any_new_result1.Start(arg1) -- Line 279
	--[[ Upvalues[5]:
		[1]: var4_upvw (read and write)
		[2]: var12_upvw (read and write)
		[3]: var13_upvw (read and write)
		[4]: var14_upvw (read and write)
		[5]: Knit_upvr (readonly)
	]]
	task.spawn(function() -- Line 280
		--[[ Upvalues[6]:
			[1]: var4_upvw (copied, read and write)
			[2]: arg1 (readonly)
			[3]: var12_upvw (copied, read and write)
			[4]: var13_upvw (copied, read and write)
			[5]: var14_upvw (copied, read and write)
			[6]: Knit_upvr (copied, readonly)
		]]
		repeat
			task.wait()
		until var4_upvw.data
		arg1:createItem(var12_upvw, "potion")
		arg1:createItem(var13_upvw, "fruit")
		arg1:createItem(var14_upvw, "activeEvent")
		arg1:setup()
		arg1:buttons()
		arg1:valuesChanged()
		Knit_upvr.listenToUpdate:Connect(function() -- Line 290
			--[[ Upvalues[1]:
				[1]: arg1 (copied, readonly)
			]]
			arg1:update()
		end)
	end)
end
local var66_upvw
local var67_upvw
local var68_upvw
local var69_upvw
function any_new_result1.Construct(arg1) -- Line 296
	--[[ Upvalues[16]:
		[1]: var66_upvw (read and write)
		[2]: Knit_upvr (readonly)
		[3]: var4_upvw (read and write)
		[4]: var67_upvw (read and write)
		[5]: var5_upvw (read and write)
		[6]: var6_upvw (read and write)
		[7]: var7_upvw (read and write)
		[8]: var11_upvw (read and write)
		[9]: var68_upvw (read and write)
		[10]: ReplicatedStorage_upvr (readonly)
		[11]: var9_upvw (read and write)
		[12]: var10_upvw (read and write)
		[13]: var12_upvw (read and write)
		[14]: var13_upvw (read and write)
		[15]: var14_upvw (read and write)
		[16]: var69_upvw (read and write)
	]]
	var66_upvw = Knit_upvr.GetService("EggService")
	var4_upvw = Knit_upvr.GetController("DataController")
	var67_upvw = Knit_upvr.GetController("ClickController")
	var5_upvw = Knit_upvr.GetController("UIController")
	var6_upvw = Knit_upvr.GetController("EggController")
	var7_upvw = Knit_upvr.GetController("FFlagController")
	var11_upvw = require(script.Parent.Parent.Parent.Parent.Modules.Button)
	var68_upvw = require(ReplicatedStorage_upvr.Shared.Util)
	var9_upvw = require(ReplicatedStorage_upvr.Shared.Functions)
	var10_upvw = require(ReplicatedStorage_upvr.Shared.Items)
	var12_upvw = require(ReplicatedStorage_upvr.Shared.List.Items.Potions)
	var13_upvw = require(ReplicatedStorage_upvr.Shared.List.Items.Fruits)
	var14_upvw = require(ReplicatedStorage_upvr.Shared.List.Items.ActiveEvents)
	var69_upvw = require(ReplicatedStorage_upvr.Shared.List.Shop.ExclusiveItems)
end
return any_new_result1