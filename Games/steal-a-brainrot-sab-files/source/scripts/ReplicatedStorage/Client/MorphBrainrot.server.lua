local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Net = require(ReplicatedStorage.Packages.Net)
local AnimalAnimations = ReplicatedStorage.Animations.Animals
local LocalPlayer = Players.LocalPlayer

local MorphEvent = Net:RemoteEvent("MorphBrainrot")

local WALK_THRESHOLD = 0.1
local TRANSITION_TIME = 0.2

local currentMorphData = nil

local function cleanupMorph()
	if not currentMorphData then return end

	if currentMorphData.connection then
		currentMorphData.connection:Disconnect()
	end

	if currentMorphData.walkTrack then
		currentMorphData.walkTrack:Stop(TRANSITION_TIME)
	end

	if currentMorphData.idleTrack then
		currentMorphData.idleTrack:Stop(TRANSITION_TIME)
	end

	currentMorphData = nil
end

local function applyMorphAnimations(animalName)
	cleanupMorph()

	local character = LocalPlayer.Character
	if not character then return end

	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if not humanoid then return end

	local morphModel = character:WaitForChild("MorphBrainrot", 10)
	if not morphModel then return end

	local animationController = morphModel:FindFirstChildOfClass("AnimationController")
	if not animationController then
		animationController = morphModel:WaitForChild("AnimationController", 10)
	end
	if not animationController then return end

	local animator = animationController:FindFirstChildOfClass("Animator")
	if not animator then
		animator = animationController:WaitForChild("Animator", 10)
	end
	if not animator then return end

	local animalFolder = AnimalAnimations:FindFirstChild(animalName)
	if not animalFolder then return end

	local idleAnimation = animalFolder:FindFirstChild("Idle")
	local walkAnimation = animalFolder:FindFirstChild("Walk")
	if not idleAnimation or not walkAnimation then return end

	local idleTrack = animator:LoadAnimation(idleAnimation)
	local walkTrack = animator:LoadAnimation(walkAnimation)

	idleTrack.Priority = Enum.AnimationPriority.Action
	walkTrack.Priority = Enum.AnimationPriority.Action
	idleTrack.Looped = true
	walkTrack.Looped = true

	idleTrack:Play(TRANSITION_TIME)

	local isWalking = false

	currentMorphData = {
		idleTrack = idleTrack,
		walkTrack = walkTrack,
		connection = humanoid.Running:Connect(function(speed)
			if speed > WALK_THRESHOLD and not isWalking then
				isWalking = true
				idleTrack:Stop(TRANSITION_TIME)
				walkTrack:Play(TRANSITION_TIME)
			elseif speed <= WALK_THRESHOLD and isWalking then
				isWalking = false
				walkTrack:Stop(TRANSITION_TIME)
				idleTrack:Play(TRANSITION_TIME)
			end
		end)
	}
end

MorphEvent.OnClientEvent:Connect(function(animalName)
	if animalName then
		applyMorphAnimations(animalName)
	else
		cleanupMorph()
	end
end)