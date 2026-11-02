local db = false
local animationcontroller = script.Parent.Parent.Parent.AnimationController
local remotestorage = require(game.ServerScriptService.Remotes)
local wardrobe = script.Parent.Parent.Parent
local hiddenplayer = wardrobe.HiddenPlayer
local animationenter = wardrobe.Anim_Enter
local animationexit = wardrobe.Anim_Exit
local animationentermodel = wardrobe.Anim_EnterModel
local animationexitmodel = wardrobe.Anim_ExitModel
local animationforceout = wardrobe.Anim_ForceOut
local animationidle = wardrobe.Anim_Idle
script.Parent.Triggered:Connect(function(player)
	if player.Character:GetAttribute("HideSickness") then
		return
	end
	if db == false then
		if hiddenplayer.Value == nil then
			db = true
			hiddenplayer.Value = player.Character
			hiddenplayer.Value:SetAttribute("Hiding", true)
			hiddenplayer.Value.HumanoidRootPart.CFrame = wardrobe.Pillow.EnterAttachment.WorldCFrame
			hiddenplayer.Value.HumanoidRootPart.Orientation = wardrobe.Pillow.EnterAttachment.Orientation
			remotestorage.camlock:FireClient(player,player.Character.Head.Position)
			hiddenplayer.Value.HumanoidRootPart.Anchored = true
			local animationplay1 = hiddenplayer.Value.Humanoid.Animator:LoadAnimation(animationenter)
			local animationidleplay = hiddenplayer.Value.Humanoid.Animator:LoadAnimation(animationidle)
			animationplay1:Play(0, 1, 1)
			wait(1)
			animationidleplay:Play(0, 1, 1)
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
					game.ReplicatedStorage.Bricks.EntityHide:FireClient(player)
					wait(0.02)
					for i=1,10 do
						task.wait(1)
						if hiddenplayer.Value == nil then
							return
						end
					end
					hiddenplayer.Value:SetAttribute("HideSickness", true)
					remotestorage.getoutofhiding:FireClient(player)
					task.wait(0.15)
					remotestorage.camlock:FireClient(player,player.Character.Head.Position)
					local animationplay3 = hiddenplayer.Value.Humanoid.Animator:LoadAnimation(animationforceout)
					animationplay3:Play(0, 1, 1)
					local animationplaywardrobe3 = animationcontroller.Animator:LoadAnimation(animationexitmodel)
					animationplaywardrobe3:Play(0, 1, 1)
					animationidleplay:Stop(0)
					hiddenplayer.Value.HumanoidRootPart.Anchored = true
					hiddenplayer.Value.HumanoidRootPart.CFrame = wardrobe.Pillow.HideAttachment.WorldCFrame
					hiddenplayer.Value.HumanoidRootPart.Orientation = wardrobe.Pillow.HideAttachment.Orientation
					hiddenplayer.Value:SetAttribute("Hiding", nil)
					task.wait(1.9)
					animationplay3:Stop(0)
					remotestorage.getoutofhiding:FireClient(player)
					hiddenplayer.Value.HumanoidRootPart.CFrame = wardrobe.Pillow.ExitAttachment.WorldCFrame
					hiddenplayer.Value.HumanoidRootPart.Orientation = wardrobe.Pillow.ExitAttachment.Orientation
					hiddenplayer.Value.HumanoidRootPart.Anchored = false
					hiddenplayer.Value = nil
					task.wait(1)
					player.Character.Humanoid:SetAttribute("HideSickness", nil)
				end
			end)
			hiddenplayer.Value.HumanoidRootPart.CFrame = wardrobe.Pillow.HideAttachment.WorldCFrame
			remotestorage.camlock:FireClient(player, hiddenplayer.Value.Head.Position)
			task.wait(1)
			repeat task.wait() until hiddenplayer.Value.Humanoid.MoveDirection.Magnitude > 0
			remotestorage.getoutofhiding:FireClient(player)
			task.wait(0.15)
			hiddenplayer.Value.HumanoidRootPart.Anchored = true
			hiddenplayer.Value.HumanoidRootPart.CFrame = wardrobe.Pillow.HideAttachment.WorldCFrame
			hiddenplayer.Value:SetAttribute("Hiding", nil)
			remotestorage.camlock:FireClient(player,player.Character.Head.Position)
			local animationplay2 = hiddenplayer.Value.Humanoid.Animator:LoadAnimation(animationexit)
			animationplay2:Play(0, 1, 1)
			hiddenplayer.Value.HumanoidRootPart.CFrame = wardrobe.Pillow.ExitAttachment.WorldCFrame
			wait(1.5)
			local animationplaywardrobe2 = animationcontroller.Animator:LoadAnimation(animationexitmodel)
			animationplaywardrobe2:Play(0, 1, 1)
			animationidleplay:Stop(0)
			wardrobe.Main.SoundExit:Play()
			task.wait(0.8)
			animationplay2:Stop(0)
			hiddenplayer.Value.HumanoidRootPart.CFrame = wardrobe.Pillow.ExitAttachmentDone.WorldCFrame
			remotestorage.getoutofhiding:FireClient(player)
			hiddenplayer.Value.HumanoidRootPart.Anchored = false
			hiddenplayer.Value = nil
			task.wait(0.25)
			db = false
		end
	end
end)