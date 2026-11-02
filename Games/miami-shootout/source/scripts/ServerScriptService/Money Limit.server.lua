local bankLimit = 99999999999999999999999999999999999999999999999999
local cashLimit = 99999999999999999999999999999999999999999999999999

local whitelisted = {
 -- jaden
	
	-1, -- studio
	0,
	0
}

game.Players.PlayerAdded:Connect(function(p)
	
	if not table.find(whitelisted,p.UserId) then
		print("APPLYING LIMITS")
		local storedData = p:WaitForChild("stored")
		local money, bank = storedData:WaitForChild("Money"), storedData:WaitForChild("Bank")

		money:GetPropertyChangedSignal('Value'):Connect(function()
			if money.Value > cashLimit then
				money.Value = cashLimit
			end
		end)

		bank:GetPropertyChangedSignal('Value').Changed:Connect(function()
			if bank.Value > bankLimit then
				bank.Value = bankLimit
			end
		end)
	end
	
end)

while wait(5) do
	
	for i,v in pairs(game.Players:GetPlayers()) do
		if not table.find(whitelisted,v.UserId) then
			
			local storedData = v:FindFirstChild("stored")
			if storedData then
				local money,bank = storedData:FindFirstChild("Money"), storedData:FindFirstChild("Bank")
				if money then
					if money.Value > cashLimit then
						money.Value = cashLimit
					end
				end
				if bank then
					if bank.Value > bankLimit then
						bank.Value = bankLimit
					end
				end
			end
			
		end
	end
	
end