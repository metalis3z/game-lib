local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ContentProvider = game:GetService("ContentProvider")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local Players = game:GetService("Players")
local Debris = game:GetService("Debris")

local EventTypes = require(ReplicatedStorage.Shared.EventTypes)

local BrazilEventClient = {}

local EncryptedAssetsController = require(ReplicatedStorage.Controllers.EncryptedAssetsController)
local ClientEventUtils = require(ReplicatedStorage.Controllers.EventController.ClientEventUtils)
local AnimalController = require(ReplicatedStorage.Controllers.AnimalController)
local EffectController = require(ReplicatedStorage.Controllers.EffectController)
local CameraController = require(ReplicatedStorage.Controllers.CameraController)
local SoundController = require(ReplicatedStorage.Controllers.SoundController)
local EventController = require(ReplicatedStorage.Controllers.EventController)
local CycleController = require(ReplicatedStorage.Controllers.CycleController)
local SharedEventUtils = require(ReplicatedStorage.Shared.SharedEventUtils)
local CreateTween = require(ReplicatedStorage.Packages.CreateTween)
local TweenPivot = require(ReplicatedStorage.Shared.TweenPivot)
local Observers = require(ReplicatedStorage.Packages.Observers)
local ServerData = require(ReplicatedStorage.Datas.ServerData)
local MathUtils = require(ReplicatedStorage.Utils.MathUtils)
local Signal = require(ReplicatedStorage.Packages.Signal)
local Spring = require(ReplicatedStorage.Packages.Spring)
local Trove = require(ReplicatedStorage.Packages.Trove)
local Shake = require(ReplicatedStorage.Packages.Shake)
local Net = require(ReplicatedStorage.Packages.Net)
local VFX = require(ReplicatedStorage.Shared.VFX)

local LocalPlayer = Players.LocalPlayer
local CurrentCamera = workspace.CurrentCamera

local PRIMARY_STAGE_COLOR = Color3.fromRGB(128, 255, 0)
local SECONDARY_STAGE_COLOR = Color3.fromRGB(0, 255, 0)

local EVENT_NAME = script.Name
local BrazilMusic = workspace.Sounds.BrazilEvent
local EventFloor = if ServerData.IsBiggerServer() then workspace.Events.Brazil.FullMapFloorBigger else workspace.Events.Brazil.FullMapFloor
local RenderedMovingAnimals = workspace.RenderedMovingAnimals

local FocusRemote = Net:RemoteEvent("EventService/Brazil/Focus")
local BurstRemote = Net:RemoteEvent("EventService/Brazil/Burst")

local cleanupTrove = Trove.new()

local function getRandomPosition()
	return EventFloor.Position + Vector3.new(
		EventFloor.Size.X * 0.5 * (math.random(0, 1) * 2 - 1),
		0,
		EventFloor.Size.Z * 0.5 * (math.random(0, 1) * 2 - 1)
	)
end

local function createLight(parentPart)
	local attachment = Instance.new("Attachment")
	attachment.Name = "Attachment"
	attachment.CFrame = CFrame.new(0, 3, 0)

	local pointLight = Instance.new("PointLight")
	pointLight.Name = "PointLight"
	pointLight.Brightness = 4
	pointLight.Color = Color3.fromRGB(255, 157, 0)
	pointLight.Range = 6
	pointLight.Parent = attachment

	attachment.Parent = parentPart

	return function()
		attachment:Destroy()
		pointLight:Destroy()
	end
end

BrazilEventClient.OnStart = function(_)
	local activeEventData = EventController:GetActiveEventData(EVENT_NAME)
	assert(activeEventData)

	local function calculateTimeLeft(offset)
		return math.max(activeEventData.startedAt + offset - workspace:GetServerTimeNow(), 0)
	end

	local function createEventScheduler(startOffset, endOffset, callback)
		local function getRemainingTime()
			local targetOffset = endOffset
			return math.max(activeEventData.startedAt + targetOffset - workspace:GetServerTimeNow(), 0)
		end

		local function run()
			callback(getRemainingTime)
		end

		local scheduledThread = nil
		local delayTime = math.max(activeEventData.startedAt + startOffset - workspace:GetServerTimeNow(), 0)

		if delayTime > 0 then
			scheduledThread = task.delay(delayTime, run)
		else
			callback(getRemainingTime)
		end

		return function()
			if scheduledThread and coroutine.status(scheduledThread) == "suspended" then
				pcall(task.cancel, scheduledThread)
			end
		end
	end

	cleanupTrove:Add(function()
		EffectController:Activate("Blink")
		CycleController:Update()
		SoundController:UpdateOST()
	end)

	cleanupTrove:Add(BurstRemote.OnClientEvent:Connect(function(position)
		ClientEventUtils.playBurst(script.Burst, position, {
			ReplicatedStorage.Sounds.Events.Brazil.Hit
		})
	end))

	local cartoonEffect = Lighting:FindFirstChild("Cartoon")
	if cartoonEffect then
		cartoonEffect.Parent = ReplicatedStorage
		cleanupTrove:Add(function()
			cartoonEffect.Parent = Lighting
		end)
	end

	local cameraColorCorrection = cleanupTrove:Clone(Instance.new("ColorCorrectionEffect"))
	cameraColorCorrection.Parent = CurrentCamera

	local danceTrack = nil
	local stageModel = if ServerData.IsBiggerServer() then cleanupTrove:Clone(script.StageBigger) else cleanupTrove:Clone(script.Stage)
	local vfxModel = if ServerData.IsBiggerServer() then cleanupTrove:Clone(script.VFXBigger) else cleanupTrove:Clone(script.VFX)

	local function initPlayerDance()
		cleanupTrove:Add(task.delay(math.max(activeEventData.startedAt + 20 - workspace:GetServerTimeNow(), 0), function()
			cleanupTrove:Add(Observers.observeCharacter(Players.LocalPlayer, function(_, character)
				local characterTrove = Trove.new()

				characterTrove:Add(task.spawn(function()
					local humanoid = character:WaitForChild("Humanoid")
					if not humanoid then
						return
					else
						local animator = humanoid:WaitForChild("Animator")
						if not animator then
							return
						else
							local animationTrack = animator:LoadAnimation(script.Dance)
							animationTrack.Priority = Enum.AnimationPriority.Action
							danceTrack = animationTrack

							local idleTime = 0

							characterTrove:Add(RunService.PostSimulation:Connect(function(deltaTime)
								debug.profilebegin("Brazil:Player:Dance")
								local _serverTime = workspace:GetServerTimeNow()

								if math.max(activeEventData.startedAt + 55 - workspace:GetServerTimeNow(), 0) > 0 then
									if not animationTrack.IsPlaying then
										animationTrack:Play()
									end
									debug.profileend()
									return
								else
									if not (humanoid.MoveDirection ~= Vector3.new(0, 0, 0, 0)) and not LocalPlayer:GetAttribute("Stealing") then
										if idleTime < 3 then
											idleTime = idleTime + deltaTime
										elseif not animationTrack.IsPlaying then
											animationTrack:Play()
										end
									else
										idleTime = 0
										if animationTrack.IsPlaying then
											animationTrack:Stop()
										end
									end

									debug.profileend()
									return
								end
							end))

							characterTrove:Add(function()
								animationTrack:Stop()
								animationTrack:Destroy()
								danceTrack = nil
							end)

							return
						end
					end
				end))

				return characterTrove:WrapClean()
			end))
		end))
	end

	local function createMovingSquare()
		local baseAttachmentPositions = {}
		local topAttachments = {}
		local bottomAttachments = {}

		for _, attachment in vfxModel.Square.Bottom:GetChildren() do
			if attachment:IsA("Attachment") then
				baseAttachmentPositions[attachment] = attachment.Position
				table.insert(bottomAttachments, attachment)
			end
		end

		for _, attachment in vfxModel.Square.Top:GetChildren() do
			if attachment:IsA("Attachment") then
				baseAttachmentPositions[attachment] = attachment.Position
				table.insert(topAttachments, attachment)
			end
		end

		local currentSquareScale = Vector3.new(9, 9, 9, 0)

		for _, attachment in bottomAttachments do
			attachment.Position = baseAttachmentPositions[attachment] * Vector3.new(1, 1, 1, 0) * 9
		end

		for _, attachment in topAttachments do
			attachment.Position = baseAttachmentPositions[attachment] * Vector3.new(1, 1, 1, 0) * 9
		end

		cleanupTrove:Add(Observers.observeTag("BrazilHitbox", function(hitbox)
			local hitboxTrove = Trove.new()
			local previousSquareScale = nil
			local focusedAnimalData = nil
			local topRaiseAlpha = 0
			local hasPlayedCubeSound = false

			local currentHitboxPosition = hitbox.Position
			local targetHitboxPosition = hitbox.Position
			local TWEEN_SPEED = 8

			hitboxTrove:Add(RunService.PostSimulation:Connect(function(deltaTime)
				debug.profilebegin("Brazil:Hitbox")

				local serverTime = workspace:GetServerTimeNow()
				local hitboxCFrame = hitbox.CFrame
				local focusedAt = hitbox:GetAttribute("Focused")
				local focusedAnimalModel = if focusedAnimalData and focusedAt and focusedAt <= serverTime then ClientEventUtils.getAnimalModel(focusedAnimalData) else nil

				if focusedAnimalData and focusedAnimalModel then
					if not hasPlayedCubeSound then
						hasPlayedCubeSound = true

						local cubeSound = ReplicatedStorage.Sounds.Events.Brazil.Cube:Clone()
						cubeSound.Parent = hitbox
						cubeSound:Play()

						local cubeSoundRef = cubeSound
						cubeSound.Ended:Once(function()
							cubeSoundRef:Destroy()
						end)
					end

					local focusProgress = math.clamp((serverTime - focusedAt) / 1, 0, 1)
					topRaiseAlpha = math.clamp((serverTime - (focusedAt + 1)) / 1, 0, 1)

					local vfxInstance = focusedAnimalModel:FindFirstChild("VfxInstance")
					local animalCFrame = ClientEventUtils.getAnimalCFrame(focusedAnimalData)
					local targetScale = ((if vfxInstance then vfxInstance.Size else focusedAnimalModel:GetExtentsSize()) * Vector3.new(1.25, 1.5, 1.25, 0)):Min(Vector3.new(9, 18, 9, 0))

					targetHitboxPosition = Vector3.new(animalCFrame.X, hitboxCFrame.Y, animalCFrame.Z)
					local alpha = 1 - math.exp(-TWEEN_SPEED * deltaTime)
					currentHitboxPosition = currentHitboxPosition:Lerp(targetHitboxPosition, alpha)

					hitboxCFrame = CFrame.new(currentHitboxPosition)

					if not previousSquareScale then
						previousSquareScale = currentSquareScale
					end

					assert(previousSquareScale)

					local topScale = previousSquareScale:Lerp(targetScale, focusProgress)
					local bottomScale = previousSquareScale:Lerp(Vector3.new(targetScale.X, 0, targetScale.Z), focusProgress)

					currentSquareScale = topScale

					for _, attachment in topAttachments do
						attachment.Position = (baseAttachmentPositions[attachment] + Vector3.new(0, topRaiseAlpha * 1, 0)) * topScale
					end

					for _, attachment in bottomAttachments do
						attachment.Position = baseAttachmentPositions[attachment] * bottomScale
					end
				else
					if hasPlayedCubeSound then
						hasPlayedCubeSound = false
					end

					local decay = math.exp(-4 * deltaTime)
					currentSquareScale = Vector3.new(9, 9, 9, 0):Lerp(currentSquareScale, decay)
					previousSquareScale = currentSquareScale
					topRaiseAlpha = math.lerp(0, topRaiseAlpha, decay)

					local alpha = 1 - math.exp(-TWEEN_SPEED * deltaTime)
					currentHitboxPosition = currentHitboxPosition:Lerp(hitbox.Position, alpha)
					hitboxCFrame = CFrame.new(currentHitboxPosition)

					for _, attachment in topAttachments do
						attachment.Position = (baseAttachmentPositions[attachment] + Vector3.new(0, topRaiseAlpha * 1, 0)) * currentSquareScale
					end

					for _, attachment in bottomAttachments do
						attachment.Position = baseAttachmentPositions[attachment] * currentSquareScale
					end
				end

				SharedEventUtils.pushPartCFrame(vfxModel.Square, hitboxCFrame)
				debug.profileend()
			end))

			hitboxTrove:Add(FocusRemote.OnClientEvent:Connect(function(animalData)
				previousSquareScale = currentSquareScale
				focusedAnimalData = animalData

				if animalData then
					local animalModel = ClientEventUtils.getAnimalModel(animalData)
					if animalModel then
						local animalCFrame = ClientEventUtils.getAnimalCFrame(animalData)
						targetHitboxPosition = Vector3.new(animalCFrame.X, hitbox.Position.Y, animalCFrame.Z)
					end
				end
			end))

			return hitboxTrove:WrapClean()
		end, {
			workspace
		}))
	end

	local function createPlayerLights()
		cleanupTrove:Add(Observers.observeCharacters(function(_, character)
			local characterTrove = Trove.new()

			characterTrove:Add(task.spawn(function()
				local upperTorso = character:WaitForChild("UpperTorso")
				if not upperTorso then
					return
				else
					characterTrove:Add(createLight(upperTorso))
					return
				end
			end))

			return characterTrove:WrapClean()
		end))

		cleanupTrove:Add(Observers.observeChildren(RenderedMovingAnimals, function(animalModel)
			local animalTrove = Trove.new()

			animalTrove:Add(task.spawn(function()
				local rootPart = animalModel:WaitForChild("RootPart")
				if not rootPart then
					return
				else
					animalTrove:Add(createLight(rootPart))
					return
				end
			end))

			return animalTrove:WrapClean()
		end))
	end

	local function createStage()
		Lighting.Ambient = Color3.fromRGB(50, 50, 50)
		Lighting.OutdoorAmbient = Color3.fromRGB(71, 71, 71)

		cleanupTrove:Add(function()
			Lighting.Ambient = Color3.fromRGB(241, 241, 241)
			Lighting.OutdoorAmbient = Color3.fromRGB(212, 212, 212)
		end)

		cleanupTrove:Add(function()
			BrazilMusic:Stop()
			ReplicatedStorage:SetAttribute("BrazilEventMusic", nil)
		end)

		cleanupTrove:Add(task.spawn(function()
			BrazilMusic.TimePosition = workspace:GetServerTimeNow() - (activeEventData.startedAt + 5)
			BrazilMusic:Play()
			ReplicatedStorage:SetAttribute("BrazilEventMusic", true)
		end))

		cleanupTrove:Clone(script.Night_Sky).Parent = Lighting

		vfxModel.Parent = stageModel
		VFX.disable(vfxModel)

		local primaryColorValue = cleanupTrove:Add(Instance.new("Color3Value"))
		primaryColorValue.Value = Color3.fromRGB(0, 0, 0)

		local secondaryColorValue = cleanupTrove:Add(Instance.new("Color3Value"))
		secondaryColorValue.Value = Color3.fromRGB(0, 0, 0)

		local squareAndBigBeamEffects = {}
		local generalEffects = {}
		local spotLights = {}
		local particleEmitters = {}
		local particleTimeScales = {}

		VFX.enable(vfxModel)
		VFX.disable(vfxModel.firestuff)

		local currentColorState = 1
		local fovCooldown = 0
		local colorSwapCooldown = 0

		createPlayerLights()
		createMovingSquare()

		for _, descendant in stageModel:GetDescendants() do
			if descendant:IsA("SpotLight") then
				table.insert(spotLights, descendant)
			elseif descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
				if descendant:IsDescendantOf(vfxModel.Square) or descendant:IsDescendantOf(vfxModel.bigbeams) then
					table.insert(squareAndBigBeamEffects, descendant)
				else
					table.insert(generalEffects, descendant)
				end

				if descendant:IsA("ParticleEmitter") then
					particleTimeScales[descendant] = descendant.TimeScale
					table.insert(particleEmitters, descendant)
				end
			end
		end

		local currentAttachmentPositions = {}
		local targetAttachmentPositions = {}
		local initialAttachments = {}
		local initialAttachmentChildren = {}

		for _, initialChild in vfxModel.initial:GetChildren() do
			local attachment = initialChild.att1
			targetAttachmentPositions[attachment] = getRandomPosition()
			currentAttachmentPositions[attachment] = getRandomPosition()
			attachment.WorldCFrame = CFrame.new(currentAttachmentPositions[attachment])
			table.insert(initialAttachments, attachment)

			for _, child in attachment:GetChildren() do
				table.insert(initialAttachmentChildren, child)
			end
		end

		local thinBeamAttachments = {}
		local thinBeamGroupHeights = {}
		local sortedThinBeamGroups = {}

		for _, thinBeamPart in vfxModel.thinbeams:GetChildren() do
			local attachment = thinBeamPart.att1
			targetAttachmentPositions[attachment] = getRandomPosition()
			currentAttachmentPositions[attachment] = getRandomPosition()
			attachment.WorldCFrame = CFrame.new(currentAttachmentPositions[attachment])
			table.insert(thinBeamAttachments, attachment)

			local effectGroup = {}
			for _, effect in attachment:GetChildren() do
				effect.Enabled = false
				table.insert(effectGroup, effect)
			end

			thinBeamGroupHeights[effectGroup] = thinBeamPart.Position.Y
			table.insert(sortedThinBeamGroups, effectGroup)
		end

		table.sort(sortedThinBeamGroups, function(groupA, groupB)
			return thinBeamGroupHeights[groupA] < thinBeamGroupHeights[groupB]
		end)

		local introFireTriggered = false
		local outroFireTriggered = false
		local lastRetargetTime = 0

		cleanupTrove:Add(RunService.PostSimulation:Connect(function(deltaTime)
			debug.profilebegin("Brazil:Update")

			local serverTime = workspace:GetServerTimeNow()
			fovCooldown = fovCooldown - deltaTime
			colorSwapCooldown = colorSwapCooldown - deltaTime

			local musicTimePosition = BrazilMusic.TimePosition
			local playbackLoudness = BrazilMusic.PlaybackLoudness
			local loudnessAlpha = math.clamp(playbackLoudness / 1000, 0, 1)

			for _, emitter in particleEmitters do
				emitter.TimeScale = math.clamp(loudnessAlpha / 0.05, 1, 2) * particleTimeScales[emitter]
			end

			if playbackLoudness >= 320 and serverTime - lastRetargetTime >= 2 then
				lastRetargetTime = serverTime
				for attachment, _ in targetAttachmentPositions do
					targetAttachmentPositions[attachment] = getRandomPosition()
				end
			end

			for _, attachmentGroup in {
				thinBeamAttachments,
				initialAttachments
				} do
				for _, attachment in attachmentGroup do
					local currentPosition = currentAttachmentPositions[attachment]
					local targetPosition = targetAttachmentPositions[attachment]
					local direction = targetPosition - currentPosition
					local distance = vector.magnitude(direction)
					local speed = math.lerp(35, 120, math.clamp((playbackLoudness - 100) / 200, 0, 1)) * deltaTime

					if distance < speed then
						currentPosition = targetPosition
						targetAttachmentPositions[attachment] = getRandomPosition()
					else
						currentPosition = currentPosition + vector.normalize(direction) * speed
					end

					currentAttachmentPositions[attachment] = currentPosition
					attachment.WorldCFrame = CFrame.new(currentPosition)
				end
			end

			if musicTimePosition >= 17 then
				local enabledGroups = math.max((musicTimePosition - 17) // #sortedThinBeamGroups, 2)
				if musicTimePosition >= 82 then
					enabledGroups = enabledGroups + 10
				end

				for groupIndex = 1, math.min(enabledGroups, #sortedThinBeamGroups) do
					for _, effect in sortedThinBeamGroups[groupIndex] do
						effect.Enabled = true
					end
				end
			end

			if musicTimePosition >= 17 and not introFireTriggered then
				VFX.enable(vfxModel.firestuff)
				task.delay(5.5, function()
					VFX.disable(vfxModel.firestuff)
				end)

				introFireTriggered = true

				for _, child in initialAttachmentChildren do
					child.Enabled = false
				end
			end

			if musicTimePosition >= 83 and not outroFireTriggered then
				outroFireTriggered = true
				VFX.enable(vfxModel.firestuff)

				task.delay(5.5, function()
					VFX.disable(vfxModel.firestuff)
				end)
			end

			if loudnessAlpha >= 0.11 and colorSwapCooldown <= 0 and math.max(activeEventData.startedAt + 6 - workspace:GetServerTimeNow(), 0) <= 0 then
				colorSwapCooldown = 0.4
				currentColorState = currentColorState == 1 and 2 or 1

				CreateTween(primaryColorValue, TweenInfo.new(0.2), {
					Value = if currentColorState == 1 then PRIMARY_STAGE_COLOR else SECONDARY_STAGE_COLOR
				})

				CreateTween(secondaryColorValue, TweenInfo.new(0.2), {
					Value = if currentColorState == 1 then SECONDARY_STAGE_COLOR else PRIMARY_STAGE_COLOR
				})
			end

			if danceTrack then
				danceTrack:AdjustSpeed(math.clamp(loudnessAlpha / 0.07, 0.8, 1.5))
			end

			local primaryColor = primaryColorValue.Value
			local secondaryColor = secondaryColorValue.Value
			local primarySequence = ColorSequence.new(primaryColor)
			local secondarySequence = ColorSequence.new(secondaryColor)

			for _, effect in generalEffects do
				effect.Color = primarySequence
			end

			for _, effect in squareAndBigBeamEffects do
				effect.Color = secondarySequence
			end

			for _, light in spotLights do
				light.Color = primaryColor
			end

			if loudnessAlpha >= 0.1 and fovCooldown <= 0 then
				fovCooldown = 0.1
				CameraController:Fov(loudnessAlpha / 0.7 * 15 + 70, 0.1)
			end

			debug.profileend()
		end))

		cleanupTrove:Add(createEventScheduler(5, 6, function(getRemainingTime)
			CreateTween(primaryColorValue, TweenInfo.new(getRemainingTime()), {
				Value = PRIMARY_STAGE_COLOR
			})

			CreateTween(secondaryColorValue, TweenInfo.new(getRemainingTime()), {
				Value = SECONDARY_STAGE_COLOR
			})
		end))

		stageModel.Parent = workspace

		cleanupTrove:Add(Observers.observeTag("HideInBrazil", function(instanceToHide)
			local originalParent = instanceToHide.Parent
			instanceToHide.Parent = script

			return function()
				pcall(function()
					instanceToHide.Parent = originalParent
				end)
			end
		end, {
			workspace,
			script
		}))
	end

	cleanupTrove:Add(createEventScheduler(0, 5, function(getRemainingTime)
		CreateTween(cameraColorCorrection, TweenInfo.new(getRemainingTime(), Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
			Brightness = -1.2
		})

		EffectController:Run("BrazilEvent", "GrassRecolor")

		cleanupTrove:Add(function()
			EffectController:Stop("BrazilEvent", "GrassRecolor")
		end)

		cleanupTrove:Add(task.delay(getRemainingTime(), function()
			createStage()

			CreateTween(cameraColorCorrection, TweenInfo.new(math.max(activeEventData.startedAt + 6 - workspace:GetServerTimeNow(), 0), Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
				Brightness = 0
			})
		end))
	end))

	cleanupTrove:Add(task.delay(math.max(activeEventData.startedAt + 20 - workspace:GetServerTimeNow(), 0), function()
		cleanupTrove:Add(Observers.observeCharacter(Players.LocalPlayer, function(_, character)
			local characterTrove = Trove.new()

			characterTrove:Add(task.spawn(function()
				local humanoid = character:WaitForChild("Humanoid")
				if not humanoid then
					return
				else
					local animator = humanoid:WaitForChild("Animator")
					if not animator then
						return
					else
						local animationTrack = animator:LoadAnimation(script.Dance)
						animationTrack.Priority = Enum.AnimationPriority.Action
						danceTrack = animationTrack

						local idleTime = 0

						characterTrove:Add(RunService.PostSimulation:Connect(function(deltaTime)
							debug.profilebegin("Brazil:Player:Dance")
							local _serverTime = workspace:GetServerTimeNow()

							if math.max(activeEventData.startedAt + 55 - workspace:GetServerTimeNow(), 0) > 0 then
								if not animationTrack.IsPlaying then
									animationTrack:Play()
								end
								debug.profileend()
								return
							else
								if not (humanoid.MoveDirection ~= Vector3.new(0, 0, 0, 0)) and not LocalPlayer:GetAttribute("Stealing") then
									if idleTime < 3 then
										idleTime = idleTime + deltaTime
									elseif not animationTrack.IsPlaying then
										animationTrack:Play()
									end
								else
									idleTime = 0
									if animationTrack.IsPlaying then
										animationTrack:Stop()
									end
								end

								debug.profileend()
								return
							end
						end))

						characterTrove:Add(function()
							animationTrack:Stop()
							animationTrack:Destroy()
							danceTrack = nil
						end)

						return
					end
				end
			end))

			return characterTrove:WrapClean()
		end))
	end))

	CycleController:Update()
	SoundController:UpdateOST()
end

BrazilEventClient.OnStop = function(_)
	cleanupTrove:Destroy()
end

BrazilEventClient.OnLoad = function(_)
	task.spawn(pcall, function()
		ContentProvider:PreloadAsync(script:GetChildren())
	end)
end

return BrazilEventClient