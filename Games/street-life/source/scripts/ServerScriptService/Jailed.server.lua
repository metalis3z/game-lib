local Outfits = game:FindService('ReplicatedStorage'):WaitForChild('OutfitsOk')
local PrisonTP = workspace:WaitForChild('PRISONTP')

game:FindService('Players').PlayerAdded:Connect(function(Player)
	local Waited = false
	Player.CharacterAdded:Connect(function(Character)
		Character:WaitForChild('Humanoid')
		Character:WaitForChild('HumanoidRootPart')
		
		local Jailed = Player:WaitForChild('stored'):WaitForChild('Jailed')
		repeat task.wait(.5) until Waited == true
		task.wait(.5)
		if Jailed.Value > 0 then
			Player.Team = game.Teams.Prisoner
			if Character:FindFirstChildOfClass('Shirt') then Character:FindFirstChildOfClass('Shirt'):Destroy() end
			if Character:FindFirstChildOfClass('Pants') then Character:FindFirstChildOfClass('Pants'):Destroy() end

			Outfits:FindFirstChild('PrisonShirt'):Clone().Parent = Character
			Outfits:FindFirstChild('PrisonPants'):Clone().Parent = Character
			Character:FindFirstChild('HumanoidRootPart').Anchored = true
			Character:FindFirstChild('HumanoidRootPart').CFrame = PrisonTP.CFrame
			task.wait(1)
			Character:FindFirstChild('HumanoidRootPart').Anchored = false
			while Character and Jailed and (true) do
				if Character then
					Jailed.Value -= 1
					task.wait(1)
					if Jailed.Value == 0 then
						Player.Team = game.Teams.Civilians
						Player:LoadCharacter()
						break
					end
				end
			end
		elseif Jailed.Value == 0 then
			if Player.Team == game.Teams.Prisoner then 
				Player.Team = game.Teams.Civilians
				Player:LoadCharacter()
			end
		end
	end)
	task.wait(15)
	Waited = true
end)