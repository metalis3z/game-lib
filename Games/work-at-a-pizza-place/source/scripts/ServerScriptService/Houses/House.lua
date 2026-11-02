local ServerScriptService = script.Parent.Parent
local Global = require(ServerScriptService:WaitForChild("Global"))
local House = {}
local Room = require(script.Room)
local Furniture = require(script.Furniture)
local Players = Global.Players
local Environment = Global.Environment
local Door = Global.Door
local Vehicles = Global.Vehicles
local AssetLibraryManager = Global.AssetLibraryManager
local Utility = require(game.ReplicatedStorage:WaitForChild("Utilities"):WaitForChild("Utility"))
local Enums = require(game.ReplicatedStorage:WaitForChild("Enums"))
local Dialog = require(game.ReplicatedStorage:WaitForChild("Dialog"))
local Debug = require(game.ReplicatedStorage:WaitForChild("Debug"))


print("House Dependencies Loaded")
House.__index = House

--room = {Furniture = {}, WallObjects = {}, FloorObjects = {}, FloorPatternId = 1234, WallpatternId = 1234}



function House.new(container,cframe,inverted,address,index)
	
	local function CreateHouse(this,cframe)
		local house = workspace.House:clone()
		house.Parent = workspace.Houses
		
		
		for _,upgrade in ipairs(house.Upgrades:GetChildren()) do
			upgrade:SetPrimaryPartCFrame(house.PrimaryPart.CFrame)
			this.AllUpgrades[upgrade.Name] = upgrade
		end
		
		house:SetPrimaryPartCFrame(cframe)
		return house
	end
	
	
	local function GetRoomData(self)
		local collection = {}
		for _,upgrade in ipairs(self.Upgrades:GetChildren()) do
			local rooms = {}
			for _,room in ipairs(upgrade.Rooms:GetChildren()) do

				rooms[room] = Room.new(room,upgrade)
		
			end
			upgrade.Parent = game.ServerStorage.HouseStorage --put all the upgrades in storage
			collection[upgrade] = rooms
		end
		return collection
	end
	
	
	
	
	local this = {}
	setmetatable(this,House)

	this.Colors = nil
	this.Wallpapers = nil
	this.Floors = nil
	this.Upgrade = nil

	this.SavedData = {"Colors","Wallpapers","Floors","Upgrade"}
	
	this.Owner = nil
	this.CFrame = cframe
	this.Furniture = {}
	this.Container = container
	this.Address = address
	this.GarageEnabled = false
	this.AllUpgrades = {}
	this.Inverted = inverted
	this.Index = 0
	
	this.Object = CreateHouse(this,cframe)
	this.Garage = this.Object.Garage
	this.OriginalGarageGateSize = this.Garage.Gate.Size
	this.OriginalGarageGateCFrame = this.Garage.Gate.CFrame
	this.BarrierVisible = false

	this.Mailbox = this.Object.Mailbox
	this.Upgrades = this.Object.Upgrades
	this.BoundsBlocks = {}
	
	
	this.UpgradeModel = nil
	this.GivePizza = nil
	this.Rooms = GetRoomData(this)  --UpgadeModel(RoomName(floors and walls))

	if not Enums.IsPartyServer then
		this.Mailbox.Head.LabelBack.TextLabel.Text = this.Address
		this.Mailbox.Head.LabelFront.TextLabel.Text = this.Address
	else
		this.Mailbox.Head.LabelBack.TextLabel.Text = this.Address
		this.Mailbox.Head.LabelFront.TextLabel.Text = this.Address
	end
	this.Mailbox.Name = ""
	this.GivePizzaConnection = nil
	
	if not Enums.IsPartyServer then
		this.Guy = this.Object.Guy
		this.Guy.Name = ""
		this.Guy.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(0,10000+math.random(1,1000),0))
	else
		this.Object.Guy:Destroy()
	end
	
	this.Doors = {}
	this.FrontDoor = nil
	this.FurnitureCount = 0
	
	this.Object.Address.Value  = this.Address
	this.Object.MailboxPointer.Value = this.Mailbox
	
	
	this.HouseEvents = {}
	this.GarageEvents = {}
	
	return this
end





--convert old data structure to new
--turn {143454,5477463,758363} into {["FirstFloor"] = "127726526",["SecondFloor"] = "127726526",["ThirdFloor"] = "127726526"}
local function ConvertCompatablilty(data)
	local newTable = {}
	local roomNames = {"FirstFloor","SecondFloor","ThirdFloor","Basement","FourthFloor","SecondFloor2","ThirdFloor2"}
	if data and data[1] then
		for i,assetId in ipairs(data) do
			newTable[roomNames[i]] = assetId
		end
		return newTable
	end
	return nil
end


function AddHouseEvents(self)
	
	for _,event in ipairs(self.HouseEvents) do
		event:disconnect()
	end
	self.HouseEvents = {}

	
	local function setWindowState(player,window)
		if self.Owner and self.Owner == Players[player] then
			if window.Transparency ~= 0 then
				window.Transparency = 0
			else
				window.Transparency = 0.7
			end
		end
	end
	
	local function setBarrierState(player,button)
		if self.Owner and self.Owner == Players[player] then
			for i,obj in ipairs(button.Parent:GetChildren()) do
				if obj:IsA("BasePart") and obj.Name == "Barrier" then
					if obj.Transparency ~= 0 then
						self.BarrierVisible = true
						obj.Transparency = 0
					else
						self.BarrierVisible = false
						obj.Transparency = 1
					end
				end
			end
		end
	end
	

	
	for _,part in ipairs(self.UpgradeModel:GetChildren()) do
		
		if part.Name == "Window" then
			part.Transparency = .7
			local clickdetector = part:FindFirstChild("ClickDetector") or Instance.new("ClickDetector",part)
			clickdetector.MaxActivationDistance = 10
			table.insert(self.HouseEvents,clickdetector.MouseClick:connect(function(player)
				setWindowState(player,part)
	
			end))
			
			
		elseif part.Name == "WallButton" then
			table.insert(self.HouseEvents,part.ClickDetector.MouseClick:connect(function(player)
				setBarrierState(player,part)
			end))
			if self.BarrierVisible then --make invisibe if visibe
				setBarrierState(self.Owner.Object,self.UpgradeModel.WallButton)
			end
		end
	end
	
	--when players starts going down basement stairs, give player script that makes the water and baseplate dissapear until player comes back to first floor
	if self.Upgrade == "Basement" then
		table.insert(self.HouseEvents,self.UpgradeModel.GoingToBasement.Touched:connect(function(hit)
			if hit and hit.Parent and hit.Parent:FindFirstChild("Humanoid") and not hit.Parent:FindFirstChild("Basement") then
				local basement = script.Basement:clone()
				basement.Disabled = false
				basement.Parent = hit.Parent
			end
		end))
	end

	if self.Upgrade == "FourStory" then
		table.insert(self.HouseEvents,self.UpgradeModel.GoingToBasement.Touched:connect(function(hit)
			if hit and hit.Parent and hit.Parent:FindFirstChild("Humanoid") and not hit.Parent:FindFirstChild("Basement") then
				local basement = script.Basement:clone()
				basement.Disabled = false
				basement.Parent = hit.Parent
			end
		end))
	end

	if self.Upgrade == "Massive" then
		table.insert(self.HouseEvents,self.UpgradeModel.GoingToBasement.Touched:connect(function(hit)
			if hit and hit.Parent and hit.Parent:FindFirstChild("Humanoid") and not hit.Parent:FindFirstChild("Basement") then
				local basement = script.Basement:clone()
				basement.Disabled = false
				basement.Parent = hit.Parent
			end
		end))
	end

	if self.Upgrade == "Hotel" then
		table.insert(self.HouseEvents,self.UpgradeModel.GoingToBasement.Touched:connect(function(hit)
			if hit and hit.Parent and hit.Parent:FindFirstChild("Humanoid") and not hit.Parent:FindFirstChild("Basement") then
				local basement = script.Basement:clone()
				basement.Disabled = false
				basement.Parent = hit.Parent
			end
		end))
	end

end






function House:LoadHouse(Player,upgradeName,furniture,colors,wallpapers,floors,garageEnabled)
	
	self.Owner = Player
		
	self.Upgrade = Enums.HouseSizes[upgradeName] or upgradeName or (Player and Debug.Enabled and Debug.HouseSize) or  (Player ~= nil and "Mini") or "Small"
	
	self.Colors = colors or {["Wall"] = 5, ["Roof"] = 1003, ["Window"] = 5, ["Door"] = 192}
	
	self.Wallpapers = ConvertCompatablilty(wallpapers) or wallpapers or {["FirstFloor"] = "142751224",["SecondFloor"] = "142751224",["ThirdFloor"] = "142751224",["Basement"] = "142751224",["FourthFloor"] = "142751224",["SecondFloor2"] = "142751224",["ThirdFloor2"] = "142751224"}

	self.Floors = ConvertCompatablilty(floors) or floors or {["FirstFloor"] = "142263417",["SecondFloor"] = "142263417",["ThirdFloor"] = "142263417",["Basement"] = "142263417",["FourthFloor"] = "142263417",["SecondFloor2"] = "142263417",["ThirdFloor2"] = "142263417"}
	
	self.GarageEnabled = garageEnabled or (Debug.Enabled and not Debug.LoadSaveData and Debug.GarageEnabled ) or false
	self:LoadGarage()
	
	self.Mailbox.Name = ((Player and Player.Object.Name) or self.Address)
	
	self.FurnitureCount = 0
	
	
	self:SetUpgrade(self.Upgrade)
	
	
	 
	
		
	--delete furniture----
	for _,furn in pairs(self.Furniture) do
		furn:Delete()
	end
	
	self.Furniture = {}
	
	--loadfurniture
	if Player and furniture then
		for _,savedData in ipairs(furniture) do
				
			local furniture = Furniture.new(self,savedData)
			if furniture then
				self.Furniture[furniture.Object] = furniture
				furniture:Initialize() --need to be here
								
				--keep track of the number of furniture
				if furniture.Data.Category == "Customization" then
					self.FurnitureCount = self.FurnitureCount + .5
				else
					self.FurnitureCount = self.FurnitureCount + 1
				end
			end
		end
	end
	
	------------
	
	

	
end




function House:PlaceFurniture(player,assetId,furnitureModel,newCFrame)
	
	
	--if has too much furniture in house
	if self.FurnitureCount >= Enums.MaxNumFurniture[self.Upgrade] then
		Dialog:ShowMessage(player,"House Full","You have too much furniture in your house.")
		furnitureModel:Destroy()
		return
	end


	if furnitureModel == nil then
		error("Furniture model dosent exist playerData = " .. tostring(self.Owner))
	end
	
	local playerData = self.Owner
	local inventory = playerData.Inventory
	local placedFurniture = playerData.PlacedFurniture
	local notZero = playerData:IncrementItemQuantity(assetId,-1) --subtract 1 from item in inventory
	if notZero then --if item was in inventory
		

		local border = furnitureModel.BorderPointer.Value
		--furnitureModel:SetPrimaryPartCFrame(newCFrame) --update model to the new positiond define by the client
		local localCFrame = self.UpgradeModel.Marker.CFrame:toObjectSpace(newCFrame) --convert to local
		
		local furniture = Furniture.new(self,nil,assetId,localCFrame,furnitureModel)
		self.Furniture[furniture.Object] = furniture
		furniture:Initialize() --need to be here
		
		--keep track of the number of furniture
		if furniture.Data.Category == "Customization" then
			self.FurnitureCount = self.FurnitureCount + .5
		else
			self.FurnitureCount = self.FurnitureCount + 1
		end
	
		
		
		
		
		playerData.DraggingFurniture = nil

	else
		furnitureModel:Destroy()
		
	end
end

function House:DeleteFurniture(furnitureModel)
	for furnitureObject,furnitureData in pairs(self.Furniture) do
		if furnitureData.Object == furnitureModel then
			local success = furnitureData.House.Owner:IncrementItemQuantity(furnitureData.AssetId,1)
			if success then
				if furnitureData.Data.Category == "Customization" then
					self.FurnitureCount = self.FurnitureCount - .5
				else
					self.FurnitureCount = self.FurnitureCount - 1
				end
				furnitureData:Delete()
				self.Furniture[furnitureObject] = nil
			end
		end
	end
end


function House:StartPlayerListUpdate()
	if Enums.IsPartyServer then
	
		local playerListPart = self.Object.PlayerList
		local billboard = playerListPart.BillboardGui
		
		spawn(function()
				
				math.randomseed(Utility:StringToUniqueNumber(self.Object.Name)) --so the checks happen at differnt times that other houses
				wait(math.random(1,60))
			
				while true do
					wait(10)
					local playersInsideHouse = self:GetPlayersInside()
					for _,player in ipairs(game.Players:GetPlayers()) do
						
						local insideHouse = false
						for _,insidePlayer in ipairs(playersInsideHouse) do
							if insidePlayer == player then
								insideHouse = true
							end
						end
						
						if self.Owner and self.Owner.Object == player and player.Character and player.Character.Parent and player.Character:FindFirstChild("Head") then
							if not insideHouse and player:DistanceFromCharacter(self.GivePizza.Position) > 50 and player.Character.Head:FindFirstChild("HostBillboardGui") then
								player.Character.Head.HostBillboardGui:Destroy()
							elseif insideHouse and player.Character.Head:FindFirstChild("HostBillboardGui") == nil then
								local host = game.ServerStorage.HostBillboardGui:clone()
								host.Parent = player.Character.Head
							end
						end
						
						if not insideHouse and billboard.Frame:FindFirstChild(player.Name) and player:DistanceFromCharacter(self.GivePizza.Position) > 50 then
							billboard.Frame[player.Name]:Destroy()
						elseif insideHouse and billboard.Frame:FindFirstChild(player.Name) == nil then
							local URL,ready = game.Players:GetUserThumbnailAsync ( player.userId, Enum.ThumbnailType.AvatarThumbnail,Enum.ThumbnailSize.Size180x180)
							billboard.Enabled = true
							local template = billboard.Frame.Template
							local newIcon = template:clone()
							newIcon.Name = player.Name
							newIcon.Visible = true
							newIcon.Image = URL
							newIcon.Parent = billboard.Frame
							playerListPart.Position = Vector3.new(self.GivePizza.Position.X,playerListPart.Position.Y,self.GivePizza.Position.Z) --
							workspace.Main.PlayerEnteredHouse:FireAllClients(player.userId,newIcon)
						end
						
						
						if #playersInsideHouse == 0 then
							billboard.Enabled = false
						else
							billboard.Enabled = true
						end
					end
					for _,obj in ipairs(billboard.Frame:GetChildren()) do
						if obj:IsA("ImageLabel") and obj.Name ~= "Template" and game.Players:FindFirstChild(obj.Name) == nil then
							obj:Destroy()
						end
					end
				end
			end)
			
	end
end


function House:LoadGarage()
	
	for _,event in ipairs(self.GarageEvents) do
		event:disconnect()
	end
	self.GarageEvents = {}

	
	if not self.GarageEnabled then self.Garage.Parent = game.ServerStorage.HouseStorage return end
	
	
	self.Garage.Parent = self.Object
	
	self.Garage.Gate.Size = self.OriginalGarageGateSize
	self.Garage.Gate.CFrame = self.OriginalGarageGateCFrame

	local boundsBlock = self.BoundsBlocks[self.Garage]
	if boundsBlock == nil then
		boundsBlock = self.Garage.HouseBoundsBlock
		boundsBlock.Transparency = 1
		boundsBlock.Parent = game.ServerStorage
		boundsBlock.CFrame = CFrame.new(Vector3.new(boundsBlock.Position.X,17.4,boundsBlock.Position.Z))
		self.BoundsBlocks[self.Garage] = boundsBlock
	end
	
	Environment:ClearTreesForHouse(self.Garage,boundsBlock)
	

		
	local function openGate(player,gate)
		
		if (self.Owner and self.Owner == Players[player]) or gate.CFrame:pointToObjectSpace(player.Character.HumanoidRootPart.Position).X > 0 then --dont let the player get trapped inside garage
			
			local pos = gate.Position
			local size = gate.Size
			local frame = gate.CFrame
			local loop = gate.Size.y
					
			for i=0,loop,1.2 do
				wait(.1)--wait(.03)
				gate.Size = Vector3.new(size.x,size.y-i,size.z)
				gate.CFrame = frame + Vector3.new(0,i/2,0)
			end
			
			
			local isOwner = (self.Owner and self.Owner.Object and self.Owner.Object == player)
			if isOwner then
				while player and player.Parent and player.Character and player:DistanceFromCharacter(gate.Position) < 50 do
					wait(1)
				end
			end
			
			
			pos = gate.Position
			size = gate.Size
			frame = gate.CFrame
			
			for i=0,loop,1.2 do
				wait(.1)
				gate.Size = Vector3.new(size.x,size.y+i,size.z)
				gate.CFrame = frame + Vector3.new(0,-i/2,0)
			end
		end
	end
	
	
	
	local buttonDebounce = false
	
	self.GarageEvents[1] = self.Garage.Button.ClickDetector.MouseClick:connect(function(player)
		if not Enums.IsPartyServer and not buttonDebounce and player.Character ~= nil and player.Character:FindFirstChild("Humanoid") then
			buttonDebounce = true
			if Players[player] and self.Owner and self.Owner == Players[player] then
				Vehicles:SpawnCarInGarage(player,self.Garage.GarageFloor)
			end
			wait(3)
			buttonDebounce = false
		end
	end)
		
	self.GarageEvents[2] = self.Garage.Button.Button.Touched:connect(function(hit) 
		if not buttonDebounce and not Enums.IsPartyServer then
			local player =  Utility:GetPlayerFromBodyPart(hit)
			if player then
				buttonDebounce = true				
				if Players[player] and self.Owner and self.Owner == Players[player] then
					Vehicles:SpawnCarInGarage(player,self.Garage.GarageFloor)
				end
				wait(3)
				buttonDebounce = false
			end
		end
	end)
		

	local gateDebounce = false

	self.GarageEvents[3] = self.Garage.Gate.Touched:connect(function(hit) 
		if not gateDebounce then
			local player =  Utility:GetPlayerFromBodyPart(hit)
			if player then
				gateDebounce = true
				openGate(player,self.Garage.Gate) 
				gateDebounce = false
			end
		end
	end)

	self.GarageEvents[4] = self.Garage.Gate.ClickDetector.MouseClick:connect(function(player) 
		if not gateDebounce then
			gateDebounce = true
			openGate(player,self.Garage.Gate) 
			gateDebounce = false
		end
	end)

end



function House:GetFurnitureInRoom(room)
	local furnitureObjects = {}
	for object,data in pairs(self.Furniture) do
		if data.Room == room then
			table.insert(furnitureObjects,object)
		end
	end
	return furnitureObjects
end



--hide rooms of old upgrademodel and enable the new rooms
local function SetRoomsEnabled(self,enabled)
	for object,room in pairs(self.Rooms[self.UpgradeModel]) do
		room:SetEnabled(enabled)
	end
end



function House:PlayerLeftHouse(player)
	if Enums.IsPartyServer then
		local billboard = self.Object.PlayerList.BillboardGui
		if billboard.Frame:FindFirstChild(player.Name) then
			billboard.Frame[player.Name]:Destroy()
		end
		
		if player.Character and player.Character:FindFirstChild("Head") and player.Character.Head:FindFirstChild("HostBillboardGui") then
			player.Character.Head.HostBillboardGui:Destroy()
		end
	
	end
end


function House:SetUpgrade(upgradeName)
	
	self.Upgrade = upgradeName
	
	if self.UpgradeModel then --get rid of current upgrade
		SetRoomsEnabled(self,false)
		self.UpgradeModel.Parent = game.ServerStorage.HouseStorage
	end
		
	self.UpgradeModel = self.AllUpgrades[upgradeName]
	self.UpgradeModel.Parent = self.Upgrades
	self.Object.CurrentUpgrade.Value = self.UpgradeModel
	
	--change room object of all the furniture
	for object,data in pairs(self.Furniture) do
		data:UpdateRoom()
	end
		
		
	SetRoomsEnabled(self,true)
	
	self:RefreshPaint()
	
	--window, open garage, open barrier
	AddHouseEvents(self)
	

	local boundsBlock = self.BoundsBlocks[self.UpgradeModel]
	if boundsBlock == nil then
		boundsBlock = self.UpgradeModel.HouseBoundsBlock
		boundsBlock.Transparency = 1
		boundsBlock.Parent = game.ServerStorage
		boundsBlock.CFrame = CFrame.new(Vector3.new(boundsBlock.Position.X,17.4,boundsBlock.Position.Z))
		self.BoundsBlocks[self.UpgradeModel] = boundsBlock
	end
	
	Environment:ClearTreesForHouse(self.Garage,boundsBlock)
	
	
	
	---doors----
	for i,door in ipairs(self.Doors) do
		--close door
		door:SetState(false)
		door:DisconnectEvents()
		self.Doors[i] = nil
	end
	
	self.Doors = {}
	
	for _,door in ipairs(self.UpgradeModel.Doors:GetChildren()) do
		local doorData = Door.new(door,self)
		table.insert(self.Doors,doorData)
		if doorData.Type == "FrontDoor" then
			self.FrontDoor = doorData
		end
	end
	----------
	
	
	

	
	self.GivePizza = self.UpgradeModel.GivePizza
	
	if self.GivePizzaConnection then self.GivePizzaConnection:disconnect() end
	
	if not Enums.IsPartyServer then
		self.GivePizzaConnection = self.GivePizza.Touched:connect(function(hit)
			workspace.Main.GivePizzaTouched:Fire(hit,self.Object,self.GivePizza,self.Guy)
		end)
	end
	
	
		---Clearing out snow for backyard and garage	
	
			

	
	
end






function House:IsPlayerInsideHouse(player)
	local torso = Utility:GetObjectInsideCharacter(player,"HumanoidRootPart")
	if torso then
		for box,data in pairs(self.Rooms[self.UpgradeModel]) do
			if Utility.IsPointInsideBox(box,torso.Position) then
				return true
			end
		end
	end
	return false
end

function House:GetPlayersInside()
	local insidePlayers = {}
	for _,player in ipairs(game.Players:GetPlayers()) do
		if self:IsPlayerInsideHouse(player) then
			table.insert(insidePlayers,player)
		end
	end
	return insidePlayers
end




function House:KickPlayerFromHouse(player)
	local humanoid = Utility:GetObjectInsideCharacter(player,"Humanoid")
	local playerData = Players[player]
	if humanoid and not humanoid.Sit then
		playerData:Teleport(self.UpgradeModel.Walkway.Position)
	--	self:PlayerLeftHouse(player)
	end
end

function House:KickAllPlayersFromHouse()
	for _,player in ipairs(self:GetPlayersInside()) do
		self:KickPlayerFromHouse(player)
		Dialog:ShowMessage("Party Shutdown", "The host has left the game.")
	end
end




function House:PaintFurniture(part,color)
	if part and part.Parent and self.Furniture[part.Parent] then -- will be nil if painting other people funrtiture
		self.Furniture[part.Parent]:SetColor(part,color)
	end
end



function House:SetColor(groupName,color)
	
	if groupName == "DoorTouch" then groupName = "Door" end
	
	self.Colors[groupName] = color
	
	local function paintChildren(model)
		for _,part in ipairs(model:GetChildren()) do
			if part:IsA("Model") then --doors are models
				paintChildren(part)
			elseif part.Name == groupName or (part.Name == "Barrier" and groupName == "Wall") then
				part.BrickColor = BrickColor.new(color)
			end
		end
	end
	
	paintChildren(self.UpgradeModel)

	if self.GarageEnabled then
		paintChildren(self.Garage)
	end
	
end


function House:RefreshPaint()
	for Type,brickcolor in pairs(self.Colors) do
		self:SetColor(Type,brickcolor)
	end
end


--gather properties of the wall and floor assets to be sent to client
function House:PackageWallFloor(zone)
	--backyard does not have wallpaper or floors
	if zone.Name == "Backyard" or zone.Name == "Porch" or zone.Name == "Balcony" then return nil end
	local floorId = self.Floors[zone.Name]
	if not floorId then --if a new updated added a new room
		self.Floors[zone.Name] = "142263417"
		floorId = "142263417"
	end
	local floorObject = AssetLibraryManager:GetAssetById(floorId).Object
	local floorData = {Texture = floorObject.Texture.Texture,Transparency = floorObject.Texture.Transparency,StudsPerTileU = floorObject.Texture.StudsPerTileU,StudsPerTileV = floorObject.Texture.StudsPerTileV,Reflectance = floorObject.Reflectance,Material = floorObject.Material,BrickColor = floorObject.BrickColor}
									
									
	local wallpaperId = self.Wallpapers[zone.Name]
	if not wallpaperId then--if a new updated added a new room
		self.Wallpapers[zone.Name] = "142751224"
		wallpaperId = "142751224"
	end
	local wallpaperObject = AssetLibraryManager:GetAssetById(wallpaperId).Object
	local wallpaperData ={Texture = wallpaperObject.Texture.Texture,Transparency = wallpaperObject.Texture.Transparency,StudsPerTileU = wallpaperObject.Texture.StudsPerTileU,StudsPerTileV = wallpaperObject.Texture.StudsPerTileV}
	return floorData,wallpaperData
end




function House:SetWallorFloor(room,assetId)
	
	local category = AssetLibraryManager:GetAssetById(assetId).Category
	local textureObjects = nil 
	
	if category == "Walls" then
		self.Wallpapers[room.Name] = assetId
	else
		self.Floors[room.Name] = assetId
	end
	
	local floorData,wallpaperData = self:PackageWallFloor(room)
	workspace.Main.WallOrFloorChanged:FireAllClients(self.Object,room,floorData,wallpaperData) --let the rest of the clients know the walls have changed
	
end


function House:GetOwner()
	--if player left but didnt clean up house for some reason
	if self.Owner and (not self.Owner.Object or not self.Owner.Object.Parent) then
 		delay(10,function()
			if self.Owner and (not self.Owner.Object or not self.Owner.Object.Parent) then
				error("House didnt lose ownership when player left.")
			end
		end)
	end
	return self.Owner
end

function House:SetOwner(Player)
	self.Owner = Player
	self.Object.Owner.Value = Player.Object
end

print("House loaded")
return House
