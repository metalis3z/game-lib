local Settings = {
	Cooldown = {
		Min = 45,
		Max = 60
	},
	Money = {
		Min = 250 * 2,
		Max = 400 * 2
	}
}

local Cooldown = false

script.Parent.Triggered:Connect(function(Player)
	if Cooldown or script.Parent.Enabled == false then return end
	local Stored = Player:WaitForChild('stored')

	if Stored then
		local Amount = math.random(Settings.Money.Min, Settings.Money.Max)
		if game:FindFirstChild('MarketplaceService'):UserOwnsGamePassAsync(Player.UserId, 800131475) or game:FindFirstChild('MarketplaceService'):UserOwnsGamePassAsync(Player.UserId, 734604960) then
			Amount = Amount + Amount
		end
		Stored.Money.Value += Amount
		script.Parent.Parent.Kaching:Play()
		script.Parent.Enabled = false
		if Player:FindFirstChild('stored') then
			local XPValue = Player:FindFirstChild('stored'):FindFirstChild('XP')
			local LevelValue = Player:FindFirstChild('stored'):FindFirstChild('Level')
			if XPValue.Value + 3 >= 100 then
				if LevelValue.Value >= 200 then
				else
					LevelValue.Value += 1
					XPValue.Value = 0
				end
			else
				XPValue.Value += 3
			end
		end
		task.spawn(function()
			if Player.PlayerGui:FindFirstChild('Adder') then Player.PlayerGui:FindFirstChild('Adder'):Destroy() end
			local Adder = game:FindService('ReplicatedStorage').Misc.Adder:Clone()
			Adder.Parent = Player.PlayerGui
			Adder.Amount.Text = '+$' .. tostring(Amount)
			task.wait(2)
			for _ = 1, 100 do 
				if Adder then 
					Adder.Amount.TextTransparency += .01 
					Adder.Amount.UIStroke.Transparency += .01
					task.wait(.01) 
				end 
			end
			Adder:Destroy()
		end)
		task.wait(Settings.Cooldown.Min, Settings.Cooldown.Max)
		script.Parent.Enabled = true
	end
end)