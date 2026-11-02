local teleportService = game:GetService("TeleportService")
local placeid = 15593042384
local replicatedStorage = game:GetService("ReplicatedStorage")
local dataStore2  = require(replicatedStorage.ModuleScripts.DataStore2)
dataStore2.Combine("DATA", tostring(placeid))

local lastErrorTimes = {}

game.Players.PlayerAdded:Connect(function(player)
	local ownStore = dataStore2(tostring(placeid), player)
	local owned = ownStore:Get(false)
	if owned then
		player:SetAttribute("Owned"..tostring(placeid), true)
	else
		player:SetAttribute("Owned"..tostring(placeid), false)
	end
end)

script.Parent.Touched:Connect(function(otherPart)
	if game.Players:FindFirstChild(otherPart.Name) then
		local player = game.Players:FindFirstChild(otherPart.Name)
		local ownStore = dataStore2(tostring(placeid), player)
		local owned = ownStore:Get(false)
		if owned then
			teleportService:Teleport(placeid, player)
		else
			player:WaitForChild("leaderstats")
			if player.leaderstats.Wins.Value >= 5 then
				game.ServerScriptService["Coins + Inv Save"].DeductWins:Fire(player, -5)
				ownStore:Set(true)
				player:SetAttribute("Owned"..tostring(placeid), true)
				script.Bought:Play()
			else
				if not lastErrorTimes[player.Name] then
					lastErrorTimes[player.Name] = os.time()
					player.PlayerGui.GameGUI.Frame.CashNotificationHandler.serverErrorWrite:FireClient(player, "You don't have enough wins to enter this world!")
				else
					if os.time() - lastErrorTimes[player.Name] >= 5 then
						player.PlayerGui.GameGUI.Frame.CashNotificationHandler.serverErrorWrite:FireClient(player, "You don't have enough wins to enter this world!")
						lastErrorTimes[player.Name] = os.time()
					end
				end
			end
		end
	end
end)