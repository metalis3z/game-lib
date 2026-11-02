-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:21:53
-- Luau version 6, Types version 3
-- Time taken: 0.003144 seconds

local Knit_upvr = require(game:GetService("ReplicatedStorage").Packages.Knit)
local any_new_result1 = require(Knit_upvr.Util.Component).new({
	Tag = "ProfileFrame";
})
local var4_upvw
local var5_upvw
local var6_upvw
local var7_upvw
local var8_upvw
local var9_upvw
local LocalPlayer_upvr = game:GetService("Players").LocalPlayer
local Menus = LocalPlayer_upvr:WaitForChild("PlayerGui"):WaitForChild("MainUI"):WaitForChild("Menus")
local ProfileFrame_upvr = Menus:WaitForChild("ProfileFrame")
local Holder_upvr = ProfileFrame_upvr:WaitForChild("Holder")
function any_new_result1.update(arg1) -- Line 39
	--[[ Upvalues[5]:
		[1]: var4_upvw (read and write)
		[2]: var9_upvw (read and write)
		[3]: ProfileFrame_upvr (readonly)
		[4]: LocalPlayer_upvr (readonly)
		[5]: var8_upvw (read and write)
	]]
	local var14 = var9_upvw[var4_upvw:getData().selectedTitle]
	local var16
	if var14 then
		var16 = `{var14.title}`
	else
		var16 = "No Title!"
	end
	ProfileFrame_upvr.Title.Label.Text = var16
	local displayName = LocalPlayer_upvr.DisplayName
	ProfileFrame_upvr.PlayerUsername.Text = displayName
	local function loadIcon()
		--[[ Upvalues[3]:
			[1]: ProfileFrame_upvr (copied, readonly)
			[2]: var8_upvw (copied, read and write)
			[3]: LocalPlayer_upvr (copied, readonly)
		]]
		ProfileFrame_upvr.PlayerIcon.Icon.Image = var8_upvw.getUserHeadshot(LocalPlayer_upvr.UserId)
	end
	task.spawn(loadIcon)
	arg1:infoIndicators()
end
function any_new_result1.infoIndicators(arg1) -- Line 54
	--[[ Upvalues[4]:
		[1]: var5_upvw (read and write)
		[2]: Holder_upvr (readonly)
		[3]: var6_upvw (read and write)
		[4]: ProfileFrame_upvr (readonly)
	]]
	if var5_upvw:getCurrentFrameOpen() ~= "ProfileFrame" then return end
	local auraCount = var6_upvw:getNewItems("aura")
	Holder_upvr.Aura.InfoIndicator.Visible = auraCount > 0
	local boothCount = var6_upvw:getNewItems("booth")
	Holder_upvr.Booth.InfoIndicator.Visible = boothCount > 0
	local mountCount = var6_upvw:getNewItems("mount")
	Holder_upvr.Mount.InfoIndicator.Visible = mountCount > 0
end
local ProfileChooseFrame_upvr = Menus:WaitForChild("ProfileChooseFrame")
function any_new_result1.buttons(arg1) -- Line 66
	--[[ Upvalues[6]:
		[1]: var7_upvw (read and write)
		[2]: Holder_upvr (readonly)
		[3]: ProfileChooseFrame_upvr (readonly)
		[4]: var5_upvw (read and write)
		[5]: var6_upvw (read and write)
		[6]: ProfileFrame_upvr (readonly)
	]]
	var7_upvw.new(Holder_upvr.Mount):buttonUp(function() -- Line 68
		--[[ Upvalues[3]:
			[1]: ProfileChooseFrame_upvr (copied, readonly)
			[2]: var5_upvw (copied, read and write)
			[3]: var6_upvw (copied, read and write)
		]]
		ProfileChooseFrame_upvr:SetAttribute("class", "mount")
		var5_upvw:openFrame("ProfileChooseFrame")
		var6_upvw:resetNewItems("mount")
	end)
	var7_upvw.new(Holder_upvr.Aura):buttonUp(function() -- Line 75
		--[[ Upvalues[3]:
			[1]: ProfileChooseFrame_upvr (copied, readonly)
			[2]: var5_upvw (copied, read and write)
			[3]: var6_upvw (copied, read and write)
		]]
		ProfileChooseFrame_upvr:SetAttribute("class", "aura")
		var5_upvw:openFrame("ProfileChooseFrame")
		var6_upvw:resetNewItems("aura")
	end)
	var7_upvw.new(Holder_upvr.Booth):buttonUp(function() -- Line 82
		--[[ Upvalues[3]:
			[1]: ProfileChooseFrame_upvr (copied, readonly)
			[2]: var5_upvw (copied, read and write)
			[3]: var6_upvw (copied, read and write)
		]]
		ProfileChooseFrame_upvr:SetAttribute("class", "booth")
		var5_upvw:openFrame("ProfileChooseFrame")
		var6_upvw:resetNewItems("booth")
	end)
	var7_upvw.new(ProfileFrame_upvr.Title.Settings):buttonUp(function() -- Line 89
		--[[ Upvalues[2]:
			[1]: var5_upvw (copied, read and write)
			[2]: arg1 (readonly)
		]]
		var5_upvw:openFrame("TitlesFrame")
		arg1:setTitlesUnlocked()
	end)
end
function any_new_result1.getTitlesUnlocked(arg1) -- Line 95
	--[[ Upvalues[3]:
		[1]: var4_upvw (read and write)
		[2]: var9_upvw (read and write)
		[3]: LocalPlayer_upvr (readonly)
	]]
	local var27 = 0
	for _, v in var9_upvw do
		if v.isUnlocked(LocalPlayer_upvr, var4_upvw:getData()) then
			var27 += 1
		end
	end
	return var27
end
function any_new_result1.setTitlesUnlocked(arg1) -- Line 107
	arg1._titlesUnlocked = arg1:getTitlesUnlocked()
end
function any_new_result1.opened(arg1) -- Line 111
	arg1:update()
end
function any_new_result1.Start(arg1) -- Line 115
	--[[ Upvalues[2]:
		[1]: var5_upvw (read and write)
		[2]: Knit_upvr (readonly)
	]]
	arg1:buttons()
	arg1:setTitlesUnlocked()
	arg1:infoIndicators()
	arg1:opened()
	var5_upvw:listenToOpen("ProfileFrame"):Connect(function() -- Line 121
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:opened()
	end)
	Knit_upvr.listenToUpdate:Connect(function() -- Line 125
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:infoIndicators()
	end)
end
local var31_upvw
local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local var33_upvw
function any_new_result1.Construct(arg1) -- Line 130
	--[[ Upvalues[10]:
		[1]: var4_upvw (read and write)
		[2]: Knit_upvr (readonly)
		[3]: var5_upvw (read and write)
		[4]: var31_upvw (read and write)
		[5]: var6_upvw (read and write)
		[6]: var7_upvw (read and write)
		[7]: var8_upvw (read and write)
		[8]: ReplicatedStorage_upvr (readonly)
		[9]: var33_upvw (read and write)
		[10]: var9_upvw (read and write)
	]]
	var4_upvw = Knit_upvr.GetController("DataController")
	var5_upvw = Knit_upvr.GetController("UIController")
	var31_upvw = Knit_upvr.GetController("SoundController")
	var6_upvw = Knit_upvr.GetController("ItemController")
	var7_upvw = require(Knit_upvr.Modules.Button)
	var8_upvw = require(ReplicatedStorage_upvr.Shared.Functions)
	var33_upvw = require(ReplicatedStorage_upvr.Shared.List.Upgrades)
	var9_upvw = require(ReplicatedStorage_upvr.Shared.List.Titles)
end
return any_new_result1