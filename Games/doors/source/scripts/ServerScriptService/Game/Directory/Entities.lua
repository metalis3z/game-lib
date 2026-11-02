local module = {}

-- Created and Fixed by BUILDG Studios

local Workspace = game:GetService("Workspace")
local l__TweenService__1 = game:GetService("TweenService");

function module:Dupe_Door(hidden)
	
	hidden.Parent:GetAttributeChangedSignal("TimeToClear"):Connect(function()
		if hidden.Parent:GetAttribute("TimeToClear") == true then
			hidden.Parent.Parts:Destroy()
			hidden.Parent.DoorFake.Sign:Destroy()
			hidden.Parent.DoorFake.Door.SignMotor:Destroy()
			hidden.Parent.DoorFake.Door.SignPart.CanCollide = true
			hidden:Destroy()
		end
	end)
	
	local function onTouched(hit)
		
		if not hidden then
			return
		end
		
		local humroot = hit.Parent:findFirstChild("HumanoidRootPart")
		local human = hit.Parent:findFirstChild("Humanoid")
		local dooranimator = hidden.Parent.DoorFake.AnimationController
		if human then
			if game.Players:GetPlayerFromCharacter(hit.Parent).Character:GetAttribute("CrucifixEnabled", true) then
				if human then
					hidden.CanTouch = false

					hidden.Parent.Parts.Floor.Attachment.FaceParticle.Enabled = true
					hidden.Parent.Parts.Floor.Attachment.PointLight.Enabled = true

					humroot.Anchored = true
					humroot.Position = hidden.Parent.DoorFake.Hidden.CharPosCF.Position
					humroot.Orientation = hidden.Parent.DoorFake.Hidden.CharPosCF.Orientation
					local anim = human:LoadAnimation(hidden.Parent.AnimCharCrucifix)
					local doorslap = dooranimator:LoadAnimation(hidden.Parent.AnimOpen)
					doorslap.Looped = false
					game.ReplicatedStorage.EntityInfo.DupeCrucifixCutscene:FireClient(game.Players:GetPlayerFromCharacter(hit.Parent))
					doorslap:Play()
					anim:Play()

					hidden.Parent.DoorFake.Hidden.Scare:Play()

					wait(1.1)

					game.ReplicatedStorage.Bricks.FireCamera:FireAllClients(19, 15, 0.5, 7.5)

					hidden.Parent.DoorFake.Door.SignMotor:Destroy()
					hidden.Parent.DoorFake.Door.SignPart.CanCollide = true
					hidden.Parent.DoorFake.Sign:Destroy()

					local vd = game.Players:GetPlayerFromCharacter(hit.Parent)

					local key = vd.Character:FindFirstChild("Crucifix")
					local keyBack = vd.Backpack:FindFirstChild("Crucifix")
					
					vd.Character:SetAttribute("CrucifixEnabled", false)
					
					if key then

						for i,v in pairs(vd.Character.Humanoid:GetPlayingAnimationTracks()) do
							if v.Name == "idle" then
								v:Stop()
							end
						end

						game.ReplicatedStorage.ClientBricks.AntiTool:FireAllClients()
                        wait(0.2)
						key:Destroy()
					end
					if keyBack then
						
						for i,v in pairs(vd.Character.Humanoid:GetPlayingAnimationTracks()) do
							if v.Name == "idle" then
								v:Stop()
							end
						end
						
						game.ReplicatedStorage.ClientBricks.AntiTool:FireAllClients()
						wait(0.2)
						
						keyBack:Destroy()
					end

					humroot.Anchored = false

					hidden.Parent.Parts.Floor.Attachment.FaceParticle.Enabled = false
					hidden.Parent.Parts.Floor.Attachment.PointLight.Enabled = false

					hidden.Parent.DoorFake.Hidden.CrucifixSound:Play()
					l__TweenService__1:Create(hidden.Parent.DoorFake.Hidden.CrucifixStuff.SpotLight, TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
						Brightness = 20
					}):Play();

					l__TweenService__1:Create(hidden.Parent.Parts.Floor, TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
						Color = Color3.fromRGB(142, 255, 247)
					}):Play();

					wait(6)

					l__TweenService__1:Create(hidden.Parent.DoorFake.Hidden.CrucifixStuff.SpotLight, TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
						Brightness = 0
					}):Play();

					l__TweenService__1:Create(hidden.Parent.Parts.Floor, TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
						Color = Color3.fromRGB(0, 0, 0)
					}):Play();
				end
			else
				if human then
					hidden.CanTouch = false
					hidden.Parent.Parts.Floor.Attachment.FaceParticle.Enabled = true
					hidden.Parent.Parts.Floor.Attachment.PointLight.Enabled = true
					humroot.Anchored = true
					humroot.Position = hidden.Parent.DoorFake.Hidden.CharPosCF.Position
					humroot.Orientation = hidden.Parent.DoorFake.Hidden.CharPosCF.Orientation
					local anim = human:LoadAnimation(hidden.Parent.AnimChar)
					local doorslap = dooranimator:LoadAnimation(hidden.Parent.AnimOpen)
					game.ReplicatedStorage.EntityInfo.DupeCutscene:FireClient(game.Players:GetPlayerFromCharacter(hit.Parent))
					doorslap:Play()
					anim:Play()
					hidden.Parent.DoorFake.Hidden.Scare:Play()
					wait(0.5)
					hidden.Parent.Parts.Floor.Attachment.ImpactParticle.Enabled = true
					game.Players:GetPlayerFromCharacter(hit.Parent).Stats.Death.Value = "Dupe"
					human.Health -= 45
					wait(0.3)
					hidden.Parent.Parts.Floor.Attachment.ImpactParticle.Enabled = false
					hidden.Parent.Parts.Floor.Attachment.PointLight.Enabled = false
					wait(3.2)
					
					local ach = "SurviveDupe"
					local p1_player = game.Players:GetPlayerFromCharacter(hit.Parent)

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
					
					hidden.Parent.Parts.Floor.Attachment.FaceParticle.Enabled = false
					humroot.Anchored = false
					hidden.Parent.DoorFake.Door.SignMotor:Destroy()
					hidden.Parent.DoorFake.Door.SignPart.CanCollide = true
					wait(0.6)
					hidden.Parent.DoorFake.Sign:Destroy()
				end
			end
		end
	end
	
	hidden.Touched:connect(onTouched)
end

function module:Lookman_Eyes(v, number)
	local Model_Eyes = v
	
	local l__TweenService__5 = game:GetService("TweenService");
	local v8 = TweenInfo.new(1.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut);
	
	Workspace:FindFirstChild("CurrentRooms"):FindFirstChild("CurrentRoom").Changed:Connect(function()
		if Workspace:FindFirstChild("CurrentRooms"):FindFirstChild("CurrentRoom").Value == number then
			Model_Eyes:FindFirstChild("Range"):Destroy()
			Model_Eyes:FindFirstChild("EffectsLookman").Attachment.Eyes.Enabled = false
			for i, v in pairs(game.Players:GetPlayers()) do 
				if v.Character then 
					game.ReplicatedStorage.ClientBricks.EyesClientDestroy:FireClient(v)
				end
			end
			l__TweenService__5:Create(v.EffectsLookman.PointLight2, v8, {
				Range = 0
			}):Play();

			l__TweenService__5:Create(v.EffectsLookman.PointLight1, v8, {
				Range = 0
			}):Play();
			wait(2)
			Model_Eyes:FindFirstChild("EffectsLookman").Attachment.Spark.Enabled = false
			wait(1)
			Model_Eyes:Destroy()
			for i, v in pairs(game.Players:GetPlayers()) do 
				if v.Character then
					local ach = "SurviveEyes"
					local p1_player = v

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
				end
			end
		end
	end)
end

function module:ScreechSpawner(v)
	local hitted = false

	--[[v.Touched:Connect(function(hit)
		local mathd = math.random(3, 8)
		if hitted == false then
			hitted = true
			v.CanTouch = false
			task.wait(mathd)
			game.ReplicatedStorage.Bricks.Screech:FireAllClients()
			hitted = false
			v.CanTouch = true
		end
	end)--]]
end

return module
