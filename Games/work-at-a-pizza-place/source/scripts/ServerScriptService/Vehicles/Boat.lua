local ServerScriptService = script.Parent.Parent
local Global = require(ServerScriptService:WaitForChild("Global"))
local Boat = {}
local Vehicles = Global.Vehicles
local Houses = Global.Houses
local Players = Global.Players
local AssetLibraryManager = Global.AssetLibraryManager
local Enviroment = Global.Environment
local Utility = require(game.ReplicatedStorage:WaitForChild("Utilities"):WaitForChild("Utility"))
local Dialog = require(game.ReplicatedStorage:WaitForChild("Dialog"))


Boat.__index = Boat









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
	if self.Object:FindFirstChild("LightMain") then
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
end







local subToFullName = {["Colo"] = "Color",["Part"] = "Part", ["Base"] = "Base", ["Stee"] = "Steering", ["Seat"] = "Seat", ["Stee"] = "Steering",["Whee"] = "Wheel", ["Wind"] = "Window"}


function Boat:SetColor(partName,color)
	Utility:SetGroupPropertiesByName(partName,{BrickColor = BrickColor.new(color)},self.Object)
	UpdateLights(self) --update light color
end



function Boat:Delete()
	--disconnect all events
	for k,v in pairs(self) do
		pcall(function() self[k]:disconnect() end)
	end
	
	if self.Object then
		self.Object:Destroy()
	end
	
	self.Deleted = true

end



function Boat.new(owner)

	local this = {}
	setmetatable(this, Boat)
	local object = game.ServerStorage.Vehicles.Boat:clone()
	
	this.Object = object
	this.Colors = {}
	this.Owner = owner
	this.LightsOn = false
	this.LastSeated = nil
	this.Deleted = false
	this.Type = "Boat"
	this.OriginalMaxSpeed = object.Driver.MaxSpeed  --gamepad driving make changes to these value and need to be reset when the player jumps out of the vehicle
	this.OriginalTurnSpeed = object.Driver.TurnSpeed

	
	

	this.TimeOfDayChange = game.ReplicatedStorage.GlobalData.TimeOfDay.Changed:connect(function() UpdateLights(this) end)
	UpdateLights(this)
	
		
	
	object.Parent = workspace.Boats
	object:MakeJoints()
	Utility:WeldVehicle(object)
	Utility:EnableScripts(object)

	object.Driver:SetNetworkOwner(owner)


	
	object.Base.BodyGyro.CFrame = object.Base.CFrame
	
	
	local last_seated = tick()
	local function PlayerSat(weld)
		if weld.Name == "SeatWeld" then
			last_seated = tick()
			
			local player = Utility:GetPlayerFromBodyPart(weld.Part1)
			if player then
				if this.Owner and this.Owner ~= player then
					wait()
					Dialog:ShowMessage(player,"Private boat","You are not allowed to drive " .. this.Owner.Name .. "'s boat.")
					wait()
					object.Driver.Disabled = true
					player.Character.Humanoid.Sit = false
					player.Character.Humanoid.Jump = true
					wait(.1)
					object.Driver.Disabled = false
					
				else
					
					local drive = script.DriveScript:clone()
					drive.Disabled = false
					drive.Parent = player.Character
					
				end
				
			end
		end
	end
	this.WeldAdded = object.Driver.ChildAdded:connect(PlayerSat)
	
	
	this.WeldRemoved = object.Driver.ChildRemoved:connect(function(weld)
		if weld.Name == "SeatWeld" then
			object.Driver.MaxSpeed  = this.OriginalMaxSpeed
			object.Driver.TurnSpeed = this.OriginalTurnSpeed
		end
	end)

	if Players[owner] then 
		Players[owner]:SetBoat(this)
	end

	
	this.SeatDestroyed = object.ChildRemoved:connect(function(part)
		if part.Name == "Driver" then
			this.SeatDestroyed:disconnect()
			Vehicles:Delete(object)
		end
	end)
	
	
	--open music menu to play music in boat
	for _,obj in ipairs(object:GetChildren()) do
		if obj:FindFirstChild("Speaker") then
			
			obj.Speaker.Detector.Event:connect(function(player)
				if player == this.Owner then
					local getid = game.Workspace.MessageService.GetInput:InvokeClient(player,"Audio")--local getid = game.Workspace.MessageService.GetInput:InvokeClient(player,"Audio")
					if getid ~= -1 then
						object.Base.Config.Value = getid
					end
				end
			end)
			
		end
	end
	
	return this

end



return Boat




