-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:21:37
-- Luau version 6, Types version 3
-- Time taken: 0.007071 seconds

local Knit_upvr = require(game:GetService("ReplicatedStorage").Packages.Knit)
local any_new_result1 = require(Knit_upvr.Util.Component).new({
	Tag = "RebirthFrame";
	_sortAscending = true;
	_isSelectingAutoRebirth = false;
	_selectedAutoRebirth = 0;
	_isAutoRebirthing = false;
	removeAutoRebirthGradient = nil;
})
any_new_result1._buttons = {}
any_new_result1._debounce = 0
any_new_result1._rebirthDebounce = false
local var4_upvw
local var5_upvw
local var6_upvw
local var7_upvw
local var8_upvw
local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local TweenService_upvr = game:GetService("TweenService")
local var11_upvw
local var12_upvw
local var13_upvw
local var14_upvw
local var15_upvw
local var16_upvw
local LocalPlayer_upvr = game:GetService("Players").LocalPlayer
local MainUI = LocalPlayer_upvr:WaitForChild("PlayerGui"):WaitForChild("MainUI")
local RebirthFrame_upvr = MainUI:WaitForChild("Menus"):WaitForChild("RebirthFrame")
local Holder_upvr = RebirthFrame_upvr:WaitForChild("Main"):WaitForChild("List"):WaitForChild("Holder")
local Main_upvr = Holder_upvr:WaitForChild("Main")
local AutoRebirth_upvr = Main_upvr:WaitForChild("AutoRebirth")
function any_new_result1.autoRebirthGradient(arg1) -- Line 72
	--[[ Upvalues[2]:
		[1]: Holder_upvr (readonly)
		[2]: TweenService_upvr (readonly)
	]]
	local SOME = Holder_upvr.Rebirths:FindFirstChild(arg1._selectedAutoRebirth)
	if not SOME then
	else
		local UIStroke_upvr = SOME.Main.UIStroke
		local UIGradient_upvr = UIStroke_upvr.UIGradient
		UIStroke_upvr.Color = Color3.fromRGB(255, 255, 255)
		UIGradient_upvr.Enabled = true
		local any_Create_result1_upvr = TweenService_upvr:Create(UIGradient_upvr, TweenInfo.new(4, Enum.EasingStyle.Linear, Enum.EasingDirection.In, -1, false), {
			Rotation = 360;
		})
		any_Create_result1_upvr:Play()
		local var29_upvw
		var29_upvw = arg1.removeAutoRebirthGradient:Connect(function() -- Line 91
			--[[ Upvalues[4]:
				[1]: UIStroke_upvr (readonly)
				[2]: UIGradient_upvr (readonly)
				[3]: var29_upvw (read and write)
				[4]: any_Create_result1_upvr (readonly)
			]]
			UIStroke_upvr.Color = Color3.fromRGB(0, 32, 54)
			UIGradient_upvr.Enabled = false
			var29_upvw:Disconnect()
			any_Create_result1_upvr:Cancel()
			any_Create_result1_upvr:Destroy()
		end)
	end
end
local State_upvr = MainUI:WaitForChild("HUD"):WaitForChild("Bars"):WaitForChild("Left"):WaitForChild("Row2"):WaitForChild("Rebirth"):WaitForChild("Main"):WaitForChild("State")
local RunService_upvr = game:GetService("RunService")
function any_new_result1.autoRebirth(arg1) -- Line 101
	--[[ Upvalues[6]:
		[1]: var4_upvw (read and write)
		[2]: var13_upvw (read and write)
		[3]: State_upvr (readonly)
		[4]: var7_upvw (read and write)
		[5]: var14_upvw (read and write)
		[6]: RunService_upvr (readonly)
	]]
	local _selectedAutoRebirth_upvr = arg1._selectedAutoRebirth
	State_upvr.ON.Visible = true
	arg1:toggleSelection(false, false)
	arg1:autoRebirthGradient()
	arg1._isAutoRebirthing = true
	var7_upvw.setIsAutoRebirthing:Fire(true, _selectedAutoRebirth_upvr)
	local data_upvr = var4_upvw.data
	local var35_upvr = var13_upvw[_selectedAutoRebirth_upvr]
	task.spawn(function() -- Line 116
		--[[ Upvalues[8]:
			[1]: var14_upvw (copied, read and write)
			[2]: data_upvr (readonly)
			[3]: var35_upvr (readonly)
			[4]: var7_upvw (copied, read and write)
			[5]: _selectedAutoRebirth_upvr (readonly)
			[6]: RunService_upvr (copied, readonly)
			[7]: arg1 (readonly)
			[8]: State_upvr (copied, readonly)
		]]
		repeat
			if (var14_upvw.rebirthPrice + data_upvr.rebirths * var14_upvw.rebirthPriceMultiplier) * var35_upvr + (var14_upvw.rebirthPriceMultiplier) * (var35_upvr * (var35_upvr - 1) / 2) <= data_upvr.clicks then
				var7_upvw:rebirth(_selectedAutoRebirth_upvr)
			end
			RunService_upvr.RenderStepped:Wait()
		until not arg1._isAutoRebirthing
		State_upvr.ON.Visible = false
		var7_upvw.setIsAutoRebirthing:Fire(false)
		arg1.removeAutoRebirthGradient:Fire()
		arg1._selectedAutoRebirth = 0
	end)
end
local Assets_upvr = ReplicatedStorage_upvr.Assets
function any_new_result1.setupFrames(arg1) -- Line 134
	arg1:removeFrames() -- Clear any existing clones first
	local data_upvr_2 = var4_upvw.data
	if not data_upvr_2 then return end
	for i_upvr, v_upvr in var13_upvw do
		local upgradeLevel = data_upvr_2.upgrades.rebirthButtons or 0
		local upgradeEntry = var15_upvw.rebirthButtons.upgrades[upgradeLevel]
		if not upgradeEntry then continue end
		if upgradeEntry.value >= i_upvr then
			local clone = Assets_upvr.UI.Rebirth:Clone()
			clone:SetAttribute("index", i_upvr)
			clone.Visible = true
			clone.Name = i_upvr
			clone.Parent = Holder_upvr.Rebirths
			arg1._buttons[i_upvr] = var11_upvw.new(clone.Main, clone.Main.Click, {
				enter = 1.04;
				up = 1.04;
			})
			arg1._buttons[i_upvr]:buttonUp(function()
				if arg1._isSelectingAutoRebirth then
					arg1._isSelectingAutoRebirth = false
					arg1._selectedAutoRebirth = i_upvr
					arg1:autoRebirth()
					return
				end
				-- Debounce rapid clicks
				if arg1._rebirthDebounce then return end
				arg1._rebirthDebounce = true
				task.delay(0.3, function()
					arg1._rebirthDebounce = false
				end)
				local var43 = (var14_upvw.rebirthPrice + data_upvr_2.rebirths * var14_upvw.rebirthPriceMultiplier) * v_upvr + (var14_upvw.rebirthPriceMultiplier) * (v_upvr * (v_upvr - 1) / 2)
				if data_upvr_2.clicks < var43 then
					if data_upvr_2.rebirths < 100 then
						var5_upvw:createMessagePopup({
							title = "Almost there!";
							message = `You need {var12_upvw.suffixes(var43 - data_upvr_2.clicks)} more clicks to rebirth!`;
							reOpen = "RebirthFrame";
						})
					else
						var5_upvw:createNotification("Default", `You need {var12_upvw.suffixes(var43 - data_upvr_2.clicks)} more clicks to rebirth!`)
					end
					return
				end
				if var7_upvw:rebirth(i_upvr) == "success" then
					var6_upvw:play("Rebirth", {
						volume = 0.3;
					})
				end
			end)
		end
	end
	arg1:update()
end
function any_new_result1.canAutoRebirth(arg1) -- Line 191
	--[[ Upvalues[1]:
		[1]: var4_upvw (read and write)
	]]
	if var4_upvw.data.passes.autoRebirth then
		return true
	end
end
local Warning_upvr = RebirthFrame_upvr:WaitForChild("Warning")
function any_new_result1.update(arg1) -- Line 199
	if not RebirthFrame_upvr.Visible then
		return
	end
	local data_2 = var4_upvw.data
	local upgradeLevel = data_2.upgrades.rebirthButtons or 0
	local upgradeEntry = var15_upvw.rebirthButtons.upgrades[upgradeLevel]
	if not upgradeEntry then return end
	local maxValue = upgradeEntry.value
	for i_3, v_3 in var13_upvw do
		if maxValue >= i_3 then
			local var54 = Holder_upvr.Rebirths:FindFirstChild(tostring(i_3))
			if var54 then
				local Main = var54.Main
				local rebirthPrice = var14_upvw.rebirthPrice
				local rebirthPriceMultiplier = var14_upvw.rebirthPriceMultiplier
				local var56 = v_3 - 1
				local var57 = (rebirthPrice + data_2.rebirths * rebirthPriceMultiplier) * v_3 + rebirthPriceMultiplier * (v_3 * var56 / 2)
				local any_suffixes_result1 = var12_upvw.suffixes(v_3)
				local plural
				if v_3 ~= 1 then
					plural = "s"
				else
					plural = ""
				end
				Main.Label.Text = tostring(any_suffixes_result1) .. " Rebirth" .. plural .. " For " .. var12_upvw.suffixes(var57) .. " Clicks"
				local locked = false
				if data_2.clicks < var57 then
					locked = not arg1._isSelectingAutoRebirth
				end
				Main.Locked.Visible = locked
				var54.LayoutOrder = arg1._sortAscending and -i_3 or i_3
			end
		end
	end
	local any_canAutoRebirth_result1 = arg1:canAutoRebirth()
	if not Main_upvr.SelectInfo.Visible then
		Main_upvr.AutoRebirth.Visible = any_canAutoRebirth_result1
		Main_upvr.Buy.Visible = not any_canAutoRebirth_result1
	end
	Warning_upvr.Visible = (data_2.rebirths or 0) < 100
end

function any_new_result1.removeFrames(arg1) -- Line 240
	--[[ Upvalues[1]:
		[1]: Holder_upvr (readonly)
	]]
	for _, v_2 in Holder_upvr.Rebirths:GetChildren() do
		if v_2:IsA("Frame") then
			local index = v_2:GetAttribute("index")
			arg1._buttons[index]:remove()
			arg1._buttons[index] = nil
			v_2:Destroy()
		end
	end
end
function any_new_result1.toggleSelection(arg1, arg2, arg3) -- Line 253
	--[[ Upvalues[2]:
		[1]: AutoRebirth_upvr (readonly)
		[2]: Main_upvr (readonly)
	]]
	AutoRebirth_upvr.Off.Visible = not arg3
	AutoRebirth_upvr.On.Visible = arg3
	AutoRebirth_upvr.Visible = not arg2
	Main_upvr.SelectInfo.Visible = arg2
	Main_upvr.Label.Visible = not arg2
	arg1:update()
end
function any_new_result1.sortArrow(arg1) -- Line 264
	--[[ Upvalues[2]:
		[1]: TweenService_upvr (readonly)
		[2]: RebirthFrame_upvr (readonly)
	]]
	local var66
	if arg1._sortAscending then
		var66 = 0
	else
		var66 = 180
	end
	TweenService_upvr:Create(RebirthFrame_upvr.Sort.Arrow, TweenInfo.new(0.2), {
		Rotation = var66;
	}):Play()
end
local MarketplaceService_upvr = game:GetService("MarketplaceService")
function any_new_result1.buttons(arg1) -- Line 269
	--[[ Upvalues[9]:
		[1]: var11_upvw (read and write)
		[2]: RebirthFrame_upvr (readonly)
		[3]: AutoRebirth_upvr (readonly)
		[4]: Main_upvr (readonly)
		[5]: var5_upvw (read and write)
		[6]: MarketplaceService_upvr (readonly)
		[7]: LocalPlayer_upvr (readonly)
		[8]: var16_upvw (read and write)
		[9]: var8_upvw (read and write)
	]]
	var11_upvw.new(RebirthFrame_upvr.Sort):buttonUp(function() -- Line 271
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1._sortAscending = not arg1._sortAscending
		arg1:update()
		arg1:sortArrow()
	end)
	var11_upvw.new(AutoRebirth_upvr.On):buttonUp(function() -- Line 278
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1._debounce = tick()
		arg1._isSelectingAutoRebirth = true
		arg1:toggleSelection(true, true)
	end)
	var11_upvw.new(AutoRebirth_upvr.Off):buttonUp(function() -- Line 286
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		if tick() - arg1._debounce < 0.5 then
		else
			arg1._debounce = tick()
			arg1._isAutoRebirthing = false
			arg1:toggleSelection(false, true)
		end
	end)
	local any_new_result1_2_upvr = var11_upvw.new(Main_upvr.Buy)
	any_new_result1_2_upvr:buttonUp(function() -- Line 298
		--[[ Upvalues[6]:
			[1]: any_new_result1_2_upvr (readonly)
			[2]: var5_upvw (copied, read and write)
			[3]: MarketplaceService_upvr (copied, readonly)
			[4]: LocalPlayer_upvr (copied, readonly)
			[5]: var16_upvw (copied, read and write)
			[6]: var8_upvw (copied, read and write)
		]]
		any_new_result1_2_upvr:setToOriginalSize()
		var5_upvw:setToIsPurchasing()
		MarketplaceService_upvr:PromptGamePassPurchase(LocalPlayer_upvr, var16_upvw.autoRebirth.gamePassId)
		var8_upvw.setLocation:Fire(3, 2)
	end)
end
function any_new_result1.isAutoRebirthingOnJoin(arg1) -- Line 306
	--[[ Upvalues[1]:
		[1]: var4_upvw (read and write)
	]]
	local data = var4_upvw.data
	if not data.isAutoRebirthing then
	else
		arg1._isAutoRebirthing = data.isAutoRebirthing
		arg1._selectedAutoRebirth = data.selectedAutoRebirth
		arg1:autoRebirth()
	end
end
function any_new_result1.valuesChanged(arg1) -- Line 318
	--[[ Upvalues[1]:
		[1]: var4_upvw (read and write)
	]]
	var4_upvw.replica:OnSet({"rebirths"}, function(arg1_2) -- Line 319
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:update()
	end)
	var4_upvw.replica:OnSet({"clicks"}, function(arg1_3) -- Line 322
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:update()
	end)
end
function any_new_result1.opened(arg1) -- Line 327
	--[[ Upvalues[1]:
		[1]: var6_upvw (read and write)
	]]
	arg1:setupFrames()
	if arg1._isAutoRebirthing then
		arg1:autoRebirthGradient()
	end
	arg1:update()
	var6_upvw:preloadSounds({"Rebirth"})
end
function any_new_result1.closed(arg1) -- Line 341
	arg1:removeFrames()
	arg1.removeAutoRebirthGradient:Fire()
end
function any_new_result1.Start(arg1) -- Line 347
	--[[ Upvalues[2]:
		[1]: var4_upvw (read and write)
		[2]: var5_upvw (read and write)
	]]
	task.spawn(function() -- Line 348
		--[[ Upvalues[3]:
			[1]: var4_upvw (copied, read and write)
			[2]: arg1 (readonly)
			[3]: var5_upvw (copied, read and write)
		]]
		var4_upvw:waitForData()
		arg1:buttons()
		arg1:valuesChanged()
		var5_upvw:listenToOpen("RebirthFrame"):Connect(function() -- Line 354
			--[[ Upvalues[1]:
				[1]: arg1 (copied, readonly)
			]]
			arg1:opened()
		end)
		var5_upvw:listenToClose("RebirthFrame"):Connect(function() -- Line 357
			--[[ Upvalues[1]:
				[1]: arg1 (copied, readonly)
			]]
			arg1:closed()
		end)
		arg1:isAutoRebirthingOnJoin()
	end)
end
local var83_upvw
function any_new_result1.Construct(arg1) -- Line 365
	--[[ Upvalues[14]:
		[1]: var7_upvw (read and write)
		[2]: Knit_upvr (readonly)
		[3]: var8_upvw (read and write)
		[4]: var4_upvw (read and write)
		[5]: var5_upvw (read and write)
		[6]: var6_upvw (read and write)
		[7]: var11_upvw (read and write)
		[8]: var12_upvw (read and write)
		[9]: ReplicatedStorage_upvr (readonly)
		[10]: var13_upvw (read and write)
		[11]: var14_upvw (read and write)
		[12]: var83_upvw (read and write)
		[13]: var15_upvw (read and write)
		[14]: var16_upvw (read and write)
	]]
	var7_upvw = Knit_upvr.GetService("RebirthService")
	var8_upvw = Knit_upvr.GetService("ShopService")
	var4_upvw = Knit_upvr.GetController("DataController")
	var5_upvw = Knit_upvr.GetController("UIController")
	var6_upvw = Knit_upvr.GetController("SoundController")
	var11_upvw = require(Knit_upvr.Modules.Button)
	var12_upvw = require(ReplicatedStorage_upvr.Shared.Functions)
	var13_upvw = require(ReplicatedStorage_upvr.Shared.List.Rebirths)
	var14_upvw = require(ReplicatedStorage_upvr.Shared.Variables)
	var83_upvw = require(ReplicatedStorage_upvr.Packages.Signal)
	var15_upvw = require(ReplicatedStorage_upvr.Shared.List.Upgrades)
	var16_upvw = require(ReplicatedStorage_upvr.Shared.List.Shop.IDs)
	arg1.removeAutoRebirthGradient = var83_upvw.new()
end
return any_new_result1