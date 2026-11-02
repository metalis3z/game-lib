local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Debris = game:GetService("Debris")
local Workspace = game:GetService("Workspace")

local InteractionController = {}

local player = Players.LocalPlayer

local CLICK_SCALE_DOWN = Vector3.new(0.9, 0.75, 0.9)
local CLICK_SCALE_DURATION = 0.1
local CLICK_RELEASE_DURATION = 0.15
local CLICK_COLOR_FLASH = Color3.fromRGB(255, 255, 255)
local CLICK_FLASH_DURATION = 0.12
local CLICK_COOLDOWN = 0.3

local PLATE_COOLDOWN = 0.5
local PLATE_CHECK_INTERVAL = 0.1

local function playSound(parent, soundId)
	if not soundId or soundId == "" then return end

	local assetId = soundId
	if type(soundId) == "string" and not soundId:match("^rbxassetid://") then
		assetId = "rbxassetid://" .. soundId
	end

	local sound = Instance.new("Sound")
	sound.SoundId = assetId
	sound.Volume = 0.8
	sound.PlayOnRemove = false
	sound.Parent = parent
	sound:Play()
	Debris:AddItem(sound, sound.TimeLength + 0.5)
end

local clickCooldowns = {}

local function onButtonClicked(part)
	if clickCooldowns[part] then return end
	clickCooldowns[part] = true

	local soundId = part:GetAttribute("ClickSound")
	playSound(part, soundId)

	local originalSize = part.Size
	local originalColor = part.Color
	local originalCFrame = part.CFrame

	local targetSize = originalSize * CLICK_SCALE_DOWN
	local yDiff = (originalSize.Y - targetSize.Y) / 2
	local targetCFrame = originalCFrame - Vector3.new(0, yDiff, 0)

	local pressInfo = TweenInfo.new(CLICK_SCALE_DURATION, Enum.EasingStyle.Back, Enum.EasingDirection.In)
	local pressTween = TweenService:Create(part, pressInfo, {
		Size = targetSize,
		CFrame = targetCFrame,
	})

	local flashInfo = TweenInfo.new(CLICK_FLASH_DURATION, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	local flashTween = TweenService:Create(part, flashInfo, {
		Color = CLICK_COLOR_FLASH,
	})

	pressTween:Play()
	flashTween:Play()

	pressTween.Completed:Once(function()
		local releaseInfo = TweenInfo.new(CLICK_RELEASE_DURATION, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
		local releaseTween = TweenService:Create(part, releaseInfo, {
			Size = originalSize,
			CFrame = originalCFrame,
		})

		local colorBackInfo = TweenInfo.new(CLICK_RELEASE_DURATION, Enum.EasingStyle.Sine)
		local colorBack = TweenService:Create(part, colorBackInfo, {
			Color = originalColor,
		})

		releaseTween:Play()
		colorBack:Play()

		releaseTween.Completed:Once(function()
			part.Size = originalSize
			part.CFrame = originalCFrame
			part.Color = originalColor
		end)
	end)

	task.delay(CLICK_COOLDOWN, function()
		clickCooldowns[part] = nil
	end)
end

local connectedButtons = {}

local function setupButton(part)
	if connectedButtons[part] then return end

	local clickDetector = part:FindFirstChildOfClass("ClickDetector")
	if not clickDetector then
		clickDetector = part:WaitForChild("ClickDetector", 2)
	end
	if not clickDetector then return end

	connectedButtons[part] = true

	clickDetector.MouseClick:Connect(function(clickedPlayer)
		if clickedPlayer ~= player then return end
		onButtonClicked(part)
	end)
end

local plateCooldowns = {}

local function onFloorPlateTriggered(plate)
	if plateCooldowns[plate] then return end
	plateCooldowns[plate] = true

	local soundId = plate:GetAttribute("StepSound")
	playSound(plate, soundId)

	local originalSize = plate.Size
	local originalColor = plate.Color
	local originalCFrame = plate.CFrame

	local targetSize = originalSize * CLICK_SCALE_DOWN
	local yDiff = (originalSize.Y - targetSize.Y) / 2
	local targetCFrame = originalCFrame - Vector3.new(0, yDiff, 0)

	local pressInfo = TweenInfo.new(CLICK_SCALE_DURATION, Enum.EasingStyle.Back, Enum.EasingDirection.In)
	local pressTween = TweenService:Create(plate, pressInfo, {
		Size = targetSize,
		CFrame = targetCFrame,
	})

	local flashInfo = TweenInfo.new(CLICK_FLASH_DURATION, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	local flashTween = TweenService:Create(plate, flashInfo, {
		Color = CLICK_COLOR_FLASH,
	})

	pressTween:Play()
	flashTween:Play()

	pressTween.Completed:Once(function()
		local releaseInfo = TweenInfo.new(CLICK_RELEASE_DURATION, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
		local releaseTween = TweenService:Create(plate, releaseInfo, {
			Size = originalSize,
			CFrame = originalCFrame,
		})

		local colorBackInfo = TweenInfo.new(CLICK_RELEASE_DURATION, Enum.EasingStyle.Sine)
		local colorBack = TweenService:Create(plate, colorBackInfo, {
			Color = originalColor,
		})

		releaseTween:Play()
		colorBack:Play()

		releaseTween.Completed:Once(function()
			plate.Size = originalSize
			plate.CFrame = originalCFrame
			plate.Color = originalColor
		end)
	end)

	task.delay(PLATE_COOLDOWN, function()
		plateCooldowns[plate] = nil
	end)
end

local connectedPlates = {}

local function setupFloorPlate(part)
	if connectedPlates[part] then return end
	connectedPlates[part] = true

	part.Touched:Connect(function(hit)
		local character = player.Character
		if not character then return end

		if hit.Parent ~= character then return end
		local humanoid = character:FindFirstChildOfClass("Humanoid")
		if not humanoid or humanoid.Health <= 0 then return end

		onFloorPlateTriggered(part)
	end)
end

local function scanObject(obj)
	if not obj:IsA("BasePart") then return end

	if obj:GetAttribute("InteractButton") then
		task.spawn(setupButton, obj)
	end

	if obj:GetAttribute("FloorPlate") then
		task.spawn(setupFloorPlate, obj)
	end
end

local function scanFolder(folder)
	for _, obj in ipairs(folder:GetDescendants()) do
		scanObject(obj)
	end

	folder.DescendantAdded:Connect(function(obj)
		task.defer(function()
			scanObject(obj)
		end)
	end)

	folder.DescendantAdded:Connect(function(obj)
		if not obj:IsA("BasePart") then return end

		obj:GetAttributeChangedSignal("InteractButton"):Connect(function()
			if obj:GetAttribute("InteractButton") then
				task.spawn(setupButton, obj)
			end
		end)

		obj:GetAttributeChangedSignal("FloorPlate"):Connect(function()
			if obj:GetAttribute("FloorPlate") then
				task.spawn(setupFloorPlate, obj)
			end
		end)
	end)
end

function InteractionController.Init()
	scanFolder(Workspace)

	Players.PlayerRemoving:Connect(function(leavingPlayer)
		if leavingPlayer == player then
			table.clear(clickCooldowns)
			table.clear(plateCooldowns)
		end
	end)
end

return InteractionController