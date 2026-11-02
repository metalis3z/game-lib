local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local ServerScriptService = game:GetService("ServerScriptService")

local Net = require(ReplicatedStorage.Packages.Net)
local Burst = Net:RemoteEvent("EventService/RipMyGranny/Burst")
local Projectile = Net:RemoteEvent("EventService/RipMyGranny/Projectile")
local Trove = require(ReplicatedStorage.Packages.Trove)
local ServerData = require(ReplicatedStorage.Datas.ServerData)

local function getAnimalService()
	return require(ServerScriptService.Services.AnimalService)
end

local RipMyGranny = {}

local eventTrove: typeof(Trove.new()) = nil
local grannies: { [string]: Part } = {}
local grannyTroves: { [string]: typeof(Trove.new()) } = {}
local recentlyTargeted: { [string]: number } = {}
local activeAttacks = 0
local isActive = false

local MAX_ATTACKS = 2
local GRANNY_SPEED = 24
local FLY_HEIGHT_MIN = 20
local FLY_HEIGHT_MAX = 60
local TARGET_CHECK_MIN = 10
local TARGET_CHECK_MAX = 20
local RECENT_TARGET_COOLDOWN = 25
local MIN_WANDER_DISTANCE = 40
local Granny_Count = 10
local SAMMY_SHOOT_DELAY = 3.5
local WanderFolder = workspace.Events:FindFirstChild("Rip My Granny")

local HIDE_TAG = "HideInRipMyGrannyServer"

local BLOCKING_TRAITS = {
	["Granny"] = true,
}


local hiddenInstances: { [Instance]: boolean } = {}

local function hideInstance(instance: Instance)
	if not eventTrove then return end
	if hiddenInstances[instance] then return end
	if not instance:IsDescendantOf(workspace) then return end

	local originalParent = instance.Parent
	if not originalParent then return end

	hiddenInstances[instance] = true
	instance.Parent = script

	eventTrove:Add(function()
		hiddenInstances[instance] = nil

		if originalParent and originalParent.Parent ~= nil then
			pcall(function()
				instance.Parent = originalParent
			end)
		end
	end)
end

local function setupHiddenInstances()
	for _, instance in CollectionService:GetTagged(HIDE_TAG) do
		hideInstance(instance)
	end

	eventTrove:Connect(CollectionService:GetInstanceAddedSignal(HIDE_TAG), function(instance)
		hideInstance(instance)
	end)
end


local function getWanderParts(): { BasePart }
	local parts: { BasePart } = {}
	if WanderFolder then
		for _, child in ipairs(WanderFolder:GetChildren()) do
			if child:IsA("BasePart") then
				table.insert(parts, child)
			end
		end
	end
	return parts
end

local function getRandomFlyPosition(currentPosition: Vector3?)
	local maxAttempts = 20
	local wanderParts = getWanderParts()

	for _ = 1, maxAttempts do
		local x, z

		if #wanderParts > 0 then
			local zone = wanderParts[math.random(1, #wanderParts)]
			x = zone.Position.X + (math.random() - 0.5) * zone.Size.X
			z = zone.Position.Z + (math.random() - 0.5) * zone.Size.Z
		else
			x = (math.random() - 0.5) * 400
			z = (math.random() - 0.5) * 400
		end

		local y = FLY_HEIGHT_MIN + math.random() * (FLY_HEIGHT_MAX - FLY_HEIGHT_MIN)
		local pos = Vector3.new(x, y, z)

		if not currentPosition or (pos - currentPosition).Magnitude >= MIN_WANDER_DISTANCE then
			return pos
		end
	end

	local x = (math.random() - 0.5) * 400
	local z = (math.random() - 0.5) * 400
	local y = FLY_HEIGHT_MIN + math.random() * (FLY_HEIGHT_MAX - FLY_HEIGHT_MIN)
	return Vector3.new(x, y, z)
end

local function getTraits(animal: Instance): ({ string }, { [string]: boolean })
	local traitsJson = animal:GetAttribute("Traits")
	local traitList: { string } = {}
	local traitSet: { [string]: boolean } = {}

	if traitsJson then
		local success, decoded = pcall(function()
			return HttpService:JSONDecode(traitsJson)
		end)
		if success and type(decoded) == "table" then
			traitList = decoded
			for _, trait in ipairs(decoded) do
				traitSet[trait] = true
			end
		end
	end

	return traitList, traitSet
end

local function hasBlockingTrait(animal: Instance): boolean
	local _, traitSet = getTraits(animal)
	for trait in pairs(BLOCKING_TRAITS) do
		if traitSet[trait] then return true end
	end
	return false
end

local function applyGrannyTrait(animal: Instance)
	if animal:GetAttribute("HasGranny") then return end

	local traitList, traitSet = getTraits(animal)
	if traitSet["Granny"] then
		animal:SetAttribute("HasGranny", true)
		return
	end

	table.insert(traitList, "Granny")
	animal:SetAttribute("Traits", HttpService:JSONEncode(traitList))
	animal:SetAttribute("HasGranny", true)
end


local function createGrannyHitbox(grannTrove: typeof(Trove.new())): Part
	local hitbox = grannTrove:Add(Instance.new("Part"))
	hitbox.Name = HttpService:GenerateGUID(false)
	hitbox.Size = Vector3.new(2, 2, 2)
	hitbox.Transparency = 1
	hitbox.CanCollide = false
	hitbox.Anchored = true
	hitbox.CFrame = CFrame.new(getRandomFlyPosition(nil))
	hitbox:SetAttribute("Flying", true)
	CollectionService:AddTag(hitbox, "FlyingGrannyEvent")
	hitbox.Parent = workspace
	return hitbox
end


local function tweenGrannyToPosition(granny: Part, position: Vector3, trove: typeof(Trove.new()))
	local currentPos = granny.Position

	local rotateTween = trove:Add(TweenService:Create(
		granny,
		TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.Out),
		{ CFrame = CFrame.lookAt(currentPos, position) }
		), "Destroy")
	rotateTween:Play()
	rotateTween.Completed:Wait()

	if not granny.Parent then return nil end

	local direction = position - granny.Position
	local distance  = direction.Magnitude
	if distance < 0.1 then return nil end

	local duration    = distance / GRANNY_SPEED
	local finalCFrame = CFrame.lookAt(position, position + direction.Unit)

	local moveTween = trove:Add(TweenService:Create(
		granny,
		TweenInfo.new(duration, Enum.EasingStyle.Linear),
		{ CFrame = finalCFrame }
		), "Destroy")
	moveTween:Play()
	return moveTween
end


local function wanderGranny(granny: Part, grannTrove: typeof(Trove.new()))
	local cycleTrove = grannTrove:Extend()

	while isActive and granny.Parent do
		if granny:GetAttribute("IsAttacking") then
			task.wait(0.5)
			continue
		end

		granny:SetAttribute("Flying", true)
		cycleTrove:Clean()

		local pos   = getRandomFlyPosition(granny.Position)
		local tween = tweenGrannyToPosition(granny, pos, cycleTrove)
		if not tween then break end

		cycleTrove:Connect(granny:GetAttributeChangedSignal("IsAttacking"), function()
			if granny:GetAttribute("IsAttacking") then
				tween:Cancel()
			end
		end)

		tween.Completed:Wait()
		task.wait(math.random(1, 3))
	end

	cycleTrove:Destroy()
end


local function attackAnimal(granny: Part, grannTrove: typeof(Trove.new()))
	while isActive and granny.Parent do
		task.wait(math.random(TARGET_CHECK_MIN, TARGET_CHECK_MAX))

		if not isActive or activeAttacks >= MAX_ATTACKS then continue end
		if granny:GetAttribute("IsAttacking") then continue end

		local animals      = CollectionService:GetTagged("Animal")
		local candidates: { Instance } = {}
		local currentTime  = workspace:GetServerTimeNow()

		for _, animal in ipairs(animals) do
			local hasTrait = animal:GetAttribute("HasGranny")
			local isLocked = animal:GetAttribute("TargetedByGranny") ~= nil
			local lastHit  = recentlyTargeted[animal.Name] or 0

			if animal.PrimaryPart and not hasTrait and not isLocked then
				if currentTime - lastHit > RECENT_TARGET_COOLDOWN then
					if not hasBlockingTrait(animal) then
						table.insert(candidates, animal)
					end
				end
			end
		end

		if #candidates == 0 or activeAttacks >= MAX_ATTACKS then continue end

		local selected = candidates[math.random(1, #candidates)]
		activeAttacks += 1
		granny:SetAttribute("IsAttacking", true)
		granny:SetAttribute("Flying", true)
		selected:SetAttribute("TargetedByGranny", granny.Name)

		local chaseStart    = os.clock()
		local reachedTarget = false

		local chaseTrove = grannTrove:Extend()

		local chaseActive = true
		chaseTrove:Add(function()
			chaseActive = false
		end)

		chaseTrove:Connect(RunService.Heartbeat, function(dt)
			local targetLost    = not selected.Parent or not selected.PrimaryPart
			local targetAlready = selected:GetAttribute("HasGranny")
			local timedOut      = (os.clock() - chaseStart) > 15

			if not isActive or targetLost or targetAlready or timedOut then
				chaseTrove:Clean()
				return
			end

			local targetPos  = selected.PrimaryPart.Position + Vector3.new(0, 3, 0)
			local currentPos = granny.Position

			granny.CFrame = granny.CFrame:Lerp(CFrame.lookAt(currentPos, targetPos), 0.12)
			granny.Position += granny.CFrame.LookVector * GRANNY_SPEED * dt

			if (targetPos - currentPos).Magnitude <= 10 then
				granny:SetAttribute("Attack", not granny:GetAttribute("Attack"))
			end

			if (targetPos - currentPos).Magnitude <= 5 then
				reachedTarget = true
				chaseTrove:Clean()
			end
		end)

		repeat RunService.Heartbeat:Wait() until not chaseActive

		if reachedTarget and isActive and selected.Parent then
			recentlyTargeted[selected.Name] = workspace:GetServerTimeNow()
			Burst:FireAllClients(granny.Name, selected.Name)
			applyGrannyTrait(selected)

			local retreatPos = Vector3.new(
				granny.Position.X + (math.random() - 0.5) * 20,
				granny.Position.Y + 25,
				granny.Position.Z + (math.random() - 0.5) * 20
			)

			local retreatTween = grannTrove:Add(TweenService:Create(
				granny,
				TweenInfo.new(1.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out),
				{ CFrame = CFrame.new(retreatPos) }
				), "Destroy")
			retreatTween:Play()
			retreatTween.Completed:Wait()
		end

		if selected and selected.Parent then
			selected:SetAttribute("TargetedByGranny", nil)
		end

		granny:SetAttribute("IsAttacking", false)
		granny:SetAttribute("Flying", true)
		activeAttacks = math.max(0, activeAttacks - 1)

		chaseTrove:Destroy()
	end
end


local function spawnGranny()
	if not isActive then return end

	local grannTrove = eventTrove:Extend()

	local granny = createGrannyHitbox(grannTrove)
	local id     = granny.Name
	grannies[id]      = granny
	grannyTroves[id]  = grannTrove

	grannTrove:Add(task.spawn(function() wanderGranny(granny, grannTrove) end))
	grannTrove:Add(task.spawn(function() attackAnimal(granny, grannTrove) end))

	grannTrove:Add(task.spawn(function()
		while isActive do
			task.wait(5)
			if not isActive then break end

			if not grannies[id] or not grannies[id].Parent then
				grannies[id]     = nil
				grannyTroves[id] = nil

				local count = 0
				for _ in pairs(grannies) do count += 1 end

				grannTrove:Destroy()

				if isActive and count < Granny_Count then
					spawnGranny()
				end
				return
			end
		end
	end))

	grannTrove:Add(function()
		grannies[id]     = nil
		grannyTroves[id] = nil
	end)
end

local function spawnWanderingGrannies()
	for _ = 1, Granny_Count do
		spawnGranny()
	end
end


local function findWheelchairGranny(): Model?
	for _, animal in ipairs(CollectionService:GetTagged("Animal")) do
		if animal:GetAttribute("Index") == "Wheelchair Granny" and animal.Parent then
			return animal
		end
	end
	return nil
end

local function doIntroShot(wheelchairModel: Model)
	local AnimalService = getAnimalService()
	local Animals       = require(ReplicatedStorage.Datas.Animals)

	local primaryPart = wheelchairModel.PrimaryPart
	if not primaryPart then
		warn("[RipMyGranny] Wheelchair Granny has no PrimaryPart")
		return
	end

	local animalName = wheelchairModel.Name
	local posA       = primaryPart.Position
	task.wait(0.1)
	if not isActive or not wheelchairModel.Parent then return end

	local velocity     = (primaryPart.Position - posA) / 0.1
	local travelTime   = 1.8
	local predictedPos = primaryPart.Position + velocity * travelTime

	local anchor = eventTrove:Add(Instance.new("Part"))
	anchor.Name         = animalName
	anchor.Anchored     = true
	anchor.CanCollide   = false
	anchor.Transparency = 1
	anchor.Size         = Vector3.new(1, 1, 1)
	anchor.Position     = predictedPos
	anchor.Parent       = workspace

	Projectile:FireAllClients(animalName, 0, travelTime, workspace:GetServerTimeNow() + 0.05)
	task.wait(travelTime)

	eventTrove:Remove(anchor)

	if not isActive then return end
	if not wheelchairModel.Parent then
		warn("[RipMyGranny] Wheelchair Granny gone before replacement")
		return
	end

	local Animals_data = Animals["Granny"]
	if not Animals_data then
		warn("[RipMyGranny] 'Granny' not found in Animals data")
		return
	end

	Burst:FireAllClients("__introShot__", animalName)

	local newModel = AnimalService.ReplaceAnimal(
		wheelchairModel,
		Animals_data,
		{
			PlaySound           = false,
		}
	)

	if not newModel then
		warn("[RipMyGranny] ReplaceAnimal returned nil for Granny spawn")
	end
end

local function runIntroSequence(onComplete: () -> ())
	local wheelchairModel = findWheelchairGranny()

	if not wheelchairModel then
		warn("[RipMyGranny] No Wheelchair Granny found, skipping intro")
		onComplete()
		return
	end

	task.wait(SAMMY_SHOOT_DELAY)
	if not isActive then onComplete() return end

	if not wheelchairModel.Parent then
		wheelchairModel = findWheelchairGranny()
		if not wheelchairModel then
			warn("[RipMyGranny] Wheelchair Granny disappeared, skipping")
			onComplete()
			return
		end
	end

	doIntroShot(wheelchairModel)
	onComplete()
end


local function cloneServerMap()
	local mapSource
	if ServerData.IsBiggerServer() then
		mapSource = script:FindFirstChild("BiggerGrannyMapServer")
	elseif ServerData.IsTsunamiServer() then
		mapSource = script:FindFirstChild("TsunamiGrannyMapServer")
	else
		mapSource = script:FindFirstChild("GrannyMapServer")
	end

	if mapSource then
		eventTrove:Clone(mapSource).Parent = workspace
	else
		warn("[RipMyGranny] Server map source not found")
	end
end


function RipMyGranny.OnStart()
	if isActive then return end
	isActive = true

	eventTrove = Trove.new()
	hiddenInstances = {}

	ReplicatedStorage:SetAttribute("RipMyGrannyEvent", true)
	ReplicatedStorage:SetAttribute("RipMyGrannyEventMusic", true)
	local liveboard = workspace:FindFirstChild("LiveBoard")
	local originalCFrames = {}

	local function moveObject(obj, targetPos, targetRot)
		if not obj then return end

		local currentPivot = obj:GetPivot()
		originalCFrames[obj] = currentPivot

		local newCF = CFrame.new(targetPos)
		if targetRot then
			newCF = newCF * CFrame.Angles(
				math.rad(targetRot.X),
				math.rad(targetRot.Y),
				math.rad(targetRot.Z)
			)
		else
			newCF = newCF * (currentPivot - currentPivot.Position)
		end
		obj:PivotTo(newCF)
	end

	moveObject(liveboard, Vector3.new(-353.952,  4.25, -138.594))

	eventTrove:Add(function()
		for obj, oldCF in pairs(originalCFrames) do
			if obj and obj.Parent then
				obj:PivotTo(oldCF)
			end
		end
	end)
	eventTrove:Add(function()
		ReplicatedStorage:SetAttribute("RipMyGrannyEvent", nil)
		ReplicatedStorage:SetAttribute("RipMyGrannyEventMusic", nil)
		ReplicatedStorage:SetAttribute("RipMyGrannySharedPhase", nil)
	end)

	eventTrove:Add(function()
		for _, animal in ipairs(CollectionService:GetTagged("Animal")) do
			if animal:GetAttribute("TargetedByGranny") then
				animal:SetAttribute("TargetedByGranny", nil)
			end
		end
	end)

	setupHiddenInstances()

	eventTrove:Add(task.spawn(function()
		runIntroSequence(function()
			if not isActive then return end
			ReplicatedStorage:SetAttribute("RipMyGrannySharedPhase", workspace:GetServerTimeNow())
			cloneServerMap()
			spawnWanderingGrannies()
		end)
	end))
end

function RipMyGranny.OnStop()
	if not isActive then return end
	isActive = false

	if eventTrove then
		eventTrove:Destroy()
		eventTrove = nil
	end

	grannies         = {}
	grannyTroves     = {}
	recentlyTargeted = {}
	activeAttacks    = 0
	hiddenInstances  = {}
end

return RipMyGranny