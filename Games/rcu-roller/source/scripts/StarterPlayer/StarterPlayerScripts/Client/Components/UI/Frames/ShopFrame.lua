-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:22:19
-- Luau version 6, Types version 3
-- Time taken: 0.024066 seconds

local Knit_upvr = require(game:GetService("ReplicatedStorage").Packages.Knit)
local any_new_result1 = require(Knit_upvr.Util.Component).new({
	Tag = "ShopFrame";
})
local var4_upvw
local var5_upvw
local var6_upvw
local var7_upvw
local var8_upvw
local var9_upvw
local var10_upvw
local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local TweenService_upvr = game:GetService("TweenService")
local MarketplaceService_upvr = game:GetService("MarketplaceService")
local PolicyService_upvr = game:GetService("PolicyService")
local var15_upvw
local var16_upvw
local var17_upvw
local var18_upvw
local var19_upvw
local var20_upvw
local var21_upvw
local var22_upvw
local var23_upvw
local var24_upvw
local var25_upvw
local LocalPlayer_upvr = game:GetService("Players").LocalPlayer
local MainUI = LocalPlayer_upvr:WaitForChild("PlayerGui"):WaitForChild("MainUI")
local ShopFrame_upvr = MainUI:WaitForChild("Menus"):WaitForChild("ShopFrame")
local Holder_upvr = ShopFrame_upvr:WaitForChild("Main"):WaitForChild("Container"):WaitForChild("List"):WaitForChild("Holder")
local List_upvr_2 = ShopFrame_upvr:WaitForChild("Options"):WaitForChild("List")
local GiftingMode_upvr = ShopFrame_upvr:WaitForChild("GiftingMode")
local GiftingMode_upvr_2 = Holder_upvr:WaitForChild("GiftingMode")
local StarterPacks_upvr = Holder_upvr:WaitForChild("StarterPacks")
local ExclusiveEgg_upvr = Holder_upvr:WaitForChild("ExclusiveEgg")
local Passes_upvr = Holder_upvr:WaitForChild("Passes")
local BuyAllGamepasses_upvr = Holder_upvr:WaitForChild("BuyAllGamepasses")
local ExclusiveItems_upvr = Holder_upvr:WaitForChild("ExclusiveItems")
local SupporterPack_upvr = Holder_upvr:WaitForChild("SupporterPack")
local Main_4_upvr = SupporterPack_upvr:WaitForChild("Main")
local Codes_upvr = Holder_upvr:WaitForChild("Codes")
local List_upvr = ShopFrame_upvr:WaitForChild("Displays"):WaitForChild("List")
local vector2_upvw = Vector2.new(0, 0)
local function getTradeTokenAmount(data)
	if not data or not data.inventory or not data.inventory.exclusive then return 0 end
	for _, itemData in data.inventory.exclusive do
		if type(itemData) == "table" and itemData.nm == "tradeTokens" then
			return itemData.am or 0
		end
	end
	return 0
end
function any_new_result1.setPurchaseType(arg1, ...) -- Line 87
	arg1._purchaseType = ...
end
function any_new_result1.getPurchaseType(arg1) -- Line 90
	return arg1._purchaseType or 1
end
function any_new_result1.isGifting(arg1) -- Line 94
	--[[ Upvalues[1]:
		[1]: var8_upvw (read and write)
	]]
	local var43
	if var8_upvw:getGiftingTo() == nil then
		var43 = false
	else
		var43 = true
	end
	return var43
end
function any_new_result1.getAllPassesProductName(arg1, arg2) -- Line 98
	if arg2 == 3 then
		return "buyAllPassesTier3"
	end
	if 4 <= arg2 then
		return "buyAllPassesTier4"
	end
	return "buyAllPassesBasic"
end
function any_new_result1.buyWithTokens(arg1, arg2) -- Line 109
	--[[ Upvalues[7]:
		[1]: var4_upvw (read and write)
		[2]: var7_upvw (read and write)
		[3]: var5_upvw (read and write)
		[4]: var16_upvw (read and write)
		[5]: var20_upvw (read and write)
		[6]: var8_upvw (read and write)
		[7]: var9_upvw (read and write)
	]]
	if var7_upvw:getFFlag("tokenPurchases") == false then
		var5_upvw:createMessagePopup({
			fFlagDisabled = true;
			reOpen = "ShopFrame";
		})
	else
		local data = var4_upvw:getData()
		local tokenBalance = getTradeTokenAmount(data)
		local cachedPrice = var8_upvw:getCachedPrice(arg2)
		local cachedPrice = var8_upvw:getCachedPrice(arg2)
		if tokenBalance < cachedPrice then
			-- Not enough tokens — ask if they want to buy more
			local suffix = ""
			if var20_upvw[arg2] and var20_upvw[arg2].gamePassId then
				suffix = " Gamepass"
			end
			local tbl = {}
			tbl.message = `You're only {cachedPrice - tokenBalance} Tokens away from this{suffix}! Do you want to get more now?`
			tbl.reOpen = "ShopFrame"
			tbl.button = "Yes!"
			tbl.buttonNegative = "No"
			tbl.messageSize = UDim2.fromScale(1, 0.67)
			function tbl.positive() -- Line 134
				--[[ Upvalues[2]:
					[1]: var5_upvw (copied, read and write)
					[2]: var9_upvw (copied, read and write)
				]]
				var5_upvw:openFrame("TokensFrame")
				var9_upvw.setLocation:Fire(2, 1)
			end
			var5_upvw:createMessagePopup(tbl)
			return
		end
		if var9_upvw:buyWithTokens(arg2) == "success" and var5_upvw:getCurrentFrameOpen() == "ShopFrame" then
			task.spawn(function() -- Line 145
				for _ = 1, 10 do
					if var5_upvw:getCurrentFrameOpen() ~= "ShopFrame" then break end
					arg1:toggleTradeTokensTop(true)
					task.wait(0.05)
				end
			end)
		end
	end
end
function any_new_result1.paidRandomItemsRestricted(arg1) -- Line 155
	--[[ Upvalues[4]:
		[1]: PolicyService_upvr (readonly)
		[2]: LocalPlayer_upvr (readonly)
		[3]: var17_upvw (read and write)
		[4]: var5_upvw (read and write)
	]]
	local pcall_result1, pcall_result2 = pcall(function() -- Line 156
		--[[ Upvalues[2]:
			[1]: PolicyService_upvr (copied, readonly)
			[2]: LocalPlayer_upvr (copied, readonly)
		]]
		return PolicyService_upvr:GetPolicyInfoForPlayerAsync(LocalPlayer_upvr)
	end)
	if not pcall_result1 then
		var17_upvw.print(`Kunde inte f\xE5 policy: {pcall_result2}`, warn)
	end
	if not pcall_result1 or pcall_result2.ArePaidRandomItemsRestricted then
		var5_upvw:createMessagePopup({
			message = "Sorry! Your country doesn't allow you to purchase this.";
			reOpen = "ShopFrame";
		})
		return true
	end
end
function any_new_result1.setupStarterPacks(arg1) -- Line 172
	--[[ Upvalues[8]:
		[1]: var22_upvw (read and write)
		[2]: StarterPacks_upvr (readonly)
		[3]: var17_upvw (read and write)
		[4]: var5_upvw (read and write)
		[5]: var15_upvw (read and write)
		[6]: MarketplaceService_upvr (readonly)
		[7]: LocalPlayer_upvr (readonly)
		[8]: var20_upvw (read and write)
	]]
	for i_upvr, v in var22_upvw do
		local Main_10 = StarterPacks_upvr[`{var17_upvw.toPascal(i_upvr)}`].Main
		var5_upvw.fx.bob(Main_10.GiftIcon, {
			timeUntilNext = 0.4;
			time = 0.4;
		})
		for i_2, v_2 in v.rewards do
			local var65
			if v_2:getClass() == "pet" then
				var65 = var5_upvw.uis.pet(v_2, {
					uiStrokeThicknessMult = 0.75;
				})
			else
				var65 = var5_upvw.uis.item(v_2, {
					scribble = false;
					container = true;
					uiStrokeThicknessMult = 0.75;
				})
			end
			var65.LayoutOrder = i_2
			var65.Parent = Main_10.Rewards
			var5_upvw:createInfoHoverOnGuiStateChange(var65.Main.Click, {
				item = v_2;
				unusable = true;
				ignoreExist = true;
			})
		end
		local any_new_result1_3_upvr = var15_upvw.new(Main_10.Buy.Robux)
		any_new_result1_3_upvr:buttonUp(function() -- Line 208
			--[[ Upvalues[7]:
				[1]: arg1 (readonly)
				[2]: any_new_result1_3_upvr (readonly)
				[3]: var5_upvw (copied, read and write)
				[4]: MarketplaceService_upvr (copied, readonly)
				[5]: LocalPlayer_upvr (copied, readonly)
				[6]: var20_upvw (copied, read and write)
				[7]: i_upvr (readonly)
			]]
			if not arg1:isGifting() then
				any_new_result1_3_upvr:setToOriginalSize()
				var5_upvw:setToIsPurchasing()
				MarketplaceService_upvr:PromptProductPurchase(LocalPlayer_upvr, var20_upvw[i_upvr].productId)
				return
			end
		end)
		var15_upvw.new(Main_10.Buy.Tokens):buttonUp(function() -- Line 219
			--[[ Upvalues[2]:
				[1]: arg1 (readonly)
				[2]: i_upvr (readonly)
			]]
			if arg1:getPurchaseType() ~= 2 then
			else
				arg1:buyWithTokens(i_upvr)
			end
		end)
	end
end
function any_new_result1.updateStarterPacks(arg1) -- Line 229
	--[[ Upvalues[4]:
		[1]: var4_upvw (read and write)
		[2]: var22_upvw (read and write)
		[3]: StarterPacks_upvr (readonly)
		[4]: var17_upvw (read and write)
	]]
	-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
	if arg1:isGifting() then return end
	local tbl_3 = {}
	local var82 = {}
	for i_3, v_3 in var22_upvw do
		tbl_3[#tbl_3 + 1] = {
			starterPackId = i_3;
			data = v_3;
		}
		var82[#var82 + 1] = tbl_3[#tbl_3]
	end
	table.sort(var82, function(arg1_2, arg2) -- Line 244
		local var84
		if arg1_2.data.expires >= arg2.data.expires then
			var84 = false
		else
			var84 = true
		end
		return var84
	end)
	-- TODO: rest of updateStarterPacks was lost by decompiler (display sorted packs)
end
function any_new_result1.lightningEffect(arg1) -- Line 279
	--[[ Upvalues[3]:
		[1]: TweenService_upvr (readonly)
		[2]: ExclusiveEgg_upvr (readonly)
		[3]: var5_upvw (read and write)
	]]
	local function lightingEffect_upvr(arg1_3) -- Line 280, Named "lightingEffect"
		--[[ Upvalues[1]:
			[1]: TweenService_upvr (copied, readonly)
		]]
		arg1_3.ImageTransparency = 1
		arg1_3.Visible = true
		local any_Create_result1_2 = TweenService_upvr:Create(arg1_3, TweenInfo.new(0.03, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			ImageTransparency = 0;
		})
		any_Create_result1_2:Play()
		any_Create_result1_2.Completed:Wait()
		task.wait(0.3)
		local any_Create_result1 = TweenService_upvr:Create(arg1_3, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			ImageTransparency = 1;
		})
		any_Create_result1:Play()
		any_Create_result1.Completed:Wait()
		arg1_3.Visible = false
	end
	local var90_upvw = 1
	task.spawn(function()
		while true do
			local chosenIdx
			local children = ExclusiveEgg_upvr.Storm:GetChildren()
			if 1 < #children then
				repeat
					chosenIdx = math.random(1, #children)
				until chosenIdx ~= var90_upvw
				var90_upvw = chosenIdx
			else
				chosenIdx = 1
			end
			if var5_upvw:getCurrentFrameOpen() ~= "ShopFrame" then
				task.wait(1)
			end
			lightingEffect_upvr(children[chosenIdx])
			task.wait(math.random(1, 10) / 10)
		end
	end)
end
function any_new_result1.setupExclusiveEgg(arg1) -- Line 331
	--[[ Upvalues[10]:
		[1]: var5_upvw (read and write)
		[2]: ExclusiveEgg_upvr (readonly)
		[3]: var21_upvw (read and write)
		[4]: var18_upvw (read and write)
		[5]: var19_upvw (read and write)
		[6]: var15_upvw (read and write)
		[7]: var8_upvw (read and write)
		[8]: MarketplaceService_upvr (readonly)
		[9]: LocalPlayer_upvr (readonly)
		[10]: var20_upvw (read and write)
	]]
	arg1:lightningEffect()
	var5_upvw.fx.bob(ExclusiveEgg_upvr.Clip.Egg)
	for i_4, v_4 in var21_upvw[var18_upvw.currentExclusiveEgg.name].pets do
		local any_pet_result1_2 = var19_upvw.pet(i_4)
		local any_pet_result1 = var5_upvw.uis.pet(any_pet_result1_2)
		local Main_5 = any_pet_result1.Main
		Main_5.Percentage.Visible = true
		Main_5.Percentage.Text = `{v_4}%`
		Main_5.Amount.Visible = false
		Main_5.Multiplier.Visible = false
		any_pet_result1.LayoutOrder = -any_pet_result1.LayoutOrder
		any_pet_result1.Parent = ExclusiveEgg_upvr.Rewards
		var5_upvw:createInfoHoverOnGuiStateChange(Main_5.Click, {
			item = any_pet_result1_2;
			ignoreExist = true;
		})
	end
	local any_new_result1_upvr = var15_upvw.new(ExclusiveEgg_upvr.Buttons.Buy1.Buy.Robux)
	any_new_result1_upvr:buttonUp(function() -- Line 359
		--[[ Upvalues[7]:
			[1]: arg1 (readonly)
			[2]: var8_upvw (copied, read and write)
			[3]: var5_upvw (copied, read and write)
			[4]: any_new_result1_upvr (readonly)
			[5]: MarketplaceService_upvr (copied, readonly)
			[6]: LocalPlayer_upvr (copied, readonly)
			[7]: var20_upvw (copied, read and write)
		]]
		if arg1:paidRandomItemsRestricted() then
		else
			if arg1:isGifting() then
				var8_upvw:setPurchaseType(1)
				var8_upvw:setProductName("exclusiveEgg1")
				var5_upvw:openFrame("GiftConfirmationFrame")
				return
			end
			any_new_result1_upvr:setToOriginalSize()
			var5_upvw:setToIsPurchasing()
			MarketplaceService_upvr:PromptProductPurchase(LocalPlayer_upvr, var20_upvw.exclusiveEgg1.productId)
		end
	end)
	var15_upvw.new(ExclusiveEgg_upvr.Buttons.Buy1.Buy.Tokens):buttonUp(function() -- Line 377
		--[[ Upvalues[3]:
			[1]: arg1 (readonly)
			[2]: var8_upvw (copied, read and write)
			[3]: var5_upvw (copied, read and write)
		]]
		if arg1:paidRandomItemsRestricted() then
		else
			if arg1:getPurchaseType() ~= 2 then return end
			if arg1:isGifting() then
				var8_upvw:setPurchaseType(2)
				var8_upvw:setProductName("exclusiveEgg1")
				var5_upvw:openFrame("GiftConfirmationFrame")
				return
			end
			arg1:buyWithTokens("exclusiveEgg1")
		end
	end)
	local any_new_result1_upvr_4 = var15_upvw.new(ExclusiveEgg_upvr.Buttons.Buy3.Buy.Robux)
	any_new_result1_upvr_4:buttonUp(function() -- Line 398
		--[[ Upvalues[7]:
			[1]: arg1 (readonly)
			[2]: var8_upvw (copied, read and write)
			[3]: var5_upvw (copied, read and write)
			[4]: any_new_result1_upvr_4 (readonly)
			[5]: MarketplaceService_upvr (copied, readonly)
			[6]: LocalPlayer_upvr (copied, readonly)
			[7]: var20_upvw (copied, read and write)
		]]
		if arg1:paidRandomItemsRestricted() then
		else
			if arg1:isGifting() then
				var8_upvw:setPurchaseType(1)
				var8_upvw:setProductName("exclusiveEgg3")
				var5_upvw:openFrame("GiftConfirmationFrame")
				return
			end
			any_new_result1_upvr_4:setToOriginalSize()
			var5_upvw:setToIsPurchasing()
			MarketplaceService_upvr:PromptProductPurchase(LocalPlayer_upvr, var20_upvw.exclusiveEgg3.productId)
		end
	end)
	var15_upvw.new(ExclusiveEgg_upvr.Buttons.Buy3.Buy.Tokens):buttonUp(function() -- Line 416
		--[[ Upvalues[3]:
			[1]: arg1 (readonly)
			[2]: var8_upvw (copied, read and write)
			[3]: var5_upvw (copied, read and write)
		]]
		if arg1:paidRandomItemsRestricted() then
		else
			if arg1:getPurchaseType() ~= 2 then return end
			if arg1:isGifting() then
				var8_upvw:setPurchaseType(2)
				var8_upvw:setProductName("exclusiveEgg3")
				var5_upvw:openFrame("GiftConfirmationFrame")
				return
			end
			arg1:buyWithTokens("exclusiveEgg3")
		end
	end)
	local any_new_result1_2_upvr = var15_upvw.new(ExclusiveEgg_upvr.Buttons.Buy10.Buy.Robux)
	any_new_result1_2_upvr:buttonUp(function() -- Line 437
		--[[ Upvalues[7]:
			[1]: arg1 (readonly)
			[2]: var8_upvw (copied, read and write)
			[3]: var5_upvw (copied, read and write)
			[4]: any_new_result1_2_upvr (readonly)
			[5]: MarketplaceService_upvr (copied, readonly)
			[6]: LocalPlayer_upvr (copied, readonly)
			[7]: var20_upvw (copied, read and write)
		]]
		if arg1:paidRandomItemsRestricted() then
		else
			if arg1:isGifting() then
				var8_upvw:setPurchaseType(1)
				var8_upvw:setProductName("exclusiveEgg10")
				var5_upvw:openFrame("GiftConfirmationFrame")
				return
			end
			any_new_result1_2_upvr:setToOriginalSize()
			var5_upvw:setToIsPurchasing()
			MarketplaceService_upvr:PromptProductPurchase(LocalPlayer_upvr, var20_upvw.exclusiveEgg10.productId)
		end
	end)
	var15_upvw.new(ExclusiveEgg_upvr.Buttons.Buy10.Buy.Tokens):buttonUp(function() -- Line 455
		--[[ Upvalues[3]:
			[1]: arg1 (readonly)
			[2]: var8_upvw (copied, read and write)
			[3]: var5_upvw (copied, read and write)
		]]
		if arg1:paidRandomItemsRestricted() then
		else
			if arg1:getPurchaseType() ~= 2 then return end
			if arg1:isGifting() then
				var8_upvw:setPurchaseType(2)
				var8_upvw:setProductName("exclusiveEgg10")
				var5_upvw:openFrame("GiftConfirmationFrame")
				return
			end
			arg1:buyWithTokens("exclusiveEgg10")
		end
	end)
end
function any_new_result1.updateExclusiveEgg(arg1) -- Line 476
	--[[ Upvalues[3]:
		[1]: var7_upvw (read and write)
		[2]: ExclusiveEgg_upvr (readonly)
		[3]: var17_upvw (read and write)
	]]
	local var109 = var7_upvw:getFFlag("exclusiveEggCountdown") - os.time()
	if 0 <= var109 then
		ExclusiveEgg_upvr.Timer.Label.Text = var17_upvw.formatTime(var109)
	else
		ExclusiveEgg_upvr.Timer.Label.Text = "Limited!"
	end
end
function any_new_result1.setupPasses(arg1) -- Line 485
	--[[ Upvalues[11]:
		[1]: var15_upvw (read and write)
		[2]: BuyAllGamepasses_upvr (readonly)
		[3]: var8_upvw (read and write)
		[4]: var17_upvw (read and write)
		[5]: var5_upvw (read and write)
		[6]: var4_upvw (read and write)
		[7]: MarketplaceService_upvr (readonly)
		[8]: LocalPlayer_upvr (readonly)
		[9]: var20_upvw (read and write)
		[10]: Passes_upvr (readonly)
		[11]: var9_upvw (read and write)
	]]
	local any_new_result1_upvr_3 = var15_upvw.new(BuyAllGamepasses_upvr.Main.Buy.Robux)
	any_new_result1_upvr_3:buttonUp(function() -- Line 487
		--[[ Upvalues[9]:
			[1]: arg1 (readonly)
			[2]: var8_upvw (copied, read and write)
			[3]: var17_upvw (copied, read and write)
			[4]: var5_upvw (copied, read and write)
			[5]: var4_upvw (copied, read and write)
			[6]: any_new_result1_upvr_3 (readonly)
			[7]: MarketplaceService_upvr (copied, readonly)
			[8]: LocalPlayer_upvr (copied, readonly)
			[9]: var20_upvw (copied, read and write)
		]]
		if arg1:isGifting() then
			local _, _, _, any_getGiftingTo_result4_2 = var8_upvw:getGiftingTo()
			var17_upvw.print(`Andra spelares RCX Tier: {any_getGiftingTo_result4_2}`)
			var8_upvw:setProductName(arg1:getAllPassesProductName(any_getGiftingTo_result4_2))
			var8_upvw:setPurchaseType(1)
			var5_upvw:openFrame("GiftConfirmationFrame")
		else
			any_new_result1_upvr_3:setToOriginalSize()
			var5_upvw:setToIsPurchasing()
			MarketplaceService_upvr:PromptProductPurchase(LocalPlayer_upvr, var20_upvw[arg1:getAllPassesProductName(var4_upvw:getData().rcxTier)].productId)
		end
	end)
	var15_upvw.new(BuyAllGamepasses_upvr.Main.Buy.Tokens):buttonUp(function() -- Line 509
		--[[ Upvalues[5]:
			[1]: arg1 (readonly)
			[2]: var8_upvw (copied, read and write)
			[3]: var17_upvw (copied, read and write)
			[4]: var5_upvw (copied, read and write)
			[5]: var4_upvw (copied, read and write)
		]]
		if arg1:getPurchaseType() ~= 2 then
		else
			if arg1:isGifting() then
				local _, _, _, any_getGiftingTo_result4_5 = var8_upvw:getGiftingTo()
				var17_upvw.print(`Andra spelares RCX Tier: {any_getGiftingTo_result4_5}`)
				var8_upvw:setPurchaseType(2)
				var8_upvw:setProductName(arg1:getAllPassesProductName(any_getGiftingTo_result4_5))
				var5_upvw:openFrame("GiftConfirmationFrame")
				return
			end
			arg1:buyWithTokens(arg1:getAllPassesProductName(var4_upvw:getData().rcxTier))
		end
	end)
	for i_5_upvr, v_5_upvr in var20_upvw do
		if v_5_upvr.gamePassId then
			local Main_6 = Passes_upvr:FindFirstChild(var17_upvw.toPascal(i_5_upvr)).Main
			local any_new_result1_upvr_2 = var15_upvw.new(Main_6.Buy.Robux)
			any_new_result1_upvr_2:buttonUp(function() -- Line 541
				--[[ Upvalues[9]:
					[1]: arg1 (readonly)
					[2]: var8_upvw (copied, read and write)
					[3]: i_5_upvr (readonly)
					[4]: var5_upvw (copied, read and write)
					[5]: any_new_result1_upvr_2 (readonly)
					[6]: MarketplaceService_upvr (copied, readonly)
					[7]: LocalPlayer_upvr (copied, readonly)
					[8]: v_5_upvr (readonly)
					[9]: var9_upvw (copied, read and write)
				]]
				if arg1:isGifting() then
					var8_upvw:setProductName(i_5_upvr)
					var8_upvw:setPurchaseType(1)
					var5_upvw:openFrame("GiftConfirmationFrame")
				else
					any_new_result1_upvr_2:setToOriginalSize()
					var5_upvw:setToIsPurchasing()
					MarketplaceService_upvr:PromptGamePassPurchase(LocalPlayer_upvr, v_5_upvr.gamePassId)
					if i_5_upvr == "autoRebirth" then
						var9_upvw.setLocation:Fire(3, 1)
						return
					end
					if i_5_upvr == "insaneFarmer" then
						var9_upvw.setLocation:Fire(4, 1)
					end
				end
			end)
			var15_upvw.new(Main_6.Buy.Tokens):buttonUp(function() -- Line 561
				--[[ Upvalues[4]:
					[1]: arg1 (readonly)
					[2]: var8_upvw (copied, read and write)
					[3]: i_5_upvr (readonly)
					[4]: var5_upvw (copied, read and write)
				]]
				if arg1:getPurchaseType() ~= 2 then
				else
					if arg1:isGifting() then
						var8_upvw:setPurchaseType(2)
						var8_upvw:setProductName(i_5_upvr)
						var5_upvw:openFrame("GiftConfirmationFrame")
						return
					end
					arg1:buyWithTokens(i_5_upvr)
				end
			end)
		end
	end
end
function any_new_result1.updatePasses(arg1) -- Line 578
	--[[ Upvalues[6]:
		[1]: var4_upvw (read and write)
		[2]: var25_upvw (read and write)
		[3]: BuyAllGamepasses_upvr (readonly)
		[4]: var17_upvw (read and write)
		[5]: var20_upvw (read and write)
		[6]: Passes_upvr (readonly)
	]]
	if arg1:isGifting() then
	else
		local any_getData_result1 = var4_upvw:getData()
		local var141 = var25_upvw[arg1:getAllPassesProductName(any_getData_result1.rcxTier)]
		-- Variable reuse fix: separate the boolean from the UI references
		local showBuyAll
		if var17_upvw.getAmountInTable(any_getData_result1.passes) > 4 then
			showBuyAll = false
		else
			showBuyAll = true
		end
		BuyAllGamepasses_upvr.Visible = showBuyAll
		BuyAllGamepasses_upvr.Main.Buy.Robux.Price.Price.Label.Text = var141.price
		BuyAllGamepasses_upvr.Main.Buy.Tokens.Price.Price.Label.Text = var141.price
		BuyAllGamepasses_upvr.Main.Sale.Text = `-{var141.discountPercentage}%`
		for i_12, v_8 in var20_upvw do
			if v_8.gamePassId then
				local Main_3 = Passes_upvr:FindFirstChild(var17_upvw.toPascal(i_12)).Main
				Main_3.Owned.Visible = any_getData_result1.passes[i_12]
				if any_getData_result1.passes[i_12] then
					Main_3.Buy.Robux.Visible = false
					Main_3.Buy.Tokens.Visible = false
				end
			end
		end
	end
end
function any_new_result1.setupExclusiveItems(arg1) -- Line 610
	--[[ Upvalues[8]:
		[1]: ExclusiveItems_upvr (readonly)
		[2]: var15_upvw (read and write)
		[3]: var8_upvw (read and write)
		[4]: var5_upvw (read and write)
		[5]: MarketplaceService_upvr (readonly)
		[6]: LocalPlayer_upvr (readonly)
		[7]: var20_upvw (read and write)
		[8]: var23_upvw (read and write)
	]]
	for i_6_upvr = 1, 3 do
		local Main_8 = ExclusiveItems_upvr[i_6_upvr].Main
		local any_new_result1_4_upvr = var15_upvw.new(Main_8.Buy.Robux)
		any_new_result1_4_upvr:buttonUp(function() -- Line 616
			--[[ Upvalues[8]:
				[1]: arg1 (readonly)
				[2]: var8_upvw (copied, read and write)
				[3]: i_6_upvr (readonly)
				[4]: var5_upvw (copied, read and write)
				[5]: any_new_result1_4_upvr (readonly)
				[6]: MarketplaceService_upvr (copied, readonly)
				[7]: LocalPlayer_upvr (copied, readonly)
				[8]: var20_upvw (copied, read and write)
			]]
			if arg1:isGifting() then
				var8_upvw:setProductName(`exclusiveItem{i_6_upvr}`)
				var8_upvw:setPurchaseType(1)
				var5_upvw:openFrame("GiftConfirmationFrame")
			else
				any_new_result1_4_upvr:setToOriginalSize()
				var5_upvw:setToIsPurchasing()
				MarketplaceService_upvr:PromptProductPurchase(LocalPlayer_upvr, var20_upvw[`exclusiveItem{i_6_upvr}`].productId)
			end
		end)
		var15_upvw.new(Main_8.Buy.Tokens):buttonUp(function() -- Line 630
			--[[ Upvalues[4]:
				[1]: arg1 (readonly)
				[2]: var8_upvw (copied, read and write)
				[3]: i_6_upvr (readonly)
				[4]: var5_upvw (copied, read and write)
			]]
			if arg1:getPurchaseType() ~= 2 then
			else
				if arg1:isGifting() then
					var8_upvw:setPurchaseType(2)
					var8_upvw:setProductName(`exclusiveItem{i_6_upvr}`)
					var5_upvw:openFrame("GiftConfirmationFrame")
					return
				end
				arg1:buyWithTokens(`exclusiveItem{i_6_upvr}`)
			end
		end)
		if var23_upvw[i_6_upvr].rewards then
			var5_upvw:createInfoHoverOnGuiStateChange(Main_8.ExclusiveContainer.Click, {
				item = var23_upvw[i_6_upvr].rewards[1];
				unusable = true;
			})
		end
		local ExclusiveContainer = Main_8.ExclusiveContainer
		local ExclusiveIcon_upvr = ExclusiveContainer.ExclusiveIcon
		local Scale_upvr = ExclusiveIcon_upvr.Size.X.Scale
		local Scale_upvr_2 = ExclusiveIcon_upvr.Size.X.Scale
		ExclusiveContainer.MouseEnter:Connect(function() -- Line 657
			--[[ Upvalues[3]:
				[1]: ExclusiveIcon_upvr (readonly)
				[2]: Scale_upvr (readonly)
				[3]: Scale_upvr_2 (readonly)
			]]
			ExclusiveIcon_upvr:TweenSize(UDim2.new(Scale_upvr * 1.05, 0, Scale_upvr_2 * 1.05, 0), "Out", "Quad", 0.15, true)
		end)
		ExclusiveContainer.MouseLeave:Connect(function() -- Line 660
			--[[ Upvalues[3]:
				[1]: ExclusiveIcon_upvr (readonly)
				[2]: Scale_upvr (readonly)
				[3]: Scale_upvr_2 (readonly)
			]]
			ExclusiveIcon_upvr:TweenSize(UDim2.new(Scale_upvr, 0, Scale_upvr_2, 0), "Out", "Quad", 0.15, true)
		end)
	end
end
function any_new_result1.updateExclusiveItems(arg1) -- Line 666
	--[[ Upvalues[3]:
		[1]: var4_upvw (read and write)
		[2]: ExclusiveItems_upvr (readonly)
		[3]: var23_upvw (read and write)
	]]
	if arg1:isGifting() then
	else
		for var155 = 1, 3 do
			local Main = ExclusiveItems_upvr[var155].Main
			local var157 = var23_upvw[var155].stock - ((var4_upvw:getData().inventory and var4_upvw:getData().inventory.exclusive and var4_upvw:getData().inventory.exclusive[var23_upvw[var155].id]) or 0)
			Main.Amount.Text = `{var157} Left`
			if var157 <= 0 then
				Main.Buy.Robux.Visible = false
				Main.Buy.Tokens.Visible = false
			end
		end
	end
end
local Rewards_upvr = Main_4_upvr:WaitForChild("Clip"):WaitForChild("Rewards")
local Assets_upvr = ReplicatedStorage_upvr.Assets
function any_new_result1.updateSupporterPack(arg1) -- Line 690
	--[[ Upvalues[11]:
		[1]: var4_upvw (read and write)
		[2]: var24_upvw (read and write)
		[3]: Rewards_upvr (readonly)
		[4]: Assets_upvr (readonly)
		[5]: var5_upvw (read and write)
		[6]: var17_upvw (read and write)
		[7]: var15_upvw (read and write)
		[8]: var9_upvw (read and write)
		[9]: var6_upvw (read and write)
		[10]: Main_4_upvr (readonly)
		[11]: List_upvr (readonly)
	]]
	-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
	local any_getData_result1_2_upvr = var4_upvw:getData()
	local var165_upvr
	for i_7 = 1, 4 do
		local var166_upvr = (any_getData_result1_2_upvr.supporterPackTier or 0) + i_7
		var165_upvr = var24_upvw
		local var167_upvr = var165_upvr[var166_upvr]
		local var168
		if var167_upvr then
			var165_upvr = Rewards_upvr
			var168 = var166_upvr
			var165_upvr = var165_upvr:FindFirstChild(var168)
			if not var165_upvr then
				var168 = Assets_upvr
				var165_upvr = var168.UI.SupporterPack:Clone()
				local Main_9 = var165_upvr.Main
				var168 = var5_upvw.uis.item(var167_upvr.item)
				var168.AnchorPoint = Vector2.new(0.5, 0.5)
				var168.Position = UDim2.fromScale(0.5, 0.5)
				var168.Size = UDim2.fromScale(0.9, 0.9)
				local Amount = var168.Main.Amount
				Amount.Position += UDim2.fromScale(0.1, -0.075)
				var168.Parent = Main_9.RewardContainer
				Main_9.State.Robux.Price.Price.Text = var17_upvw.suffixes(var17_upvw.floatingPoint(var167_upvr.required))
				var165_upvr.Name = var166_upvr
				var165_upvr.LayoutOrder = var166_upvr
				var165_upvr.Parent = Rewards_upvr
				var5_upvw:createInfoHoverOnGuiStateChange(var168.Main.Click, {
					item = var167_upvr.item;
					ignoreExist = true;
					unusable = true;
				})
				var15_upvw.new(Main_9.State):buttonUp(function() -- Line 724
					--[[ Upvalues[8]:
						[1]: arg1 (readonly)
						[2]: any_getData_result1_2_upvr (readonly)
						[3]: var167_upvr (readonly)
						[4]: var5_upvw (copied, read and write)
						[5]: var166_upvr (readonly)
						[6]: var9_upvw (copied, read and write)
						[7]: var165_upvr (readonly)
						[8]: var6_upvw (copied, read and write)
					]]
					if tick() - (arg1._debounce or 0) < 0.4 then
					else
						arg1._debounce = tick()
						if any_getData_result1_2_upvr.stats.robuxSpent < var167_upvr.required then
							var5_upvw:createMessagePopup({
								message = `<font color="#002036">You're only <font color="#49e41b"><stroke color="#143809" thickness="$t">{var167_upvr.required - any_getData_result1_2_upvr.stats.robuxSpent}</stroke></font> away from being able to claim this free reward!</font>`;
								messageSize = UDim2.fromScale(1, 0.75);
								reOpen = "ShopFrame";
							})
							return
						end
						if any_getData_result1_2_upvr.supporterPackTier + 1 ~= var166_upvr then
							var5_upvw:createMessagePopup({
								message = "Claim previous rewards first!";
								reOpen = "ShopFrame";
							})
							return
						end
						if var9_upvw:claimSupporterPack() == "success" then
							var165_upvr:Destroy()
							var6_upvw:play("Supporter Pack")
							var5_upvw.fx.confetti()
						end
					end
				end)
			end
			var165_upvr = Rewards_upvr[var166_upvr]
			local Main_7 = var165_upvr.Main
			if var167_upvr.required > any_getData_result1_2_upvr.stats.robuxSpent then
				var168 = false
			else
				var168 = true
			end
		local var176 = var168 and (any_getData_result1_2_upvr.supporterPackTier + 1 == var166_upvr)
			Main_7.State.Claim.Visible = var176
			Main_7.State.Robux.Visible = not var176
		end
	end
	-- Variable reuse fix: var166_upvr was being used as both Main_4_upvr (Frame) and stats table
	-- The supporter pack limited display shows total robuxSpent
	local stats = any_getData_result1_2_upvr.stats
	Main_4_upvr.Limited.Amount.Price.Text = var17_upvw.suffixes(stats.robuxSpent)
	Main_4_upvr.Limited.Amount.Price.Label.Text = var17_upvw.suffixes(stats.robuxSpent)
end
local Canvas_upvr = Codes_upvr:WaitForChild("Main"):WaitForChild("Canvas")
function any_new_result1.setupCodes(arg1) -- Line 785
	--[[ Upvalues[4]:
		[1]: var15_upvw (read and write)
		[2]: Canvas_upvr (readonly)
		[3]: var10_upvw (read and write)
		[4]: var5_upvw (read and write)
	]]
	var15_upvw.new(Canvas_upvr.Enter):buttonUp(function() -- Line 787
		--[[ Upvalues[3]:
			[1]: var10_upvw (copied, read and write)
			[2]: Canvas_upvr (copied, readonly)
			[3]: var5_upvw (copied, read and write)
		]]
		local any_redeem_result1 = var10_upvw:redeem(Canvas_upvr.Input.TextBox.Text)
		if any_redeem_result1 == "success" then
		else
			if any_redeem_result1 == "invalid" then
				var5_upvw:createMessagePopup({
					message = "This code does not exist!";
					reOpen = "ShopFrame";
				})
				return
			end
			if any_redeem_result1 == "redeemed" then
				var5_upvw:createMessagePopup({
					message = "You have already redeemed this code!";
					reOpen = "ShopFrame";
				})
				return
			end
			if any_redeem_result1 == "expired" then
				var5_upvw:createMessagePopup({
					message = "This code has expired!";
					reOpen = "ShopFrame";
				})
				return
			end
			if any_redeem_result1 == "maxUsed" then
				var5_upvw:createMessagePopup({
					message = "This code has no more uses!";
					reOpen = "ShopFrame";
				})
			end
		end
	end)
end
function any_new_result1.buttons(arg1) -- Line 815
	--[[ Upvalues[11]:
		[1]: List_upvr (readonly)
		[2]: var15_upvw (read and write)
		[3]: Holder_upvr (readonly)
		[4]: TweenService_upvr (readonly)
		[5]: List_upvr_2 (readonly)
		[6]: ShopFrame_upvr (readonly)
		[7]: var5_upvw (read and write)
		[8]: GiftingMode_upvr_2 (readonly)
		[9]: var9_upvw (read and write)
		[10]: var8_upvw (read and write)
		[11]: GiftingMode_upvr (readonly)
	]]
	for _, v_6_upvr in List_upvr:GetChildren() do
		if v_6_upvr:IsA("Frame") then
			var15_upvw.new(v_6_upvr):buttonUp(function() -- Line 820
				--[[ Upvalues[3]:
					[1]: Holder_upvr (copied, readonly)
					[2]: v_6_upvr (readonly)
					[3]: TweenService_upvr (copied, readonly)
				]]
				local SOME = Holder_upvr:FindFirstChild(`LABEL_{v_6_upvr.Name:upper()}`)
				if not SOME then
					TweenService_upvr:Create(Holder_upvr, TweenInfo.new(0.5), {
						CanvasPosition = Vector2.new(0, 0);
					}):Play()
				else
					TweenService_upvr:Create(Holder_upvr, TweenInfo.new(0.5), {
						CanvasPosition = Vector2.new(0, (Holder_upvr.CanvasPosition.Y) + ((SOME.AbsolutePosition - Holder_upvr.AbsolutePosition).Y - Holder_upvr.AbsoluteSize.Y / 2) + SOME.AbsoluteSize.Y / 2 + workspace.CurrentCamera.ViewportSize.Y / 4.3);
					}):Play()
				end
			end)
		end
	end
	var15_upvw.new(List_upvr_2.Robux):buttonUp(function() -- Line 848
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:setPurchaseType(1)
		arg1:updateRobuxOrTokenButtons()
		arg1:updateOptions()
	end)
	var15_upvw.new(List_upvr_2.Tokens):buttonUp(function() -- Line 855
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:setPurchaseType(2)
		arg1:updateRobuxOrTokenButtons()
		arg1:updateOptions()
	end)
	var15_upvw.new(ShopFrame_upvr.Gifting):buttonUp(function() -- Line 862
		--[[ Upvalues[1]:
			[1]: var5_upvw (copied, read and write)
		]]
		var5_upvw:openFrame("GiftingFrame")
	end)
	var15_upvw.new(GiftingMode_upvr_2.Cancel):buttonUp(function() -- Line 867
		--[[ Upvalues[3]:
			[1]: var9_upvw (copied, read and write)
			[2]: var8_upvw (copied, read and write)
			[3]: arg1 (readonly)
		]]
		var9_upvw:cancelGift()
		var8_upvw:setGiftingTo(nil, nil)
		arg1:updateRobuxOrTokenButtons()
		arg1:updateGiftingVisible(false)
		arg1:update()
	end)
	var15_upvw.new(GiftingMode_upvr.Cancel):buttonUp(function() -- Line 877
		--[[ Upvalues[3]:
			[1]: var9_upvw (copied, read and write)
			[2]: var8_upvw (copied, read and write)
			[3]: arg1 (readonly)
		]]
		var9_upvw:cancelGift()
		var8_upvw:setGiftingTo(nil, nil)
		arg1:updateRobuxOrTokenButtons()
		arg1:updateGiftingVisible(false)
		arg1:update()
	end)
end
function any_new_result1.setCanvasPosition(arg1) -- Line 887
	--[[ Upvalues[3]:
		[1]: TweenService_upvr (readonly)
		[2]: Holder_upvr (readonly)
		[3]: vector2_upvw (read and write)
	]]
	for _ = 1, 15 do
		TweenService_upvr:Create(Holder_upvr, TweenInfo.new(0.01, Enum.EasingStyle.Linear), {
			CanvasPosition = vector2_upvw;
		}):Play()
		task.wait(0.01)
	end
end
function any_new_result1.updateOptions(arg1) -- Line 894
	--[[ Upvalues[1]:
		[1]: List_upvr_2 (readonly)
	]]
	-- Variable reuse fix: var202 was used as both a Color3 and a Frame (List_upvr_2.Tokens)
	local any_getPurchaseType_result1 = arg1:getPurchaseType()
	-- Robux icon: green if selected, dark if not
	if any_getPurchaseType_result1 == 1 then
		List_upvr_2.Robux.Icon.ImageColor3 = Color3.fromRGB(18, 197, 18)
	else
		List_upvr_2.Robux.Icon.ImageColor3 = Color3.fromRGB(0, 32, 54)
	end
	-- Tokens icon: yellow if selected, dark if not
	if any_getPurchaseType_result1 == 2 then
		List_upvr_2.Tokens.Icon.ImageColor3 = Color3.fromRGB(255, 191, 0)
	else
		List_upvr_2.Tokens.Icon.ImageColor3 = Color3.fromRGB(0, 32, 54)
	end
end
local CollectionService_upvr = game:GetService("CollectionService")
function any_new_result1.updateRobuxOrTokenButtons(arg1) -- Line 900
	--[[ Upvalues[1]:
		[1]: CollectionService_upvr (readonly)
	]]
	local any_getPurchaseType_result1_2 = arg1:getPurchaseType()
	for _, v_7 in CollectionService_upvr:GetTagged("RobuxOrTokenButton") do
		local var212
		if any_getPurchaseType_result1_2 ~= 1 then
			var212 = false
		else
			var212 = true
		end
		v_7.Robux.Visible = var212
		if any_getPurchaseType_result1_2 ~= 2 then
			var212 = false
		else
			var212 = true
		end
		v_7.Tokens.Visible = var212
	end
	arg1:update()
end
function any_new_result1.updateGiftingPasses(arg1, arg2, arg3) -- Line 910
	--[[ Upvalues[5]:
		[1]: var25_upvw (read and write)
		[2]: BuyAllGamepasses_upvr (readonly)
		[3]: var17_upvw (read and write)
		[4]: var20_upvw (read and write)
		[5]: Passes_upvr (readonly)
	]]
	local var213 = var25_upvw[arg1:getAllPassesProductName(arg3)]
	local showBuyAll
	if var17_upvw.getAmountInTable(arg2) > 4 then
		showBuyAll = false
	else
		showBuyAll = true
	end
	BuyAllGamepasses_upvr.Visible = showBuyAll
	local robuxPriceLabel = BuyAllGamepasses_upvr.Main.Buy.Robux.Price.Price
	robuxPriceLabel.Label.Text = var213.price
	local tokensPriceLabel = BuyAllGamepasses_upvr.Main.Buy.Tokens.Price.Price
	tokensPriceLabel.Label.Text = var213.price
	BuyAllGamepasses_upvr.Main.Sale.Text = `-{var213.discountPercentage}%`
end
function any_new_result1.updateGiftingExclusiveItems(arg1, arg2) -- Line 939
	--[[ Upvalues[2]:
		[1]: ExclusiveItems_upvr (readonly)
		[2]: var23_upvw (read and write)
	]]
	-- CF ANALYSIS FAILED stub: iterate exclusive items for the gifting target
	if not arg2 then return end
	for i, v in ExclusiveItems_upvr:GetChildren() do
		if v:IsA("Frame") then
			v:Destroy()
		end
	end
end
function any_new_result1.updateGiftingMode(arg1) -- Line 960
	--[[ Upvalues[4]:
		[1]: var8_upvw (read and write)
		[2]: GiftingMode_upvr_2 (readonly)
		[3]: GiftingMode_upvr (readonly)
		[4]: var17_upvw (read and write)
	]]
	-- Variable reuse fix: var223 was used as Frame, string, and function all at once
	local any_getGiftingTo_result1_upvr, any_getGiftingTo_result2_2, any_getGiftingTo_result3_3, any_getGiftingTo_result4_4 = var8_upvw:getGiftingTo()
	if not any_getGiftingTo_result1_upvr then
	else
		arg1:updateGiftingPasses(any_getGiftingTo_result2_2, any_getGiftingTo_result4_4)
		arg1:updateGiftingExclusiveItems(any_getGiftingTo_result3_3)
		local any_getGiftingUserInfos_result1 = var8_upvw:getGiftingUserInfos()
		local username = any_getGiftingUserInfos_result1.Username or "?"
		GiftingMode_upvr_2.Username.Text = `@{username}`
		GiftingMode_upvr.Label.Text = `Gifting To: @{username}`
		-- Display name with verified badge (utf8.char(57344) is the verified badge icon)
		local displayName
		if any_getGiftingUserInfos_result1.HasVerifiedBadge then
			displayName = `{any_getGiftingUserInfos_result1.DisplayName}{utf8.char(57344)}`
		else
			displayName = `{any_getGiftingUserInfos_result1.DisplayName}`
		end
		GiftingMode_upvr_2.DisplayName.Text = displayName
		-- Deferred headshot load
		local function loadHeadshot()
			--[[ Upvalues[4]:
				[1]: GiftingMode_upvr_2 (copied, readonly)
				[2]: var17_upvw (copied, read and write)
				[3]: any_getGiftingTo_result1_upvr (readonly)
				[4]: GiftingMode_upvr (copied, readonly)
			]]
			GiftingMode_upvr_2.PlayerIcon.Icon.Image = var17_upvw.getUserHeadshot(any_getGiftingTo_result1_upvr)
			GiftingMode_upvr.PlayerIcon.Icon.Image = var17_upvw.getUserHeadshot(any_getGiftingTo_result1_upvr)
		end
		task.defer(loadHeadshot)
	end
end
function any_new_result1.updateGiftingVisible(arg1, arg2) -- Line 981
	--[[ Upvalues[7]:
		[1]: GiftingMode_upvr_2 (readonly)
		[2]: GiftingMode_upvr (readonly)
		[3]: StarterPacks_upvr (readonly)
		[4]: SupporterPack_upvr (readonly)
		[5]: Codes_upvr (readonly)
		[6]: Holder_upvr (readonly)
		[7]: ShopFrame_upvr (readonly)
	]]
	GiftingMode_upvr_2.Visible = arg2
	GiftingMode_upvr.Visible = arg2
	StarterPacks_upvr.Visible = not arg2
	SupporterPack_upvr.Visible = not arg2
	Codes_upvr.Visible = not arg2
	Holder_upvr.LABEL_SUPPORTERPACK.Visible = not arg2
	Holder_upvr.LABEL_CODES.Visible = not arg2
	Holder_upvr.LABEL_EXCLUSIVEITEMS.Visible = not arg2
	ShopFrame_upvr.Gifting.Visible = not arg2
end
local TradeTokens_upvr = MainUI:WaitForChild("HUD"):WaitForChild("Bars"):WaitForChild("Top"):WaitForChild("TradeTokens")
function any_new_result1.toggleTradeTokensTop(arg1, arg2) -- Line 996
	--[[ Upvalues[4]:
		[1]: var4_upvw (read and write)
		[2]: TradeTokens_upvr (readonly)
		[3]: var16_upvw (read and write)
		[4]: var17_upvw (read and write)
	]]
	local frame = TradeTokens_upvr
	if _G.isTradingPlaza then
	else
		frame.Visible = arg2
		if not arg2 then return end
		frame.Amount.Text = var17_upvw.suffixes(getTradeTokenAmount(var4_upvw.data))
	end
end
function any_new_result1.setCodesLabel(arg1) -- Line 1013
	--[[ Upvalues[4]:
		[1]: PolicyService_upvr (readonly)
		[2]: LocalPlayer_upvr (readonly)
		[3]: var17_upvw (read and write)
		[4]: Codes_upvr (readonly)
	]]
	local pcall_result1_2, pcall_result2_2 = pcall(function() -- Line 1014
		--[[ Upvalues[2]:
			[1]: PolicyService_upvr (copied, readonly)
			[2]: LocalPlayer_upvr (copied, readonly)
		]]
		return PolicyService_upvr:GetPolicyInfoForPlayerAsync(LocalPlayer_upvr)
	end)
	if not pcall_result1_2 then
		var17_upvw.print(`Kunde inte f\xE5 policy: {pcall_result2_2}`, warn)
	end
	if not pcall_result1_2 or not table.find(pcall_result2_2.AllowedExternalLinkReferences, "Discord") then
		Codes_upvr.Main.Label.Text = "Join our Community Server for Free Items, Boosts & More!"
	else
		Codes_upvr.Main.Label.Text = "Join our Discord Server for Free Items, Boosts & More!"
	end
end
function any_new_result1.update(arg1) -- Line 1029
	--[[ Upvalues[2]:
		[1]: var5_upvw (read and write)
		[2]: var8_upvw (read and write)
	]]
	if var5_upvw:getCurrentFrameOpen() ~= "ShopFrame" then
	else
		arg1:updateStarterPacks()
		arg1:updateExclusiveEgg()
		arg1:updatePasses()
		arg1:updateExclusiveItems()
		arg1:updateSupporterPack()
		if arg1:isGifting() then
			local _, any_getGiftingTo_result2, any_getGiftingTo_result3_2, any_getGiftingTo_result4_3 = var8_upvw:getGiftingTo()
			arg1:updateGiftingPasses(any_getGiftingTo_result2, any_getGiftingTo_result4_3)
			arg1:updateGiftingExclusiveItems(any_getGiftingTo_result3_2)
			arg1:updateGiftingVisible(true)
		end
	end
end
function any_new_result1.onSet(arg1) -- Line 1048
	--[[ Upvalues[1]:
		[1]: var4_upvw (read and write)
	]]
	var4_upvw.replica:OnSet({"starterPacks"}, function() -- Line 1049
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:update()
	end)
	var4_upvw.replica:OnSet({"passes"}, function() -- Line 1052
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:update()
	end)
	var4_upvw.replica:OnSet({"exclusiveItems"}, function() -- Line 1055
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:update()
	end)
	var4_upvw.replica:OnSet({"supporterPackTier"}, function() -- Line 1058
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:update()
	end)
end
function any_new_result1.opened(arg1) -- Line 1063
	--[[ Upvalues[1]:
		[1]: var8_upvw (read and write)
	]]
	local any_getGiftingTo_result1, any_getGiftingTo_result2_3, any_getGiftingTo_result3, any_getGiftingTo_result4 = var8_upvw:getGiftingTo()
	if any_getGiftingTo_result1 then
		arg1:updateGiftingMode()
		arg1:updateGiftingPasses(any_getGiftingTo_result2_3, any_getGiftingTo_result4)
		arg1:updateGiftingExclusiveItems(any_getGiftingTo_result3)
	end
	arg1:toggleTradeTokensTop(true)
	arg1:update()
	arg1:setCanvasPosition()
end
function any_new_result1.closing(arg1) -- Line 1076
	--[[ Upvalues[2]:
		[1]: vector2_upvw (read and write)
		[2]: Holder_upvr (readonly)
	]]
	arg1:toggleTradeTokensTop(false)
	vector2_upvw = Holder_upvr.CanvasPosition
end
function any_new_result1.closed(arg1) -- Line 1081
end
function any_new_result1.Start(arg1) -- Line 1085
	--[[ Upvalues[2]:
		[1]: var5_upvw (read and write)
		[2]: Knit_upvr (readonly)
	]]
	arg1:buttons()
	arg1:onSet()
	arg1:updateRobuxOrTokenButtons()
	arg1:setupStarterPacks()
	arg1:setupExclusiveEgg()
	arg1:setupPasses()
	arg1:setupExclusiveItems()
	arg1:setupCodes()
	arg1:setCodesLabel()
	-- Don't call opened() here — trade tokens bar must only show when shop is actually open
	var5_upvw:listenToOpen("ShopFrame"):Connect(function()
		arg1:opened()
	end)
	var5_upvw:listenToClose("ShopFrame"):Connect(function()
		arg1:closed()
	end)
	var5_upvw:listenToClosing("ShopFrame"):Connect(function()
		arg1:closing()
	end)
	-- Listen for token balance changes to update the display
	var4_upvw.replica:OnSet({"inventory", "exclusive"}, function()
		if var5_upvw:getCurrentFrameOpen() == "ShopFrame" then
			arg1:toggleTradeTokensTop(true)
		end
	end)
	Knit_upvr.listenToUpdate:Connect(function()
		arg1:update()
	end)
end
local var250_upvw
function any_new_result1.Construct(arg1) -- Line 1114
	--[[ Upvalues[21]:
		[1]: var9_upvw (read and write)
		[2]: Knit_upvr (readonly)
		[3]: var10_upvw (read and write)
		[4]: var4_upvw (read and write)
		[5]: var5_upvw (read and write)
		[6]: var6_upvw (read and write)
		[7]: var250_upvw (read and write)
		[8]: var7_upvw (read and write)
		[9]: var8_upvw (read and write)
		[10]: var15_upvw (read and write)
		[11]: var16_upvw (read and write)
		[12]: ReplicatedStorage_upvr (readonly)
		[13]: var17_upvw (read and write)
		[14]: var18_upvw (read and write)
		[15]: var19_upvw (read and write)
		[16]: var20_upvw (read and write)
		[17]: var21_upvw (read and write)
		[18]: var22_upvw (read and write)
		[19]: var23_upvw (read and write)
		[20]: var24_upvw (read and write)
		[21]: var25_upvw (read and write)
	]]
	var9_upvw = Knit_upvr.GetService("ShopService")
	var10_upvw = Knit_upvr.GetService("CodesService")
	var4_upvw = Knit_upvr.GetController("DataController")
	var5_upvw = Knit_upvr.GetController("UIController")
	var6_upvw = Knit_upvr.GetController("SoundController")
	var250_upvw = Knit_upvr.GetController("ItemController")
	var7_upvw = Knit_upvr.GetController("FFlagController")
	var8_upvw = Knit_upvr.GetController("ShopController")
	var15_upvw = require(Knit_upvr.Modules.Button)
	var16_upvw = require(ReplicatedStorage_upvr.Shared.Util)
	var17_upvw = require(ReplicatedStorage_upvr.Shared.Functions)
	var18_upvw = require(ReplicatedStorage_upvr.Shared.Variables)
	var19_upvw = require(ReplicatedStorage_upvr.Shared.Items)
	var20_upvw = require(ReplicatedStorage_upvr.Shared.List.Shop.IDs)
	var21_upvw = require(ReplicatedStorage_upvr.Shared.List.Items.ExclusiveEggs)
	var22_upvw = require(ReplicatedStorage_upvr.Shared.List.Shop.StarterPacks)
	var23_upvw = require(ReplicatedStorage_upvr.Shared.List.Shop.ExclusiveItems)
	var24_upvw = require(ReplicatedStorage_upvr.Shared.List.Shop.SupporterPack)
	var25_upvw = require(ReplicatedStorage_upvr.Shared.List.Shop.AllGamepasses)
end
return any_new_result1