local ServerScriptService = script.Parent
local Global = require(ServerScriptService:WaitForChild("Global"))
local Players = Global.Players
local Houses = Global.Houses
local Vehicles = Global.Vehicles
local Manager = Global.Manager
local AssetLibraryManager = Global.AssetLibraryManager
local Player = require(script:WaitForChild("Player"))
local Utility = require(game.ReplicatedStorage:WaitForChild("Utilities"):WaitForChild("Utility"))
local Dialog = require(game.ReplicatedStorage:WaitForChild("Dialog"))
local Enums = require(game.ReplicatedStorage:WaitForChild("Enums"))
local Debug = require(game.ReplicatedStorage:WaitForChild("Debug"))


local DataStore = Enums.DataStore
local OldDataStore = (game.PlaceId ~= 0 and game:GetService("DataStoreService"):GetGlobalDataStore())--change when making major updates so it can be rolled back

Players.PlayerData = {}




function onPlayerAdded(player)
	print("Player Added")
	
	

	
	local key = tostring(player.userId)
	local get
	local userId = (Debug.Enabled and Debug.LoadPlayerDataById) or player.userId
	
	--GET saved data - if fail, keep trying
	local success,err
	local NUM_TRIES = 3
	
	if DataStore then
		for i=1,NUM_TRIES do
			success, err = pcall(function()
				get = DataStore:GetAsync(userId)
			end)
			if success then
				break
			else
				wait(1)
			end
		end
		
	end
	
		
	if not success and err then
		spawn(function()
			error(err)
		end)
	end
	
	--use old datastore as a backup just in case the new update fails - save to new one
	-- if player is player the new version of the game but is using the old database
	if success and get == nil then
		success, err = pcall(function()
			get = OldDataStore:GetAsync(userId)
			
		end)
	end
		
	if Debug.Enabled and Debug.SavedData then
		get = Debug.SavedData
	end
	

	if Debug.Enabled and not Debug.LoadSavedData then
		success = false
	
	end 
	

	
	if success then
		
		
		 --is playing for first time
		if (get == nil or get == -1) or player.userId < 0 then
			Players[player] =  Player.new(player,nil)
			if Players[player] == nil then return end
			Players[player]:ListenForEvents()
			print("FIRST TIME PLAYER!")
			Players[player]:Initialize()
			Players[player]:SaveData()
			

		else    --is not playing for the first time
			
			print("saved data loaded")
			Players[player] =  Player.new(player,get)
			if Players[player] == nil then return end
			Players[player]:ListenForEvents()
			Players[player]:Initialize()
			
			--Utility:PrintTable(Players[player])
			
		end

	else						--is playing in solo mode or errored
		
		if game.PlaceVersion ~= 0 then
			print("DATA STORE ERROR")
			workspace.Main.DataStoreError:FireClient(player,"There was an error loading your data. Roblox's saving system may be down. Come back another time.")
			error(player.Name .. err)
			return
		else
			print("solo mode")
			if not Enums.IsOnline then
				Players[player] = Player.new(player,{})
				if Players[player] == nil then return end
				Players[player].DisableSaving = true
				Players[player]:ListenForEvents()
				Players[player]:Initialize()
			else
				error("THIS SHOULD NOT HAPPEN")
			end
		end
		
	end
end




function onPlayerRemoving(player)
	local playerData = Players[player]
	if not Enums.IsStudio and playerData then
		if playerData.DraggingFurniture then playerData.DraggingFurniture:Destroy() end

		if not Enums.IsPartyServer and Vehicles then Vehicles:PlayerLeaving(player) end
		local house = playerData.House
		playerData:SaveData(true) --save before reseting house
		house:KickAllPlayersFromHouse()
		if playerData.LocationHouse then playerData.LocationHouse:PlayerLeftHouse(player) end --for party lists
		house:LoadHouse() --reset house
		if playerData.Gear then playerData.Gear:Destroy() end --remove gear that is in workspace
		Players[player]:Delete() --clean up connections
		Players[player] = nil
	end
end


function Players:Initialize()
	for _,p in ipairs(game.Players:GetPlayers()) do onPlayerAdded(p) end
	game.Players.PlayerAdded:connect(onPlayerAdded)
	game.Players.PlayerRemoving:connect(onPlayerRemoving)
end


game.OnClose = function()
	if not Enums.IsStudio then
		for _,playerData in ipairs(Players.PlayerData) do
			playerData:SaveData(true)
		end
	end
end

local function CreateMouthParticles(player,particleName)
	if player.Character and player.Character:FindFirstChild("Head") then
		local head = player.Character.Head
		
		if player.Character:FindFirstChild(particleName) then player.Character[particleName]:Destroy() end
		
		local block = Instance.new("Part")
		block.Name = particleName
		block.CanCollide = false
		block.Transparency = 1
		block.Size = Vector3.new(.2,.2,.2)
		block.Parent = player.Character
		block.CFrame = head.CFrame *CFrame.new(0,-(head.Size.Y/4),-(head.Size.Z/2))
			
		Utility:Weld(block,head)
				
		local particle = game.ServerStorage[particleName]:clone()
		particle.Parent = block
	end

end

workspace.Animation.AnimationStarted.OnServerEvent:connect(function(player,animationName)
	if animationName == "SleepSeat" then animationName = "Sleep" end
	if (animationName == "Whistle" or animationName == "Sleep") and player.Character:FindFirstChild("Head") then
		
		 CreateMouthParticles(player,animationName)
		
	end
end)

	
workspace.Animation.AnimationStopped.OnServerEvent:connect(function(player,animationName)
	
	if animationName == "SleepSeat" then animationName = "Sleep" end
	if player.Character and player.Character:FindFirstChild(animationName) then player.Character[animationName]:Destroy() end
	
end)
	



local channel = game.ReplicatedStorage.Channels:WaitForChild("PlayerChannel")

function Recieve(player,action,...)
	print("received",action,player,...)
	local args = {...}
	
	
	while player and player.Parent and not Players[player] do wait() end
	if not Players[player] then 
		return
	end

	
	
	local playerData = Players[player]
	
	if action == "SaveCanvasProject" and args[1] and args[2] then
		playerData.CanvasProjects[args[1]] = args[2]
		
	elseif action == "LoadCanvasProject" and args[1]  then
		return playerData.CanvasProjects[args[1]]
		
	elseif action == "DeleteCanvasProject" and args[1] then
		playerData.CanvasProjects[args[1]] = nil		
		
	elseif action == "GetProjectsList" then
		local list = {}
		for name,_ in pairs(playerData.CanvasProjects) do
			table.insert(list,name)
		end
		return list
	
	elseif action == "SetSuit" then
		playerData:SetUniform(tostring(args[2]))
	
	
	elseif action == "SetWaterEnabled" and type(args[1]) == "boolean" then
		playerData:SetWaterEnabled(args[1])
		
		
	elseif action == "ChangeJob" then
		local newJobName = tostring(args[1])
		if newJobName == "Manager" then return end --prevent exploiters from becoming manager
		
		--fire manager if going inside a house
		if newJobName == "On Break" and Manager.CurrentManager == player then return end
			
			--[[playerData:Teleport(playerData.House.UpgradeModel.Walkway.Position)
			if Dialog:GetChoice(player,"You are about to go on break. Do you want to go on break?","Yes","No") then
				if Manager.CurrentManager == player then
					Manager:FireManager()
				end
			end]]
		playerData:SetJob(newJobName)
	
	
	elseif action == "SellInventoryItem" then
		playerData:SellInventoryItem(args[1])
	
	
	elseif action == "GetJobsCompleted" then
		return Players[player].Jobs_Completed
	
	
	elseif action == "RefreshJobsCompleted" then
		game.Workspace.Main.RefreshJobsCompleted:FireClient(player,playerData.Jobs_Completed)
	
	
	elseif action == "LocationChanged" then
		playerData:LocationChanged(args[1])
		
		
	elseif action == "SaveBackpackItem" then
		playerData:SaveBackpackItem(tonumber(args[1]))
	
	
	elseif action == "TeleportToJob" then
		playerData:TeleportToJob(args[1],args[2])
		
	elseif action == "TeleportHome" then
		playerData:Teleport(playerData.House.GivePizza.Position)
	
	
	elseif action == "UnsaveBackpackItem" then
		playerData:UnsaveBackpackItem(tonumber(args[1]))
	
	
	elseif action == "UnsaveClothing" then
		playerData:UnsaveClothing(args[1],args[2])
		
		
	elseif action == "SaveClothing" then
		playerData:SaveClothing(args[1],args[2])
		
		
	elseif action == "GetSettings" then
		return playerData.Settings
		
	elseif action == "GetSprayId" then
		return playerData.SprayId or 80373024
		
	elseif action == "SetSprayId"  then
		print("set",args[1])
		playerData.SprayId = tonumber(args[1])
		
	elseif action == "GetHistory" then
		return playerData.AssetHistory
	
	elseif action == "AddAssetToHistory" then
		return playerData:AddAssetToHistory(tostring(args[1]),tonumber(args[2]),tostring(args[3]))
		
	elseif action == "RemoveAssetFromHistory" then
		return playerData:RemoveAssetFromHistory(tostring(args[1]),tonumber(args[2]),tostring(args[3]))
		
	elseif action == "SettingChanged" then
		playerData:SetSetting(args[1],args[2])
		
		
	elseif action == "GetUpgrade" then
		return  playerData.House.Upgrade, playerData.UpgradePayments
		
	elseif action == "GetGamePasses" then
		return playerData.GamePasses
		
		
	elseif action == "IncrementPayments" then
		playerData:IncrementPayments(tonumber(args[1]))
		
	elseif action == "GetVideoCollection" then
		local collectionOwner = args[1]
		local ownerData = Players[collectionOwner]
		if ownerData and ownerData.SavedVideos then
			return ownerData.SavedVideos
		end
		
	elseif action == "PlayVideo" then
		local videoId = args[1]
		playerData:PlayVideo(args[1],args[2],args[3])
		
	elseif action == "DeleteVideo" then
		local videoId = args[1]
		for i,data in ipairs(playerData.SavedVideos) do
			if data[1] == videoId then
				table.remove(playerData.SavedVideos,i)
				break
			end
		end
		return true
		
	elseif action == "TakeVideo" then
		playerData:AddVideoToCollection(args[1],args[2],args[3])
		
	elseif action == "ImportVideo" then
		local serializedVideo = args[1]
		return playerData:ImportVideo(serializedVideo)
		
	elseif action == "GetPlayerCFramesInRoom" then
		local roomName = args[1]
		local cframes = {}
		for _,_player in pairs(game.Players:GetChildren()) do
			if _player ~= player and _player.Parent and _player:FindFirstChild("Room") and _player.Room.Value == roomName and _player.Character and _player.Character.Parent and _player.Character:FindFirstChild("HumanoidRootPart") then
				cframes[_player.Name] = _player.Character.HumanoidRootPart.CFrame
			end
		end
		return cframes
	
		
		
	elseif action == "GetInventory" then
	
		local newInventory = {}
		local library = AssetLibraryManager:GetAssetLibrary()
		
		--add more information to inventoy data from assetlibray before sending to client
		for _,item in ipairs(playerData.Inventory) do
			local asset = library[tostring(item.AssetId)]
			if asset then
				table.insert(newInventory,Players:AddAssetData(asset,item.AssetId,item))
			elseif item.Category and item.Category == "Pants" or item.Category == "Shirts" then
				table.insert(newInventory,item)
			end
				
		end
		
		
		return newInventory

	end
end


function Players:AddAssetData(asset,assetId,item)
	return {Quantity = item.Quantity, AssetId = assetId, Category = asset.Category, Name = asset.Name, Unsellable = asset.Unsellable}
end



channel.OnServerEvent:connect(function(player,action,...)
	local response1,response2,response3 = Recieve(player,action,...)
	if response1 then
		channel:FireClient(player,action,response1,response2,response3)
	end
end)

--save every 5 mintues
spawn(function()
	if not Enums.IsStudio then
		while wait(300) do
			local counter = 0
			for player,playerData in pairs(Players.PlayerData) do
				playerData:SaveData(true)
				counter = counter + 1
				if counter > 20 and not Enums.IsPartyServer then
					spawn(function()
						error("Player data leak")
					end)
				end
			end
		end
	end
end)


setmetatable(Players, {
	__index = Players.PlayerData,
	__newindex = Players.PlayerData
})



return Players






