-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:21:50
-- Luau version 6, Types version 3
-- Time taken: 0.004809 seconds

local Knit_upvr = require(game:GetService("ReplicatedStorage").Packages.Knit)
local any_new_result1 = require(Knit_upvr.Util.Component).new({
	Tag = "PrestigeFrame";
})
local var4_upvw
local var5_upvw
local var6_upvw
local var7_upvw
local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local var9_upvw
local var10_upvw
local var11_upvw
local PrestigeFrame_upvr = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("MainUI"):WaitForChild("Menus"):WaitForChild("PrestigeFrame")
local Main = PrestigeFrame_upvr:WaitForChild("Main")
local Holder_upvr = Main:WaitForChild("List"):WaitForChild("Holder")
local Main_upvr = Holder_upvr:WaitForChild("Main")
local Claimed_upvr = Holder_upvr:WaitForChild("Claimed")
local Side_upvr = Main:WaitForChild("Canvas"):WaitForChild("Side")
function any_new_result1.getPrestigeProgress(arg1) -- Line 47
	--[[ Upvalues[2]:
		[1]: var4_upvw (read and write)
		[2]: var11_upvw (read and write)
	]]
	local data = var4_upvw.data
	local prestige = data.prestige
	local var20 = var11_upvw[prestige]
	local var21
	if var11_upvw[prestige + 1] then
		-- var21 = the "required" XP for current tier (baseline), default 0 if no current tier
		if var20 then
			var21 = var20.required
		else
			var21 = 0
		end
		return (data.prestigeXp - var21) / (var11_upvw[prestige + 1].required - var21)
	end
	return 1
end
local Assets_upvr = ReplicatedStorage_upvr.Assets
function any_new_result1.setupFrames(arg1) -- Line 63
	--[[ Upvalues[6]:
		[1]: var4_upvw (read and write)
		[2]: var11_upvw (read and write)
		[3]: Assets_upvr (readonly)
		[4]: var5_upvw (read and write)
		[5]: Main_upvr (readonly)
		[6]: Claimed_upvr (readonly)
	]]
	for i, v in var11_upvw do
		local clone = Assets_upvr.UI.PrestigeReward:Clone()
		clone.PrestigeLabel.Text = v.title
		clone.PrestigeLabel.UIGradient.Color = v.textGradient
		clone.PrestigeLabel.UIStroke.Color = v.textStroke
		clone.UIGradient.Color = v.backgroundGradient
		clone.TagIcon.Image = v.icon
		clone.TagIcon.Shadow.Image = v.icon
		local var32 = v.rewards
		for _, v_2 in var32 do
			local any_item_result1 = var5_upvw.uis.item(v_2, {
				uiStrokeThicknessMult = 0.75;
			})
			any_item_result1.Visible = true
			any_item_result1.Parent = clone.List
			var5_upvw:createInfoHoverOnGuiStateChange(any_item_result1.Main.Click, {
				item = v_2;
				unusable = true;
			})
		end
		clone.Name = i
		clone.Visible = true
		local cloneParent = Main_upvr
		if var4_upvw.data.prestige >= i then
			cloneParent = Claimed_upvr
		end
		clone.Parent = cloneParent
	end
end
function any_new_result1.update(arg1) -- Line 99
	--[[ Upvalues[6]:
		[1]: var4_upvw (read and write)
		[2]: var11_upvw (read and write)
		[3]: Side_upvr (readonly)
		[4]: Holder_upvr (readonly)
		[5]: var10_upvw (read and write)
		[6]: var5_upvw (read and write)
	]]
	local data_2 = var4_upvw.data
	local var41 = var11_upvw[data_2.prestige + 1]
	-- Show side panel only if there's a next prestige tier
	Side_upvr.Visible = var41 ~= nil
	-- hasPrestige: whether player has prestiged at least once
	local hasPrestige = data_2.prestige > 0
	-- Show rewards list when player has NOT yet reached max (i.e. next tier exists means unclaimed exist)
	Holder_upvr.Gap.Visible = not hasPrestige
	Holder_upvr.Main.Visible = not hasPrestige
	Holder_upvr.RewardsText.Visible = not hasPrestige
	-- Show claimed section only if player has at least 1 prestige
	Holder_upvr.ClaimedText.Visible = hasPrestige
	Holder_upvr.Claimed.Visible = hasPrestige
	if var41 then
		local required = var41.required
		local Claim = Side_upvr.Claim
		local lockedVisible
		if data_2.prestigeXp >= required then
			lockedVisible = false
		else
			lockedVisible = true
		end
		Claim.Locked.Visible = lockedVisible
		Side_upvr.PrestigeLabel.Text = `Prestige {var41.title}`
		Side_upvr.XP.Text = `{var10_upvw.suffixes(data_2.prestigeXp)}/{var10_upvw.suffixes(required)} XP`
		local progress = arg1:getPrestigeProgress()
		Side_upvr.LevelProgress.Bar.Size = UDim2.fromScale(math.min(1, progress), 1)
		Holder_upvr.RewardsText.Label.Text = `Rewards ({data_2.prestige}/{#var11_upvw})`
		arg1:removeFramesInParent(Side_upvr.Rewards)
		for _, v_4 in var41.rewards do
			local any_item_result1_2 = var5_upvw.uis.item(v_4)
			any_item_result1_2.Visible = true
			any_item_result1_2.Parent = Side_upvr.Rewards
			var5_upvw:createInfoHoverOnGuiStateChange(any_item_result1_2.Main.Click, {
				item = v_4;
				unusable = true;
			})
		end
	end
end
function any_new_result1.setFrameClaimed(arg1, arg2) -- Line 146
	--[[ Upvalues[2]:
		[1]: Main_upvr (readonly)
		[2]: Claimed_upvr (readonly)
	]]
	Main_upvr[arg2 + 1].Parent = Claimed_upvr
end
function any_new_result1.buttons(arg1) -- Line 150
	--[[ Upvalues[5]:
		[1]: var9_upvw (read and write)
		[2]: Side_upvr (readonly)
		[3]: var4_upvw (read and write)
		[4]: var7_upvw (read and write)
		[5]: var6_upvw (read and write)
	]]
	var9_upvw.new(Side_upvr.Claim):buttonUp(function() -- Line 152
		--[[ Upvalues[4]:
			[1]: var4_upvw (copied, read and write)
			[2]: var7_upvw (copied, read and write)
			[3]: var6_upvw (copied, read and write)
			[4]: arg1 (readonly)
		]]
		if var7_upvw:claim(var4_upvw.data.prestige + 1) == "success" then
			var6_upvw:play("Prestige")
			arg1:setFrameClaimed(var4_upvw.data.prestige)
		end
	end)
end
function any_new_result1.infoHover(arg1) -- Line 164
	--[[ Upvalues[2]:
		[1]: var5_upvw (read and write)
		[2]: PrestigeFrame_upvr (readonly)
	]]
	var5_upvw:createInfoHoverOnGuiStateChange(PrestigeFrame_upvr.Info.Click, {
		hoverType = "prestige";
	})
end
function any_new_result1.removeFramesInParent(arg1, arg2) -- Line 170
	for _, v_3 in arg2:GetChildren() do
		if v_3:IsA("Frame") then
			v_3:Destroy()
		end
	end
end
function any_new_result1.removeFrames(arg1) -- Line 178
	--[[ Upvalues[2]:
		[1]: Main_upvr (readonly)
		[2]: Claimed_upvr (readonly)
	]]
	arg1:removeFramesInParent(Main_upvr)
	arg1:removeFramesInParent(Claimed_upvr)
end
function any_new_result1.opened(arg1) -- Line 183
	arg1:setupFrames()
	arg1:update()
end
function any_new_result1.closed(arg1) -- Line 188
	arg1:removeFrames()
end
function any_new_result1.valuesChanged(arg1) -- Line 192
	--[[ Upvalues[1]:
		[1]: var4_upvw (read and write)
	]]
	var4_upvw.replica:OnSet({"prestige"}, function(arg1_2) -- Line 193
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:update()
	end)
end
function any_new_result1.Start(arg1) -- Line 198
	--[[ Upvalues[1]:
		[1]: var5_upvw (read and write)
	]]
	arg1:buttons()
	arg1:infoHover()
	arg1:valuesChanged()
	arg1:opened()
	var5_upvw:listenToOpen("PrestigeFrame"):Connect(function() -- Line 205
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:opened()
	end)
	var5_upvw:listenToClose("PrestigeFrame"):Connect(function() -- Line 208
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:closed()
	end)
end
local var59_upvw
function any_new_result1.Construct(arg1) -- Line 213
	--[[ Upvalues[10]:
		[1]: var7_upvw (read and write)
		[2]: Knit_upvr (readonly)
		[3]: var4_upvw (read and write)
		[4]: var5_upvw (read and write)
		[5]: var6_upvw (read and write)
		[6]: var9_upvw (read and write)
		[7]: var59_upvw (read and write)
		[8]: ReplicatedStorage_upvr (readonly)
		[9]: var10_upvw (read and write)
		[10]: var11_upvw (read and write)
	]]
	var7_upvw = Knit_upvr.GetService("PrestigeService")
	var4_upvw = Knit_upvr.GetController("DataController")
	var5_upvw = Knit_upvr.GetController("UIController")
	var6_upvw = Knit_upvr.GetController("SoundController")
	var9_upvw = require(Knit_upvr.Modules.Button)
	var59_upvw = require(ReplicatedStorage_upvr.Shared.Util)
	var10_upvw = require(ReplicatedStorage_upvr.Shared.Functions)
	var11_upvw = require(ReplicatedStorage_upvr.Shared.List.Prestige.Prestiges)
end
return any_new_result1