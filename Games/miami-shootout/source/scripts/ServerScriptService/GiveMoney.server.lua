function comma_value(amount)
	local formatted = amount
	while true do  
		formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
		if (k==0) then
			break
		end
	end
	return formatted
end

function getPlayerMoneyCount(player)

	local checksFolder = game.Workspace.Dollas
	local count = 0
	for i,v in pairs(checksFolder:GetChildren()) do
		if v:FindFirstChild("From") then
			if v:FindFirstChild("From").Value == player and v:FindFirstChild("DROPPED") then
				count = count + 1
			end
		end
	end

	wait()
	return count

end

local db = {}

game.ReplicatedStorage.GiveMoney.OnServerEvent:Connect(function(plr, otherPlr, amount)
	
	if db[plr] then return end
	
	if not tonumber(amount) then return print("a") end
	amount = tonumber(amount)
	if amount <= 1 and amount ~= 1 then return print("b") end
	amount = math.floor(amount + 0.5)
	
	if amount > 10000 then
		amount = 10000
	end
	
	db[plr] = true
	delay(2,function()
		db[plr] = nil
	end)
	
	if otherPlr == "drop" then
		if plr.stored.Money.Value >= amount then
			plr.stored.Money.Value = plr.stored.Money.Value - amount

			local checksActive = getPlayerMoneyCount(plr)
			if checksActive >= 4 then
				return game.ReplicatedStorage.server:FireClient(plr,"alert","You have too many dollars on the floor!")
			end
			
			local Money = plr:FindFirstChild("stored"):FindFirstChild("Money")
		
			game.ReplicatedStorage.PhoneStuff.Phone:FireClient(plr,"play",game.ReplicatedStorage.assets_imp.money)
			game.ReplicatedStorage.server:FireClient(plr,"alert","-$"..comma_value(amount))

			local dollar = game.ServerStorage.Money:Clone()
			dollar.Gui.MainFrame.rank.Text = "$"..comma_value(amount)
			dollar.From.Value = plr
			dollar.Amount.Value = amount

			dollar.Parent = game.Workspace.Dollas
			dollar.CFrame = plr.Character.PrimaryPart.CFrame
			dollar.DollarScript.Enabled = true
			dollar.ProximityPrompt.Enabled = true
			
			Instance.new("NumberValue",dollar).Name = "DROPPED"

			print("bro dropped money")
			game.Debris:AddItem(dollar,100)
			
			game.ReplicatedStorage.MoneyLog:Fire(plr.Name.. " dropped $"..comma_value(amount),"N/A")
		end	
		return
	end
	
	if plr.stored.Money.Value >= amount and otherPlr and amount >= 1 then
		
		otherPlr = game.Players:FindFirstChild(otherPlr)
		
		if not otherPlr then
			return game.ReplicatedStorage.server:FireClient(plr,"alert","Invalid player!")
		end
		
		if otherPlr == plr then
			return game.ReplicatedStorage.server:FireClient(plr,"alert","Can't give to yourself!")
		end
		
		plr.stored.Money.Value = plr.stored.Money.Value - amount
		otherPlr.stored.Money.Value = otherPlr.stored.Money.Value + amount
		game.ReplicatedStorage.GiveMoney:FireClient(otherPlr, plr.Name, amount)
		
		game.ReplicatedStorage.PhoneStuff.Phone:FireClient(plr,"play",game.ReplicatedStorage.assets_imp.money)
		game.ReplicatedStorage.server:FireClient(plr,"alert","-$"..comma_value(amount))
		
		game.ReplicatedStorage.MoneyLog:Fire(plr.Name.. " sent "..otherPlr.Name .. " $"..comma_value(amount),"N/A")
	end
end)