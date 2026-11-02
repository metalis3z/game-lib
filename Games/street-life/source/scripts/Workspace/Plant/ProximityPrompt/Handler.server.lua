local Notify = game:FindService('ReplicatedStorage'):WaitForChild('Notify')

script.Parent.Triggered:Connect(function(Player)
	if not script.Parent.Enabled then return end
	if game:FindService('ReplicatedStorage'):FindFirstChild('BankCooldown').Value ~= 0 then return end
	if game.PrivateServerId ~= "" or game.PrivateServerOwnerId ~= 0 then
		Notify:FireClient(Player, 'NO PRIVATE SERVERS.', 2)
		return
	end
	
	local PlayerTotal = 0
	for _, v in pairs(game:GetService('Players'):GetPlayers()) do
		PlayerTotal = PlayerTotal + 1
	end

	if PlayerTotal < 10 then
		Notify:FireClient(Player, '10 PLAYERS MINIMUM.', 2)
		return 
	end

	if Player and Player.Character then
		if Player.Character:FindFirstChild('C4') then
			if not Player.PlayerGui:FindFirstChild('Circle') then
				local Clone = script.Parent:FindFirstChild('Circle'):Clone()
				Clone:FindFirstChild('Handler').Enabled = true
				Clone.Enabled = true
				Clone.Parent = Player.PlayerGui
				script.Parent.Parent:FindFirstChild('BillboardGui').Enabled = true
				script.Parent.Enabled = false
				task.wait(25)
				if Player then
					if Player.PlayerGui:FindFirstChild('Circle') then
						if Player.PlayerGui:FindFirstChild('Circle'):FindFirstChild('Object') then
							if game:FindService('ReplicatedStorage'):FindFirstChild('BankCooldown').Value == 0 then
								script.Parent.Enabled = true
								Player.PlayerGui:FindFirstChild('Circle'):Destroy()
								script.Parent.Parent:FindFirstChild('BillboardGui').Enabled = false
							end
						end
					else
						if game:FindService('ReplicatedStorage'):FindFirstChild('BankCooldown').Value == 0 and script.Parent.Parent:FindFirstChild('BillboardGui').Enabled then
							script.Parent.Enabled = true
							script.Parent.Parent:FindFirstChild('BillboardGui').Enabled = false
						end
					end
				else
					if game:FindService('ReplicatedStorage'):FindFirstChild('BankCooldown').Value == 0 and script.Parent.Parent:FindFirstChild('BillboardGui').Enabled then
						script.Parent.Enabled = true
						script.Parent.Parent:FindFirstChild('BillboardGui').Enabled = false
					end
				end
			end
		else
			if Player.Backpack:FindFirstChild('C4') then
				Notify:FireClient(Player, 'EQUIP THE C4.', 2)
			else
				Notify:FireClient(Player, 'YOU DONT HAVE A C4', 2)
			end
		end
	end
end)

game:FindService('ReplicatedStorage'):FindFirstChild('BankCooldown'):GetPropertyChangedSignal('Value'):Connect(function()
	if game:FindService('ReplicatedStorage'):FindFirstChild('BankCooldown').Value == 0 then
		script.Parent.Parent.Cooldown.Enabled = false
		script.Parent.Enabled = true
		script.Parent.Parent:FindFirstChild('BillboardGui').Enabled = false
	else
		script.Parent.Parent.Cooldown.Enabled = true
		script.Parent.Parent.Cooldown.TextLabel.Text = 'COOLDOWN: ' .. game:FindService('ReplicatedStorage'):FindFirstChild('BankCooldown').Value .. ' SECONDS'
	end
end)