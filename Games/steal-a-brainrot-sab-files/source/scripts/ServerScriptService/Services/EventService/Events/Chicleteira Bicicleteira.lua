local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local HttpService = game:GetService("HttpService")
local Net = require(ReplicatedStorage.Packages.Net)
local ServerScriptService = game:GetService("ServerScriptService")
local AnimalService = require(ServerScriptService.Services.AnimalService)

local ChicleteraBicicleteira = {}

local IsActive = false
local SprayTimer = nil
local Clones = nil

local Animals = require(ReplicatedStorage.Datas.Animals)
local SpawnChicleteira = Net:RemoteEvent("EventService/Chicleteira Bicicleteira/SpawnChicleteira")
local Burst = Net:RemoteEvent("EventService/Chicleteira Bicicleteira/Burst")

local DEFAULT_LANES = {
	{ x = -419.394, baseY = -9.074 },
	{ x = -402.863, baseY = -9.074 },
}

local PATH_END_Z  = 251.706
local BIKE_SPEED  = 35


local function fireBikeLane(startCF, endCF, jumpCF)
	SpawnChicleteira:FireAllClients(startCF, endCF, BIKE_SPEED, jumpCF)
	local dist = math.abs(endCF.Z - startCF.Z)
	return dist / BIKE_SPEED
end

local function laneFromPlayerCFrame(playerCF)
	local x   = playerCF.X
	local playerY = playerCF.Y
	local groundY = DEFAULT_LANES[1].baseY
	local rot = CFrame.Angles(0, math.rad(180), 0)

	local startCF = CFrame.new(x, groundY, -132.1) * rot

	local endCF   = CFrame.new(x, groundY, PATH_END_Z) * rot

	local jumpCF  = CFrame.new(x, playerY, -132.1) * rot

	return startCF, endCF, jumpCF
end

local function laneFromDefault(lane)
	local rot = CFrame.Angles(0, math.rad(180), 0)
	local startCF = CFrame.new(lane.x, lane.baseY, -132.1) * rot
	local endCF   = CFrame.new(lane.x, lane.baseY, PATH_END_Z) * rot
	return startCF, endCF
end


function ChicleteraBicicleteira.OnStart(_, spawnCFrames)
	if IsActive then return end
	IsActive = true
	task.wait(3)
	local travelTimes = {}

	local hasRitualPositions = spawnCFrames and #spawnCFrames > 0

	if hasRitualPositions then
		for _, playerCF in ipairs(spawnCFrames) do
			local startCF, endCF, jumpCF = laneFromPlayerCFrame(playerCF)
			local t = fireBikeLane(startCF, endCF, jumpCF)
			table.insert(travelTimes, t)
		end
	else
		for _, lane in ipairs(DEFAULT_LANES) do
			local startCF, endCF = laneFromDefault(lane)
			local t = fireBikeLane(startCF, endCF, nil)
			table.insert(travelTimes, t)
		end
	end

	local maxTravelTime = 0
	for _, t in ipairs(travelTimes) do
		if t > maxTravelTime then maxTravelTime = t end
	end

	task.wait(maxTravelTime)

	if not IsActive then return end

	AnimalService.SetSpeed(15)
	AnimalService.SetSpawnRate(2.33333333333)

	if Clones then Clones:Destroy() end
	Clones = script:WaitForChild("Chicleteras"):Clone()
	Clones.Parent = workspace

	if SprayTimer then
		pcall(task.cancel, SprayTimer)
	end

	SprayTimer = task.spawn(function()
		while IsActive do
			local waitTime = math.random(4, 7)
			task.wait(waitTime)

			if not IsActive then break end

			local chicleteras = {}
			if Clones and Clones.Parent then
				for _, obj in ipairs(Clones:GetChildren()) do
					table.insert(chicleteras, obj)
				end
			end

			if #chicleteras == 0 then continue end

			local chicletera = chicleteras[math.random(1, #chicleteras)]
			local chicleteraPos = chicletera:GetPivot().Position

			local closest = nil
			local closestDist = 50
			local animals = CollectionService:GetTagged("Animal")

			for _, animal in ipairs(animals) do
				if animal.PrimaryPart then
					local dist = (animal.PrimaryPart.Position - chicleteraPos).Magnitude
					if dist < closestDist then
						closest = animal
						closestDist = dist
					end
				end
			end

			if not closest then continue end

			local traitsRaw = closest:GetAttribute("Traits") or "[]"
			local success, decoded = pcall(function()
				return HttpService:JSONDecode(traitsRaw)
			end)

			if success and type(decoded) == "table" then
				local hasPaint = false
				for _, t in ipairs(decoded) do
					if t == "Paint" then
						hasPaint = true
						break
					end
				end

				if not hasPaint then
					chicletera:SetAttribute("ForceSpray", closest.Name)
					task.wait(1.4)
					decoded[#decoded + 1] = "Paint"
					closest:SetAttribute("Traits", HttpService:JSONEncode(decoded))
					Burst:FireAllClients(closest.Name)
					chicletera:SetAttribute("ForceSpray", nil)
				end
			end
		end
	end)
end


function ChicleteraBicicleteira.OnStop()
	if not IsActive then return end
	IsActive = false
	AnimalService.SetSpeed(10)
	AnimalService.SetSpawnRate(3)
	if Clones and Clones.Parent then
		for _, chicletera in ipairs(Clones:GetChildren()) do
			chicletera:SetAttribute("ForceSpray", nil)
		end
		Clones:Destroy()
		Clones = nil
	end
end

return ChicleteraBicicleteira