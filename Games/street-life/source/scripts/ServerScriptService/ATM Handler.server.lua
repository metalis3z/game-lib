local ATM = game:FindService('ReplicatedStorage').ATM
local Blank = game:FindService('ReplicatedStorage').Blank

ATM.OnServerEvent:Connect(function(Player, Type, Payment)
	local Wallet_Data = Player:WaitForChild('stored'):FindFirstChild('Money')
	local Bank_Data = Player:WaitForChild('stored'):FindFirstChild('Bank')
	Payment = math.floor(Payment)
	
	if Type and Payment then
		if Payment < 0 or Payment > 100000 and typeof(Payment) == 'number' then return end
		if Type == 'Deposit' then
			if Wallet_Data.Value >= Payment then
				Wallet_Data.Value = Wallet_Data.Value - Payment
				Bank_Data.Value = Bank_Data.Value + Payment
			end
		elseif Type == 'Withdraw' then
			if Bank_Data.Value >= Payment then
				Wallet_Data.Value = Wallet_Data.Value + Payment
				Bank_Data.Value = Bank_Data.Value - Payment
			end
		elseif Type == nil then
			Player:Kick()
		end
	end
end)

Blank.OnServerEvent:Connect(function(Player, Tool, Proximity, Arg)
	if Arg == nil then
		if Player:IsDescendantOf(game:FindService('Players')) then
			if Tool and Tool.Name == 'ActiveCard' then
				if Proximity:IsA('ProximityPrompt') and Proximity.Name == 'Blank' then
					if Tool.Parent == Player.Character then
						local Stored = Player:WaitForChild('stored')
						local HRP = Player.Character:FindFirstChild('HumanoidRootPart') 
						if Stored and HRP then
							Tool:Destroy()
							HRP.Anchored = true
							HRP.CFrame = Proximity.Parent.Parent:FindFirstChild('Position').CFrame
							local Animation = Player.Character:FindFirstChild('Humanoid'):LoadAnimation(game:FindService('ReplicatedStorage').AnimationEvents:FindFirstChild('Card'))
							Animation:AdjustSpeed(.5)
							Animation:Play()
							Animation.Stopped:Wait()
							HRP.Anchored = false
							if math.random() <= 0.65 then
								local Amount = math.random(2250 * 2, 3750 * 2)
								Stored.Money.Value += Amount
								game.ReplicatedStorage.server:FireClient(Player,"money", Amount, 'GAINED')
							else
								game.ReplicatedStorage:FindFirstChild('Notify'):FireClient(Player, 'You got nothing from the active card.', 3)
							end
						end
					end
				end
			end
		end
	elseif Arg == true and Proximity == 'Test' then
		local Tool = Player.Character:FindFirstChild('BlankCard') 
		if Tool then 
			Tool.Name = 'ActiveCard'
			Player.Character:FindFirstChild('Humanoid'):UnequipTools()
		end
	end
end)