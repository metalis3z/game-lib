local data = require(game.ServerScriptService.ProfileCache)
local alphabet = {}
local process = {}
local debounce = {}
local licenses = {}

for i=97, 122 do
	local char = utf8.char(i)
	table.insert(alphabet, char)
end

local function GetDistance(p1,p2)
	local Distance = (p1.Position - p2.Position).magnitude
	return Distance
end

_G.hookLicenseRemove = function(license)
	if license then
		licenses[license] = nil
		print("REMOVED A LICENSE")
	end
end

_G.hookCarRemove = function(car,player)
	spawn(function() 
		local license = car:FindFirstChild("Body"):FindFirstChild("Plate"):FindFirstChild("SurfaceGui"):FindFirstChild("Frame"):FindFirstChild("TextLabel").Text
		_G.hookLicenseRemove(license) 
	end)

	local carOwner = player
	if not carOwner or not player then
		carOwner = game.Players:FindFirstChild(car:FindFirstChild("Owner").Value)
	end
	
	if carOwner then
		if data[carOwner] and data[carOwner].Data then
			local urdata = data[carOwner].Data
			if urdata.ownedCars[car.Name] then
				print("saving fuel")
				urdata.ownedCars[car.Name]["Fuel"] = car.FUEL.Value
			else
				print("wat")
			end
		end	
		wait()
	else
		print("no car owner")
	end
	car:Destroy()
end

_G.checkCarOwnership = function(player,carName)
	
	local urdata = data[player].Data
	if urdata.ownedCars[carName] then
		return true
	else
		return false
	end
	
end

_G.getCarInfo = function(player,carName)
	
	local urdata = data[player].Data
	if urdata.ownedCars[carName] then
		return urdata.ownedCars[carName]
	else
		return nil
	end
	
end

function isCarSpawned(player)
	
	local ret = false	
	for i,v in pairs(game.Workspace.CivCars:GetChildren()) do
		if v.Owner.Value == player.Name then
			ret = true
		end
	end
	
	wait()
	return ret
end

function getSpawnedCar(player)

	local ret = nil	
	for i,v in pairs(game.Workspace.CivCars:GetChildren()) do
		if v.Owner.Value == player.Name then
			ret = v
		end
	end

	wait()
	return ret
end

_G.getLicenses = function()
	return licenses
end

_G.getLicenseInfo = function(officer,plate)
	print("called")
	if licenses[plate] then
		-- report to radio
		-- returns ["Car"] and ["Player"] and ["Stolen"]
		print("LP")
		return licenses[plate]
	else
		return nil
	end
	
end

local checkOccupied = function(player)
	
	local theirCar = getSpawnedCar(player)
	if theirCar then
		if theirCar.DriveSeat.Occupant ~= nil and game.Players:GetPlayerFromCharacter(theirCar.DriveSeat.Occupant.Parent) then
			return true
		else
			return false
		end
	else
		return false
	end
	
end

_G.reportStolen = function(player)
	print("got stolen report")
	local getCar = getSpawnedCar(player)
	if getCar then
		local plate = getCar:FindFirstChild("Body"):FindFirstChild("Plate"):FindFirstChild("SurfaceGui"):FindFirstChild("Frame"):FindFirstChild("TextLabel").Text
		
		print("checking")
		
		if plate and licenses[plate] then
			print("checked")
			licenses[plate]["Stolen"] = true
			return game.ReplicatedStorage.server:FireClient(player,"msg","Car has been reported stolen.")
		end
	else
		print("no car is spawned currently")
	end
end

_G.spawnCar = function(player,carName)
	
	if GetDistance(player.Character.PrimaryPart,game.Workspace.CARDealerP) > 10 then
		game.ReplicatedStorage.server:FireClient(player,"alert","Too far from Dealer!")
		return "toofar"
	end
	
	if process[player] then return "processing" end
	if debounce[player] then return "db" end
	
	debounce[player] = true
	process[player] = true
	local completed = false
	
	delay(2,function()
		debounce[player] = nil
		print("db removed")
	end)
	delay(2,function()
		if process[player] and completed ~= true then
			process[player] = nil
			completed = true
		end
	end)
	
	if isCarSpawned(player) == true then
		local cO = checkOccupied(player)
		if cO == false then
			print("REMOVING")
			_G.hookCarRemove(getSpawnedCar(player),player)
		else
			print("OCCUPIED")
			process[player] = nil
			return "occ"
		end
	end
	repeat wait(0.1) until isCarSpawned(player) == false
	
	local urdata = data[player].Data
	if urdata.ownedCars[carName] then
		print("spawn")
		local clon = game.ServerStorage.Cars:FindFirstChild(carName):Clone()
		clon.Parent = game.Workspace.CivCars
		clon.FUEL.Value = urdata.ownedCars[carName]["Fuel"]
		clon.Owner.Value = player.Name
		
		if clon.FUEL.Value == 0 then
			clon.FUEL.Value = 0.8
		end
		
		local license = string.upper(alphabet[math.random(1, #alphabet)]..alphabet[math.random(1, #alphabet)]..alphabet[math.random(1, #alphabet)].."-"..alphabet[math.random(1, #alphabet)]..alphabet[math.random(1, #alphabet)]..alphabet[math.random(1, #alphabet)])
		licenses[license] = {
			["Car"] = clon,
			["Player"] = player,
			["Stolen"] = false
		}
		
		clon:FindFirstChild("Body"):FindFirstChild("Plate"):FindFirstChild("SurfaceGui"):FindFirstChild("Frame"):FindFirstChild("TextLabel").Text = license
		
		wait(0.3)
		local sel = math.random(1,7)
		print("SELECTED "..sel)
		clon:MoveTo(game.Workspace:FindFirstChild("CarDealer"..sel).Position)
		wait(0.3)
		clon.DriveSeat:Sit(player.Character.Humanoid)
	else
		print("doesn't own :skull:")
	end
	process[player] = nil
	completed = true
	return "end"
end

_G.hookCarBuy = function(player,carName)
	
	local urdata = data[player].Data
	if urdata.ownedCars[carName] then
		return game.ReplicatedStorage.server:FireClient(player,"alert","You already own that car!")
	end
	
	urdata.ownedCars[carName] = {
		["Fuel"] = 10,
		["Miles"] = 0,
		["Settings"] = {},
		["EXTRA"] = nil
	}
	game.ReplicatedStorage.server:FireClient(player,"money",carName.. " Purchased!")
	
end

game.Players.PlayerRemoving:Connect(function(player)
	
	for i,v in pairs(game.Workspace.CivCars:GetChildren()) do
		if v:FindFirstChild("DriveSeat") and v:FindFirstChild("Owner").Value == player.Name then
			print("starting remove on this car")
			local DS = v:FindFirstChild("DriveSeat")
			local seats = {DS}
			for ind1,seat in pairs(v:FindFirstChild("Body"):GetChildren()) do
				if seat:IsA("Seat") or seat:IsA("VehicleSeat") then
					table.insert(seats,seat)
				end
			end
			
			for ind2,partSeat in pairs(seats) do
				if partSeat.Occupant ~= nil then
					partSeat.Occupant.Jump = true
					repeat wait() until partSeat.Occupant == nil
				end
				partSeat:Destroy()
			end
			_G.hookCarRemove(v,player)
			print("lol")
		end
	end
	
end)

game.Players.PlayerAdded:Connect(function(p)
	p.Chatted:Connect(function(msg)
		if msg:lower() == "/lock" then
			local car = getSpawnedCar(p)
			if car then
				local action = "lock"
				
				if car.DriveSeat:FindFirstChild("Locked") then
					action = "unlock"
				end
				
				local cO = checkOccupied(p)
				if cO then
					return game.ReplicatedStorage.server:FireClient(p,"alert","Someone is already using your car!")
				end

				if GetDistance(p.Character.PrimaryPart, car.DriveSeat) > 15 or p.Character.Humanoid.Health == 0 then
					return game.ReplicatedStorage.server:FireClient(p,"alert","You are too far from your car!")
				end

				local carSound = script.CarLock:Clone()
				carSound.Parent = car.DriveSeat
				carSound:Play()

				game.Debris:AddItem(carSound, carSound.TimeLength)

				if action == "lock" then
					local lockValue = Instance.new("BoolValue",car.DriveSeat)
					lockValue.Name = "Locked"
					lockValue.Value = true
					car.DriveSeat.Disabled = true
				elseif action == "unlock" then
					car.DriveSeat:FindFirstChild("Locked"):Destroy()
					car.DriveSeat.Disabled = false
				end	

				game.ReplicatedStorage.server:FireClient(p,"msg","Car has been "..action.."ed")
			else
				game.ReplicatedStorage.server:FireClient(p,"alert","You do not have a car spawned!")
			end
		end
	end)
end)