-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:22:39
-- Luau version 6, Types version 3
-- Time taken: 0.002310 seconds

local Knit_upvr = require(game:GetService("ReplicatedStorage").Packages.Knit)
local any_new_result1 = require(Knit_upvr.Util.Component).new({
	Tag = "Top";
})
local var4_upvw
local var5_upvw
local var6_upvw
local var7_upvw
local var8_upvw
local _ = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("MainUI"):WaitForChild("HUD"):WaitForChild("Bars"):WaitForChild("Bottom")
local tbl_upvr = {"clicks", "gems", "rebirths"}
local TweenService_upvr = game:GetService("TweenService")
function any_new_result1.displayStats(arg1) -- Line 45
	--[[ Upvalues[4]:
		[1]: var4_upvw (read and write)
		[2]: tbl_upvr (readonly)
		[3]: var7_upvw (read and write)
		[4]: TweenService_upvr (readonly)
	]]
	local data_upvr = var4_upvw.data
	for _, v_upvr in tbl_upvr do
		local SOME_upvr = arg1.Instance:FindFirstChild(var7_upvw.toPascal(v_upvr))
		if SOME_upvr then
			local NumberValue_upvr = Instance.new("NumberValue")
			NumberValue_upvr.Changed:Connect(function() -- Line 55
				--[[ Upvalues[3]:
					[1]: SOME_upvr (readonly)
					[2]: var7_upvw (copied, read and write)
					[3]: NumberValue_upvr (readonly)
				]]
				SOME_upvr.Amount.Text = var7_upvw.suffixes(var7_upvw.floatingPoint(NumberValue_upvr.Value, 1))
			end)
			SOME_upvr.Amount.Text = var7_upvw.suffixes(var7_upvw.floatingPoint(NumberValue_upvr.Value, 1))
			TweenService_upvr:Create(NumberValue_upvr, TweenInfo.new(0.5), {
				Value = data_upvr[v_upvr];
			}):Play()
			var4_upvw.replica:OnSet({v_upvr}, function(arg1_2) -- Line 61
				--[[ Upvalues[4]:
					[1]: NumberValue_upvr (readonly)
					[2]: TweenService_upvr (copied, readonly)
					[3]: data_upvr (readonly)
					[4]: v_upvr (readonly)
				]]
				local var21 = arg1_2 - NumberValue_upvr.Value
					local var22 = 0.5
				if var21 <= 1 and 0 < var21 then
					var22 = 0
				end
				TweenService_upvr:Create(NumberValue_upvr, TweenInfo.new(var22), {
					Value = data_upvr[v_upvr];
				}):Play()
			end)
		end
	end
end
function any_new_result1.buttons(arg1) -- Line 73
	--[[ Upvalues[3]:
		[1]: var8_upvw (read and write)
		[2]: var5_upvw (read and write)
		[3]: var6_upvw (read and write)
	]]
	var8_upvw.new(arg1.Instance.TradeTokens.Add):buttonUp(function() -- Line 75
		--[[ Upvalues[2]:
			[1]: var5_upvw (copied, read and write)
			[2]: var6_upvw (copied, read and write)
		]]
		var5_upvw:openFrame("TokensFrame")
		local var25
		if _G.isTradingPlaza then
			var25 = 2
		else
			var25 = 1
		end
		var6_upvw.setLocation:Fire(1, var25)
	end)
end
function any_new_result1.Start(arg1) -- Line 81
	task.spawn(function() -- Line 82
		var4_upvw:waitForData()
		arg1:displayStats()
		arg1:buttons()
	end)
end
local var27_upvw
local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
function any_new_result1.Construct(arg1) -- Line 89
	-- Construct
	--[[ Upvalues[8]:
		[1]: var6_upvw (read and write)
		[2]: Knit_upvr (readonly)
		[3]: var4_upvw (read and write)
		[4]: var5_upvw (read and write)
		[5]: var8_upvw (read and write)
		[6]: var27_upvw (read and write)
		[7]: ReplicatedStorage_upvr (readonly)
		[8]: var7_upvw (read and write)
	]]
	var6_upvw = Knit_upvr.GetService("ShopService")
	var4_upvw = Knit_upvr.GetController("DataController")
	var5_upvw = Knit_upvr.GetController("UIController")
	var8_upvw = require(script.Parent.Parent.Parent.Parent.Modules.Button)
	var27_upvw = require(ReplicatedStorage_upvr.Shared.Util)
	var7_upvw = require(ReplicatedStorage_upvr.Shared.Functions)
end
return any_new_result1