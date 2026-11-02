local db = false
local animationcontroller = script.Parent.Parent.AnimationController
local remotestorage = require(game.ServerScriptService.Remotes)
local wardrobe = script.Parent.Parent
local hiddenplayer = wardrobe.HiddenPlayer
local animationenter = wardrobe.Anim_Enter
local animationexit = wardrobe.Anim_Exit
local animationentermodel = wardrobe.Anim_EnterModel
local animationexitmodel = wardrobe.Anim_ExitModel
local animationforceout = wardrobe.Anim_ForceOut

local Status = {
	Danger = wardrobe:GetAttribute("Danger")
}

script.Parent.Triggered:Connect(function(player)
	
	if player.Character:GetAttribute("Hiding") == true then
		return
	end
	
	if db == false then
		if hiddenplayer.Value == nil then
			db = true
			game.ReplicatedStorage.EntityInfo.Uncrouch:FireClient(player)
			game.ReplicatedStorage.EntityInfo.ToggleInv:FireClient(player, false)
			hiddenplayer.Value = player.Character
			hiddenplayer.Value.Humanoid:UnequipTools()
			hiddenplayer.Value:SetAttribute("Hiding", true)
			hiddenplayer.Value:PivotTo(wardrobe.PartEnter.CFrame)
			game.ReplicatedStorage.EntityInfo.RenderCam:FireClient(player, wardrobe.PartEnter.Orientation.Y, wardrobe.Main.Orientation.Y)
			hiddenplayer.Value.HumanoidRootPart.Anchored = true
			local animationplay1 = hiddenplayer.Value.Humanoid.Animator:LoadAnimation(animationenter)
			animationplay1:Play(0, 1, 1)
			local animationplaywardrobe1 = animationcontroller.Animator:LoadAnimation(animationentermodel)
			animationplaywardrobe1:Play(0, 1, 1)
			wardrobe.Main.SoundEnter:Play()
			task.wait(0.8)
			animationplay1:Stop(0)
			hiddenplayer.Value:PivotTo(wardrobe.Part.CFrame)
			task.wait(1)
			repeat task.wait() until hiddenplayer.Value.Humanoid.MoveDirection.Magnitude > 0
			game.ReplicatedStorage.EntityInfo.RenderCamMiddle:FireClient(player)
			game.ReplicatedStorage.EntityInfo.RenderCamOffset:FireClient(player, wardrobe.Main.Orientation.Y)
			task.wait(0.15)
			hiddenplayer.Value.HumanoidRootPart.Anchored = true
			hiddenplayer.Value:SetAttribute("Hiding", false)
			local animationplay2 = hiddenplayer.Value.Humanoid.Animator:LoadAnimation(animationexit)
			animationplay2:Play(0, 1, 1)
			hiddenplayer.Value.HumanoidRootPart.CFrame = wardrobe.Main.ExitCharAttachment.WorldCFrame
			local animationplaywardrobe2 = animationcontroller.Animator:LoadAnimation(animationexitmodel)
			animationplaywardrobe2:Play(0, 1, 1)
			wardrobe.Main.EnterAttachment.SoundExit:Play()
			task.wait(animationplay2.Length - 0.05)
			game.ReplicatedStorage.EntityInfo.ToggleInv:FireClient(player, true)
			animationplay2:AdjustSpeed(0)
			animationplay2:Stop(0)
			game.ReplicatedStorage.EntityInfo.RenderCamStop:FireClient(player, wardrobe.Main.Orientation.Y)
			wardrobe.PartCharExit:PivotTo(hiddenplayer.Value.UpperTorso.CFrame)
			wait(0.05)
			hiddenplayer.Value:PivotTo(wardrobe.PartCharExit.CFrame)
			hiddenplayer.Value.HumanoidRootPart.Anchored = false
			wait(0.25)
			hiddenplayer.Value = nil
			db = false
		end
	else
		game.ReplicatedStorage.EntityInfo.Caption:FireClient(player, "Someone is already hiding here.")
	end
end)