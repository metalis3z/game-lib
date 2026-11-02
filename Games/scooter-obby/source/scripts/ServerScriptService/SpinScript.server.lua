local RepStorage = game:GetService("ReplicatedStorage")
local MPS = game:GetService("MarketplaceService")
local Remotes = RepStorage.RemoteEvents
local Remote = Remotes.SpinWheel
local ServerScriptService = game:GetService("ServerScriptService")
local DataStore2 = require(RepStorage.ModuleScripts.DataStore2)
local ugcHandler = require(ServerScriptService.UGCHandler)
local skipHandler = require(ServerScriptService.SkipHandler)
local invHandler = require(ServerScriptService.InventoryHandler)

DataStore2.Combine("DATA", "MinutesLeft")

local Rewards = {
	["1"] = 31,
	["2"] = 1,
	["3"] = 17,
	["4"] = 29,
	["5"] = 22,
}

-- Code

local function getRandomReward()
	local totalWeight = 0
	for _, weight in pairs(Rewards) do
		totalWeight = totalWeight + weight
	end

	local randomNumber = math.random() * totalWeight
	local accumulatedWeight = 0

	for reward, weight in pairs(Rewards) do
		accumulatedWeight = accumulatedWeight + weight
		if accumulatedWeight >= randomNumber then
			return reward
		end
	end
end

local function giveSpins(player, amount)
	player:WaitForChild("Data"):WaitForChild("WheelSpins").Value = player:WaitForChild("Data"):WaitForChild("WheelSpins").Value + amount
end

Remote.OnServerEvent:Connect(function(player)
	if player:WaitForChild("Data"):WaitForChild("WheelSpins").Value >= 1 then
		if player then
			local reward = getRandomReward()

			if reward then
				player:WaitForChild("Data"):WaitForChild("WheelSpins").Value -= 1
				Remote:FireClient(player, reward)

				if reward == "1" then
					--[[task.wait(4)
					ugcHandler.GiveUGC(player, 15435887455)]]--
					task.wait(4)
					ServerScriptService.StageUpdater.CoinTake:Fire(player, 500)
				elseif reward == "2" then
					task.wait(4)
					invHandler.AddItemToInventory(player, "ForestScooter")
				elseif reward == "3" then
					--[[task.wait(4)
					ugcHandler.GiveUGC(player, 15393535271)]]--
					task.wait(4)
					skipHandler.AddSkips(player, 1)
				elseif reward == "4" then
					--[[task.wait(4) -- Waits 4 Seconds then gives reward
					ugcHandler.GiveUGC(player, 15222528780)]]--
					task.wait(4)
					ServerScriptService.StageUpdater.CoinTake:Fire(player, 1000)
				elseif reward == "5" then
					--[[task.wait(4)
					ugcHandler.GiveUGC(player, 15435891755)]]--
					giveSpins(player, 1)
				end
			end
		end
	end	
end)



-- Wheel Spins

local function IncrementWheelSpins(player)
	if game:GetService("MarketplaceService"):UserOwnsGamePassAsync(player.UserId, 645182658) then
		player:WaitForChild("Data"):WaitForChild("WheelSpins").Value = player:WaitForChild("Data"):WaitForChild("WheelSpins").Value + 2
	else
		player:WaitForChild("Data"):WaitForChild("WheelSpins").Value = player:WaitForChild("Data"):WaitForChild("WheelSpins").Value + 1
	end
end

script.GiveSkips.Event:Connect(function(player, amount)
	giveSpins(player, amount)
end)

game.Players.PlayerAdded:Connect(function(player)
	task.wait(2)
	coroutine.resume(coroutine.create(function()
		if player:IsInGroup(33345909) then
			local minutesLeftStore = DataStore2("MinutesLeft", player)
			local startingMinute = minutesLeftStore:Get(0)
			player.PlayerGui:WaitForChild("GameGUI").Frame:WaitForChild("WheelSpin").Container.Spin1.NextSpin.Text = '+1 Spin In ' .. (60 - startingMinute) .. "m"
			while true do
				if startingMinute <= -10 then
					minutesLeftStore:Set(0)
					IncrementWheelSpins(player)
					startingMinute = minutesLeftStore:Get(0)
				end
				if startingMinute >= 60 then
					minutesLeftStore:Set(0)
					IncrementWheelSpins(player)
					startingMinute = minutesLeftStore:Get(0)
				end
				task.wait(60)
				if not game.Players:FindFirstChild(player.Name) then
					print("broke off " .. player.Name)
					break
				end
				minutesLeftStore:Increment(1)
				startingMinute = minutesLeftStore:Get(0)
				player.PlayerGui:WaitForChild("GameGUI").Frame:WaitForChild("WheelSpin").Container.Spin1.NextSpin.Text = '+1 Spin In ' .. (60 - startingMinute) .. "m"
				print(startingMinute, player.Name)
			end
		else
			local minutesLeftStore = DataStore2("MinutesLeft", player)
			local startingMinute = minutesLeftStore:Get(0)
			player.PlayerGui:WaitForChild("GameGUI").Frame:WaitForChild("WheelSpin").Container.Spin1.NextSpin.Text = '+1 Spin In ' .. (120 - startingMinute) .. "m"
			while true do
				if startingMinute <= -5 then
					minutesLeftStore:Set(0)
					startingMinute = minutesLeftStore:Get(0)
				end
				if startingMinute >= 120 then
					minutesLeftStore:Set(0)
					startingMinute = minutesLeftStore:Get(0)
				end
				task.wait(60)
				if not game.Players:FindFirstChild(player.Name) then
					print("broke off " .. player.Name)
					break
				end
				minutesLeftStore:Increment(1)
				startingMinute = minutesLeftStore:Get(0)
				player.PlayerGui:WaitForChild("GameGUI").Frame:WaitForChild("WheelSpin").Container.Spin1.NextSpin.Text = '+1 Spin In ' .. (120 - startingMinute) .. "m"
				print(startingMinute, player.Name)
			end
		end
	end))
end)

