local JobRemote = game:FindService('ReplicatedStorage'):FindFirstChild('Job')
local Timer = false

script.Parent.Triggered:Connect(function(Player)
	if not script.Parent.Enabled then return end
	if Timer == false then script.Parent.Parent:Destroy() return end
	local Extra = Player:WaitForChild('Extra')
	local ColorValue = script.Parent.Parent:FindFirstChild('ColorValue')

	if Extra.Job.Value == 'Frosty' and script.Parent.Parent.Name == 'NPC ' .. Player.Name then
		if Player:FindFirstChild('CurrentFrost') then
			if Player:FindFirstChild('CurrentFrost').Value == ColorValue.Value then
				script.Parent.Enabled = false
				local Earned = Player:FindFirstChild('FrostyJobEarned')
				local Amount = math.random(55, 70)
				if game:FindFirstChild('MarketplaceService'):UserOwnsGamePassAsync(Player.UserId, 800131475) or game:FindFirstChild('MarketplaceService'):UserOwnsGamePassAsync(Player.UserId, 734604960) then
					Amount = Amount + Amount
				end
				Earned.Value = Earned.Value + Amount
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
					local Adder = game.ReplicatedStorage.Misc.Adder:Clone()
					Adder.Parent = Player.PlayerGui
					Adder.Amount.Text = '+$' .. tostring(Amount)
					task.wait(.5)
					for _ = 1, 100 do if Adder then Adder.Amount.TextTransparency += .01 Adder.Amount.UIStroke.Transparency += .01 task.wait(.00001) end end
					if Adder then Adder:Destroy() end
				end)
				Player:FindFirstChild('CurrentFrost'):Destroy()
				script.Parent.Parent:Destroy()
			else
				Player:FindFirstChild('CurrentFrost'):Destroy()
				script.Parent.Enabled = false
				Player:FindFirstChild('stored'):FindFirstChild('Money').Value -= 30
				game:FindService('ReplicatedStorage'):FindFirstChild('Notify'):FireClient(Player, 'Wrong frosted color!', 2)
				game.ReplicatedStorage.server:FireClient(Player, "money", 30)
				script.Parent.Parent:Destroy()
			end
		end
	end
end)

task.wait(2)
Timer = true
script.Parent.Parent:FindFirstChild('HumanoidRootPart').Anchored = true