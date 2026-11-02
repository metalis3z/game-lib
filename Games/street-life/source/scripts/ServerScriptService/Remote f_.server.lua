local Deli_Prices = {
	['Balaclava'] = 40,
	['Pizza'] = 3,
	['Water'] = 2,
	['Taco'] = 4,
	['AppleJuice'] = 3,
	['GrapeJuice'] = 3,
	['CherryDrink'] = 5,
	['Burger'] = 30,
	['Protein Bar'] = 50,
	['Protein Shake'] = 50,
	['MentosBag'] = 300,
	['BlankCard'] = 1000,
	['C4'] = 2000,
	['Bat'] = 750,
	['Strawberry'] = 100,
	['Watermelon'] = 100,
	['Banana'] = 100
}

local Colors = {
	Color3.fromRGB(75, 151, 75),
	Color3.fromRGB(0, 68, 255),
	Color3.fromRGB(208, 0, 3)
}

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

game:FindService('ReplicatedStorage'):FindFirstChild('Buy').OnServerEvent:Connect(function(Player, Food, Price)
	if Player and Food and Price then
		local Stored = Player:FindFirstChild('stored')
		if Stored and Stored.Money.Value >= Price then
			if Deli_Prices[Food] and Deli_Prices[Food] == Price then
				if game:FindService('ServerStorage'):FindFirstChild(Food) and Food ~= 'C4' then
					Stored.Money.Value -= Price
					local Clone = game:FindService('ServerStorage'):FindFirstChild(Food):Clone()
					Clone.Parent = Player:WaitForChild('Backpack')
					if Food == 'Protein Shake' then
						Clone.Handle:FindFirstChild('Change').Color = Colors[math.random(1, #Colors)]
					end
				else
					if Food == 'BlankCard' then
						if game:FindService('ServerStorage'):FindFirstChild('Secret'):FindFirstChild(Food) then
							if (game:FindFirstChild('MarketplaceService'):UserOwnsGamePassAsync(Player.UserId, 800418473) or game:FindFirstChild('MarketplaceService'):UserOwnsGamePassAsync(Player.UserId, 793533527)) and workspace:FindFirstChild('IllegalDealer'):FindFirstChild('Amount').Value ~= 0 then
								Stored.Money.Value -= 1000
								workspace:FindFirstChild('IllegalDealer'):FindFirstChild('Amount').Value -= 1
								task.spawn(function()
									task.wait(300)
									workspace:FindFirstChild('IllegalDealer'):FindFirstChild('Amount').Value += 1
								end)
								game:FindService('ServerStorage'):FindFirstChild('Secret'):FindFirstChild(Food):Clone().Parent = Player:WaitForChild('Backpack')
							end
						end
					elseif Food == 'C4' then
						if game:FindService('ServerStorage'):FindFirstChild(Food) then
							if workspace:FindFirstChild('IllegalDealer'):FindFirstChild('CAmount').Value ~= 0 then
								Stored.Money.Value -= 2000
								workspace:FindFirstChild('IllegalDealer'):FindFirstChild('CAmount').Value -= 1
								task.spawn(function()
									task.wait(200)
									workspace:FindFirstChild('IllegalDealer'):FindFirstChild('CAmount').Value += 1
								end)
								game:FindService('ServerStorage'):FindFirstChild(Food):Clone().Parent = Player:WaitForChild('Backpack')
							end
						end
					end
				end
			end
		end
	end
end)

game:FindService('ReplicatedStorage'):FindFirstChild('GBuy').OnServerEvent:Connect(function(Player, Gun, Price)
	if Player and Gun and Price then
		local Stored = Player:FindFirstChild('stored')
		if Stored and Stored.Money.Value >= Price then
			if Gun_Prices[Gun] and Gun_Prices[Gun] == Price then
				if game:FindService('ServerStorage'):FindFirstChild(Gun) then
					if Gun == 'MPX' or Gun == 'Perun X-16' or Gun == 'StabVest' or Gun == 'DoubleBarrel' then
						if game:FindFirstChild('MarketplaceService'):UserOwnsGamePassAsync(Player.UserId, 834486805) then
							Stored.Money.Value -= Price
							game:FindService('ServerStorage'):FindFirstChild(Gun):Clone().Parent = Player:WaitForChild('Backpack')
						end
					else
						Stored.Money.Value -= Price
						game:FindService('ServerStorage'):FindFirstChild(Gun):Clone().Parent = Player:WaitForChild('Backpack')
					end
				end
			end
		end
	end
end)