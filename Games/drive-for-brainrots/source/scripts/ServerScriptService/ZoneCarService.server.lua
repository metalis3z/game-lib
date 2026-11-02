--!strict
-- ZoneCarService v4
-- Driver LocalScript references its siblings (LocalVehicleGui, Chassis, etc.)
-- via script.Parent:WaitForChild(...). So we clone the ENTIRE Scripts folder
-- (renamed/reparented) into PlayerGui, with Driver inside it, so its siblings
-- resolve correctly.

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Zones = Workspace:WaitForChild("Zones")
local Templates = ReplicatedStorage:WaitForChild("Templates")
local CarTemplate = Templates:WaitForChild("Car")
local Events = ReplicatedStorage:WaitForChild("Events")
local ForceUnequipCar = Events:WaitForChild("ForceUnequipCar")

local activeCars = {}         -- [player] = car model
local activeDrivers = {}      -- [player] = scripts folder in PlayerGui
local lastInZone = {}

local function isInsideZone(position)
	for _, zone in ipairs(Zones:GetChildren()) do
		if zone:IsA("BasePart") then
			local lp = zone.CFrame:PointToObjectSpace(position)
			local s = zone.Size
			if math.abs(lp.X) <= s.X/2 and math.abs(lp.Y) <= s.Y/2 and math.abs(lp.Z) <= s.Z/2 then
				return true
			end
		end
	end
	return false
end

local function despawnCar(player)
	local car = activeCars[player]
	if car then
		activeCars[player] = nil
		car:Destroy()
	end
	local d = activeDrivers[player]
	if d then
		activeDrivers[player] = nil
		d:Destroy()
	end
	local char = player.Character
	if char then
		char:SetAttribute("InCar", false)
		local hum = char:FindFirstChildOfClass("Humanoid")
		if hum then hum.Sit = false end
	end
end

local function spawnCar(player)
	if activeCars[player] then return end
	local char = player.Character
	if not char then return end
	local hrp = char:FindFirstChild("HumanoidRootPart")
	local humanoid = char:FindFirstChildOfClass("Humanoid")
	if not (hrp and humanoid) or humanoid.Health <= 0 then return end

	local car = CarTemplate:Clone()
	car.Name = "EquippedCar_" .. player.Name

	if not car.PrimaryPart then
		local fp = car:FindFirstChild("FloorPanel", true)
		if fp and fp:IsA("BasePart") then car.PrimaryPart = fp end
	end

	local chassisModel = car:FindFirstChild("Chassis")
	local seat = chassisModel and chassisModel:FindFirstChild("VehicleSeat")
	if not seat then
		warn("[ZoneCarService] No VehicleSeat")
		car:Destroy()
		return
	end

	seat.Disabled = false

	local floor = car.PrimaryPart
	local lookVec = hrp.CFrame.LookVector
	local yaw = math.atan2(-lookVec.X, -lookVec.Z)
	local seatInFloorSpace = floor.CFrame:ToObjectSpace(seat.CFrame)
	local targetSeatCFrame = CFrame.new(hrp.Position + Vector3.new(0, 3, 0)) * CFrame.Angles(0, yaw, 0)
	car:PivotTo(targetSeatCFrame * seatInFloorSpace:Inverse())

	car.Parent = Workspace

	for _, desc in ipairs(car:GetDescendants()) do
		if desc:IsA("BasePart") then
			pcall(function() desc:SetNetworkOwner(player) end)
		end
	end

	seat:Sit(humanoid)

	activeCars[player] = car
	char:SetAttribute("InCar", true)

	-- The Driver LocalScript references its siblings (LocalVehicleGui, etc.)
	-- via script.Parent:WaitForChild(). We need to place Driver somewhere that:
	--   (a) is on the client (so the LocalScript runs), and
	--   (b) has all the sibling ModuleScripts/LocalScripts alongside it.
	--
	-- Easiest: clone the entire Car.Scripts folder into the player's
	-- PlayerGui. Driver will resolve its siblings correctly.
	local playerGui = player:FindFirstChildOfClass("PlayerGui")
	if playerGui then
		local scriptsFolder = CarTemplate.Scripts:Clone()
		-- Disable Driver while we wire up CarValue, then re-enable
		local driver = scriptsFolder:FindFirstChild("Driver")
		if driver then
			driver.Disabled = true
			local cv = driver:FindFirstChild("CarValue")
			if cv and cv:IsA("ObjectValue") then
				cv.Value = car
			end
		end
		-- The "Vehicle" server Script inside the Scripts folder is not needed
		-- on the client (and the server copy inside the car already ran).
		-- Remove it to avoid noise.
		local vehicleServer = scriptsFolder:FindFirstChild("Vehicle")
		if vehicleServer then vehicleServer:Destroy() end

		scriptsFolder.Name = "CarScripts_" .. player.Name
		scriptsFolder.Parent = playerGui

		if driver then
			driver.Disabled = false
		end
		activeDrivers[player] = scriptsFolder
	else
		warn("[ZoneCarService] No PlayerGui for " .. player.Name)
	end

	-- Watch for the player leaving the seat (they pressed Space / exited)
	local sitConn
	sitConn = seat:GetPropertyChangedSignal("Occupant"):Connect(function()
		if seat.Occupant == nil then
			task.wait(0.25)
			if seat.Parent and seat.Occupant == nil and activeCars[player] == car then
				despawnCar(player)
				if sitConn then sitConn:Disconnect() end
			end
		end
	end)
end

RunService.Heartbeat:Connect(function()
	for _, player in ipairs(Players:GetPlayers()) do
		local char = player.Character
		if char then
			local hrp = char:FindFirstChild("HumanoidRootPart")
			if hrp then
				local inZone = isInsideZone(hrp.Position)
				local wasIn = lastInZone[player] == true
				if inZone and not wasIn then
					if not activeCars[player] then spawnCar(player) end
				elseif not inZone and wasIn then
					despawnCar(player)
				end
				lastInZone[player] = inZone
			end
		end
	end
end)

ForceUnequipCar.OnServerEvent:Connect(function(player)
	despawnCar(player)
end)

local function hookPlayer(player)
	player.CharacterRemoving:Connect(function() despawnCar(player) end)
end
Players.PlayerAdded:Connect(hookPlayer)
for _, p in ipairs(Players:GetPlayers()) do hookPlayer(p) end
Players.PlayerRemoving:Connect(function(player)
	despawnCar(player)
	lastInZone[player] = nil
end)

print("[ZoneCarService] v4 started")
