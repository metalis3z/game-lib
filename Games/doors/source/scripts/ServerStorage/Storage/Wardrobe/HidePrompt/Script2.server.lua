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
		if math.random(1, 25)/10 == math.random(1, 25)/10 then
			db = true
			local value = 0

			local animationplaywardrobe1 = animationcontroller.Animator:LoadAnimation(animationentermodel)
			animationplaywardrobe1:Play(0, 1, 1)

			local v = wardrobe.Main.Jack:Clone()
			v.Parent = wardrobe.Main
			wardrobe.Main.JackScream:Play()
			require(game.ReplicatedStorage.ClientModules.Module_Events).flickerLights(game.Workspace.CurrentRooms:FindFirstChild(game.Workspace.CurrentRooms.CurrentRoom.Value - 1), 1)
			
			local ach = "EncounterMobble"
			local p1_player = player

			if game.Players[p1_player.Name].InGameStats.Achievements:FindFirstChild(ach) then
				local achive = game.Players[p1_player.Name].InGameStats.Achievements:FindFirstChild(ach)
				local req = require(game.ReplicatedStorage.Achievements)[ach]

				if achive.Value == false then
					achive.Value = true
					if not game:GetService("BadgeService"):UserHasBadgeAsync(p1_player.UserId, req.BadgeId) then
						game.ReplicatedStorage.EntityInfo.AchievementUnlock:FireClient(p1_player, ach)
						game:GetService("BadgeService"):AwardBadge(p1_player.UserId, req.BadgeId)
					end
				end

			end

			while true do
				v.Beam.Enabled = true
				v.Beam.FaceCamera = true
				if value == 6 then
					v:Destroy()
					break
				else
					local matd = math.random(0.3, 0.5)
					wait(matd)
					v.Beam.Attachment0 = v.AttachmentEnd
					wait(matd - 0.1)
					value += 1
					v.Beam.Attachment0 = v.Attachment0
				end
			end
			db = false
			return
		end
	end
	
	if player.Character:GetAttribute("HideSickness") == true then
		game.ReplicatedStorage.EntityInfo.Caption:FireClient(player, "Something is stopping you from hiding...")
		wait(4)
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
			spawn(function()
				wait(5)
				if script.Parent.Parent.HiddenPlayer.Value == nil then
					wait(0.02)
				else
					game.ReplicatedStorage.EntityInfo.HideMonster:FireClient(player, Status.Danger)
					wait(0.02)
					for i=1,10 do
						task.wait(1)
						if Status.Danger > 6 then
							Status.Danger = Status.Danger - 1
						end
						if hiddenplayer.Value == nil then
							return
						end
					end
					Status.Danger = 10
					task.wait(0.15)
					hiddenplayer.Value.Humanoid:TakeDamage(32)
					
					local ach = "SurviveHide"
					local p1_player = player

					if game.Players[p1_player.Name].InGameStats.Achievements:FindFirstChild(ach) then
						local achive = game.Players[p1_player.Name].InGameStats.Achievements:FindFirstChild(ach)
						local req = require(game.ReplicatedStorage.Achievements)[ach]

						if achive.Value == false then
							achive.Value = true
							if not game:GetService("BadgeService"):UserHasBadgeAsync(p1_player.UserId, req.BadgeId) then
								game.ReplicatedStorage.EntityInfo.AchievementUnlock:FireClient(p1_player, ach)
								game:GetService("BadgeService"):AwardBadge(p1_player.UserId, req.BadgeId)
							end
						end

					end
					
					local animationplay3 = hiddenplayer.Value.Humanoid.Animator:LoadAnimation(animationforceout)
					local animationplaywardrobe3 = animationcontroller.Animator:LoadAnimation(animationexitmodel)
					hiddenplayer.Value:SetAttribute("Hiding", false)
					hiddenplayer.Value.HumanoidRootPart.CFrame = wardrobe.Main.ExitCharAttachment.WorldCFrame
					animationplay3:Play()
					animationplaywardrobe3:Play()
					game.ReplicatedStorage.EntityInfo.RenderCamMiddle:FireClient(player)
					game.ReplicatedStorage.EntityInfo.RenderCamOffset:FireClient(player, wardrobe.Main.Orientation.Y)
					hiddenplayer.Value:SetAttribute("HideSickness", true)
					task.wait(2.2)
					game.ReplicatedStorage.EntityInfo.ToggleInv:FireClient(player, true)
					hiddenplayer.Value.HumanoidRootPart.Anchored = false
					hiddenplayer.Value.HumanoidRootPart.CFrame = wardrobe.Main.ExitAttachment.WorldCFrame * CFrame.new(0, 0, -2)
					game.ReplicatedStorage.EntityInfo.RenderCamStop:FireClient(player)
					hiddenplayer.Value = nil
					db = false
				end
			end)
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