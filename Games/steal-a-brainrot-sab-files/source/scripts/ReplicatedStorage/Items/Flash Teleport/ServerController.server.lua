--!strict

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Debris = game:GetService("Debris")
local SoundService = game:GetService("SoundService")

local Net = require(ReplicatedStorage.Packages.Net)
local FlashShared = require(ReplicatedStorage.Shared.FlashShared)

local ActivateFlash = Net:RemoteFunction("Tools/Flash/Activate")

local TELEPORT_COOLDOWN = 0
local EFFECT_LIFETIME = 3
local VELOCITY_RESET_DELAY = 0.1
local SOUND_VOLUME_MULTIPLIER = 1.0
local MAXIMUM_DISTANCE_TOLERANCE = 5

local playerTeleportData: {[Player]: {
	lastTeleportTime: number,
	teleportCount: number,
	totalDistance: number
}} = {}

local flashAssets = ReplicatedStorage.Assets.Tools["Flash Teleport"]
local lightningAppear = flashAssets:FindFirstChild("lightningappear")
local lightningDisappear = flashAssets:FindFirstChild("lightningdisappear")
local lightningTrail = flashAssets:FindFirstChild("lightningtrail")

local function initializePlayerData(player: Player)
	if not playerTeleportData[player] then
		playerTeleportData[player] = {
			lastTeleportTime = 0,
			teleportCount = 0,
			totalDistance = 0
		}
	end
end

local function getTeleportSound(character: Model): Sound?
	local tool = character:FindFirstChild("Flash Teleport")
	if not tool or not tool:IsA("Tool") then
		return nil
	end

	local handle = tool:FindFirstChild("Handle")
	if not handle then
		return nil
	end

	local teleportSound = handle:FindFirstChild("TeleportSound")
	if teleportSound and teleportSound:IsA("Sound") then
		return teleportSound
	end

	return nil
end

local function playTeleportSound(sound: Sound, position: Vector3)
	if not sound then
		return
	end

	local soundClone = sound:Clone()
	soundClone.Parent = workspace

	local attachment = Instance.new("Attachment")
	attachment.Position = position
	attachment.Parent = workspace.Terrain

	soundClone.Parent = attachment

	if soundClone:IsA("Sound") then
		soundClone.Volume = soundClone.Volume * SOUND_VOLUME_MULTIPLIER
		soundClone.PlayOnRemove = false
		soundClone:Play()

		task.delay(soundClone.TimeLength + 0.5, function()
			if attachment and attachment.Parent then
				attachment:Destroy()
			end
		end)
	end
end

local function validateCharacterState(player: Player): (boolean, string, BasePart?, Humanoid?)
	local character = player.Character
	if not character then
		return false, "Character not found", nil, nil
	end

	local humanoidRootPart = character:FindFirstChild("HumanoidRootPart") :: BasePart
	local humanoid = character:FindFirstChildWhichIsA("Humanoid")

	if not humanoidRootPart or not humanoid then
		return false, "Character not ready", nil, nil
	end

	if humanoid.Health <= 0 then
		return false, "You are dead", nil, nil
	end

	if player:GetAttribute("Stealing") then
		return false, "Cannot teleport while stealing", nil, nil
	end

	if humanoidRootPart.Anchored then
		return false, "Cannot teleport while anchored", nil, nil
	end

	local ragdollEndTime = player:GetAttribute("RagdollEndTime")
	if ragdollEndTime and ragdollEndTime > workspace:GetServerTimeNow() then
		return false, "Cannot teleport while ragdolled", nil, nil
	end

	return true, "", humanoidRootPart, humanoid
end

local function validateToolOwnership(player: Player, character: Model): (boolean, string)
	if not FlashShared.Enabled:Get() then
		return false, "Flash teleport is currently disabled"
	end

	local tool = character:FindFirstChild("Flash Teleport")
	if not tool then
		tool = player.Backpack:FindFirstChild("Flash Teleport")
	end

	if not tool or not tool:IsA("Tool") then
		return false, "You don't have the Flash Teleport tool"
	end

	return true, ""
end

local function checkTeleportCooldown(player: Player): (boolean, string)
	initializePlayerData(player)

	local currentTime = workspace:GetServerTimeNow()
	local playerData = playerTeleportData[player]

	if playerData and (currentTime - playerData.lastTeleportTime < TELEPORT_COOLDOWN) then
		return false, "Please wait before teleporting again"
	end

	return true, ""
end

local function validateTeleportParameters(player: Player, params: any, result: any): (boolean, string, CFrame?, number?)
	local success1, validParams = pcall(FlashShared.AssertComputeParams, params)
	if not success1 then
	end

	local success2, validResult = pcall(FlashShared.AssertComputeResult, result)
	if not success2 then
	end

	local serverParams = FlashShared.BuildComputeParams(player, params.CameraCFrame)
	if not serverParams then
	end

	local serverResult = FlashShared.Compute(serverParams)

	if not serverResult.Valid then
	end

	local clientPos = result.CFrame.Position
	local serverPos = serverResult.CFrame.Position
	local distance = (clientPos - serverPos).Magnitude

	if distance > FlashShared.ResultTolerance:Get() then
	end

	local character = player.Character
	if not character then
	end

	local humanoidRootPart = character:FindFirstChild("HumanoidRootPart") :: BasePart
	if not humanoidRootPart then
	end

	local travelDistance = (humanoidRootPart.Position - serverPos).Magnitude
	local maxDistance = FlashShared.Distance:Get()

	if travelDistance > maxDistance + MAXIMUM_DISTANCE_TOLERANCE then
	end

	return true, "", serverResult.CFrame, travelDistance
end

local function playVisualEffect(effectModel: Model?, position: Vector3)
	if not effectModel then
		return
	end

	local effect = effectModel:Clone()
	effect.Parent = workspace

	if effect:IsA("Model") and effect.PrimaryPart then
		effect:PivotTo(CFrame.new(position))
	elseif effect:IsA("BasePart") then
		effect.CFrame = CFrame.new(position)
	end

	for _, descendant in ipairs(effect:GetDescendants()) do
		if descendant:IsA("ParticleEmitter") then
			local emitCount = descendant:GetAttribute("EmitCount") or 30
			descendant:Emit(emitCount)
		end
	end

	for _, descendant in ipairs(effect:GetDescendants()) do
		if descendant:IsA("Sound") then
			descendant:Play()
		end
	end

	Debris:AddItem(effect, EFFECT_LIFETIME)
end

local function resetCharacterVelocity(humanoidRootPart: BasePart)
	task.wait(VELOCITY_RESET_DELAY)

	if humanoidRootPart and humanoidRootPart.Parent then
		humanoidRootPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
		humanoidRootPart.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
	end
end

local function updatePlayerStatistics(player: Player, distance: number)
	local playerData = playerTeleportData[player]
	if not playerData then
		return
	end

	playerData.lastTeleportTime = workspace:GetServerTimeNow()
	playerData.teleportCount = playerData.teleportCount + 1
	playerData.totalDistance = playerData.totalDistance + distance
end

local function executeTeleportSequence(player: Player, humanoidRootPart: BasePart, targetCFrame: CFrame, distance: number)
	local startPosition = humanoidRootPart.Position
	local endPosition = targetCFrame.Position

	playVisualEffect(lightningDisappear, startPosition)

	humanoidRootPart.CFrame = targetCFrame
	humanoidRootPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
	humanoidRootPart.AssemblyAngularVelocity = Vector3.new(0, 0, 0)

	playVisualEffect(lightningAppear, endPosition)

	local teleportSound = getTeleportSound(player.Character)
	if teleportSound then
		playTeleportSound(teleportSound, endPosition)
	end

	task.spawn(resetCharacterVelocity, humanoidRootPart)

	updatePlayerStatistics(player, distance)
end

ActivateFlash.OnServerInvoke = function(player: Player, params: any, result: any): (boolean, string)
	local validCharacter, characterError, humanoidRootPart, humanoid = validateCharacterState(player)
	if not validCharacter then
		return false, characterError
	end

	local validTool, toolError = validateToolOwnership(player, player.Character)
	if not validTool then
		return false, toolError
	end

	local canTeleport, cooldownError = checkTeleportCooldown(player)
	if not canTeleport then
		return false, cooldownError
	end

	local validParams, paramError, serverCFrame, travelDistance = validateTeleportParameters(player, params, result)
	if not validParams then
		return false, paramError
	end

	executeTeleportSequence(player, humanoidRootPart, serverCFrame, travelDistance)

	return true, "Teleported successfully!"
end

Players.PlayerRemoving:Connect(function(player: Player)
	playerTeleportData[player] = nil
end)

for _, player in ipairs(Players:GetPlayers()) do
	initializePlayerData(player)
end

Players.PlayerAdded:Connect(function(player: Player)
	initializePlayerData(player)
end)