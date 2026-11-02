local Players = game:GetService("Players")
local dataService = game:GetService("DataStoreService")
local timeData = dataService:GetDataStore("lastLogin")
local dayDifference = 1

script.Parent.Touched:Connect(function(part)
	local Player
	if game.Players:FindFirstChild(part.Name) then
		Player = game.Players:FindFirstChild(part.Name)
	else
		return
	end
	local timeKey = (Player.UserId..'-$loginTime')
	local startingDate
	local claimedToday = Instance.new("BoolValue")
	claimedToday.Parent = Player
	claimedToday.Name = "claimedToday"
	local success, err = pcall(function()
		startingDate = timeData:GetAsync(timeKey)
	end)
	if success then
		if startingDate then
			local startingString = string.split(startingDate,' ')
			local todayDate = os.date()
			local splitString = string.split(todayDate,' ')
			if tonumber(splitString[3]) == tonumber(startingString[3] + dayDifference) and splitString[2] == startingString[2] and splitString[1] ~= startingString[1] then
				print('Day after!')
				game.ServerScriptService.StageUpdater.CoinTake:Fire(2000)
				game.ReplicatedStorage.RemoteEvents.cashNotification:FireClient(Player, 2000)
				claimedToday.Value = true
			elseif splitString[1] == startingString[1] then
				print('Same Day - '..os.date("%A"))
			else
				print(tonumber(splitString[3] - startingString[3]), 'days missed!')
			end
		else
			print('No past date!')
			timeData:SetAsync(timeKey,os.date())
			game.ServerScriptService.StageUpdater.CoinTake:Fire(2000)
			game.ReplicatedStorage.RemoteEvents.cashNotification:FireClient(Player, 2000)
			claimedToday.Value = true
		end
	else
		print(err)
	end
end)

Players.PlayerRemoving:Connect(function(Player)
	if Player:WaitForChild("claimedToday").Value == true then
		local timeKey = (Player.UserId..'-$loginTime')
		local success, err = pcall(function()
			timeData:SetAsync(timeKey,os.date())
		end)
		if success then
			print(Player.Name..' left and data saved successfully!')
		else
			error(err)
		end
	end
end)