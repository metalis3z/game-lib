print("Hello world!")
--[[
    FREE CAM - Version Silencieuse
    - Seuls les utilisateurs whitelistés voient l'interface et peuvent l'utiliser
    - Les autres : rien n'apparaît (pas de message)
--]]

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Camera = workspace.CurrentCamera

local player = Players.LocalPlayer

-- ========== WHITELIST (IDs autorisés) ==========
local allowedUsers = {
	12345678,   -- Remplace par ton ID
	-- Ajoute d'autres IDs ici
}
-- ===============================================

local isAllowed = false
for _, id in pairs(allowedUsers) do
	if player.UserId == id then
		isAllowed = true
		break
	end
end

-- Si non autorisé : on ne fait ABSOLUMENT RIEN (pas d'UI, pas de connexions)
if not isAllowed then
	return  -- Le script s'arrête ici pour les non-autorisés
end

-- ---------- Tout ce qui suit n'est exécuté que pour les whitelistés ----------

-- UI
local gui = Instance.new("ScreenGui")
local mainFrame = Instance.new("Frame")
local button = Instance.new("TextButton")
local statusLabel = Instance.new("TextLabel")
local lockIcon = Instance.new("TextLabel")

-- État free cam
local freeCamEnabled = false
local connections = {}
local movement = { forward = 0, backward = 0, left = 0, right = 0, up = 0, down = 0 }
local mouseDelta = Vector2.new(0, 0)
local cameraRotation = Vector2.new(0, 0)
local speed = 20
local boost = false

-- Références personnage
local character = nil
local humanoid = nil

local function updateCharacter()
	character = player.Character
	humanoid = character and character:FindFirstChild("Humanoid")
end

local function setCharacterMovementLock(locked)
	updateCharacter()
	if humanoid then
		humanoid.PlatformStand = locked
	end
end

-- Création de l'interface (moderne)
local function setupUI()
	gui.Name = "FreeCamGUI"
	gui.ResetOnSpawn = false
	gui.IgnoreGuiInset = true
	gui.Parent = player:WaitForChild("PlayerGui")

	-- Frame principal
	mainFrame.Size = UDim2.new(0, 200, 0, 110)
	mainFrame.Position = UDim2.new(0, 15, 1, -125)
	mainFrame.AnchorPoint = Vector2.new(0, 1)
	mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
	mainFrame.BackgroundTransparency = 0.1
	mainFrame.BorderSizePixel = 0
	mainFrame.Parent = gui

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 16)
	corner.Parent = mainFrame

	local stroke = Instance.new("UIStroke")
	stroke.Thickness = 1.5
	stroke.Color = Color3.fromRGB(100, 150, 255)
	stroke.Transparency = 0.6
	stroke.Parent = mainFrame

	-- Icône cadenas
	lockIcon.Size = UDim2.new(0, 30, 0, 30)
	lockIcon.Position = UDim2.new(0, 15, 0, 15)
	lockIcon.Text = "🔒"
	lockIcon.TextSize = 20
	lockIcon.TextColor3 = Color3.fromRGB(255, 255, 255)
	lockIcon.BackgroundTransparency = 1
	lockIcon.Parent = mainFrame

	-- Bouton
	button.Size = UDim2.new(0, 140, 0, 40)
	button.Position = UDim2.new(0.5, 0, 0, 50)
	button.AnchorPoint = Vector2.new(0.5, 0)
	button.Text = "🔓 ACTIVER"
	button.TextColor3 = Color3.fromRGB(255, 255, 255)
	button.TextSize = 14
	button.Font = Enum.Font.GothamBold
	button.BackgroundColor3 = Color3.fromRGB(45, 55, 80)
	button.BackgroundTransparency = 0.3
	button.BorderSizePixel = 0
	button.AutoButtonColor = false
	button.Parent = mainFrame

	local btnCorner = Instance.new("UICorner")
	btnCorner.CornerRadius = UDim.new(0, 20)
	btnCorner.Parent = button

	-- Animation hover
	local hoverTweenIn = TweenService:Create(button, TweenInfo.new(0.2), { BackgroundTransparency = 0 })
	local hoverTweenOut = TweenService:Create(button, TweenInfo.new(0.2), { BackgroundTransparency = 0.3 })
	button.MouseEnter:Connect(function() hoverTweenIn:Play() end)
	button.MouseLeave:Connect(function() hoverTweenOut:Play() end)

	-- Statut
	statusLabel.Size = UDim2.new(0, 170, 0, 25)
	statusLabel.Position = UDim2.new(0.5, 0, 1, -15)
	statusLabel.AnchorPoint = Vector2.new(0.5, 1)
	statusLabel.Text = "🔴 Caméra normale"
	statusLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
	statusLabel.TextSize = 12
	statusLabel.Font = Enum.Font.Gotham
	statusLabel.BackgroundTransparency = 1
	statusLabel.Parent = mainFrame
end

local function resetToCharacterCamera()
	updateCharacter()
	if humanoid then
		Camera.CameraType = Enum.CameraType.Custom
		Camera.CameraSubject = humanoid
	else
		Camera.CameraType = Enum.CameraType.Follow
	end
	if statusLabel then
		statusLabel.Text = "🔴 Caméra normale"
		lockIcon.Text = "🔒"
	end
end

local function cleanConnections()
	for _, conn in pairs(connections) do
		conn:Disconnect()
	end
	connections = {}
end

local function toggleFreeCam()
	freeCamEnabled = not freeCamEnabled

	if freeCamEnabled then
		Camera.CameraType = Enum.CameraType.Scriptable

		updateCharacter()
		local rootPart = character and character:FindFirstChild("HumanoidRootPart")
		if rootPart then
			Camera.CFrame = rootPart.CFrame + Vector3.new(0, 2, 5)
		end

		local _, yaw, pitch = Camera.CFrame:ToOrientation()
		cameraRotation = Vector2.new(yaw, pitch)
		mouseDelta = Vector2.new(0, 0)

		setCharacterMovementLock(true)

		local function onInputBegan(input, gp)
			if gp then return end
			if input.KeyCode == Enum.KeyCode.W then movement.forward = 1 end
			if input.KeyCode == Enum.KeyCode.S then movement.backward = 1 end
			if input.KeyCode == Enum.KeyCode.A then movement.left = 1 end
			if input.KeyCode == Enum.KeyCode.D then movement.right = 1 end
			if input.KeyCode == Enum.KeyCode.Space then movement.up = 1 end
			if input.KeyCode == Enum.KeyCode.LeftControl then movement.down = 1 end
			if input.KeyCode == Enum.KeyCode.LeftShift then boost = true end
		end

		local function onInputEnded(input, gp)
			if gp then return end
			if input.KeyCode == Enum.KeyCode.W then movement.forward = 0 end
			if input.KeyCode == Enum.KeyCode.S then movement.backward = 0 end
			if input.KeyCode == Enum.KeyCode.A then movement.left = 0 end
			if input.KeyCode == Enum.KeyCode.D then movement.right = 0 end
			if input.KeyCode == Enum.KeyCode.Space then movement.up = 0 end
			if input.KeyCode == Enum.KeyCode.LeftControl then movement.down = 0 end
			if input.KeyCode == Enum.KeyCode.LeftShift then boost = false end
		end

		local function onMouseMove(input)
			if input.UserInputType == Enum.UserInputType.MouseMovement then
				mouseDelta = input.Delta
			end
		end

		local function updateCamera(dt)
			local SENS = 0.002
			cameraRotation = cameraRotation + Vector2.new(-mouseDelta.X * SENS, -mouseDelta.Y * SENS)
			cameraRotation = Vector2.new(cameraRotation.X, math.clamp(cameraRotation.Y, -math.pi/2.2, math.pi/2.2))
			mouseDelta = Vector2.new(0, 0)

			local direction = CFrame.Angles(0, cameraRotation.X, 0) * CFrame.Angles(cameraRotation.Y, 0, 0)
			local forward = direction.LookVector
			local right = direction.RightVector
			local up = Vector3.new(0, 1, 0)

			local curSpeed = boost and speed * 3 or speed
			local move = Vector3.new(
				(movement.right - movement.left) * curSpeed * dt,
				(movement.up - movement.down) * curSpeed * dt,
				(movement.backward - movement.forward) * curSpeed * dt
			)

			local newCF = Camera.CFrame
			newCF = newCF + forward * move.Z + right * move.X + up * move.Y
			newCF = CFrame.new(newCF.Position) * CFrame.Angles(cameraRotation.Y, cameraRotation.X, 0)
			Camera.CFrame = newCF
		end

		connections["Began"] = UserInputService.InputBegan:Connect(onInputBegan)
		connections["Ended"] = UserInputService.InputEnded:Connect(onInputEnded)
		connections["MouseMove"] = UserInputService.InputChanged:Connect(onMouseMove)
		connections["Render"] = RunService.RenderStepped:Connect(updateCamera)

		UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter
		button.Text = "🔒 DÉSACTIVER"
		statusLabel.Text = "🟢 Caméra libre (F3)"
		lockIcon.Text = "🔓"
	else
		cleanConnections()
		resetToCharacterCamera()
		setCharacterMovementLock(false)
		UserInputService.MouseBehavior = Enum.MouseBehavior.Default
		button.Text = "🔓 ACTIVER"
		statusLabel.Text = "🔴 Caméra normale"
		lockIcon.Text = "🔒"
	end
end

-- Initialisation
setupUI()
button.MouseButton1Click:Connect(toggleFreeCam)

-- Raccourci F3
UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end
	if input.KeyCode == Enum.KeyCode.F3 then
		toggleFreeCam()
	end
end)

-- Gestion réapparition
player.CharacterAdded:Connect(function()
	updateCharacter()
	if freeCamEnabled then
		setCharacterMovementLock(true)
		local rootPart = character and character:FindFirstChild("HumanoidRootPart")
		if rootPart then
			Camera.CFrame = rootPart.CFrame + Vector3.new(0, 2, 5)
		end
	else
		resetToCharacterCamera()
		setCharacterMovementLock(false)
	end
end)

-- Nettoyage
player:GetPropertyChangedSignal("Parent"):Connect(function()
	if player.Parent == nil then
		cleanConnections()
		UserInputService.MouseBehavior = Enum.MouseBehavior.Default
	end
end)

updateCharacter()