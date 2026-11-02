local ServerScriptService = script.Parent.Parent
local Global = require(ServerScriptService:WaitForChild("Global"))
local Car = {}
local Vehicles = Global.Vehicles
local Houses = Global.Houses
local Players = Global.Players
local AssetLibraryManager = Global.AssetLibraryManager
local Enviroment = Global.Environment
local Utility = require(game.ReplicatedStorage:WaitForChild("Utilities"):WaitForChild("Utility"))
local Dialog = require(game.ReplicatedStorage:WaitForChild("Dialog"))


Car.__index = Car


local function SetGroupPropertyByName(groupName,properties,self)
	local subgroupName = string.sub(groupName,1,4)
	for _,obj in ipairs(self.Object:GetChildren()) do
		for propName,value in pairs(properties) do
			if string.sub(obj.Name,1,4) == subgroupName then
				obj[propName] = value
			end
		end
	end
end

local function UpdateLights(self)
	if Enviroment.TimeOfDay == "Night" then
		self.Object.LightMain.Light.Enabled = true
		Utility:SetGroupPropertiesByName("Light",{Material = "Neon"},self.Object)
		Utility:SetGroupPropertiesByName("Topper",{Material = "Neon"},self.Object)
		self.Object.LightMain.Light.Color = self.Object.LightMain.BrickColor.Color


	else
		self.Object.LightMain.Light.Enabled = false
		Utility:SetGroupPropertiesByName("Light",{Material = "SmoothPlastic"},self.Object)
		Utility:SetGroupPropertiesByName("Topper",{Material = "SmoothPlastic"},self.Object)
	end	
end



function Car:ToggleHoodVisibility()  
	if self.HoodVisible then
		Utility:SetGroupPropertiesByName("Hood",{Transparency = 1},self.Object)

		self.HoodVisible = false
		self:ShowTopper(false)
	else
		Utility:SetGroupPropertiesByName("Hood",{Transparency = 0},self.Object)
		self.HoodVisible = true
		
		if self.IsDelivery then
			self:ShowTopper(true)
		end
	end
end




function Car:ShowTopper(visible)
	for _,obj in ipairs(self.Object:GetChildren()) do
		if obj.Name == "Topper" then
			obj.Transparency = (visible and 0) or (not visible and 1)
			
		elseif obj.Name == "Image" then
			obj.SurfaceGui.Enabled = visible
		end
	end
	self.TopperEnabled = visible
end




local subToFullName = {["Hood"] = "Hood",["Ligh"] = "Lights", ["Pain"] = "Paint", ["Rear"] = "Rear", ["Seat"] = "Seat", ["Stee"] = "Steering",["Whee"] = "Wheel", ["Wind"] = "Window"}


function Car:SetColor(partName,color)
	Utility:SetGroupPropertiesByName(partName,{BrickColor = BrickColor.new(color)},self.Object)
	UpdateLights(self) --update light color
end



function Car:Delete()
	--disconnect all events
	for k,v in pairs(self) do
		pcall(function() self[k]:disconnect() end)
	end
	
	if self.Object then
		self.Object:Destroy()
	end
	
	self.Deleted = true

end



function Car.new(spawnPosition,owner,carId)
	
	
	local asset = AssetLibraryManager:GetAssetById(carId)
	local this = {}
	setmetatable(this, Car)
	this.Object = (asset~=nil and asset.Object) or game.ServerStorage.Vehicles.Car
	this.Object = this.Object:clone()
	local object = this.Object

	this.IsWorkCar = (owner == nil and true) or false
	this.Owner = owner
	this.LightsOn = false
	this.IsDelivery = false
	this.TopperVisible = false
	this.HoodVisible = true
	this.SpawnPosition = spawnPosition
	this.LastSeated = tick()
	this.Deleted = false
	this.Type = "Car"
	this.OriginalMaxSpeed = object.Driver.MaxSpeed  --gamepad driving make changes to these value and need to be reset when the player jumps out of the vehicle
	this.OriginalTurnSpeed = object.Driver.TurnSpeed
	

	this.TimeOfDayChange = game.ReplicatedStorage.GlobalData.TimeOfDay.Changed:connect(function() UpdateLights(this) end)
	UpdateLights(this)
	

	
	object.Hood1.ClickDetector.Detector.Event:connect(function(player) this:ToggleHoodVisibility()  end)
	--object.Topper.ClickDetector.Detector.Event:connect(function(player) this:ToggleHoodVisibility() end)
	object.Hood2.ClickDetector.Detector.Event:connect(function(player) this:ToggleHoodVisibility() end)
	object.Hood1.Touched:connect(Utility:Debounce(function(hit) 
		if hit and hit.Parent and hit.Position.Y < 2 and not this.Deleted then
			object.Driver.BodyGyro.MaxTorque = Vector3.new(4000000,0,4000000)
			wait(1)
			if not this.Deleted then
				object.Driver.BodyGyro.MaxTorque = Vector3.new(0,0,0)
			end
		end
	end))
	
	delay(1,function() if object:FindFirstChild("Driver") then object.Driver.BodyGyro.MaxTorque = Vector3.new(0,0,0) end end)
	
	
	object.Parent = workspace.Cars
	object:MakeJoints()
	Utility:WeldVehicle(object)
	Utility:EnableScripts(object)
	object:MoveTo(spawnPosition + Vector3.new(0,5,0))


	
	--set colors
	if owner and Players[owner] then
		for partName,color in pairs(Players[owner].Car_Colors) do
			this:SetColor(partName,color)
		end
	end
	
	if this.IsWorkCar then
		this:ShowTopper(true)
	end
	
	local currentOccupant = nil 
	
	
	local function PlayerSat(weld,state)
		if weld.Name == "SeatWeld" and not this.Deleted then
			this.LastSeated = tick()
			
			local player = Utility:GetPlayerFromBodyPart(weld.Part1)
			if player and state == "Added" then--and state == "Added" then
				if not this.IsWorkCar and this.Owner and this.Owner ~= player then
					wait()
					Dialog:ShowMessage(player,"You are not allowed to drive " .. this.Owner.Name .. "'s car.","Ok")
					object.Driver.Disabled = true
					player.Character.Humanoid.Sit = false
					player.Character.Humanoid.Jump = true
						
					wait(.1)
						
					object.Driver.Disabled = false
				
				else
					if player.TeamColor == BrickColor.new(23) and object:FindFirstChild("Hood1") and object.Hood1.Transparency == 0 then
						this.IsDelivery = true
						this:ShowTopper(true)
					else
						this.IsDelivery = false
						this:ShowTopper(false)
					end
					game.Workspace.Main.SittingInCar:FireClient(player,object,this.OriginalMaxSpeed,this.OriginalTurnSpeed)
				end
				
			elseif player and state == "Removed" then
				 workspace.TutorialService.RemoveArrows:FireClient(player)
			end
		end
	end
	this.WeldAdded = object.Driver.ChildAdded:connect(function(child) PlayerSat(child,"Added") end)
	this.WeldRemoved = object.Driver.ChildRemoved:connect(function(child) PlayerSat(child,"Removed") end)


	


	
	this.SeatDestroyed = object.ChildRemoved:connect(function(part)
		if part.Name == "Driver" then
			this.SeatDestroyed:disconnect()
			Vehicles:Delete(object)
		end
	end)
	
	
	local CAR_IDLE_TIME = 360
	if owner == nil then --dont auto respawn with player owned car
		
		spawn(function()
			while not this.Deleted do
				
				if object and object:FindFirstChild("Driver") == nil then
					Vehicles:Delete(object)
				
				elseif object.Driver.Position.Y < -.02 and not object.Driver.Occupant then
					Vehicles:Delete(object)
				
				elseif tick() - this.LastSeated > CAR_IDLE_TIME and not object.Driver.Occupant then
					Vehicles:Delete(object)
				end
				
				wait(60)
			end
		end)
		
	else
		if Players[owner] then 
			Players[owner]:SetCar(this)
		end
	end
	

	return this

end



return Car




