-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:22:59
-- Luau version 6, Types version 3
-- Time taken: 0.002042 seconds

local Knit_upvr = require(game:GetService("ReplicatedStorage").Packages.Knit)
local any_new_result1 = require(Knit_upvr.Util.Component).new({
	Tag = "LeaderboardRewards";
})
local var4_upvw
local var5_upvw
local var6_upvw
local var7_upvw
function any_new_result1.setupFrames(arg1) -- Line 32
	--[[ Upvalues[2]:
		[1]: var5_upvw (read and write)
		[2]: var4_upvw (read and write)
	]]
	for _, v in var5_upvw do
		for _, v_2 in v.rewards do
			if not v_2 then continue end
			local var16
			local tbl_2 = {
				uiStrokeThicknessMult = 0.6;
				defaultIconSize = true;
			}
			local var18
			if v_2:getClass() == "pet" then
				var16 = var4_upvw.uis.pet(v_2, tbl_2)
			else
				var16 = var4_upvw.uis.item(v_2, tbl_2)
			end
			var16.Parent = arg1.Instance.SurfaceGui.ScrollingFrame[`Rewards{v.max}`]
			local tbl = {
				item = v_2;
			}
			var18 = true
			tbl.unusable = var18
			var18 = true
			tbl.ignoreExist = var18
			if v_2:getClass() ~= "upgrade" then
				var18 = false
			else
				var18 = true
			end
			tbl.isTemporary = var18
			if v_2:getClass() ~= "upgrade" then
			else
			end
			tbl.amountInName = true
			var4_upvw:createInfoHoverOnGuiStateChange(var16.Main.Click, tbl)
			arg1._trove:Add(var16)
		end
	end
end
function any_new_result1.update(arg1) -- Line 63
	--[[ Upvalues[1]:
		[1]: var6_upvw (read and write)
	]]
	arg1.Instance.Top.Timer.SurfaceGui.Timer.Text = `Ends in: {var6_upvw.formatTime2(var6_upvw.getWeekOs(var6_upvw.getWeekNumber(7200), 7200) - os.time(), 4)}`
end
function any_new_result1.Start(arg1) -- Line 69
	--[[ Upvalues[2]:
		[1]: var7_upvw (read and write)
		[2]: Knit_upvr (readonly)
	]]
	arg1._trove = var7_upvw.new()
	arg1:setupFrames()
	arg1._trove:Add(Knit_upvr.listenToUpdate:Connect(function() -- Line 74
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:update()
	end))
end
function any_new_result1.Stop(arg1) -- Line 81
	arg1._trove:Destroy()
end
local var21_upvw
local var22_upvw
local var23_upvw
local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
function any_new_result1.Construct(arg1) -- Line 85
	--[[ Upvalues[9]:
		[1]: var21_upvw (read and write)
		[2]: Knit_upvr (readonly)
		[3]: var4_upvw (read and write)
		[4]: var22_upvw (read and write)
		[5]: var23_upvw (read and write)
		[6]: var5_upvw (read and write)
		[7]: ReplicatedStorage_upvr (readonly)
		[8]: var6_upvw (read and write)
		[9]: var7_upvw (read and write)
	]]
	var21_upvw = Knit_upvr.GetController("DataController")
	var4_upvw = Knit_upvr.GetController("UIController")
	var22_upvw = Knit_upvr.GetController("SoundController")
	var23_upvw = Knit_upvr.GetController("MapController")
	var5_upvw = require(ReplicatedStorage_upvr.Shared.List.LeaderboardRewards)
	var6_upvw = require(ReplicatedStorage_upvr.Shared.Functions)
	var7_upvw = require(ReplicatedStorage_upvr.Packages.Trove)
end
return any_new_result1