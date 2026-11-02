-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:22:49
-- Luau version 6, Types version 3
-- Time taken: 0.002998 seconds

local Knit_upvr = require(game:GetService("ReplicatedStorage").Packages.Knit)
local any_new_result1 = require(Knit_upvr.Util.Component).new({
	Tag = "MiniChest";
})
local var4_upvw
local var5_upvw
local var6_upvw
local var7_upvw
local var8_upvw
function any_new_result1.thud(arg1) -- Line 38
	--[[ Upvalues[1]:
		[1]: var6_upvw (read and write)
	]]
	var6_upvw:play("Chest Thud", {
		parent = arg1.Instance;
	})
	arg1:emitHitParticle()
end
function any_new_result1.hit(arg1, arg2) -- Line 45
	arg1:tweenSize(0.01, arg2 + 0.1, "Quad", "Out")
	task.wait(0.05)
	arg1:tweenSize(0.2, arg2, "Quad", "Out")
	arg1:thud()
end
function any_new_result1.emitHitParticle(arg1) -- Line 52
	arg1.Instance.PrimaryPart.Attachment.VFX:Emit(6)
end
local TweenService_upvr = game:GetService("TweenService")
function any_new_result1.tweenSize(arg1, arg2, arg3, arg4, arg5) -- Line 58
	--[[ Upvalues[1]:
		[1]: TweenService_upvr (readonly)
	]]
	local NumberValue_upvr = Instance.new("NumberValue")
	NumberValue_upvr.Value = arg1.Instance:GetScale()
	local tbl = {}
	tbl.Value = arg3
	TweenService_upvr:Create(NumberValue_upvr, TweenInfo.new(arg2, Enum.EasingStyle[arg4], Enum.EasingDirection[arg5]), tbl):Play()
	NumberValue_upvr.Changed:Connect(function() -- Line 63
		--[[ Upvalues[2]:
			[1]: arg1 (readonly)
			[2]: NumberValue_upvr (readonly)
		]]
		arg1.Instance:ScaleTo(NumberValue_upvr.Value)
	end)
	task.spawn(function() -- Line 67
		--[[ Upvalues[1]:
			[1]: NumberValue_upvr (readonly)
		]]
		task.wait(0.1)
		NumberValue_upvr:Destroy()
	end)
end
function any_new_result1.destroyInstance(arg1) -- Line 73
	arg1:tweenSize(0.1, 0.01, "Back", "In")
	task.spawn(function() -- Line 76
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		task.wait(0.1)
		arg1.Instance:Destroy()
	end)
end
local var16_upvw = false
function any_new_result1.claim(arg1) -- Line 82
	--[[ Upvalues[6]:
		[1]: var4_upvw (read and write)
		[2]: var16_upvw (read and write)
		[3]: var8_upvw (read and write)
		[4]: var5_upvw (read and write)
		[5]: var6_upvw (read and write)
		[6]: var7_upvw (read and write)
	]]
	arg1.Instance:WaitForChild("Touch", math.huge)
	local miniChestName_upvr = arg1.Instance:GetAttribute("miniChestName")
	if var4_upvw.data.miniChests[miniChestName_upvr] then
		arg1.Instance:Destroy()
	else
		local ProximityPrompt_upvr = Instance.new("ProximityPrompt", arg1.Instance.PrimaryPart)
		ProximityPrompt_upvr.RequiresLineOfSight = false
		ProximityPrompt_upvr.HoldDuration = 0.5
		ProximityPrompt_upvr.ActionText = "Collect!"
		local miniChestId_upvr = arg1.Instance:GetAttribute("miniChestId")
		ProximityPrompt_upvr.Triggered:Connect(function(arg1_2) -- Line 99
			--[[ Upvalues[10]:
				[1]: var16_upvw (copied, read and write)
				[2]: var4_upvw (copied, read and write)
				[3]: arg1 (readonly)
				[4]: var8_upvw (copied, read and write)
				[5]: miniChestId_upvr (readonly)
				[6]: miniChestName_upvr (readonly)
				[7]: ProximityPrompt_upvr (readonly)
				[8]: var5_upvw (copied, read and write)
				[9]: var6_upvw (copied, read and write)
				[10]: var7_upvw (copied, read and write)
			]]
			if var16_upvw then
			else
				var16_upvw = true
				task.spawn(function() -- Line 105
					--[[ Upvalues[1]:
						[1]: var16_upvw (copied, read and write)
					]]
					task.wait(5)
					var16_upvw = false
				end)
				local any_GetScale_result1 = arg1.Instance:GetScale()
				local any_claimMiniChest_result1, any_claimMiniChest_result2 = var8_upvw:claimMiniChest(miniChestId_upvr, miniChestName_upvr)
				if any_claimMiniChest_result1 == "success" then
					ProximityPrompt_upvr.Enabled = false
					arg1:hit(any_GetScale_result1)
					task.wait(0.75)
					arg1:hit(any_GetScale_result1)
					task.wait(0.75)
					arg1:thud()
					arg1:emitHitParticle()
					arg1:destroyInstance()
					var5_upvw:createNotification("Custom", "<font color=\"#ffffff\"><stroke color=\"#000000\" thickness=\"3\">You collected a Mini Chest!</stroke></font>", 4)
					var6_upvw:play("Mini Chest")
					var7_upvw:createOrbs(any_claimMiniChest_result2, {
						cframe = arg1.Instance.PrimaryPart.CFrame;
					})
				end
			end
		end)
	end
end
function any_new_result1.childAdded(arg1) -- Line 136
	arg1.Instance.ChildAdded:Connect(function(arg1_3) -- Line 137
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		if arg1_3.Name ~= "Touch" then
		else
			if arg1.Instance.PrimaryPart:FindFirstChildWhichIsA("ProximityPrompt") then return end
			arg1:claim()
		end
	end)
end
function any_new_result1.start(arg1) -- Line 150
	--[[ Upvalues[1]:
		[1]: var4_upvw (read and write)
	]]
	task.spawn(function() -- Line 151
		--[[ Upvalues[2]:
			[1]: var4_upvw (copied, read and write)
			[2]: arg1 (readonly)
		]]
		var4_upvw:waitForData()
		arg1:claim()
		arg1:childAdded()
	end)
end
function any_new_result1.Start(arg1) -- Line 158
	arg1:start()
end
local var28_upvw
local var29_upvw
local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local var31_upvw
local var32_upvw
function any_new_result1.Construct(arg1) -- Line 162
	--[[ Upvalues[11]:
		[1]: var8_upvw (read and write)
		[2]: Knit_upvr (readonly)
		[3]: var4_upvw (read and write)
		[4]: var5_upvw (read and write)
		[5]: var6_upvw (read and write)
		[6]: var7_upvw (read and write)
		[7]: var28_upvw (read and write)
		[8]: var29_upvw (read and write)
		[9]: ReplicatedStorage_upvr (readonly)
		[10]: var31_upvw (read and write)
		[11]: var32_upvw (read and write)
	]]
	var8_upvw = Knit_upvr.GetService("RewardService")
	var4_upvw = Knit_upvr.GetController("DataController")
	var5_upvw = Knit_upvr.GetController("UIController")
	var6_upvw = Knit_upvr.GetController("SoundController")
	var7_upvw = Knit_upvr.GetController("OrbController")
	var28_upvw = require(Knit_upvr.Shared.List.Chests)
	var29_upvw = require(ReplicatedStorage_upvr.Shared.Functions)
	var31_upvw = require(ReplicatedStorage_upvr.Shared.Util)
	var32_upvw = require(ReplicatedStorage_upvr.Packages.Shake)
end
return any_new_result1