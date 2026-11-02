local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local ServerStorage = game:GetService("ServerStorage")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")

local AnimalService = require(ServerScriptService.Services.AnimalService)
local PlotService = require(ServerScriptService.Services.PlotService)
local NotificationService = require(ServerScriptService.Services.NotificationService)
local ChatService = require(ServerScriptService.Services.ChatService)

local Animals = require(ReplicatedStorage.Datas.Animals)
local Mutations = require(ReplicatedStorage.Datas.Mutations)
local Traits = require(ReplicatedStorage.Datas.Traits)

local CarryAnimation = ReplicatedStorage.Animations.Player.Carry

local CollectionService = game:GetService("CollectionService")

local SpawnZone = workspace:FindFirstChild("BrainrotSpawner") and workspace.BrainrotSpawner:FindFirstChild("SpawnZone")

if not SpawnZone then
	warn("[BrainrotSpawner] SpawnZone not found at workspace.BrainrotSpawner.SpawnZone")
	return
end

-- Ground-finding raycast params (same as AnimalService)
local GROUND_RAY_PARAMS = RaycastParams.new()
GROUND_RAY_PARAMS.FilterType = Enum.RaycastFilterType.Include
GROUND_RAY_PARAMS.FilterDescendantsInstances = {workspace.Map, workspace.Terrain}

local function stickToGround(position: Vector3): Vector3
	local origin = position + Vector3.new(0, 5, 0)
	local direction = Vector3.new(0, -20, 0)
	local result = workspace:Raycast(origin, direction, GROUND_RAY_PARAMS)
	if result then
		return result.Position
	end
	-- Fallback: try without filter
	local backupParams = RaycastParams.new()
	backupParams.FilterType = Enum.RaycastFilterType.Exclude
	backupParams.FilterDescendantsInstances = {}
	local backupResult = workspace:Raycast(origin, direction, backupParams)
	if backupResult then
		return backupResult.Position
	end
	return position
end

local function getSpawnCFrame(): CFrame
	local groundPos = stickToGround(SpawnZone.Position)
	return CFrame.new(groundPos)
end

-- UnSpawnableBrainrots
local UnSpawnableBrainrots = {}
local ok, GameDataSS = pcall(function()
	return require(ServerStorage.Modules.GameData)
end)
if ok and GameDataSS and GameDataSS.UnSpawnableBrainrots then
	UnSpawnableBrainrots = GameDataSS.UnSpawnableBrainrots
end

-- Collect all Secret animals (use key for Index, not DisplayName)
local secretAnimals = {}
for name, data in pairs(Animals) do
	if data.Rarity == "Secret" then
		local isUnspawnable = false
		for _, u in ipairs(UnSpawnableBrainrots) do
			if u == data.DisplayName then isUnspawnable = true break end
		end
		if not isUnspawnable then
			table.insert(secretAnimals, {key = name, displayName = data.DisplayName, data = data})
		end
	end
end

if #secretAnimals == 0 then
	warn("[BrainrotSpawner] No Secret animals found!")
	return
end

print(string.format("[BrainrotSpawner] Found %d Secret animals", #secretAnimals))

-- State
local state = "idle"
local currentBrainrot = nil
local carryConnections = {}
local carryLoop = nil

-- Random mutation (30% chance)
local function getRandomMutation()
	if math.random(1, 100) > 30 then return nil end
	local weighted = {}
	local totalWeight = 0
	for name, data in pairs(Mutations) do
		if data.Weight and data.Weight > 0 then
			totalWeight = totalWeight + data.Weight
			table.insert(weighted, {name = name, weight = data.Weight})
		end
	end
	if #weighted == 0 then return nil end
	local rand = math.random() * totalWeight
	local cumulative = 0
	for _, entry in ipairs(weighted) do
		cumulative = cumulative + entry.weight
		if rand <= cumulative then return entry.name end
	end
	return nil
end

-- Random traits (20% chance, 1-2 traits)
local function getRandomTraits()
	if math.random(1, 100) > 20 then return {} end
	local traitNames = {}
	for name in pairs(Traits) do table.insert(traitNames, name) end
	if #traitNames == 0 then return {} end
	local numTraits = math.random(1, 2)
	local selected = {}
	for _ = 1, numTraits do
		local trait = traitNames[math.random(1, #traitNames)]
		if not table.find(selected, trait) then table.insert(selected, trait) end
	end
	return selected
end

local function clearCarryConnections()
	for _, conn in ipairs(carryConnections) do
		if conn then conn:Disconnect() end
	end
	carryConnections = {}
	if carryLoop then
		carryLoop:Disconnect()
		carryLoop = nil
	end
end

local function placeBrainrotOnZone()
	if not currentBrainrot or not currentBrainrot.model then return end
	local model = currentBrainrot.model
	local part = model.PrimaryPart

	part.Anchored = true
	part.CanCollide = false
	part.CanQuery = false
	part.CanTouch = false

	-- Use ground-finding instead of fixed 3-stud offset
	model:PivotTo(getSpawnCFrame())

	-- Create ProximityPrompt
	local promptAttachment = part:FindFirstChild("PromptAttachment")
	if not promptAttachment then
		promptAttachment = Instance.new("Attachment")
		promptAttachment.Name = "PromptAttachment"
		promptAttachment.Position = Vector3.new(0, 2, 0)
		promptAttachment.Parent = part
	end

	local oldPrompt = promptAttachment:FindFirstChildOfClass("ProximityPrompt")
	if oldPrompt then oldPrompt:Destroy() end

	local prompt = Instance.new("ProximityPrompt")
	prompt.ObjectText = currentBrainrot.displayName
	prompt.ActionText = "Steal Brainrot"
	prompt.HoldDuration = 0.5
	prompt.RequiresLineOfSight = false
	prompt.Parent = promptAttachment
	prompt:SetAttribute("UID", model.Name)
	prompt:SetAttribute("Disabled", false)
	CollectionService:AddTag(prompt, "AnimalPurchasePrompt")
	currentBrainrot.prompt = prompt

	prompt.Triggered:Connect(function(player)
		if state ~= "on_zone" then return end
		if not currentBrainrot then return end

		local character = player.Character
		if not character then return end
		local humanoid = character:FindFirstChildOfClass("Humanoid")
		if not humanoid or humanoid.Health <= 0 then return end
		local playerRoot = character:FindFirstChild("HumanoidRootPart")
		if not playerRoot then return end

		local freePodium = PlotService.getFreePodium(player)
		if not freePodium then
			NotificationService.Error(player, "Votre base est pleine !")
			return
		end

		state = "carried"

		if currentBrainrot.prompt then currentBrainrot.prompt:Destroy() end

		local animator = humanoid:FindFirstChildOfClass("Animator")
		local loadedAnim = nil
		if animator then
			loadedAnim = animator:LoadAnimation(CarryAnimation)
			loadedAnim.Looped = true
			loadedAnim:Play()
		end

		part.Anchored = true
		part.CanCollide = false

		player:SetAttribute("Stealing", true)
		player:SetAttribute("StealingIndex", currentBrainrot.displayName)

		NotificationService.Notify(player, "You stole the Secret Brainrot! Deliver it to your base!", 5, "Sounds.Sfx.Success")

		local plot = _G.playerPlots and _G.playerPlots[player.UserId]
		local deliveryHitboxes = {}
		if plot then
			for _, p in ipairs(plot:GetChildren()) do
				if p.Name == "DeliveryHitbox" then
					table.insert(deliveryHitboxes, p)
				end
			end
		end

		local delivered = false

		carryLoop = RunService.Heartbeat:Connect(function()
			if delivered then return end
			if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then return end
			local hrp = player.Character.HumanoidRootPart
			model:PivotTo(hrp.CFrame * CFrame.new(0, 5, 0))
		end)

		local function dropBrainrot()
			if delivered then return end
			delivered = true
			clearCarryConnections()
			if loadedAnim then loadedAnim:Stop() end
			player:SetAttribute("Stealing", nil)
			player:SetAttribute("StealingIndex", "")
			state = "on_zone"
			placeBrainrotOnZone()
		end

		local diedConn = humanoid.Died:Once(dropBrainrot)

		local hitConn = player:GetAttributeChangedSignal("Ragdolled"):Connect(function()
			if player:GetAttribute("Ragdolled") == true then
				dropBrainrot()
				NotificationService.Notify(player, "You dropped the Secret Brainrot!", 3, "Sounds.Sfx.Error")
			end
		end)

		local removingConn = Players.PlayerRemoving:Once(function(removedPlayer)
			if removedPlayer == player then dropBrainrot() end
		end)

		local deliveryConn
		if #deliveryHitboxes > 0 then
			deliveryConn = RunService.Heartbeat:Connect(function()
				if delivered then return end
				if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then return end
				local hrp = player.Character.HumanoidRootPart
				for _, hitbox in ipairs(deliveryHitboxes) do
					local localPos = hitbox.CFrame:PointToObjectSpace(hrp.Position)
					local halfSize = hitbox.Size / 2
					if math.abs(localPos.X) <= halfSize.X and math.abs(localPos.Y) <= halfSize.Y and math.abs(localPos.Z) <= halfSize.Z then
						delivered = true
						clearCarryConnections()
						if loadedAnim then loadedAnim:Stop() end
						player:SetAttribute("Stealing", nil)
						player:SetAttribute("StealingIndex", "")

						AnimalService.spawnAnimalInBase(player, currentBrainrot.key, currentBrainrot.mutation, currentBrainrot.traits)

						if model then model:Destroy() end
						currentBrainrot = nil
						state = "idle"

						NotificationService.Notify(player, "Secret Brainrot delivered to your base!", 5, "Sounds.Sfx.Success")

						-- Spawn next brainrot immediately, no interval
						task.spawn(spawnBrainrot)
						return
					end
				end
			end)
		end

		carryConnections = {diedConn, hitConn, removingConn, deliveryConn}
	end)
end

local function spawnBrainrot()
	if currentBrainrot and currentBrainrot.model then
		currentBrainrot.model:Destroy()
	end
	currentBrainrot = nil
	clearCarryConnections()

	local selected = secretAnimals[math.random(1, #secretAnimals)]
	local animalKey = selected.key
	local displayName = selected.displayName
	local mutation = getRandomMutation()
	local traits = getRandomTraits()

	local model = Instance.new("Model")
	model.Name = "BrainrotSpawner_" .. animalKey

	local part = Instance.new("Part")
	part.Name = "PrimaryPart"
	part.Size = Vector3.new(2, 2, 2)
	part.Transparency = 1
	part.Anchored = true
	part.CanCollide = false
	part.CanQuery = false
	part.CanTouch = false
	part.CFrame = getSpawnCFrame()
	part.Parent = model

	-- Create PromptAttachment at creation time (like AnimalService)
	local promptAttachment = Instance.new("Attachment")
	promptAttachment.Name = "PromptAttachment"
	promptAttachment.Position = Vector3.new(0, 1.714, 0)
	promptAttachment.Parent = part

	model.PrimaryPart = part

	model:SetAttribute("Index", animalKey)
	if mutation then
		model:SetAttribute("Mutation", mutation)
	end
	if traits and #traits > 0 then
		model:SetAttribute("Traits", HttpService:JSONEncode(traits))
	end

	-- Parent to MovingAnimals folder (same as AnimalService)
	local movingAnimals = workspace:FindFirstChild("MovingAnimals")
	model.Parent = movingAnimals or workspace

	model:AddTag("Animal")

	-- Ground-finding: gradually lower the model until it hits the ground
	task.spawn(function()
		local animalPart = model.PrimaryPart
		if not animalPart then return end

		local rayParams = RaycastParams.new()
		rayParams.FilterType = Enum.RaycastFilterType.Exclude
		rayParams.FilterDescendantsInstances = {model}

		local maxFallDistance = 300
		local fallSpeed = 1
		local grounded = false

		while not grounded and model and model.Parent do
			local result = workspace:Raycast(animalPart.Position, Vector3.new(0, -maxFallDistance, 0), rayParams)
			local dt = RunService.Heartbeat:Wait()

			local newY
			if result then
				local targetY = result.Position.Y + (animalPart.Size.Y / 2)
				if animalPart.Position.Y - targetY > 0.2 then
					newY = math.max(animalPart.Position.Y - fallSpeed * dt, targetY)
				else
					newY = targetY
					grounded = true
				end
			else
				newY = animalPart.Position.Y - fallSpeed * dt
			end

			local currentCF = model:GetPivot()
			local newPos = Vector3.new(currentCF.Position.X, newY, currentCF.Position.Z)
			model:PivotTo(CFrame.new(newPos) * CFrame.fromMatrix(Vector3.zero, currentCF.XVector, currentCF.YVector, currentCF.ZVector))
		end
	end)

	currentBrainrot = {
		model = model,
		key = animalKey,
		displayName = displayName,
		mutation = mutation,
		traits = traits,
		prompt = nil,
	}

	state = "on_zone"
	placeBrainrotOnZone()

	ChatService:SendMessage("<font color='#ff0000'>[SERVER] A Secret Brainrot has spawned on the SpawnZone!</font>")
	print(string.format("[BrainrotSpawner] Spawned: %s (Mutation: %s)", animalKey, tostring(mutation)))
end

_G.SpawnBrainrotSpawner = spawnBrainrot

local function setupCommand(player)
	player.Chatted:Connect(function(message)
		if message == "/SpawnBrainrotSpawner" then
			spawnBrainrot()
			print("[BrainrotSpawner] Manual spawn by " .. player.Name)
		end
	end)
end

Players.PlayerAdded:Connect(setupCommand)
for _, player in ipairs(Players:GetPlayers()) do
	setupCommand(player)
end

-- Initial spawn
task.spawn(function()
	task.wait(5)
	spawnBrainrot()
end)

print("[BrainrotSpawner] Loaded successfully")