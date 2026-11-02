game.Players.PlayerAdded:Connect(function(Player)
	Player.Chatted:Connect(function(Message)
		local Table = string.split(Message, " ")
		if string.lower(Table[1]) == "/pay" then
			if Table[2] then
				local Wallet = Player:FindFirstChild('stored'):FindFirstChild('Money')
				if tonumber(Table[2]) == nil then return end
				local Value = tonumber(math.floor(Table[2]))
				if Value and Value > 0 and Value <= Wallet.Value and Value <= 300 then
					if (string.match(Table[2], "%.")) then
						return
					end
					Wallet.Value = Wallet.Value - Value
					local Cash = script.CashXS:Clone()
					Cash.val.Value = Value
					Cash.Name = "$"..Value
					Cash.Parent = Player.Backpack
					Cash.RedeemScript.Disabled = false
					Cash.ToolTip = "$"..Value
					game.ReplicatedStorage.server:FireClient(Player,"money", Value, false)
				elseif Value and Value > 300 and Value <= Wallet.Value and Value <= 800 then
					if (string.match(Table[2], "%.")) then
						return
					end
					Wallet.Value = Wallet.Value - Value
					local Cash = script.CashS:Clone()
					Cash.val.Value = Value
					Cash.Name = "$"..Value
					Cash.Parent = Player.Backpack
					Cash.RedeemScript.Disabled = false
					Cash.ToolTip = "$"..Value
					game.ReplicatedStorage.server:FireClient(Player,"money", Value, false)
				elseif Value and Value > 800 and Value <= Wallet.Value and Value <= 1500 then
					if (string.match(Table[2], "%.")) then
						return
					end
					Wallet.Value = Wallet.Value - Value
					local Cash = script.CashM:Clone()
					Cash.val.Value = Value
					Cash.Name = "$"..Value
					Cash.Parent = Player.Backpack
					Cash.RedeemScript.Disabled = false
					Cash.ToolTip = "$"..Value
					game.ReplicatedStorage.server:FireClient(Player,"money", Value, false)
				elseif Value and Value > 1500 and Value <= Wallet.Value and Value <= 5000 then
					if (string.match(Table[2], "%.")) then
						return
					end
					Wallet.Value = Wallet.Value - Value
					local Cash = script.CashL:Clone()
					Cash.val.Value = Value
					Cash.Name = "$"..Value
					Cash.Parent = Player.Backpack
					Cash.RedeemScript.Disabled = false
					Cash.ToolTip = "$"..Value
					game.ReplicatedStorage.server:FireClient(Player,"money", Value, false)
				elseif Value and Value > 5000 and Value <= Wallet.Value and Value <= 50000 then
					if (string.match(Table[2], "%.")) then
						return
					end
					Wallet.Value = Wallet.Value - Value
					local Cash = script.CashXL:Clone()
					Cash.val.Value = Value
					Cash.Name = "$"..Value
					Cash.Parent = Player.Backpack
					Cash.RedeemScript.Disabled = false
					Cash.ToolTip = "$"..Value
					game.ReplicatedStorage.server:FireClient(Player,"money", Value, false)
				end
			end
		end
	end)
end)

game:FindService('ReplicatedStorage'):FindFirstChild('ControllerRemote').OnServerEvent:Connect(function(Player, Arg, Amount)
	if tonumber(Arg) ~= nil and Amount == 'Pay' then
		if Arg then
			local Wallet = Player:FindFirstChild('stored'):FindFirstChild('Money')
			local Value = tonumber(math.floor(Arg))
			if Value and Value > 0 and Value <= Wallet.Value and Value <= 300 then
				if (string.match(Arg, "%.")) then
					return
				end
				Wallet.Value = Wallet.Value - Value
				local Cash = script.CashXS:Clone()
				Cash.val.Value = Value
				Cash.Name = "$"..Value
				Cash.Parent = Player.Backpack
				Cash.RedeemScript.Disabled = false
				Cash.ToolTip = "$"..Value
				game.ReplicatedStorage.server:FireClient(Player,"money", Value, false)
			elseif Value and Value > 300 and Value <= Wallet.Value and Value <= 800 then
				if (string.match(Arg, "%.")) then
					return
				end
				Wallet.Value = Wallet.Value - Value
				local Cash = script.CashS:Clone()
				Cash.val.Value = Value
				Cash.Name = "$"..Value
				Cash.Parent = Player.Backpack
				Cash.RedeemScript.Disabled = false
				Cash.ToolTip = "$"..Value
				game.ReplicatedStorage.server:FireClient(Player,"money", Value, false)
			elseif Value and Value > 800 and Value <= Wallet.Value and Value <= 1500 then
				if (string.match(Arg, "%.")) then
					return
				end
				Wallet.Value = Wallet.Value - Value
				local Cash = script.CashM:Clone()
				Cash.val.Value = Value
				Cash.Name = "$"..Value
				Cash.Parent = Player.Backpack
				Cash.RedeemScript.Disabled = false
				Cash.ToolTip = "$"..Value
				game.ReplicatedStorage.server:FireClient(Player,"money", Value, false)
			elseif Value and Value > 1500 and Value <= Wallet.Value and Value <= 5000 then
				if (string.match(Arg, "%.")) then
					return
				end
				Wallet.Value = Wallet.Value - Value
				local Cash = script.CashL:Clone()
				Cash.val.Value = Value
				Cash.Name = "$"..Value
				Cash.Parent = Player.Backpack
				Cash.RedeemScript.Disabled = false
				Cash.ToolTip = "$"..Value
				game.ReplicatedStorage.server:FireClient(Player,"money", Value, false)
			elseif Value and Value > 5000 and Value <= Wallet.Value and Value <= 50000 then
				if (string.match(Arg, "%.")) then
					return
				end
				Wallet.Value = Wallet.Value - Value
				local Cash = script.CashXL:Clone()
				Cash.val.Value = Value
				Cash.Name = "$"..Value
				Cash.Parent = Player.Backpack
				Cash.RedeemScript.Disabled = false
				Cash.ToolTip = "$"..Value
				game.ReplicatedStorage.server:FireClient(Player,"money", Value, false)
			end
		end
	end
end)