local NorthPole = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Net = require(ReplicatedStorage.Packages.Net)
local NotificationService = require(ServerScriptService.Services.NotificationService)
local AnimalService = require(ServerScriptService.Services.AnimalService)
local Animals = require(ReplicatedStorage.Datas.Animals)
local SharedAnimals = require(ReplicatedStorage.Shared.Animals)
local GetAnimalBoundingBox = require(ReplicatedStorage.Shared.GetAnimalBoundingBox)
local SoundService = require(ServerScriptService.Services.SoundService)
local Ragdoll = require(ReplicatedStorage.Packages.Ragdoll)
local Trove = require(ReplicatedStorage.Packages.Trove)
local NpcPathfinding = require(ServerScriptService.Components.NpcPathfinding)
local Burst = Net:RemoteEvent(("EventService/%s/Burst"):format(script.Name))
local function GetEventService() return require(ServerScriptService.Services.EventService) end
local isActive = false
local recentlyTargeted = {}
local activeTrain = nil
local northPoleMap = nil
local deliveredGifts = 0
local MAX_GIFTS = 10
local sleighFull = false
local TARGET_COOLDOWN = 30
local CUTSCENE_DURATION = 5
local TRAIN_SPEED = 150
local COUNTDOWN_TIME = 10
local EVENT_DURATION = 180
local MAP_CENTER_WAIT = 10
local eventName = script.Name

local ELF_WALK_SPEED = 10
local ELF_ATTACK_INTERVAL = 30
local ELF_ATTACK_RANGE = 14
local ELF_RAGDOLL_DURATION = 3
local ELF_DOOR_OUT = 10
local ELF_DOOR_ANIM = 0.45
local ELF_CHASE_TIME = 10

local boardedPlayers = {}
local transportedPlayers = {}
local respawnConnections = {}
local cancelReturnTimer = nil
local cancelDepartTimer = nil
local activeElf = nil
local elfAttackThread = nil
local runTrove = nil

local StartTransition = Net:RemoteEvent(("EventService/%s/StartTransition"):format(eventName))
local StopTransition = Net:RemoteEvent(("EventService/%s/StopTransition"):format(eventName))
local ResetCamera = Net:RemoteEvent(("EventService/%s/ResetCamera"):format(eventName))
local Delivery = Net:RemoteEvent(("EventService/%s/Delivery"):format(eventName))
local PointArrow = Net:RemoteEvent(("EventService/%s/PointArrow"):format(eventName))
local Grab = Net:RemoteEvent(("EventService/%s/Grab"):format(eventName))
local SpawnBrainrot = Net:RemoteEvent(("EventService/%s/SpawnBrainrot"):format(eventName))
local SpawnGift = Net:RemoteEvent(("EventService/%s/SpawnGift"):format(eventName))
local OpenGift = Net:RemoteEvent(("EventService/%s/OpenGift"):format(eventName))
local DestroyGift = Net:RemoteEvent(("EventService/%s/DestroyGift"):format(eventName))
local GiftBurst = Net:RemoteEvent(("EventService/%s/GiftBurst"):format(eventName))

local CONVEYOR_BRAINROT_SIZE = 6

local BRAINROT_LIST = {
	"Cocoa Assassino",
	"Ballerina Peppermintina",
	"Giftini Spyderini",
	"Naughty Naughty",
	"Festive Lucky Block"
}

local CarryAnimation = ReplicatedStorage.Animations.Player.Carry
local carryingAnimations = {}

local function isOnCooldown(player)
	local lastTime = recentlyTargeted[player.UserId]
	if lastTime then
		return (os.clock() - lastTime) < TARGET_COOLDOWN
	end
	return false
end

local function setCooldown(player)
	recentlyTargeted[player.UserId] = os.clock()
end

local function cleanupCooldowns()
	local currentTime = os.clock()
	for userId, lastTime in pairs(recentlyTargeted) do
		if (currentTime - lastTime) > TARGET_COOLDOWN then
			recentlyTargeted[userId] = nil
		end
	end
end

local poleGroundParams = nil
local function snapToPoleGround(position, lift)
	lift = lift or 4
	if not northPoleMap then return CFrame.new(position + Vector3.new(0, lift, 0)) end
	if not poleGroundParams then
		poleGroundParams = RaycastParams.new()
		poleGroundParams.FilterType = Enum.RaycastFilterType.Include
		poleGroundParams.IgnoreWater = true
		poleGroundParams.FilterDescendantsInstances = { northPoleMap }
	end
	local origin = position + Vector3.new(0, 20, 0)
	local result = Workspace:Raycast(origin, Vector3.new(0, -200, 0), poleGroundParams)
	local y = result and result.Position.Y or position.Y
	return CFrame.new(position.X, y + lift, position.Z)
end

local function safeTeleport(character, targetCFrame)
	if not character then return end
	local hrp = character:FindFirstChild("HumanoidRootPart") or character.PrimaryPart
	if not hrp then return end
	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if humanoid then
		humanoid.Sit = false
		pcall(function() humanoid:ChangeState(Enum.HumanoidStateType.GettingUp) end)
		local deadline = os.clock() + 0.5
		while (humanoid.Sit or humanoid:GetState() == Enum.HumanoidStateType.Seated)
			and os.clock() < deadline do
			humanoid.Sit = false
			RunService.Heartbeat:Wait()
		end
	end
	local placeCFrame = snapToPoleGround(targetCFrame.Position, 4)
	hrp.Anchored = true
	character:PivotTo(placeCFrame)
	hrp.AssemblyLinearVelocity = Vector3.zero
	hrp.AssemblyAngularVelocity = Vector3.zero
	task.spawn(function()
		for i = 1, 21 do
			RunService.Heartbeat:Wait()
			if not (hrp and hrp.Parent) then return end
			if i % 5 == 0 then
				character:PivotTo(placeCFrame)
				hrp.AssemblyLinearVelocity = Vector3.zero
				hrp.AssemblyAngularVelocity = Vector3.zero
			end
		end
		if hrp and hrp.Parent then hrp.Anchored = false end
	end)
end

local PlotService = nil
local function returnPlayerToBase(player)
	local character = player and player.Character
	if not character then return false end
	local hrp = character:FindFirstChild("HumanoidRootPart") or character.PrimaryPart
	if not hrp then return false end
	if not PlotService then
		local ok, svc = pcall(function()
			return require(ServerScriptService.Services.PlotService)
		end)
		if ok then PlotService = svc end
	end
	if not PlotService then return false end
	local plot = PlotService.getPlot(player)
	if not plot then return false end
	local spawn = plot:FindFirstChild("Spawn")
	if not spawn or not spawn:IsA("BasePart") then return false end
	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if humanoid then
		humanoid.Sit = false
		pcall(function() humanoid:ChangeState(Enum.HumanoidStateType.GettingUp) end)
	end
	hrp.Anchored = true
	character:PivotTo(spawn.CFrame + Vector3.new(0, 3, 0))
	hrp.AssemblyLinearVelocity = Vector3.zero
	hrp.AssemblyAngularVelocity = Vector3.zero
	task.spawn(function()
		for _ = 1, 2 do RunService.Heartbeat:Wait() end
		if hrp and hrp.Parent then hrp.Anchored = false end
	end)
	return true
end

local function getNorthPoleSpawnCFrame()
	if not northPoleMap then return nil end
	local spawns = northPoleMap:FindFirstChild("Spawns")
	if not spawns then return nil end
	local spawnPoints = {}
	for _, part in spawns:GetChildren() do
		if part.Name == "Spawn" and part:IsA("BasePart") then table.insert(spawnPoints, part) end
	end
	if #spawnPoints == 0 then return nil end
	return spawnPoints[math.random(#spawnPoints)].CFrame
end

local function attachNorthPoleRespawn(player)
	if respawnConnections[player.UserId] then return end
	respawnConnections[player.UserId] = player.CharacterAdded:Connect(function(character)
		if not isActive or not transportedPlayers[player.UserId] then return end
		task.spawn(function()
			local hum = character:WaitForChild("Humanoid", 5)
			if not hum then return end
			character:WaitForChild("HumanoidRootPart", 5)
			for _ = 1, 5 do
				if not (isActive and transportedPlayers[player.UserId]) then return end
				local cf = getNorthPoleSpawnCFrame()
				if cf then
					safeTeleport(character, cf)
					return
				end
				task.wait(0.2)
			end
		end)
	end)
end

local function detachNorthPoleRespawn(player)
	local conn = respawnConnections[player.UserId]
	if conn then conn:Disconnect() respawnConnections[player.UserId] = nil end
end

local function clearTransported()
	for userId in pairs(transportedPlayers) do
		local player = Players:GetPlayerByUserId(userId)
		if player then
			player:SetAttribute("InNorthPole", nil)
			detachNorthPoleRespawn(player)
		end
	end
	table.clear(transportedPlayers)
	table.clear(boardedPlayers)
	for _, conn in pairs(respawnConnections) do conn:Disconnect() end
	table.clear(respawnConnections)
end

local function getTrainSeats()
	local seats = {}
	if not activeTrain then return seats end
	local body = activeTrain:FindFirstChild("Body")
	local seatsFolder = body and body:FindFirstChild("Seats")
	if not seatsFolder then
		warn("[NorthPole] Seats folder not found in train!")
		return seats
	end
	for _, s in seatsFolder:GetChildren() do
		if s:IsA("Seat") then
			table.insert(seats, s)
		end
	end
	return seats
end

local function enableTrainSeats()
	for _, seat in getTrainSeats() do
		seat.Anchored = true
		seat.Disabled = false
		seat.CanCollide = true
		seat.CanTouch = true
		seat.Transparency = 0.4
	end
	local body = activeTrain and activeTrain:FindFirstChild("Body")
	if body then
		for _, part in body:GetChildren() do
			if part:IsA("BasePart") and (part.Name == "Glass" or part.Name == "FakeGlass") then
				part.Transparency = 1
			end
		end
	end
end

local function hideTrainSeats()
	for _, seat in getTrainSeats() do
		seat.Anchored = true
		seat.Disabled = false
		seat.Transparency = 1
	end
end

local function getSeatedPlayers()
	local seated = {}
	for _, seat in getTrainSeats() do
		local occupant = seat.Occupant
		if occupant then
			local character = occupant.Parent
			local player = character and Players:GetPlayerFromCharacter(character)
			if player then
				seated[player.UserId] = player
			end
		end
	end
	return seated
end

local function watchSeatBoarding()
	local connections = {}
	local function recordSeat(seat)
		local occupant = seat.Occupant
		if not occupant then return end
		local character = occupant.Parent
		local player = character and Players:GetPlayerFromCharacter(character)
		if player then
			boardedPlayers[player.UserId] = player
			print("[NorthPole DEBUG] recordSeat boarded:", player.Name)
		else
			print("[NorthPole DEBUG] Occupant has no player. occupant=", occupant, "parent=", character)
		end
	end
	local seats = getTrainSeats()
	print("[NorthPole DEBUG] watchSeatBoarding: seat count =", #seats)
	for _, seat in seats do
		recordSeat(seat)
		table.insert(connections, seat:GetPropertyChangedSignal("Occupant"):Connect(function()
			print("[NorthPole DEBUG] Occupant changed on a seat. new Occupant =", seat.Occupant)
			recordSeat(seat)
		end))
	end
	return function()
		for _, conn in connections do conn:Disconnect() end
		table.clear(connections)
	end
end

local function updateBillboard()
	if not northPoleMap then return end
	local overhead = northPoleMap:FindFirstChild("Overhead")
	if not overhead then return end
	local billboard = overhead:FindFirstChild("BillboardGui")
	if not billboard then return end
	local giftsText = billboard:FindFirstChild("Gifts")
	if not giftsText or not giftsText:IsA("TextLabel") then return end
	giftsText.Text = string.format("%d/%d", deliveredGifts, MAX_GIFTS)
end

local function revealGift(number)
	if not northPoleMap then return end
	local santaSleigh = northPoleMap:FindFirstChild("SantaSleigh")
	if not santaSleigh then return end
	local giftsFolder = santaSleigh:FindFirstChild("Gifts")
	if not giftsFolder then return end
	local giftModel = giftsFolder:FindFirstChild(tostring(number))
	if not giftModel then return end
	for _, descendant in ipairs(giftModel:GetDescendants()) do
		if descendant:IsA("BasePart") then
			descendant.Transparency = 0
		end
	end
end

local function startDepartureCutscene()
	for _, player in Players:GetPlayers() do
		if transportedPlayers[player.UserId] then
			StartTransition:FireClient(player, CUTSCENE_DURATION)
		end
	end
	task.delay(CUTSCENE_DURATION - 0.5, function()
		for _, player in Players:GetPlayers() do
			if transportedPlayers[player.UserId] then
				ResetCamera:FireClient(player)
			end
		end
	end)
	task.delay(CUTSCENE_DURATION, function()
		NorthPole.OnStop()
	end)
end



local grabbableItems = {}

local function handleGrab(player, itemName)
	if not isActive then return end
	if typeof(itemName) ~= "string" then return end
	local entry = grabbableItems[itemName]
	if not entry then return end
	local mainModel = entry.model
	if not mainModel or not mainModel.Parent then
		grabbableItems[itemName] = nil
		return
	end
	local character = player.Character
	local hrp = character and character:FindFirstChild("HumanoidRootPart")
	if not hrp then return end
	if (hrp.Position - mainModel.Position).Magnitude > 18 then return end

	local StealService = require(ServerScriptService.Services.StealService)
	if StealService:IsCarryingPresent(player) or StealService:IsStealing(player) then
		NotificationService.Error(player, "You're already carrying something!")
		return
	end

	grabbableItems[itemName] = nil

	local presentTemplate = ReplicatedStorage.Models.Events["North Pole"]:FindFirstChild("Gift")
	local started = presentTemplate and StealService:StealPresent(player, presentTemplate, function()
		if player.Parent then PointArrow:FireClient(player, nil) end
	end)
	if not started then
		NotificationService.Error(player, "Couldn't grab the present.")
		return
	end

	if mainModel and mainModel.Parent then mainModel:Destroy() end

	for _, plr in ipairs(Players:GetPlayers()) do
		PointArrow:FireClient(plr, nil)
	end
	local deliveryHitbox = northPoleMap and northPoleMap:FindFirstChild("DeliveryHitbox")
	if deliveryHitbox then
		PointArrow:FireClient(player, deliveryHitbox, true)
	end
end

local function handleDelivery(player)
	if not isActive or sleighFull then return end
	local StealService = require(ServerScriptService.Services.StealService)
	if not StealService:IsCarryingPresent(player) then return end

	StealService:DeliverPresent(player)
	PointArrow:FireClient(player, nil)

	deliveredGifts += 1
	revealGift(deliveredGifts)
	updateBillboard()
	pcall(function()
		SoundService:Play(player, ReplicatedStorage.Sounds.Events["North Pole"].Deliver)
	end)

	if deliveredGifts >= MAX_GIFTS then
		sleighFull = true
		if cancelReturnTimer then cancelReturnTimer() cancelReturnTimer = nil end
		if cancelDepartTimer then cancelDepartTimer() cancelDepartTimer = nil end
		for userId in pairs(transportedPlayers) do
			local p = Players:GetPlayerByUserId(userId)
			if p then
				NotificationService.Notify(p, "The <font color=\"#FFD700\">Santa Sleigh</font> is full! Returning in 10 seconds.", 5)
			end
		end
		task.delay(10, function()
			if isActive and sleighFull then
				startDepartureCutscene()
			end
		end)
	end
end

local function startPathLoop()
	if not northPoleMap then return end
	local pathFolder = northPoleMap:FindFirstChild("Path")
	if not pathFolder then return end
	local pathPoints = {}
	for i = 1, 6 do
		local p = pathFolder:FindFirstChild(tostring(i))
		if not p or not p:IsA("BasePart") then return end
		pathPoints[i] = p
	end
	task.spawn(function()
		while isActive and northPoleMap and northPoleMap.Parent do
			local randomBrainrot = BRAINROT_LIST[math.random(#BRAINROT_LIST)]
			local brainrotData = Animals[randomBrainrot]
			if not brainrotData then warn("[NorthPole] Brainrot not found:", randomBrainrot) task.wait(0.5) continue end
			local MainModel = Instance.new("Part")
			MainModel.Name = HttpService:GenerateGUID(false)
			MainModel.Size = Vector3.new(1, 1, 1)
			MainModel.Transparency = 1
			MainModel.Anchored = true
			MainModel.CanCollide = false
			MainModel.CanQuery = false
			MainModel.CanTouch = false
			local brainrotModel = SharedAnimals:GetAnimatedModel(randomBrainrot, "Idle")
			if not brainrotModel then
				warn("[NorthPole] Animal model not found:", randomBrainrot)
				MainModel:Destroy()
				task.wait(0.5)
				continue
			end
			local ItemContainer = Instance.new("Model")
			ItemContainer.Name = "Item"
			ItemContainer.Parent = MainModel
			do
				local _, rawSize = GetAnimalBoundingBox(randomBrainrot, brainrotModel)
				local maxDim = math.max(rawSize.X, rawSize.Y, rawSize.Z)
				local fitScale = (maxDim > 0.01) and (CONVEYOR_BRAINROT_SIZE / maxDim) or 0.5
				brainrotModel:ScaleTo(math.clamp(fitScale, 0.02, 6))
			end
			brainrotModel.Parent = ItemContainer
			local itemRootPart = brainrotModel.PrimaryPart or brainrotModel:FindFirstChild("RootPart")
			if itemRootPart and itemRootPart:IsA("BasePart") then
				itemRootPart.Anchored = false
				local modelCFrame, modelSize = GetAnimalBoundingBox(randomBrainrot, brainrotModel)
				local rootToCenterY = modelCFrame.Position.Y - itemRootPart.Position.Y
				local itemWeld = Instance.new("Weld")
				itemWeld.Name = "Weld"
				itemWeld.Part0 = itemRootPart
				itemWeld.Part1 = MainModel
				itemWeld.C0 = CFrame.new(0, rootToCenterY - (modelSize.Y / 2), 0)
				itemWeld.Parent = MainModel
			else
				warn("[NorthPole] RootPart not found:", randomBrainrot)
				MainModel:Destroy()
				task.wait(0.5)
				continue
			end
			MainModel.CFrame = pathPoints[1].CFrame
			MainModel.Parent = Workspace
			local gift = nil
			local giftOffset = CFrame.new(0, 0, 0)
			local grabPrompt = nil
			task.spawn(function()
				local speed = 10
				for i = 2, #pathPoints do
					if not isActive or not MainModel or not MainModel.Parent then break end
					local targetCFrame = pathPoints[i].CFrame
					local distance = (targetCFrame.Position - MainModel.Position).Magnitude
					local duration = distance / speed
					local tween = TweenService:Create(MainModel, TweenInfo.new(duration, Enum.EasingStyle.Linear), {CFrame = targetCFrame})
					tween:Play()
					tween.Completed:Wait()
					if i == 2 and not gift then
						gift = ReplicatedStorage.Models.Events["North Pole"].Gift:Clone()
						gift.Name = "Gift"
						gift:PivotTo(MainModel.CFrame * giftOffset)
						gift.Parent = MainModel
						local giftRootPart = gift:FindFirstChild("RootPart")
						if giftRootPart and giftRootPart:IsA("BasePart") then
							giftRootPart.Anchored = false
							for _, part in ipairs(gift:GetDescendants()) do
								if part:IsA("BasePart") and part ~= giftRootPart then part.Anchored = false end
							end
							local giftWeld = Instance.new("Weld")
							giftWeld.Name = "GiftWeld"
							giftWeld.Part0 = giftRootPart
							giftWeld.Part1 = MainModel
							giftWeld.C0 = giftOffset
							giftWeld.Parent = MainModel
						end
						local animController = gift:FindFirstChildOfClass("AnimationController") or Instance.new("AnimationController", gift)
						local animator = animController:FindFirstChildOfClass("Animator") or Instance.new("Animator", animController)
						local wrapAnimation = ReplicatedStorage.Models.Events["North Pole"].Wrap
						local animTrack = animator:LoadAnimation(wrapAnimation)
						animTrack.Looped = false
						animTrack:Play()
						SoundService:PlayAllAt(ReplicatedStorage.Sounds.Events["North Pole"].PresentWrap, MainModel.Position)
						task.wait(1.2)

						for _, player in ipairs(Players:GetPlayers()) do
							if not player:GetAttribute("Stealing") then
								PointArrow:FireClient(player, MainModel, true)
							end
						end

						grabbableItems[MainModel.Name] = { model = MainModel, brainrot = randomBrainrot }
						MainModel:AddTag("NorthPoleEventGrabItem")
						MainModel:SetAttribute("GrabPrompt", true)

						MainModel.Destroying:Once(function()
							grabbableItems[MainModel.Name] = nil
							for _, plr in ipairs(Players:GetPlayers()) do
								if not plr:GetAttribute("Stealing") then
									PointArrow:FireClient(plr, nil)
								end
							end
						end)
					end
				end

				if MainModel and MainModel.Parent then MainModel:Destroy() end
			end)
			task.wait(5)
		end
	end)
end


local ELF_TURN_SPEED = 8
local elfGroundParams = nil

local function elfGroundY(x, z, fromY)
	if not northPoleMap then return nil end
	if not elfGroundParams then
		elfGroundParams = RaycastParams.new()
		elfGroundParams.FilterType = Enum.RaycastFilterType.Include
		elfGroundParams.IgnoreWater = true
		elfGroundParams.FilterDescendantsInstances = { northPoleMap }
	end
	local origin = Vector3.new(x, fromY + 20, z)
	local result = Workspace:Raycast(origin, Vector3.new(0, -200, 0), elfGroundParams)
	if result then return result.Position.Y end
	return nil
end

local function stepElf(elf, newXZ, flatDir, dt, yStand)
	local groundY = elfGroundY(newXZ.X, newXZ.Z, elf.hrp.Position.Y)
	local y = (groundY and (groundY + yStand)) or elf.hrp.Position.Y
	local newPos = Vector3.new(newXZ.X, y, newXZ.Z)

	if flatDir.Magnitude < 1e-4 then
		local look = elf.hrp.CFrame.LookVector
		flatDir = Vector3.new(look.X, 0, look.Z)
		if flatDir.Magnitude < 1e-4 then flatDir = Vector3.new(0, 0, 1) end
	end
	flatDir = flatDir.Unit

	local targetCF = CFrame.new(newPos, newPos + flatDir)
	local alpha = math.min(1, ELF_TURN_SPEED * dt)
	local eased = CFrame.new(newPos) * (elf.hrp.CFrame - elf.hrp.CFrame.Position):Lerp(targetCF - targetCF.Position, alpha)
	elf.model:PivotTo(eased)
end

local function elfWalkTo(elf, targetPos, maxTime, shouldStop, straight)
	local yStand = elf.yStand
	local startClock = os.clock()
	local waypoints = straight and { targetPos } or NpcPathfinding.computePath(elf.hrp.Position, targetPos)
	if not waypoints or #waypoints == 0 then
		waypoints = { targetPos }
	end
	for _, wp in ipairs(waypoints) do
		while isActive and elf.model.Parent do
			if shouldStop and shouldStop() then return false end
			if maxTime and (os.clock() - startClock) > maxTime then return false end
			local current = elf.hrp.Position
			local flatVec = Vector3.new(wp.X - current.X, 0, wp.Z - current.Z)
			local dist = flatVec.Magnitude
			if dist <= 2 then break end
			local dt = RunService.Heartbeat:Wait()
			local moveAmt = math.min(ELF_WALK_SPEED * dt, dist)
			local flatDir = flatVec.Unit
			stepElf(elf, current + flatDir * moveAmt, flatDir, dt, yStand)
		end
		if not (isActive and elf.model.Parent) then return false end
		if shouldStop and shouldStop() then return false end
	end
	return true
end

local function createElfRig(position)
	local model = Instance.new("Model")
	model.Name = "Elf"

	local hrp = Instance.new("Part")
	hrp.Name = "HumanoidRootPart"
	hrp.Size = Vector3.new(2, 2, 1)
	hrp.Transparency = 1
	hrp.Anchored = true
	hrp.CanCollide = false
	hrp.CanQuery = false
	hrp.CanTouch = false
	hrp.CFrame = CFrame.new(position)
	hrp.Parent = model

	model.PrimaryPart = hrp
	model.Parent = Workspace
	model:AddTag("Elf")
	return model, hrp
end

local function pickElfHouse()
	local houses = northPoleMap and northPoleMap:FindFirstChild("Houses")
	if not houses then return nil end
	local valid = {}
	for _, house in houses:GetChildren() do
		local spawn = house:FindFirstChild("ElfSpawn", true)
		local door = house:FindFirstChild("Door")
		if spawn and spawn:IsA("BasePart") and door then
			table.insert(valid, house)
		end
	end
	if #valid == 0 then return nil end
	return valid[math.random(#valid)]
end

local function chaseAndStrike(elf, player)
	local deadline = os.clock() + ELF_CHASE_TIME
	local reached = false
	elf.model:SetAttribute("IsRunning", true)
	local chasePath, chaseIndex, lastRepath = nil, 1, -math.huge
	while isActive and elf.model.Parent and os.clock() < deadline do
		local dt = RunService.Heartbeat:Wait()
		local character = player.Character
		local targetHrp = character and character:FindFirstChild("HumanoidRootPart")
		if not targetHrp then break end
		local current = elf.hrp.Position
		local tp = targetHrp.Position
		if Vector3.new(tp.X - current.X, 0, tp.Z - current.Z).Magnitude <= ELF_ATTACK_RANGE then
			reached = true
			break
		end
		if (not chasePath) or chaseIndex > #chasePath or (os.clock() - lastRepath) > 0.6 then
			chasePath = NpcPathfinding.computePath(current, tp) or { tp }
			chaseIndex = 1
			lastRepath = os.clock()
		end
		local wp = chasePath[chaseIndex]
		local flatVec = Vector3.new(wp.X - current.X, 0, wp.Z - current.Z)
		while flatVec.Magnitude <= 2 and chaseIndex < #chasePath do
			chaseIndex += 1
			wp = chasePath[chaseIndex]
			flatVec = Vector3.new(wp.X - current.X, 0, wp.Z - current.Z)
		end
		if flatVec.Magnitude > 0.1 then
			local flatDir = flatVec.Unit
			local moveAmt = math.min(ELF_WALK_SPEED * dt, flatVec.Magnitude)
			stepElf(elf, current + flatDir * moveAmt, flatDir, dt, elf.yStand)
		end
	end
	elf.model:SetAttribute("IsRunning", false)

	local character = player.Character
	local targetHrp = character and character:FindFirstChild("HumanoidRootPart")
	if reached and character and targetHrp and isActive and elf.model.Parent then
		local elfPos = elf.hrp.Position
		elf.model:PivotTo(CFrame.lookAt(elfPos, Vector3.new(targetHrp.Position.X, elfPos.Y, targetHrp.Position.Z)))
		elf.model:SetAttribute("AttackAnimation", (elf.model:GetAttribute("AttackAnimation") or 0) + 1)
		task.wait(0.35)
		Burst:FireAllClients(targetHrp.Position)
		pcall(function() Ragdoll.TimedRagdoll(character, ELF_RAGDOLL_DURATION) end)
	end
end

local function runHouseElf(player)
	local house = pickElfHouse()
	if not house then return end
	local spawnPart = house:FindFirstChild("ElfSpawn", true)
	local door = house:FindFirstChild("Door")
	if not spawnPart or not door then return end

	local spawnPos = spawnPart.Position
	local doorPos = door:GetPivot().Position
	local flatOut = Vector3.new(doorPos.X - spawnPos.X, 0, doorPos.Z - spawnPos.Z)
	if flatOut.Magnitude < 0.1 then
		local look = door:GetPivot().LookVector
		flatOut = Vector3.new(look.X, 0, look.Z)
	end
	if flatOut.Magnitude < 0.1 then flatOut = Vector3.new(0, 0, 1) end
	local outsidePos = doorPos + flatOut.Unit * ELF_DOOR_OUT

	local yStand = 3
	local groundY = elfGroundY(spawnPos.X, spawnPos.Z, spawnPos.Y) or spawnPos.Y
	local model, hrp = createElfRig(Vector3.new(spawnPos.X, groundY + yStand, spawnPos.Z))
	local elf = { model = model, hrp = hrp, yStand = yStand, door = door }
	activeElf = elf

	door:SetAttribute("Open", true)
	task.wait(ELF_DOOR_ANIM)
	if isActive and elf.model.Parent then
		elf.model:SetAttribute("IsRunning", true)
		elfWalkTo(elf, outsidePos, 8, nil, true)
	end
	door:SetAttribute("Open", false)

	if isActive and elf.model.Parent then
		chaseAndStrike(elf, player)
	end

	if isActive and elf.model.Parent then
		elf.model:SetAttribute("IsRunning", true)
		elfWalkTo(elf, outsidePos, 12, nil, false)
		door:SetAttribute("Open", true)
		task.wait(ELF_DOOR_ANIM)
		if isActive and elf.model.Parent then
			elfWalkTo(elf, spawnPos, 8, nil, true)
		end
		elf.model:SetAttribute("IsRunning", false)
	end

	pcall(function() door:SetAttribute("Open", false) end)
	if elf.model then elf.model:Destroy() end
	if activeElf == elf then activeElf = nil end
end

local function startElves()
	activeElf = nil
	elfGroundParams = nil

	elfAttackThread = task.spawn(function()
		while isActive and northPoleMap and northPoleMap.Parent do
			task.wait(ELF_ATTACK_INTERVAL)
			if not (isActive and northPoleMap and northPoleMap.Parent) then break end
			if activeElf then continue end
			local targets = {}
			for userId in pairs(transportedPlayers) do
				local player = Players:GetPlayerByUserId(userId)
				local character = player and player.Character
				local hum = character and character:FindFirstChildOfClass("Humanoid")
				if player and character and hum and hum.Health > 0 then
					table.insert(targets, player)
				end
			end
			if #targets == 0 then continue end
			local player = targets[math.random(#targets)]
			task.spawn(runHouseElf, player)
		end
	end)
end

local function stopElves()
	if elfAttackThread then
		task.cancel(elfAttackThread)
		elfAttackThread = nil
	end
	if activeElf then
		if activeElf.door then pcall(function() activeElf.door:SetAttribute("Open", false) end) end
		if activeElf.model and activeElf.model.Parent then activeElf.model:Destroy() end
		activeElf = nil
	end
	elfGroundParams = nil
end

local function spawnMapAndPlayers()
	print("[NorthPole DEBUG] spawnMapAndPlayers CALLED")
	local mainMap = script:FindFirstChild("MainNorthPoleMap")
	if not mainMap then warn("[NorthPole DEBUG] MainNorthPoleMap missing") return end
	northPoleMap = mainMap:Clone()
	northPoleMap.Parent = Workspace
	do
		local deliveryHitbox = northPoleMap:FindFirstChild("DeliveryHitbox")
		if deliveryHitbox then deliveryHitbox:AddTag("NorthPoleDeliveryHitboxes") end
	end
	poleGroundParams = nil
	elfGroundParams = nil
	for _ = 1, 3 do RunService.Heartbeat:Wait() end
	local spawns = northPoleMap:FindFirstChild("Spawns")
	if not spawns then warn("[NorthPole DEBUG] cloned map has NO Spawns folder") return end
	local spawnPoints = {}
	for _, part in spawns:GetChildren() do
		if part.Name == "Spawn" and part:IsA("BasePart") then table.insert(spawnPoints, part) end
	end
	if #spawnPoints == 0 then warn("[NorthPole DEBUG] spawnMapAndPlayers: NO SPAWN POINTS, aborting teleport") return end
	print("[NorthPole DEBUG] spawnMapAndPlayers: spawnPoints =", #spawnPoints)
	local boardedCount = 0
	for _ in boardedPlayers do boardedCount += 1 end
	print("[NorthPole DEBUG] spawnMapAndPlayers: boardedPlayers =", boardedCount)
	table.clear(transportedPlayers)
	for userId, player in boardedPlayers do
		if player.Parent then
			transportedPlayers[userId] = true
			player:SetAttribute("InNorthPole", true)
			attachNorthPoleRespawn(player)
		end
	end
	table.clear(boardedPlayers)
	for _, player in Players:GetPlayers() do
		if transportedPlayers[player.UserId] then
			task.spawn(function()
				local character = player.Character
				if not character then
					local startWait = os.clock()
					repeat
						task.wait(0.1)
						character = player.Character
					until character or (os.clock() - startWait) > 5 or not player.Parent
				end
				if not character then return end
				local humanoid = character:FindFirstChildOfClass("Humanoid")
				if humanoid then
					local seatPart = humanoid.SeatPart
					humanoid.Sit = false
					if seatPart then
						pcall(function() seatPart:Sit(nil) end)
						local seatWeld = seatPart:FindFirstChild("SeatWeld")
						if seatWeld then seatWeld:Destroy() end
					end
					local hrp0 = character:FindFirstChild("HumanoidRootPart")
					if hrp0 then
						local w = hrp0:FindFirstChild("SeatWeld")
						if w then w:Destroy() end
					end
					pcall(function() humanoid:ChangeState(Enum.HumanoidStateType.GettingUp) end)
				end
				RunService.Heartbeat:Wait()
				local hrp = character:FindFirstChild("HumanoidRootPart") or character.PrimaryPart
				if hrp then
					local spawn = spawnPoints[math.random(#spawnPoints)]
					print("[NorthPole DEBUG] Teleporting", player.Name, "to", spawn.CFrame.Position)
					safeTeleport(character, spawn.CFrame)
				else
					warn("[NorthPole DEBUG] No HRP for", player.Name)
				end
			end)
		end
	end
	deliveredGifts = 0
	sleighFull = false
	updateBillboard()
	startPathLoop()
	startElves()
	if cancelReturnTimer then cancelReturnTimer() cancelReturnTimer = nil end
	local returnAudience = {}
	for userId in pairs(transportedPlayers) do
		local p = Players:GetPlayerByUserId(userId)
		if p then table.insert(returnAudience, p) end
	end
	cancelReturnTimer = NotificationService.TimerForPlayers(
		returnAudience,
		"NorthPoleReturn",
		EVENT_DURATION,
		function(remaining)
			local s = remaining == 1 and "" or "S"
			return string.format("<font color=\"#FFFFFF\">RETURNING IN</font> %d SECOND%s", remaining, s)
		end,
		nil,
		nil,
		function()
			if isActive and not sleighFull then startDepartureCutscene() end
		end
	)
end

local function startTrainCutscene()
	local trainModel = script:FindFirstChild("BrainrotExpress")
	if not trainModel then return end
	activeTrain = trainModel:Clone()
	local road = Workspace:FindFirstChild("Road")
	if not road then 
		warn("[NorthPole] Road not found!")
		return 
	end

	local startGround = road:FindFirstChild("StartGround")
	local mapCenterGround = Workspace:FindFirstChild("MapCenterGround")

	if not startGround or not mapCenterGround then 
		warn("[NorthPole] StartGround or MapCenterGround not found!")
		if activeTrain then activeTrain:Destroy() end
		return 
	end

	if not activeTrain.PrimaryPart then 
		activeTrain.PrimaryPart = activeTrain:FindFirstChildWhichIsA("BasePart")
		if not activeTrain.PrimaryPart then
			warn("[NorthPole] Train has no PrimaryPart!")
			activeTrain:Destroy()
			return
		end
	end
	if activeTrain then
		SoundService:PlayAll(ReplicatedStorage.Sounds.Events["North Pole"].ChooChoo)
	end
	for _, part in ipairs(activeTrain:GetDescendants()) do
		if part:IsA("BasePart") then
			part.Anchored = true
			if part:IsA("Seat") then
				part.Disabled = true
				part.Transparency = 1
			end
		end
	end

	local cameraMarker = activeTrain:FindFirstChild("Camera")
	if cameraMarker and cameraMarker:IsA("BasePart") then
		cameraMarker.Transparency = 1
		cameraMarker.CanCollide = false
		cameraMarker.CanQuery = false
		cameraMarker.CanTouch = false
	end

	activeTrain.Parent = Workspace

	local startPos = startGround.Position
	local endPos = mapCenterGround.Position
	local direction = (endPos - startPos).Unit

	local startCFrame = CFrame.lookAt(startPos, endPos)
	local endCFrame = CFrame.lookAt(endPos, endPos + direction)

	activeTrain:PivotTo(startCFrame)
	local distance = (endPos - startPos).Magnitude
	local duration = distance / TRAIN_SPEED

	print(string.format("[NorthPole Train] Distance: %.2f studs, Duration: %.2f seconds", distance, duration))

	local tweenInfo = TweenInfo.new(
		duration,
		Enum.EasingStyle.Sine,
		Enum.EasingDirection.InOut,
		0,
		false,
		0
	)

	local cframeValue = Instance.new("CFrameValue")
	cframeValue.Value = startCFrame

	local tween = TweenService:Create(cframeValue, tweenInfo, {Value = endCFrame})

	local connection
	connection = RunService.Heartbeat:Connect(function()
		if not activeTrain or not activeTrain.Parent then 
			if connection then connection:Disconnect() end
			if cframeValue then cframeValue:Destroy() end
			return 
		end

		activeTrain:PivotTo(cframeValue.Value)
	end)

	tween.Completed:Connect(function()
		if connection then connection:Disconnect() end
		if cframeValue then cframeValue:Destroy() end

		print("[NorthPole] Train arrived at MapCenterGround")


		enableTrainSeats()
		table.clear(boardedPlayers)

		if cancelDepartTimer then cancelDepartTimer() cancelDepartTimer = nil end
		cancelDepartTimer = NotificationService.BroadcastTimer(
			"NorthPoleDepart",
			10,
			function(remaining)
				local s = remaining == 1 and "" or "S"
				return string.format("<font color=\"#FF0000\">BRAINROT EXPRESS</font> DEPARTS IN %d SECOND%s", remaining, s)
			end
		)

		local stopWatching = watchSeatBoarding()
		local boardingDeadline = os.clock() + 10
		task.spawn(function()
			while os.clock() < boardingDeadline and activeTrain and activeTrain.Parent do
				for userId, player in getSeatedPlayers() do
					boardedPlayers[userId] = player
				end
				task.wait(0.25)
			end
		end)

		task.wait(10)

		for userId, player in getSeatedPlayers() do
			boardedPlayers[userId] = player
		end
		if stopWatching then stopWatching() end
		hideTrainSeats()

		local boardedCount = 0
		for _ in boardedPlayers do boardedCount += 1 end
		print("[NorthPole DEBUG] boardedPlayers count after boarding window =", boardedCount)

		if activeTrain and activeTrain.Parent then
			local trainPos = activeTrain:GetPivot().Position
			for _, player in Players:GetPlayers() do
				if not boardedPlayers[player.UserId] then
					local character = player.Character
					local hrp = character and character:FindFirstChild("HumanoidRootPart")
					if hrp then
						local flat = Vector3.new(hrp.Position.X - trainPos.X, 0, hrp.Position.Z - trainPos.Z)
						if flat.Magnitude <= 40 and math.abs(hrp.Position.Y - trainPos.Y) <= 20 then
							boardedPlayers[player.UserId] = player
						end
					end
				end
			end
		end

		local endGround = road:FindFirstChild("EndTrain")
		if endGround and activeTrain and activeTrain.Parent then
			local endPos = endGround.Position
			local currentPos = activeTrain:GetPivot().Position
			local direction = (endPos - currentPos).Unit

			local endCFrame = CFrame.lookAt(endPos, endPos + direction)
			local distance = (endPos - currentPos).Magnitude
			local duration = distance / TRAIN_SPEED

			local tweenInfo2 = TweenInfo.new(
				duration,
				Enum.EasingStyle.Sine,
				Enum.EasingDirection.InOut,
				0,
				false,
				0
			)

			local cframeValue2 = Instance.new("CFrameValue")
			cframeValue2.Value = activeTrain:GetPivot()

			local tween2 = TweenService:Create(cframeValue2, tweenInfo2, {Value = endCFrame})

			local connection2
			connection2 = RunService.Heartbeat:Connect(function()
				if not activeTrain or not activeTrain.Parent then 
					if connection2 then connection2:Disconnect() end
					if cframeValue2 then cframeValue2:Destroy() end
					return 
				end

				activeTrain:PivotTo(cframeValue2.Value)
			end)

			tween2.Completed:Connect(function()
				if connection2 then connection2:Disconnect() end
				if cframeValue2 then cframeValue2:Destroy() end

				for _, player in Players:GetPlayers() do 
					if boardedPlayers[player.UserId] then StartTransition:FireClient(player, CUTSCENE_DURATION) end 
				end

				task.delay(CUTSCENE_DURATION - 0.5, function() 
					for _, player in Players:GetPlayers() do 
						if boardedPlayers[player.UserId] then ResetCamera:FireClient(player) end 
					end 
				end)

				task.delay(CUTSCENE_DURATION, function()
					if activeTrain then 
						activeTrain:Destroy() 
						print("[NorthPole] Train destroyed")
					end
					activeTrain = nil
					spawnMapAndPlayers()
				end)
			end)

			tween2:Play()
		else
			for _, player in Players:GetPlayers() do 
				if boardedPlayers[player.UserId] then StartTransition:FireClient(player, CUTSCENE_DURATION) end 
			end

			task.delay(CUTSCENE_DURATION - 0.5, function() 
				for _, player in Players:GetPlayers() do 
					if boardedPlayers[player.UserId] then ResetCamera:FireClient(player) end 
				end 
			end)

			task.delay(CUTSCENE_DURATION, function()
				if activeTrain then 
					activeTrain:Destroy() 
					print("[NorthPole] Train destroyed")
				end
				activeTrain = nil
				spawnMapAndPlayers()
			end)
		end
	end)

	tween:Play()
end

local SANTA_TAG            = "NorthPoleSantaSleign"
local SANTA_HEIGHT         = 200
local SANTA_SPEED          = 70
local SANTA_BOB            = 3
local SNOW_DROP_INTERVAL   = 5
local SNOW_MAX_PRESENTS    = 25
local SNOW_PRESENT_FALL    = 5
local SNOW_PRESENT_LIFETIME = 180
local SANTA_ARRIVE_TIME    = 10

local snowSanta = nil
local snowGifts = {}
local snowGeneration = 0

local function getWanderParts()
	local events = Workspace:FindFirstChild("Events")
	local folder = events and events:FindFirstChild("Wander")
	local parts = {}
	if folder then
		for _, p in folder:GetChildren() do
			if p:IsA("BasePart") then table.insert(parts, p) end
		end
	end
	return parts
end

local function randomPointInPart(part, lift)
	local lx = (math.random() - 0.5) * part.Size.X
	local lz = (math.random() - 0.5) * part.Size.Z
	local p = (part.CFrame * CFrame.new(lx, 0, lz)).Position
	return p + Vector3.new(0, lift or 0, 0)
end

local function clearSnowGifts(fireDestroy)
	for giftId in pairs(snowGifts) do
		if fireDestroy then
			DestroyGift:FireAllClients(giftId)
		end
	end
	table.clear(snowGifts)
end

local function claimSnowGift(player, giftId)
	if typeof(giftId) ~= "string" then return end
	local gift = snowGifts[giftId]
	if not gift then return end
	if not player or not player.Parent then return end

	local char = player.Character
	local hrp = char and char:FindFirstChild("HumanoidRootPart")
	if not hrp or (hrp.Position - gift.landPos).Magnitude > 30 then return end

	local animalData = Animals[gift.brainrot]
	if not animalData then return end

	snowGifts[giftId] = nil
	DestroyGift:FireAllClients(giftId)
	GiftBurst:FireAllClients(gift.landPos)

	local spawnPart = Instance.new("Part")
	spawnPart.Name = "SnowSpawn"
	spawnPart.Anchored = true
	spawnPart.Transparency = 1
	spawnPart.CanCollide = false
	spawnPart.CanQuery = false
	spawnPart.CanTouch = false
	spawnPart.Size = Vector3.one
	spawnPart.CFrame = CFrame.new(gift.landPos)
	spawnPart.Parent = Workspace

	pcall(function()
		AnimalService.spawnAnimalCustom(
			animalData,
			nil,
			nil,
		    nil,
			{ Start = spawnPart, End = spawnPart, Owner = player },
			1.5,
			true,
			false
		)
	end)
	task.delay(8, function() if spawnPart and spawnPart.Parent then spawnPart:Destroy() end end)
end

local function dropSnowGift(myGen, fromPos, brainrot)
	local wanderParts = getWanderParts()
	if #wanderParts == 0 then return end
	local landPos = randomPointInPart(wanderParts[math.random(#wanderParts)], 3)

	local giftId = HttpService:GenerateGUID(false)
	snowGifts[giftId] = { brainrot = brainrot, landPos = landPos }

	SpawnGift:FireAllClients(giftId, brainrot, fromPos, landPos, Workspace:GetServerTimeNow(), SNOW_PRESENT_FALL)

	task.delay(SNOW_PRESENT_LIFETIME, function()
		if myGen == snowGeneration and snowGifts[giftId] then
			snowGifts[giftId] = nil
			DestroyGift:FireAllClients(giftId)
		end
	end)
end

function NorthPole.StartSnowSleigh(count)
	snowGeneration += 1
	local myGen = snowGeneration

	count = math.clamp(math.floor(tonumber(count) or 0), 0, SNOW_MAX_PRESENTS)
	if count <= 0 then return end

	local wanderParts = getWanderParts()
	if #wanderParts == 0 then
		warn("[NorthPole] Snow: no Workspace.Events.Wander parts found")
		return
	end

	if snowSanta then snowSanta:Destroy() snowSanta = nil end
	clearSnowGifts(true)

	local giftQueue = table.create(count)
	for i = 1, count do
		giftQueue[i] = BRAINROT_LIST[math.random(#BRAINROT_LIST)]
	end

	local santa = Instance.new("Part")
	santa.Name = "SnowSanta"
	santa.Size = Vector3.new(6, 3, 12)
	santa.Transparency = 1
	santa.Anchored = true
	santa.CanCollide = false
	santa.CanQuery = false
	santa.CanTouch = false
	santa.CFrame = CFrame.new(randomPointInPart(wanderParts[math.random(#wanderParts)], SANTA_HEIGHT))
	santa.Parent = Workspace
	santa:AddTag(SANTA_TAG)
	snowSanta = santa

	local function refreshGifts()
		local arr = {}
		for i = 1, math.min(#giftQueue, 10) do arr[i] = giftQueue[i] end
		santa:SetAttribute("Gifts", HttpService:JSONEncode(arr))
	end
	refreshGifts()
    GetEventService():ExecuteEvent("Snow")

	local delivering = true

	task.spawn(function()
		while delivering and myGen == snowGeneration and santa.Parent do
			local dest = randomPointInPart(wanderParts[math.random(#wanderParts)], SANTA_HEIGHT)
			local from = santa.Position
			local dur = math.max((dest - from).Magnitude / SANTA_SPEED, 0.1)
			local t0 = os.clock()
			while delivering and myGen == snowGeneration and santa.Parent do
				local a = math.clamp((os.clock() - t0) / dur, 0, 1)
				local pos = from:Lerp(dest, a)
				local bob = math.sin(os.clock() * 2) * SANTA_BOB
				local flat = Vector3.new(dest.X - from.X, 0, dest.Z - from.Z)
				if flat.Magnitude < 1e-3 then flat = santa.CFrame.LookVector end
				santa.CFrame = CFrame.lookAt(pos + Vector3.new(0, bob, 0), pos + Vector3.new(0, bob, 0) + flat.Unit)
				if a >= 1 then break end
				RunService.Heartbeat:Wait()
			end
			task.wait(math.random(1, 2))
		end
	end)

	task.spawn(function()
		NotificationService.BroadcastTimer(
			"NorthPoleSantaArrive",
			SANTA_ARRIVE_TIME,
			function(remaining)
				local s = remaining == 1 and "" or "S"
				return string.format("<font color=\"#FF4545\">SANTA</font> ARRIVES IN %d SECOND%s", remaining, s)
			end
		)
		for _ = 1, SANTA_ARRIVE_TIME do
			task.wait(1)
			if myGen ~= snowGeneration or not santa.Parent then return end
		end

		while #giftQueue > 0 and myGen == snowGeneration and santa.Parent do
			local brainrot = table.remove(giftQueue, 1)
			refreshGifts()
			dropSnowGift(myGen, santa.Position, brainrot)
			task.wait(SNOW_DROP_INTERVAL)
		end
		if myGen ~= snowGeneration or not santa.Parent then return end

		delivering = false
		local dir = santa.CFrame.LookVector
		local from = santa.Position
		local away = from + dir * 8000 + Vector3.new(0, 1500, 0)
		local flyDur = 5
		local t0 = os.clock()
		while myGen == snowGeneration and santa.Parent do
			local a = math.clamp((os.clock() - t0) / flyDur, 0, 1)
			local pos = from:Lerp(away, a)
			santa.CFrame = CFrame.lookAt(pos, pos + dir)
			if a >= 1 then break end
			RunService.Heartbeat:Wait()
		end
		if myGen ~= snowGeneration then return end

		local svc = GetEventService()
		if svc and not isActive then
			pcall(function() svc:CancelEvent(eventName) end)
		end
		if snowSanta == santa then snowSanta = nil end
		santa:Destroy()
	end)
end

function NorthPole.StopSnowSleigh()
	snowGeneration += 1
	if snowSanta then snowSanta:Destroy() snowSanta = nil end
	clearSnowGifts(true)
end

function NorthPole.OnStart()
	if isActive then return end
	isActive = true
	ReplicatedStorage:SetAttribute("NorthPoleEventInMap", true)
	ReplicatedStorage:SetAttribute("NorthPoleEventActive", true)
	runTrove = Trove.new()
	runTrove:Add(task.spawn(function()
		while isActive do task.wait(TARGET_COOLDOWN) cleanupCooldowns() end
	end))
	runTrove:Connect(Delivery.OnServerEvent, function(player) handleDelivery(player) end)
	runTrove:Connect(Grab.OnServerEvent, function(player, itemName) handleGrab(player, itemName) end)
	runTrove:Connect(SpawnBrainrot.OnServerEvent, function(player)
		if not isActive or isOnCooldown(player) then return end
		setCooldown(player)
	end)
	local arriveDone = false
	NotificationService.BroadcastTimer(
		"NorthPoleArrive",
		COUNTDOWN_TIME,
		function(remaining)
			local s = remaining == 1 and "" or "S"
			return string.format("<font color=\"#FF0000\">BRAINROT EXPRESS</font> ARRIVES IN %d SECOND%s", remaining, s)
		end,
		nil,
		nil,
		function() arriveDone = true end
	)
	repeat task.wait(0.25) until arriveDone or not isActive
	if not isActive then return end
	startTrainCutscene()
end

function NorthPole.OnStop()
	if not isActive then return end
	isActive = false
	if runTrove then runTrove:Clean() runTrove = nil end
	local giftsCollected = deliveredGifts
	ReplicatedStorage:SetAttribute("NorthPoleEventInMap", false)
	ReplicatedStorage:SetAttribute("NorthPoleEventActive", false)
	table.clear(recentlyTargeted)
	if cancelReturnTimer then cancelReturnTimer() cancelReturnTimer = nil end
	if cancelDepartTimer then cancelDepartTimer() cancelDepartTimer = nil end
	NotificationService.CloseBroadcast("NorthPoleReturn", 0.5)
	NotificationService.CloseBroadcast("NorthPoleDepart", 0.5)
	NotificationService.CloseBroadcast("NorthPoleArrive", 0.5)
	stopElves()

	local playersToReturn = {}
	for userId in pairs(transportedPlayers) do
		local player = Players:GetPlayerByUserId(userId)
		if player then table.insert(playersToReturn, player) end
	end
	for _, player in ipairs(playersToReturn) do
		pcall(returnPlayerToBase, player)
	end

	do
		local StealService = require(ServerScriptService.Services.StealService)
		for _, player in ipairs(playersToReturn) do
			if StealService:IsCarryingPresent(player) then
				StealService:CancelPresent(player)
			end
		end
	end

	if giftsCollected > 0 then
		task.spawn(function()
			NorthPole.StartSnowSleigh(giftsCollected)
		end)
	end

	clearTransported()
	if activeTrain then activeTrain:Destroy() end
	activeTrain = nil
	if northPoleMap then northPoleMap:Destroy() end
	northPoleMap = nil
	for player, track in pairs(carryingAnimations) do 
		if track then track:Stop() end 
		if player.Parent then player:SetAttribute("IsCarryingGift", nil) end
	end
	table.clear(carryingAnimations)
	for _, player in playersToReturn do
		if player.Parent then
			StopTransition:FireClient(player)
			ResetCamera:FireClient(player)
		end
	end
end

function NorthPole.OnLoad()
	OpenGift.OnServerEvent:Connect(function(player, giftId)
		claimSnowGift(player, giftId)
	end)
end

return NorthPole