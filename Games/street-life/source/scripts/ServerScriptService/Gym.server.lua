for _,v in next, workspace:WaitForChild('Gym'):GetChildren() do
	if v:FindFirstChild('Main') then
		local Clone = script:FindFirstChild('Interact'):Clone()
		Clone.ObjectText = 'Train ' .. v.Name
		Clone.Parent = v:FindFirstChild('Main')
		Clone.Triggered:Connect(function(Player)
			if not Clone.Enabled or not Player.Character then return end
			if not Player.Character:FindFirstChild('HumanoidRootPart') then return end
			if Player.Character:FindFirstChild('Humanoid').Health == 0 then return end
			if Player.Character:FindFirstChild('WorkingOut') then return end
			if Player.stored:FindFirstChild('Gym' .. v.Name).Value >= 100 then 
				game:FindService('ReplicatedStorage'):FindFirstChild('Notify'):FireClient(Player, 'You have maxed out your ' .. v.Name .. ' Stats!', 3)
				return 
			end
			
			local WorkingOut = Instance.new('BoolValue', Player.Character)
			WorkingOut.Name = 'WorkingOut'			
			Clone.Enabled = false
			local Dumbbell = nil
			local Animation = Player.Character:FindFirstChild('Humanoid'):LoadAnimation(script:FindFirstChild(v.Name))
			Animation.Looped = true
			Animation.Priority = Enum.AnimationPriority.Action
			Animation:Play()
			Player.Character:FindFirstChild('HumanoidRootPart').Anchored = true
			Player.Character:FindFirstChild('HumanoidRootPart').CFrame = v:FindFirstChild('Main').CFrame
			if v.Name == 'Strength' then
				Animation:AdjustSpeed(1.75)
				Dumbbell = script:FindFirstChild('Dumbbell'):Clone()
				Dumbbell.Parent = Player.Character.RightHand
				Dumbbell.Weld.Part0 = Dumbbell:FindFirstChild('Handle')
				Dumbbell.Weld.Part1 = Player.Character.RightHand
			end
			task.wait(math.random(5, 7))
			if not Player.Character:FindFirstChild(v.Name .. 'Amount') then
				local Amount = Instance.new('NumberValue', Player.Character)
				Amount.Name = v.Name .. 'Amount'
				Amount.Value = 1
			else
				if Player.Character:FindFirstChild(v.Name .. 'Amount').Value < 2 then
					Player.Character:FindFirstChild(v.Name .. 'Amount').Value += 1
				end
				if Player.Character:FindFirstChild(v.Name .. 'Amount').Value >= 2 then
					Player.Character:FindFirstChild(v.Name .. 'Amount'):Destroy()
					Player.stored:FindFirstChild('Gym' .. v.Name).Value += 1
				end
			end
			if Dumbbell ~= nil then
				Dumbbell:Destroy()
			end
			Animation:Stop()
			Player.Character:FindFirstChild('HumanoidRootPart').Anchored = false
			WorkingOut:Destroy()
			task.wait(3)
			Clone.Enabled = true
		end)
	end
end