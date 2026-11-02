-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:20:17
-- Luau version 6, Types version 3
-- Time taken: 0.003655 seconds

local Knit_upvr = require(game:GetService("ReplicatedStorage").Packages.Knit)
local any_CreateController_result1 = Knit_upvr.CreateController({
	Name = "ShopController";
	_priceCaches = {};
})
local var4_upvw
local var5_upvw
local var6_upvw
local var7_upvw
local var8_upvw
local var9_upvw
function any_CreateController_result1.setGiftingTo(arg1, arg2, arg3, arg4, arg5) -- Line 37
	arg1._userId = arg2
	arg1._passes = arg3
	arg1._exclusiveItems = arg4
	arg1._rcxTier = arg5
	arg1:updateGiftingUserInfos(arg2)
end
function any_CreateController_result1.getGiftingTo(arg1) -- Line 45
	return arg1._userId, arg1._passes, arg1._exclusiveItems, arg1._rcxTier
end
function any_CreateController_result1.setPurchaseType(arg1, arg2) -- Line 49
	arg1._purchaseType = arg2
end
function any_CreateController_result1.getPurchaseType(arg1) -- Line 52
	return arg1._purchaseType
end
function any_CreateController_result1.setProductName(arg1, arg2) -- Line 56
	arg1._productName = arg2
end
function any_CreateController_result1.getProductName(arg1) -- Line 59
	return arg1._productName
end
function any_CreateController_result1.getCachedPrice(arg1, arg2) -- Line 63
	return arg1._priceCaches[arg2]
end
local UserService_upvr = game:GetService("UserService")
function any_CreateController_result1.updateGiftingUserInfos(arg1, arg2) -- Line 67
	--[[ Upvalues[2]:
		[1]: UserService_upvr (readonly)
		[2]: var7_upvw (read and write)
	]]
	local pcall_result1, pcall_result2 = pcall(function() -- Line 68
		--[[ Upvalues[2]:
			[1]: UserService_upvr (copied, readonly)
			[2]: arg2 (readonly)
		]]
		local module = {}
		module[1] = arg2
		return UserService_upvr:GetUserInfosByUserIdsAsync(module)
	end)
	if not pcall_result1 then
		local errMsg = `Kunde inte få gifting user infos: {pcall_result2}`
		var7_upvw.print(errMsg)
	end
	local defaultInfo = {}
	defaultInfo.Id = 0
	defaultInfo.Username = '?'
	defaultInfo.DisplayName = '?'
	defaultInfo.HasVerifiedBadge = false
	local userInfo
	if pcall_result2 and pcall_result2[1] then
		userInfo = pcall_result2[1]
	else
		userInfo = defaultInfo
	end
	arg1._giftingUserInfos = userInfo
end
function any_CreateController_result1.getGiftingUserInfos(arg1) -- Line 87
	return arg1._giftingUserInfos
end
function any_CreateController_result1.purchaseSuccess(arg1) -- Line 91
	--[[ Upvalues[2]:
		[1]: var5_upvw (read and write)
		[2]: var4_upvw (read and write)
	]]
	var4_upvw:play("Purchase Completed")
	var5_upvw:createMessagePopup({
		title = "Nice!";
		message = "Thanks for your purchase! Have a great day! 😄";
		reOpen = var5_upvw:getCurrentFrameOpen();
		noSound = true;
	})
	var5_upvw.fx.confetti()
end
function any_CreateController_result1.purchaseWithTokensSuccess(arg1) -- Line 106
	--[[ Upvalues[2]:
		[1]: var4_upvw (read and write)
		[2]: var5_upvw (read and write)
	]]
	var4_upvw:play("Purchase Completed")
	var5_upvw.fx.confetti()
end
function any_CreateController_result1.giftSuccess(arg1, arg2) -- Line 111
	--[[ Upvalues[3]:
		[1]: var5_upvw (read and write)
		[2]: var8_upvw (read and write)
		[3]: var9_upvw (read and write)
	]]
	var5_upvw:createMessagePopup({
		message = `You successfully gifted to {arg1:getGiftingUserInfos().DisplayName}!`;
		reOpen = "ShopFrame";
		sound = "Purchase Completed";
	})
	if var8_upvw[arg2].gamePassId then
		arg1._passes[arg2] = true
	end
	if arg2:find("exclusiveItem") then
		local tonumber_result1 = tonumber(arg2:gsub("exclusiveItem", ""))
		arg1._exclusiveItems[var9_upvw[tonumber_result1].id] = (arg1._exclusiveItems[var9_upvw[tonumber_result1].id] or 0) + 1
	end
end
local CollectionService_upvr = game:GetService("CollectionService")
function any_CreateController_result1.updateProductPrices(arg1) -- Line 131
	--[[ Upvalues[1]:
		[1]: CollectionService_upvr (readonly)
	]]
	for _, v in CollectionService_upvr:GetTagged("ProductPrice") do
		v.Text = arg1._priceCaches[v:GetAttribute("productName")] or '?'
	end
end
function any_CreateController_result1.setProductPrices(arg1) -- Line 139
	task.spawn(function() -- Line 140
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		while true do
			arg1:updateProductPrices()
			task.wait(240)
		end
	end)
end
function any_CreateController_result1.setPriceCaches(arg1) -- Line 148
	--[[ Upvalues[2]:
		[1]: var8_upvw (read and write)
		[2]: var7_upvw (read and write)
	]]
	task.spawn(function() -- Line 149
		--[[ Upvalues[3]:
			[1]: var8_upvw (copied, read and write)
			[2]: var7_upvw (copied, read and write)
			[3]: arg1 (readonly)
		]]
		while true do
			for i_2, _ in var8_upvw do
				local any_getProductInfo_result1 = var7_upvw.getProductInfo(i_2)
				if any_getProductInfo_result1 then
					arg1._priceCaches[i_2] = any_getProductInfo_result1.PriceInRobux
					task.wait(0.2)
				end
			end
			arg1:updateProductPrices()
			task.wait(300)
		end
	end)
end
function any_CreateController_result1.KnitStart(arg1) -- Line 168
	--[[ Upvalues[1]:
		[1]: var6_upvw (read and write)
	]]
	arg1:setPriceCaches()
	arg1:setProductPrices()
	var6_upvw.purchaseSuccess:Connect(function() -- Line 172
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:purchaseSuccess()
	end)
	var6_upvw.purchaseWithTokensSuccess:Connect(function() -- Line 175
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:purchaseWithTokensSuccess()
	end)
	var6_upvw.giftSuccess:Connect(function(...) -- Line 178
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:giftSuccess(...)
	end)
end
local var34_upvw
local var35_upvw
local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
function any_CreateController_result1.KnitInit(arg1) -- Line 183
	--[[ Upvalues[10]:
		[1]: var6_upvw (read and write)
		[2]: Knit_upvr (readonly)
		[3]: var34_upvw (read and write)
		[4]: var4_upvw (read and write)
		[5]: var5_upvw (read and write)
		[6]: var35_upvw (read and write)
		[7]: ReplicatedStorage_upvr (readonly)
		[8]: var7_upvw (read and write)
		[9]: var8_upvw (read and write)
		[10]: var9_upvw (read and write)
	]]
	var6_upvw = Knit_upvr.GetService("ShopService")
	var34_upvw = Knit_upvr.GetController("DataController")
	var4_upvw = Knit_upvr.GetController("SoundController")
	var5_upvw = Knit_upvr.GetController("UIController")
	var35_upvw = require(ReplicatedStorage_upvr.Shared.Util)
	var7_upvw = require(ReplicatedStorage_upvr.Shared.Functions)
	var8_upvw = require(ReplicatedStorage_upvr.Shared.List.Shop.IDs)
	var9_upvw = require(ReplicatedStorage_upvr.Shared.List.Shop.ExclusiveItems)
end
return any_CreateController_result1