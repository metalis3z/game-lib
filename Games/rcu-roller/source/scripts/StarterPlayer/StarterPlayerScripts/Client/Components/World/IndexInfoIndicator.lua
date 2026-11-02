-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:23:02
-- Luau version 6, Types version 3
-- Time taken: 0.001526 seconds

local Knit_upvr = require(game:GetService("ReplicatedStorage").Packages.Knit)
local any_new_result1 = require(Knit_upvr.Util.Component).new({
	Tag = "IndexInfoIndicator";
})
local var4_upvw
local var5_upvw
local var6_upvw
local var7_upvw
function any_new_result1.Start(arg1) -- Line 34
	--[[ Upvalues[5]:
		[1]: var5_upvw (read and write)
		[2]: Knit_upvr (readonly)
		[3]: var4_upvw (read and write)
		[4]: var6_upvw (read and write)
		[5]: var7_upvw (read and write)
	]]
	arg1._trove = var5_upvw.new()
	arg1._trove:Add(Knit_upvr.listenToUpdate:Connect(function() -- Line 37
		--[[ Upvalues[4]:
			[1]: var4_upvw (copied, read and write)
			[2]: var6_upvw (copied, read and write)
			[3]: var7_upvw (copied, read and write)
			[4]: arg1 (readonly)
		]]
		local any_getData_result1 = var4_upvw:getData()
		local var14
		if not any_getData_result1 then
		else
			var14 = false
			for i, _ in var6_upvw do
				if var7_upvw.indexUtils.countIndex(any_getData_result1, true) >= var6_upvw[i].required and not table.find(any_getData_result1.claimedIndexRewards, i) then
					var14 = true
				end
			end
			if arg1._showing == var14 then return end
			arg1._showing = var14
			arg1.Instance.Visible = var14
		end
	end))
end
function any_new_result1.Stop(arg1) -- Line 69
	arg1._trove:Destroy()
end
local var15_upvw
local var16_upvw
local var17_upvw
local var18_upvw
local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
function any_new_result1.Construct(arg1) -- Line 73
	--[[ Upvalues[10]:
		[1]: var4_upvw (read and write)
		[2]: Knit_upvr (readonly)
		[3]: var15_upvw (read and write)
		[4]: var16_upvw (read and write)
		[5]: var17_upvw (read and write)
		[6]: var18_upvw (read and write)
		[7]: ReplicatedStorage_upvr (readonly)
		[8]: var5_upvw (read and write)
		[9]: var6_upvw (read and write)
		[10]: var7_upvw (read and write)
	]]
	var4_upvw = Knit_upvr.GetController("DataController")
	var15_upvw = Knit_upvr.GetController("UIController")
	var16_upvw = Knit_upvr.GetController("SoundController")
	var17_upvw = Knit_upvr.GetController("MapController")
	var18_upvw = require(ReplicatedStorage_upvr.Shared.Functions)
	var5_upvw = require(ReplicatedStorage_upvr.Packages.Trove)
	var6_upvw = require(ReplicatedStorage_upvr.Shared.List.IndexRewards)
	var7_upvw = require(ReplicatedStorage_upvr.Shared.Util)
end
return any_new_result1