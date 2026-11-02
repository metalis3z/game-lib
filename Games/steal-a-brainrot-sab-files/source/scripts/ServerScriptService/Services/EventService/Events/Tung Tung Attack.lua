local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local CollectionService = game:GetService("CollectionService")
local HttpService = game:GetService("HttpService")

local Packages = ReplicatedStorage:WaitForChild("Packages")
local Net = require(Packages.Net)
local Trove = require(Packages.Trove)
local SharedEventUtils = require(ReplicatedStorage.Shared.SharedEventUtils)

local TungTungAttackEvent = {}
TungTungAttackEvent.__index = TungTungAttackEvent

local SCAN_RADIUS             = 35
local TRAIT_NAME              = "Zombie"
local WANDER_SPEED            = 16
local CHASE_SPEED             = 22
local WANDER_PAUSE_MIN        = 1
local WANDER_PAUSE_MAX        = 2
local BABY_COUNT              = 20
local SPAWN_INTERVAL          = 2
local MAX_SIMULTANEOUS_CHASES = 2
local RECENT_TARGET_COOLDOWN  = 20
local ATTACK_SCAN_MIN         = 8
local ATTACK_SCAN_MAX         = 14

local TungTungHitEvent = Net:RemoteEvent("EventService/Tung Tung Attack/Hit")

local isActive      = false
local eventTrove    = nil
local babies        = {}
local lockedTargets = {}
local recentlyHit   = {}
local activeChases  = 0

local eventService  = require(ServerScriptService.Services.EventService)
local Animals       = require(ReplicatedStorage.Datas.Animals)
local AnimalService = require(ServerScriptService.Services.AnimalService)


local function stickToGround(position)
	local rayParams = RaycastParams.new()
	rayParams.FilterType = Enum.RaycastFilterType.Include
	rayParams.FilterDescendantsInstances = {workspace.Map, workspace.Terrain}
	local result = workspace:Raycast(position + Vector3.new(0, 10, 0), Vector3.new(0, -20, 0), rayParams)
	return result and (result.Position + Vector3.new(0, 2.5, 0)) or position
end

local function applyZombieTrait(animal)
	local currentTraits = animal:GetAttribute("Traits")
	local traitsTable   = {}
	if currentTraits then
		local ok, decoded = pcall(HttpService.JSONDecode, HttpService, currentTraits)
		if ok and type(decoded) == "table" then traitsTable = decoded end
	end
	for _, trait in ipairs(traitsTable) do
		if trait == TRAIT_NAME then return end
	end
	table.insert(traitsTable, TRAIT_NAME)
	animal:SetAttribute("Traits",   HttpService:JSONEncode(traitsTable))
	animal:SetAttribute("IsZombie", true)
end


local function createBabyBox(position)
	local model = Instance.new("Model")
	model.Name = "BabyTungTung"

	local root = Instance.new("Part")
	root.Name         = "HumanoidRootPart"
	root.Size         = Vector3.new(2, 5, 2)
	root.Transparency = 1
	root.Anchored     = true
	root.CanCollide   = false
	root.CanQuery     = false
	root.CanTouch     = false
	root.Massless     = true
	root.CFrame       = CFrame.new(position)
	root.Parent       = model
	model.PrimaryPart = root

	model:SetAttribute("IsRunning", false)
	model:SetAttribute("IsHunting", false)

	CollectionService:AddTag(model, "BabyTungTung")
	return model
end


local function wander(baby, wanderPoints)
	if not baby or not baby.Parent then return end
	if baby:GetAttribute("IsHunting") or baby:GetAttribute("IsRunning") then return end

	baby:SetAttribute("IsRunning", true)

	local part      = wanderPoints[math.random(#wanderPoints)]
	local sz        = part.Size
	local targetPos = stickToGround(part.Position + Vector3.new(
		math.random(-sz.X / 2, sz.X / 2), 0, math.random(-sz.Z / 2, sz.Z / 2)
		))

	local startPos = baby:GetPivot().Position
	local dist     = (targetPos - startPos).Magnitude
	if dist < 1 then
		baby:SetAttribute("IsRunning", false)
		return
	end

	local flatDir  = Vector3.new(targetPos.X - startPos.X, 0, targetPos.Z - startPos.Z).Unit
	local duration = dist / WANDER_SPEED

	task.spawn(function()
		local elapsed = 0
		local lastTime = os.clock()
		while elapsed < duration
			and isActive
			and baby.Parent
			and not baby:GetAttribute("IsHunting")
		do
			local now = os.clock()
			local dt  = now - lastTime
			lastTime  = now
			elapsed  += dt
			local lerpPos = stickToGround(startPos:Lerp(targetPos, math.clamp(elapsed / duration, 0, 1)))
			local goalCF  = CFrame.new(lerpPos, lerpPos + flatDir)
			baby:PivotTo(baby:GetPivot():Lerp(goalCF, 0.15))
			task.wait()
		end
		baby:SetAttribute("IsRunning", false)
	end)
end


local function startBabyLoop(baby, wanderPoints, trove)
	trove:Add(task.spawn(function()
		task.wait(math.random() * 0.5)

		wander(baby, wanderPoints)

		while isActive and baby.Parent do
			if not baby:GetAttribute("IsHunting") and not baby:GetAttribute("IsRunning") then
				task.wait(math.random(WANDER_PAUSE_MIN, WANDER_PAUSE_MAX) + math.random())
				if isActive and baby.Parent
					and not baby:GetAttribute("IsHunting")
					and not baby:GetAttribute("IsRunning")
				then
					wander(baby, wanderPoints)
				end
			else
				task.wait(0.5)
			end
		end
	end))
end


local function chaseAndAttack(baby, target, wanderPoints)
	if not baby or not baby.Parent or baby:GetAttribute("IsHunting") then return end
	if lockedTargets[target] then return end

	lockedTargets[target] = true
	activeChases         += 1
	baby:SetAttribute("IsHunting", true)
	baby:SetAttribute("IsRunning", true)
	target:SetAttribute("TargetedByTung", baby.Name)

	local chaseTrove = eventTrove:Extend()

	chaseTrove:Add(task.spawn(function()

		local reached  = false
		local lastTime = os.clock()

		while isActive and baby.Parent and target.Parent and target.PrimaryPart do
			local now = os.clock()
			local dt  = now - lastTime
			lastTime  = now

			local targetPos = target.PrimaryPart.Position
			local myPos     = baby:GetPivot().Position
			local dist      = (targetPos - myPos).Magnitude

			if dist <= 5 then reached = true; break end

			local dir     = (targetPos - myPos).Unit
			local flatDir = Vector3.new(dir.X, 0, dir.Z).Unit
			local newPos  = stickToGround(myPos + dir * math.min(CHASE_SPEED * dt, dist))
			baby:PivotTo(CFrame.new(newPos, newPos + flatDir))
			task.wait()
		end

		if reached and isActive and target and target.Parent and target.PrimaryPart and SharedEventUtils.isPointInCarpet(target.PrimaryPart.Position) then
			local elapsed   = 0
			local lastTime2 = os.clock()

			while elapsed < 0.5 and target.Parent and target.PrimaryPart do
				local now = os.clock()
				local dt  = now - lastTime2
				lastTime2 = now
				elapsed  += dt

				local diff = target.PrimaryPart.Position - baby:GetPivot().Position
				if diff.Magnitude > 0.5 then
					local dir     = diff.Unit
					local flatDir = Vector3.new(dir.X, 0, dir.Z).Unit
					local newPos  = stickToGround(baby:GetPivot().Position + dir * math.min(CHASE_SPEED * dt, diff.Magnitude))
					baby:PivotTo(CFrame.new(newPos, newPos + flatDir))
				end
				task.wait()
			end

			recentlyHit[target.Name] = os.clock()
			applyZombieTrait(target)
			TungTungHitEvent:FireAllClients(target.Name)
			task.wait(0.5)
		elseif reached and isActive and target and target.Parent then
			recentlyHit[target.Name] = os.clock()
		end

		if target and target.Parent then
			target:SetAttribute("TargetedByTung", nil)
		end
		lockedTargets[target] = nil
		activeChases = math.max(0, activeChases - 1)

		baby:SetAttribute("IsRunning", false)
		task.wait()
		baby:SetAttribute("IsHunting", false)

		task.wait(0.5)
		if isActive and baby.Parent then
			wander(baby, wanderPoints)
		end

		chaseTrove:Clean()
	end))
end

function TungTungAttackEvent.OnStart(eventData)
	if isActive then
		warn("[TungTungAttackEvent] OnStart called while already active — ignoring")
		return
	end
	isActive      = true
	eventTrove    = Trove.new()
	babies        = {}
	lockedTargets = {}
	recentlyHit   = {}
	activeChases  = 0

	local chicleteiraData = Animals["Coffin Tung Tung Tung Sahur"]
	if chicleteiraData then
		AnimalService.spawnAnimalCustom(chicleteiraData)
	end

	local eventsFolder = workspace:FindFirstChild("Events")
	local eventFolder  = eventsFolder and eventsFolder:FindFirstChild("Tung Tung Attack")
	if not eventFolder or not eventData then
		warn("[TungTungAttackEvent] Event folder or data not found")
		isActive = false; return
	end

	local wanderPoints   = {}
	local spawnPositions = {}
	for _, child in ipairs(eventFolder:GetChildren()) do
		if child:IsA("BasePart") then
			if child.Name == "Wander" then
				table.insert(wanderPoints, child)
			elseif child.Name == "SpawnPosition" then
				table.insert(spawnPositions, child)
			end
		end
	end

	if #wanderPoints == 0 or #spawnPositions == 0 then
		warn("[TungTungAttackEvent] Missing wander points or spawn positions")
		isActive = false; return
	end

	local now       = workspace:GetServerTimeNow()
	local caveDelay = eventData.startedAt + 11 - now

	eventTrove:Add(task.spawn(function()
		task.wait(math.max(0, caveDelay))
		if not isActive then return end

		local babiesFolder = workspace:FindFirstChild("BabyTungTungs")
		if babiesFolder then babiesFolder:Destroy() end
		babiesFolder        = Instance.new("Folder")
		babiesFolder.Name   = "BabyTungTungs"
		babiesFolder.Parent = workspace
		eventTrove:Add(babiesFolder)

		local lastIdx = nil
		for i = 1, BABY_COUNT do
			if not isActive then break end

			local idx = math.random(#spawnPositions)
			if #spawnPositions > 1 then
				while idx == lastIdx do idx = math.random(#spawnPositions) end
			end
			lastIdx = idx

			local baby = createBabyBox(spawnPositions[idx].Position)
			eventTrove:Add(baby)
			baby.Parent = babiesFolder
			table.insert(babies, baby)

			startBabyLoop(baby, wanderPoints, eventTrove)

			if i < BABY_COUNT then task.wait(SPAWN_INTERVAL) end
		end
	end))

	eventTrove:Add(task.spawn(function()
		task.wait(3)

		while isActive do
			if #babies > 0 and activeChases < MAX_SIMULTANEOUS_CHASES then
				local candidates = {}
				for _, animal in ipairs(CollectionService:GetTagged("Animal")) do
					if animal.PrimaryPart
						and not lockedTargets[animal]
						and not animal:GetAttribute("IsZombie")
						and not animal:GetAttribute("TargetedByTung")
					then
						local lastHit = recentlyHit[animal.Name] or 0
						if os.clock() - lastHit > RECENT_TARGET_COOLDOWN then
							table.insert(candidates, animal)
						end
					end
				end

				if #candidates > 0 then
					local free = {}
					for _, b in ipairs(babies) do
						if b.Parent and not b:GetAttribute("IsHunting") then
							table.insert(free, b)
						end
					end

					if #free > 0 then
						chaseAndAttack(
							free[math.random(#free)],
							candidates[math.random(#candidates)],
							wanderPoints
						)
					end
				end

				for name, t in pairs(recentlyHit) do
					if os.clock() - t > RECENT_TARGET_COOLDOWN + 10 then
						recentlyHit[name] = nil
					end
				end
			end

			task.wait(math.random(ATTACK_SCAN_MIN, ATTACK_SCAN_MAX))
		end
	end))
end


function TungTungAttackEvent.OnStop()
	if not isActive then return end
	isActive = false

	for _, animal in ipairs(CollectionService:GetTagged("Animal")) do
		animal:SetAttribute("TargetedByTung", nil)
	end

	if eventTrove then
		eventTrove:Clean()
		eventTrove = nil
	end

	babies        = {}
	lockedTargets = {}
	recentlyHit   = {}
	activeChases  = 0
end

return TungTungAttackEvent