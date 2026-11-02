local WinterHour = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local ServerScriptService = game:GetService("ServerScriptService")

local Net = require(ReplicatedStorage.Packages.Net)
local DataStoreModule = require(ServerScriptService.Services.DataManagment)
local CaneService = require(ServerScriptService.Services.CandyService)

local WinterHourAssets = ReplicatedStorage.Controllers.EventController.Events["Winter Hour"]
local DropModel = WinterHourAssets:FindFirstChild("Drop")
local HatIdleAnim = WinterHourAssets:FindFirstChild("HatIdle")
local SequenceAnim = WinterHourAssets:FindFirstChild("Sequence")

local Burst = Net:RemoteEvent("RE/EventService/WinterHour/Burst")
local SpawnCandyCane = Net:RemoteEvent("RE/EventService/WinterHour/SpawnCandyCane")
local ClaimCandyCane = Net:RemoteEvent("RE/EventService/WinterHour/ClaimCandyCane")

local isActive = false
local candyCanes = {}
local recentlyTargeted = {}
local candyCaneCounter = 0
local strikeTask = nil
local mapDropTask = nil
local hatIdleAnimation = nil
local sequenceAnimation = nil

local MAP_CENTER = Vector3.new(-411.132, -9.518, 60.17)
local SPAWN_RADIUS = 120
local COLLECTION_DIST = 15
local CLAIM_DIST = 3
local PULL_SPEED = 35
local FALL_SPEED = 40

local winterate = workspace.Events["Winter Hour"].Model
local ACTIVE_POSITION = CFrame.new(-381.879, -7.709, 14.276)
local HIDDEN_POSITION = CFrame.new(0, 5000, 0)

local candyCaneFolder = workspace:FindFirstChild("ActiveCandyCanes") or Instance.new("Folder")
candyCaneFolder.Name = "ActiveCandyCanes"
candyCaneFolder.Parent = workspace

local function setSantaHatVisibility(visible)
	local sammy = winterate:FindFirstChild("Sammy")
	if sammy then
		local santaHat = sammy:FindFirstChild("Santa's Hat")
		if santaHat then
			for _, child in ipairs(santaHat:GetDescendants()) do
				if child:IsA("BasePart") then
					child.Transparency = visible and 0 or 1
				end
			end
		end
	end
end

local function setupIdleAnimation()
	local sammy = winterate:FindFirstChild("Sammy")
	local humanoid = sammy and sammy:FindFirstChildOfClass("Humanoid")
	if humanoid then
		local animator = humanoid:FindFirstChildOfClass("Animator") or Instance.new("Animator", humanoid)
		if HatIdleAnim then
			if hatIdleAnimation then hatIdleAnimation:Stop() end
			hatIdleAnimation = animator:LoadAnimation(HatIdleAnim)
			hatIdleAnimation.Looped = true
			hatIdleAnimation.Priority = Enum.AnimationPriority.Idle
			hatIdleAnimation:Play()
		end
	end
end

local function playSequenceAnimation()
	local sammy = winterate:FindFirstChild("Sammy")
	local humanoid = sammy and sammy:FindFirstChildOfClass("Humanoid")
	if humanoid then
		local animator = humanoid:FindFirstChildOfClass("Animator") or Instance.new("Animator", humanoid)
		if SequenceAnim then
			if hatIdleAnimation then hatIdleAnimation:Stop() end
			if sequenceAnimation then sequenceAnimation:Stop() end
			sequenceAnimation = animator:LoadAnimation(SequenceAnim)
			sequenceAnimation.Priority = Enum.AnimationPriority.Action
			sequenceAnimation:Play()
			sequenceAnimation.Stopped:Connect(function()
				if isActive then setupIdleAnimation() end
			end)
		end
	end
end

local function startCollectionLoop()
	task.spawn(function()
		while isActive do
			local dt = task.wait()

			-- Wrap in pcall to prevent one error from killing the whole event
			local success, err = pcall(function()
				for id, data in pairs(candyCanes) do
					local candyPart = data.Instance
					if not candyPart or not candyPart.Parent then 
						candyCanes[id] = nil
						continue 
					end

					local targetPlayer = nil
					local shortestDist = COLLECTION_DIST

					for _, player in ipairs(Players:GetPlayers()) do
						local char = player.Character
						local root = char and char:FindFirstChild("HumanoidRootPart")
						if root then
							local dist = (root.Position - candyPart.Position).Magnitude
							if dist < shortestDist then
								targetPlayer = player
								shortestDist = dist
							end
						end
					end

					if targetPlayer then
						local targetPos = targetPlayer.Character.HumanoidRootPart.Position
						local direction = (targetPos - candyPart.Position).Unit
						candyPart.CFrame = candyPart.CFrame + (direction * PULL_SPEED * dt)

						if shortestDist <= CLAIM_DIST then
							local amount = math.random(5, 15)  
							candyCanes[id] = nil
							candyPart:Destroy()

							CaneService:Add(targetPlayer, amount)

							ClaimCandyCane:FireAllClients(id, targetPlayer, amount)
						end
			
					elseif not data.OnGround then
						local currentPos = candyPart.Position
						if currentPos.Y > data.EndPos.Y then
							candyPart.CFrame = candyPart.CFrame - Vector3.new(0, FALL_SPEED * dt, 0)
						else
							candyPart.CFrame = CFrame.new(data.EndPos)
							data.OnGround = true
						end
					end
				end
			end)

			if not success then
				warn("WinterHour Collection Loop Error: " .. tostring(err))
			end
		end
	end)
end

local function getRandomMapPosition()
	local rx = MAP_CENTER.X + math.random(-SPAWN_RADIUS, SPAWN_RADIUS)
	local rz = MAP_CENTER.Z + math.random(-SPAWN_RADIUS, SPAWN_RADIUS)
	local rayOrigin = Vector3.new(rx, 100, rz)
	local rayDirection = Vector3.new(0, -200, 0)
	local params = RaycastParams.new()
	params.FilterType = Enum.RaycastFilterType.Exclude
	params.FilterDescendantsInstances = {candyCaneFolder, winterate}
	local result = workspace:Raycast(rayOrigin, rayDirection, params)
	return result and result.Position or Vector3.new(rx, MAP_CENTER.Y, rz)
end

local function spawnCandy(endPos, amount)
	if not DropModel then return end
	candyCaneCounter += 1
	local candyId = "candy_" .. candyCaneCounter
	local startPos = endPos + Vector3.new(0, 60, 0)

	local newCandy = DropModel:Clone()
	newCandy.Name = candyId

	-- Ensure physics won't interfere
	for _, part in ipairs(newCandy:GetDescendants()) do
		if part:IsA("BasePart") then
			part.Anchored = true
			part.CanCollide = false
			part.CanQuery = true -- Needed for distance checks
		end
	end

	if newCandy:IsA("Model") then
		newCandy:PivotTo(CFrame.new(startPos))
	else
		newCandy.CFrame = CFrame.new(startPos)
	end

	newCandy.Parent = candyCaneFolder
	candyCanes[candyId] = {Instance = newCandy, EndPos = endPos, amount = amount, OnGround = false}
	SpawnCandyCane:FireAllClients(candyId, startPos, endPos, workspace:GetServerTimeNow(), 1.2)
end

function WinterHour.OnStart()
	if isActive then return end
	isActive = true
	winterate:PivotTo(ACTIVE_POSITION)
	ReplicatedStorage:SetAttribute("WinterHourEvent", true)
	setSantaHatVisibility(true)
	setupIdleAnimation()
	startCollectionLoop()

	mapDropTask = task.spawn(function()
		while isActive do
			task.wait(4)
			spawnCandy(getRandomMapPosition(), math.random(3, 8))
		end
	end)

	strikeTask = task.spawn(function()
		while isActive do
			task.wait(math.random(6, 12))
			local animals = CollectionService:GetTagged("Animal")
			local sammy = winterate:FindFirstChild("Sammy")
			local sammyPos = sammy and sammy.PrimaryPart and sammy.PrimaryPart.Position or ACTIVE_POSITION.Position

			local target = nil
			for _, animal in ipairs(animals) do
				if animal.PrimaryPart and (animal.PrimaryPart.Position - sammyPos).Magnitude < 75 then
					local traits = animal:GetAttribute("Traits")
					if (not traits or not string.find(traits, "Santa Hat")) and not recentlyTargeted[animal.Name] then
						target = animal
						break
					end
				end
			end

			if target then
				recentlyTargeted[target.Name] = true
				playSequenceAnimation()
				task.delay(0.6, function()
					if not target or not target.Parent then return end
					local currentTraits = {}
					local json = target:GetAttribute("Traits")
					if json then pcall(function() currentTraits = HttpService:JSONDecode(json) end) end
					table.insert(currentTraits, "Santa Hat")
					target:SetAttribute("Traits", HttpService:JSONEncode(currentTraits))
					Burst:FireAllClients(target.Name)
					spawnCandy(target.PrimaryPart.Position, math.random(10, 20))
					task.wait(15)
					recentlyTargeted[target.Name] = nil
				end)
			end
		end
	end)
end

function WinterHour.OnStop()
	isActive = false
	ReplicatedStorage:SetAttribute("WinterHourEvent", false)
	if mapDropTask then task.cancel(mapDropTask) end
	if strikeTask then task.cancel(strikeTask) end
	if hatIdleAnimation then hatIdleAnimation:Stop() end
	if sequenceAnimation then sequenceAnimation:Stop() end
	setSantaHatVisibility(false)
	winterate:PivotTo(HIDDEN_POSITION)
	for _, data in pairs(candyCanes) do
		if data.Instance then data.Instance:Destroy() end
	end
	candyCanes = {}
	recentlyTargeted = {}
end

return WinterHour