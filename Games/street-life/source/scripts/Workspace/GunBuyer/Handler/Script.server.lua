local Gun_Prices = {}

for _,v in next, workspace.Map["Utility buildings"].Gunstore.Wall:GetChildren() do
	if v:IsA('Model') and v:FindFirstChild('Price') and v:FindFirstChild('Tool') then
		Gun_Prices[v.Tool.Value] = v.Price.Value
	end
end

for _,v in next, workspace.Map["Utility buildings"].Gunstore.Wallz:GetChildren() do
	if v:IsA('Model') and v:FindFirstChild('Price') and v:FindFirstChild('Tool') then
		Gun_Prices[v.Tool.Value] = v.Price.Value
	end
end

script.Parent.Triggered:Connect(function(Player)
	if Player and Player.Character then
		local Stored = Player:FindFirstChild('stored')
		if Stored then
			if game.PrivateServerId ~= "" or game.PrivateServerOwnerId ~= 0 then
				game:FindService('ReplicatedStorage'):FindFirstChild('Notify'):FireClient(Player, 'NO PRIVATE SERVERS.', 2)
				return
			end
			if Player.Character:FindFirstChildOfClass('Tool') then
				if Player.Character:FindFirstChildOfClass('Tool'):FindFirstChild('POLICE') then return end
				if Player.Character:FindFirstChildOfClass('Tool').Name == 'StabVest' then return end
				if Player.Character:FindFirstChildOfClass('Tool'):FindFirstChild('SPAWNER') then
					game:FindService('ReplicatedStorage'):FindFirstChild('Notify'):FireClient(Player, 'Cant sell spawner guns.', 2)
					return 
				end
				if Gun_Prices[Player.Character:FindFirstChildOfClass('Tool').Name] then
					Player.Character:FindFirstChild('Humanoid'):LoadAnimation(script:FindFirstChild('Takes')):Play()
					script.Parent.Parent:FindFirstChild('Humanoid'):LoadAnimation(script:FindFirstChild('Takes')):Play()
					script.Parent.Parent:FindFirstChild('HumanoidRootPart'):FindFirstChild('Kaching'):Play()
					local Price = Gun_Prices[Player.Character:FindFirstChildOfClass('Tool').Name] * .2
					local Tool = Player.Character:FindFirstChildOfClass('Tool')
					Tool.Parent = Player.Backpack
					Tool:Destroy()
					Stored.Money.Value += Price
					if Player.PlayerGui:FindFirstChild('Adder') then Player.PlayerGui:FindFirstChild('Adder'):Destroy() end
					local Adder = game:FindService('ReplicatedStorage').Misc.Adder:Clone()
					Adder.Parent = Player.PlayerGui
					Adder.Amount.Text = '+$' .. tostring(Price)
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
					game:FindService('ReplicatedStorage'):FindFirstChild('Notify'):FireClient(Player, 'You cant sell this tool.', 2)
				end
			else
				game:FindService('ReplicatedStorage'):FindFirstChild('Notify'):FireClient(Player, 'You dont have a gun equipped.', 2)
			end
		end
	end
end)