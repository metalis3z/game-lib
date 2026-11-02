-- Reference copy for study. Game: steal-a-brainrot-sab-files
-- Original: ReplicatedStorage/Controllers/JumpscareController.lua  (ModuleScript, 146 lines)
-- What it does: Clones a model in front of the camera, slams it towards the screen with a cubic ease, shakes it, adds black flash + contrast + depth of field, plays a loud sound, then cleans everything with a Trove.
-- (an advertising comment line from the original was removed)

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local Trove = require(ReplicatedStorage.Packages.Trove)
local Net = require(ReplicatedStorage.Packages.Net)
local JumpscareEvent = Net:RemoteEvent("JumpscareService/TriggerJumpscare")

local LocalPlayer = Players.LocalPlayer
local JumpscareController = {}

local function triggerJumpscare(animalName)
	animalName = animalName or "Tim Cheese"

	local currentCamera = workspace.CurrentCamera

	local animalModel = ReplicatedStorage:FindFirstChild("Models") 
		and require(ReplicatedStorage.Shared.BrainrotAssets).getModel(animalName)

	local scareSound = ReplicatedStorage:FindFirstChild("Sounds") 
		and ReplicatedStorage.Sounds.Animals:FindFirstChild(animalName)

	local idleAnim = ReplicatedStorage:FindFirstChild("Animations") 
		and ReplicatedStorage.Animations.Animals:FindFirstChild(animalName)
		and ReplicatedStorage.Animations.Animals[animalName]:FindFirstChild("Idle")

	if not LocalPlayer or not currentCamera or not animalModel or not scareSound or not idleAnim then
		warn("Jumpscare assets missing for:", animalName)
		return
	end

	local trove = Trove.new()

	local modelClone = trove:Add(animalModel:Clone())
	if not modelClone.PrimaryPart then
		trove:Destroy()
		return
	end

	for _, descendant in ipairs(modelClone:GetDescendants()) do
		if descendant:IsA("BasePart") then
			descendant.CanCollide = false
		end
	end

	local soundClone = trove:Add(scareSound:Clone())
	soundClone.Volume = 10
	soundClone.Parent = modelClone.PrimaryPart

	local colorCorrection = trove:Add(Instance.new("ColorCorrectionEffect"))
	colorCorrection.Saturation = -0.1
	colorCorrection.Brightness = -0.1
	colorCorrection.Contrast = 0
	colorCorrection.Parent = currentCamera

	local depthOfField = trove:Add(Instance.new("DepthOfFieldEffect"))
	depthOfField.Enabled = true
	depthOfField.FocusDistance = 8
	depthOfField.FarIntensity = 1
	depthOfField.NearIntensity = 0
	depthOfField.InFocusRadius = 2
	depthOfField.Parent = currentCamera

	local screenGui = trove:Add(Instance.new("ScreenGui"))
	screenGui.ResetOnSpawn = false
	screenGui.IgnoreGuiInset = true
	screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

	local flashFrame = Instance.new("Frame")
	flashFrame.Size = UDim2.new(1, 0, 1, 0)
	flashFrame.BackgroundColor3 = Color3.new(0, 0, 0)
	flashFrame.BackgroundTransparency = 1
	flashFrame.Parent = screenGui

	modelClone.Parent = currentCamera

	local rotationOffset = CFrame.Angles(0, math.pi, 0)
	local startCFrame = CFrame.new(0, -20, -15) * rotationOffset
	local endCFrame = CFrame.new(0, -6, -8) * rotationOffset

	TweenService:Create(depthOfField, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false, 4.3), {
		FarIntensity = 0, 
		NearIntensity = 0, 
		InFocusRadius = 0
	}):Play()

	TweenService:Create(colorCorrection, TweenInfo.new(0.3), { Contrast = 0.2 }):Play()

	TweenService:Create(flashFrame, TweenInfo.new(0.1), { BackgroundTransparency = 0 }):Play()
	task.delay(0.1, function()
		TweenService:Create(flashFrame, TweenInfo.new(0.4), { BackgroundTransparency = 1 }):Play()
	end)

	local animController = modelClone:FindFirstChildOfClass("AnimationController")
	if animController then
		local track = trove:Add(animController:LoadAnimation(idleAnim))
		track.Looped = true
		track.Play(track)
	end

	soundClone:Play()

	local startTime = os.clock()

	local renderConnection = RunService.RenderStepped:Connect(function()
		debug.profilebegin("Jumpscare:Update")
		local elapsed = os.clock() - startTime
		local targetRelativeCFrame = nil

		if elapsed < 0.3 then
			local alpha = elapsed / 0.3
			local cubicAlpha = alpha * alpha * alpha
			targetRelativeCFrame = startCFrame:Lerp(endCFrame, cubicAlpha)

		elseif elapsed < 4.3 then
			local shakeX = math.random(-5, 5) / 100
			local shakeY = math.random(-5, 5) / 100
			local shakeZ = math.random(-5, 5) / 100
			targetRelativeCFrame = endCFrame * CFrame.new(shakeX, shakeY, shakeZ)

		elseif elapsed < 4.8 then
			local alpha = math.sin((elapsed - 4.3) / 0.5 * 1.5707963267948966)
			targetRelativeCFrame = endCFrame:Lerp(startCFrame, alpha)

		else
			trove:Destroy()
			debug.profileend()
			return
		end

		modelClone:PivotTo(currentCamera.CFrame * targetRelativeCFrame)
		debug.profileend()
	end)

	trove:Add(renderConnection)
end

JumpscareController.Start = function()
	JumpscareEvent.OnClientEvent:Connect(triggerJumpscare)
end
JumpscareController.Jumpscare = triggerJumpscare

return JumpscareController
