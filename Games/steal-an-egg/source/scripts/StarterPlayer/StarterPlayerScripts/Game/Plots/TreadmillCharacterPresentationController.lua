local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

local Asserts = require(ReplicatedStorage.Library.Asserts)
local Easing = require(ReplicatedStorage.Library.Functions.Easing)
local Player = require(ReplicatedStorage.Library.Player)
local PlotCmds = require(ReplicatedStorage.Library.Client.PlotCmds)
local RuntimeInstanceRegistry = require(ReplicatedStorage.Library.Modules.RuntimeInstanceRegistry)
local TreadmillUtil = require(ReplicatedStorage.Library.Util.TreadmillUtil)
local Trove = require(ReplicatedStorage.Library.Modules.Packages.Trove)

local LocalPlayer = Players.LocalPlayer
local PlayerScripts = LocalPlayer:WaitForChild("PlayerScripts")
local CameraModule = require(PlayerScripts.PlayerModule):GetCameras()

local TreadmillCameraController = {}

local activeTrove = nil
local activeCharacterState = nil
local autoCameraState = nil
local currentCameraToken = 0

local originalBillboardAlwaysOnTop = {}
local originalHumanoidDisplayDistance = {}

local function restoreSnapshot(snapshot)
	for part, originalTransparency in pairs(snapshot.PartStates) do
		if part.Parent ~= nil then
			part.Transparency = originalTransparency
		end
	end
end

local function restoreActiveSnapshot()
	local state = activeCharacterState
	activeCharacterState = nil

	if state == nil then
		return
	end

	state.DescendantTrove:Destroy()

	for part, originalTransparency in pairs(state.PartStates) do
		if part.Parent ~= nil then
			part.Transparency = originalTransparency
		end
	end
end

local function restoreBillboardAlwaysOnTop(billboardGui, originalValue)
	if originalBillboardAlwaysOnTop[billboardGui] ~= originalValue then
		return
	end

	originalBillboardAlwaysOnTop[billboardGui] = nil

	if billboardGui.Parent == nil or billboardGui.AlwaysOnTop ~= false then
		return
	end

	billboardGui.AlwaysOnTop = originalValue
end

local function getCameraSubjectPosition()
	local camera = Workspace.CurrentCamera
	if camera == nil then
		return nil
	end

	local subject = camera.CameraSubject
	if subject == nil then
		return nil
	end

	if subject:IsA("Humanoid") then
		local subjectRoot = subject.RootPart
		return subjectRoot and subjectRoot.Position or nil
	elseif subject:IsA("BasePart") then
		return subject.Position
	end

	return nil
end

local function setBillboardNotAlwaysOnTop(billboardGui)
	Asserts.BillboardGui(billboardGui)

	local trove = activeTrove
	if trove ~= nil and originalBillboardAlwaysOnTop[billboardGui] == nil then
		local initialAlwaysOnTop = billboardGui.AlwaysOnTop

		originalBillboardAlwaysOnTop[billboardGui] = initialAlwaysOnTop
		billboardGui.AlwaysOnTop = false

		trove:Connect(billboardGui:GetPropertyChangedSignal("AlwaysOnTop"), function()
			if billboardGui.AlwaysOnTop == false then
				return
			end
			originalBillboardAlwaysOnTop[billboardGui] = nil
		end)

		trove:Add(function()
			if originalBillboardAlwaysOnTop[billboardGui] ~= initialAlwaysOnTop then
				return
			end

			originalBillboardAlwaysOnTop[billboardGui] = nil

			if billboardGui.Parent == nil or billboardGui.AlwaysOnTop ~= false then
				return
			end

			billboardGui.AlwaysOnTop = initialAlwaysOnTop
		end)
	end
end

local function restoreHumanoidDisplayDistanceType(humanoid, originalValue)
	if originalHumanoidDisplayDistance[humanoid] ~= originalValue then
		return
	end

	originalHumanoidDisplayDistance[humanoid] = nil

	if humanoid.Parent == nil or humanoid.DisplayDistanceType ~= Enum.HumanoidDisplayDistanceType.None then
		return
	end

	humanoid.DisplayDistanceType = originalValue
end

local function hideVisibleHumanoidDisplayDistance(humanoid)
	Asserts.Humanoid(humanoid)

	local trove = activeTrove
	if trove == nil or originalHumanoidDisplayDistance[humanoid] ~= nil then
		return
	end

	local initialDisplayDistanceType = humanoid.DisplayDistanceType

	if initialDisplayDistanceType ~= Enum.HumanoidDisplayDistanceType.None then
		originalHumanoidDisplayDistance[humanoid] = initialDisplayDistanceType
		humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None

		trove:Connect(humanoid:GetPropertyChangedSignal("DisplayDistanceType"), function()
			if humanoid.DisplayDistanceType == Enum.HumanoidDisplayDistanceType.None then
				return
			end
			originalHumanoidDisplayDistance[humanoid] = nil
		end)

		trove:Add(function()
			if originalHumanoidDisplayDistance[humanoid] ~= initialDisplayDistanceType then
				return
			end

			originalHumanoidDisplayDistance[humanoid] = nil

			if humanoid.Parent == nil or humanoid.DisplayDistanceType ~= Enum.HumanoidDisplayDistanceType.None then
				return
			end

			humanoid.DisplayDistanceType = initialDisplayDistanceType
		end)
	end
end

local function getCameraTransparency(distance)
	if distance <= 5 then
		return 1
	end
	return math.clamp(1 - (distance - 5) / 8, 0, 1)
end

local function trackCharacterPart(characterState, part)
	if not part:IsA("BasePart") then
		return
	end

	if part:FindFirstAncestorWhichIsA("Tool") ~= nil then
		return
	end

	if characterState.PartStates[part] == nil then
		characterState.PartStates[part] = part.Transparency
	end
end

local function bindCharacter(character)
	local trove = activeTrove
	if trove == nil then
		return
	end

	local previousState = activeCharacterState
	activeCharacterState = nil

	if previousState ~= nil then
		previousState.DescendantTrove:Destroy()
		for part, originalTransparency in pairs(previousState.PartStates) do
			if part.Parent ~= nil then
				part.Transparency = originalTransparency
			end
		end
	end

	local state = {
		Character = character,
		DescendantTrove = trove:Extend(),
		PartStates = {}
	}
	activeCharacterState = state

	for _, descendant in ipairs(character:GetDescendants()) do
		if descendant:IsA("BasePart") and descendant:FindFirstAncestorWhichIsA("Tool") == nil then
			if state.PartStates[descendant] == nil then
				state.PartStates[descendant] = descendant.Transparency
			end
		end
	end

	state.DescendantTrove:Connect(character.DescendantAdded, function(descendant)
		if not descendant:IsA("BasePart") then
			return
		end

		if descendant:FindFirstAncestorWhichIsA("Tool") ~= nil then
			return
		end

		if state.PartStates[descendant] == nil then
			state.PartStates[descendant] = descendant.Transparency
		end
	end)
end

local function updateCharacterTransparency()
	local camera = Workspace.CurrentCamera
	local head = Player.Optional.Head(LocalPlayer)

	if camera == nil or head == nil then
		return
	end

	local state = activeCharacterState
	if state == nil or head.Parent ~= state.Character then
		return
	end

	local distance = (camera.CFrame.Position - head.Position).Magnitude
	local cameraTransparency = getCameraTransparency(distance)

	for part, initialTransparency in pairs(state.PartStates) do
		if part.Parent == nil then
			state.PartStates[part] = nil
			continue
		end

		part.Transparency = math.max(initialTransparency, cameraTransparency)
	end
end

local function resolveCurrentTransparency()
	local camera = Workspace.CurrentCamera
	local head = Player.Optional.Head(LocalPlayer)

	if camera == nil or head == nil then
		return nil
	end

	local state = activeCharacterState
	if state == nil or head.Parent ~= state.Character then
		return nil
	end

	local distance = (camera.CFrame.Position - head.Position).Magnitude
	return getCameraTransparency(distance)
end

local function restoreAutoCameraState()
	local camera = Workspace.CurrentCamera
	if camera == nil or camera.CameraType ~= Enum.CameraType.Scriptable then
		return
	end

	camera.CameraType = Enum.CameraType.Custom
end

local function commitAutoCameraDistance(targetCFrame)
	local camera = Workspace.CurrentCamera
	if camera == nil then
		return
	end

	camera.CFrame = targetCFrame
	camera.CameraType = Enum.CameraType.Custom
end

local function completeAutoCameraState(targetCFrame)
	local state = autoCameraState
	autoCameraState = nil

	if state == nil then
		return
	end

	local camera = Workspace.CurrentCamera
	if camera == nil then
		return
	end

	camera.CFrame = targetCFrame
	camera.CameraType = Enum.CameraType.Custom
end

local function clearAutoCameraState()
	local state = autoCameraState
	autoCameraState = nil

	if state == nil then
		return
	end

	local camera = Workspace.CurrentCamera
	if camera == nil or camera.CameraType ~= Enum.CameraType.Scriptable then
		return
	end

	camera.CameraType = Enum.CameraType.Custom
end

local function resolveAutoCameraFocusPoint(rootPart, focusOffset)
	return rootPart.CFrame:PointToWorldSpace(focusOffset)
end

local function resolveAutoCameraTargetCFrame(screenPart, focusPoint)
	local offsetVector = screenPart.Position - focusPoint

	if offsetVector.Magnitude <= 0.001 then
		offsetVector = -screenPart.CFrame.LookVector
	end

	return CFrame.lookAt(focusPoint - offsetVector.Unit * 1.8, screenPart.Position + Vector3.new(0, 0.12, 0), Vector3.new(0, 1, 0))
end

local function updateAutoCamera()
	local state = autoCameraState
	if state == nil then
		return
	end

	local camera = Workspace.CurrentCamera
	local head = Player.Optional.Head(LocalPlayer)
	local rootPart = Player.Optional.HumanoidRootPart(LocalPlayer)
	local screenPart = state.VideoScreenPart

	if camera == nil or head == nil or rootPart == nil or screenPart == nil then
		return
	end

	if screenPart.Parent == nil then
		clearAutoCameraState()
		return
	end

	local focusPoint = rootPart.CFrame:PointToWorldSpace(state.FocusOffset)
	local targetCFrame = resolveAutoCameraTargetCFrame(screenPart, focusPoint)

	local alpha = math.clamp((os.clock() - state.StartedAt) / 0.35, 0, 1)
	local lerpedCFrame = state.InitialCameraCFrame:Lerp(targetCFrame, Easing(alpha, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut))

	camera.CFrame = lerpedCFrame

	if alpha >= 1 then
		completeAutoCameraState(targetCFrame)
	end
end

local function bindAutoCameraScreen(treadmillName, token)
	local treadmillTool = RuntimeInstanceRegistry.Require("Treadmill", treadmillName)
	assert(treadmillTool:IsA("Tool"), (("Runtime treadmill \"%*\" must be a Tool"):format(treadmillName)))

	local state = autoCameraState
	if state == nil or state.Token ~= token then
		return
	end

	local screenPart = TreadmillUtil.FindVideoFeedScreenPart(treadmillTool)
	if screenPart ~= nil then
		state.VideoScreenPart = screenPart
		return
	end

	clearAutoCameraState()
end

local function bindPlayerDisplayDistance(player)
	Asserts.Player(player)

	local trove = activeTrove
	if trove == nil then
		return
	end

	local humanoid = Player.Optional.Humanoid(player)
	if humanoid ~= nil then
		hideVisibleHumanoidDisplayDistance(humanoid)
	end

	local function bindPlayerCharacterDisplayDistance(characterModel)
		Asserts.Model(characterModel)

		local charHumanoid = Player.Optional.Humanoid(player)
		if charHumanoid ~= nil then
			hideVisibleHumanoidDisplayDistance(charHumanoid)
		end

		trove:Connect(characterModel.ChildAdded, function(child)
			if not child:IsA("Humanoid") then
				return
			end
			hideVisibleHumanoidDisplayDistance(child)
		end)
	end

	if player.Character ~= nil then
		bindPlayerCharacterDisplayDistance(player.Character)
	end

	trove:Connect(player.CharacterAdded, bindPlayerCharacterDisplayDistance)
end

local function bindHumanoidDisplayPresentation()
	local trove = activeTrove
	if trove == nil then
		return
	end

	for _, player in ipairs(Players:GetPlayers()) do
		task.defer(bindPlayerDisplayDistance, player)
	end

	trove:Connect(Players.PlayerAdded, bindPlayerDisplayDistance)
end

local function bindYourBaseBillboardPresentation()
	local trove = activeTrove
	if trove == nil then
		return
	end

	local function bindCurrentPlot()
		local billboard = PlotCmds.GetLocalYourBaseBillboard()
		if billboard == nil then
			return
		end
		setBillboardNotAlwaysOnTop(billboard)
	end

	local activeBillboard = PlotCmds.GetLocalYourBaseBillboard()
	if activeBillboard ~= nil then
		setBillboardNotAlwaysOnTop(activeBillboard)
	end

	trove:Add(PlotCmds.OnLocalPlotUpdated:Connect(bindCurrentPlot))
end

function TreadmillCameraController.Stop()
	currentCameraToken += 1

	if autoCameraState ~= nil then
		local camera = Workspace.CurrentCamera
		if camera ~= nil and camera.CameraType == Enum.CameraType.Scriptable then
			camera.CameraType = Enum.CameraType.Custom
		end
		autoCameraState = nil
	end

	if activeTrove ~= nil then
		activeTrove:Destroy()
		activeTrove = nil
		return
	end

	restoreActiveSnapshot()
end

function TreadmillCameraController.StopCameraTransparency()
	TreadmillCameraController.Stop()
end

function TreadmillCameraController.Start(treadmillName)
	Asserts.string(treadmillName)

	TreadmillCameraController.Stop()
	currentCameraToken += 1

	local token = currentCameraToken
	local trove = Trove.new()
	activeTrove = trove

	local camera = Workspace.CurrentCamera
	local rootPart = Player.Optional.HumanoidRootPart(LocalPlayer)
	local cameraSubjectPos = getCameraSubjectPosition()

	if camera ~= nil and cameraSubjectPos ~= nil and rootPart ~= nil then
		autoCameraState = {
			VideoScreenPart = nil,
			FocusOffset = rootPart.CFrame:PointToObjectSpace(cameraSubjectPos),
			InitialCameraCFrame = camera.CFrame,
			StartedAt = os.clock(),
			Token = token
		}
		task.spawn(bindAutoCameraScreen, treadmillName, token)
	end

	local character = LocalPlayer.Character
	if character ~= nil then
		bindCharacter(character)
	end

	trove:Connect(LocalPlayer.CharacterAdded, bindCharacter)
	trove:BindToRenderStep("TreadmillCameraAutoFrame", Enum.RenderPriority.Camera.Value + 1, updateAutoCamera)
	trove:BindToRenderStep("TreadmillCameraTransparency", Enum.RenderPriority.Camera.Value + 2, updateCharacterTransparency)

	bindHumanoidDisplayPresentation()
	bindYourBaseBillboardPresentation()

	trove:Add(restoreActiveSnapshot)
	trove:Add(clearAutoCameraState)
end

function TreadmillCameraController.StartCameraTransparency(treadmillName)
	TreadmillCameraController.Start(treadmillName)
end

function TreadmillCameraController.IsLocalCharacterFullyTransparent()
	local currentTransparency = resolveCurrentTransparency()
	return currentTransparency ~= nil and currentTransparency >= 1
end

return TreadmillCameraController