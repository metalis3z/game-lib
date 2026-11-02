local module = {}

-- Created and Fixed by BUILDG Studios

function module:wardrobeInput(v)
	
	local AnimationWardrobe = {
		Anim_Enter = "rbxassetid://15945038421",
		Anim_EnterModel = "rbxassetid://15945040385",
		Anim_Exit = "rbxassetid://15945042452",
		Anim_ExitModel = "rbxassetid://15945044291",
		Anim_ForceOut = "rbxassetid://15945046556",
	}
	
	local db = false
	local animationcontroller = v.AnimationController
	local remotestorage = require(game.ServerScriptService.Game.Directory.Remotes)
	local wardrobe = v
	local hiddenplayer = wardrobe.HiddenPlayer
	
	local animationenter = Instance.new("Animation")
	animationenter.AnimationId = AnimationWardrobe.Anim_Enter
	animationenter.Parent = v
	animationenter.Name = "Anim_Enter"
	
	local animationexit = Instance.new("Animation")
	animationexit.AnimationId = AnimationWardrobe.Anim_Exit
	animationexit.Parent = v
	animationexit.Name = "Anim_Exit"
	
	local animationentermodel = Instance.new("Animation")
	animationentermodel.AnimationId = AnimationWardrobe.Anim_EnterModel
	animationentermodel.Parent = v
	animationentermodel.Name = "Anim_EnterModel"
	
	local animationexitmodel = Instance.new("Animation")
	animationexitmodel.AnimationId = AnimationWardrobe.Anim_ExitModel
	animationexitmodel.Parent = v
	animationexitmodel.Name = "Anim_ExitModel"
	
	local animationforceout = Instance.new("Animation")
	animationforceout.AnimationId = AnimationWardrobe.Anim_ForceOut
	animationforceout.Parent = v
	animationforceout.Name = "Anim_ForceOut"
	
	local prompt = v:FindFirstChild("HidePrompt")
	
	prompt.Triggered:Connect(function(player)
		if player.Character:GetAttribute("HideSickness") then
			return
		end
		if db == false then
			if hiddenplayer.Value == nil then
				db = true
				hiddenplayer.Value = player.Character
				hiddenplayer.Value:SetAttribute("Hiding", true)
				hiddenplayer.Value:PivotTo(wardrobe.Inside.CFrame)
				--hiddenplayer.Value.HumanoidRootPart.CFrame = wardrobe.Main.EnterAttachment.WorldCFrame
				--hiddenplayer.Value.HumanoidRootPart.Orientation = wardrobe.Main.EnterAttachment.Orientation
				
				game.ReplicatedStorage.ClientBricks.PlayerHide:FireClient(player)
				
				--remotestorage.camlock:FireClient(player,player.Character.Head.Position)
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
					if v.HiddenPlayer.Value == nil then
						wait(0.02)
					else

						wait(0.02)
						for i=1,10 do
							task.wait(1)
							if hiddenplayer.Value == nil then
								return
							end
						end
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
				hiddenplayer.Value.HumanoidRootPart.CFrame = wardrobe.Main.HideAttachment.WorldCFrame
				game.ReplicatedStorage.ClientBricks.PlayerHide:FireClient(player)
				task.wait(0.5)
				repeat task.wait() until hiddenplayer.Value.Humanoid.MoveDirection.Magnitude > 0
				remotestorage.getoutofhiding:FireClient(player)
				hiddenplayer.Value:SetAttribute("Hiding", nil)
				task.wait(0.05)
				hiddenplayer.Value.HumanoidRootPart.Anchored = true
				hiddenplayer.Value.HumanoidRootPart.CFrame = wardrobe.Main.ExitAttachment.WorldCFrame
				hiddenplayer.Value:SetAttribute("Hiding", nil)
				game.ReplicatedStorage.ClientBricks.PlayerGetout:FireClient(player)
				local animationplay2 = hiddenplayer.Value.Humanoid.Animator:LoadAnimation(animationexit)
				animationplay2:Play(0, 1, 1)
				local animationplaywardrobe2 = animationcontroller.Animator:LoadAnimation(animationexitmodel)
				animationplaywardrobe2:Play(0, 1, 1)
				wardrobe.Main.EnterAttachment.SoundExit:Play()
				task.wait(0.5)
				animationplay2:Stop(0)
				game.ReplicatedStorage.Bricks.CamLockEnd:FireClient(player)
				hiddenplayer.Value:SetAttribute("Hiding", nil)
				remotestorage.getoutofhiding:FireClient(player)
				hiddenplayer.Value.HumanoidRootPart.CFrame = wardrobe.Main.ExitAttachment.WorldCFrame
				hiddenplayer.Value.HumanoidRootPart.Anchored = false
				hiddenplayer.Value = nil
				task.wait(0.25)
				db = false
			end
		else
			
		end
	end)
end

return module
