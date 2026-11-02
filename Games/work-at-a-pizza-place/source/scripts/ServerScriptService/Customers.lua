local Enums = require(game.ReplicatedStorage:WaitForChild("Enums"))
if Enums.IsPartyServer then
	return false
end

local ServerScriptService = script.Parent
local Global = require(ServerScriptService:WaitForChild("Global"))
local Players = Global.Players
local Customers = Global.Customers
local Environment = Global.Environment
local Customer = require(script:WaitForChild("Customer"))




Customers.AllCustomers = {}
Customers.SpawnRate = 5--60--25 --median one every 10 seconds
Customers.SpawnVariance = 5 --seconds
Customers.SpawnDriveThroughRate = 60 --seconds
Customers.DriveThroughVariance = 20

Customers.Orders = nil

Customers.Outfits = {}


function Customers:AddOutfit(player)

	local con
	con = player.CharacterAdded:connect(function(character)
		con:disconnect()
		wait(4)--wait(7) -- wait for everything to load
		if player == nil or player.Character == nil or not Players[player] or not Players[player].House then return end
		player.Character:WaitForChild("Head",10)
		player.Character:WaitForChild("HumanoidRootPart",10)
		
		if string.sub(player.Name,1,5) ~= "Guest" then--if not Player:IsGuest() then
			local AIclone = nil
			--clear the appreance of the clone au
			for i,guy in ipairs(Players[player].House.Object:GetChildren()) do
				if guy:FindFirstChild("Player") ~= nil then
					for i,v in ipairs(guy:GetChildren()) do
						if v:IsA("Accessory") or v:IsA("Hat") or v:IsA("CharacterMesh") or v:IsA("Pants")  or v:IsA("Shirt") and v.Name ~="Uniform" then
							v:Destroy()
						end
					end
					if guy.Head:FindFirstChild("face") ~= nil then
						guy.Head.face:Destroy()
					end
					AIclone = guy
				end
			end
			if AIclone == nil then return end
		
			local playerClone = game.ServerStorage.Customers.CustomerTemplate:clone()
			playerClone.Parent = game.ServerStorage.Customers.PlayerModelStorage
			
	
			local function CopyColors(clone)
				if string.sub(player.Name,1,6) ~= "Player" then
					local playerColors = player.Character:FindFirstChild("Body Colors") or Instance.new("BodyColors",player.Character)
					clone.Head.BrickColor = playerColors.HeadColor
					clone["Right Arm"].BrickColor = playerColors.RightArmColor
					clone["Left Leg"].BrickColor = playerColors.LeftLegColor
					clone["Left Arm"].BrickColor = playerColors.LeftArmColor
					clone["Right Leg"].BrickColor = playerColors.RightLegColor
					clone["Torso"].BrickColor = playerColors.TorsoColor
				end
			end
			CopyColors(AIclone)
			CopyColors(playerClone)
				
				
			local function CopyAssets(dir)
				for i,v in ipairs(dir:GetChildren()) do
					if ((v:IsA("Accessory") or v:IsA("Hat")) and v.Name ~= "ChefHat" and v.Name ~= "Visor") or v:IsA("CharacterMesh") or (v:IsA("Pants") and v.Name ~= "BusinessSkirt") or (v:IsA("Shirt") and v.Name ~="Uniform") then
						v:clone().Parent = playerClone
						v:clone().Parent = AIclone
					end
				end
			end
			CopyAssets(character.Head)
			CopyAssets(character)


			if character.Head:FindFirstChild("face") then 
				character.Head.face:clone().Parent = AIclone.Head 
				character.Head.face:clone().Parent = playerClone.Head 
			end
			
			table.insert(self.Outfits,1,playerClone)
			
			if #self.Outfits >= 25 then
				self.Outfits[#self.Outfits]:Destroy()
				table.remove(self.Outfits,#Customers.Outfits)
			end
			
		end
	end)
end


function Customers:FindOpenSeat()
	
	math.randomseed(math.floor((tick()-math.floor(tick()))*10000))
	math.random()
	
	local unoccupied = {} 
	for _,chair in ipairs(workspace.Seating:GetChildren()) do
		for _,part in ipairs(chair:GetChildren()) do
			if part:IsA("Seat") and not part.Occupant then
				local occupied = false
				for customer,data in pairs(self.AllCustomers) do --make sure no other customers are about to sit there
					if data.Seat == part then
						occupied = true
					end
				end
				if not occupied then
					table.insert(unoccupied,part)
				end
			end
		end
	end
	if #unoccupied  ~= 0 then
		return unoccupied[math.random(1,#unoccupied)]
	end
end


--[[function Customer:GetOpenLane()
	local lanes = {Enums.Lanes.Right,false,false}
	for _,customer in ipairs(self.AllCustomers) do
		if (customer.State == Enums.CustomerStates.WaitingForCashier or customer.State == Enums.CustomerStates.WalkingToEntrance) then
			if customer.Lane == Enums.Lanes.Right then
				lanes[1] = true
			elseif customer.Lane == Enums.Lanes.Left then
				lanes[2] = true
			elseif customer.Lane == Enums.Lanes.DriveThrough then
				lanes[3] = true
			end
		end	
	end
	for _,lane in ipairs(lane) do
		if not lane then
	end
end]]


function PlayerInDriveThrough()
	local areaBlock = workspace.CustomerBlock2
	for _,player in ipairs(game.Players:GetPlayers()) do
		if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
			local sizeX = areaBlock.Size.X
			local sizeZ = areaBlock.Size.Z
			local positionX = areaBlock.Position.X
			local positionZ = areaBlock.Position.Z
			local torsoPos = player.Character.HumanoidRootPart.Position
			
			if torsoPos.x > positionX - (sizeX/2) then
			if torsoPos.x < positionX + (sizeX/2) then
			if torsoPos.z > positionZ - (sizeZ/2) then
			if torsoPos.z < positionZ + (sizeZ/2) then
				return true
			end
			end
			end
			end
		end
	end
	return false
end



local LanesOccupied = {
	Right = false,
	Left = false,
	DriveThrough = false
}

local Lanes = {"Right","Left","DriveThrough"}

local parkingLot = workspace.CustomerParking
local spots = {parkingLot.Spot1, parkingLot.Spot2,parkingLot.Spot3,parkingLot.Spot4,parkingLot.Spot5,parkingLot.Spot6,parkingLot.Spot7,parkingLot.Spot8}

local ParkingSpotsOccupied = {}
for _,spot in ipairs(spots) do ParkingSpotsOccupied[spot] = false end

function Customers:UnoccupyLane(laneName) --when customer goes to sit down
	LanesOccupied[laneName] = false
end



function Customers:Initialize(orders)
	

	Customers.Orders =  orders
	
	local function FindParkingSpot()
		for _,spot in pairs(spots) do
			if not ParkingSpotsOccupied[spot] then
				return spot
			end
		end
	end
	
	workspace.Houses:WaitForChild("House1",20) --wait for hosues to load
	wait()
	local houses = workspace.Houses:GetChildren()
	
	local function SpawnCustomerLane(lane,intervalMin,intervalMax)
		spawn(function()
			local currentCustomer = nil
			while true do
				
				--wait for interation to finish before starting countdown for a new customer
				while currentCustomer and currentCustomer.Model and currentCustomer.Model.Parent and (currentCustomer.State ~= Enums.CustomerStates.Leaving and currentCustomer.State ~= Enums.CustomerStates.SittingAtTable) do
					wait(1)
				end
				
				--slow down customer rate at night
				local isNight = Environment.TimeOfDay == "Night"
				local muliplier = (isNight and 2) or 1 --high number = slower
			
				
				if lane == "DriveThrough" then
					wait(math.random(self.SpawnDriveThroughRate - self.DriveThroughVariance, self.SpawnDriveThroughRate + self.DriveThroughVariance) * muliplier)
				else
					wait(math.random(self.SpawnRate - self.SpawnVariance, self.SpawnRate + self.SpawnVariance) * muliplier)
				end
				
				if lane and not LanesOccupied[lane] then
					
					local parkingSpot = FindParkingSpot()
					if (lane ~= "DriveThrough" and parkingSpot) 
					or (lane == "DriveThrough" and not PlayerInDriveThrough()) then
						

						local order = {}
						order.Order = math.random(1,4)
						order.House = houses[math.random(1,#houses)]
						order.Phase = 1
						table.insert(orders,order)
						
						LanesOccupied[lane] = true
						if parkingSpot then ParkingSpotsOccupied[parkingSpot] = true end
						
						currentCustomer = Customer.new(self,order,lane,parkingSpot)
						order.Object = currentCustomer.Model
						spawn(function()
							currentCustomer:StartPathFinding()
						end)
							
						table.insert(self.AllCustomers,currentCustomer)
					
					end
				end
			end
		end)
	end
	spawn(function()
		while #self.Outfits == 0 do wait(.1) end
		--start a thread for each lane
		SpawnCustomerLane("Right")
		wait(self.SpawnRate)
		SpawnCustomerLane("Left")
		wait(1)
		SpawnCustomerLane("DriveThrough")
	end)
end


		
function Customers:delete(customer)
	for i,cus in ipairs(self.AllCustomers) do
		if cus == customer then
			if customer.Model then
				customer.Model:Destroy()
			end
			
			if customer.Car then
				customer.Car:Destroy()
			end
			
			if customer.OccupyingLane then
				LanesOccupied[customer.Lane] = false
			end
			
			if customer.ParkingSpot then
				ParkingSpotsOccupied[customer.ParkingSpot] = false
			end
			
			customer.Deleted = true

			table.remove(self.AllCustomers,i)
		end
	end
end





setmetatable(Customers,{
	__index = function(object,key)
		for i,customerData in ipairs(rawget(Customers,"AllCustomers")) do
			local model = rawget(customerData,"Model")
			if model == key then
				return customerData
			end
		end
	end
})



return Customers
	

