local BombardiroCrocodilo = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local HttpService = game:GetService("HttpService")
local MathUtils = require(ReplicatedStorage.Utils.MathUtils)

local Net = require(ReplicatedStorage.Packages.Net)
local SharedAnimals = require(ReplicatedStorage.Shared.Animals)

local NUM_PLANES = 3
local PlaneTasks = {}
local PlaneStates = {}

local Explode = Net:RemoteEvent("EventService/Bombardiro Crocodilo/Explode")
local SpawnBomb = Net:RemoteEvent("EventService/Bombardiro Crocodilo/SpawnBomb")

local NPCState = {}
local movementTasks = {}

local function getRouteParts()
	local routePoints = {}
	local wanderPart = Workspace:FindFirstChild("Events") and Workspace.Events:FindFirstChild("Air") and Workspace.Events.Air:FindFirstChild("Wander")
	if not wanderPart or not wanderPart:IsA("BasePart") then
		warn("Wander part not found or invalid")
		return {}
	end

	local size = wanderPart.Size
	local center = wanderPart.Position
	local count = 7

	for _ = 1, count do
		local offset = Vector3.new(
			(math.random() - 0.5) * size.X,
			(math.random() - 0.5) * size.Y,
			(math.random() - 0.5) * size.Z
		)
		local point = center + offset
		table.insert(routePoints, point)
	end

	return routePoints
end

local function wander(npcModel, waypoints)
	if not npcModel or not npcModel.PrimaryPart then return end
	if not waypoints or #waypoints == 0 then
		warn("Invalid waypoints for", npcModel.Name)
		return
	end

	if movementTasks[npcModel] then
		movementTasks[npcModel]:Disconnect()
	end

	local idx = 1

	local conn
	conn = RunService.Heartbeat:Connect(function(dt)
		if not npcModel or not npcModel.PrimaryPart then
			conn:Disconnect()
			movementTasks[npcModel] = nil
			return
		end

		local currentPos = npcModel.PrimaryPart.Position
		local target = waypoints[idx]
		local dir = target - currentPos
		local dist = dir.Magnitude

		if dist < 0.5 then
			idx += 1
			if idx > #waypoints then
				idx = 1
			end
			target = waypoints[idx]
			dir = target - currentPos
			dist = dir.Magnitude
			if dist == 0 then return end
		end

		if dist == 0 then return end

		local dirUnit = dir.Unit
		local speed = 30
		local moveDelta = dirUnit * speed * dt

		local nextPos = (moveDelta.Magnitude >= dist) and target or (currentPos + moveDelta)

		local lookCFrame = CFrame.lookAt(nextPos, nextPos + dirUnit)
		npcModel:SetPrimaryPartCFrame(lookCFrame)
	end)

	movementTasks[npcModel] = conn
end

local function spawnNPCs()
	local planesFolder = Workspace:FindFirstChild("Planes")
	if not planesFolder then
		planesFolder = Instance.new("Folder")
		planesFolder.Name = "Planes"
		planesFolder.Parent = Workspace
	end

	local spawnedNPCs = {}

	for i = 1, NUM_PLANES do
		local template = SharedAnimals.GetAnimatedModel(nil, "Bombardiro Crocodilo", "Walk")
		template.Parent = planesFolder
		template:SetAttribute("BombardiroCrocodilo", true)
		template.Name = template.Name .. tostring(i)

		for _, part in pairs(template:GetDescendants()) do
			if part:IsA("BasePart") then
				part.Anchored = true
			end
		end

		spawnedNPCs[template.Name] = template
	end

	return spawnedNPCs
end

local function activateNPCs()
	local spawnedNPCs = spawnNPCs()
	local routes = getRouteParts()
	if #routes == 0 then
		return
	end

	local usedIndices = {}
	for npcName, npc in pairs(spawnedNPCs) do
		if npc and npc.PrimaryPart then
			local routeIndex
			repeat
				routeIndex = math.random(1, #routes)
			until not usedIndices[routeIndex]
			usedIndices[routeIndex] = true
			npc:SetPrimaryPartCFrame(CFrame.new(routes[routeIndex]))

			NPCState[npcName] = { Model = npc, OriginalPosition = routes[routeIndex] }

			local routePoints = getRouteParts()
			wander(npc, routePoints)
		end
	end
end

local function deactivateNPCs()
	for npcName, data in pairs(NPCState) do
		local npc = data.Model
		if npc and data.OriginalPosition then
			npc.PrimaryPart.Position = data.OriginalPosition
			npc:Destroy()
		end
	end
	NPCState = {}
	movementTasks = {}
end

local function startevent()
	while true do
		task.wait(1.5)

		local randomDelay = math.random(5, 10)
		task.wait(randomDelay)

		local planesFolder = workspace:WaitForChild("Planes")

		local planes = {}
		for _, plane in pairs(planesFolder:GetChildren()) do
			if plane:IsA("Model") then
				table.insert(planes, plane)
			end
		end

		if #planes == 0 then
			task.wait(1)
			continue
		end

		local randomPlane = planes[math.random(1, #planes)]

		local bomb = SharedAnimals.GetAnimatedModel(nil, "Svinina Bombardino", "Walk")

		local groundPart = workspace.Events.Air:WaitForChild("Ground")

		local timetoground

		if bomb.PrimaryPart then
			local planePosition = randomPlane:GetModelCFrame().Position
			local newCFrame = CFrame.new(planePosition) * CFrame.Angles(math.rad(-90), 0, 0)

			timetoground = MathUtils.calculateTimeToGround(planePosition.Y, groundPart.Position.Y)

			bomb:SetPrimaryPartCFrame(newCFrame)
		end

		if not timetoground or timetoground <= 0 then
			bomb:Destroy()
			continue
		end

		task.wait(timetoground)

		local vfx = game.ReplicatedStorage.Controllers.EventController.Events["Bombardiro Crocodilo"].ExplosionBoom:Clone()
		vfx.Parent = workspace.Events.Air
		vfx.CFrame = CFrame.new(bomb.PrimaryPart.Position.X, -7, bomb.PrimaryPart.Position.Z)

		local hitbox = Instance.new("Part")
		hitbox.Shape = Enum.PartType.Ball
		hitbox.Transparency = 1
		hitbox.BrickColor = BrickColor.new("Bright red")
		hitbox.Material = Enum.Material.Neon
		hitbox.Anchored = true
		hitbox.Parent = workspace.Events.Air
		hitbox.Size = Vector3.new(25, 25, 25)
		hitbox.CFrame = vfx.CFrame
		hitbox.CanCollide = false
		game.Debris:AddItem(hitbox, 10)

		local currentPos = hitbox.Position
		local regionSize = hitbox.Size

		for _, animal in ipairs(workspace.MovingAnimals:GetChildren()) do
			if animal:IsA("Model") then
				local root = animal:FindFirstChild("HumanoidRootPart") or animal.PrimaryPart
				if root then
					local relativePosition = currentPos - root.Position
					local within = (
						math.abs(relativePosition.X) <= regionSize.X * 0.5 and
							math.abs(relativePosition.Y) <= regionSize.Y * 0.5 and
							math.abs(relativePosition.Z) <= regionSize.Z * 0.5
					)

					if within then
						local traitsJson = animal:GetAttribute("Traits")
						local traits = {}

						if traitsJson then
							local success, decoded = pcall(function()
								return HttpService:JSONDecode(traitsJson)
							end)
							if success and type(decoded) == "table" then
								traits = decoded
							end
						end

						if not table.find(traits, "Explosive") then
							table.insert(traits, "Explosive")
							animal:SetAttribute("Traits", HttpService:JSONEncode(traits))
						end
					end
				end
			end
		end

		bomb:Destroy()

		require(game.ReplicatedStorage.Shared.VFX).emit(vfx)
		task.wait(1.5)
		vfx:Destroy()
	end
end

function BombardiroCrocodilo.OnStart()
	task.delay(8, function()
		activateNPCs()
		task.spawn(function()
			startevent()
		end)
	end)
end

function BombardiroCrocodilo.OnStop()
	deactivateNPCs()
end

return BombardiroCrocodilo