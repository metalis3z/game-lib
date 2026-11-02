-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:21:58
-- Luau version 6, Types version 3
-- Time taken: 0.003184 seconds

local Knit_upvr = require(game:GetService("ReplicatedStorage").Packages.Knit)
local any_new_result1 = require(Knit_upvr.Util.Component).new({
	Tag = "BoothBuyFrame";
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
local BoothBuyFrame_upvr = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("MainUI"):WaitForChild("Menus"):WaitForChild("BoothBuyFrame")
function any_new_result1.update(arg1) -- Line 39
	--[[ Upvalues[6]:
		[1]: var4_upvw (read and write)
		[2]: var6_upvw (read and write)
		[3]: BoothBuyFrame_upvr (readonly)
		[4]: var11_upvw (read and write)
		[5]: var5_upvw (read and write)
		[6]: var12_upvw (read and write)
	]]
	local _selectedOfferData = var6_upvw._selectedOfferData
	local _itemUI = BoothBuyFrame_upvr:FindFirstChild("_itemUI")
	if _itemUI then
		_itemUI:Destroy()
	end
	local any_createItemFromData_result1 = var11_upvw.itemUtils.createItemFromData(_selectedOfferData.item)
	local var19
	if any_createItemFromData_result1:getClass() == "pet" then
		var19 = var5_upvw.uis.pet(any_createItemFromData_result1, {
			name = "_itemUI";
		})
	else
		var19 = var5_upvw.uis.item(any_createItemFromData_result1)
	end
	var19.AnchorPoint = Vector2.new(0.5, 0.5)
	var19.Size = UDim2.fromScale(0.204, 0.298)
	var19.Position = UDim2.fromScale(0.5, 0.575)
	var19.Parent = BoothBuyFrame_upvr
	var5_upvw:createInfoHoverOnGuiStateChange(var19.Main.Click, {
		item = any_createItemFromData_result1;
		unusable = true;
	})
	BoothBuyFrame_upvr.Message.Text = `Buy this item for {var12_upvw.comma(_selectedOfferData.tokens)} Tokens?`
	BoothBuyFrame_upvr.Buy.Price.Label.Text = var12_upvw.comma(_selectedOfferData.tokens)
	BoothBuyFrame_upvr.Buy.Visible = false
	BoothBuyFrame_upvr.Countdown.Visible = true
	for i = 20, 1, -1 do
		if not BoothBuyFrame_upvr.Visible then break end
		BoothBuyFrame_upvr.Countdown.Label.Text = `({i / 10}s)`
		task.wait(0.1)
	end
	BoothBuyFrame_upvr.Countdown.Visible = false
	BoothBuyFrame_upvr.Buy.Visible = true
end
function any_new_result1.buttons(arg1) -- Line 85
	--[[ Upvalues[9]:
		[1]: var10_upvw (read and write)
		[2]: BoothBuyFrame_upvr (readonly)
		[3]: var4_upvw (read and write)
		[4]: var7_upvw (read and write)
		[5]: var5_upvw (read and write)
		[6]: var6_upvw (read and write)
		[7]: var8_upvw (read and write)
		[8]: var9_upvw (read and write)
		[9]: var12_upvw (read and write)
	]]
	var10_upvw.new(BoothBuyFrame_upvr.Buy):buttonUp(function() -- Line 87
		--[[ Upvalues[7]:
			[1]: var4_upvw (copied, read and write)
			[2]: var7_upvw (copied, read and write)
			[3]: var5_upvw (copied, read and write)
			[4]: var6_upvw (copied, read and write)
			[5]: var8_upvw (copied, read and write)
			[6]: var9_upvw (copied, read and write)
			[7]: var12_upvw (copied, read and write)
		]]
		if var7_upvw:getFFlag("tradingPlazaBooths") == false then
			var5_upvw:createMessagePopup({
				fFlagDisabled = true;
				reOpen = "BoothBuyFrame";
			})
			return
		end
		local any_purchaseOffer_result1, any_purchaseOffer_result2 = var8_upvw:purchaseOffer(var6_upvw._selectedOfferId, var6_upvw._openedBoothId)
		if any_purchaseOffer_result1 == "success" then
			var5_upvw:closeAllFrames()
			return
		end

		if any_purchaseOffer_result1 == "notEnoughTokens" then
			var5_upvw:createMessagePopup({
				message = `You're only {any_purchaseOffer_result2} Tokens away from being able to purchase this item! Do you want to get more now?`;
				reOpen = "BoothPlayerFrame";
				button = "Yes!";
				buttonNegative = "No";
				messageSize = UDim2.fromScale(1, 0.67);
				positive = function() -- Line 111, Named "positive"
					--[[ Upvalues[2]:
						[1]: var5_upvw (copied, read and write)
						[2]: var9_upvw (copied, read and write)
					]]
					var5_upvw:openFrame("TokensFrame")
					var9_upvw.setLocation:Fire(2, 2)
				end;
			})
		elseif any_purchaseOffer_result1 == "isTrading" then
			var5_upvw:createMessagePopup({
				message = "Other player is currently trading this item!";
				reOpen = "BoothPlayerFrame";
			})
		else
			var5_upvw:closeAllFrames()
		end

	var10_upvw.new(BoothBuyFrame_upvr.Cancel):buttonUp(function() -- Line 129
		--[[ Upvalues[1]:
			[1]: var5_upvw (copied, read and write)
		]]
		var5_upvw:openFrame("BoothPlayerFrame")
	end)
	var10_upvw.new(BoothBuyFrame_upvr.Countdown):buttonUp(function() -- Line 134
	end)
end
function any_new_result1.opened(arg1) -- Line 139
	arg1:update()
end
function any_new_result1.Start(arg1) -- Line 143
	--[[ Upvalues[1]:
		[1]: var5_upvw (read and write)
	]]
	arg1:buttons()
	arg1:opened()
	var5_upvw:listenToOpen("BoothBuyFrame"):Connect(function() -- Line 147
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:opened()
	end)
end
local var31_upvw
local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
function any_new_result1.Construct(arg1) -- Line 152
	--[[ Upvalues[12]:
		[1]: var8_upvw (read and write)
		[2]: Knit_upvr (readonly)
		[3]: var9_upvw (read and write)
		[4]: var4_upvw (read and write)
		[5]: var5_upvw (read and write)
		[6]: var31_upvw (read and write)
		[7]: var6_upvw (read and write)
		[8]: var7_upvw (read and write)
		[9]: var10_upvw (read and write)
		[10]: var11_upvw (read and write)
		[11]: ReplicatedStorage_upvr (readonly)
		[12]: var12_upvw (read and write)
	]]
	var8_upvw = Knit_upvr.GetService("TradingPlazaService")
	var9_upvw = Knit_upvr.GetService("ShopService")
	var4_upvw = Knit_upvr.GetController("DataController")
	var5_upvw = Knit_upvr.GetController("UIController")
	var31_upvw = Knit_upvr.GetController("SoundController")
	var6_upvw = Knit_upvr.GetController("TradingPlazaController")
	var7_upvw = Knit_upvr.GetController("FFlagController")
	var10_upvw = require(Knit_upvr.Modules.Button)
	var11_upvw = require(ReplicatedStorage_upvr.Shared.Util)
	var12_upvw = require(ReplicatedStorage_upvr.Shared.Functions)
end
return any_new_result1