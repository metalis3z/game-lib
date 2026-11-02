-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:22:41
-- Luau version 6, Types version 3
-- Time taken: 0.006041 seconds

local Knit_upvr = require(game:GetService("ReplicatedStorage").Packages.Knit)
local any_new_result1 = require(Knit_upvr.Util.Component).new({
	Tag = "Right";
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
local Right = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("MainUI"):WaitForChild("HUD"):WaitForChild("Bars"):WaitForChild("Right")
local Buttons_upvr = Right:WaitForChild("Buttons")
local List_upvr = Right:WaitForChild("List")
local Category_upvr = Right:WaitForChild("Category")
local Quests_upvr = Right:WaitForChild("Quests")
local var19_upvw = 0
function any_new_result1.updateMapQuests(arg1) -- Line 52
	--[[ Upvalues[8]:
		[1]: var4_upvw (read and write)
		[2]: var12_upvw (read and write)
		[3]: Category_upvr (readonly)
		[4]: Quests_upvr (readonly)
		[5]: var7_upvw (read and write)
		[6]: var19_upvw (read and write)
		[7]: var13_upvw (read and write)
		[8]: var9_upvw (read and write)
	]]
	local any_getData_result1 = var4_upvw:getData()
	local var27 = #any_getData_result1.maps + 1
	local var28 = var12_upvw[var27]
	if not var28 or os.time() < (var28.unlocksAt or 0) then
		Category_upvr.CategoryName.Label.Text = "Quests completed!"
		Category_upvr.CategoryName.Button.Visible = false
		Quests_upvr.Visible = false
		arg1._hasMoreQuests = false
	else
		if not arg1._mapsOnJoin[var27 - 1] and not var7_upvw:hasVisitedMap(var27 - 1) then return end
		local tbl = {}
		for i_2, v_2 in any_getData_result1.mapQuests do
			if var28.quests[i_2] and var28.quests[i_2].amount > v_2 then
				tbl[#tbl + 1] = {
					index = i_2;
					amount = v_2;
				}
			end
		end
		table.sort(tbl, function(arg1_2, arg2) -- Line 89
			local var32
			if arg2.amount >= arg1_2.amount then
				var32 = false
			else
				var32 = true
			end
			return var32
		end)
		Category_upvr.CategoryName.Label.Text = `{var28.name} Map`
		local var33 = (var19_upvw % math.ceil(#tbl / 2) + 1 - 1) * 2 + 1
		for i_3 = var33, var33 + 1 do
			local SOME = Quests_upvr:FindFirstChild(tostring(i_3))
			if not SOME then continue end
			SOME.Visible = true
			if not tbl[i_3] then
				SOME.Visible = false
			else
				local var37 = var28.quests[tbl[i_3].index]
				local amountSuffix = var9_upvw.suffixes(var37.amount)
				local questName = var37.name or ""
				SOME.Quest.Text = string.gsub(string.gsub(var13_upvw[var37.quest], "$a", amountSuffix), "$s", questName)
				local questEntry = tbl[i_3]
				local playerAmount = questEntry.amount or 0
				local maxAmount = var37.amount
				local clamped = math.clamp(playerAmount, 0, maxAmount)
				SOME.Progress.Percentage.Text = `{var9_upvw.floatingPoint(clamped / maxAmount * 100, 1)}%`
				local barScale = math.clamp(clamped / maxAmount, 0, 1)
				SOME.Progress.Bar:TweenSize(UDim2.fromScale(barScale, 1), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.25, true)
				SOME.Progress.Bar.Visible = barScale > 0
			end
			end
		arg1._hasMoreQuests = true
	end
end
local StarterGui_upvr = game:GetService("StarterGui")
function any_new_result1.toggleMapQuests(arg1, arg2, arg3) -- Line 133
	--[[ Upvalues[3]:
		[1]: Quests_upvr (readonly)
		[2]: Category_upvr (readonly)
		[3]: StarterGui_upvr (readonly)
	]]
	Quests_upvr.Visible = arg2
	Category_upvr.Visible = arg2
	if not arg1._hasMoreQuests then
		Quests_upvr.Visible = false
	end
	if not arg3 then
		StarterGui_upvr:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, not arg2)
	end
end
function any_new_result1.setMapsOnJoin(arg1) -- Line 146
	--[[ Upvalues[1]:
		[1]: var4_upvw (read and write)
	]]
	arg1._mapsOnJoin = var4_upvw:getData().maps
end
local SubButtons_upvr = Buttons_upvr:WaitForChild("SubButtons")
function any_new_result1.buttons(arg1) -- Line 151
	--[[ Upvalues[7]:
		[1]: var10_upvw (read and write)
		[2]: SubButtons_upvr (readonly)
		[3]: var5_upvw (read and write)
		[4]: Buttons_upvr (readonly)
		[5]: List_upvr (readonly)
		[6]: Category_upvr (readonly)
		[7]: var19_upvw (read and write)
	]]
	var10_upvw.new(SubButtons_upvr.Teleport.Main):buttonUp(function() -- Line 153
		--[[ Upvalues[1]:
			[1]: var5_upvw (copied, read and write)
		]]
		if _G.isTradingPlaza then
			var5_upvw:openFrame("TradingPlazaServersFrame")
		else
			var5_upvw:openFrame("TeleportFrame")
		end
	end)
	var10_upvw.new(SubButtons_upvr.Settings.Main):buttonUp(function() -- Line 162
		--[[ Upvalues[1]:
			[1]: var5_upvw (copied, read and write)
		]]
		var5_upvw:openFrame("SettingsFrame")
	end)
	var10_upvw.new(Buttons_upvr.Rewards.Main):buttonUp(function() -- Line 167
		--[[ Upvalues[1]:
			[1]: var5_upvw (copied, read and write)
		]]
		var5_upvw:openFrame("RewardsFrame")
	end)
	var10_upvw.new(List_upvr.StarterPack.Main):buttonUp(function() -- Line 172
		--[[ Upvalues[1]:
			[1]: var5_upvw (copied, read and write)
		]]
		var5_upvw:openFrame("ReleaseStockFrame")
	end)
	if List_upvr.StarterPack.Main:FindFirstChild("Sunburst") then
		var5_upvw.fx.sunburst(List_upvr.StarterPack.Main.Sunburst)
	end
	var10_upvw.new(SubButtons_upvr.ShowQuests.Main):buttonUp(function() -- Line 178
		--[[ Upvalues[2]:
			[1]: arg1 (readonly)
			[2]: Category_upvr (copied, readonly)
		]]
		arg1:toggleMapQuests(not Category_upvr.Visible)
	end)
	var10_upvw.new(Category_upvr.CategoryName.Button):buttonUp(function() -- Line 183
		--[[ Upvalues[2]:
			[1]: var19_upvw (copied, read and write)
			[2]: arg1 (readonly)
		]]
		var19_upvw += 1
		arg1:updateMapQuests()
	end)
end
local Countdown_upvr = List_upvr:WaitForChild("Countdown")
function any_new_result1.update(arg1) -- Line 189
	--[[ Upvalues[4]:
		[1]: Countdown_upvr (readonly)
		[2]: var6_upvw (read and write)
		[3]: var9_upvw (read and write)
		[4]: List_upvr (readonly)
	]]
	Countdown_upvr.Title.Text = var6_upvw:getFFlag("hudCountdownText")
	local var57 = var6_upvw:getFFlag("hudCountdownUnix") - os.time()
	local timerText
	-- formatTime2 returns HH:MM format (used for >= 12 hours); formatTime returns MM:SS
	timerText = var9_upvw.formatTime2(var57)
	if 43200 > var57 or not timerText then
		timerText = var9_upvw.formatTime(var57)
		if not timerText then
			timerText = "NOW..."
		end
	end
	Countdown_upvr.Timer.Text = timerText
	Countdown_upvr.Visible = var6_upvw:getFFlag("hudCountdownEnabled")
	local visibleCount = 0
	for _, v in List_upvr:GetChildren() do
		if v:IsA("Frame") then
			if v.Visible then
				visibleCount += 1
			end
		end
	end
	List_upvr.Visible = visibleCount > 0
	arg1:updateMapQuests()
end
function any_new_result1.stockUpdated(arg1, arg2, arg3) -- Line 208
	--[[ Upvalues[2]:
		[1]: List_upvr (readonly)
		[2]: var11_upvw (read and write)
	]]
	if arg2 ~= "release" then
	else
		local isSoldOut = (arg3 >= var11_upvw.release.stock)
		List_upvr.StarterPack.Visible = not isSoldOut
		List_upvr.StarterPack.Main.Left.Text = `{var11_upvw.release.stock - arg3} Left!`
	end
end
function any_new_result1.getStock(arg1) -- Line 217
	--[[ Upvalues[1]:
		[1]: var8_upvw (read and write)
	]]
	local any_getStock_result1 = var8_upvw:getStock("release")
	if not any_getStock_result1 then
	else
		arg1:stockUpdated("release", any_getStock_result1)
	end
end
function any_new_result1.onSet(arg1) -- Line 226
	--[[ Upvalues[1]:
		[1]: var4_upvw (read and write)
	]]
	var4_upvw.replica:OnSet({"mapQuests"}, function() -- Line 227
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:update()
	end)
end
function any_new_result1.Start(arg1) -- Line 232
	--[[ Upvalues[3]:
		[1]: var4_upvw (read and write)
		[2]: Knit_upvr (readonly)
		[3]: var8_upvw (read and write)
	]]
	arg1:buttons()
	task.spawn(function() -- Line 235
		--[[ Upvalues[3]:
			[1]: var4_upvw (copied, read and write)
			[2]: arg1 (readonly)
			[3]: Knit_upvr (copied, readonly)
		]]
		var4_upvw:waitForData()
		arg1:onSet()
		arg1:setMapsOnJoin()
		arg1:toggleMapQuests(false, true)
		Knit_upvr.listenToUpdate:Connect(function() -- Line 242
			--[[ Upvalues[1]:
				[1]: arg1 (copied, readonly)
			]]
			arg1:update()
		end)
		arg1:getStock()
	end)
	var8_upvw.stockUpdated:Connect(function(...) -- Line 249
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:stockUpdated(...)
	end)
end
local var70_upvw
local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
function any_new_result1.Construct(arg1) -- Line 254
	--[[ Upvalues[13]:
		[1]: var8_upvw (read and write)
		[2]: Knit_upvr (readonly)
		[3]: var4_upvw (read and write)
		[4]: var5_upvw (read and write)
		[5]: var6_upvw (read and write)
		[6]: var7_upvw (read and write)
		[7]: var10_upvw (read and write)
		[8]: var70_upvw (read and write)
		[9]: ReplicatedStorage_upvr (readonly)
		[10]: var9_upvw (read and write)
		[11]: var11_upvw (read and write)
		[12]: var12_upvw (read and write)
		[13]: var13_upvw (read and write)
	]]
	var8_upvw = Knit_upvr.GetService("ShopService")
	var4_upvw = Knit_upvr.GetController("DataController")
	var5_upvw = Knit_upvr.GetController("UIController")
	var6_upvw = Knit_upvr.GetController("FFlagController")
	var7_upvw = Knit_upvr.GetController("MapController")
	var10_upvw = require(Knit_upvr.Modules.Button)
	var70_upvw = require(ReplicatedStorage_upvr.Shared.Util)
	var9_upvw = require(ReplicatedStorage_upvr.Shared.Functions)
	var11_upvw = require(ReplicatedStorage_upvr.Shared.List.Shop.Stocks)
	var12_upvw = require(ReplicatedStorage_upvr.Shared.List.Maps)
	var13_upvw = require(ReplicatedStorage_upvr.Shared.List.Quests)
	arg1._hasMoreQuests = true
end
return any_new_result1