local JobRemote = game:FindService('ReplicatedStorage'):FindFirstChild('Job')
local Timer = false

script.Parent.Triggered:Connect(function(Player)
	if not script.Parent.Enabled then return end
	if Timer == false then script.Parent.Parent:Destroy() return end
	local Extra = Player:WaitForChild('Extra')

	if Extra.Job.Value == 'Delivery' and script.Parent.Parent.Name == 'NPC ' .. Player.Name then
		if Player.Character:FindFirstChild('DeliveryFood') then
			Player.Character:FindFirstChild('DeliveryFood'):Destroy()
			script.Parent.Enabled = false
			JobRemote:FireClient(Player, 'Delivered', script.Parent)
			local Earned = Player:FindFirstChild('FoodJobEarned')
			local Amount = math.random(45, 55)
			if game:FindFirstChild('MarketplaceService'):UserOwnsGamePassAsync(Player.UserId, 800131475) or game:FindFirstChild('MarketplaceService'):UserOwnsGamePassAsync(Player.UserId, 734604960) then
				Amount = Amount + Amount
			end
			Earned.Value = Earned.Value + Amount
			script.Parent.Enabled = false
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
			if Player.PlayerGui:FindFirstChild('Adder') then Player.PlayerGui:FindFirstChild('Adder'):Destroy() end
			local Adder = game.ReplicatedStorage.Misc.Adder:Clone()
			Adder.Parent = Player.PlayerGui
			Adder.Amount.Text = '+$' .. tostring(Amount)
			task.wait(2)
			for _ = 1, 100 do if Adder then Adder.Amount.TextTransparency += .01 Adder.Amount.UIStroke.Transparency += .01 task.wait(.00001) end end
			Adder:Destroy()
			script.Parent.Parent:Destroy()
		end
	end
end)

task.wait(3)
Timer = true
