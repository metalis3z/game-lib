-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:22:24
-- Luau version 6, Types version 3
-- Time taken: 0.003489 seconds

local Knit_upvr = require(game:GetService("ReplicatedStorage").Packages.Knit)
local any_new_result1 = require(Knit_upvr.Util.Component).new({
	Tag = "GiftConfirmationFrame";
})
local var4_upvw
local var5_upvw
local var6_upvw
local var7_upvw
local var8_upvw
local var9_upvw
local var10_upvw
local var11_upvw
local LocalPlayer_upvr = game:GetService("Players").LocalPlayer
local GiftConfirmationFrame_upvr = LocalPlayer_upvr:WaitForChild("PlayerGui"):WaitForChild("MainUI"):WaitForChild("Menus"):WaitForChild("GiftConfirmationFrame")
local PlayerInformation_upvr = GiftConfirmationFrame_upvr:WaitForChild("PlayerInformation")
local MarketplaceService_upvr = game:GetService("MarketplaceService")
function any_new_result1.buttons(arg1) -- Line 42
	--[[ Upvalues[10]:
		[1]: var8_upvw (read and write)
		[2]: GiftConfirmationFrame_upvr (readonly)
		[3]: var5_upvw (read and write)
		[4]: var4_upvw (read and write)
		[5]: var6_upvw (read and write)
		[6]: var10_upvw (read and write)
		[7]: MarketplaceService_upvr (readonly)
		[8]: LocalPlayer_upvr (readonly)
		[9]: var11_upvw (read and write)
		[10]: var7_upvw (read and write)
	]]
	var8_upvw.new(GiftConfirmationFrame_upvr.Cancel):buttonUp(function() -- Line 44
		--[[ Upvalues[1]:
			[1]: var5_upvw (copied, read and write)
		]]
		var5_upvw:openFrame("ShopFrame")
	end)
	local any_new_result1_2_upvr = var8_upvw.new(GiftConfirmationFrame_upvr.Confirm)
	any_new_result1_2_upvr:buttonUp(function() -- Line 49
		--[[ Upvalues[9]:
			[1]: var4_upvw (copied, read and write)
			[2]: var6_upvw (copied, read and write)
			[3]: var10_upvw (copied, read and write)
			[4]: any_new_result1_2_upvr (readonly)
			[5]: var5_upvw (copied, read and write)
			[6]: MarketplaceService_upvr (copied, readonly)
			[7]: LocalPlayer_upvr (copied, readonly)
			[8]: var11_upvw (copied, read and write)
			[9]: var7_upvw (copied, read and write)
		]]
		-- KONSTANTWARNING fixed: variable reuse — any_getCachedPrice_result1 was used both
		-- as the cached numeric price AND then overwritten with a type suffix string " Gamepass"/"".
		-- Separated into two distinct variables: cachedPrice (number) and typeLabel (string).
		local any_getProductName_result1 = var6_upvw:getProductName()
		if var6_upvw:getPurchaseType() == 1 then
			any_new_result1_2_upvr:setToOriginalSize()
			var5_upvw:setToIsPurchasing()
			MarketplaceService_upvr:PromptProductPurchase(LocalPlayer_upvr, var10_upvw[any_getProductName_result1].giftId)
			var5_upvw:openFrame("ShopFrame")
		else
			if var6_upvw:getPurchaseType() == 2 then
				-- FIX: removed dead `if gamePassId then else end` block (CF ANALYSIS FAILED artifact)
				local var20 = 0
				local _data = var4_upvw:getData()
				if _data and _data.inventory and _data.inventory.exclusive then
					for _, itemData in _data.inventory.exclusive do
						if type(itemData) == "table" and itemData.nm == "tradeTokens" then
							var20 = itemData.am or 0
							break
						end
					end
				end
				-- FIX: separated numeric price from type-label string — cannot subtract string from number
				local cachedPrice = var6_upvw:getCachedPrice(any_getProductName_result1)
				local typeLabel
				if var10_upvw[any_getProductName_result1].gamePassId then
					typeLabel = " Gamepass"
				else
					typeLabel = ""
				end
				if var20 < cachedPrice then
					local tbl = {}
					tbl.message = `You're only {cachedPrice - var20} Tokens away from this{typeLabel}! Do you want to get more now?`
					tbl.reOpen = "ShopFrame"
					tbl.button = "Yes!"
					tbl.buttonNegative = "No"
					tbl.messageSize = UDim2.fromScale(1, 0.67)
					function tbl.positive()
						var5_upvw:openFrame("TokensFrame")
					end
					var5_upvw:createMessagePopup(tbl)
					return
				end
				var7_upvw:buyWithTokens(any_getProductName_result1)
			end
		end
end
function any_new_result1.update(arg1) -- Line 91
	--[[ Upvalues[5]:
		[1]: var6_upvw (read and write)
		[2]: PlayerInformation_upvr (readonly)
		[3]: var9_upvw (read and write)
		[4]: var10_upvw (read and write)
		[5]: GiftConfirmationFrame_upvr (readonly)
	]]
	local any_getGiftingUserInfos_result1 = var6_upvw:getGiftingUserInfos()
	PlayerInformation_upvr.Username.Text = any_getGiftingUserInfos_result1.Username
	PlayerInformation_upvr.PlayerIcon.Icon.Image = var9_upvw.getUserHeadshot(any_getGiftingUserInfos_result1.Id)
	local var25
	if var10_upvw[var6_upvw:getProductName()].gamePassId then
		var25 = "Gamepass"
	else
		var25 = ""
	end
	GiftConfirmationFrame_upvr.Product.Text = `{var9_upvw.getProductInfo(var6_upvw:getProductName()).Name} {var25}`
end
function any_new_result1.opened(arg1) -- Line 101
	arg1:update()
end
function any_new_result1.closed(arg1) -- Line 105
	--[[ Upvalues[3]:
		[1]: GiftConfirmationFrame_upvr (readonly)
		[2]: PlayerInformation_upvr (readonly)
		[3]: var9_upvw (read and write)
	]]
	GiftConfirmationFrame_upvr.Product.Text = "..."
	PlayerInformation_upvr.PlayerIcon.Icon.Image = var9_upvw.getUserHeadshot(-1)
end
function any_new_result1.Start(arg1) -- Line 110
	--[[ Upvalues[1]:
		[1]: var5_upvw (read and write)
	]]
	arg1:buttons()
	arg1:opened()
	var5_upvw:listenToOpen("GiftConfirmationFrame"):Connect(function() -- Line 114
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:opened()
	end)
	var5_upvw:listenToClose("GiftConfirmationFrame"):Connect(function() -- Line 117
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:closed()
	end)
end
local var28_upvw
local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local var30_upvw
function any_new_result1.Construct(arg1) -- Line 122
	--[[ Upvalues[12]:
		[1]: var7_upvw (read and write)
		[2]: Knit_upvr (readonly)
		[3]: var4_upvw (read and write)
		[4]: var5_upvw (read and write)
		[5]: var28_upvw (read and write)
		[6]: var6_upvw (read and write)
		[7]: var8_upvw (read and write)
		[8]: var9_upvw (read and write)
		[9]: ReplicatedStorage_upvr (readonly)
		[10]: var10_upvw (read and write)
		[11]: var30_upvw (read and write)
		[12]: var11_upvw (read and write)
	]]
	var7_upvw = Knit_upvr.GetService("ShopService")
	var4_upvw = Knit_upvr.GetController("DataController")
	var5_upvw = Knit_upvr.GetController("UIController")
	var28_upvw = Knit_upvr.GetController("SoundController")
	var6_upvw = Knit_upvr.GetController("ShopController")
	var8_upvw = require(Knit_upvr.Modules.Button)
	var9_upvw = require(ReplicatedStorage_upvr.Shared.Functions)
	var10_upvw = require(ReplicatedStorage_upvr.Shared.List.Shop.IDs)
	var30_upvw = require(Knit_upvr.Modules.LoadingSpinner)
	var11_upvw = require(ReplicatedStorage_upvr.Shared.Util)
end
return any_new_result1