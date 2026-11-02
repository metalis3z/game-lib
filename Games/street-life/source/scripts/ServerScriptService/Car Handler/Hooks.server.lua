local data = require(game.ServerScriptService.ProfileCache)
local alphabet = {}
local process = {}
local debounce = {}
local licenses = {}

local Notify = game:FindService('ReplicatedStorage'):FindFirstChild('Notify')

for i = 97, 122 do
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
	end
end

_G.hookCarRemove = function(car,player)
	local carOwner = player
	if not carOwner or not player then
		carOwner = game.Players:FindFirstChild(car:FindFirstChild("Owner").Value)
	end

	if carOwner then
		local urdata = data[carOwner].Data
		if urdata.ownedCars[car:FindFirstChild('CarType').Value] then
			for _,v in next, car:GetChildren() do
				if v.Name == 'FUEL' then
					urdata.ownedCars[car:FindFirstChild('CarType').Value]["Fuel"] = v.Value
				end
			end
		end
	end	
	task.spawn(function()
		if car:FindFirstChildOfClass('VehicleSeat') then
			if car:FindFirstChildOfClass('VehicleSeat').Occupant ~= nil then
				car:FindFirstChildOfClass('VehicleSeat').Occupant.Jump = true
			end
		end
	end)
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
	if licenses[plate] then
		-- report to radio
		-- returns ["Car"] and ["Player"] and ["Stolen"]
		return licenses[plate]
	else
		return nil
	end

end

local checkOccupied = function(player)

	local theirCar = getSpawnedCar(player)
	if theirCar then
		if theirCar:FindFirstChildOfClass('DriveSeat') then
			if theirCar:FindFirstChildOfClass('DriveSeat').Occupant ~= nil and game.Players:GetPlayerFromCharacter(theirCar:FindFirstChildOfClass('DriveSeat').Occupant.Parent) then
				return true
			else
				return false
			end
		else
			return false
		end
	else
		return false
	end

end

_G.reportStolen = function(player)
	local getCar = getSpawnedCar(player)
	if getCar then
		local plate = getCar:FindFirstChild("Body"):FindFirstChild("Plate"):FindFirstChild("SurfaceGui"):FindFirstChild("Frame"):FindFirstChild("TextLabel").Text


		if plate and licenses[plate] then
			licenses[plate]["Stolen"] = true
			return Notify:FireClient(player, "Car has been reported stolen.", 3)
		end
	end
end

_G.spawnCar = function(player,carName, extra)
	if not game.ServerStorage.Cars:FindFirstChild(carName) then return end

	if process[player] then return "processing" end
	if debounce[player] then return "db" end

	debounce[player] = true
	process[player] = true
	local completed = false

	delay(2,function()
		debounce[player] = nil
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
			_G.hookCarRemove(getSpawnedCar(player),player)
		else
			process[player] = nil
			return "occ"
		end
	end
	repeat wait(0.1) until isCarSpawned(player) == false
	local urdata = data[player].Data
	if urdata.ownedCars[carName] or carName == 'PDCar' or carName == 'PDCar2' then
		local clon = game.ServerStorage.Cars:FindFirstChild(carName):Clone()

		if carName ~= 'PDCar' and carName ~= 'PDCar2' and carName ~= 'Scooter' then
			clon.FUEL.Value = urdata.ownedCars[carName]["Fuel"]
		end
		clon.Owner.Value = player.Name

		if clon.FUEL.Value == 0 then
			clon.FUEL.Value = 0.5
		end

		local license = string.upper(alphabet[math.random(1, #alphabet)]..alphabet[math.random(1, #alphabet)]..alphabet[math.random(1, #alphabet)].."-"..alphabet[math.random(1, #alphabet)]..alphabet[math.random(1, #alphabet)]..alphabet[math.random(1, #alphabet)])
		licenses[license] = {
			["Car"] = clon,
			["Player"] = player,
			["Stolen"] = false
		}

		if clon:FindFirstChild('Body') then
			if clon.Body:FindFirstChild('Plate') then
				if clon.Body.Plate:FindFirstChild('SurfaceGui') then
					clon:FindFirstChild("Body"):FindFirstChild("Plate"):FindFirstChild("SurfaceGui"):FindFirstChild("Frame"):FindFirstChild("TextLabel").Text = license
				end
			end
		end

		if carName ~= 'PDCar' and carName ~= 'PDCar2' then
			if not urdata.ownedCars[carName]["EXTRA2"] then
				urdata.ownedCars[carName]["EXTRA2"] = 'nil'
			end

			if not urdata.ownedCars[carName]['EXTRA'] or urdata.ownedCars[carName]['EXTRA'] == nil then
				urdata.ownedCars[carName]['EXTRA'] = 'White'
			end
			if clon:FindFirstChild('Body') then
				if clon.Body:FindFirstChild('CHANGE') then
					for _,v in next, clon.Body:FindFirstChild('CHANGE'):GetChildren() do
						if v:IsA('MeshPart') or v:IsA('Part') then
							v.BrickColor = BrickColor.new(urdata.ownedCars[carName]['EXTRA'])
						end
					end
				end
			end
			
			if urdata.ownedCars[carName]["EXTRA2"] ~= 'nil' and carName ~= 'DirtBike' then
				if clon:FindFirstChild('Body') then
					if clon.Body:FindFirstChild('Underglow') then
						for _,v in next, clon.Body:FindFirstChild('Underglow'):GetChildren() do
							if v.Name == 'Neon' then
								v:FindFirstChild('PointLight').Color = BrickColor.new(urdata.ownedCars[carName]['EXTRA2']).Color
								v:FindFirstChild('PointLight').Enabled = true
							end
						end
					end
				end
			else
				if clon:FindFirstChild('Body') then
					if clon.Body:FindFirstChild('Underglow') then
						for _,v in next, clon.Body:FindFirstChild('Underglow'):GetChildren() do
							if v.Name == 'Neon' then
								v:FindFirstChild('PointLight').Enabled = false
							end
						end
					end
				end
			end
			
			if not urdata.ownedCars[carName]["EXTRA3"] then
				urdata.ownedCars[carName]["EXTRA3"] = 'None'
			end
			if urdata.ownedCars[carName]["EXTRA3"] and carName ~= 'DirtBike' then
				if clon:FindFirstChild('Body') then
					if clon.Body:FindFirstChild('Windows') then
						for _,v in next, clon.Body:FindFirstChild('Windows'):GetChildren() do
							if urdata.ownedCars[carName]["EXTRA3"] == 'None' then
								v.Transparency = .9
							elseif urdata.ownedCars[carName]["EXTRA3"] == 'Light Smoke' then
								v.Transparency = .7
							elseif urdata.ownedCars[carName]["EXTRA3"] == 'Medium Smoke' then
								v.Transparency = .5
							elseif urdata.ownedCars[carName]["EXTRA3"] == 'Dark Smoke' then
								v.Transparency = .3
							elseif urdata.ownedCars[carName]["EXTRA3"] == 'Limo' then
								v.Transparency = 0
							end
						end
					end
				end
			end
		end

		clon:WaitForChild('Owner').Value = tostring(player.Name)
		if clon.Name == 'Scooter' then
			clon:WaitForChild('DriveSeat'):FindFirstChild('Sit').ActionText =  tostring(player.Name) .. "'s Scooter"
		elseif clon.Name == 'DirtBike' then
			clon:WaitForChild('DriveSeat'):FindFirstChild('Sit').ActionText =  tostring(player.Name) .. "'s Bike"
		else
			clon:WaitForChild('DriveSeat'):FindFirstChild('Sit').ActionText =  tostring(player.Name) .. "'s Car"
		end
		clon.Name = tostring(player.Name) .. "'s Car"
		wait(0.3)
		local sel = math.random(1, 4)
		clon.Parent = game.Workspace.CivCars
		clon.Name = tostring(player.Name) .. "'s Car"
		if extra then
			if extra == true then
				task.spawn(function() clon:SetPrimaryPartCFrame(CFrame.new(player.Character.PrimaryPart.Position) + Vector3.new(3, 5, 0)) end)
			end
		end
	end
	process[player] = nil
	completed = true
	return
end

_G.RentScooter = function(player, carName, extra)
	if not game.ServerStorage.Cars:FindFirstChild(carName) then return end
	if carName ~= 'Scooter' then return end

	if process[player] then return "processing" end
	if debounce[player] then return "db" end

	debounce[player] = true
	process[player] = true
	local completed = false

	delay(2,function()
		debounce[player] = nil
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
			_G.hookCarRemove(getSpawnedCar(player),player)
		else
			process[player] = nil
			return "occ"
		end
	end
	repeat wait(0.1) until isCarSpawned(player) == false
	local clon = game.ServerStorage.Cars:FindFirstChild(carName):Clone()
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

	clon:WaitForChild('Owner').Value = tostring(player.Name)
	if clon.Name == 'Scooter' then
		clon:WaitForChild('DriveSeat'):FindFirstChild('Sit').ActionText =  tostring(player.Name) .. "'s Scooter"
	elseif clon.Name == 'DirtBike' then
		clon:WaitForChild('DriveSeat'):FindFirstChild('Sit').ActionText =  tostring(player.Name) .. "'s Bike"
	else
		clon:WaitForChild('DriveSeat'):FindFirstChild('Sit').ActionText =  tostring(player.Name) .. "'s Car"
	end
	clon.Name = tostring(player.Name) .. "'s Car"
	wait(0.3)
	clon.Parent = game.Workspace.CivCars
	clon.Name = tostring(player.Name) .. "'s Car"
	if extra then
		if extra == true then
			task.spawn(function() clon:SetPrimaryPartCFrame(CFrame.new(player.Character.PrimaryPart.Position) + Vector3.new(math.random(-8, -6), 3, 0)) end)
		end
	end
	process[player] = nil
	completed = true
	task.wait(1)
	clon:WaitForChild('DriveSeat'):Sit(player.Character:FindFirstChild('Humanoid'))
	return
end

_G.hookCarBuy = function(player,carName)
	if not game.ServerStorage.Cars:FindFirstChild(carName) then return end
	local Price = game.ServerStorage.Cars:FindFirstChild(carName):FindFirstChild('Price')
	local Level = game.ServerStorage.Cars:FindFirstChild(carName):FindFirstChild('Level')
	local Wallet = player:FindFirstChild('stored').Money
	local PlayerLevel = player:FindFirstChild('stored').Level
	if PlayerLevel.Value < Level.Value then return end 

	if Wallet.Value >= Price.Value then
		local urdata = data[player].Data
		if urdata.ownedCars[carName] then return end
		if (carName == 'M2' or carName == 'Urus') and not game:FindFirstChild('MarketplaceService'):UserOwnsGamePassAsync(player.UserId, 834486805) then return end
		if not game:FindService('BadgeService'):UserHasBadgeAsync(player.UserId, 2859466878069576) then
			game:FindService('BadgeService'):AwardBadge(player.UserId, 2859466878069576)
		end
		Wallet.Value -= Price.Value
		urdata.ownedCars[carName] = {
			["Fuel"] = 10,
			["Miles"] = 0,
			["Settings"] = {},
			["EXTRA"] = 'Institutional White',
			["EXTRA2"] = 'nil',
			["EXTRA3"] = "None"
		}
		game.ReplicatedStorage.server:FireClient(player,"money", Price.Value)
	end
end

local Colors = {
	"Bright red",
	"Bright orange",
	"Bright yellow",
	"Bright green",
	"Bright blue",
	"Dark indigo",
	"Royal purple",
	"Black",
	"White",
	"Dark stone grey",
	"Cool yellow",
	"Hot pink",
	"Really black",
	"Teal",
	"Earth green",
	'nil'
}

_G.HookCarExtra = function(player, car, color)
	if not game.ServerStorage.Cars:FindFirstChild(car) then return end
	if not workspace.CivCars:FindFirstChild(player.Name .. "'s Car") then return end
	if not table.find(Colors, color) then return end
	local Wallet = player:FindFirstChild('stored').Money
	local urdata = data[player].Data
	if not urdata.ownedCars[car] or urdata.ownedCars[car]['EXTRA'] == color then return end

	if Wallet.Value >= 2000 then
		Wallet.Value -= 2000
		urdata.ownedCars[car]['EXTRA'] = color
		for _,v in next, workspace.CivCars:FindFirstChild(player.Name .. "'s Car"):FindFirstChild('Body'):FindFirstChild('CHANGE'):GetChildren() do
			if v:IsA('MeshPart') or v:IsA('Part') then
				v.BrickColor = BrickColor.new(urdata.ownedCars[car]['EXTRA'])
			end
		end
		game.ReplicatedStorage.server:FireClient(player, "money", 2000)
	end
end

_G.HookCarExtra2 = function(player, car, color)
	if not game.ServerStorage.Cars:FindFirstChild(car) then return end
	if not workspace.CivCars:FindFirstChild(player.Name .. "'s Car") then return end
	if not table.find(Colors, color) then return end
	local Wallet = player:FindFirstChild('stored').Money
	local urdata = data[player].Data
	if not urdata.ownedCars[car] or urdata.ownedCars[car]['EXTRA2'] == color then return end

	if Wallet.Value >= 1000 or color == 'nil' then
		if color ~= 'nil' then
			Wallet.Value -= 1000
		end
		urdata.ownedCars[car]['EXTRA2'] = color
		if urdata.ownedCars[car]["EXTRA2"] ~= 'nil' then
			for _,v in next, workspace.CivCars:FindFirstChild(player.Name .. "'s Car"):FindFirstChild('Body'):FindFirstChild('Underglow'):GetChildren() do
				if v.Name == 'Neon' then
					v:FindFirstChild('PointLight').Color = BrickColor.new(urdata.ownedCars[car]['EXTRA2']).Color
					v:FindFirstChild('PointLight').Enabled = true
				end
			end
		else
			for _,v in next, workspace.CivCars:FindFirstChild(player.Name .. "'s Car"):FindFirstChild('Body'):FindFirstChild('Underglow'):GetChildren() do
				if v.Name == 'Neon' then
					v:FindFirstChild('PointLight').Enabled = false
				end
			end
		end
		if color ~= 'nil' then
			game.ReplicatedStorage.server:FireClient(player, "money", 1000)
		end
	end
end

local Tints = {
	"None",
	"Light Smoke",
	"Medium Smoke",
	"Dark Smoke",
	"Limo"
}

_G.HookCarExtra3 = function(player, car, color)
	if not game.ServerStorage.Cars:FindFirstChild(car) then return end
	if not workspace.CivCars:FindFirstChild(player.Name .. "'s Car") then return end
	if not table.find(Tints, color) then return end
	local Wallet = player:FindFirstChild('stored').Money
	local urdata = data[player].Data
	if not urdata.ownedCars[car] or urdata.ownedCars[car]['EXTRA3'] == color then return end

	if Wallet.Value >= 1000 or color == 'nil' then
		Wallet.Value -= 1000
		urdata.ownedCars[car]['EXTRA3'] = color
		if urdata.ownedCars[car]["EXTRA3"] then
			for _,v in next, workspace.CivCars:FindFirstChild(player.Name .. "'s Car"):FindFirstChild('Body'):FindFirstChild('Windows'):GetChildren() do
				if urdata.ownedCars[car]["EXTRA3"] == 'None' then
					v.Transparency = .9
				elseif urdata.ownedCars[car]["EXTRA3"] == 'Light Smoke' then
					v.Transparency = .7
				elseif urdata.ownedCars[car]["EXTRA3"] == 'Medium Smoke' then
					v.Transparency = .5
				elseif urdata.ownedCars[car]["EXTRA3"] == 'Dark Smoke' then
					v.Transparency = .3
				elseif urdata.ownedCars[car]["EXTRA3"] == 'Limo' then
					v.Transparency = 0
				end
			end
		end
		game.ReplicatedStorage.server:FireClient(player, "money", 1000)
	end
end

game.Players.PlayerRemoving:Connect(function(player)
	for i,v in pairs(game.Workspace.CivCars:GetChildren()) do
		if v:FindFirstChild("DriveSeat") and v:FindFirstChild("Owner").Value == player.Name then
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
			_G.hookCarRemove(v, player)
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
					return Notify:FireClient(p, "Car is already locked.", 3)
				end

				local cO = checkOccupied(p)
				if cO then
					return Notify:FireClient(p, "Someone is using your car", 3)
				end

				if GetDistance(p.Character.PrimaryPart, car.DriveSeat) > 15 or p.Character.Humanoid.Health == 0 then
					return Notify:FireClient(p, "You are too far from your car", 3)
				end

				local carSound = script.CarLock:Clone()
				carSound.Parent = car.DriveSeat
				carSound:Play()

				game.Debris:AddItem(carSound, carSound.TimeLength)

				if action == "lock" then
					local lockValue = Instance.new("BoolValue")
					lockValue.Name = "Locked"
					lockValue.Value = true
					lockValue.Parent = car.DriveSeat
				elseif action == "unlock" then
					car.DriveSeat:FindFirstChild("Locked"):Destroy()
				end	
				
				for _,v in next, car.Body:GetChildren() do
					if v:IsA('VehicleSeat') or v:IsA('Seat') then
						if v:FindFirstChildOfClass('ProximityPrompt') and v.Occupant == nil then
							local lockValue = Instance.new("BoolValue")
							lockValue.Name = "Locked"
							lockValue.Value = true
							lockValue.Parent = v
						end
					end
				end

				Notify:FireClient(p, "Car has been "..action.."ed.", 3)
			else
				Notify:FireClient(p, "You do not have a car spawned.", 3)
			end
		elseif msg:lower() == "/unlock" then
			local car = getSpawnedCar(p)
			if car then
				local action = "unlock"

				if not car.DriveSeat:FindFirstChild("Locked") then
					return Notify:FireClient(p, "Car is already unlocked.", 3)
				end

				local cO = checkOccupied(p)
				if cO then
					return Notify:FireClient(p, "Someone is using your car", 3)
				end

				if GetDistance(p.Character.PrimaryPart, car.DriveSeat) > 15 or p.Character.Humanoid.Health == 0 then
					return Notify:FireClient(p, "You are too far from your car", 3)
				end

				local carSound = script.CarLock:Clone()
				carSound.Parent = car.DriveSeat
				carSound:Play()

				game.Debris:AddItem(carSound, carSound.TimeLength)

				if action == "lock" then
					local lockValue = Instance.new("BoolValue")
					lockValue.Name = "Locked"
					lockValue.Value = true
					lockValue.Parent = car.DriveSeat
				elseif action == "unlock" then
					car.DriveSeat:FindFirstChild("Locked"):Destroy()
				end	
				for _,v in next, car.Body:GetChildren() do
					if v:IsA('VehicleSeat') or v:IsA('Seat') then
						if v:FindFirstChildOfClass('ProximityPrompt') and v.Occupant == nil then
							if v:FindFirstChild('Locked') then
								v:FindFirstChild('Locked'):Destroy()
							end
						end
					end
				end
				Notify:FireClient(p, "Car has been "..action.."ed.", 3)
			else
				Notify:FireClient(p, "You do not have a car spawned.", 3)
			end
		elseif msg:lower() == "/spawn pd" then
			if p:IsInGroup(33159644) then
				_G.spawnCar(p, 'PDCar')
			else
				Notify:FireClient(p, "Not high enough PD rank.", 3)
			end
		elseif msg:lower() == "/spawn pd2" then
			if p:IsInGroup(33159644) then
				_G.spawnCar(p, 'PDCar2')
			else
				Notify:FireClient(p, "Not high enough PD rank.", 3)
			end
		end
	end)
end)

local RefreshCooldown = {}

game:FindService('ReplicatedStorage'):FindFirstChild('ControllerRemote').OnServerEvent:Connect(function(p, msg, extra)
	if msg:lower() == "/lock" then
		local car = getSpawnedCar(p)
		if car then
			local action = "lock"

			if car.DriveSeat:FindFirstChild("Locked") then
				return Notify:FireClient(p, "Car is already locked.", 3)
			end

			local cO = checkOccupied(p)
			if cO then
				return Notify:FireClient(p, "Someone is using your car", 3)
			end

			if GetDistance(p.Character.PrimaryPart, car.DriveSeat) > 15 or p.Character.Humanoid.Health == 0 then
				return Notify:FireClient(p, "You are too far from your car", 3)
			end

			local carSound = script.CarLock:Clone()
			carSound.Parent = car.DriveSeat
			carSound:Play()

			game.Debris:AddItem(carSound, carSound.TimeLength)

			if action == "lock" then
				local lockValue = Instance.new("BoolValue")
				lockValue.Name = "Locked"
				lockValue.Value = true
				lockValue.Parent = car.DriveSeat
			elseif action == "unlock" then
				car.DriveSeat:FindFirstChild("Locked"):Destroy()
			end	
			for _,v in next, car.Body:GetChildren() do
				if v:IsA('VehicleSeat') or v:IsA('Seat') then
					if v:FindFirstChildOfClass('ProximityPrompt') and v.Occupant == nil then
						local lockValue = Instance.new("BoolValue")
						lockValue.Name = "Locked"
						lockValue.Value = true
						lockValue.Parent = v
					end
				end
			end
			Notify:FireClient(p, "Car has been "..action.."ed.", 3)
		else
			Notify:FireClient(p, "You do not have a car spawned.", 3)
		end
	elseif msg:lower() == "/unlock" then
		local car = getSpawnedCar(p)
		if car then
			local action = "unlock"

			if not car.DriveSeat:FindFirstChild("Locked") then
				return Notify:FireClient(p, "Car is already unlocked.", 3)
			end

			local cO = checkOccupied(p)
			if cO then
				return Notify:FireClient(p, "Someone is using your car", 3)
			end

			if GetDistance(p.Character.PrimaryPart, car.DriveSeat) > 15 or p.Character.Humanoid.Health == 0 then
				return Notify:FireClient(p, "You are too far from your car", 3)
			end

			local carSound = script.CarLock:Clone()
			carSound.Parent = car.DriveSeat
			carSound:Play()

			game.Debris:AddItem(carSound, carSound.TimeLength)

			if action == "lock" then
				local lockValue = Instance.new("BoolValue")
				lockValue.Name = "Locked"
				lockValue.Value = true
				lockValue.Parent = car.DriveSeat
			elseif action == "unlock" then
				car.DriveSeat:FindFirstChild("Locked"):Destroy()
			end	
			for _,v in next, car.Body:GetChildren() do
				if v:IsA('VehicleSeat') or v:IsA('Seat') then
					if v:FindFirstChildOfClass('ProximityPrompt') and v.Occupant == nil then
						if v:FindFirstChild('Locked') then
							v:FindFirstChild('Locked'):Destroy()
						end
					end
				end
			end
			Notify:FireClient(p, "Car has been "..action.."ed.", 3)
		else
			Notify:FireClient(p, "You do not have a car spawned.", 3)
		end
	elseif msg:lower() == "/spawn pd" then
		if p:IsInGroup(33159644) then
			_G.spawnCar(p, 'PDCar')
		else
			Notify:FireClient(p, "Not high enough PD rank.", 3)
		end
	elseif msg:lower() == "/spawn pd2" then
		if p:IsInGroup(33159644) then
			_G.spawnCar(p, 'PDCar2')
		else
			Notify:FireClient(p, "Not high enough PD rank.", 3)
		end
	elseif msg:lower() == "refreshvehicle" then
		if workspace:FindFirstChild('CivCars'):FindFirstChild(tostring(p.Name).. "'s Car") then
			if GetDistance(p.Character.PrimaryPart, workspace:FindFirstChild('CivCars'):FindFirstChild(tostring(p.Name).. "'s Car").DriveSeat) > 15 or p.Character.Humanoid.Health == 0 then return Notify:FireClient(p, "You are too far from your car", 3) end
			if workspace:FindFirstChild('CivCars'):FindFirstChild(tostring(p.Name).. "'s Car").DriveSeat.Occupant ~= nil then return Notify:FireClient(p, "Leave the driver seat.", 3) end
			if RefreshCooldown[p] ~= nil then return Notify:FireClient(p, "Refresh vehicle cooldown!", 3) end
			local CarType = workspace:FindFirstChild('CivCars'):FindFirstChild(tostring(p.Name).. "'s Car"):FindFirstChild('CarType').Value
			_G.hookCarRemove(getSpawnedCar(p), p)
			_G.spawnCar(p, CarType, true)
			RefreshCooldown[p] = true
			task.wait(3)
			RefreshCooldown[p] = nil
		else
			Notify:FireClient(p, "You do not have a car spawned.", 3)
		end
	elseif msg:lower() == "savecrosshair" then
		if tostring(extra) ~= nil then
			p.stored.Crosshair.Value = extra
		end
	elseif msg:lower() == "girl" then
		if not p:FindFirstChild('Girl') then
			local GIRL = Instance.new('BoolValue', p)
			GIRL.Name = 'Girl'
			task.wait(.1)
			p:LoadCharacter()
		end
	elseif msg:lower() == "boy" then
		if p:FindFirstChild('Girl') then
			p:FindFirstChild('Girl'):Destroy()
			task.wait(.1)
			p:LoadCharacter()
		end
	elseif msg:lower() == "updatedevice" then
		if p:FindFirstChild('Extra') then
			if p.Extra:FindFirstChild('Device') then
				if extra == "Keyboard" or extra == "Mobile" or extra == "Controller" then
					p.Extra:FindFirstChild('Device').Value = extra
				end
			end
		end
	
	end
end)

game:FindService('ReplicatedStorage').CarHandler.OnServerEvent:Connect(function(Player, String, Car, Extra)
	if not game.ServerStorage.Cars:FindFirstChild(Car) then return end
	if String == 'Spawn' then
		_G.spawnCar(Player, Car)
	elseif String == 'Buy' then
		_G.hookCarBuy(Player, Car)
	elseif String == 'BuyExtra' then
		_G.HookCarExtra(Player, Car, Extra)
	elseif String == 'BuyExtra2' then
		_G.HookCarExtra2(Player, Car, Extra)
	elseif String == 'BuyExtra3' then
		_G.HookCarExtra3(Player, Car, Extra)
	else
		Player:Kick()
	end
end)

game:FindService('ReplicatedStorage').GetCarInfo.OnServerInvoke = function(Player, Car)
	return _G.checkCarOwnership(Player, Car)
end