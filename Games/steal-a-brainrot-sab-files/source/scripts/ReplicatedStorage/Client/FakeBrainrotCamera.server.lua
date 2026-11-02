local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ContextActionService = game:GetService("ContextActionService")
local Net = require(ReplicatedStorage.Packages.Net)
local SoundController = require(ReplicatedStorage.Controllers.SoundController)

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local ToolFrame = PlayerGui:WaitForChild("ToolsFrames")
local ActivateFrame = ToolFrame.Morphs
local EarlyDestroyButton = ActivateFrame:WaitForChild("Activate")

local SpawnCameraEvent = Net:RemoteEvent("SpawnFakeBrainrot/Camera")
local CameraToggleEvent = Net:RemoteEvent("SpawnFakeBrainrot/CameraToggle")
local PoofEvent = Net:RemoteEvent("SpawnFakeBrainrot/Poof")
local EarlyDestroyEvent = Net:RemoteEvent("SpawnFakeBrainrot/EarlyDestroy")

local targetModel = nil
local targetAnimalId = nil
local cameraAnchor = nil
local isFollowing = false
local ToggleKey = Enum.KeyCode.T
local isOnCooldown = false
local COOLDOWN_TIME = 5
local pendingEarlyDestroy = false


local function resetCameraToPlayer()
	local Character = LocalPlayer.Character
	if Character then
		local Humanoid = Character:FindFirstChildWhichIsA("Humanoid")
		if Humanoid then
			workspace.CurrentCamera.CameraSubject = Humanoid
		end
	end
	isFollowing = false
end

local function destroyCameraAnchor()
	if cameraAnchor then
		cameraAnchor:Destroy()
		cameraAnchor = nil
	end
end

local function cleanupMorphState()
	ActivateFrame.Visible = false
	task.wait(0.1)
	resetCameraToPlayer()
	destroyCameraAnchor()
	targetModel = nil
	targetAnimalId = nil
	pendingEarlyDestroy = false
	ContextActionService:UnbindAction("FakeBrainrotCameraToggle")
end

local function getOrCreateCameraAnchor()
	if cameraAnchor and cameraAnchor.Parent then
		return cameraAnchor
	elseif not targetModel or not targetModel.PrimaryPart then
		return nil
	else
		local Part = Instance.new("Part")
		Part.Name = "FakeBrainrotCameraAnchor"
		Part.Size = Vector3.new(1, 1, 1)
		Part.Transparency = 1
		Part.CanCollide = false
		Part.CanQuery = false
		Part.CanTouch = false
		Part.Massless = true
		Part.Anchored = false

		local WeldConstraint = Instance.new("WeldConstraint")
		WeldConstraint.Part0 = targetModel.PrimaryPart
		WeldConstraint.Part1 = Part
		WeldConstraint.Parent = Part

		Part.CFrame = targetModel.PrimaryPart.CFrame + Vector3.new(0, 3, 0)
		Part.Parent = targetModel
		cameraAnchor = Part
		return Part
	end
end


EarlyDestroyButton.MouseButton1Click:Connect(function()
	if isOnCooldown or not targetAnimalId or pendingEarlyDestroy then return end

	pendingEarlyDestroy = true
	isOnCooldown = true

	EarlyDestroyEvent:FireServer(targetAnimalId)


	task.delay(3, function()
		if pendingEarlyDestroy then
			task.spawn(cleanupMorphState)
		end
	end)

	task.delay(COOLDOWN_TIME, function()
		isOnCooldown = false
	end)
end)


local function toggleCamera(_, inputState)
	if inputState ~= Enum.UserInputState.Begin then
		return Enum.ContextActionResult.Pass
	end

	if isFollowing then
		resetCameraToPlayer()
		CameraToggleEvent:FireServer(false)
	elseif targetModel and targetModel.PrimaryPart then
		local anchor = getOrCreateCameraAnchor()
		if anchor then
			workspace.CurrentCamera.CameraSubject = anchor
		end
		isFollowing = true
		CameraToggleEvent:FireServer(true)
	end
	return Enum.ContextActionResult.Sink
end

SpawnCameraEvent.OnClientEvent:Connect(function(model, animalId)
	if model then
		targetModel = model
		targetAnimalId = animalId or (model and model.Name)
		pendingEarlyDestroy = false

		ActivateFrame.Visible = true

		if targetModel.PrimaryPart then
			local anchor = getOrCreateCameraAnchor()
			if anchor then
				workspace.CurrentCamera.CameraSubject = anchor
			end
			isFollowing = true
			CameraToggleEvent:FireServer(true)
		end

		ContextActionService:BindAction("FakeBrainrotCameraToggle", toggleCamera, false, ToggleKey)

		if targetModel then
			targetModel.Destroying:Connect(function()
				if targetModel == model then
					task.spawn(cleanupMorphState)
				end
			end)
		end
	else
		task.spawn(cleanupMorphState)
	end
end)

PoofEvent.OnClientEvent:Connect(function(data)
	if not data or not data.Position then return end

	local smokeClone = script.Smoke:Clone()
	smokeClone:PivotTo(CFrame.new(data.Position))
	smokeClone.Parent = workspace
	smokeClone.smoke1:Emit(10)

	task.spawn(function()
		SoundController:PlaySound(ReplicatedStorage.Sounds.Sfx.Puff3, data.Position, false)
	end)

	task.delay(3, function()
		smokeClone:Destroy()
	end)
end)