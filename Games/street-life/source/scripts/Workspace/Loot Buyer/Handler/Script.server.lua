script.Parent.Triggered:Connect(function(Player)
	if Player.Character and Player.Character:FindFirstChild('Humanoid') and Player:FindFirstChild('stored') then
		if Player.Character:FindFirstChild('BankTotal').Value >= 1 then
			local MoneyTotal = 0
			for _ = 1, Player.Character:FindFirstChild('BankTotal').Value do
				MoneyTotal = MoneyTotal + math.random(1500, 2500)
			end
			Player:FindFirstChild('stored'):FindFirstChild('Money').Value += MoneyTotal
			Player.Character:FindFirstChild('BankTotal').Value = 0
			if Player.Character:FindFirstChild('DuffelBag') then Player.Character:FindFirstChild('DuffelBag'):Destroy() end
			Player.Character:FindFirstChild('Humanoid'):LoadAnimation(script.Parent:FindFirstChild('Takes')):Play()
			script.Parent.Parent:FindFirstChild('Humanoid'):LoadAnimation(script.Parent:FindFirstChild('Takes')):Play()
			script.Parent.Parent:FindFirstChild('HumanoidRootPart'):FindFirstChild('Kaching'):Play()
			if Player.PlayerGui:FindFirstChild('Adder') then Player.PlayerGui:FindFirstChild('Adder'):Destroy() end
			local Adder = game:FindService('ReplicatedStorage').Misc.Adder:Clone()
			Adder.Parent = Player.PlayerGui
			Adder.Amount.Text = '+$' .. tostring(MoneyTotal)
			task.wait(2)
			for _ = 1, 100 do 
				if Adder then 
					Adder.Amount.TextTransparency += .01 
					Adder.Amount.UIStroke.Transparency += .01
					task.wait(.01) 
				end 
			end
			Adder:Destroy()
		else
			game:FindService('ReplicatedStorage'):FindFirstChild('Notify'):FireClient(Player, 'You dont have any bank loot. (rob the bank)', 3)
		end
	end
end)