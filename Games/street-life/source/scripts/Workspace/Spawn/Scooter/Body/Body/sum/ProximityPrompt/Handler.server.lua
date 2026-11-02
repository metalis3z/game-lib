script.Parent.Triggered:Connect(function(Player)
	if Player then
		if Player:FindFirstChild('stored') and Player:FindFirstChild('stored'):FindFirstChild('Money') then
			if Player:FindFirstChild('stored'):FindFirstChild('Money').Value >= 250 then
				Player:FindFirstChild('stored'):FindFirstChild('Money').Value -= 250
				_G.RentScooter(Player, 'Scooter', true)
				task.spawn(function()
					if Player.PlayerGui:FindFirstChild('Adder') then Player.PlayerGui:FindFirstChild('Adder'):Destroy() end
					local Adder = game:FindService('ReplicatedStorage').Misc.Adder:Clone()
					Adder.Parent = Player.PlayerGui
					Adder.Amount.TextColor3 = Color3.fromRGB(255, 0, 0)
					Adder.Amount.Text = '-$250'
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
			else
				game:FindService('ReplicatedStorage'):FindFirstChild('Notify'):FireClient(Player, 'Not enough money.', 3)
				return
			end
		end
	end
end)