local ServerScriptService = script.Parent.Parent.Parent
local Global = require(ServerScriptService:WaitForChild("Global"))
local Furniture = {}
local Houses = Global.Houses
local Players = Global.Players
local AssetLibraryManager = Global.AssetLibraryManager
local Utility = require(game.ReplicatedStorage:WaitForChild("Utilities"):WaitForChild("Utility"))
local Dialog = require(game.ReplicatedStorage:WaitForChild("Dialog"))


Furniture.__index = Furniture



--legacy code, for converting to new structure
function ConvertPosition(self,object,savedData)
	local inverse_rotation = {
		[0] = 2,
		[1] = 3,	
		[2] = 0,
		[3] = 1,
	}
	
	local function boxProduct(product,offset)
		if offset == "" or product:FindFirstChild("Border") then return end
		local product_cframe = product:GetModelCFrame()
		local product_position =Vector3.new(product_cframe.x,product_cframe.y,product_cframe.z)
		local product_size = product:GetModelSize()
		local box = Instance.new("Part")
		box.Anchored = true
		box.Transparency = 1
		box.Name = "Border"
		box.CanCollide = false
		box.FormFactor = 0
		box.Size = Vector3.new(Utility:RoundUp(product_size.x,4),Utility:RoundUp(product_size.y,4),Utility:RoundUp(product_size.z,4))
		box.Parent = product
		local axis = nil
		if product.Name == "Workout Dumbells" or product.Name == "Outdoors Log Bench" or product.Name == "Tot Slide" or product.Name == "Patio Umbrella" or product.Name == "Varknox TV" or product.Name == "Princess Vanity"  then
			axis = product_size.z
		elseif product.Name == "Antler Bed" or product.Name == "Modern Coffee Table" or product.Name == "Modern Couch" or product.Name == "Bowling" or product.Name == "Stainless Microwave" or product.Name == "Pink Microwave" then
			axis = product_size.x
		else
			axis = product_size.y
		end
		
		box.CFrame = product_cframe + Vector3.new(0,(Utility:RoundUp(axis,4) - axis)/2,0)
		--box.CFrame = CFrame.new(Vector3.new(product_position.x, product_position.y + (roundUp(axis,4) - axis),product_position.z))
	end
	
	local function rotateModel(model,orientation)
		local amount = 0--math.pi
		if orientation == 0 then
			return
		elseif orientation == 1 then
			amount = math.pi/2
		elseif orientation == 2 then
			amount = math.pi
		elseif orientation == 3 then
			amount = -math.pi/2
		end
		local rotCF = CFrame.fromEulerAnglesXYZ(0, amount, 0)
		for i, object in pairs(model:GetChildren()) do
			if object:IsA("Part") or object:IsA("TrussPart") or object:IsA("UnionOperation") or object:IsA("WedgePart") or object:IsA("CornerWedgePart") or object:IsA("Seat") or object:IsA("VehicleSeat") then
				object.CFrame = rotCF * object.CFrame
			end
		end
	end
	if self.House.Inverted then
		if savedData.Reflection then
			rotateModel(object,inverse_rotation[savedData.Orientation])
		else
			rotateModel(object,savedData.Orientation)
		end
	else
		if not savedData.Reflection then
			rotateModel(object,inverse_rotation[savedData.Orientation])
		else			
			rotateModel(object,savedData.Orientation)
		end
	end
	local marker = self.House.UpgradeModel.Marker
	if self.House.Inverted then
		Utility:MoveModel(object,Vector3.new(marker.Position.x + savedData["X"],marker.Position.y + savedData["Y"],marker.Position.z + savedData["Z"]))
	else
		Utility:MoveModel(object,Vector3.new(marker.Position.x - savedData["X"],marker.Position.y + savedData["Y"],marker.Position.z - savedData["Z"]))
	end
	
	return marker.CFrame:toObjectSpace(object.PrimaryPart.CFrame)
end


local function ConvertColors(colors)
	if colors then
		while colors[1] do
			table.remove(colors,1)
		end
		return colors
	end
end


local function SetPropertyByName(name,root,properties)
	for _,obj in ipairs(root:GetChildren()) do
		for propName,value in pairs(properties) do
			if obj.Name == name then
				obj[propName] = value
			end
		end
		SetPropertyByName(name,obj,properties)
	end
end



function Furniture.new(house,savedData,assetId,localCFrame,object)
	
	savedData = savedData or {}
	
	local this = {}
	setmetatable(this, Furniture)
	
	

	this.Colors = ConvertColors(savedData.Colors) or {}   --{["21"] = 23, ["28"] = 21}
	this.AssetId = tonumber(savedData.AssetId) or tonumber(savedData.Asset_Id) or tonumber(assetId)
	this.LocalCFrame = Utility:JSONDecode(savedData.LocalCFrame,"CFrame") or localCFrame --cframe has to be encoded to be saved
	this.Config = savedData.Config
	
	this.SavedData = {"Colors","AssetId","LocalCFrame","Config"}

	
	this.Object = object
	this.ColorGroups = {}   --{["21"] = {workspace.Furniture1,workspace.Furniture2}}
	this.House = house
	this.Room = nil
	this.Data = AssetLibraryManager:GetAssetById(this.AssetId)
	this.Scripts = {}
	this.ConfigChanged = nil
	
	
	if this.Data.Category == "Walls" or this.Data.Category == "Floors" then return nil end

	
	--create a new object when loading furniture for first time. Furniture added during the game will already be created
	if not this.Object then
		print(this.Data.Name)
		this.Object = this.Data.Object:clone()
		--objects like friend doors are preloaded in houses
		this.Object.Parent = (this.Object:FindFirstChild("Preload")  and house.Object.Furniture) or game.ReplicatedStorage.StreamingFurnitureStorage
		--hide border, all the other furniture in the room will have no borders
		if savedData.X then --legacy format
			this.LocalCFrame = ConvertPosition(this,this.Object,savedData)
		end
		
	end
	
	--added 7/10/17   remove in 6 months 1/10/18
	if house and house.Owner and house.Owner.SavedDataVersion == 1 then --CHANGE TO 0
		if savedData.AssetId then  --apply to loaded furniture only
			if this.Object.Name == "Robloxian Poster" then
				local worldCFrame = house.UpgradeModel.Marker.CFrame:toWorldSpace(this.LocalCFrame)
				worldCFrame = worldCFrame - (worldCFrame.lookVector*1.5)
				this.LocalCFrame = house.UpgradeModel.Marker.CFrame:toObjectSpace(worldCFrame)
			elseif this.Object.Name == "Place Portal" then
				local worldCFrame = house.UpgradeModel.Marker.CFrame:toWorldSpace(this.LocalCFrame)
				worldCFrame = worldCFrame - (worldCFrame.lookVector*1.6)
				this.LocalCFrame = house.UpgradeModel.Marker.CFrame:toObjectSpace(worldCFrame)
			elseif this.Object.Name == "Poster" then
				local worldCFrame = house.UpgradeModel.Marker.CFrame:toWorldSpace(this.LocalCFrame)
				worldCFrame = worldCFrame - (worldCFrame.lookVector*1.5)
				this.LocalCFrame = house.UpgradeModel.Marker.CFrame:toObjectSpace(worldCFrame)
			elseif this.Object.Name == "Sign" then
				local worldCFrame = house.UpgradeModel.Marker.CFrame:toWorldSpace(this.LocalCFrame)
				worldCFrame = worldCFrame - (worldCFrame.lookVector*1.6)
				this.LocalCFrame = house.UpgradeModel.Marker.CFrame:toObjectSpace(worldCFrame)
			elseif this.Object.Name == "Pixel Art Canvas" then
				local worldCFrame = house.UpgradeModel.Marker.CFrame:toWorldSpace(this.LocalCFrame)
				worldCFrame = worldCFrame - (worldCFrame.lookVector*1.6)
				this.LocalCFrame = house.UpgradeModel.Marker.CFrame:toObjectSpace(worldCFrame)
			end
			
		end
	end
	
	
	
	return this
	
end
	
	
function Furniture:Initialize()


	local object = self.Object
	local house = self.House
	
	object:SetPrimaryPartCFrame(house.UpgradeModel.Marker.CFrame:toWorldSpace(self.LocalCFrame)) --move furniture to position

	local roomExists = self:UpdateRoom()
	if not roomExists then return end
	
	
	if self.Room.Name == "Porch" or self.Room.Name == "Balcony" or object:FindFirstChild("Preload") then
		
		self.Object.Parent = house.Object.Furniture
		
		if not object:FindFirstChild("Preload") then
			local preload = Instance.new("IntValue")
			preload.Name = "Preload"
			preload.Parent = object
		end
		
		if object:FindFirstChild("MusicPlayer") and house and house.Owner then
			Dialog:ShowMessage(house.Owner.Object,"","Music players don't work on porches and balconies.")
		end
	end
	

	--set config value and listen for changes
	if object:FindFirstChild("Config") then

		--string values cant be set to nil
		if  self.Config == nil and object.Config.ClassName == "StringValue" then
			self.Config = ""
		elseif self.Config == nil and (object.Config.Value ~= 0 and object.Config.Value ~= "" and object.Config.Value ~= 0) then --furniture with default config values like the multi light
			self.Config = object.Config.Value
		end
		
		object.Config.Value = self.Config
		
		self.ConfigChanged = object.Config.Changed:connect(function(value)
			self.Config = value
		end)
		
	end
	
	



	
	--enable then and then put in ServerScriptService
	local function EnableScripts(root) 
		for i,v in ipairs(root:GetChildren()) do
			if v:IsA("Script") and not v:IsA("LocalScript") then
				
				local objValue = Instance.new("ObjectValue")
				objValue.Value = object
				objValue.Name = "ObjectPointer"
				
				local housePointer = Instance.new("ObjectValue")
				housePointer.Value = house.Object
				housePointer.Name = "HousePointer"
				
				local e = v:clone()
				objValue.Parent = e
				housePointer.Parent = e
				e.Disabled  = (e:FindFirstChild("DontEnable") and true) or false
				e.Parent = game.ServerScriptService
				
				table.insert(self.Scripts,e)
				
				
				v:Destroy()
				
			else
				EnableScripts(v)
			end
		end
	end
	EnableScripts(object)
	
	
	
	--make new furniture visible for players in the same room
	local floorData,wallData = house:PackageWallFloor(self.Room)
	workspace.Main.FurnitureAdded:FireAllClients(house.Object,self.Room,object,nil,wallData)



	
	local houseColors = house.Colors
	
	
	--addpaint walls and doors when loaded or placed
	if object:FindFirstChild("Wall") then
		local wallpaperId = house.Wallpapers[self.Room.Name]
		SetPropertyByName("Wall",object,{BrickColor = BrickColor.new(houseColors.Wall)})
	end 
			
	if object:FindFirstChild("DoorClosed") then
		SetPropertyByName("DoorClosed",object,{BrickColor = BrickColor.new(houseColors.Door)})
		SetPropertyByName("DoorOpen",object,{BrickColor = BrickColor.new(houseColors.Door)})		
	end
	
	
	
	--color all the parts
	local children = object:GetChildren()
	for partName,color in pairs(self.Colors) do
		for _,object in ipairs(children) do
			if object.Name == partName then
				object.BrickColor = BrickColor.new(color)
			end
		end
	end
	
	object.BorderPointer.Value.Parent = game.ReplicatedStorage.BorderStorage
	
	
	
	


end

--when upgrade model changes, need to update
function Furniture:UpdateRoom()
	--find the room the item is in
	for roomObject,_ in pairs(self.House.Rooms[self.House.UpgradeModel]) do
		if Utility.IsPointInsideBox(roomObject,self.Object.BorderPointer.Value.Position) then
			self.Room = roomObject
			
			break
		end
	end
	
	--if not furniture is no inside any room, put back into inventory
	if self.Room == nil then
		self.House:DeleteFurniture(self.Object)
		return false
	else
		return true
	end
end



function Furniture:SetColor(part,color)
	
	self.Colors[part.Name] = color

	for _,obj in ipairs(self.Object:GetChildren()) do
		if obj:IsA("BasePart") and obj.Name == part.Name then
			obj.BrickColor = BrickColor.new(color)
		end
	end
end




function Furniture:RotateIncrement(increment)
	
end


function Furniture:SetPosition(localCFrame)
	
end



function Furniture:Delete()
	self.Object.BorderPointer.Value:Destroy()
	self.Object:Destroy()
	if self.ConfigChanged then
		self.ConfigChanged:disconnect()
	end
	
	for _,Script in ipairs(self.Scripts) do
		if Script and Script.Parent then
			Script:Destroy()
		end
	end
	
end


return Furniture
