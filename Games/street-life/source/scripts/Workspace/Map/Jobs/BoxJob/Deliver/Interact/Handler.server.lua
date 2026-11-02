local JobRemote = game:FindService('ReplicatedStorage'):FindFirstChild('Job')
local NotifyRemote = game:FindService('ReplicatedStorage'):FindFirstChild('Notify')

script.Parent.Triggered:Connect(function(Player)
	local Extra = Player:WaitForChild('Extra')
	local Stored = Player:WaitForChild('stored')

	if Player.Character:FindFirstChild('Box') then
		local Box = Player.Character:FindFirstChild('Box')
		if Player.Character:FindFirstChild('PickedUpBox') then
			Box:Destroy()
			return 
		end
		JobRemote:FireClient(Player, 'BoxDelivered', script.Parent)
		NotifyRemote:FireClient(Player, 'Delivered Box.', 2)
		Box:Destroy()
		if Player.PlayerGui:FindFirstChild('Adder') then Player.PlayerGui:FindFirstChild('Adder'):Destroy() end
		local MoneyEarned = math.random(20 * 3, 30 * 3)
		local Adder = game.ReplicatedStorage.Misc.Adder:Clone()
		Adder.Parent = Player.PlayerGui
		if MoneyEarned ~= 0 then
			Adder.Amount.Text = '+$' .. tostring(MoneyEarned)
		else
			Adder.Amount.Text = ''
		end
		if game:FindFirstChild('MarketplaceService'):UserOwnsGamePassAsync(Player.UserId, 800131475) or game:FindFirstChild('MarketplaceService'):UserOwnsGamePassAsync(Player.UserId, 734604960) then
			MoneyEarned = MoneyEarned + MoneyEarned
		end
		Stored.Money.Value += MoneyEarned
		if Player:FindFirstChild('stored') then
			local XPValue = Player:FindFirstChild('stored'):FindFirstChild('XP')
			local LevelValue = Player:FindFirstChild('stored'):FindFirstChild('Level')
			if XPValue.Value + 2 >= 100 then
				if LevelValue.Value >= 200 then
				else
					LevelValue.Value += 1
					XPValue.Value = 0
				end
			else
				XPValue.Value += 2
			end
		end
		task.wait(2)
		for _ = 1, 100 do if Adder then Adder.Amount.TextTransparency += .01 Adder.Amount.UIStroke.Transparency += .01 task.wait(.00001) end end
		Adder:Destroy()
	end
end)