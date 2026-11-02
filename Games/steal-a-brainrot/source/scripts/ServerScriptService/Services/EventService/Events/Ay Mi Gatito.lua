local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")

local Net = require(ReplicatedStorage.Packages.Net)
local Burst = Net:RemoteEvent("EventService/AyMiGatito/Burst")

local AyMiGatito = {}

local isActive = false
local attackTask = nil
local wanderTask = nil
local recentlyTargeted = {}
local spawnedCats = {}

local WANDER_FOLDER = workspace.Events:FindFirstChild("Wander")
local TOTAL_CATS = 15
local WALK_SPEED = 21

local CAT_VARIANTS = {
	"Gatito",
	"Angry Gatito",
	"Crying Gatito"
}

local RAY_PARAMS = RaycastParams.new()
RAY_PARAMS.FilterType = Enum.RaycastFilterType.Include
RAY_PARAMS.FilterDescendantsInstances = {workspace.Map, workspace.Terrain}

local function stickToGround(Position)
	local Origin = Position + Vector3.new(0, 10, 0)
	local Direction = Vector3.new(0, -20, 0)
	local Result = workspace:Raycast(Origin, Direction, RAY_PARAMS)
	if Result then return Result.Position + Vector3.new(0, 1, 0) end

	local BackupParams = RaycastParams.new()
	BackupParams.FilterType = Enum.RaycastFilterType.Exclude
	BackupParams.FilterDescendantsInstances = {}
	local BackupResult = workspace:Raycast(Origin, Direction, BackupParams)
	if BackupResult then return BackupResult.Position + Vector3.new(0, 1, 0) end

	return Position
end

local function getRandomWanderPosition(wanderPart)
	local size = wanderPart.Size
	local cf = wanderPart.CFrame
	local randomX = math.random(-size.X/2, size.X/2)
	local randomZ = math.random(-size.Z/2, size.Z/2)

	local rayOrigin = (cf * CFrame.new(randomX, size.Y/2 + 10, randomZ)).Position
	local rayDirection = Vector3.new(0, -200, 0)

	local raycastParams = RaycastParams.new()
	raycastParams.FilterType = Enum.RaycastFilterType.Exclude
	raycastParams.FilterDescendantsInstances = {}

	local result = workspace:Raycast(rayOrigin, rayDirection, raycastParams)
	if result then
		return result.Position + Vector3.new(0, 1, 0)
	else
		return (cf * CFrame.new(randomX, -size.Y/2, randomZ)).Position + Vector3.new(0, 1, 0)
	end
end

local function createCat(position)
	local cat = Instance.new("Model")
	cat.Name = "AyMiGatito"

	local rootPart = Instance.new("Part")
	rootPart.Name = "HumanoidRootPart"
	rootPart.Size = Vector3.new(2, 2, 2)
	rootPart.Transparency = 1
	rootPart.CanCollide = false
	rootPart.Anchored = true
	rootPart.CFrame = CFrame.new(position)
	rootPart.Parent = cat

	cat.PrimaryPart = rootPart
	CollectionService:AddTag(cat, "Gatito")

	for _, part in ipairs(cat:GetDescendants()) do
		if part:IsA("BasePart") then
			part.CanCollide = false
		end
	end

	return cat
end

local function spawnCats()
	task.wait(6)

	if not WANDER_FOLDER then
		warn("Wander folder not found at workspace.Events.Wander")
		return
	end

	local wanderParts = {}
	for _, wanderPart in ipairs(WANDER_FOLDER:GetChildren()) do
		if wanderPart:IsA("BasePart") then
			table.insert(wanderParts, wanderPart)
		end
	end

	if #wanderParts == 0 then
		warn("No wander parts found")
		return
	end

	for i = 1, TOTAL_CATS do
		task.spawn(function()
			task.wait(math.random() * 3)

			local randomWander = wanderParts[math.random(1, #wanderParts)]
			local spawnPos = getRandomWanderPosition(randomWander)
			spawnPos = stickToGround(spawnPos)

			local cat = createCat(spawnPos)
			cat.Parent = workspace

			task.delay(0.2, function()
				if not cat.Parent then return end

				cat:SetAttribute("Dance", true)
				task.delay(0.05, function()
					if cat.Parent then
						cat:SetAttribute("Dance", false)
					end
				end)
			end)

			local variant = CAT_VARIANTS[math.random(1, #CAT_VARIANTS)]
			cat:SetAttribute("Variant", variant)

			cat:SetAttribute("IsRunning", false)
			cat:SetAttribute("Ground", false)
			cat:SetAttribute("InitialGround", true)
			cat:SetAttribute("AttackAnimation", false)

			table.insert(spawnedCats, {
				Model = cat,
				WanderPart = randomWander,
				LastWander = 0,
				IsMoving = false,
				CurrentTask = nil,
				_cancelAttack = nil,
			})
		end)
	end
end

local function stopCatMovement(catData)
	if catData._cancelAttack then
		catData._cancelAttack()
		catData._cancelAttack = nil
	end

	if catData.CurrentTask then
		task.cancel(catData.CurrentTask)
		catData.CurrentTask = nil
	end
	catData.IsMoving = false

	local cat = catData.Model
	if cat and cat.Parent then
		cat:SetAttribute("IsRunning", false)
		cat:SetAttribute("Ground", false)
		cat:SetAttribute("InitialGround", false)
		cat:SetAttribute("AttackAnimation", false)

		cat:SetAttribute("Dance", true)
		task.delay(0.05, function()
			if cat.Parent then
				cat:SetAttribute("Dance", false)
			end
		end)
	end
end

local function moveCatToPosition(catData, targetPosition, onComplete)
	local cat = catData.Model
	if not cat or not cat.Parent or not cat.PrimaryPart then
		return false
	end

	stopCatMovement(catData)
	catData.IsMoving = true

	cat:SetAttribute("IsRunning", true)
	cat:SetAttribute("Ground", false)
	cat:SetAttribute("InitialGround", false)
	cat:SetAttribute("Dance", false)

	catData.CurrentTask = task.spawn(function()
		local lastTime = os.clock()
		local stuckCheckTime = 0
		local lastPos = cat.PrimaryPart.Position

		while catData.IsMoving and cat.Parent and cat.PrimaryPart do
			local currentTime = os.clock()
			local deltaTime = currentTime - lastTime
			lastTime = currentTime

			local currentPos = cat.PrimaryPart.Position

			if (currentPos - lastPos).Magnitude < 0.1 and deltaTime > 0.5 then
				stuckCheckTime += deltaTime
				if stuckCheckTime > 1 then
					local randomOffset = Vector3.new(math.random(-8, 8), 0, math.random(-8, 8))
					local newTarget = currentPos + randomOffset
					newTarget = stickToGround(newTarget)
					cat:PivotTo(CFrame.new(newTarget))
					stuckCheckTime = 0
				end
			else
				stuckCheckTime = 0
			end
			lastPos = currentPos

			local targetPos = typeof(targetPosition) == "function" and targetPosition() or targetPosition
			if not targetPos then break end

			local direction = (targetPos - currentPos).Unit
			local distance = (targetPos - currentPos).Magnitude
			if distance < 0.5 then break end

			local moveAmount = math.min(WALK_SPEED * deltaTime, distance)
			local newPos = currentPos + direction * moveAmount
			newPos = stickToGround(newPos)

			local lookVector = Vector3.new(direction.X, 0, direction.Z)
			if lookVector.Magnitude > 0 then
				lookVector = lookVector.Unit
				local uprightCFrame = CFrame.lookAt(newPos, newPos + lookVector, Vector3.new(0, 1, 0))
				cat:PivotTo(uprightCFrame)
			else
				cat:PivotTo(CFrame.new(newPos))
			end

			RunService.Heartbeat:Wait()
		end

		catData.IsMoving = false
		cat:SetAttribute("IsRunning", false)
		cat:SetAttribute("Ground", false)
		cat:SetAttribute("InitialGround", false)
		cat:SetAttribute("Dance", true)
		task.delay(0.05, function()
			if cat.Parent then
				cat:SetAttribute("Dance", false)
			end
		end)

		if onComplete then onComplete() end
	end)

	return true
end

-- ⭐ Fonction d'attaque corrigée (trait AVANT le FireAllClients)
local function followAndAttackAnimal(catData, targetAnimal)
	local cat = catData.Model
	if not cat or not cat.Parent or not cat.PrimaryPart then return end
	if not targetAnimal or not targetAnimal.Parent or not targetAnimal.PrimaryPart then return end

	stopCatMovement(catData)

	local attackCancelled = false
	catData._cancelAttack = function()
		attackCancelled = true
	end

	catData.IsMoving = true
	cat:SetAttribute("IsRunning", true)
	cat:SetAttribute("Ground", false)
	cat:SetAttribute("InitialGround", false)
	cat:SetAttribute("AttackAnimation", false)

	catData.CurrentTask = task.spawn(function()
		local lastTime = os.clock()
		local attackDistance = 5
		local maxFollowTime = 10
		local startTime = os.clock()

		while not attackCancelled and cat.Parent and cat.PrimaryPart do
			if not targetAnimal or not targetAnimal.Parent or not targetAnimal.PrimaryPart then break end
			if os.clock() - startTime > maxFollowTime then break end

			local currentTime = os.clock()
			local deltaTime = currentTime - lastTime
			lastTime = currentTime

			local currentPos = cat.PrimaryPart.Position
			local targetPos = targetAnimal.PrimaryPart.Position
			local distance = (targetPos - currentPos).Magnitude

			if distance < attackDistance then
				catData.IsMoving = false
				cat:SetAttribute("IsRunning", false)
				cat:SetAttribute("Ground", false)
				cat:SetAttribute("InitialGround", false)

				task.wait(0.1)
				if attackCancelled then
					cat:SetAttribute("AttackAnimation", false)
					break
				end

				cat:SetAttribute("AttackAnimation", true)
				task.wait(0.5)
				if attackCancelled then
					cat:SetAttribute("AttackAnimation", false)
					break
				end

				if targetAnimal and targetAnimal.Parent then
					-- 1. Lire les traits existants
					local traitsJson = targetAnimal:GetAttribute("Traits")
					local currentTraits = {}
					if traitsJson then
						local success, decoded = pcall(HttpService.JSONDecode, HttpService, traitsJson)
						if success and type(decoded) == "table" then
							currentTraits = decoded
						end
					end

					-- 2. Vérifier si le trait ":3" est déjà présent
					local hasGatito = false
					for _, trait in ipairs(currentTraits) do
						if trait == ":3" then
							hasGatito = true
							break
						end
					end

					-- 3. Ajouter le trait si absent
					if not hasGatito then
						table.insert(currentTraits, ":3")
						targetAnimal:SetAttribute("Traits", HttpService:JSONEncode(currentTraits))
					end

					-- 4. Envoyer l'événement APRÈS avoir ajouté le trait
					--    pour que le client puisse vérifier l'attribut au moment du traitement
					Burst:FireAllClients(targetAnimal.Name)
				end

				task.wait(0.5)
				cat:SetAttribute("AttackAnimation", false)

				cat:SetAttribute("Dance", true)
				task.delay(0.05, function()
					if cat.Parent then
						cat:SetAttribute("Dance", false)
					end
				end)

				task.wait(1)
				catData._cancelAttack = nil
				return
			end

			local direction = (targetPos - currentPos).Unit
			local moveAmount = math.min(WALK_SPEED * deltaTime, distance)
			local newPos = currentPos + direction * moveAmount
			newPos = stickToGround(newPos)

			local lookVector = Vector3.new(direction.X, 0, direction.Z)
			if lookVector.Magnitude > 0 then
				lookVector = lookVector.Unit
				local uprightCFrame = CFrame.lookAt(newPos, newPos + lookVector, Vector3.new(0, 1, 0))
				cat:PivotTo(uprightCFrame)
			else
				cat:PivotTo(CFrame.new(newPos))
			end

			RunService.Heartbeat:Wait()
		end

		catData.IsMoving = false
		catData._cancelAttack = nil
		cat:SetAttribute("IsRunning", false)
		cat:SetAttribute("Ground", false)
		cat:SetAttribute("InitialGround", false)
		cat:SetAttribute("AttackAnimation", false)
	end)
end

local function wanderCat(catData)
	if catData.IsMoving then return end
	local wanderPos = getRandomWanderPosition(catData.WanderPart)
	moveCatToPosition(catData, wanderPos)
	catData.LastWander = os.clock()
end

function AyMiGatito.OnStart()
	if isActive then return end
	isActive = true

	ReplicatedStorage:SetAttribute("AyMiGatitoEvent", true)
	spawnCats()

	wanderTask = task.spawn(function()
		while isActive do
			task.wait(1)
			for _, catData in ipairs(spawnedCats) do
				local cat = catData.Model
				local currentTime = os.clock()

				if cat and cat.Parent and not catData.IsMoving then
					if (currentTime - catData.LastWander) > math.random(8, 15) then
						wanderCat(catData)
					end
				end
			end
		end
	end)

	attackTask = task.spawn(function()
		while isActive do
			task.wait(math.random(8, 15))
			if not isActive or #spawnedCats == 0 then break end

			local roadAnimals = workspace.MovingAnimals:GetChildren()
			local currentTime = workspace:GetServerTimeNow()

			for animalName, lastTime in pairs(recentlyTargeted) do
				if (currentTime - lastTime) > 15 then
					recentlyTargeted[animalName] = nil
				end
			end

			local candidates = {}
			for _, animal in roadAnimals do
				if animal.PrimaryPart then
					local isRecentlyTargeted = recentlyTargeted[animal.Name] ~= nil
					local hasGatito = false

					local traitsJson = animal:GetAttribute("Traits")
					if traitsJson then
						local success, decoded = pcall(HttpService.JSONDecode, HttpService, traitsJson)
						if success and type(decoded) == "table" then
							for _, trait in decoded do
								if trait == ":3" then
									hasGatito = true
									break
								end
							end
						end
					end

					if not isRecentlyTargeted and not hasGatito then
						table.insert(candidates, animal)
					end
				end
			end

			if #candidates > 0 then
				local selected = candidates[math.random(1, #candidates)]
				recentlyTargeted[selected.Name] = currentTime

				local availableCats = {}
				for _, catData in spawnedCats do
					if catData.Model and catData.Model.Parent and not catData.IsMoving then
						table.insert(availableCats, catData)
					end
				end

				if #availableCats > 0 then
					local catData = availableCats[math.random(1, #availableCats)]
					followAndAttackAnimal(catData, selected)
				end
			end
		end
	end)
end

function AyMiGatito.OnStop()
	if not isActive then return end
	isActive = false

	ReplicatedStorage:SetAttribute("AyMiGatitoEvent", false)

	if attackTask then task.cancel(attackTask) attackTask = nil end
	if wanderTask then task.cancel(wanderTask) wanderTask = nil end

	for _, catData in spawnedCats do
		stopCatMovement(catData)
		if catData.Model and catData.Model.Parent then
			catData.Model:Destroy()
		end
	end

	spawnedCats = {}
	recentlyTargeted = {}
end

return AyMiGatito