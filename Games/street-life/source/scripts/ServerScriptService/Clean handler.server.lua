for _,v in ipairs(workspace:WaitForChild('Clean NPC'):FindFirstChild('Clean'):GetDescendants()) do
	if not v:FindFirstChildOfClass('ProximityPrompt') and v:IsA('BasePart') then
		local Clone = script:FindFirstChildOfClass('ProximityPrompt'):Clone()
		script:FindFirstChildOfClass('Sound'):Clone().Parent = v
		Clone.Parent = v
		Clone.Triggered:Connect(function(Player)
			if not Clone.Enabled then return end
			local Job = Player:WaitForChild('Extra'):WaitForChild('Job')
			if not Player.Character then return end
			local Humanoid, HumanoidRootPart = Player.Character:FindFirstChild('Humanoid'), Player.Character:FindFirstChild('HumanoidRootPart')
			if HumanoidRootPart.Anchored == true then return end
			if not Humanoid or not HumanoidRootPart then return end
			if v:FindFirstChildOfClass('Decal').Transparency == 0.25 and Job.Value == 'Clean' then
				Clone.Enabled = false
				local Animation = Humanoid:LoadAnimation(Clone:FindFirstChildOfClass('Animation'))
				Animation:Play()
				HumanoidRootPart.Anchored = true
				v:FindFirstChildOfClass('Sound'):Play()
				local Mop = script:FindFirstChild('Mop'):Clone()
				Mop.Parent = Player.Character
				repeat 
					v:FindFirstChildOfClass('Decal').Transparency += .01
					task.wait(.0275)
				until v:FindFirstChildOfClass('Decal').Transparency >= 1 or not Animation.IsPlaying
				v:FindFirstChildOfClass('Decal').Transparency = 1
				if Player:FindFirstChild('CleanJobEarned') then
					local Adder = math.random(30 * 2, 35 * 2)
					if game:FindFirstChild('MarketplaceService'):UserOwnsGamePassAsync(Player.UserId, 800131475) or game:FindFirstChild('MarketplaceService'):UserOwnsGamePassAsync(Player.UserId, 734604960) then
						Adder = Adder + Adder
					end
					Player:FindFirstChild('CleanJobEarned').Value += Adder
					if Player:FindFirstChild('stored') then
						local XPValue = Player:FindFirstChild('stored'):FindFirstChild('XP')
						local LevelValue = Player:FindFirstChild('stored'):FindFirstChild('Level')
						if XPValue.Value + 1 >= 100 then
							if LevelValue.Value >= 200 then
							else
								LevelValue.Value += 1
								XPValue.Value = 0
							end
						else
							XPValue.Value += 1
						end
					end
				end
				Animation.Stopped:Wait()
				Mop:Destroy()
				task.wait(.25)
				HumanoidRootPart.Anchored = false
				task.wait(math.random(5, 10))
				repeat 
					v:FindFirstChildOfClass('Decal').Transparency -= .01
					task.wait(.015)
				until v:FindFirstChildOfClass('Decal').Transparency <= 0.25
				v:FindFirstChildOfClass('Decal').Transparency = 0.25
				Clone.Enabled = true
			end
		end)
	end
end