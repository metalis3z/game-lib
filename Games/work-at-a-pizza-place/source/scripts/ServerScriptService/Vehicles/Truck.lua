local ServerScriptService = script.Parent.Parent
local Global = require(ServerScriptService:WaitForChild("Global"))
local Truck = {}
local Vehicles = Global.Vehicles
local Houses = Global.Houses
local Players = Global.Players
local AssetLibraryManager = Global.AssetLibraryManager
local Enviroment = Global.Environment
local Utility = require(game.ReplicatedStorage:WaitForChild("Utilities"):WaitForChild("Utility"))


Truck.__index = Truck




local function UpdateLights(self)

	if Enviroment.TimeOfDay == "Night" then
		self.Object.LightMain.Light.Enabled = true
		Utility:SetGroupPropertiesByName("Light",{Material = "Neon"},self.Object)
		Utility:SetGroupPropertiesByName("Topper",{Material = "Neon"},self.Object)

	else
		self.Object.LightMain.Light.Enabled = false
		Utility:SetGroupPropertiesByName("Light",{Material = "SmoothPlastic"},self.Object)
		Utility:SetGroupPropertiesByName("Topper",{Material = "SmoothPlastic"},self.Object)
	end	
end







function Truck:Delete()
	--disconnect all events
	for k,v in pairs(self) do
		pcall(function() self[k]:disconnect() end)
	end
	
	if self.Object then
		self.Object:Destroy()
	end
	
	self.Deleted = true

end

function Truck:GetBoxesInTruck()
	local boxes = {}
	local bottom = self.Object:FindFirstChild("Bottom")
	if bottom then
		for _,box in ipairs(workspace.AllSupplyBoxes:GetChildren()) do  -- set network ownership of all boxes inside truck
					
			local localPos = bottom.CFrame:pointToObjectSpace(box.Position)
			if box and box.Parent and not box.Anchored and math.abs(localPos.X) <= (bottom.Size.X/2)+4 and math.abs(localPos.Z) <= (bottom.Size.Z/2)+4 then
				table.insert(boxes,box)
			end
		end
		return boxes
	end
end




function Truck.new(spawnPosition,owner,carId)
	

	
	local this = {}
	setmetatable(this, Truck)
	this.Object = game.ServerStorage.Vehicles.Truck
	this.Object = this.Object:clone()
	local object = this.Object

	this.LightsOn = false
	this.SpawnPosition = spawnPosition
	this.LastSeated = tick()
	this.Deleted = false
	this.Type = "Truck"
	this.OriginalMaxSpeed = object.Driver.MaxSpeed  --gamepad driving make changes to these value and need to be reset when the player jumps out of the vehicle
	this.OriginalTurnSpeed = object.Driver.TurnSpeed

	


	this.TimeOfDayChange = game.ReplicatedStorage.GlobalData.TimeOfDay.Changed:connect(function() UpdateLights(this) end)
	UpdateLights(this)


	
	object.Parent = workspace.Trucks
	object:MakeJoints()
	Utility:WeldVehicle(object)
	Utility:EnableScripts(object)

	object:MoveTo(spawnPosition)
	
	
	
	local player = nil ---player that owns the boxes in the truck
	local owner_boxes = {} --collection of boxes the player owns
	local function PlayerSat(weld,Type)
		if weld.Name == "SeatWeld" then
			this.LastSeated = tick()

			if Type == "Added" then
				player = Utility:GetPlayerFromBodyPart(weld.Part1)
				if player then
					
					pcall(function() object.Driver:SetNetworkOwner(player) end)
					game.Workspace.Main.SittingInCar:FireClient(player,object,this.OriginalMaxSpeed,this.OriginalTurnSpeed)
					
					while player and not this.Deleted do

						for _,box in ipairs(workspace.AllSupplyBoxes:GetChildren()) do  -- set network ownership of all boxes inside truck
							
							local localPos = object.Bottom.CFrame:pointToObjectSpace(box.Position)
							if box and box.Parent and not box.Anchored and not owner_boxes[box] and math.abs(localPos.X) <= (object.Bottom.Size.X/2)+4 and math.abs(localPos.Z) <= (object.Bottom.Size.Z/2)+4 then
								box:SetNetworkOwner(player)
								owner_boxes[box] = true

							end
						end
						wait(1)
					end
				end
			elseif Type == "Removed" then
				if object.Driver.Position.Y < 2.45 and player and Players[player] and  Players[player].Settings.WaterEnabled then return end --dont give up physics to server or else the truck will fall though the water
				
				player = nil								

					
				pcall(function() object.Driver:SetNetworkOwnershipAuto() end)
				
					
				for k,v in pairs(owner_boxes) do
					if k and k.Parent and not k.Anchored then
						pcall(function() k:SetNetworkOwnershipAuto() end)
					end
				end
					
				owner_boxes = {}
				
			
			end
		end
	end
	
	this.WeldAdded = object.Driver.ChildAdded:connect(function(weld) PlayerSat(weld,"Added") end)
	this.WeldRemoved = object.Driver.ChildRemoved:connect(function(weld) PlayerSat(weld,"Removed") end)



	
	
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
				
				if object.Driver.Position.Y < 2.45 and not object.Driver.Occupant then
					Vehicles:Delete(object)
				
				elseif tick() - this.LastSeated > CAR_IDLE_TIME and not object.Driver.Occupant then
					Vehicles:Delete(object)
					
				elseif math.abs(object.LeftDoor.Position.y - object.RightDoor.Position.y) > 5 or object.Bumper.Position.y > object.Roof.Position.y then
					Vehicles:Delete(object)

				end
				
				wait(60)
			end
		end)
		
	
	end
	

	return this

end



return Truck




