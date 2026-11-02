local db = {}

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

local function RemoveSpaces(name)
	return name:gsub('%s+', '') or name
end

local function getPlayer(name)
	name = RemoveSpaces(name)
	for i, player in pairs(game:GetService('Players'):GetPlayers()) do
		if player.Name:lower():match('^'.. name:lower()) then
			return player
		end
	end
	return nil
end

local dropDb = {}
local dropMax = 850

function getPlayerCheckCount(player)
	
	local checksFolder = game.Workspace.Checks
	local count = 0
	for i,v in pairs(checksFolder:GetChildren()) do
		if v:FindFirstChild("By") then
			if v:FindFirstChild("By").Value == player.Name then
				count = count + 1
			end
		end
	end
	
	wait()
	return count
	
end

game.Players.PlayerAdded:Connect(function(p)
	p.Chatted:Connect(function(msg)
		local splits = msg:split(" ")
		--[[
		if splits[1]:lower() == "/check" then

			if not p.Character.Humanoid then return print("no human") end
			if p.Character.Humanoid.Health == 0 then return print("dead") end
			
			if dropDb[p] then return game.ReplicatedStorage.server:FireClient(p,"alert","On cooldown!") end
			
			if not splits[2] or not splits[3] then return end

			local playerToDropFor = getPlayer(splits[2]:lower())
			if not playerToDropFor then return end

			if playerToDropFor.UserId == p.UserId then return end
			
			
			local amount = tonumber(splits[3])
			if not amount then return end
			local limit = 30000
			if amount < 1 then return end
			if amount > limit then amount = limit end
			if not tonumber(amount) then return end
			
			local cash = p:FindFirstChild("stored"):FindFirstChild("Bank")

			if amount > cash.Value then return game.ReplicatedStorage.server:FireClient(p,"alert","Not enough in your bank!") end 
			
			local checksActive = getPlayerCheckCount(p)
			if checksActive >= 4 then
				return game.ReplicatedStorage.server:FireClient(p,"alert","You have too many checks on the floor!")
			end
			
			dropDb[p] = true
			delay(3,function()
				dropDb[p] = nil
			end)
			
			cash.Value = cash.Value - amount

			local physc = game.Lighting.CheckModel:Clone()
			physc.Handle.BillboardGui.ItemText.Text = "$"..comma_value(amount)
			physc.Paper.BillboardGui.ItemText.Text = "By "..p.Name.." | For "..playerToDropFor.Name

			physc.By.Value = p.Name
			physc.For.Value = playerToDropFor.Name
			physc.Price.Value = amount

			physc.Parent = game.Workspace.Checks
			physc:MoveTo(p.Character.HumanoidRootPart.Position)
			print("Done")
			
			game.ReplicatedStorage.PhoneStuff.Phone:FireClient(p,"play",game.ReplicatedStorage.assets_imp.money)
			game.ReplicatedStorage.server:FireClient(p,"alert","-$"..tostring(comma_value(amount)).."!")
			
			game.Debris:AddItem(physc,180)
			
			game.ReplicatedStorage.MoneyLog:Fire(p.Name.. " dropped a check for $"..comma_value(amount),"To "..playerToDropFor.Name)
		end
		--]]
	end)
	
	p.CharacterAdded:Connect(function(c)
		wait()
		local hum = c:WaitForChild("Humanoid")
		local combatTimer = 60
		hum.Died:Connect(function()
			
			if _G.shooters[hum] and game.PrivateServerOwnerId == 0 then
				print("is shooter")
				local timeLeft = string.gsub(tostring(math.round(_G.shooters[hum] - time())),"-","")
				if tonumber(timeLeft) <= tonumber(combatTimer) then
					print("shot last 60 sec")
					local Money = p:FindFirstChild("stored"):FindFirstChild("Money")
				
					if Money.Value == 0 or Money.Value == 1000 then
						return print("bro broke")
					end
					
					local DeathMoney = math.round((Money.Value * 0.1))
				
					if DeathMoney <= 0 then
						return print("no")
					end
				
					if DeathMoney >= dropMax then
						DeathMoney = dropMax
					end
				
					Money.Value = Money.Value - DeathMoney
					game.ReplicatedStorage.PhoneStuff.Phone:FireClient(p,"play",game.ReplicatedStorage.assets_imp.money)
					game.ReplicatedStorage.server:FireClient(p,"alert","You lost $"..comma_value(DeathMoney).." for dying in combat!")
				
					local dollar = game.ServerStorage.Money:Clone()
					dollar.Gui.MainFrame.rank.Text = "$"..comma_value(DeathMoney)
					dollar.From.Value = p
					dollar.Amount.Value = DeathMoney
				
					dollar.Parent = game.Workspace.Dollas
					dollar.CFrame = p.Character.PrimaryPart.CFrame
					dollar.DollarScript.Enabled = true
					dollar.ProximityPrompt.Enabled = true
			
					print("bro dropped money")
					game.Debris:AddItem(dollar,100)
				else
					print("good")
				end	
			end	
		end)
	end)
	
end)

game.ReplicatedStorage.BankAction.OnServerEvent:Connect(function(p,action,amount)
	local cash = p:FindFirstChild("stored"):FindFirstChild("Money")
	local bank = p:FindFirstChild("stored"):FindFirstChild("Bank")
	if action == "depo" then
		if not tonumber(amount) then return print("NaN") end
		amount = tonumber(amount)
		if amount < 1 then return end
		local limit = 30000
		local amt = amount
		amt = tonumber(amt)
		print(amt)
		if amount > limit then amt = limit end
		if amt > cash.Value then return game.ReplicatedStorage.server:FireClient(p,"alert","You don't have enough for that!") end

		if db[p.UserId] then return game.ReplicatedStorage.server:FireClient(p,"alert","On cooldown") end

		db[p.UserId] = true

		cash.Value = cash.Value - amt
		bank.Value = bank.Value + amt
		
		game.ReplicatedStorage.PhoneStuff.Phone:FireClient(p,"play",game.ReplicatedStorage.assets_imp.money)
		game.ReplicatedStorage.server:FireClient(p,"alert","-$"..tostring(comma_value(amt)).."!")
		--game.ReplicatedStorage.Roleplay:Fire(p,"Would deposit $"..amt.." into their bank account")

		delay(3,function()
			db[p.UserId] = nil
		end)
		
		game.ReplicatedStorage.MoneyLog:Fire(p.Name.. " deposited $"..comma_value(amount),"N/A")
	end
	if action == "with" then
		if not tonumber(amount) then return print("NaN") end
		amount = tonumber(amount)
		if amount < 1 then return end
		local limit = 90000
		local amt = amount
		amt = tonumber(amt)
		print(amt)
		if amount > limit then amt = limit end
		if amt > bank.Value then return game.ReplicatedStorage.server:FireClient(p,"alert","You don't have enough for that!") end

		if db[p.UserId] then return game.ReplicatedStorage.server:FireClient(p,"alert","On cooldown") end

		db[p.UserId] = true

		cash.Value = cash.Value + amt
		bank.Value = bank.Value - amt
		game.ReplicatedStorage.server:FireClient(p,"money","+$"..tostring(comma_value(amt)).."!")
		
		delay(3,function()
			db[p.UserId] = nil
		end)
		
		game.ReplicatedStorage.MoneyLog:Fire(p.Name.. " withdrew $"..comma_value(amount),"N/A")
	end
end)