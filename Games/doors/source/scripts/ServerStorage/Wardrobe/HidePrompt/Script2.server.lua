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

script.Parent.Triggered:Connect(function(player)
	if player.Character:GetAttribute("HideSickness") then
		return
	end
	if db == false then
		if hiddenplayer.Value == nil then
			db = true
			hiddenplayer.Value = player.Character
			hiddenplayer.Value:SetAttribute("Hiding", true)
			hiddenplayer.Value.HumanoidRootPart.CFrame = wardrobe.Main.EnterAttachment.WorldCFrame
			hiddenplayer.Value.HumanoidRootPart.Orientation = wardrobe.Main.EnterAttachment.Orientation
			game.ReplicatedStorage.EntityInfo.RenderCam:FireClient(player)
			--game.ReplicatedStorage.EntityInfo.CamLock:FireClient(player,player.Character.Head.Position)
			hiddenplayer.Value.HumanoidRootPart.Anchored = true
			local animationplay1 = hiddenplayer.Value.Humanoid.Animator:LoadAnimation(animationenter)
			animationplay1:Play(0, 1, 1)
			local animationplaywardrobe1 = animationcontroller.Animator:LoadAnimation(animationentermodel)
			animationplaywardrobe1:Play(0, 1, 1)
			wardrobe.Main.SoundEnter:Play()
			task.wait(0.8)
			animationplay1:Stop(0)
			spawn(function()
				wait(8)
				if script.Parent.Parent.HiddenPlayer.Value == nil then
					wait(0.02)
				else
					game.ReplicatedStorage.Bricks.HideMonster:FireClient(player, 10)
					print("GET OUT!")
					wait(0.02)
					for i=1,10 do
						task.wait(1)
						if hiddenplayer.Value == nil then
							return
						end
					end
					print("boom you ded")
					hiddenplayer.Value:SetAttribute("HideSickness", nil)
					task.wait(0.15)
					local animationplay3 = hiddenplayer.Value.Humanoid.Animator:LoadAnimation(animationforceout)
					local animationplaywardrobe3 = animationcontroller.Animator:LoadAnimation(animationexitmodel)
					hiddenplayer.Value:SetAttribute("Hiding", true)
					task.wait(1.9)
					animationplay3:Stop(0)
					task.wait()
					player.Character.Humanoid:SetAttribute("HideSickness", nil)
				end
			end)
			hiddenplayer.Value:PivotTo(wardrobe.Part.CFrame)
			--game.ReplicatedStorage.EntityInfo.CamLock:FireClient(player, hiddenplayer.Value.Head.Position)
			task.wait(1)
			repeat task.wait() until hiddenplayer.Value.Humanoid.MoveDirection.Magnitude > 0
			game.ReplicatedStorage.EntityInfo.RenderCamMiddle:FireClient(player)
			--game.ReplicatedStorage.EntityInfo.GetOutOfHiding:FireClient(player)
			task.wait(0.15)
			hiddenplayer.Value.HumanoidRootPart.Anchored = true
			hiddenplayer.Value.HumanoidRootPart.CFrame = wardrobe.Main.ExitAttachment.WorldCFrame
			hiddenplayer.Value:SetAttribute("Hiding", nil)
			--game.ReplicatedStorage.EntityInfo.CamLock:FireClient(player,player.Character.Head.Position)
			local animationplay2 = hiddenplayer.Value.Humanoid.Animator:LoadAnimation(animationexit)
			animationplay2:Play(0, 1, 1)
			local animationplaywardrobe2 = animationcontroller.Animator:LoadAnimation(animationexitmodel)
			animationplaywardrobe2:Play(0, 1, 1)
			wardrobe.Main.EnterAttachment.SoundExit:Play()
			task.wait(animationplay2.Length)
			game.ReplicatedStorage.EntityInfo.RenderCamStop:FireClient(player)
			hiddenplayer.Value.HumanoidRootPart.CFrame = wardrobe.Main.ExitAttachment.WorldCFrame
			hiddenplayer.Value.HumanoidRootPart.Anchored = false
			task.wait(0.25)
			hiddenplayer.Value.HumanoidRootPart.CFrame = wardrobe.Main.ExitAttachment.WorldCFrame * CFrame.new(0, 0, -2)
			hiddenplayer.Value = nil
			db = false
		end
	end
end)