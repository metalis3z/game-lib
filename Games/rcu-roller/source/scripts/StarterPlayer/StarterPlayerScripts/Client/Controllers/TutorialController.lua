-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:20:20
-- Luau version 6, Types version 3
-- Time taken: 0.007763 seconds

local Knit_upvr = require(game:GetService("ReplicatedStorage").Packages.Knit)
local any_CreateController_result1 = Knit_upvr.CreateController({
	Name = "TutorialController";
	_hasBeam = false;
	_beamInstances = {};
})
local var4_upvw
local var5_upvw
local var6_upvw
local var7_upvw
local var8_upvw
local var9_upvw
local var10_upvw
local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local TweenService_upvr = game:GetService("TweenService")
local var13_upvw
local var14_upvw
local LocalPlayer_upvr = game:GetService("Players").LocalPlayer
local Bars_upvr = LocalPlayer_upvr:WaitForChild("PlayerGui"):WaitForChild("MainUI", 99):WaitForChild("HUD"):WaitForChild("Bars")
local Tutorial_upvr_2 = Bars_upvr:WaitForChild("Tutorial")
local var18_upvw
local os_clock_result1_upvw = os.clock()
function any_CreateController_result1.canMoveToNextStage(arg1) -- Line 52
	--[[ Upvalues[1]:
		[1]: os_clock_result1_upvw (read and write)
	]]
	local var20
	if 0.5 >= os.clock() - os_clock_result1_upvw then
		var20 = false
	else
		var20 = true
	end
	return var20
end
local TextChatService_upvr = game:GetService("TextChatService")
function any_CreateController_result1.toggleStuffInTutorial(arg1, arg2) -- Line 56
	--[[ Upvalues[4]:
		[1]: var7_upvw (read and write)
		[2]: var9_upvw (read and write)
		[3]: var8_upvw (read and write)
		[4]: TextChatService_upvr (readonly)
	]]
	var7_upvw:hideCharacters(arg2)
	var9_upvw:hideMounts(arg2)
	var8_upvw:togglePets(false, not arg2)
	TextChatService_upvr.BubbleChatConfiguration.Enabled = not arg2
end
local Tutorial_upvr = Tutorial_upvr_2:WaitForChild("Tutorial")
function any_CreateController_result1.update(arg1) -- Line 63
	--[[ Upvalues[12]:
		[1]: var5_upvw (read and write)
		[2]: Tutorial_upvr_2 (readonly)
		[3]: var4_upvw (read and write)
		[4]: var14_upvw (read and write)
		[5]: Knit_upvr (readonly)
		[6]: LocalPlayer_upvr (readonly)
		[7]: var6_upvw (read and write)
		[8]: var18_upvw (read and write)
		[9]: os_clock_result1_upvw (read and write)
		[10]: var13_upvw (read and write)
		[11]: var10_upvw (read and write)
		[12]: Tutorial_upvr (readonly)
	]]
	local var35
	if var5_upvw:isHatching() then
		Tutorial_upvr_2.Visible = false
	else
		local any_getData_result1 = var4_upvw:getData()
		local any_getCurrentStage_result1 = arg1:getCurrentStage()
		if any_getCurrentStage_result1 == nil then
			var35 = false
		else
			var35 = true
		end
		Tutorial_upvr_2.Visible = var35
		var35 = var14_upvw
		local var38 = var35[any_getData_result1.tutorialStage]
		if not var38 then
			var35 = Tutorial_upvr_2
			var35.Visible = false
			var35 = Knit_upvr.listenToUpdate.Wait
			var35(Knit_upvr.listenToUpdate)
			return
		end
		var35 = arg1.toggleStuffInTutorial
		var35(arg1, true)
		var35 = LocalPlayer_upvr.HasVerifiedBadge
		if var35 then
			var35 = var6_upvw.toggleMusic
			var35(var6_upvw, false)
		end
		var35 = var38.arrowPosition
		local any_getArrow_result1 = arg1:getArrow()
		if not any_getArrow_result1 then
			any_getArrow_result1 = arg1:createArrow()
		end
		if any_getArrow_result1:GetAttribute("pos") ~= var35 then
			any_getArrow_result1.Position = var35
			if var18_upvw then
				var18_upvw:Cancel()
			end
		end
		any_getArrow_result1:SetAttribute("pos", var35)
		any_getArrow_result1.Rotation = var38.arrowRotation
		any_getArrow_result1.Visible = var38.arrowIsVisible(any_getData_result1)
		Tutorial_upvr_2.Visible = true
		var38.onStart()
		if var38.stageIsCompleted(any_getData_result1) then
			if arg1:canMoveToNextStage() then
				os_clock_result1_upvw = os.clock()
				arg1:playFinishedAnimation(any_getData_result1.tutorialStage, var38)
				var13_upvw.print(`S\xE4tt stage till: {any_getData_result1.tutorialStage + 1}`)
				var10_upvw.setTutorialStage:Fire(any_getData_result1.tutorialStage + 1)
			end
			var38.onCompleted()
			arg1:removeBeam()
			return
		end
		if not any_getCurrentStage_result1 then
			arg1:removeBeam()
			Knit_upvr.listenToUpdate:Wait()
			return
		end
		local data_3 = var4_upvw.data
		local var41 = var14_upvw[any_getCurrentStage_result1]
		local any_getStageProgress_result1, any_getStageProgress_result2_2 = var41.getStageProgress(data_3, 0)
		Tutorial_upvr.Text = var41.text
		local var44 = any_getStageProgress_result1 / any_getStageProgress_result2_2
		local Progress_2 = Tutorial_upvr_2.Progress
		local showProgress = (var44 > 0)
		Progress_2.Bar.Visible = showProgress
		Tutorial_upvr_2.Progress.Bar:TweenSize(UDim2.fromScale(var44, 1), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.25, true)
		Tutorial_upvr_2.Progress.Percentage.Text = `{any_getStageProgress_result1}/{any_getStageProgress_result2_2}`
		if var41.beamIsAvailable and var41.beamIsAvailable(data_3) and not arg1:hasBeam() then
			arg1:createBeam()
		end
		var6_upvw:preloadSounds({"Tutorial Stage", "Tutorial Completed"})
	end
end
function any_CreateController_result1.playFinishedAnimation(arg1, arg2, arg3) -- Line 156
	--[[ Upvalues[6]:
		[1]: var4_upvw (read and write)
		[2]: Tutorial_upvr_2 (readonly)
		[3]: TweenService_upvr (readonly)
		[4]: var14_upvw (read and write)
		[5]: var6_upvw (read and write)
		[6]: LocalPlayer_upvr (readonly)
	]]
	if arg3.playFinishedAnimation == false then
	else
		task.spawn(function() -- Line 163
			--[[ Upvalues[7]:
				[1]: Tutorial_upvr_2 (copied, readonly)
				[2]: TweenService_upvr (copied, readonly)
				[3]: arg2 (readonly)
				[4]: var14_upvw (copied, read and write)
				[5]: var6_upvw (copied, read and write)
				[6]: LocalPlayer_upvr (copied, readonly)
				[7]: arg1 (readonly)
			]]
			Tutorial_upvr_2.Flash.UIGradient.Offset = Vector2.new(-1, 0)
			TweenService_upvr:Create(Tutorial_upvr_2.Flash.UIGradient, TweenInfo.new(0.5), {
				Offset = Vector2.new(1, 0);
			}):Play()
			if arg2 == #var14_upvw then
				var6_upvw:play("Tutorial Completed")
				var6_upvw:play("Confetti")
				if LocalPlayer_upvr.HasVerifiedBadge then
					var6_upvw:toggleMusic(true)
				end
				arg1:toggleStuffInTutorial(false)
			else
				var6_upvw:play("Tutorial Stage")
			end
		end)
	end
end
function any_CreateController_result1.getArrow(arg1) -- Line 180
	--[[ Upvalues[1]:
		[1]: Bars_upvr (readonly)
	]]
	return Bars_upvr:FindFirstChild("TutorialArrow")
end
function any_CreateController_result1.createArrow(arg1) -- Line 184
	--[[ Upvalues[4]:
		[1]: ReplicatedStorage_upvr (readonly)
		[2]: Bars_upvr (readonly)
		[3]: var18_upvw (read and write)
		[4]: TweenService_upvr (readonly)
	]]
	local clone_upvr = ReplicatedStorage_upvr.Assets.UI.TutorialArrow:Clone()
	clone_upvr.Parent = Bars_upvr
	task.spawn(function() -- Line 188
		--[[ Upvalues[3]:
			[1]: clone_upvr (readonly)
			[2]: var18_upvw (copied, read and write)
			[3]: TweenService_upvr (copied, readonly)
		]]
		while task.wait(0.1) do
			if not clone_upvr.Parent then return end
			var18_upvw = TweenService_upvr:Create(clone_upvr, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
				Position = clone_upvr:GetAttribute("pos") - UDim2.fromScale(0.01, 0);
			})
			var18_upvw:Play()
			task.wait(0.5)
			var18_upvw = TweenService_upvr:Create(clone_upvr, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
				Position = clone_upvr:GetAttribute("pos");
			})
			var18_upvw:Play()
			task.wait(0.5)
		end
	end)
	return clone_upvr
end
function any_CreateController_result1.hasBeam(arg1) -- Line 213
	--[[ Upvalues[1]:
		[1]: LocalPlayer_upvr (readonly)
	]]
	return LocalPlayer_upvr.Character.HumanoidRootPart:FindFirstChild("TutorialBeam")
end
function any_CreateController_result1.removeBeam(arg1) -- Line 217
	arg1._hasBeam = false
	for _, v in arg1._beamInstances do
		v:Destroy()
	end
end
function any_CreateController_result1.createBeam(arg1) -- Line 224
	--[[ Upvalues[4]:
		[1]: var4_upvw (read and write)
		[2]: var14_upvw (read and write)
		[3]: ReplicatedStorage_upvr (readonly)
		[4]: LocalPlayer_upvr (readonly)
	]]
	local any_getCurrentStage_result1_2 = arg1:getCurrentStage()
	if not any_getCurrentStage_result1_2 then
	else
		local any_getBeamPart_result1 = var14_upvw[any_getCurrentStage_result1_2].getBeamPart()
		if not any_getBeamPart_result1 then return end
		arg1._hasBeam = true
		local clone = ReplicatedStorage_upvr.Assets.Other.TutorialBeam:Clone()
		clone.Parent = LocalPlayer_upvr.Character.PrimaryPart
		local Attachment = Instance.new("Attachment", LocalPlayer_upvr.Character.PrimaryPart)
		local Attachment_2 = Instance.new("Attachment", any_getBeamPart_result1)
		clone.Attachment0 = Attachment_2
		clone.Attachment1 = Attachment
		arg1._beamInstances[#arg1._beamInstances + 1] = clone
		arg1._beamInstances[#arg1._beamInstances + 1] = Attachment
		arg1._beamInstances[#arg1._beamInstances + 1] = Attachment_2
	end
end
function any_CreateController_result1.getCurrentStage(arg1) -- Line 254
	--[[ Upvalues[2]:
		[1]: var4_upvw (read and write)
		[2]: var14_upvw (read and write)
	]]
	local data = var4_upvw.data
	for i_2, v_2 in var14_upvw do
		if data.tutorialStage == i_2 and v_2.stageIsAvailable(data) then
			return i_2
		end
	end
end
function any_CreateController_result1.KnitStart(arg1) -- Line 264
	--[[ Upvalues[1]:
		[1]: var4_upvw (read and write)
	]]
	task.spawn(function() -- Line 265
		--[[ Upvalues[2]:
			[1]: var4_upvw (copied, read and write)
			[2]: arg1 (readonly)
		]]
		var4_upvw:waitForData()
		while task.wait(0.05) do
			arg1:update()
		end
	end)
end
local var64_upvw
local var65_upvw
local var66_upvw
function any_CreateController_result1.KnitInit(arg1) -- Line 274
	--[[ Upvalues[14]:
		[1]: var64_upvw (read and write)
		[2]: Knit_upvr (readonly)
		[3]: var10_upvw (read and write)
		[4]: var4_upvw (read and write)
		[5]: var65_upvw (read and write)
		[6]: var5_upvw (read and write)
		[7]: var6_upvw (read and write)
		[8]: var7_upvw (read and write)
		[9]: var8_upvw (read and write)
		[10]: var9_upvw (read and write)
		[11]: var14_upvw (read and write)
		[12]: ReplicatedStorage_upvr (readonly)
		[13]: var66_upvw (read and write)
		[14]: var13_upvw (read and write)
	]]
	var64_upvw = Knit_upvr.GetService("DataService")
	var10_upvw = Knit_upvr.GetService("PlayerService")
	var4_upvw = Knit_upvr.GetController("DataController")
	var65_upvw = Knit_upvr.GetController("UIController")
	var5_upvw = Knit_upvr.GetController("HatchingController")
	var6_upvw = Knit_upvr.GetController("SoundController")
	var7_upvw = Knit_upvr.GetController("PlayerController")
	var8_upvw = Knit_upvr.GetController("PetController")
	var9_upvw = Knit_upvr.GetController("MountController")
	var14_upvw = require(ReplicatedStorage_upvr.Shared.List.Tutorial)
	var66_upvw = require(ReplicatedStorage_upvr.Shared.Util)
	var13_upvw = require(ReplicatedStorage_upvr.Shared.Functions)
end
return any_CreateController_result1