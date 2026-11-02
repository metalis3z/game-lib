local Utility = require(game.ReplicatedStorage:WaitForChild("Utilities"):WaitForChild("Utility"))

local player = game.Players.LocalPlayer
local LoadedFurniture = {}
local LoadedWallsAndFloors = {}
local PreLoads = {}
local currentRoom = nil
local currentHouse = nil
local touchEvents = {}
local localScripts = {}
local localSoundCopy = {}

while player.Character == nil do wait(.1) end

--when furniture is touched by a player, trigger the furniture's touch event server code that is inside ServerScriptService
local function RegisterTouchEvents(model)
	if model:FindFirstChild("TouchEvent") then
		for _,obj in ipairs(model:GetChildren()) do
			if obj:FindFirstChild("TouchIntrest") then
				local event = obj.Touched:connect(Utility:Debounce(function(hit)
					if hit and hit.Parent and hit.Parent:FindFirstChild("Humanoid") and hit.Parent:FindFirstChild("HumanoidRootPart") and hit.Parent.HumanoidRootPart and hit.Parent.HumanoidRootPart == player.Character.HumanoidRootPart then
						model.TouchEvent:FireServer(hit,obj)
						wait(.1)
					end
				end))
				if not obj:FindFirstChild("Preload") then  --touch events stays forever if on porch
					table.insert(touchEvents,event)
				end
			end
		end
	end
end



--put all the furniture localscrips inside the player
local function GiveLocalScripts(model)
	for _,obj in ipairs(model:GetChildren()) do
		if obj:IsA("LocalScript") then
			
			--some local scripts only need one script running at a time
			if obj:FindFirstChild("DontAllowMoreThanOne") and player.PlayerScripts:FindFirstChild(obj.Name) then return end
			
			local objValue = Instance.new("ObjectValue")
			objValue.Value = model
			objValue.Name = "ObjectPointer"
			
			local housePointer = Instance.new("ObjectValue")
			housePointer.Value = model.Parent.Parent
			housePointer.Name = "HousePointer"
			
			local localScript = obj:clone()
			objValue.Parent = localScript
			housePointer.Parent = localScript
			localScript.Disabled = false
			localScript.Parent = player.PlayerScripts
			
			if not obj:FindFirstChild("Preload") then  --script stays forever if on porch
				table.insert(localScripts,localScript)
			end
		end
	end
end

local function AddWallpaperToFurniture(object,wallpaperData)
	if object:FindFirstChild("Wall") and wallpaperData then
		for _,obj in ipairs(object.Wall:GetChildren()) do
			if obj.Name == "Wallpaper" then
				obj.Texture = wallpaperData.Texture
				obj.Transparency = wallpaperData.Transparency
				obj.StudsPerTileU = wallpaperData.StudsPerTileU 
				obj.StudsPerTileV = wallpaperData.StudsPerTileV
			end
		end
	end
end

--song id is inside the sound object
local function EnabledSounds(model)
	for _,obj in ipairs(model:GetChildren()) do
		for _,child in ipairs(obj:GetChildren()) do
			if child:IsA("Sound") and child:FindFirstChild("SoundFXId") then
				local newSound = child:clone()
				newSound.Parent = child.Parent
				newSound.SoundId = child.SoundFXId.Value
				localSoundCopy[child] = newSound
			end
		end
	end
end


--play furniture sounds locally
workspace.Main.FurnitureSound.OnClientEvent:connect(function(soundObject,model,action,property)
	
	local localSound = localSoundCopy[soundObject] --get local version of soundObject

	local part = model:FindFirstChildOfClass("Part") or model:FindFirstChildOfClass("UnionOperation") or model:FindFirstChildOfClass("WedgePart") or model:FindFirstChildOfClass("MeshPart") or model:FindFirstChildOfClass("CornerWedgePart")
		
	if model.Parent.Name == "Furniture" and  player.Character and player.Character:FindFirstChild("HumanoidRootPart") and ((player.Character.HumanoidRootPart.Position*Vector3.new(1,0,1)) - (part.Position*Vector3.new(1,0,1))).magnitude < 50 then
					
		if property then --set properties of the sound
			for propery,value in pairs(property) do
				localSound[propery] = value
			end
		end
							
		if action == "Play" then
			localSound:Play()
					
		elseif action == "Stop" then
			localSound:Stop()
					
		elseif action == "Pause" then
			localSound:Pause()
		end
				
	end
	
end)



local function ChangeWallFloor(house,zoneName,wallpaperData,floorData)
	
	for _,part in ipairs(house.CurrentUpgrade.Value:GetChildren()) do

		if part:IsA("BasePart") and part:FindFirstChild(zoneName) then

			part[zoneName].Texture = (part.Name == "Wall" and wallpaperData.Texture) or floorData.Texture
			part[zoneName].Transparency = (part.Name == "Wall" and wallpaperData.Transparency) or floorData.Transparency
			part[zoneName].StudsPerTileU = (part.Name == "Wall" and wallpaperData.StudsPerTileU) or floorData.StudsPerTileU
			part[zoneName].StudsPerTileV = (part.Name == "Wall" and wallpaperData.StudsPerTileV) or floorData.StudsPerTileV
					
					
			if part.Name == "Floor" then
				part.Material = floorData.Material
				part.BrickColor =floorData.BrickColor
				part.Reflectance = floorData.Reflectance
			end
						

			table.insert(LoadedWallsAndFloors,part[zoneName])
		end
	end
end


------STREAMING PLAYER CHARACTER MODELS-------------

local currentRoomObject = player:WaitForChild("Room")
local storedCharacterModels = {}


local function RefreshLocalCharacters()
	if _G.IsPartyServer then
		for _,_player in ipairs(game.Players:GetPlayers()) do
			local inSameRoom = (_player:FindFirstChild("Room") and _player.Room.Value == currentRoomObject.Value) --if player dseont have a room value for some reason, show the player at all times
			if _player and _player.Parent and _player.Character then
				if _player.Character.Parent == game.ReplicatedStorage and inSameRoom then
					--update character model positions first
					local cframes = Utility:SendData("GetPlayerCFramesInRoom","PlayerChannel",2,currentRoomObject.Value)  --dosent matter if it fails, the character model cframes will update automatically eventually
					if cframes then
						for playerName,cframe in pairs(cframes) do
							local roomPlayer = game.Players:FindFirstChild(playerName)
							if roomPlayer and roomPlayer.Character and roomPlayer.Character:FindFirstChild("HumanoidRootPart") then
								roomPlayer.Character.HumanoidRootPart.CFrame = cframe
							end
						end
					end
		
					_player.Character.Parent = workspace
						
						
				elseif _player.Character.Parent == workspace and not inSameRoom then
					_player.Character.Parent = game.ReplicatedStorage
				end
			end
		end
		
		for _,pet in ipairs(workspace.Pets:GetChildren()) do
			if pet.Parent and pet.Owner.Value and pet.Owner.Value ~= player and pet.Owner.Value:FindFirstChild("Room") then
				local inSameRoom = pet.Owner.Value.Room.Value == player.Room.Value
				if pet.Parent == game.ReplicatedStorage and inSameRoom then
					pet.Parent = workspace
				elseif pet.Parent == workspace and not inSameRoom then
					pet.Parent = game.ReplicatedStorage
				end
			end
		end
	end
end

if _G.IsPartyServer then
	spawn(function()
		while true do 
			wait(15)
			RefreshLocalCharacters()
		end
	end)
end


local function AddPlayer(newPlayer)
	newPlayer:WaitForChild("Room").Changed:connect(function()
		RefreshLocalCharacters()
	end)
end

game.Players.PlayerAdded:connect(function(newPlayer)
	 AddPlayer(newPlayer)
end)

for _,_player in ipairs(game.Players:GetPlayers()) do
	AddPlayer(_player)
end


--------------------------------------



--when player enters or leaves a zone 
workspace.Main.LocationChanged.OnClientEvent:connect(function(zone,house,furniture,floorData,wallpaperData,houseColors)
	--floor data = {TextureId = 12345, TextureTransparency = .5, Material = Sand, BrickColor =  21, Reflectance = 1}
	--wallpaper data = {TextureId = 12345, TextureTransparency = .5}
	spawn(function()
		RefreshLocalCharacters()
	end)
	
	if house then
		if _G.TutorialEnabled then
			workspace.TutorialService.PlayerAction:FireServer("EnteredHouse",true)
		end
		
		if furniture then
			--go through furniture in room and make them visible
			if not LoadedFurniture[zone] then 
				LoadedFurniture[zone] = {}
			end
			for _,furn in ipairs(furniture) do
				table.insert(LoadedFurniture[zone],furn)
				furn.Parent = house.Furniture
				furn.BorderPointer.Value.Parent = game.ReplicatedStorage.BorderStorage
				RegisterTouchEvents(furn)
				GiveLocalScripts(furn)
				EnabledSounds(furn)
				AddWallpaperToFurniture(furn,wallpaperData)
			end
		end
		--chage wall or floor is arguments are not nil
		local zoneName = zone.Name
		if floorData and wallpaperData then
			ChangeWallFloor(house,zoneName,wallpaperData,floorData)
		end
		currentRoom = zone
		currentHouse = house
	else
		currentRoom = nil
		currentHouse = nil
	end
	
	
end)


workspace.Main.PlayerEnteredHouse.OnClientEvent:connect(function(enteringUserId,playerIconImageLabel)
	if player.userId ~= enteringUserId and player:IsFriendsWith(enteringUserId) and playerIconImageLabel and playerIconImageLabel.Parent then
		playerIconImageLabel.WhiteBackground.Visible = true
	end
end)



--load and show new furniture being added to the house you're in - and so it can unload when player leaves
workspace.Main.FurnitureAdded.OnClientEvent:connect(function(house,zone,furnitureObject,floorData,wallpaperData)
	--show new friends door and walls to all players
	--if furnitureObject:FindFirstChild("Preload") then 
	--	table.insert(LoadedFurniture[zone],furnitureObject)
		--AddWallpaperToFurniture(furnitureObject,wallpaperData)
		--furnitureObject.Parent = house.Furniture 
	--end
	--if newlly placed furniture is in the same room as player, then show it
	
	
	
	if zone == currentRoom or zone.Name == "Balcony" or zone.Name == "Porch" then
		if not LoadedFurniture[zone] then LoadedFurniture[zone] = {} end
		table.insert(LoadedFurniture[zone],furnitureObject)
		furnitureObject.BorderPointer.Value.Parent = game.ReplicatedStorage.BorderStorage
		furnitureObject.Parent = house.Furniture
		RegisterTouchEvents(furnitureObject)
		GiveLocalScripts(furnitureObject)
		EnabledSounds(furnitureObject)
		AddWallpaperToFurniture(furnitureObject,wallpaperData)
	end
end)

--when player puts down a new wallpaper or floor
workspace.Main.WallOrFloorChanged.OnClientEvent:connect(function(house,zone,floorData,wallpaperData)
	if zone == currentRoom then
		
		ChangeWallFloor(house,zone.Name,wallpaperData,floorData)
		
		--update custom wall wallpaper
		if wallpaperData then
			for _,furn in ipairs(LoadedFurniture[zone]) do
				AddWallpaperToFurniture(furn,wallpaperData)
			end
		end
			
	end
end)





workspace.Main.ClearRooms.OnClientEvent:connect(function()
	
	--clear out all the furnture
	for zoneName,furnitureList in pairs(LoadedFurniture) do
		for _,furniture in ipairs(furnitureList) do
			if furniture.Parent and furniture.Parent ~= game.ReplicatedStorage.StreamingFurnitureStorage then
				if furniture:FindFirstChild("Preload") == nil then
					furniture.BorderPointer.Value.Parent = furniture
					furniture.PrimaryPart = furniture.BorderPointer.Value
					furniture.Parent = game.ReplicatedStorage.StreamingFurnitureStorage
				else
					--removes wallpaper
					AddWallpaperToFurniture(furniture,{Texture = ""})
		
				end
			end
		end
	end
	LoadedFurniture = {}


	--reset wallpaper and floors
	for _,wallFloor in ipairs(LoadedWallsAndFloors) do
		wallFloor.Texture = ""
		if wallFloor and wallFloor.Parent and wallFloor.Parent.Name == "Floor" then
			--turn into wood floors
			wallFloor.Texture = "http://www.roblox.com/asset/?id=127726526"
			wallFloor.Parent.Material = Enum.Material.Wood
			wallFloor.Parent.BrickColor = BrickColor.new("Dark orange")
			wallFloor.Parent.Reflectance = 0
		elseif wallFloor then
			wallFloor.Texture = ""
		end
	end
	LoadedWallsAndFloors = {}
	
	
	--remove touch events
	for _,event in ipairs(touchEvents) do
		event:disconnect()
	end
	touchEvents = {}
	
	for _,localscript in ipairs(localScripts) do
		localscript:Destroy()
	end
	localScripts = {}
	
	--destroy local sound clone
	local preloadedSounds = {}
	for globalsound,localsound in pairs(localSoundCopy) do
		if not localsound.Parent.Parent:FindFirstChild("Preloaded") then --dont destroy local sounds if on porch
			localsound:Stop()
			localsound:Destroy()
		else
			preloadedSounds[globalsound] = localsound 
		end
	end
	localSoundCopy = preloadedSounds
	
	
end)



local IsPointInsideBox = Utility.IsPointInsideBox
local character = player.Character
local insideZone = false
local checkTime = 2 --num seconds to loop to check if location has changed
local connection
local rooms = {}


local function RefreshLocation()
	if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
		local torso = player.Character.HumanoidRootPart
		insideZone = false
		for house,roomList in pairs(rooms) do
			for _,room in ipairs(roomList) do
				if IsPointInsideBox(room,torso.Position + (torso.CFrame.lookVector/2.01)) then --see if the the point just beneath the surface of the player's chest is inside a room
					insideZone = true
					if room ~= currentRoom then
						currentRoom = room
						currentHouse = house
						Utility:SendData("LocationChanged","PlayerChannel",nil,room)
						return true
					end
				end
			end
		end
					
		--is outside
		if not insideZone and currentRoom ~= nil then
			currentRoom = nil
			Utility:SendData("LocationChanged","PlayerChannel",nil,currentRoom)
			return true
		end
	end
end


workspace.Main.RefreshLocation.OnClientEvent:connect(RefreshLocation)



local function UpdateConnections(character)	
	if connection then connection:disconnect() end
	local torso = character:WaitForChild("HumanoidRootPart",5)
	local humanoid = character:WaitForChild("Humanoid",5)
	if not torso or not humanoid then return end
	connection = torso.Touched:connect(Utility:Debounce(function(hit)
		if hit and hit.Name == "DoorTouch" then
			--loop until player changes rooms
			for i=1,checkTime * 10 do
				while humanoid and humanoid.MoveDirection == Vector3.new(0,0,0) do wait() end --only check while player is moving
				if RefreshLocation() then
					--just in case
					delay(2,function()
						RefreshLocation()
					end)
					break
				end
				wait(.1)
			end
			
		end
	end))
end



player.CharacterAdded:connect(function(character)
	UpdateConnections(character)
end)

if player.Character then
	UpdateConnections(player.Character)
end





--------Let the server know when changed zone has changed




local function CollectRooms(house)
	wait()
	local upgradeModel = house.CurrentUpgrade.Value
	if upgradeModel then
		rooms[house] = {}
		for _,roomPointer in ipairs(upgradeModel:WaitForChild("Rooms",1):GetChildren()) do
			table.insert(rooms[house],roomPointer.Value)
		end
	end
	RefreshLocation()
end

for _,house in ipairs(workspace.Houses:GetChildren()) do
	CollectRooms(house)
	house.CurrentUpgrade.Changed:connect(function() CollectRooms(house) end)
end




