-- LocalScript inside StarterPlayerScripts

local userInputService = game:GetService("UserInputService")
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local buildModeActive = false
local rotationAngle = 0
local blockType = "Wall"

-- RemoteEvent for placing blocks
local placeBlockEvent = ReplicatedStorage:WaitForChild("PlaceBlockEvent")

-- Preview settings
local previewWall = Instance.new("Part")
previewWall.Size = Vector3.new(4, 4, 1)
previewWall.Anchored = true
previewWall.CanCollide = true
previewWall.BrickColor = BrickColor.new("Bright blue")
previewWall.Transparency = 0.5
previewWall.Parent = workspace

-- Animation IDs

local currentAnimTrack = nil

local function stopCurrentAnimation()
	if currentAnimTrack then
		currentAnimTrack:Stop()
		currentAnimTrack = nil
	end
end

local function toggleBuildMode()
	buildModeActive = not buildModeActive
	if buildModeActive then
		for _, part in pairs(character:GetDescendants()) do
			if part:IsA("BasePart") and part ~= character:FindFirstChild("HumanoidRootPart") then
				part.CanCollide = false
			end
		end
	else
		stopCurrentAnimation()
		for _, part in pairs(character:GetDescendants()) do
			if part:IsA("BasePart") and part ~= character:FindFirstChild("HumanoidRootPart") then
				part.CanCollide = true
			end
		end
	end
end

-- Preview and place blocks
local function updatePreviewWall()
	if buildModeActive then
		local mouse = player:GetMouse()
		local ray = workspace:Raycast(mouse.UnitRay.Origin, mouse.UnitRay.Direction * 500)
		if ray then
			local position = ray.Position
			local baseplate = workspace:FindFirstChild("Baseplate")
			if baseplate then
				local baseplateTopY = baseplate.Position.Y + baseplate.Size.Y / 2
				local snappedPosition = Vector3.new(position.X, baseplateTopY, position.Z)
				previewWall.Position = snappedPosition
				previewWall.CFrame = CFrame.new(snappedPosition) * CFrame.Angles(0, math.rad(rotationAngle), 0)
			end
		end
	end
end

local function onMouseClick()
	if buildModeActive then
		local mouse = player:GetMouse()
		local ray = workspace:Raycast(mouse.UnitRay.Origin, mouse.UnitRay.Direction * 500)
		if ray then
			local position = ray.Position
			-- Fire the server to place the block
			placeBlockEvent:FireServer(position, rotationAngle, blockType, previewWall.BrickColor.Name)
		end
	end
end

-- Handle user input
userInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end

	if input.KeyCode == Enum.KeyCode.B then
		toggleBuildMode()
	elseif input.KeyCode == Enum.KeyCode.E and buildModeActive then
		onMouseClick()
	elseif input.KeyCode == Enum.KeyCode.T and buildModeActive then
		rotationAngle = (rotationAngle + 90) % 360
	elseif input.KeyCode == Enum.KeyCode.Z then
		if blockType == "Wall" then
			blockType = "Cube"
			previewWall.Size = Vector3.new(2, 2, 2)
		else
			blockType = "Wall"
			previewWall.Size = Vector3.new(4, 4, 1)
		end
	elseif input.KeyCode == Enum.KeyCode.K then
		blockType = "KillBlock"
		previewWall.Size = Vector3.new(4, 4, 1)
		previewWall.BrickColor = BrickColor.new("Bright red")
		previewWall.Material = Enum.Material.Neon
	end
end)

game:GetService("RunService").RenderStepped:Connect(function()
	updatePreviewWall()
end)
