-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:22:27
-- Luau version 6, Types version 3
-- Time taken: 0.002246 seconds

local Knit_upvr = require(game:GetService("ReplicatedStorage").Packages.Knit)
local any_new_result1 = require(Knit_upvr.Util.Component).new({
	Tag = "BoothConfirmSellFrame";
})
local var4_upvw
local var5_upvw
local var6_upvw
local var7_upvw
local var8_upvw
local var9_upvw
local var10_upvw
local var11_upvw
local BoothConfirmSellFrame_upvr = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("MainUI"):WaitForChild("Menus"):WaitForChild("BoothConfirmSellFrame")
function any_new_result1.update(arg1) -- Line 38
	--[[ Upvalues[6]:
		[1]: var4_upvw (read and write)
		[2]: var6_upvw (read and write)
		[3]: BoothConfirmSellFrame_upvr (readonly)
		[4]: var10_upvw (read and write)
		[5]: var5_upvw (read and write)
		[6]: var11_upvw (read and write)
	]]
	local _itemUI = BoothConfirmSellFrame_upvr:FindFirstChild("_itemUI")
	if _itemUI then
		_itemUI:Destroy()
	end
	local any_getItemFromId_result1 = var10_upvw.itemUtils.getItemFromId(var4_upvw:getData(), var6_upvw._offer.itemId)
	local var15
	if any_getItemFromId_result1:getClass() == "pet" then
		var15 = var5_upvw.uis.pet(any_getItemFromId_result1, {
			name = "_itemUI";
			hideAmount = true;
		})
	else
		var15 = var5_upvw.uis.item(any_getItemFromId_result1, {
			hideAmount = true;
		})
	end
	var15.AnchorPoint = Vector2.new(0.5, 0.5)
	var15.Size = UDim2.fromScale(0.204, 0.298)
	var15.Position = UDim2.fromScale(0.5, 0.575)
	var15.Parent = BoothConfirmSellFrame_upvr
	BoothConfirmSellFrame_upvr.Message.Text = `List this for {var11_upvw.comma(var6_upvw._offer.price)} Tokens?`
end
function any_new_result1.buttons(arg1) -- Line 72
	--[[ Upvalues[7]:
		[1]: var9_upvw (read and write)
		[2]: BoothConfirmSellFrame_upvr (readonly)
		[3]: var7_upvw (read and write)
		[4]: var5_upvw (read and write)
		[5]: var6_upvw (read and write)
		[6]: var8_upvw (read and write)
		[7]: var11_upvw (read and write)
	]]
	var9_upvw.new(BoothConfirmSellFrame_upvr.Confirm):buttonUp(function() -- Line 74
		--[[ Upvalues[5]:
			[1]: var7_upvw (copied, read and write)
			[2]: var5_upvw (copied, read and write)
			[3]: var6_upvw (copied, read and write)
			[4]: var8_upvw (copied, read and write)
			[5]: var11_upvw (copied, read and write)
		]]
		if var7_upvw:getFFlag("tradingPlazaBooths") == false then
			var5_upvw:createMessagePopup({
				fFlagDisabled = true;
				reOpen = "BoothConfirmSellFrame";
			})
		else
			local _offer = var6_upvw._offer
			local any_createOffer_result1, any_createOffer_result2 = var8_upvw:createOffer(_offer.itemId, _offer.price, _offer.slot)
			if any_createOffer_result1 == "success" then
				var6_upvw:addOffer(any_createOffer_result2, _offer.itemId, _offer.price, _offer.slot)
				var5_upvw:openFrame("BoothFrame")
			end
			var11_upvw.print(`Create offer result: {any_createOffer_result1}`)
		end
	end)
	var9_upvw.new(BoothConfirmSellFrame_upvr.Cancel):buttonUp(function() -- Line 92
		--[[ Upvalues[1]:
			[1]: var5_upvw (copied, read and write)
		]]
		var5_upvw:openFrame("BoothChooseFrame")
	end)
end
function any_new_result1.opened(arg1) -- Line 97
	arg1:update()
end
function any_new_result1.Start(arg1) -- Line 101
	--[[ Upvalues[1]:
		[1]: var5_upvw (read and write)
	]]
	arg1:buttons()
	arg1:opened()
	var5_upvw:listenToOpen("BoothConfirmSellFrame"):Connect(function() -- Line 105
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:opened()
	end)
end
local var25_upvw
local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
function any_new_result1.Construct(arg1) -- Line 110
	--[[ Upvalues[11]:
		[1]: var8_upvw (read and write)
		[2]: Knit_upvr (readonly)
		[3]: var4_upvw (read and write)
		[4]: var5_upvw (read and write)
		[5]: var25_upvw (read and write)
		[6]: var6_upvw (read and write)
		[7]: var7_upvw (read and write)
		[8]: var9_upvw (read and write)
		[9]: var10_upvw (read and write)
		[10]: ReplicatedStorage_upvr (readonly)
		[11]: var11_upvw (read and write)
	]]
	var8_upvw = Knit_upvr.GetService("TradingPlazaService")
	var4_upvw = Knit_upvr.GetController("DataController")
	var5_upvw = Knit_upvr.GetController("UIController")
	var25_upvw = Knit_upvr.GetController("SoundController")
	var6_upvw = Knit_upvr.GetController("TradingPlazaController")
	var7_upvw = Knit_upvr.GetController("FFlagController")
	var9_upvw = require(Knit_upvr.Modules.Button)
	var10_upvw = require(ReplicatedStorage_upvr.Shared.Util)
	var11_upvw = require(ReplicatedStorage_upvr.Shared.Functions)
end
return any_new_result1