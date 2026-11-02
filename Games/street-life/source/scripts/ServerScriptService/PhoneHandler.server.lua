local PhoneRemote = game:FindService('ReplicatedStorage'):WaitForChild('Phone')
local Notify = game:FindService('ReplicatedStorage'):FindFirstChild('Notify')

PhoneRemote.OnServerEvent:Connect(function(Player, Argument, Extra, Extra2)
	if Player and Argument and Extra then
		if Argument == 'SendMessage' then
			Extra = game:FindService('TextService'):FilterStringAsync(Extra, Player.UserId):GetNonChatStringForBroadcastAsync()
			if Extra then
				PhoneRemote:FireAllClients(Player, 'AddMessage', Extra)
			end
		elseif Argument == 'SendPrivateMessage' then
			Extra = game:FindService('TextService'):FilterStringAsync(Extra, Player.UserId):GetNonChatStringForBroadcastAsync()
			if Extra then
				PhoneRemote:FireClient(Player, Player, 'AddPrivateMessage', Extra, Extra2)
				PhoneRemote:FireClient(Extra2, Player, 'AddPrivateMessage', Extra, Player)
			end
		elseif Argument == 'SendMoney' then
			if tonumber(Extra2) ~= nil then
				Extra2 = tonumber(math.floor(Extra2))
				if Extra2 < 1 then return end
				if Extra2 >= 1 then
					local PlayerWallet = Player:FindFirstChild('stored'):FindFirstChild('Bank')
					local TargetWallet = Extra:FindFirstChild('stored'):FindFirstChild('Bank')

					if PlayerWallet.Value >= Extra2 then
						PlayerWallet.Value -= Extra2
						TargetWallet.Value += Extra2
						Notify:FireClient(Player, 'You Sent $' .. tostring(Extra2) .. ' to ' .. Extra.Name, 2)
						Notify:FireClient(Extra, 'You Received $' .. tostring(Extra2) .. ' from ' .. Player.Name, 2)
					end
				end
			end
		elseif Argument == 'Crypto' then
			if Extra == 'Purchase' then
				local PlayerWallet = Player:FindFirstChild('stored'):FindFirstChild('Bank')
				local CryptoPrice = game:FindService('ReplicatedStorage'):WaitForChild('Crypto')

				if Extra2 == CryptoPrice.Value then
					if PlayerWallet.Value >= Extra2 then
						if Player:FindFirstChild('Crypto') then
							if Player:FindFirstChild('Crypto').Value < 10 then
								Player:FindFirstChild('Crypto').Value += 1
								PlayerWallet.Value -= CryptoPrice.Value
								Notify:FireClient(Player, 'You Bought 1 Bitcoin for $' .. CryptoPrice.Value, 2)
							else
								Notify:FireClient(Player, 'Reached Max Bitcoin Balance.', 2)
							end
						end
					else
						game:FindService('ReplicatedStorage'):FindFirstChild('Notify'):FireClient('You cant afford 1 Bitcoin.', 2)
					end
				end
			elseif Extra == 'Sell' then
				local PlayerWallet = Player:FindFirstChild('stored'):FindFirstChild('Bank')
				local CryptoPrice = game:FindService('ReplicatedStorage'):WaitForChild('Crypto')
				local PlayerBalance = Player:FindFirstChild('Crypto')

				if PlayerBalance.Value >= 1 then
					if Extra2 == CryptoPrice.Value then
						if Player:FindFirstChild('Crypto') then
							Player:FindFirstChild('Crypto').Value -= 1
							PlayerWallet.Value += CryptoPrice.Value
							Notify:FireClient(Player, 'You Sold 1 Bitcoin for $' .. CryptoPrice.Value, 2)
						end
					end
				end
			end
		elseif Argument == 'ETH' then
			if Extra == 'Purchase' then
				local PlayerWallet = Player:FindFirstChild('stored'):FindFirstChild('Bank')
				local CryptoPrice = game:FindService('ReplicatedStorage'):WaitForChild('ETH')

				if Extra2 == CryptoPrice.Value then
					if PlayerWallet.Value >= Extra2 then
						if Player:FindFirstChild('ETH') then
							if Player:FindFirstChild('ETH').Value < 20 then
								Player:FindFirstChild('ETH').Value += 1
								PlayerWallet.Value -= CryptoPrice.Value
								Notify:FireClient(Player, 'You Bought 1 ETH for $' .. CryptoPrice.Value, 2)
							else
								Notify:FireClient(Player, 'Reached Max ETH Balance.', 2)
							end
						end
					else
						game:FindService('ReplicatedStorage'):FindFirstChild('Notify'):FireClient('You cant afford 1 ETH.', 2)
					end
				end
			elseif Extra == 'Sell' then
				local PlayerWallet = Player:FindFirstChild('stored'):FindFirstChild('Bank')
				local CryptoPrice = game:FindService('ReplicatedStorage'):WaitForChild('ETH')
				local PlayerBalance = Player:FindFirstChild('ETH')

				if PlayerBalance.Value >= 1 then
					if Extra2 == CryptoPrice.Value then
						if Player:FindFirstChild('ETH') then
							Player:FindFirstChild('ETH').Value -= 1
							PlayerWallet.Value += CryptoPrice.Value
							Notify:FireClient(Player, 'You Sold 1 ETH for $' .. CryptoPrice.Value, 2)
						end
					end
				end
			end
		elseif Argument == 'DOGE' then
			if Extra == 'Purchase' then
				local PlayerWallet = Player:FindFirstChild('stored'):FindFirstChild('Bank')
				local CryptoPrice = game:FindService('ReplicatedStorage'):WaitForChild('DOGE')

				if Extra2 == CryptoPrice.Value then
					if PlayerWallet.Value >= Extra2 then
						if Player:FindFirstChild('DOGE') then
							if Player:FindFirstChild('DOGE').Value < 100 then
								Player:FindFirstChild('DOGE').Value += 1
								PlayerWallet.Value -= CryptoPrice.Value
								Notify:FireClient(Player, 'You Bought 1 DOGE for $' .. CryptoPrice.Value, 2)
							else
								Notify:FireClient(Player, 'Reached Max DOGE Balance.', 2)
							end
						end
					else
						game:FindService('ReplicatedStorage'):FindFirstChild('Notify'):FireClient('You cant afford 1 DOGE.', 2)
					end
				end
			elseif Extra == 'Sell' then
				local PlayerWallet = Player:FindFirstChild('stored'):FindFirstChild('Bank')
				local CryptoPrice = game:FindService('ReplicatedStorage'):WaitForChild('DOGE')
				local PlayerBalance = Player:FindFirstChild('DOGE')

				if PlayerBalance.Value >= 1 then
					if Extra2 == CryptoPrice.Value then
						if Player:FindFirstChild('DOGE') then
							Player:FindFirstChild('DOGE').Value -= 1
							PlayerWallet.Value += CryptoPrice.Value
							Notify:FireClient(Player, 'You Sold 1 DOGE for $' .. CryptoPrice.Value, 2)
						end
					end
				end
			end
		end
	end
end)

game:FindService('ReplicatedStorage'):FindFirstChild('Notify').OnServerEvent:Connect(function(Player, Messsage, Time)
	if Player and Messsage and Time then
		Notify:FireClient(Player, Messsage, Time)
	end
end)

while task.wait() do
	for _ = 1, 30 do
		game:FindService('ReplicatedStorage'):FindFirstChild('CryptoTimer').Value -= 1
		task.wait(1)
	end
	local NewAmount = math.random(-500, 500)

	if game:FindService('ReplicatedStorage'):FindFirstChild('Crypto').Value + NewAmount >= 10000 then
		game:FindService('ReplicatedStorage'):FindFirstChild('Crypto').Value = 10000
	elseif game:FindService('ReplicatedStorage'):FindFirstChild('Crypto').Value + NewAmount <= 1000 then
		game:FindService('ReplicatedStorage'):FindFirstChild('Crypto').Value = 1000
	else
		game:FindService('ReplicatedStorage'):FindFirstChild('Crypto').Value += NewAmount
	end

	local NewAmount2 = math.random(-100, 100)

	if game:FindService('ReplicatedStorage'):FindFirstChild('ETH').Value + NewAmount2 >= 1000 then
		game:FindService('ReplicatedStorage'):FindFirstChild('ETH').Value = 1000
	elseif game:FindService('ReplicatedStorage'):FindFirstChild('ETH').Value + NewAmount2 <= 100 then
		game:FindService('ReplicatedStorage'):FindFirstChild('ETH').Value = 100
	else
		game:FindService('ReplicatedStorage'):FindFirstChild('ETH').Value += NewAmount2
	end	
	
	local NewAmount3 = math.random(-35, 35)
	
	if game:FindService('ReplicatedStorage'):FindFirstChild('DOGE').Value + NewAmount3 >= 250 then
		game:FindService('ReplicatedStorage'):FindFirstChild('DOGE').Value = 250
	elseif game:FindService('ReplicatedStorage'):FindFirstChild('DOGE').Value + NewAmount3 <= 1 then
		game:FindService('ReplicatedStorage'):FindFirstChild('DOGE').Value = 1
	else
		game:FindService('ReplicatedStorage'):FindFirstChild('DOGE').Value += NewAmount3
	end
	
	game:FindService('ReplicatedStorage'):FindFirstChild('CryptoTimer').Value = 30

end
