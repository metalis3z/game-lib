

local ServerScriptService = script.Parent.Parent
local Global = require(ServerScriptService:WaitForChild("Global"))
local Player = {}
local Houses = Global.Houses
local Players = Global.Players
local Paycheck = Global.Paycheck
local Manager = Global.Manager
local AssetLibraryManager = Global.AssetLibraryManager
local Utility = require(game.ReplicatedStorage:WaitForChild("Utilities"):WaitForChild("Utility"))
local Dialog = require(game.ReplicatedStorage:WaitForChild("Dialog"))
local Enums = require(game.ReplicatedStorage:WaitForChild("Enums"))
local Debug = require(game.ReplicatedStorage:WaitForChild("Debug"))
local Tutorial = require(ServerScriptService:WaitForChild("Tutorial"))



Player.__index = Player


local HouseRatings = (game.PlaceId ~= 0 and game:GetService("DataStoreService"):GetOrderedDataStore("TopRated181"))
local DataStore = Enums.DataStore

game.StarterPlayer.StarterCharacterScripts.CustomAnimation.Parent = script --custom faces do not work unless the script is closed from the server



function Player:SwitchClothes(uniformOn)
	if self.Character == nil or self.Character:FindFirstChild("Head") == nil then return end
	--put original clothing inside head for storage or put back inside character
	local parent = (self.WearingUniform and self.Character.Head) or self.Character
	for _,obj in pairs(parent:GetChildren()) do
		if obj:IsA("Shirt") or obj:IsA("Pants") or obj:IsA("ShirtGraphic") and obj.Name ~= "Uniform" and obj.Name ~= "BusinessSkirt" then
			obj.Parent = (uniformOn and self.Character.Head) or self.Character
		end
	end

	local bodyColors = self.Character:FindFirstChild("Body Colors") or Instance.new("BodyColors",self.Character)
	bodyColors.LeftLegColor = self.LegColors[1]
	bodyColors.RightLegColor = self.LegColors[2]
	
	
	if self.Character:FindFirstChild("Uniform") then self.Character.Uniform:Destroy() end
	if self.Character:FindFirstChild("BusinessSkirt") then self.Character.BusinessSkirt:Destroy() end

	
	
	if uniformOn then
		
		local uniform = Instance.new("Shirt")
		uniform.ShirtTemplate = "http://www.roblox.com/asset/?id=" .. self.UniformId  
		uniform.Name = "Uniform"
		uniform.Parent = self.Character
		
		
		if self.Character:FindFirstChild("BusinessSkirt") then self.Character.BusinessSkirt:Destroy() end
			
		bodyColors.LeftLegColor = BrickColor.new(1003)
		bodyColors.RightLegColor = BrickColor.new(1003)
				
				
		if self.UniformId  == 81431084 then  -- women suit
					
			local bs = Instance.new("Pants")
			bs.Name = "BusinessSkirt"
			bs.PantsTemplate = "http://www.roblox.com/asset/?id=81924152"
			bs.Parent = self.Character
				
			bodyColors.LeftLegColor = self.LegColors[1]
			bodyColors.RightLegColor = self.LegColors[2]	
		end
	end
	
	
	self.WearingUniform = uniformOn
	
end






function Player:SetUniform(uniformName)
	
	if uniformName then
		local clothes = {
			["Shirt"] = 147222549,
			["MenSuit"] = 85372001,
			["WomenSuit"] = 81431084
		}
		
		self.UniformId = clothes[uniformName]
	
		self:SwitchClothes(true)
	end
	
end



function Player:SetJob(jobName)
	local color = Enums.TeamNameToBrickColor[jobName] --make sure job name is valid
	if color then
		self.Job = jobName
		self.Object.TeamColor = BrickColor.new(color)
		
		--put on the uniform if switching to job
		if self.Settings.UniformEnabled and jobName ~= "On Break" then
			self:SwitchClothes(true)
		elseif jobName == "On Break" then
			self:SwitchClothes(false)
		end
	end
end

local occupied_list = {false,false,false,false,false,false,false,false,false,false,false,false}

function Player:StartIntro()
	

	spawn(function()
		local player = self.Object
		--while player and player.Parent ~= nil and player.Character and player.Character:FindFirstChild("HumanoidRootPart") do wait() end
		
		local intro_pos = {0,1,-1,2,-2,3,-3,4,-4,5,-5,6,-6,7,-7}
		local added = nil
		
		
		while not self.Destroyed and self.Object and self.Object.Parent and self.Object.Character == nil do wait(.1) end
		if self.Object.Parent == nil then return end
	
		local character = player.Character
	
		if game:GetService("RunService"):IsStudio() then
			workspace.Main.StartChooseJob:FireClient(player)
		end
		local humanoid = character:WaitForChild("Humanoid",5)

		
		humanoid.WalkSpeed = 0
					
		local new_count = 1
		for index,occupied in ipairs(occupied_list) do
			if not occupied or game.Players:FindFirstChild(occupied) == nil or occupied == player.Name then
				occupied_list[index] = player.Name
				new_count = index
				break
			end
		end
					
		local rootPart = character:WaitForChild("HumanoidRootPart",1)
		if rootPart and humanoid then
			rootPart.CFrame = CFrame.new(Vector3.new(47.44 + (intro_pos[new_count] * 6) , 3.5, 185),Vector3.new(47.434, 5, 217.24)) --
		end
			--rootPart.Anchored = true
			--rootPart.RotVelocity = Vector3.new(0,0,0)
		--	rootPart.Velocity = Vector3.new(0,0,0)
			--humanoid.Jump = true
			--humanoid:ChangeState(Enum.HumanoidStateType.Running)

			--[[local dances = {"Dance","Dance2","Dance3"}
			local randomDance = dances[math.random(1,3)]	
			--restart intro dance when a new player enters so they can see your animation - Animation:Play() doesnt replicate while looping
			self.DanceConnection = game.Players.PlayerAdded:connect(function()
				workspace.Main.InvokeEmotion:FireClient(player,randomDance)
			end)]]
			--wait(1)
						

			--humanoid:ChangeState(Enum.HumanoidStateType.Running)
			--pcall(function() if rootPart and rootPart.Parent then rootPart.Anchored = false end end)
			--workspace.Main.InvokeEmotion:FireClient(player,randomDance)
		
		
	end)
	
end

--print(require(game.ServerScriptService.Players)[game.Players.Dued1].StartedPlaying)
function Player:TeleportToJob(atHome,teamColor)


	local player = self.Object
	
	self:LocationChanged(nil)


	self:SetJob(Enums.BrickColorToTeamName[teamColor])	
	

	for index,occupied in ipairs(occupied_list) do
		if occupied == player.Name then
			occupied_list[index] = false
			break	
		end
	end
	
	while player.Character == nil or player.Character:FindFirstChild("HumanoidRootPart") == nil do wait() end
		
	player.Character.Humanoid.WalkSpeed = 16

	if player.Character.Humanoid.Sit == true then
		player.Character.Humanoid.Jump = true
		wait(.1)
	end
	
	
	self.StartedPlaying = true
	workspace.Main.StartedPlaying:FireClient(player)
		
		
	if atHome then
		self:TeleportHome()
		return
	end
		
		
	--try 4 times to spawn at spawn location without ending up on the roof
	math.randomseed(tick())
	math.random()
	for i=1,4 do
		local spawns = {}
		for _,obj in ipairs(workspace:GetChildren()) do
			if obj:IsA("SpawnLocation") and obj.TeamColor == player.TeamColor then
				table.insert(spawns,obj)
			end
		end
		local Spawn = spawns[math.random(1,#spawns)]
		self:Teleport(Spawn.Position + Vector3.new(0,3.5,0))
		if player and player.Character and player.Character.HumanoidRootPart.Position.Y < 15 then 
			local _,_,_,r00,r01,r02,r10,r11,r12,r20,r21,r22 = Spawn.CFrame:components() 
			local pos = player.Character.HumanoidRootPart.Position
			player.Character.HumanoidRootPart.CFrame = CFrame.new(pos.X,pos.Y,pos.Z,r00,r01,r02,r10,r11,r12,r20,r21,r22)
			break
		end
	end
end

function onPlayerRespawn(self)
	

	print("Respawn")

	
	local player = self.Object
	local character = player.Character
	
	self:LocationChanged(nil)
	
	
	
	
	if not Enums.IsPartyServer then
		--wait for clothing to load
		if not player:HasAppearanceLoaded() and not (Enums.IsStudio or Enums.IsLocalServer) then
			local loaded = false
			local connection
			connection = player.CharacterAppearanceLoaded:connect(function()
				loaded = true
				connection:disconnect()
			end)
			while not loaded and not self.Destroyed do wait() end
			
		end
		--collect clothing so it can be toggled with the uniform
		local function CollectPlayerClothes()
			local clothing = {["Shirt"]={},["Pants"]={},["Shirt Graphic"]={}} 
			for _,obj in ipairs(player.Character:GetChildren()) do
				for k,_ in pairs(clothing) do
					if obj:IsA(k) then
						clothing[k][obj] = obj.Parent
					end
				end
			end
			return clothing
		end
	end
	
	self.Character = character
	
	
	
	local humanoid = character:WaitForChild("Humanoid",10)
	humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing,false)
	
	if humanoid.RigType == Enum.HumanoidRigType.R15 then
		humanoid.JumpPower = 60 --R15 is heavier that R6
	end
	--if seat has object named 'Laying", the make player sit
	

	
	--make hats weightless
	for _,obj in ipairs(character:GetChildren()) do
		if obj:IsA("Accessory") or obj:IsA("Hat") then
			obj.Handle.CustomPhysicalProperties = PhysicalProperties.new(0,.4,.25) 
		end
	end
	
	
	local e = script:WaitForChild("CustomAnimation",10):clone()
	e.Disabled = false
	e.Parent = character--:WaitForChild("Head",1)
	
	--put all the emotion sounds as a direct descendent of Head
	--[[for i,v in ipairs(e:GetChildren()) do
		local sound = v:FindFirstChild("Sound")
		if sound ~= nil then
			sound.Name = v.Name
			sound.Parent = character:WaitForChild("Head",1)
		end
	end]]
	
	
	local bodyColors = (Enums.IsLocalServer and Instance.new("BodyColors",self.Character)) or self.Character:WaitForChild("Body Colors",10) or Instance.new("BodyColors",self.Character)
	if self.LegColors == nil then
		self.LegColors = {bodyColors.LeftLegColor,bodyColors.RightLegColor}
	end
--	self.OriginalClothing = CollectPlayerClothes()

	
	
	--load saved clothing
	--[[for category,data in pairs(self.Clothing) do
		if category == "Packages" or category == "Pants" or category == "Shirts" then
			local assetId = data
			local itemData = self:GetInventoryItemById(assetId) --
			workspace.Main.LoadClothing.LoadClothing:Fire(player,assetId,itemData.Name,category)
		else
			for _,assetId in ipairs(data) do
				workspace.Main.LoadRobloxItem.LoadRobloxItem:Fire(player,assetId,category)
			end
		end
	end]]
	
	spawn(function()
		--load saved backpack items
		while not self.StartedPlaying and not self.Destroyed do wait(.1) end
		for _,assetId in ipairs(self.Backpack) do
			workspace.Main.LoadRobloxItem.LoadRobloxItem:Fire(player,assetId,"Gear",true)
		end
	end)
	
	self.WearingUniform = false
	
	if self.Settings.UniformEnabled and not Enums.IsPartyServer  then
		--wait for clothes to load
		character:WaitForChild("Shirt",5)
		character:WaitForChild("Pants",5)
		self:SetUniform("Shirt")
	else
		self.UniformId =  147222549
	end
	

	
end


function Player:Delete()
	if self.CharacterAdded then
		self.CharacterAdded:disconnect()
	end
	
	
	self.Destroyed = true
end


function onPlayerKilled(self)
	
end





function Player:SaveData(waitFinish)
	if self.DisableSaving and Enums.IsOnline then return false end
	if(Debug.Enabled and not Debug.SavingEnabled) or Enums.IsLocalServer then return true end
	
	if not self.Moneyz then error("Moneyz dosent exist") end
	if not self.House then error("House dosent exist") end
	
	self.SavedDataVersion = Enums.SavedDataVersion
	
	
	local savedData = {}
	local function copyTable(dataObject)
		if not dataObject then return end
		for _,key in ipairs(dataObject.SavedData) do
			local value = dataObject[key]
			if type(value) == "table" then
				value = Utility:DeepCopy(value)
			end
			savedData[key] = value
		end
	end
	
	
	copyTable(self)
	copyTable(self.House)


	
	
	--save all the furniture
	savedData.Furniture = {}
	for object,furnitureData in pairs(self.House.Furniture) do
		local saved = {}
		for _,key in ipairs(furnitureData.SavedData) do --get the names of data that needs to be saved
			local value = furnitureData[key]
			if type(value) == "table" then
				value = Utility:DeepCopy(value)
			end
			if key == "LocalCFrame" then
				value = Utility:JSONEncode(value,"CFrame")
			end
			saved[key] = value
		end
		table.insert(savedData.Furniture,saved)
	end
	
	
	
	local finished = false
	local success, err
	
	spawn(function()
		success, err = pcall(function()
			DataStore:SetAsync(tostring(self.Object.userId),savedData)
			print("Finished saving")
			finished = true
		end)
		if not success then 
			finished = true 
			if err then 
				local extension = "("
				local function search(dir)
					local keyType = (type(dir) == "table" and dir[1] and "number") or "string"
					for key,value in pairs(dir) do
						if type(value) == "table" then
							search(value)
						end
						if type(key) ~= keyType then
							extension = extension .. tostring(key) .. tostring(value) .. ","
							return
						end
					end
				end
				search(savedData)

				
				
				if string.find(err,"Cannot convert mixed")  then
					error("Mixed keys " .. extension .. ")ErrorUserId:" .. tostring(self.Object.userId))
				else
					
					error(err) 
				end
			end
		end
	end)
	
	delay(10,function()
		if waitFinish and not finished then
			finished = true
			if not err then
				pcall(function() print(self.Object.Name," took to long to save") end)
				if success then
					error("Saving took too long.")
				else
					error("Saving took too long, errored")
				end
			else
				error(err)
			end
		end
	end)
	
	while waitFinish and not finished do
		wait()
	end
	
	print("Saved player data")
	
	return success or game.PlaceId ~= Enums.PizzaPlaceId
	
end


local function ConvertInventoryStructure(storedAssets)
	local newInventory = {}
	if storedAssets and storedAssets[1] == nil then
		for assetId,quantity in pairs(storedAssets) do
			if quantity > 0 then
				table.insert(newInventory,{AssetId = assetId, Quantity = quantity})
			end
		end
		return newInventory
	end
	return false
end

--some players history was corrumped. had tables with no 1 index. not suppored by json
local function CorruptionCheck(this,history)
	
	if history then
		local copy = Utility:DeepCopy(history)
		for category,categoryList in pairs(history) do
			for i,historyData in ipairs(categoryList) do
				if not historyData[2] or not historyData[1] then
					table.remove(copy[category],i)
					return CorruptionCheck(copy) --need to recurse if there are multiple corrupt items. table gets smaller after removing a item
				end
			end
		end
			
			
			
		return copy
		
	end

	
end

--asset ids were being stored as strings
local function CorruptionCheckInventory(this,inventory)
	
	if this.SavedDataVersion == 0 then --only run once
		if inventory then
			for i,item in ipairs(inventory) do
				if type(item.AssetId) == "string" then
					inventory[i].AssetId = tonumber(item.AssetId)
				end
			end
			return inventory
		end
	else
		return inventory
	end
end

local function ProccessAssetHistory(this,assetHistory)
	
	if assetHistory and this.SavedDataVersion == 0 then --only run once
		
		--remove all defaults from history  --converting to new favorites system and dont want defaults populating the popular list
		local defaults = require(game.ReplicatedStorage:WaitForChild("Defaults"))
		for category,data in pairs(assetHistory) do
			for i,item in ipairs(data) do
				if defaults[tostring(item[1])] then
					table.remove(data,i)
				end
			end
		end
	end
	
	return assetHistory
end


local function ConvertPlayTimeToPayments(currentUpgrade, play_time)
	
	local seconds_in_hour = 3600
	local upgradeTimes = {seconds_in_hour * 5, seconds_in_hour * 8, seconds_in_hour * 12, seconds_in_hour * 20}
	
	if currentUpgrade and type(currentUpgrade) == "number" and currentUpgrade <= #upgradeTimes and play_time and play_time > 0 then
		--just in case play time is above the max
		if play_time >= upgradeTimes[currentUpgrade] then
			play_time = upgradeTimes[currentUpgrade] - 600 --set back just a little
			play_time = Utility:Round(play_time,10) --min payment increment is 10
		end
		
		return math.floor((play_time/upgradeTimes[currentUpgrade]) * Enums.UpgradePrices[Enums.NextUpgradeName[Enums.HouseSizes[currentUpgrade]]])
	end
	return false
end

local function FillInventory()
	if Debug.Enabled and Debug.FillInventory then
		local inventory = {}
		for id,data in pairs(AssetLibraryManager:GetAssetLibrary()) do
			table.insert(inventory,{AssetId = tonumber(id), Quantity = 10})
		end
		return inventory
	end
end




function Player:ListenForEvents()
	spawn(function()
		local player = self.Object

		if player.Character then
			onPlayerRespawn(self)
			wait(5) --need this - characteradded can still fire
		end
		self.CharacterAdded = player.CharacterAdded:connect(function() onPlayerRespawn(self) end)
	
	end)

	--player.Changed:connect(function() onPropertyChanged(player,self) end)
end



function Player.new(player,data)
	
	local isNewPlayer = false
	if data == nil then
		isNewPlayer = true
		data = {}
	end
	
	
	local function GetRating(this)
		if HouseRatings then
			local rating
			local success = pcall(function()
				rating = HouseRatings:GetAsync(player.Name)
			end)
			if success and not rating then
				rating = 50000
				player["Rating_Player_Ids"] = {1111}
			end
			return rating
		end
	end
	
		
	if data.Banned and data.Banned > tick() then
		player:Kick("You have been banned from the game for drawing inappropriate pixel art. The ban will expire in " .. tostring(math.ceil((data.Banned - tick())/86400)) .. " days.")
		return 
	end

	
	local this = {}
	setmetatable(this, Player)
	
	--data.AssetHistory = {["Audio"] = {{47927569,"HEYYAA"},{479275695,"HEYYAA2"}}} ---remove this
	
	--saved data
	this.SavedDataVersion = (isNewPlayer and Enums.SavedDataVersion) or data.SavedDataVersion or 0 --only applies to existing player not for new players -- new players will be given the lastest verison in the 'Players' script
	this.Moneyz = data.Moneyz or (Debug.Enabled and Debug.Moneyz) or  0
	this.Jobs_Completed = data.Jobs_Completed or {["Cashier"] = 1,["Cook"] = 1,["Pizza Boxer"] = 1,["Delivery"] = 1,["Supplier"] = 1,["Manager"] = 1}
	this.Coins = data.Coins or 0
	this.UpgradePayments = data.UpgradePayments or ConvertPlayTimeToPayments(data.Upgrade, data.Play_Time) or 0
	this.Rating_Player_Ids = data.Rating_Player_Ids or {1111}
	this.Rating =  data.Rating or 50000
	this.Last_Played = data.Last_Played or tick()
	this.AssetHistory = ProccessAssetHistory(this,data.AssetHistory) or CorruptionCheck(this,data.History) or  {["Shirt"] = {},["Pants"] = {},["Audio"] = {},["Decal"] = {},["Place"] = {}}
	this.Music = data.Music or false
	this.Car_Colors = data.Car_Colors or {}
	this.Boat_Colors = data.Boat_Colors or {}
	this.Treasure = data.Treasure or false
	this.Completed_Tutorials = data.Completed_Tutorials or {false,false,false,false,false}
	this.Tutorials_Left = data.Tutorials_Left or 5   
	this.Inventory = (Debug.Enabled and not Debug.SavingEnabled and FillInventory()) or CorruptionCheckInventory(this,data.Inventory) or ConvertInventoryStructure(data.Stored_Assets) or {{AssetId = 142751224, Quantity = 1},{AssetId = 142263417, Quantity = 1},{AssetId = 499900058, Quantity = 1},{AssetId = 499900783, Quantity = 1}}
	this.Clothing = data.Clothing or {}
	this.Backpack = data.Backpack or {}
	this.Settings = data.Settings or {Music = (Debug.Enabled and Debug.MusicVolume) or 0.5, WaterEnabled = (Enums.IsConsoleServer and true) or false, UniformEnabled = true, OldMusic = false,}
	this.GamePasses = data.GamePasses or (data.Moneyz == nil and {}) or  {GarageUpgrade = game:GetService("GamePassService"):PlayerHasPass(player, 190452307) or nil, DeliveryBike = (game:GetService("GamePassService"):PlayerHasPass(player, 277476599) or game:GetService("MarketplaceService"):PlayerOwnsAsset(player,170903216)) or nil, PontoonBoat = game:GetService("GamePassService"):PlayerHasPass(player, 282349566) or nil, HangGlider = game:GetService("GamePassService"):PlayerHasPass(player, 148251062) or nil,ManagerTeleport = game:GetService("GamePassService"):PlayerHasPass(player, 148250798) or nil,UnlimitedMoneyz = game:GetService("GamePassService"):PlayerHasPass(player, 152873302) or nil}
	this.PaycheckName = data.PaycheckName or "" --when purchasing moneyz
	this.SprayId = data.SprayId or 0
	this.CanvasProjects = data.CanvasProjects or {}
	this.Banned = data.Banned or false
	this.SavedVideos = data.SavedVideos or {}   --{id,title,creator}
	
	local saveKeys = {}
	for key,value in pairs(this) do
		table.insert(saveKeys,key)
	end
	this.SavedData = saveKeys


	--session data
	this.NamingSchemeConverted = (data.Stored_Assets and true) or false --is saved data using the old naming scheme
	this.IsTestPlayer = (string.sub(player.Name,1,6) == "Player" and true) or false
	this.IsGuest = (player.userId < 5 and true) or false
	this.IsNewPlayer = (Debug.Enabled and Debug.StartAsNewPlayer) or isNewPlayer
	this.IsManager = false
	this.Object = player
	this.Current_Dialog = nil
	this.Current_Id = nil
	this.Vote_Manager = false
	this.Paycheck = 0
	this.IsAdmin = (Enums.Admins[player.Name] and true) or false
	this.WearingUniform = false
	this.Uniform = nil
	this.UniformId = 147222549 --shirt asset id
	this.Clothes = nil
	this.Character = nil
	this.LegColors = nil
	this.Car = nil
	this.Boat = nil
	this.Location = "Outside"
	this.LocationHouse = nil
	this.LoadedHouse = nil
	this.Destroyed = false
	this.Job = "On Break"
	this.LoadedRooms = {}
	this.OriginalPackage = {}
	this.TutorialObject = nil
	this.DisableSaving = true
	this.AnimationEvents = {}

	
	this.House = Houses:ReserveUnoccupiedHouse(this)
	
		
	if this.House == nil then
		if player and player.Parent then
			error("Could not reserve house")
		else --player left the game before a house was availble
			return
		end
	end
	
	--data.Furniture = {{Reflection = false, AssetId = 142269326, Orientation = 1,X=8.100269317627,Y=4.0900220870972,Z=10.1000061035156}}
	
	--convert house colors to new structure
	if data.House_Color then
		data.Colors = {
			Wall = data.House_Color,
			Roof = data.Roof_Color,
			Window = data.Window_Color,
			Door = data.Door_Color
		}
	end

	local success,err = pcall(function()
		this.House:LoadHouse(
			this,
			data.Upgrade,
			data.Furniture or data.Placed_Assets,
			data.Colors, 
			data.Wallpapers or data.Wallpaper, 
			data.Floors or data.Floor,
			this.GamePasses.GarageUpgrade
		)
	end)
	
	if not success then
		this.House:LoadHouse() --disown house so another player can use it
		workspace.Main.DataStoreError:FireClient(player,"There was an error when loading your house. Come back another time.")
		error(err)
	end
	
	

	if this.GamePasses.UnlimitedMoneyz and player.Name ~= "Dued1" then
		this.Moneyz = 99999
	end
	
	if not this.IsGuest and player.Name ~= "Dued1" then
		workspace.Main.Chatted:FireAllClients(nil,player.Name .. " has joined the game.",false)
	end
	
	return this
end


function Player:Initialize()
	
	local player = self.Object
	
	player.CameraMaxZoomDistance = 30
	player.HealthDisplayDistance = 0


	

	
	--give new player 3 random items and a bed
	
	if self.IsNewPlayer or (Enums.IsStudio and (Debug.Enabled and not Debug.LoadSavedData)) then
		
		local beds = AssetLibraryManager:GetItemsInCategories("Beds")
		local items = AssetLibraryManager:GetItemsInCategories("Lights","Seats","Tables","Collectable","Decoration")
		math.random()
		for i=1,2 do
			table.insert(self.Inventory,{AssetId = items[math.random(1,#items)].AssetId, Quantity = 1})
		end
		table.insert(self.Inventory,{AssetId = beds[math.random(1,#beds)].AssetId, Quantity = 1})
	end
	
	if game.PlaceId == Enums.PizzaPlaceTestId then
		if self:GetInventoryItemById(143758655) == nil and self.House.Object.Furniture:FindFirstChild("Modern TV") == nil then
			table.insert(self.Inventory,{AssetId = 143758655, Quantity = 1})
		end
		if self:GetInventoryItemById(912780197) == nil and self.House.Object.Furniture:FindFirstChild("Accessory Display") == nil then
			table.insert(self.Inventory,{AssetId = 912780197, Quantity = 1})
		end
	end
	
	
	
	--ask player if they want to put furniture down 
	if self.House.FurnitureCount == 0 then
		spawn(function()
			while not self.Destroyed do
				wait(300)
				if not self.Destroyed and self.House.FurnitureCount == 0 and player and player.Parent and self.TutorialObject == nil and not Enums.IsPartyServer then --make player isnt already in a tutorial
					spawn(function()
						local tutorial = Tutorial.new(player,6) --6 is index of Tutorial for furniture placment
						if tutorial then
							self.TutorialObject =  tutorial
							tutorial:Start()
						end
					end)
					break
				end
			end
		end)
	end
	
	local hasRemovePetHat = false
	for _,item in ipairs(self.Inventory) do
		if item.AssetId == 860395229 then
			hasRemovePetHat = true
			break
		end
	end
	--so player can remove hats from their pets
	if not hasRemovePetHat then
		table.insert(self.Inventory,{AssetId = 860395229, Quantity = 1})
	end
	
	

	--login bonus
	if not self.IsNewPlayer and tick() - self.Last_Played > 12 * 3600 then
		spawn(function()
			while not self.StartedPlaying do
				wait(1)
				if self.Destroyed then return end
			end
			Paycheck:GiveCheck(player,"Daily Check")
		end)
	end
	
	--starer check -- yeilds until player has starter
	if self.IsNewPlayer then
		Paycheck:GiveCheck(player,"Starter Check")
	end
	
	if self.PaycheckName ~= "" then
		Paycheck:GiveCheck(player,"Moneyz Purchase Check")
	end
	
	--tell players about the update in testing place
	
	if Enums.IsTestPlace and not Enums.IsStudio then
		delay(10,function()
			workspace.Main.ShowTestServerMessage:FireClient(player)
		end)
	end
	
	local folder = Instance.new("Folder")
	folder.Name = "SoundFolder"
	folder.Parent = player
	
	
	local Moneyz = Instance.new("IntValue")
	Moneyz.Name = "Moneyz"
	Moneyz.Value = self.Moneyz
	Moneyz.Parent = player
	
	
	local room = Instance.new("StringValue")
	room.Name = "Room"
	room.Value = "Outside"
	room.Parent = player
	
	
	
	
	
	--delay(5,function()
		
		--give starter gear if new player or using legacy saved data
		if self.IsNewPlayer or self.NamingSchemeConverted or Enums.IsStudio then
			print("giving paint bucket")
			self:IncrementItemQuantity(495886176,1) --paint bucket
			self:SaveBackpackItem(495886176,"Gear") -- put paintbucket in backpack
			self:IncrementItemQuantity(499900783,1) --chef hat
			self:IncrementItemQuantity(499900058,1) --work visor
		end
	
	
		if self.GamePasses.PontoonBoat then
			workspace.Main.ShowBoatButton:FireClient(player)
		end
		
	
		--give hang glider and bike if bought in the old version of the game. Give moneyzbag if player still has coins.
		if self.NamingSchemeConverted then
			
			local function GivePurchasedGear(gearAssetId)
				self:IncrementItemQuantity(gearAssetId,1)
				--game.Workspace.Main.LoadRobloxItem.LoadRobloxItem:Fire(player,gearAssetId,"Gear",true)
				self:SaveBackpackItem(gearAssetId,"Gear")
			end
		
			if self.GamePasses.HangGlider then GivePurchasedGear(497501382) end
			if self.GamePasses.DeliveryBike then GivePurchasedGear(497502431) end	
			if self.Coins > 0 then GivePurchasedGear(495315981) end
		end
		
		
			

		
	--end)
		
	
	if Debug.Enabled and not Debug.IntroEnabled then
		wait(1)
		self.StartedPlaying = true
		workspace.Main.StartedPlaying:FireClient(player)
	elseif Enums.IsPartyServer then
		self.StartedPlaying = true
		workspace.Main.StartedPlaying:FireClient(player)
		delay(1,function()
			self:TeleportHome()
		end)
		
	else
		self:StartIntro()
	end
	
	delay(20,function()
		if Enums.FreeMode then
			Dialog:ShowMessage(player,"FREE MODE","Everything that costs Robux is FREE for a little while for testing purposes. You won't get to keep anything though.")
		end
	end)
	
	local currentTick = 1487333806
	delay(20,function()
		if not Enums.IsStudio and self.House.Upgrade == "Backyard" and tick() - currentTick < 604800 then
			workspace.Main.SetWindowVisible:FireClient(player,"Upgrade",true)
		end 
	end)
	

	
	
	
	workspace.Main.CheckIfPlayerBoughtGamePass:Fire(player) -- make sure this is last 


	--if nothing errored, allow saving
	self.DisableSaving = false --make sure this is last
	
	
end




function Player:LocationChanged(zone)
	if zone == nil then  --default location is outside

		--if Enums.IsPartyServer and self.LocationHouse then
			
			--self.LoadedHouse:PlayerLeftHouse(self.Object)
		--end
		self.Object.Room.Value = "Outside"
		self.Location = "Outside"
		self.LocationHouse = nil
		workspace.Main.LocationChanged:FireClient(self.Object,nil)
		return
		
	--[[elseif zone.Name == "Shop" then
		self.LocationHouse = nil
		self.Location = zone
		workspace.Main.LocationChanged:FireClient(self.Object,zone)
		return]]
	end
	
	
	local roomData 
	local houseData
	for _,house in pairs(Houses.AllHouses) do --find the house the zone is located
		if house.Rooms[house.UpgradeModel][zone] then
			houseData = house
			roomData = house.Rooms[house.UpgradeModel][zone]
		end
	end
	
	--if Enums.IsPartyServer and houseData and self.Location == "Outside" then
		--houseData:PlayerEnteredHouse(self.Object)
	
--	end
				

	self.Location = zone
	if roomData and houseData and zone.Name ~= "Balcony" and zone.Name ~= "Porch" then --if zone is a house zone
			
		if  houseData.Owner and houseData.Owner.Object then
			self.Object.Room.Value = houseData.Owner.Object.Name
		else
			self.Object.Room.Value = "Outside"
		end
								
		self.LocationHouse = houseData -- LocationHouse = the house that player is inside
		
		if self.LoadedHouse ~= houseData  then --if player is inside new house, delete all the furniture in the other.
		
			self.LoadedHouse = houseData
			self.LoadedRooms = {}
			workspace.Main.ClearRooms:FireClient(self.Object)
		end
									
																
		if not self.LoadedRooms[zone] then -- dont load room if its already loaded
			self.LoadedRooms[zone] = true
			local furnitureList = houseData:GetFurnitureInRoom(zone)
						
			local floorData,wallpaperData = houseData:PackageWallFloor(zone) --gather all the properties of the walls and floors

			local houseColors = houseData.Colors	
										
			workspace.Main.LocationChanged:FireClient(self.Object,zone,self.LoadedHouse.Object,furnitureList,floorData,wallpaperData,houseColors)
								
		else
			workspace.Main.LocationChanged:FireClient(self.Object,zone,self.LoadedHouse.Object)
		end
									
									
	else --is balcony
		self.LocationHouse = nil
		self.LoadedHouse = nil
		workspace.Main.LocationChanged:FireClient(self.Object,zone)
	end	
end


function Player:SaveGamePass(nameId)
	self.GamePasses[nameId] = true
end




function Player:EnableMusic(enabled)
	self.Music = enabled
end



local MAX_NUM_FAVORITES = 70

function Player:AddAssetToHistory(Type,assetId,assetName)

	if assetName and assetId and Type then
		
		self.AssetHistory[Type] = self.AssetHistory[Type] or {}
		
		for _,assetInfo in ipairs(self.AssetHistory[Type]) do
			if assetInfo[1] == assetId then
				Dialog:ShowMessage(self.Object,"Already Exists","'" .. assetName .. "' has already been added to your favorites.")
				return self.AssetHistory
			end
		end
		
		
		if #self.AssetHistory[Type] == MAX_NUM_FAVORITES then
			Dialog:ShowMessage(self.Object,"Too Many Favorites","You have too many favorites. Delete some favorites to add more.")
			return self.AssetHistory
		end
		
		--alpha numeric and spaces only
		assetName = string.gsub(assetName,"[^%w ]+","")
		
		table.insert(self.AssetHistory[Type],1,{assetId,assetName})
		
		
	end
	return self.AssetHistory
end

function Player:RemoveAssetFromHistory(Type,assetId,assetName)
	for i,assetInfo in ipairs(self.AssetHistory[Type]) do
		if assetInfo[1] == assetId then
			table.remove(self.AssetHistory[Type],i)
			break
		end
	end
	return self.AssetHistory
end




function Player:IsTestPlayer()
	return self.IsTestPlayer
end


function Player:Teleport(position)
	local humanoidRootPart = Utility:GetObjectInsideCharacter(self.Object,"HumanoidRootPart")
	if humanoidRootPart then
		if humanoidRootPart.Parent.Humanoid.Sit == true then
			humanoidRootPart.Parent.Humanoid.Jump = true
			wait(.1)
		end
		self:LocationChanged(nil)
		humanoidRootPart.CFrame = CFrame.new(position + Vector3.new(0,2.5,0))
	end
end

function Player:TeleportHome()
	local house = self.House
	if house then
		self:Teleport(house.GivePizza.Position)
	end
end

function Player:AddMoneyz(amount,save)
	self.Moneyz = self.Moneyz + amount
	if self.Object and self.Object:FindFirstChild("Moneyz") ~= nil  then--and player.TeamColor ~= BrickColor.new(194)
		self.Object.Moneyz.Value = self.Moneyz
	end
	if save then
		self:SaveData()
	end
end

function Player:RemoveMoneyz(amount,dontUpdateCounter)
	if self.Moneyz > 0 and self.Moneyz - amount >= 0 and amount > 0 then 
		self.Moneyz = self.Moneyz - amount
		if not dontUpdateCounter and self.Object:FindFirstChild("Moneyz") ~= nil  then--and player.TeamColor ~= BrickColor.new(194)
			self.Object.Moneyz.Value = self.Moneyz
		end
		return true
	else
		return false
	end
end

function Player:HasEnoughMoneyz(price)
	return self.Moneyz >= price
end


function Player:IsGuest()
	return self.IsGuest
end

function Player:SetCar(car)
	self.Car = car
end

function Player:SetBoat(boat)
	self.Boat = boat
end




function Player:GetInventoryItemById(assetId)
	for i,itemData in ipairs(self.Inventory) do
		if itemData.AssetId == assetId then
			return itemData,i
		end
	end
end


function Player:SellInventoryItem(assetId)

	local success = self:IncrementItemQuantity(assetId,-1)
	if success then
		local asset = AssetLibraryManager:GetAssetById(assetId)
		local price = asset.Price
		price = price / 2
		self:AddMoneyz(price)
		
		--if item sold was a gear item, then remove from backpack
		local name = asset.Name
		local tool = self.Object.Backpack:FindFirstChild(name) or self.Object.Character:FindFirstChild(name)
		if tool then
			tool.Parent = nil
			self:UnsaveBackpackItem(assetId)
		end
		
	end
end




function Player:IncrementItemQuantity(assetId,delta) 

	local item, index = self:GetInventoryItemById(assetId)
	if item then
		
		self.Inventory[index].Quantity = self.Inventory[index].Quantity + delta
		if self.Inventory[index].Quantity == 0 then
			table.remove(self.Inventory,index)
			workspace.Main.InventoryItemQuantityChanged:FireClient(self.Object,assetId,0)  --update inventory list
		else
			workspace.Main.InventoryItemQuantityChanged:FireClient(self.Object,assetId,self.Inventory[index].Quantity)  --update inventory list
		end
		
		
		return true
	
	elseif delta > 0 then --if item dosent dosent exist, create it unless the quantity is not being incremented positivly
	
		
		table.insert(self.Inventory,1,{AssetId = assetId, Quantity = delta})
		
		--creates new inventory item and adds data from asset library to it. category, name, ect.
		local newItemData = Players:AddAssetData(AssetLibraryManager:GetAssetById(assetId),assetId,{Quantity = delta})
		
		
		
		workspace.Main.InventoryItemAdded:FireClient(self.Object,newItemData)  --client will have to get a updated inventory list from the server

		return true
	else
		print("ITEM DOSENT EXIST")
		return false
	end
end

 
function Player:SaveBackpackItem(assetId)
	--dont allow duplicates
	if assetId then
		for _,id in ipairs(self.Backpack) do
			if id == assetId then
				return
			end
		end
		table.insert(self.Backpack,assetId)
	end
end

function Player:UnsaveBackpackItem(assetId)
	if assetId then
		for i,id in ipairs(self.Backpack) do
			if id == assetId then
				table.remove(self.Backpack,i)
				break
			end
		end
	end
end

--for saving hats,gear, ect the player is wearing and load them when they reenter or reset
function Player:SaveClothing(assetId,category)
	--[[if category == "Pants" or category == "Shirts" or category == "Packages" then
		self.RobloxItems[category] = assetId  --only allow one shirt/pants id
	
	else --for multiple items categoryies- gear, hats
		self.RobloxItems[category] = self.RobloxItems[category] or {}
		table.insert(self.RobloxItems[category],assetId)
	end]]
end


function Player:UnsaveClothing(assetId,category)
	--[[for i,itemAssetId in ipairs(self.RobloxItems[category]) do
		if itemAssetId == assetId then
			table.remove(self.RobloxItems[category],i)
			
			break
		end
	end]]
end


function Player:SetSetting(settingName,value)
	self.Settings[settingName] = value
	
	--put on uniform if working
	if settingName == "UniformEnabled" and value == true and self.Job ~= "On Break" then
		self:SwitchClothes(true)
	
	elseif settingName == "UniformEnabled" and value == true and self.Job == "On Break" then
		Dialog:ShowMessage(self.Object,"Uniform","Your uniform will be put on automatically when you start working again.")
	
	elseif settingName == "UniformEnabled" and value == false then
		self:SwitchClothes(false)
	
	end
end


--adding moneyz towards house
function Player:IncrementPayments(value)
	

	local house = self.House
	local goalAmount = Enums.UpgradePrices[Enums.NextUpgradeName[house.Upgrade]]
	
	--sometimes this function is called twice in a row
	
	--dont allow incement payments if player has a backyard
	if not goalAmount or not value then
		return
	end
	
	
	if self:RemoveMoneyz(value,true) then
		self.UpgradePayments = self.UpgradePayments + value
	end


	if house and self.UpgradePayments >= goalAmount then
		workspace.Main.StartUpgradeCutscene:FireClient(self.Object,house.UpgradeModel,false)
	end
end



local VideoDataStore = (game.PlaceId ~= 0 and game:GetService("DataStoreService"):GetDataStore("Videos"))
local playbackDebounce = {}
function Player:PlayVideo(videoId,videoName,videoCreator)
	
	if not playbackDebounce[self.Object] and VideoDataStore and self.House then
		
		playbackDebounce[self.Object] = true
		local houseData = self.House
		local success,videoClips  = pcall(function() return VideoDataStore:GetAsync(videoId) end)
		if success then
			
			local houseObject = houseData.Object

			local videoClipsJSON = game:GetService("HttpService"):JSONEncode(videoClips)
			
			if videoClipsJSON ~= houseObject.Video.VideoClips.Value then --dont play the same video twice
			
				
				houseObject.Video.VideoCreator.Value = videoCreator
				houseObject.Video.VideoName.Value = videoName
				houseObject.Video.VideoCurrentFrame.Value = 0 
				houseObject.Video.VideoClips.Value = videoClipsJSON
	
				
				
				local function Play()
					
					houseObject.Video.VideoCurrentFrame.Value = 0
					wait(5) -- title screen
					
					for _,clip in ipairs(videoClips) do
						if houseObject.Video.VideoClips.Value == videoClipsJSON then
							houseObject.Video.VideoCurrentFrame.Value = houseObject.Video.VideoCurrentFrame.Value + 1 
							wait(tonumber(clip[2])) --wait length
						else
							return false
						end
					end
					return true
				end
				
				spawn(function()
					while Play() do wait() end --play on repeat
					houseObject.Video.VideoCurrentFrame.Value = -1
				end)
			end
		end
		
		wait(1)
		playbackDebounce[self.Object] = true
	end
end
local MAX_NUM_VIDEOS = 70
function Player:AddVideoToCollection(videoId,videoName,videoCreator)
	if #self.SavedVideos < MAX_NUM_VIDEOS then
		table.insert(self.SavedVideos,{videoId,videoName,videoCreator})
	else
		Dialog:ShowMessage(self.Object,"Too many video","You have too many video in your collection. The maximum number you can have is " .. MAX_NUM_VIDEOS)
	end
end


function Player:ImportVideo(videoJSON)
	
	
	local videoData = game:GetService("HttpService"):JSONDecode(videoJSON)
	
	

	
	if videoData.PluginVersion == nil or videoData.PluginVersion ~= Enums.VideoMakerPluginVersion then
		Dialog:ShowMessage(self.Object,"Plugin Update","In Roblox Studio, press the Manage Plugins button, then press the 'Update' button, then restart studio.")
		return true
	end
	
	local success,filteredVideoName = pcall(function() return game:GetService("Chat"):FilterStringForBroadcast(videoData.VideoName,self.Object) end)
	if not success then
		Dialog:ShowMessage(self.Object,"Error","There was an error when importing your video. Try agan later.")
		spawn(function() error(filteredVideoName) end)
		return true
	end
	
	

	for _,data in ipairs(videoData.VideoClips) do
		if data[3] ~= "" then
			local success,filteredCaption = pcall(function() return game:GetService("Chat"):FilterStringForBroadcast(data[3],self.Object) end)
			if not success then
				Dialog:ShowMessage(self.Object,"Error","There was an error when importing your video. Try agan later.")
				spawn(function() error(filteredCaption) end)
				return true
			end
			
			data[3] = filteredCaption
		end
	end
		
	
	--[[local filteredVideoData = videoName .. "|" .. numFrames .. "|"
	for imageId,length,caption in videoDataSerialized:match("\n(%d+)|([%d.]+)|([^%|]*)|") do

		filteredVideoData = filteredVideoData .. "\n" .. imageId .. "|" .. length .. "|" .. game:GetService("Chat"):FilterStringForBroadcast(caption,self.Object) .. "|"
	end]]
	

		--save data
	local videoId = self.Object.Name .. math.floor(tick())
	
	pcall(function()  RecentVideoDataStore:SetAsync(videoId,videoData.VideoClips) end) --so I cant check out some of the videos

		
	local success,err  = pcall(function()  VideoDataStore:SetAsync(videoId,videoData.VideoClips) end)
		
	if success then
		self:AddVideoToCollection(videoId,filteredVideoName,self.Object.Name)
	else
		if Enums.IsStudio then
			Dialog:ShowMessage(self.Object,"ERROR","Need to publish place before you can import. It uses datastores.")
		else
			Dialog:ShowMessage(self.Object,"ERROR","There was an error when importing your video.")
		end
		return true
	end
	
	return true
end





return Player






