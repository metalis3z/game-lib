local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

local BrainrotController = require(ReplicatedStorage:WaitForChild("Source"):WaitForChild("Controllers"):WaitForChild("BrainrotController"))
local NotificationsController = require(ReplicatedStorage:WaitForChild("Source"):WaitForChild("Controllers"):WaitForChild("NotificationsController"))

local TeleportController = {}

local TeleportRemotes = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("TeleportService")
local RequestTeleportEvent = TeleportRemotes:WaitForChild("RequestTeleport")
local TeleportCompletedEvent = TeleportRemotes:WaitForChild("TeleportCompleted")

local CAMERA_DISTANCE = 14
local CAMERA_HEIGHT_OFFSET = 3
local FOCUS_HEIGHT_OFFSET = 2

local function applyCameraOrientation(targetCFrame)
	local player = Players.LocalPlayer
	local character = player.Character
	if not character then return end

	local hrp = character:FindFirstChild("HumanoidRootPart")
	if not hrp then return end

	local camera = Workspace.CurrentCamera
	if not camera then return end

	local lookVec = targetCFrame.LookVector
	local focus = hrp.Position + Vector3.new(0, FOCUS_HEIGHT_OFFSET, 0)
	local camPos = focus - lookVec * CAMERA_DISTANCE + Vector3.new(0, CAMERA_HEIGHT_OFFSET, 0)
	camera.CFrame = CFrame.lookAt(camPos, focus)
end

local isTeleporting = false
local CLIENT_COOLDOWN = 0.2

local function sendTeleportRequest(destinationType)
	if isTeleporting then return end

	if BrainrotController.GetCarryStackCount() > 0 then
		NotificationsController.SendRed("Cant teleport while collecting a brainrot!")
		return
	end

	isTeleporting = true
	RequestTeleportEvent:FireServer(destinationType)

	task.delay(CLIENT_COOLDOWN, function()
		isTeleporting = false
	end)
end

function TeleportController.Init()
	TeleportCompletedEvent.OnClientEvent:Connect(applyCameraOrientation)

	local player = Players.LocalPlayer
	local playerGui = player:WaitForChild("PlayerGui")

	local gui = playerGui:WaitForChild("GUI", 10)
	if not gui then
		return
	end

	local hud = gui:WaitForChild("HUD", 10)
	if not hud then
		return
	end

	local topButtons = hud:WaitForChild("TopButtons", 10)
	if not topButtons then
		return
	end

	local homeButton = topButtons:WaitForChild("Home", 10)
	local treeButton = topButtons:WaitForChild("Tree", 10)
	local shopButton = topButtons:WaitForChild("Shop", 10)

	if homeButton then
		homeButton.MouseButton1Click:Connect(function()
			sendTeleportRequest("Home")
		end)
	end

	if treeButton then
		treeButton.MouseButton1Click:Connect(function()
			sendTeleportRequest("Trees")
		end)
	end

	if shopButton then
		shopButton.MouseButton1Click:Connect(function()
			sendTeleportRequest("Shop")
		end)
	end
end

return TeleportController