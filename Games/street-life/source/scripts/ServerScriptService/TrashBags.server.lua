local Settings = {
	Cooldown = {
		Min = 60,
		Max = 120
	},
	Money = {
		Min = 40 * 2,
		Max = 80 * 2,
		MaxLucky = 250 * 2
	};
}

for _,v in next, workspace:WaitForChild('Interactions'):GetChildren() do
	if v.Name == 'Search Trash' then
		local Handler = v:FindFirstChildOfClass('MeshPart'):FindFirstChild('Handler')
		Handler.Triggered:Connect(function(Player)
			if not Handler.Enabled then return end
			local Stored = Player:FindFirstChild('stored')
			if Stored and Player.Character and Player.Character:FindFirstChild('Humanoid') then
				if Player.Character:FindFirstChild('Searched') then
					Player:Kick('Trash Bag Vuln')
				end
				local Searched = Instance.new('BoolValue', Player.Character)
				Searched.Name = 'Searched'
				Handler.Enabled = false
				task.spawn(function()
					task.wait(1)
					Searched:Destroy()
				end)
				if math.random(1, 100) <= 30 then
					local Luck = math.random(1, 100)
					local Got
					if Luck == 1 or Luck == 2 then
						local Money = math.random(500, 800)
						game:FindService('ServerStorage'):FindFirstChild('1911'):Clone().Parent = Player.Backpack
						Got = '$' .. Money .. ' + 1911'
						Stored.Money.Value += Money
					elseif Luck <= 10 then
						if math.random(1, 2) == 1 then
							game:FindService('ServerStorage'):FindFirstChild('Knife'):Clone().Parent = Player.Backpack
							Got = 'Knife'
						else
							game:FindService('ServerStorage'):FindFirstChild('Bat'):Clone().Parent = Player.Backpack
							Got = 'Bat'
						end
					elseif Luck <= 21 then
						local Money = math.random(Settings.Money.Max, Settings.Money.MaxLucky)
						Got = '$' .. Money
						Stored.Money.Value += Money
					else
						local Money = math.random(Settings.Money.Min, Settings.Money.Max)
						Got = '$' .. Money
						Stored.Money.Value += Money
					end
					if Player.PlayerGui:FindFirstChild('Adder') then Player.PlayerGui:FindFirstChild('Adder'):Destroy() end
					local Adder = game.ReplicatedStorage.Misc.Adder:Clone()
					Adder.Parent = Player.PlayerGui
					Adder.Amount.Text = '+' .. Got
					task.wait(2)
					for _ = 1, 100 do if Adder then Adder.Amount.TextTransparency += .01 Adder.Amount.UIStroke.Transparency += .01 task.wait(.00001) end end
				end
				Handler.Parent.ParticleEmitter.Enabled = false
				Handler.Parent.PointLight.Enabled = false
				task.wait(math.random(Settings.Cooldown.Min, Settings.Cooldown.Max) - 2)
				Handler.Parent.ParticleEmitter.Enabled = true
				Handler.Parent.PointLight.Enabled = true
				Handler.Enabled = true
			end
		end)
	end
end