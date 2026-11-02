local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RSEngine = ReplicatedStorage:WaitForChild("Engine")
local Modules = RSEngine:WaitForChild("Modules")
local abbreviateModule = require(Modules:WaitForChild("AbbreviateModule"))
local transitionModule = require(Modules:WaitForChild("Transition"))
local notificationModule = require(Modules:WaitForChild("NotificationModule"))
local DataModules = ReplicatedStorage:WaitForChild("DataModules")
local worlds = require(DataModules:WaitForChild("Worlds"))


local ServerScriptService = game:GetService("ServerScriptService")
local Engine = ServerScriptService:WaitForChild("Engine")
local Scripts = Engine:WaitForChild("Scripts")
local Data = Scripts:WaitForChild("Data")
local dataManager = require(Data:WaitForChild("DataManager"))

local costDisplay = script.CostDisplay

local playersTeleporting = {}

for worldName, worldInfo in pairs(worlds) do
	local tp1 = worldInfo.tp1
	local tp2 = worldInfo.tp2
	
	--Enter
	
	for _, tp: Part in pairs(tp1) do
		local newCostDisplay = costDisplay:Clone()
		newCostDisplay.Parent = tp
		newCostDisplay.Cost.Text = abbreviateModule:AbbreviateNumbers(worldInfo.cost).. " Rolls"
		
		tp.Touched:Connect(function(hit)
			local player = Players:GetPlayerFromCharacter(hit.Parent)
			
			if player and not table.find(playersTeleporting, player) then
				repeat wait() until dataManager.profiles[player]
				if dataManager.profiles[player].Data["Rolls"] >= worldInfo.cost then
					dataManager.profiles[player].Data["World"] = worldName
					table.insert(playersTeleporting, player)
					transitionModule.Start(player, tp2[math.random(1, #tp2)].exit.Position, "Entering the " .. worldName .. " world...", "x" .. worldInfo.bonus .. " luck")
					wait(1.5)
					table.remove(playersTeleporting, table.find(playersTeleporting, player))
				else
					table.insert(playersTeleporting, player)
					notificationModule.Notify(player, "Not enough rolls")
					wait(1.5)
					table.remove(playersTeleporting, table.find(playersTeleporting, player))
				end
			end
		end)
	end
	
	--exit
	
	for _, tp: Part in pairs(tp2) do
		tp.Touched:Connect(function(hit)
			local player = Players:GetPlayerFromCharacter(hit.Parent)

			if player and not table.find(playersTeleporting, player) then
				repeat wait() until dataManager.profiles[player]
				dataManager.profiles[player].Data["World"] = "Basic"
				
				table.insert(playersTeleporting, player)
				transitionModule.Start(player, tp1[math.random(1, #tp1)].exit.Position, "Exiting the " .. worldName .. " world...", "")
				wait(2)
				table.remove(playersTeleporting, table.find(playersTeleporting, player))
			end
		end)
	end
end

game.Players.PlayerAdded:Connect(function(player)
	repeat wait() until dataManager.profiles[player]
	local character = player.Character or player.CharacterAdded:Wait()
	local worldName = dataManager.profiles[player].Data["World"]
	local worldInfo
	
	for aWorldName, aWorldInfo in pairs(worlds) do
		if aWorldName == worldName then
			worldInfo = aWorldInfo
		end
	end

	if worldInfo then
		character:MoveTo(worldInfo.tp2[1].exit.Position)
	end
	
	while wait(1) do
		local worldBoost = 1
		for worldName, worldInfo in pairs(worlds) do
			repeat wait() until dataManager.profiles[player]
			if worldName == dataManager.profiles[player].Data["World"] then
				worldBoost = worldInfo.bonus	
			end
		end
		
		local playerGui = player.PlayerGui
		local gui = playerGui:WaitForChild("GUI")
		local bottomLeft = gui:WaitForChild("BottomLeft")
		local worldBoostFrame = bottomLeft:WaitForChild("WorldBoost")
		local worldBonusText = worldBoostFrame:WaitForChild("Text1")
		
		worldBonusText.Text = "x" .. worldBoost
	end
end)