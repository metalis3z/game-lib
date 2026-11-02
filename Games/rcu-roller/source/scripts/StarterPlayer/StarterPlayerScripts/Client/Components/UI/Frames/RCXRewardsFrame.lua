-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:22:25
-- Luau version 6, Types version 3
-- Time taken: 0.002065 seconds

local Knit_upvr = require(game:GetService("ReplicatedStorage").Packages.Knit)
local any_new_result1 = require(Knit_upvr.Util.Component).new({
	Tag = "RCXRewardsFrame";
})
local var4_upvw
local var5_upvw
local var6_upvw
local var7_upvw
local var8_upvw
local var9_upvw
local var10_upvw
local var11_upvw
local RCXRewardsFrame_upvr = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("MainUI"):WaitForChild("Menus"):WaitForChild("RCXRewardsFrame")
function any_new_result1.buttons(arg1) -- Line 38
	--[[ Upvalues[5]:
		[1]: var8_upvw (read and write)
		[2]: RCXRewardsFrame_upvr (readonly)
		[3]: var7_upvw (read and write)
		[4]: var5_upvw (read and write)
		[5]: var6_upvw (read and write)
	]]
	var8_upvw.new(RCXRewardsFrame_upvr.Claim):buttonUp(function() -- Line 40
		--[[ Upvalues[3]:
			[1]: var7_upvw (copied, read and write)
			[2]: var5_upvw (copied, read and write)
			[3]: var6_upvw (copied, read and write)
		]]
		if var7_upvw:claimRCXReward() == "success" then
			var5_upvw:closeAllFrames()
			var6_upvw:play("Reward")
		end
	end)
end
local Holder_upvr = RCXRewardsFrame_upvr:WaitForChild("Rewards"):WaitForChild("Canvas"):WaitForChild("Holder")
function any_new_result1.onJoin(arg1) -- Line 49
	--[[ Upvalues[7]:
		[1]: var4_upvw (read and write)
		[2]: var6_upvw (read and write)
		[3]: var5_upvw (read and write)
		[4]: var11_upvw (read and write)
		[5]: var9_upvw (read and write)
		[6]: var10_upvw (read and write)
		[7]: Holder_upvr (readonly)
	]]
	local any_getData_result1 = var4_upvw:getData()
	if any_getData_result1.hasClaimedRCXTier then
	else
		if any_getData_result1.rcxTier == 0 then return end
		var6_upvw:preloadSounds({"Weekly Reward"})
		repeat
			task.wait(1)
		until var5_upvw:isFrameOpen() or #var11_upvw >= any_getData_result1.tutorialStage or any_getData_result1.hasCheckedRCXTier
		var9_upvw.print(`RCX Tier: {any_getData_result1.rcxTier}`)
		for _, v in var10_upvw[any_getData_result1.rcxTier].rewards do
			local any_item_result1 = var5_upvw.uis.item(v, {
				scribble = true;
				container = false;
			})
			any_item_result1.Size = UDim2.fromScale(0.145, 0.749)
			any_item_result1.Parent = Holder_upvr
			var5_upvw:createInfoHoverOnGuiStateChange(any_item_result1.Main.Click, {
				item = v;
				unusable = true;
				ignoreExist = true;
			})
		end
		var5_upvw:openFrame("RCXRewardsFrame")
		var6_upvw:play("Weekly Reward", {
			volume = 0.4;
		})
	end
end
function any_new_result1.Start(arg1) -- Line 95
	--[[ Upvalues[1]:
		[1]: var4_upvw (read and write)
	]]
	task.spawn(function() -- Line 96
		--[[ Upvalues[2]:
			[1]: var4_upvw (copied, read and write)
			[2]: arg1 (readonly)
		]]
		var4_upvw:waitForData()
		arg1:buttons()
		arg1:onJoin()
	end)
end
local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
function any_new_result1.Construct(arg1) -- Line 104
	--[[ Upvalues[10]:
		[1]: var7_upvw (read and write)
		[2]: Knit_upvr (readonly)
		[3]: var4_upvw (read and write)
		[4]: var5_upvw (read and write)
		[5]: var6_upvw (read and write)
		[6]: var8_upvw (read and write)
		[7]: var9_upvw (read and write)
		[8]: ReplicatedStorage_upvr (readonly)
		[9]: var10_upvw (read and write)
		[10]: var11_upvw (read and write)
	]]
	var7_upvw = Knit_upvr.GetService("RewardService")
	var4_upvw = Knit_upvr.GetController("DataController")
	var5_upvw = Knit_upvr.GetController("UIController")
	var6_upvw = Knit_upvr.GetController("SoundController")
	var8_upvw = require(Knit_upvr.Modules.Button)
	var9_upvw = require(ReplicatedStorage_upvr.Shared.Functions)
	var10_upvw = require(ReplicatedStorage_upvr.Shared.List.RCXTiers)
	var11_upvw = require(ReplicatedStorage_upvr.Shared.List.Tutorial)
end
return any_new_result1