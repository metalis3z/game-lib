-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:22:36
-- Luau version 6, Types version 3
-- Time taken: 0.002384 seconds

local Knit_upvr = require(game:GetService("ReplicatedStorage").Packages.Knit)
local any_new_result1 = require(Knit_upvr.Util.Component).new({
	Tag = "UpdateLogFrame";
})
local var4_upvw
local var5_upvw
local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local var7_upvw
local var8_upvw
local Holder_upvr = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("MainUI"):WaitForChild("Menus"):WaitForChild("UpdateLogFrame"):WaitForChild("Main"):WaitForChild("List"):WaitForChild("Holder")
local Assets_upvr = ReplicatedStorage_upvr.Assets
local Main_upvr = Holder_upvr:WaitForChild("Canvas"):WaitForChild("Holder"):WaitForChild("Main")
function any_new_result1.setupFrames(arg1) -- Line 43
	--[[ Upvalues[4]:
		[1]: var7_upvw (read and write)
		[2]: Assets_upvr (readonly)
		[3]: Holder_upvr (readonly)
		[4]: Main_upvr (readonly)
	]]
	for _, v in var7_upvw.lines do
		local clone = Assets_upvr.UI.UpdateLog:Clone()
		clone.Main.Label.Text = v.text
		clone:SetAttribute("isUpdateLog", true)
		clone.Parent = Holder_upvr
	end
	Main_upvr.UpdateTitle.Text = var7_upvw.title
	Main_upvr.UpdateDesc.Text = var7_upvw.description
	Main_upvr.Icon.Image = var7_upvw.icon
end
function any_new_result1.removeFrames(arg1) -- Line 59
	--[[ Upvalues[1]:
		[1]: Holder_upvr (readonly)
	]]
	for _, v_2 in Holder_upvr:GetChildren() do
		if v_2:GetAttribute("isUpdateLog") then
			v_2:Destroy()
		end
	end
end
function any_new_result1.opened(arg1) -- Line 67
	arg1:setupFrames()
end
function any_new_result1.closed(arg1) -- Line 71
	arg1:removeFrames()
end
function any_new_result1.onJoin(arg1) -- Line 75
	--[[ Upvalues[5]:
		[1]: var4_upvw (read and write)
		[2]: var7_upvw (read and write)
		[3]: var8_upvw (read and write)
		[4]: Knit_upvr (readonly)
		[5]: var5_upvw (read and write)
	]]
	local any_getData_result1 = var4_upvw:getData()
	-- Check if update number matches — if so, player already saw this update
	local updateNumber = any_getData_result1.updateNumber
	if updateNumber == var7_upvw.updateNumber then return end
	-- isTutorialDone: true if tutorial stage is complete (tutorial list fully done)
	local isTutorialDone
	if any_getData_result1.tutorialStage >= #var8_upvw then
		isTutorialDone = false
	else
		isTutorialDone = true
	end
	repeat
		Knit_upvr.listenToUpdate:Wait()
	until var5_upvw:isFrameOpen() or #var8_upvw < any_getData_result1.tutorialStage
	if isTutorialDone then
		task.wait(2)
		repeat
			Knit_upvr.listenToUpdate:Wait()
		until not var5_upvw:isFrameOpen()
	end
	var5_upvw:openFrame("UpdateLogFrame")
end
function any_new_result1.Start(arg1) -- Line 100
	--[[ Upvalues[2]:
		[1]: var4_upvw (read and write)
		[2]: var5_upvw (read and write)
	]]
	task.spawn(function() -- Line 101
		--[[ Upvalues[3]:
			[1]: var4_upvw (copied, read and write)
			[2]: var5_upvw (copied, read and write)
			[3]: arg1 (readonly)
		]]
		var4_upvw:waitForData()
		var5_upvw:listenToOpen("UpdateLogFrame"):Connect(function() -- Line 104
			--[[ Upvalues[1]:
				[1]: arg1 (copied, readonly)
			]]
			arg1:opened()
		end)
		var5_upvw:listenToClose("UpdateLogFrame"):Connect(function() -- Line 107
			--[[ Upvalues[1]:
				[1]: arg1 (copied, readonly)
			]]
			arg1:closed()
		end)
		arg1:onJoin()
	end)
end
local var25_upvw
local var26_upvw
local var27_upvw
function any_new_result1.Construct(arg1) -- Line 115
	--[[ Upvalues[9]:
		[1]: var4_upvw (read and write)
		[2]: Knit_upvr (readonly)
		[3]: var5_upvw (read and write)
		[4]: var25_upvw (read and write)
		[5]: var26_upvw (read and write)
		[6]: var27_upvw (read and write)
		[7]: ReplicatedStorage_upvr (readonly)
		[8]: var7_upvw (read and write)
		[9]: var8_upvw (read and write)
	]]
	var4_upvw = Knit_upvr.GetController("DataController")
	var5_upvw = Knit_upvr.GetController("UIController")
	var25_upvw = Knit_upvr.GetController("SoundController")
	var26_upvw = require(Knit_upvr.Modules.Button)
	var27_upvw = require(ReplicatedStorage_upvr.Shared.Functions)
	var7_upvw = require(ReplicatedStorage_upvr.Shared.List.UpdateLog)
	var8_upvw = require(ReplicatedStorage_upvr.Shared.List.Tutorial)
end
return any_new_result1