-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:23:00
-- Luau version 6, Types version 3
-- Time taken: 0.001745 seconds

local Knit_upvr = require(game:GetService("ReplicatedStorage").Packages.Knit)
local any_new_result1 = require(Knit_upvr.Util.Component).new({
	Tag = "TipSign";
})
local var4_upvw
local var5_upvw = 1
function any_new_result1.setRandomTip(arg1) -- Line 34
	--[[ Upvalues[2]:
		[1]: var4_upvw (read and write)
		[2]: var5_upvw (read and write)
	]]
	local TipPart = arg1.Instance:FindFirstChild("TipPart")
	local var7
	if not TipPart then
	else
		var7 = nil
		repeat
			var7 = math.random(1, #var4_upvw)
		until var7 ~= var5_upvw
		var5_upvw = var7
		local SurfaceGui = TipPart:FindFirstChild("SurfaceGui")
		SurfaceGui.Frame.Desc.Text = var4_upvw[var7]
		SurfaceGui.Frame.Title.Text = `Tip #{var7}`
	end
end
function any_new_result1.setRandomTips(arg1) -- Line 52
	task.spawn(function() -- Line 53
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		while true do
			arg1:setRandomTip()
			task.wait(20)
		end
	end)
end
function any_new_result1.childAdded(arg1) -- Line 61
	arg1.Instance.ChildAdded:Connect(function() -- Line 62
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:setRandomTip()
	end)
end
function any_new_result1.Start(arg1) -- Line 67
	arg1:childAdded()
	arg1:setRandomTips()
end
local var11_upvw
local var12_upvw
local var13_upvw
local var14_upvw
local var15_upvw
local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
function any_new_result1.Construct(arg1) -- Line 72
	--[[ Upvalues[8]:
		[1]: var11_upvw (read and write)
		[2]: Knit_upvr (readonly)
		[3]: var12_upvw (read and write)
		[4]: var13_upvw (read and write)
		[5]: var14_upvw (read and write)
		[6]: var15_upvw (read and write)
		[7]: ReplicatedStorage_upvr (readonly)
		[8]: var4_upvw (read and write)
	]]
	var11_upvw = Knit_upvr.GetController("DataController")
	var12_upvw = Knit_upvr.GetController("UIController")
	var13_upvw = Knit_upvr.GetController("SoundController")
	var14_upvw = Knit_upvr.GetController("FFlagController")
	var15_upvw = require(ReplicatedStorage_upvr.Shared.Functions)
	var4_upvw = require(arg1.Instance.Tips)
end
return any_new_result1