-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:21:40
-- Luau version 6, Types version 3
-- Time taken: 0.002043 seconds

local Knit_upvr = require(game:GetService("ReplicatedStorage").Packages.Knit)
local any_new_result1 = require(Knit_upvr.Util.Component).new({
	Tag = "TradeRequestFrame";
	_sentTradeName = nil;
})
local var4_upvw
local var5_upvw
local TweenService_upvr = game:GetService("TweenService")
local var7_upvw
local MainUI = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("MainUI")
local TradeRequestFrame_upvr = MainUI:WaitForChild("Menus"):WaitForChild("TradeRequestFrame")
local Main_upvr = TradeRequestFrame_upvr:WaitForChild("Main")
local Right = MainUI:WaitForChild("HUD"):WaitForChild("Bars"):WaitForChild("Right")
function any_new_result1.hide(arg1) -- Line 43
	--[[ Upvalues[2]:
		[1]: TweenService_upvr (readonly)
		[2]: TradeRequestFrame_upvr (readonly)
	]]
	task.spawn(function() -- Line 44
		--[[ Upvalues[2]:
			[1]: TweenService_upvr (copied, readonly)
			[2]: TradeRequestFrame_upvr (copied, readonly)
		]]
		TweenService_upvr:Create(TradeRequestFrame_upvr, TweenInfo.new(0.05), {
			Position = UDim2.fromScale(1.1, 0.266);
		}):Play()
		task.wait(0.05)
		TradeRequestFrame_upvr.Visible = false
	end)
end
local Category_upvr = Right:WaitForChild("Category")
local Quests_upvr = Right:WaitForChild("Quests")
function any_new_result1.promptTrade(arg1, arg2) -- Line 51
	--[[ Upvalues[6]:
		[1]: Category_upvr (readonly)
		[2]: Quests_upvr (readonly)
		[3]: TradeRequestFrame_upvr (readonly)
		[4]: TweenService_upvr (readonly)
		[5]: Main_upvr (readonly)
		[6]: var4_upvw (read and write)
	]]
	Category_upvr.Visible = false
	Quests_upvr.Visible = false
	TradeRequestFrame_upvr.Visible = true
	TweenService_upvr:Create(TradeRequestFrame_upvr, TweenInfo.new(0.15), {
		Position = UDim2.fromScale(1.1, 0.266);
	}):Play()
	task.wait(0.15)
	TweenService_upvr:Create(TradeRequestFrame_upvr, TweenInfo.new(0.15), {
		Position = UDim2.fromScale(0.9, 0.266);
	}):Play()
	Main_upvr.DisplayName.Text = `Trade Request from @{arg2}`
	var4_upvw:play("Trade Request", {
		playbackSpeed = 1.15;
	})
	arg1._sentTradeName = arg2
	task.delay(7, function() -- Line 68
		--[[ Upvalues[2]:
			[1]: arg1 (readonly)
			[2]: arg2 (readonly)
		]]
		if arg1._sentTradeName ~= arg2 then
		else
			arg1:hide()
		end
	end)
end
function any_new_result1.buttons(arg1) -- Line 77
	--[[ Upvalues[3]:
		[1]: var7_upvw (read and write)
		[2]: Main_upvr (readonly)
		[3]: var5_upvw (read and write)
	]]
	var7_upvw.new(Main_upvr.Accept):buttonUp(function() -- Line 79
		--[[ Upvalues[2]:
			[1]: var5_upvw (copied, read and write)
			[2]: arg1 (readonly)
		]]
		var5_upvw.acceptTrade:Fire(arg1._sentTradeName)
		arg1:hide()
	end)
	var7_upvw.new(Main_upvr.Decline):buttonUp(function() -- Line 85
		--[[ Upvalues[2]:
			[1]: var5_upvw (copied, read and write)
			[2]: arg1 (readonly)
		]]
		var5_upvw.declineTrade:Fire(arg1._sentTradeName)
		arg1:hide()
	end)
end
function any_new_result1.Start(arg1) -- Line 91
	--[[ Upvalues[1]:
		[1]: var5_upvw (read and write)
	]]
	arg1:buttons()
	var5_upvw.promptTradeRequest:Connect(function(...) -- Line 94
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:promptTrade(...)
	end)
	var5_upvw.tradeAccepted:Connect(function() -- Line 97
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:hide()
	end)
end
local var24_upvw
local var25_upvw
function any_new_result1.Construct(arg1) -- Line 102
	--[[ Upvalues[6]:
		[1]: var5_upvw (read and write)
		[2]: Knit_upvr (readonly)
		[3]: var24_upvw (read and write)
		[4]: var25_upvw (read and write)
		[5]: var4_upvw (read and write)
		[6]: var7_upvw (read and write)
	]]
	var5_upvw = Knit_upvr.GetService("TradeService")
	var24_upvw = Knit_upvr.GetController("DataController")
	var25_upvw = Knit_upvr.GetController("UIController")
	var4_upvw = Knit_upvr.GetController("SoundController")
	var7_upvw = require(Knit_upvr.Modules.Button)
end
return any_new_result1