local TeleportService = game:GetService("TeleportService")
local l__TweenService__1 = game:GetService("TweenService");
local MarketplaceService = game:GetService("MarketplaceService")

local rd = require(game.ServerScriptService.Game.Services.RoomsServices)
local red = require(game.ReplicatedStorage.ClientModules.Module_Events)

-- Created and Fixed by BUILDG Studios

rd:LoadRooms()

game:GetService("MarketplaceService").PromptProductPurchaseFinished:Connect(function(playerd, assetID, isPurchased)
	local player = game.Players:GetPlayerByUserId(playerd)
	if isPurchased then 
		if assetID == 1666432137 then
			player:FindFirstChild("PlayerStats"):FindFirstChild("Knobs").Value += 250
			player:FindFirstChild("PlayerStats"):FindFirstChild("RobuxSpend").Value += 19
		elseif assetID == 1666454855 then
			player:FindFirstChild("PlayerStats"):FindFirstChild("Knobs").Value += 600
			player:FindFirstChild("PlayerStats"):FindFirstChild("RobuxSpend").Value += 29
		elseif assetID == 1666455129 then
			player:FindFirstChild("PlayerStats"):FindFirstChild("Knobs").Value += 1300
			player:FindFirstChild("PlayerStats"):FindFirstChild("RobuxSpend").Value += 59
		elseif assetID == 1666455484 then
			player:FindFirstChild("PlayerStats"):FindFirstChild("Knobs").Value += 2800
			player:FindFirstChild("PlayerStats"):FindFirstChild("RobuxSpend").Value += 99
		elseif assetID == 1779545686 then
			player:FindFirstChild("PlayerStats"):FindFirstChild("Revives").Value += 3
			player:FindFirstChild("PlayerStats"):FindFirstChild("RobuxSpend").Value += 59
		end
	end
end)

local GameDetails = require(game.ServerScriptService.Game.Directory:FindFirstChild("GameDetails"))
local l__RealGameId__3 = "13180494150"

for _, descendant in ipairs(game.ServerStorage:GetChildren()) do
	if descendant:IsA("Tool") then
		local d = descendant:Clone()
		d.Parent = game.ReplicatedStorage.ClientBricks.ServerStorage
	end
end

local module_menu = require(game.ReplicatedStorage.Items)

for Module, value in pairs(module_menu) do
	local ValueItem = Instance.new("StringValue")
	ValueItem.Value = module_menu[Module].Stock
	ValueItem.Parent = game.Workspace.GameSettings.ItemsStock
	ValueItem.Name = module_menu[Module].Title
end

game.ReplicatedStorage.Bricks.GuideHint.OnServerEvent:Connect(function(pt)
	pt:Destroy()
end)

game.ReplicatedStorage.Bricks.HasteInClient.OnServerEvent:Connect(function(pt)
	game.ReplicatedStorage.EntityInfo.DeathHint:FireClient(pt, {"What got you this time?","You ran out of time, and died to Haste.","Look around for the levers I placed for \n you... they can be anywhere","Maybe try a little harder next time", "You'll be back. See you then."}, "Yellow")
end)

game.Workspace.CurrentRooms.CurrentRoom.Changed:Connect(function()
	
	if game.Workspace.CurrentRooms.CurrentRoom.Value == 7 then
		game.Workspace.CurrentRooms.CurrentRoom.Difficulty.Value = 2
	elseif game.Workspace.CurrentRooms.CurrentRoom.Value == 15 then
		game.Workspace.CurrentRooms.CurrentRoom.Difficulty.Value = 3
	elseif game.Workspace.CurrentRooms.CurrentRoom.Value == 31 then
		game.Workspace.CurrentRooms.CurrentRoom.Difficulty.Value = 4
	elseif game.Workspace.CurrentRooms.CurrentRoom.Value == 74 then
		game.Workspace.CurrentRooms.CurrentRoom.Difficulty.Value = 5
	end
end)

game.Workspace.CurrentRooms.CurrentRoom.Difficulty.Changed:Connect(function()
	if game.Workspace.CurrentRooms.CurrentRoom.Difficulty.Value == 2 then
		local Rooms = game.ServerScriptService.Server.DifficultyRooms["2"]:GetChildren()
		for Room=1, #Rooms do
			wait(0.1)
			Rooms[Room]:SetAttribute("Difficulty", 2)
			Rooms[Room].Parent = game.ServerScriptService.Server.Rooms
		end
		rd:LoadRooms()
		game.Workspace.Game.GameData.EyesChance.Value = 14
		game.Workspace.Game.GameData.BlitzChance.Value = 8
		game.Workspace.Game.GameData.LookmanChance.Value = 14
		game.Workspace.CurrentRooms.CurrentRoom.DarkIncrease.Value = 12
	elseif game.Workspace.CurrentRooms.CurrentRoom.Difficulty.Value == 3 then
		local Rooms = game.ServerScriptService.Server.DifficultyRooms["3"]:GetChildren()
		for Room=1, #Rooms do
			wait(0.1)
			Rooms[Room]:SetAttribute("Difficulty", 3)
			Rooms[Room].Parent = game.ServerScriptService.Server.Rooms
		end
		for i, v in pairs(game.ServerScriptService.Server.Rooms:GetChildren()) do
			if v:IsA("Folder") and v:GetAttribute("Durability", 2) then
				v:Destroy()
			end
		end
		rd:LoadRooms()
		game.Workspace.Game.GameData.EyesChance.Value = 12
		game.Workspace.Game.GameData.BlitzChance.Value = 6
		game.Workspace.Game.GameData.LookmanChance.Value = 12
		game.Workspace.CurrentRooms.CurrentRoom.DarkIncrease.Value = 9
	elseif game.Workspace.CurrentRooms.CurrentRoom.Difficulty.Value == 4 then
		local Rooms = game.ServerScriptService.Server.DifficultyRooms["4"]:GetChildren()
		for Room=1, #Rooms do
			wait(0.1)
			Rooms[Room]:SetAttribute("Difficulty", 4)
			Rooms[Room].Parent = game.ServerScriptService.Server.Rooms
		end
		rd:LoadRooms()
		game.Workspace.Game.GameData.EyesChance.Value = 10
		game.Workspace.Game.GameData.BlitzChance.Value = 4
		game.Workspace.Game.GameData.LookmanChance.Value = 10
		game.Workspace.CurrentRooms.CurrentRoom.DarkIncrease.Value = 7
	elseif game.Workspace.CurrentRooms.CurrentRoom.Difficulty.Value == 5 then
		local Rooms = game.ServerScriptService.Server.DifficultyRooms["5"]:GetChildren()
		for Room=1, #Rooms do
			wait(0.1)
			Rooms[Room]:SetAttribute("Difficulty", 5)
			Rooms[Room].Parent = game.ServerScriptService.Server.Rooms
		end
		for i, v in pairs(game.ServerScriptService.Server.Rooms:GetChildren()) do
			if v:IsA("Folder") and v:GetAttribute("Durability", 3) then
				v:Destroy()
			end
		end
		rd:LoadRooms()
		game.Workspace.Game.GameData.EyesChance.Value = 8
		game.Workspace.CurrentRooms.CurrentRoom.DarkIncrease.Value = 5
	else
		return
	end
end)
--[[spawn(function()
	while true do
		task.wait(0.5)
		local time_left = game.Workspace.Game:GetAttribute("GameTimer")
		if time_left == 0 then
			game.ReplicatedStorage.FloorClientStuff.ClientRemote.HasteRemote:FireAllClients("server-sided")
			break
		end
	end
end)--]]

game.Workspace.GameSettings.Fires.SetLimbs:Fire()

while true do
	task.wait(0.5)
	for i, v in pairs(game.Workspace.GameSettings.Players:GetChildren()) do 
		if not v then
			return
		end

		if v:IsA("BoolValue") then
			if v:FindFirstChild("PlayerReady") then
				if v:FindFirstChild("PlayerReady").Value == true then
					game.Workspace.GameSettings.Server.CanSkipElevator.Value = true
				end
			end
		end
	end
end

script.Parent = game:GetService("ServerScriptService")
