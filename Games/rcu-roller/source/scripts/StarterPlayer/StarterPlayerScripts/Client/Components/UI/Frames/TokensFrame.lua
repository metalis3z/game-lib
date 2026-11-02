-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:22:35
-- Luau version 6, Types version 3
-- Time taken: 0.002136 seconds

local Knit_upvr = require(game:GetService("ReplicatedStorage").Packages.Knit)
local any_new_result1 = require(Knit_upvr.Util.Component).new({
	Tag = "TokensFrame";
})
local var4_upvw
local var5_upvw
local var6_upvw
local var7_upvw
local var8_upvw
local var9_upvw
local LocalPlayer_upvr = game:GetService("Players").LocalPlayer
local MainUI = LocalPlayer_upvr:WaitForChild("PlayerGui"):WaitForChild("MainUI")
local Holder_upvr = MainUI:WaitForChild("Menus"):WaitForChild("TokensFrame"):WaitForChild("Main"):WaitForChild("List"):WaitForChild("Holder")
local MarketplaceService_upvr = game:GetService("MarketplaceService")
function any_new_result1.buttons(arg1) -- Line 44
	--[[ Upvalues[7]:
		[1]: Holder_upvr (readonly)
		[2]: var6_upvw (read and write)
		[3]: var5_upvw (read and write)
		[4]: MarketplaceService_upvr (readonly)
		[5]: LocalPlayer_upvr (readonly)
		[6]: var9_upvw (read and write)
		[7]: var8_upvw (read and write)
	]]
	for _, v_upvr in Holder_upvr:GetChildren() do
		if v_upvr.Name:find("Tokens") then
			local any_new_result1_2_upvr = var6_upvw.new(v_upvr.Main.Robux)
			any_new_result1_2_upvr:buttonUp(function() -- Line 51
				--[[ Upvalues[7]:
					[1]: any_new_result1_2_upvr (readonly)
					[2]: var5_upvw (copied, read and write)
					[3]: MarketplaceService_upvr (copied, readonly)
					[4]: LocalPlayer_upvr (copied, readonly)
					[5]: var9_upvw (copied, read and write)
					[6]: var8_upvw (copied, read and write)
					[7]: v_upvr (readonly)
				]]
				any_new_result1_2_upvr:setToOriginalSize()
				var5_upvw:setToIsPurchasing()
				MarketplaceService_upvr:PromptProductPurchase(LocalPlayer_upvr, var9_upvw[var8_upvw.toCamel(v_upvr.Name)].productId)
			end)
		end
	end
end
local TradeTokens_upvr = MainUI:WaitForChild("HUD"):WaitForChild("Bars"):WaitForChild("Top"):WaitForChild("TradeTokens")
local function getTradeTokenAmount(data)
	if not data or not data.inventory or not data.inventory.exclusive then return 0 end
	for _, itemData in data.inventory.exclusive do
		if type(itemData) == "table" and itemData.nm == "tradeTokens" then
			return itemData.am or 0
		end
	end
	return 0
end
function any_new_result1.toggleTradeTokensTop(arg1, arg2) -- Line 59
	--[[ Upvalues[4]:
		[1]: var4_upvw (read and write)
		[2]: TradeTokens_upvr (readonly)
		[3]: var7_upvw (read and write)
		[4]: var8_upvw (read and write)
	]]
	if _G.isTradingPlaza then
	else
		TradeTokens_upvr.Visible = arg2
		if not arg2 then return end
		TradeTokens_upvr.Amount.Text = var8_upvw.suffixes(getTradeTokenAmount(var4_upvw.data))
	end
end
function any_new_result1.opened(arg1) -- Line 76
	arg1:toggleTradeTokensTop(true)
end
function any_new_result1.closing(arg1) -- Line 80
	arg1:toggleTradeTokensTop(false)
end
function any_new_result1.Start(arg1) -- Line 84
	--[[ Upvalues[1]:
		[1]: var5_upvw (read and write)
	]]
	arg1:buttons()
	arg1:opened()
	var5_upvw:listenToOpen("TokensFrame"):Connect(function() -- Line 88
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:opened()
	end)
	var5_upvw:listenToClosing("TokensFrame"):Connect(function() -- Line 91
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:closing()
	end)
end
local var26_upvw
local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
function any_new_result1.Construct(arg1) -- Line 96
	--[[ Upvalues[9]:
		[1]: var4_upvw (read and write)
		[2]: Knit_upvr (readonly)
		[3]: var5_upvw (read and write)
		[4]: var26_upvw (read and write)
		[5]: var6_upvw (read and write)
		[6]: var7_upvw (read and write)
		[7]: ReplicatedStorage_upvr (readonly)
		[8]: var8_upvw (read and write)
		[9]: var9_upvw (read and write)
	]]
	var4_upvw = Knit_upvr.GetController("DataController")
	var5_upvw = Knit_upvr.GetController("UIController")
	var26_upvw = Knit_upvr.GetController("SoundController")
	var6_upvw = require(Knit_upvr.Modules.Button)
	var7_upvw = require(ReplicatedStorage_upvr.Shared.Util)
	var8_upvw = require(ReplicatedStorage_upvr.Shared.Functions)
	var9_upvw = require(ReplicatedStorage_upvr.Shared.List.Shop.IDs)
end
return any_new_result1