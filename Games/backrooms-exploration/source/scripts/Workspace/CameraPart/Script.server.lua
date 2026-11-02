local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

while not Players.LocalPlayer do
	task.wait()
end
local localPlayer = Players.LocalPlayer

local slotsForInventory = script.Parent
if slotsForInventory:IsA("ScreenGui") then
	slotsForInventory.Enabled = false
end

local slotTemplate = slotsForInventory:FindFirstChild("Slot", true)
if slotTemplate then
	slotTemplate.Visible = false
end

local playerGui = localPlayer:WaitForChild("PlayerGui")
local titleScreen = playerGui:WaitForChild("TitleScreen")
local holder = titleScreen:WaitForChild("Holder")
local startButton = holder:WaitForChild("Startbutton")

local part = workspace:WaitForChild("CameraPart")
local maxAngle = 15
local speed = 0.7
local originalCFrame = part.CFrame
local gameStarted = false

local function lockCamera()
	if gameStarted then return end
	local camera = workspace.CurrentCamera
	if camera then
		camera.CameraType = Enum.CameraType.Scriptable
	end
end

localPlayer.CharacterAdded:Connect(lockCamera)
if localPlayer.Character then
	lockCamera()
end

local cameraConnection
cameraConnection = RunService.RenderStepped:Connect(function()
	if gameStarted then
		if cameraConnection then
			cameraConnection:Disconnect()
			cameraConnection = nil
		end
		return
	end

	local camera = workspace.CurrentCamera
	if not camera then return end

	if camera.CameraType ~= Enum.CameraType.Scriptable then
		camera.CameraType = Enum.CameraType.Scriptable
	end

	local angle = math.sin(os.clock() * speed) * math.rad(maxAngle)
	local newCFrame = originalCFrame * CFrame.Angles(0, 0, angle)

	part.CFrame = newCFrame
	camera.CFrame = newCFrame
end)

startButton.MouseButton1Click:Connect(function()
	if gameStarted then return end
	gameStarted = true

	if cameraConnection then
		cameraConnection:Disconnect()
		cameraConnection = nil
	end

	local camera = workspace.CurrentCamera
	if camera then
		camera.CameraType = Enum.CameraType.Scriptable

		local currentRotation = camera.CFrame.Rotation
		local targetCFrame = CFrame.new(-28.5, 129.6, 441) * currentRotation

		local fadeGui = Instance.new("ScreenGui")
		fadeGui.IgnoreGuiInset = true
		fadeGui.DisplayOrder = 9999

		local fadeFrame = Instance.new("Frame")
		fadeFrame.Size = UDim2.new(1, 0, 1, 0)
		fadeFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		fadeFrame.BackgroundTransparency = 1
		fadeFrame.Parent = fadeGui
		fadeGui.Parent = playerGui

		local moveTween = TweenService:Create(camera, TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {CFrame = targetCFrame})
		moveTween:Play()

		task.wait(0.3)

		local fadeToBlack = TweenService:Create(fadeFrame, TweenInfo.new(0.8), {BackgroundTransparency = 0})
		fadeToBlack:Play()
		fadeToBlack.Completed:Wait()

		camera.CameraType = Enum.CameraType.Custom
		holder:Destroy()

		task.wait(1.5)

		local fadeFromBlack = TweenService:Create(fadeFrame, TweenInfo.new(1), {BackgroundTransparency = 1})
		fadeFromBlack:Play()
		fadeFromBlack.Completed:Wait()

		fadeGui:Destroy()
	end
end)