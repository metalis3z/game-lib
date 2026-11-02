local Debris = game:GetService("Debris")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Packages = ReplicatedStorage:WaitForChild("Packages")
local Ragdoll = require(ReplicatedStorage.Packages.Ragdoll)

local CombatService = require(ServerScriptService.Services.CombatService)
local StealService = require(ServerScriptService.Services.StealService)

local SentryTool = {}

local Net = require(Packages.Net)
local ToolsCooldown = Net:RemoteEvent("Tools/Cooldown")

local SentryDebounce = {}
local ActiveSentries = {}
local PlayerSentries = {}
local RagdollImmunity = {}

local SENTRY_DURATION = 60
local PLACEMENT_COUNTDOWN = 3
local DETECTION_RANGE = 50
local SHOOT_RANGE = 25
local SHOOT_COOLDOWN = 2.5
local PlaceCooldown = 5

local function updateCountdown(sentry, timeLeft, isPlacing)
	local setupFrame = sentry:FindFirstChild("SetupFrame", true)
	if setupFrame then
		local mainFrame = setupFrame:FindFirstChild("MainFrame", true)
		if mainFrame then
			local timeText = mainFrame:FindFirstChild("Time", true)
			if timeText then
				if isPlacing then
					timeText.Text = ("Sentry is ready in %ds"):format(timeLeft)
					timeText.TextColor3 = Color3.fromRGB(255, 255, 255)
				else
					timeText.Text = math.ceil(timeLeft) .. "s!"
					timeText.TextColor3 = Color3.fromRGB(255, 0, 0)
				end
			end
		end
	end
end

local function ragdollPlayer(character, direction, targetRootPart)
	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if humanoid then
		local player = Players:GetPlayerFromCharacter(character)
		if player then
			local currentTime = tick()
			if RagdollImmunity[player] and currentTime - RagdollImmunity[player] < 2.5 then
				return
			end
			RagdollImmunity[player] = currentTime
		end

		pcall(function()
			if StealService:IsStealing(player) then
				StealService:CancelSteal(player)
			end

			CombatService.Fling(targetRootPart, 750)
			Ragdoll.Ragdoll(character)
			task.wait(1.5)
			Ragdoll.Unragdoll(character)
		end)
	end
end

local function createBeam(sentryPart, targetPosition, owner)
	local startPosition = sentryPart.Position
	local direction = (targetPosition - startPosition).Unit
	local distance = (targetPosition - startPosition).Magnitude

	local beam = Instance.new("Part")
	beam.Name = "SentryBullet"
	beam.Anchored = false
	beam.CanCollide = false
	beam.Color = Color3.fromRGB(255, 0, 0)
	beam.MaterialVariant = ""
	beam.Size = Vector3.new(0.75, 0.75, 2)
	beam.CFrame = CFrame.new(startPosition, targetPosition)
	beam.Parent = workspace

	local flightPower = Instance.new("BodyVelocity")
	flightPower.Name = "FlightPower"
	flightPower.MaxForce = Vector3.new(100000, 100000, 100000)
	flightPower.P = 1250
	flightPower.Velocity = direction * 150
	flightPower.Parent = beam

	local raycastParams = RaycastParams.new()
	raycastParams.FilterType = Enum.RaycastFilterType.Exclude
	local filterInstances = {workspace.CurrentCamera, beam, sentryPart}

	if owner.Character then
		table.insert(filterInstances, owner.Character)
	end
	raycastParams.FilterDescendantsInstances = filterInstances

	local startTime = tick()
	local lastPosition = startPosition
	local connection
	connection = RunService.Heartbeat:Connect(function(dt)
		if not beam.Parent then
			connection:Disconnect()
			return
		end

		local currentPosition = beam.Position
		local rayDirection = currentPosition - lastPosition

		if rayDirection.Magnitude > 0 then
			local raycast = workspace:Raycast(lastPosition, rayDirection, raycastParams)
			if raycast then
				local character = raycast.Instance.Parent
				local humanoid = character and character:FindFirstChildOfClass("Humanoid")
				if humanoid and character ~= owner.Character then
					local targetRoot = character:FindFirstChild("HumanoidRootPart")
					if targetRoot then
						ragdollPlayer(character, direction, targetRoot)
					end
					beam:Destroy()
					connection:Disconnect()
					return
				end
			end
		end

		lastPosition = currentPosition

		local elapsed = tick() - startTime
		if elapsed >= 3 then
			beam:Destroy()
			connection:Disconnect()
		end
	end)

	Debris:AddItem(beam, 3)
end

local function predictTargetPosition(target, shooterPosition, projectileSpeed)
	local currentPos = target.Position
	local character = target.Parent
	if not character then return currentPos end

	local rootPart = character:FindFirstChild("HumanoidRootPart")
	if not rootPart then return currentPos end

	local velocity = rootPart.AssemblyLinearVelocity
	local distance = (currentPos - shooterPosition).Magnitude
	local timeToHit = distance / projectileSpeed

	local predictionTime = math.min(timeToHit, 0.5)

	if velocity.Magnitude < 2 then
		return currentPos
	end

	local predictedPosition = currentPos + (velocity * predictionTime)

	local spread = Vector3.new(
		math.random(-1, 1),
		0, 
		math.random(-1, 1)
	)

	return predictedPosition + spread
end

local function manageSentry(sentry, owner)
	local sentryData = ActiveSentries[sentry]
	if not sentryData then 
		return 
	end

	local lastShot = 0

	local connection
	connection = RunService.Heartbeat:Connect(function()
		if not sentry.Parent or not ActiveSentries[sentry] then
			connection:Disconnect()
			return
		end

		local currentTime = tick()
		local timeLeft = SENTRY_DURATION - (currentTime - sentryData.startTime)

		updateCountdown(sentry, timeLeft)

		if timeLeft <= 0 then
			sentry:Destroy()
			ActiveSentries[sentry] = nil
			if PlayerSentries[owner.UserId] == sentry then
				PlayerSentries[owner.UserId] = nil
			end
			connection:Disconnect()
			return
		end

		local sentryPosition = sentry:IsA("BasePart") and sentry.Position or sentry:GetPivot().Position
		local nearestTarget = nil
		local nearestDistance = math.huge

		for _, player in pairs(Players:GetPlayers()) do
			if player ~= owner and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
				local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
				if humanoid and humanoid.Health > 0 then
					local distance = (player.Character.HumanoidRootPart.Position - sentryPosition).Magnitude
					if distance <= DETECTION_RANGE and distance < nearestDistance then
						nearestTarget = player.Character.HumanoidRootPart
						nearestDistance = distance
					end
				end
			end
		end

		if nearestTarget then
			local targetPosition = nearestTarget.Position
			local lookDirection = (Vector3.new(targetPosition.X, sentryPosition.Y, targetPosition.Z) - sentryPosition).Unit
			local facingCFrame = CFrame.new(sentryPosition, sentryPosition + lookDirection)
			sentry.CFrame = facingCFrame * CFrame.Angles(math.rad(-90), 0, 0)
		end

		if nearestTarget and nearestDistance <= SHOOT_RANGE and currentTime - lastShot >= SHOOT_COOLDOWN then
			local predictedPos = predictTargetPosition(nearestTarget, sentryPosition, 80)
			createBeam(sentry, predictedPos, owner)

			local sound = Instance.new("Sound")
			sound.SoundId = "rbxassetid://77280130656922"
			sound.Name = "Shoot"
			sound.Parent = sentry
			sound:Play()
			Debris:AddItem(sound, 2)

			lastShot = currentTime
		end
	end)
end

function SentryTool.OnExecution(Player: Player, Character: Model, Tool: Tool)
	if SentryDebounce[Player.UserId] and tick() - SentryDebounce[Player.UserId] < PlaceCooldown then
		return
	end
	ToolsCooldown:FireClient(Player, Tool, PlaceCooldown)
	SentryDebounce[Player.UserId] = tick()

	if PlayerSentries[Player.UserId] then
		local oldSentry = PlayerSentries[Player.UserId]
		if oldSentry and oldSentry.Parent then
			oldSentry:Destroy()
		end
		ActiveSentries[oldSentry] = nil
		PlayerSentries[Player.UserId] = nil
	end

	local SentryModel = ServerScriptService.ToolsCode.AdditionalItems:FindFirstChild("Sentry")
	if not SentryModel then
		return
	end

	local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
	if not HumanoidRootPart then 
		return 
	end

	local Sentry = SentryModel:Clone()

	Sentry.Name = ("Sentry_%d"):format(Player.UserId)
	Sentry:AddTag(("Player_%d"):format(Player.UserId))

	local ForwardDirection = HumanoidRootPart.CFrame.LookVector
	local SentryPosition = HumanoidRootPart.Position + ForwardDirection * 5

	local params = RaycastParams.new()
	params.FilterType = Enum.RaycastFilterType.Exclude
	params.FilterDescendantsInstances = { Character }

	local raycast = workspace:Raycast(SentryPosition + Vector3.new(0, 10, 0), Vector3.new(0, -100, 0), params)
	local GroundY = raycast and raycast.Position.Y or SentryPosition.Y

	local sentrySize = Sentry.Size
	local sentryHeight = sentrySize.Y

	SentryPosition = Vector3.new(SentryPosition.X, GroundY + (sentryHeight / 2), SentryPosition.Z)

	local facingCFrame = CFrame.new(SentryPosition, SentryPosition + ForwardDirection)
	Sentry.CFrame = facingCFrame * CFrame.Angles(math.rad(-90), 0, 0)

	Sentry.Anchored = true
	Sentry.Transparency = 0

	Sentry.Parent = workspace

	local placedSound = Instance.new("Sound")
	placedSound.SoundId = "rbxassetid://119354387183704"
	placedSound.Name = "Placed"
	placedSound.Parent = Sentry
	placedSound:Play()
	Debris:AddItem(placedSound, 2)

	PlayerSentries[Player.UserId] = Sentry

	local OwnerLeavingConnection
	OwnerLeavingConnection = Players.PlayerRemoving:Connect(function(LeavingPlayer)
		if LeavingPlayer == Player then
			if Sentry and Sentry.Parent then
				Sentry:Destroy()
			end
			if OwnerLeavingConnection then
				OwnerLeavingConnection:Disconnect()
			end
			ActiveSentries[Sentry] = nil
			PlayerSentries[Player.UserId] = nil
		end
	end)

	ActiveSentries[Sentry] = {
		owner = Player,
		startTime = nil
	}

	task.spawn(function()
		for i = PLACEMENT_COUNTDOWN, 1, -1 do
			updateCountdown(Sentry, i, true)
			task.wait(1)
		end

		local setupReadySound = Instance.new("Sound")
		setupReadySound.SoundId = "rbxassetid://87047730068459"
		setupReadySound.Name = "SetupReady"
		setupReadySound.Parent = Sentry
		setupReadySound:Play()
		Debris:AddItem(setupReadySound, 2)

		if ActiveSentries[Sentry] then
			ActiveSentries[Sentry].startTime = tick()
		end

		manageSentry(Sentry, Player)
	end)
end

return SentryTool