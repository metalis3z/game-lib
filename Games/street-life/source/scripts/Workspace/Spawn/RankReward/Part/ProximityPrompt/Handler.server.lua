local Amount = 2500

script.Parent.Triggered:Connect(function(Player)
	if Player.Character and Player.Character:FindFirstChild('Humanoid').Health > 0 then
		local Stored = Player:FindFirstChild('stored')
		if Stored then
			local ClaimedGroup = Stored:FindFirstChild('ClaimedGroup')
			local Money = Stored:FindFirstChild('Money')
			if Player:IsInGroup(16041902) then
				if ClaimedGroup and ClaimedGroup.Value == false then
					ClaimedGroup.Value = true
					task.spawn(function()
						if Player.PlayerGui:FindFirstChild('Adder') then Player.PlayerGui:FindFirstChild('Adder'):Destroy() end
						local Adder = game:FindService('ReplicatedStorage').Misc.Adder:Clone()
						Adder.Parent = Player.PlayerGui
						Adder.Amount.Text = '+$' .. tostring(Amount)
						Money.Value += Amount
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
					game:FindService('ReplicatedStorage'):FindFirstChild('Notify'):FireClient(Player, 'You already claimed this.', 2)
				end
			else
				game:FindService('ReplicatedStorage'):FindFirstChild('Notify'):FireClient(Player, 'You arent in our roblox group.', 3)
			end
		end
	end
end)