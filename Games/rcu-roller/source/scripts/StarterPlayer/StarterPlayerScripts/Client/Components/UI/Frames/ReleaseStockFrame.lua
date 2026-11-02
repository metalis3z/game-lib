-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:22:22
-- Luau version 6, Types version 3
-- Time taken: 0.003342 seconds

local Knit_upvr = require(game:GetService("ReplicatedStorage").Packages.Knit)
local any_new_result1 = require(Knit_upvr.Util.Component).new({
	Tag = "ReleaseStockFrame";
})
local var4_upvw
local var5_upvw
local var6_upvw
local var7_upvw
local var8_upvw
local var9_upvw
local var10_upvw
local LocalPlayer_upvr = game:GetService("Players").LocalPlayer
local Main_upvr = LocalPlayer_upvr:WaitForChild("PlayerGui"):WaitForChild("MainUI"):WaitForChild("Menus"):WaitForChild("ReleaseStockFrame"):WaitForChild("Main")
function any_new_result1.setupFrames(arg1) -- Line 41
	--[[ Upvalues[4]:
		[1]: var4_upvw (read and write)
		[2]: Main_upvr (readonly)
		[3]: var9_upvw (read and write)
		[4]: var10_upvw (read and write)
	]]
	var4_upvw:createInfoHoverOnGuiStateChange(Main_upvr.Rewards.Reward1.Click, {
		item = var9_upvw.pet("Magic Shard");
		unusable = true;
		ignoreExist = true;
	})
	var4_upvw:createInfoHoverOnGuiStateChange(Main_upvr.Rewards.Reward2.Click, {
		item = var9_upvw.exclusiveEgg(var10_upvw.currentExclusiveEgg.name);
		unusable = true;
		ignoreExist = true;
	})
	var4_upvw:createInfoHoverOnGuiStateChange(Main_upvr.Rewards.Reward3.Click, {
		item = var9_upvw.box("potionsChest");
		unusable = true;
		ignoreExist = true;
	})
	var4_upvw:createInfoHoverOnGuiStateChange(Main_upvr.Rewards.Reward4.Click, {
		item = var9_upvw.exclusive("epicLuck");
		unusable = true;
		ignoreExist = true;
	})
	var4_upvw:createInfoHoverOnGuiStateChange(Main_upvr.Rewards.Reward5.Click, {
		item = var9_upvw.mount("magmaHoverboard");
		unusable = true;
		ignoreExist = true;
	})
	for _, v_upvr in Main_upvr.Rewards:GetChildren() do
		if v_upvr:IsA("Frame") then
			local Scale_upvr = v_upvr.Icon.Size.X.Scale
			local Scale_upvr_2 = v_upvr.Icon.Size.X.Scale
			v_upvr.Icon.MouseEnter:Connect(function() -- Line 75
				--[[ Upvalues[3]:
					[1]: v_upvr (readonly)
					[2]: Scale_upvr (readonly)
					[3]: Scale_upvr_2 (readonly)
				]]
				v_upvr.Icon:TweenSize(UDim2.new(Scale_upvr * 1.05, 0, Scale_upvr_2 * 1.05, 0), "Out", "Quad", 0.15, true)
			end)
			v_upvr.Icon.MouseLeave:Connect(function() -- Line 78
				--[[ Upvalues[3]:
					[1]: v_upvr (readonly)
					[2]: Scale_upvr (readonly)
					[3]: Scale_upvr_2 (readonly)
				]]
				v_upvr.Icon:TweenSize(UDim2.new(Scale_upvr, 0, Scale_upvr_2, 0), "Out", "Quad", 0.15, true)
			end)
		end
	end
	task.spawn(function() -- Line 83
		--[[ Upvalues[2]:
			[1]: Main_upvr (copied, readonly)
			[2]: var4_upvw (copied, read and write)
		]]
		for i_2 = 1, 5 do
			var4_upvw.fx.wiggle(Main_upvr.Rewards[`Reward{i_2}`].Icon.Icon, {
				infinite = true;
				timeUntilNext = 9;
			})
			task.wait(0.2)
		end
	end)
end
function any_new_result1.update(arg1) -- Line 96
	--[[ Upvalues[2]:
		[1]: var7_upvw (read and write)
		[2]: Main_upvr (readonly)
	]]
	if not arg1._stock then
	else
		local var30 = var7_upvw.release.stock - (arg1._stock or 0)
		Main_upvr.Left.Text = `{var30} Left!`
		local isEnabled = (var30 > 0)
		Main_upvr.Buy.Visible = isEnabled
	end
end
function any_new_result1.getStock(arg1) -- Line 107
	--[[ Upvalues[1]:
		[1]: var5_upvw (read and write)
	]]
	arg1._stock = var5_upvw:getStock("release")
	arg1:update()
end
function any_new_result1.stockUpdated(arg1, arg2, arg3) -- Line 112
	if arg2 ~= "release" then
	else
		arg1._stock = arg3
		arg1:update()
	end
end
local MarketplaceService_upvr = game:GetService("MarketplaceService")
function any_new_result1.buttons(arg1) -- Line 121
	--[[ Upvalues[6]:
		[1]: var6_upvw (read and write)
		[2]: Main_upvr (readonly)
		[3]: var4_upvw (read and write)
		[4]: MarketplaceService_upvr (readonly)
		[5]: LocalPlayer_upvr (readonly)
		[6]: var8_upvw (read and write)
	]]
	local any_new_result1_upvr = var6_upvw.new(Main_upvr.Buy)
	any_new_result1_upvr:buttonUp(function() -- Line 123
		--[[ Upvalues[5]:
			[1]: any_new_result1_upvr (readonly)
			[2]: var4_upvw (copied, read and write)
			[3]: MarketplaceService_upvr (copied, readonly)
			[4]: LocalPlayer_upvr (copied, readonly)
			[5]: var8_upvw (copied, read and write)
		]]
		any_new_result1_upvr:setToOriginalSize()
		var4_upvw:setToIsPurchasing()
		MarketplaceService_upvr:PromptProductPurchase(LocalPlayer_upvr, var8_upvw.releaseStockPack.productId)
	end)
end
function any_new_result1.opened(arg1) -- Line 130
	arg1:update()
end
function any_new_result1.Start(arg1) -- Line 134
	--[[ Upvalues[2]:
		[1]: var4_upvw (read and write)
		[2]: var5_upvw (read and write)
	]]
	arg1:setupFrames()
	arg1:buttons()
	arg1:getStock()
	arg1:opened()
	var4_upvw:listenToOpen("ReleaseStockFrame"):Connect(function() -- Line 140
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:opened()
	end)
	var5_upvw.stockUpdated:Connect(function(...) -- Line 144
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:stockUpdated(...)
	end)
end
local var37_upvw
local var38_upvw
local var39_upvw
local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
function any_new_result1.Construct(arg1) -- Line 149
	--[[ Upvalues[12]:
		[1]: var5_upvw (read and write)
		[2]: Knit_upvr (readonly)
		[3]: var37_upvw (read and write)
		[4]: var4_upvw (read and write)
		[5]: var38_upvw (read and write)
		[6]: var6_upvw (read and write)
		[7]: var39_upvw (read and write)
		[8]: ReplicatedStorage_upvr (readonly)
		[9]: var7_upvw (read and write)
		[10]: var8_upvw (read and write)
		[11]: var9_upvw (read and write)
		[12]: var10_upvw (read and write)
	]]
	var5_upvw = Knit_upvr.GetService("ShopService")
	var37_upvw = Knit_upvr.GetController("DataController")
	var4_upvw = Knit_upvr.GetController("UIController")
	var38_upvw = Knit_upvr.GetController("SoundController")
	var6_upvw = require(Knit_upvr.Modules.Button)
	var39_upvw = require(ReplicatedStorage_upvr.Shared.Functions)
	var7_upvw = require(ReplicatedStorage_upvr.Shared.List.Shop.Stocks)
	var8_upvw = require(ReplicatedStorage_upvr.Shared.List.Shop.IDs)
	var9_upvw = require(ReplicatedStorage_upvr.Shared.Items)
	var10_upvw = require(ReplicatedStorage_upvr.Shared.Variables)
end
return any_new_result1