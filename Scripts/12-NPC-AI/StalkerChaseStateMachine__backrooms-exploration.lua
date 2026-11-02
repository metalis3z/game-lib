-- Reference copy for study. Game: backrooms-exploration
-- Original: ReplicatedStorage/Parts/Level_0/Part_Spawn/Entity/AI Chase.server.lua  (Script, 420 lines)
-- What it does: Backrooms entity with IDLE/STALK/FLEE/CHASE states: hears players in a radius, hides behind cover found by raycast sampling, peeks, flees when looked at (dot-product + raycast), sometimes snaps into a chase and plays a jumpscare kill.

local CFG = {
	HearRadius       = 130,  -- Distance it notices you from the dark
	SightRadius      = 75,   -- Maximum distance it can detect you looking at it
	FleeTriggerDist  = 35,   -- Panic radius (if you get closer than this, it triggers)
	LoseRadius       = 180,  -- Distance at which it completely loses track of you

	AttackChance     = 20,    -- 5% chance to snap and enter kill mode when spotted

	IdleSpeed        = 6,
	StalkSpeed       = 11,   -- Silent, slow positioning speed
	FleeSpeed        = 35,   -- Sprints away from you
	ChaseSpeed       = 28,   -- Sprints directly AT you (Attack Mode)

	CoverSearchRadius  = 40,   
	CoverMinDist       = 25,   
	CoverSamples       = 24,   
	PeekDuration       = 2.0,  
	PeekCooldown       = 4.0,  
	RepositionCooldown = 7.0,  
	StalkCycleRate     = 0.3,  

	Sound = {
		ChaseVolume       = 0.8,   
		FootstepVolume    = 0.5,
		FootstepRateFlee  = 0.25,  
		FootstepRateIdle  = 1.2,
	}
}

local RunService         = game:GetService("RunService")
local PathfindingService = game:GetService("PathfindingService")
local Players            = game:GetService("Players")

local bacteria  = script.Parent
local humanoid  = bacteria:WaitForChild("Humanoid")
local rootPart  = bacteria:WaitForChild("HumanoidRootPart")

-- JUMPSCARE ASSETS (Must be placed directly inside this script!)
local animation      = script:FindFirstChild("JumpscareAnim")
local jumpscareSound = script:FindFirstChild("Jumpscare")

-- BACKROOMS SOUND EFFECTS (Must be inside a folder named "Sounds" under the monster model)
local soundsFolder  = bacteria:FindFirstChild("Sounds")
local chaseSound    = soundsFolder and soundsFolder:FindFirstChild("Chase") 
local lurkSound     = soundsFolder and soundsFolder:FindFirstChild("Lurk")
local footstepSound = soundsFolder and soundsFolder:FindFirstChild("Footstep")

local State = { IDLE = "IDLE", STALK = "STALK", FLEE = "FLEE", CHASE = "CHASE" }
local currentState        = State.IDLE
local actionAudioPlaying  = false
local isJumpscaring       = false

local coverPos            = nil   
local fleeTarget          = nil
local lastFleeTick        = 0
local isPeeking           = false
local peekUntil           = 0
local nextPeekAt          = 0
local nextRepositionAt    = 0
local lastStalkTick       = 0
local lastFootstepTime    = 0

local function playSound(s, vol, looped)
	if not s then return end
	s.Volume = vol; s.Looped = looped or false
	if not s.IsPlaying then s:Play() end
end

local function stopSound(s)
	if s and s.IsPlaying then s:Stop() end
end

local function tickFootstep(rate)
	if not footstepSound or isJumpscaring then return end
	local now = tick()
	if now - lastFootstepTime >= rate then
		footstepSound.Volume = CFG.Sound.FootstepVolume
		footstepSound:Play()
		lastFootstepTime = now
	end
end

local function moveToward(targetPos, speed)
	if isJumpscaring then return false end
	humanoid.WalkSpeed = speed

	local path = PathfindingService:CreatePath({
		AgentRadius  = 2.5,
		AgentHeight  = 11,
		AgentCanJump = false,
	})

	local ok = pcall(function() path:ComputeAsync(rootPart.Position, targetPos) end)

	if ok and path.Status == Enum.PathStatus.Success then
		local wps = path:GetWaypoints()
		local wp  = wps[2] or wps[1]
		if wp then 
			humanoid:MoveTo(wp.Position) 
			return true 
		end
	end

	humanoid:MoveTo(targetPos)
	return false
end

-- Uses Vector Dot Product to check if the player's camera face is aimed toward the monster
local function playerIsLookingAt(playerHRP)
	local toMonster = (rootPart.Position - playerHRP.Position).Unit
	local lookVector = playerHRP.CFrame.LookVector

	if lookVector:Dot(toMonster) > 0.4 then
		local ray = Ray.new(playerHRP.Position, toMonster * CFG.SightRadius)
		local hit = workspace:FindPartOnRayWithIgnoreList(ray, { playerHRP.Parent, bacteria })

		if not hit then
			return true
		end
	end
	return false
end

local function findCoverPosition(playerHRP)
	local myPos     = rootPart.Position
	local playerPos = playerHRP.Position
	local best      = nil
	local bestScore = math.huge  

	for i = 1, CFG.CoverSamples do
		local angle = (i / CFG.CoverSamples) * math.pi * 2
		local dir   = Vector3.new(math.cos(angle), 0, math.sin(angle))

		local ray = Ray.new(myPos, dir * CFG.CoverSearchRadius)
		local hit, hitPos = workspace:FindPartOnRayWithIgnoreList(ray, { bacteria })

		local candidatePos = hit and (hitPos - dir * 3) or (myPos + dir * CFG.CoverSearchRadius)
		local distToPlayer = (candidatePos - playerPos).Magnitude
		if distToPlayer < CFG.CoverMinDist then continue end

		local toCandidate = candidatePos - playerPos
		local testRay     = Ray.new(playerPos, toCandidate)
		local testHit     = workspace:FindPartOnRayWithIgnoreList(testRay, { playerHRP.Parent, bacteria })

		local hiddenByWall = false
		if testHit then
			local blockDist = (testHit.Position - playerPos).Magnitude
			if blockDist < toCandidate.Magnitude - 1 then
				hiddenByWall = true
			end
		end

		local distToMe = (candidatePos - myPos).Magnitude
		local score    = distToMe + (hiddenByWall and 0 or 60)  
		if score < bestScore then
			bestScore = score
			best      = candidatePos
		end
	end
	return best
end

local function getEscapeRoute(playerPos)
	local runDirection = (rootPart.Position - playerPos).Unit
	local rightVector = Vector3.new(-runDirection.Z, 0, runDirection.X)
	local randomDrift = rightVector * math.random(-15, 15)

	return rootPart.Position + (runDirection * 60) + randomDrift
end

local function getNearestPlayer()
	local nearest, nearestDist = nil, math.huge
	for _, p in ipairs(Players:GetPlayers()) do
		local c = p.Character
		if c then
			local hrp = c:FindFirstChild("HumanoidRootPart")
			local h   = c:FindFirstChildOfClass("Humanoid")
			if hrp and h and h.Health > 0 then
				local d = (hrp.Position - rootPart.Position).Magnitude
				if d < nearestDist then nearest = hrp; nearestDist = d end
			end
		end
	end
	return nearest, nearestDist
end

-- Handled locally right inside the model workspace connection
for _, part in ipairs(bacteria:GetDescendants()) do
	if part:IsA("BasePart") then
		part.Touched:Connect(function(hit)
			if currentState ~= State.CHASE or isJumpscaring then return end

			local character = hit.Parent
			if not character then return end

			local player = Players:GetPlayerFromCharacter(character)
			local targetHumanoid = character:FindFirstChildOfClass("Humanoid")
			local playerHRP = character:FindFirstChild("HumanoidRootPart")

			if player and targetHumanoid and targetHumanoid.Health > 0 and playerHRP then
				isJumpscaring = true
				humanoid.WalkSpeed = 0
				rootPart.Anchored = true
				playerHRP.Anchored = true 

				-- Forces player to look right into the monster's face
				playerHRP.CFrame = CFrame.lookAt(playerHRP.Position, Vector3.new(rootPart.Position.X, playerHRP.Position.Y, rootPart.Position.Z))

				if animation then
					local animKill = humanoid:LoadAnimation(animation)
					animKill:Play()
				end

				if jumpscareSound then
					jumpscareSound:Play()
				end

				task.wait(0.75)
				targetHumanoid.Health = 0
				task.wait(1.0)

				playerHRP.Anchored = false
				rootPart.Anchored = false
				isJumpscaring = false

				currentState = State.IDLE
				coverPos = nil; fleeTarget = nil; isPeeking = false
				stopSound(chaseSound); stopSound(lurkSound)
				actionAudioPlaying = false
			end
		end)
	end
end

local function enterIdle()
	if isJumpscaring then return end
	currentState = State.IDLE
	coverPos = nil; fleeTarget = nil; isPeeking = false
	stopSound(chaseSound)
	stopSound(lurkSound)
	actionAudioPlaying = false
end

local function enterStalk()
	if currentState == State.STALK or isJumpscaring then return end
	currentState = State.STALK
	coverPos = nil; fleeTarget = nil; isPeeking = false
	peekUntil = 0; nextPeekAt = tick() + CFG.PeekCooldown
	nextRepositionAt = 0

	-- Strict silencing forces audio loops off completely
	stopSound(chaseSound)
	stopSound(lurkSound)
	stopSound(footstepSound)
	actionAudioPlaying = false
end

local function enterFlee(playerHRP)
	if currentState == State.FLEE or isJumpscaring then return end
	currentState = State.FLEE
	coverPos = nil; isPeeking = false

	fleeTarget = getEscapeRoute(playerHRP.Position)
	lastFleeTick = tick()

	if not actionAudioPlaying and chaseSound then
		chaseSound.Volume = CFG.Sound.ChaseVolume
		chaseSound.Looped = true
		chaseSound:Play()
		actionAudioPlaying = true
	end
end

local function enterChase()
	if currentState == State.CHASE or isJumpscaring then return end
	currentState = State.CHASE
	coverPos = nil; fleeTarget = nil; isPeeking = false

	if not actionAudioPlaying and chaseSound then
		chaseSound.Volume = CFG.Sound.ChaseVolume
		chaseSound.Looped = true
		chaseSound:Play()
		actionAudioPlaying = true
	end
end

local function triggerReaction(playerHRP)
	local roll = math.random(1, 100)
	if roll <= CFG.AttackChance then
		enterChase()
	else
		enterFlee(playerHRP)
	end
end

local function updateWanderer()
	if isJumpscaring then return end
	local now = tick()
	if now < nextRepositionAt then return end

	local angle  = math.random() * math.pi * 2
	local radius = math.random(20, 65)
	local target = rootPart.Position + Vector3.new(math.cos(angle) * radius, 0, math.sin(angle) * radius)

	nextRepositionAt = now + math.random(4, 8)
	moveToward(target, CFG.IdleSpeed)
	tickFootstep(CFG.Sound.FootstepRateIdle)
end

local function updateStalk(playerHRP)
	if isJumpscaring then return end
	local now  = tick()
	local dist = (playerHRP.Position - rootPart.Position).Magnitude

	if dist <= CFG.FleeTriggerDist or (dist <= CFG.SightRadius and playerIsLookingAt(playerHRP)) then
		triggerReaction(playerHRP)
		return
	end

	if now - lastStalkTick < CFG.StalkCycleRate then return end
	lastStalkTick = now

	if isPeeking then
		if now >= peekUntil then
			isPeeking = false
		else
			humanoid.WalkSpeed = 0
			rootPart.CFrame = CFrame.lookAt(
				rootPart.Position,
				Vector3.new(playerHRP.Position.X, rootPart.Position.Y, playerHRP.Position.Z)
			)
			return
		end
	end

	if coverPos == nil or now >= nextRepositionAt then
		coverPos = findCoverPosition(playerHRP)
		nextRepositionAt = now + CFG.RepositionCooldown
		nextPeekAt = now + CFG.PeekCooldown
	end

	if coverPos then
		local distToCover = (coverPos - rootPart.Position).Magnitude
		if distToCover > 4 then
			moveToward(coverPos, CFG.StalkSpeed)
		else
			humanoid.WalkSpeed = 0
			if now >= nextPeekAt then
				isPeeking  = true
				peekUntil  = now + CFG.PeekDuration
				nextPeekAt = now + CFG.PeekCooldown + CFG.PeekDuration
			end
		end
	else
		humanoid.WalkSpeed = 0
		rootPart.CFrame = CFrame.lookAt(rootPart.Position, Vector3.new(playerHRP.Position.X, rootPart.Position.Y, playerHRP.Position.Z))
	end
end

local function updateFlee(playerHRP)
	if isJumpscaring then return end
	local dist = (playerHRP.Position - rootPart.Position).Magnitude
	if dist > CFG.LoseRadius then enterIdle(); return end

	if not fleeTarget or tick() - lastFleeTick > 2 then
		fleeTarget = getEscapeRoute(playerHRP.Position)
		lastFleeTick = tick()
	end

	local pathSuccess = moveToward(fleeTarget, CFG.FleeSpeed)
	if not pathSuccess then fleeTarget = nil end

	tickFootstep(CFG.Sound.FootstepRateFlee)
end

local function updateChase(playerHRP)
	if isJumpscaring then return end
	local dist = (playerHRP.Position - rootPart.Position).Magnitude
	if dist > CFG.LoseRadius then enterIdle(); return end

	moveToward(playerHRP.Position, CFG.ChaseSpeed)
	tickFootstep(CFG.Sound.FootstepRateFlee)
end

RunService.Heartbeat:Connect(function()
	if humanoid.Health <= 0 then
		stopSound(chaseSound); stopSound(lurkSound); return
	end

	if isJumpscaring then return end

	local playerHRP, dist = getNearestPlayer()

	if not playerHRP then
		if currentState ~= State.IDLE then enterIdle() end
		updateWanderer()
		return
	end

	if currentState == State.IDLE then
		if dist <= CFG.HearRadius then
			enterStalk()
		else
			updateWanderer()
		end

	elseif currentState == State.STALK then
		if dist > CFG.LoseRadius then
			enterIdle()
		else
			updateStalk(playerHRP)
		end

	elseif currentState == State.FLEE then
		updateFlee(playerHRP)

	elseif currentState == State.CHASE then
		updateChase(playerHRP)
	end
end)
