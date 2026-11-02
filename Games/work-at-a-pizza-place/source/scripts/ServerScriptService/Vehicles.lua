local Enums = require(game.ReplicatedStorage:WaitForChild("Enums"))
if Enums.IsPartyServer then
	return false
end

local ServerScriptService = script.Parent
local Global = require(ServerScriptService:WaitForChild("Global"))
local Vehicles = Global.Vehicles
local Houses = Global.Houses
local Players = Global.Players
local Car = require(script:WaitForChild("Car"))
local Truck = require(script:WaitForChild("Truck"))
local Boat = require(script:WaitForChild("Boat"))
local Utility = require(game.ReplicatedStorage:WaitForChild("Utilities"):WaitForChild("Utility"))
local Dialog = require(game.ReplicatedStorage:WaitForChild("Dialog"))


Vehicles.AllVehicles = {}



function Vehicles:TurnOnLights()
	
end



--respawn the Truck that is being used the least for tutorial

function Vehicles:RespawnInactiveTruck() 
	
	--have to decide which truck to respawn
	--a hight score = less likely to respawn
	
	local function PointValue(truck)
		local truckData = Vehicles[truck]
		if truckData then
			local points = #truckData:GetBoxesInTruck() -- start out at #boxes as score
						
			if math.abs(truck.LeftDoor.Position.y - truck.RightDoor.Position.y) > 5 or truck.Bumper.Position.y > truck.Roof.Position.y then --if fliped over
				points = points - 600
			end
			
						
			if truck.Driver.Occupant then --if theres a driver
				points = points + 15
				
			elseif tick() - truckData.LastSeated < 60 then --if used in last 60 seconds
				points = points + 10
				
			elseif tick() - truckData.LastSeated > 60 then
				points = points - 10
			end
						
						
			if truck.Driver:FindFirstChild("TutorialPlayerOnly") then  --truck is being used by player in tutorial
				points = points + 100
			end
				
			return points	
		else
			
			error("Truck data dosent exist" .. 
				"Truck.Driver = " .. (function() local var pcall(function() var =     truck.Driver     end) return var end)() .. ", " ..
				"Truck = " .. (function() local var pcall(function() var =     truck     end) return var end)() .. ", " ..
				"Truck.Parent = " .. (function() local var pcall(function() var =     truck.Parent     end) return var end)() 
			)
		end	
	end
	
	
	
	local lowScore = 1000 
	local lowestTruck = nil
	for _,truck in ipairs(workspace.Trucks:GetChildren()) do
		local score = PointValue(truck)
		if score < lowScore then
			lowestTruck = truck
			lowScore = score
		end
	end
	
	
	return Vehicles:Delete(lowestTruck) --Delete returns the new truck
		
	
end




function workspace.Main.GetBoxesInTruck.OnServerInvoke(player,truck)
	if Vehicles[truck] and player then
		return Vehicles[truck]:GetBoxesInTruck()
	end
end


function Vehicles:GetVehicleDataByOwner(owner,Type)
	for _,vehicle in pairs(Vehicles.AllVehicles) do
		if vehicle.Type == Type and vehicle.Owner == owner then
			return vehicle
		end
	end
end


function Vehicles:PlayerLeaving(player)
	--delete car and boat when player leaves
	pcall(function() self:Delete(self:GetVehicleDataByOwner(player,"Car").Object) end)
	pcall(function() self:Delete(self:GetVehicleDataByOwner(player,"Boat").Object) end)
end





local debounce = false
function SpawnBoat(hit)
	if not debounce then
		debounce = true
		local player = Utility:GetPlayerFromBodyPart(hit)
		local playerData = Players[player]
		if player and playerData and playerData.GamePasses.PontoonBoat then
			if playerData.Settings.WaterEnabled then
				
				local boat = playerData.Boat
				if boat and (not boat.Object:FindFirstChild("Driver") or player:DistanceFromCharacter(boat.Object.Driver.Position) > 100) then
					Vehicles[boat.Object]:Delete()
					Vehicles[boat.Object] = nil
					boat = nil
				end
				
				if boat == nil then
					local boat = Boat.new(player)
					Vehicles[boat.Object] = boat
				end
				
			elseif not playerData.WaterEnabled then
				Dialog:ShowMessage(player,"Detailed Water","You must turn on detailed water to spawn your boat")
			end
		end
		wait(1)
		debounce = false
	end
end
workspace.Dock["Spawn Boat"].Head.Touched:connect(SpawnBoat)


	
function Vehicles:SpawnCarInGarage(carOwner,garageFloor)
	--delete existing car
	local existingCar = Vehicles:GetVehicleDataByOwner(carOwner,"Car")
	if existingCar then
		Vehicles:Delete(existingCar.Object)
	end
	
	local car = Car.new(garageFloor.Position,carOwner)
	Vehicles[car.Object] = car
end


function Vehicles:Initialize()
		
	local truck = Truck.new(workspace.TruckSpawn1.Position)
	Vehicles[truck.Object] = truck
	
	local truck2 = Truck.new(workspace.TruckSpawn2.Position)
	Vehicles[truck2.Object] = truck2
	
	spawn(function() 
		for _,spot in ipairs(workspace.ParkingSpots:GetChildren()) do
			wait(1)
			local car = Car.new(spot.Position)
			Vehicles[car.Object] = car
		end
	end)

end



function Vehicles:Delete(object)
	local vehicleData = Vehicles[object]
	if not vehicleData.Deleted then
		if vehicleData.Type == "Car" then
			if vehicleData.IsWorkCar then
				local carPosition = vehicleData.SpawnPosition
				Vehicles[object]:Delete()
				Vehicles[object] = nil
				local car = Car.new(carPosition) --replace existing car data with new car
				Vehicles[car.Object] = car
			else
				Vehicles[object]:Delete()
				Vehicles[object] = nil
			end
		
		
		elseif vehicleData.Type == "Truck" then
			local truckPosition = vehicleData.SpawnPosition
			Vehicles[object]:Delete()
			Vehicles[object] = nil
			local truck = Truck.new(truckPosition)
			Vehicles[truck.Object] = truck
			return truck.Object
		end
	end
end

local channel = game.ReplicatedStorage.Channels:WaitForChild("VehicleChannel")


function Recieve(player,action,...)
	print("received",action,player,...)	local args = {...}
	local playerData = Players[player] --player is in args on binable event
	
	if action == "Paint" and playerData then
		
		local part = args[1]
		local color = args[2]
		if part and part.Parent then
			local vehicleData = Vehicles[part.Parent]
			if vehicleData and (vehicleData.IsWorkCar or vehicleData.Owner == player) then
				Players[player].Car_Colors[part.Name] = color
				vehicleData:SetColor(part.Name,color)
			end
		end
	end
end


channel.OnServerEvent:connect(function(player,action,...)
	local response1,response2,response3 = Recieve(player,action,...)
	if response1 then
		channel:FireClient(player,action,response1,response2,response3)
	end
end)


setmetatable(Vehicles, {
	__index = Vehicles.AllVehicles,
	__newindex = Vehicles.AllVehicles
})



return Vehicles