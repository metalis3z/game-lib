local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ContentProvider = game:GetService("ContentProvider")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local Players = game:GetService("Players")
local Debris = game:GetService("Debris")

require(ReplicatedStorage.Shared.EventTypes)
local EventController = require(ReplicatedStorage.Controllers.EventController)
local EffectController = require(ReplicatedStorage.Controllers.EffectController)
local NotificationController = require(ReplicatedStorage.Controllers.NotificationController)
local Observers = require(ReplicatedStorage.Packages.Observers)

local SoundController = require(ReplicatedStorage.Controllers.SoundController)
local Trove = require(ReplicatedStorage.Packages.Trove)
local LightingController = require(ReplicatedStorage.Controllers.LightingController)
local WorldBrainrotController = require(ReplicatedStorage.Controllers.WorldBrainrotController)
local ReplicatorClient = require(ReplicatedStorage.Packages.ReplicatorClient)
local Net = require(ReplicatedStorage.Packages.Net)
local BackroomsDropRemote = Net:RemoteEvent("BackroomsService/Drop")
local BackroomsInRemote = Net:RemoteEvent("BackroomsService/SetInBackrooms")
local CollectZoneRemote = Net:RemoteEvent("BackroomsService/CollectZoneEffect")

local random = Random.new()
local color3_3 = Color3.new(0, 0, 0)
local color3_yellow = Color3.fromRGB(255, 242, 153)

local function attachLight(part, color, brightness, range, yOffset)

	local topAttachment = Instance.new("Attachment")
	topAttachment.Name = "BackroomsAttachment"
	topAttachment.Position = Vector3.new(0, yOffset or 3, 0)
	local pointLight = Instance.new("PointLight")
	pointLight.Name = "BackroomsPointLight"
	pointLight.Brightness = brightness or 3
	pointLight.Color = color or color3_yellow
	pointLight.Range = range or 12
	pointLight.Parent = topAttachment
	topAttachment.Parent = part

	local bottomAttachment = Instance.new("Attachment")
	bottomAttachment.Name = "BackroomsGroundAttachment"
	bottomAttachment.Position = Vector3.new(0, -2, 0)
	local groundLight = Instance.new("PointLight")
	groundLight.Name = "BackroomsGroundLight"
	groundLight.Brightness = 8
	groundLight.Color = color or color3_yellow
	groundLight.Range = 14
	groundLight.Parent = bottomAttachment
	bottomAttachment.Parent = part
	return function()
		topAttachment:Destroy()
		bottomAttachment:Destroy()
	end, pointLight
end

local BACKROOMS_LIGHTING = {
	Priority = 100,
	Brightness = 2,
	ExposureCompensation = 0.1,
	EnvironmentDiffuseScale = 0.7,
	EnvironmentSpecularScale = 0.35,
	GlobalShadows = false,
	Ambient = Color3.fromRGB(105, 95, 70),
	OutdoorAmbient = Color3.fromRGB(90, 82, 60),
	ColorCorrection = {
		Brightness = -0.05,
		Saturation = -0.15,
		Contrast = 0.15,
		TintColor = Color3.fromRGB(255, 235, 145)
	}
}

local smokeTemplate = ReplicatedStorage:WaitForChild("Client"):WaitForChild("FakeBrainrotCamera"):WaitForChild("Smoke")

CollectZoneRemote.OnClientEvent:Connect(function(puffSoundPath: string, spawnCFrame: CFrame)

	local soundObj = ReplicatedStorage
	for _, part in ipairs(puffSoundPath:split(".")) do
		soundObj = soundObj:FindFirstChild(part)
		if not soundObj then break end
	end
	if soundObj then
		task.spawn(function()
			SoundController:PlaySound(soundObj, spawnCFrame.Position, false)
		end)
	end

	if smokeTemplate and spawnCFrame then
		local clone = smokeTemplate:Clone()
		clone:PivotTo(CFrame.new(spawnCFrame.Position))
		clone.Parent = workspace
		if clone:FindFirstChild("smoke1") then
			clone.smoke1:Emit(10)
		end
		task.delay(3, function()
			if clone and clone.Parent then
				clone:Destroy()
			end
		end)
	end
end)

local BackroomsClient = {}

local localPlayer = Players.LocalPlayer
local insideBackrooms = false
local ambienceSound = nil
local insideConn = nil
local outsideConn = nil
local popLighting = nil
local flickerTrove = nil
local insideMap = false
local renderPoolTrove = nil
local renderedBrainrots = {}

local dropButton = localPlayer.PlayerGui:WaitForChild("ToolsFrames").Drop
local dropButtonConn = nil

local function updateDropButton()
	local isSammyStealing = localPlayer:GetAttribute("SammyStealing")
	local isStealing = localPlayer:GetAttribute("Stealing")
	local inBackrooms = localPlayer:GetAttribute("InBackrooms")

	if isSammyStealing == true or (isStealing == true and inBackrooms == true) then
		dropButton.Visible = true
	else
		dropButton.Visible = false
	end
end

localPlayer:GetAttributeChangedSignal("SammyStealing"):Connect(updateDropButton)
localPlayer:GetAttributeChangedSignal("Stealing"):Connect(updateDropButton)
localPlayer:GetAttributeChangedSignal("InBackrooms"):Connect(updateDropButton)
task.spawn(updateDropButton)

dropButton.Activate.Activated:Connect(function()
	local isSammyStealing = localPlayer:GetAttribute("SammyStealing")
	local isStealing = localPlayer:GetAttribute("Stealing")
	local inBackrooms = localPlayer:GetAttribute("InBackrooms")
	if isSammyStealing == true or (isStealing == true and inBackrooms == true) then
		BackroomsDropRemote:FireServer()
	end
end)

local function applyInsideEffects(value)
	if value then

		if not popLighting then
			popLighting = LightingController:Push("Backrooms", BACKROOMS_LIGHTING)
		end

		if not flickerTrove then
			flickerTrove = Trove.new()
			flickerTrove:Add(Observers.observeTag("BackroomsFlicker", function(p12)
				if not p12:IsA("SpotLight") then
					return nil
				end
				local p12Parent = p12.Parent
				if not p12Parent or not p12Parent:IsA("BasePart") then
					return nil
				end
				local p12ParentColor = p12Parent.Color
				local running = true
				local v151 = Trove.new()
				v151:Add(function()
					running = false
					p12Parent.Color = p12ParentColor
					p12.Enabled = true
				end)
				task.spawn(function()
					task.wait(random:NextNumber(0, 8))
					while running do
						task.wait(random:NextNumber(8, 25))
						if not running then break end
						for _ = 1, random:NextInteger(2, 6) do
							if not running then break end
							p12Parent.Color = color3_3
							p12.Enabled = false
							task.wait(random:NextNumber(0.04, 0.18))
							if not running then break end
							p12Parent.Color = p12ParentColor
							p12.Enabled = true
							task.wait(random:NextNumber(0.04, 0.18))
						end
					end
				end)
				return v151:WrapClean()
			end, { workspace }))
		end
	else

		if popLighting then
			popLighting()
			popLighting = nil
		end

		if flickerTrove then
			flickerTrove:Destroy()
			flickerTrove = nil
		end
	end
end

local function setInsideBackrooms(value)
	if insideBackrooms == value then return end
	insideBackrooms = value
	localPlayer:SetAttribute("InBackrooms", value)

	BackroomsInRemote:FireServer(value)
	if insideMap then
		applyInsideEffects(value)
	end
end

local function startInsideDetection()

	if insideConn then insideConn:Disconnect() insideConn = nil end
	if outsideConn then outsideConn:Disconnect() outsideConn = nil end

	local overlapParams = OverlapParams.new()
	overlapParams.FilterType = Enum.RaycastFilterType.Include

	local function trySetupHitbox()
		local br = workspace:FindFirstChild("Backrooms")
		if not br then return nil end
		local map = br:FindFirstChild("BackroomsMap")
		if not map then return nil end
		return map:FindFirstChild("TeleportHitbox")
	end

	insideConn = RunService.Heartbeat:Connect(function()
		local teleportHitbox = trySetupHitbox()
		if not teleportHitbox then
			setInsideBackrooms(false)
			return
		end
		local char = localPlayer.Character
		if not char then
			setInsideBackrooms(false)
			return
		end
		local rootPart = char:FindFirstChild("HumanoidRootPart")
		if not rootPart then
			setInsideBackrooms(false)
			return
		end
		overlapParams.FilterDescendantsInstances = {char}
		local parts = workspace:GetPartsInPart(teleportHitbox, overlapParams)
		setInsideBackrooms(#parts > 0)
	end)
end

local function stopInsideDetection()
	if insideConn then insideConn:Disconnect() insideConn = nil end
	outsideConn = nil
	setInsideBackrooms(false)
end

function BackroomsClient.OnStart()
	insideMap = true
	startInsideDetection()

	renderedBrainrots = {}
	renderPoolTrove = Trove.new()
	renderPoolTrove:Add(WorldBrainrotController:RenderPool({
		PoolId = "Backrooms/Brainrots",
		ReplicatorId = "Backrooms/Brainrots",
		ShowTimer = true,
		ShowDropButton = true,
		GrabHoldDuration = 1.5,
		GrabMaxDistance = 10,
		KeepWhenGrabbed = false,
		RenderedBrainrots = renderedBrainrots,
		OnRendered = function(id)
			local entry = renderedBrainrots[id]
			if not entry or not entry.model or not entry.model.PrimaryPart then return end
			local primaryPart = entry.model.PrimaryPart
			
			task.defer(function()
				if not primaryPart.Parent then return end
				local cleanupLight, pointLight = attachLight(primaryPart, color3_yellow, 3, 16, 2)
				entry.trove:Add(cleanupLight)

				local running = true
				entry.trove:Add(function() running = false end)
				task.spawn(function()
					task.wait(random:NextNumber(0, 8))
					while running and pointLight.Parent do
						local isDespawning = false
						local rep = ReplicatorClient.get("Backrooms/Brainrots")
						if rep then
							local data = rep:TryIndex({"brainrots", id})
							isDespawning = data ~= nil and data.despawnTimer ~= nil and data.despawnTimer < 30
						end
						local waitMin = not isDespawning and 8 or 0.4
						local waitMax = not isDespawning and 25 or 1.5
						task.wait(random:NextNumber(waitMin, waitMax))
						if not running then break end
						local flickMin = not isDespawning and 2 or 4
						local flickMax = not isDespawning and 6 or 10
						for _ = 1, random:NextInteger(flickMin, flickMax) do
							if not running or not pointLight.Parent then break end
							pointLight.Enabled = false
							task.wait(random:NextNumber(0.04, 0.18))
							if not running or not pointLight.Parent then break end
							pointLight.Enabled = true
							task.wait(random:NextNumber(0.04, 0.18))
						end
					end
				end)
			end)
		end
	}))

	NotificationController:Notify(
		'<font color="#FFD700"><b>The Backrooms</b></font> have appeared in the cave!',
		6,
		"Sounds.Sfx.Success"
	)
end

function BackroomsClient.OnStop()
	insideMap = false
	stopInsideDetection()
	applyInsideEffects(false)
	if renderPoolTrove then
		renderPoolTrove:Destroy()
		renderPoolTrove = nil
		renderedBrainrots = {}
	end
end

function BackroomsClient.OnLoad()

	task.spawn(pcall, function()
		ContentProvider:PreloadAsync(script:GetChildren())
	end)

	local hideObserver = nil
	local showObserver = nil

	local function updateVisibility(skipEffect)
		if ReplicatedStorage:GetAttribute("BackroomsEvent") then

			if not skipEffect then
				EffectController:Activate("Blink")
			end

			if showObserver then
				showObserver()
				showObserver = nil
			end

			if not hideObserver then
				hideObserver = Observers.observeTag("HideInBackrooms", function(object)
					local originalParent = object.Parent
					object.Parent = script
					return function()
						pcall(function()
							object.Parent = originalParent
						end)
					end
				end, {workspace, script})
			end
		else
			
			if not skipEffect then
				EffectController:Activate("Blink")
			end

			if not showObserver then
				showObserver = Observers.observeTag("ShowInBackrooms", function(object)
					local originalParent = object.Parent
					local isDestroyed = false
					local destroyingConn = originalParent.Destroying:Once(function()
						isDestroyed = true
						object:Destroy()
					end)
					object.Parent = script
					return function()
						destroyingConn:Disconnect()
						if not isDestroyed then
							pcall(function()
								object.Parent = originalParent
							end)
						end
					end
				end, {workspace, script})
			end

			if hideObserver then
				hideObserver()
				hideObserver = nil
			end
		end
	end

	ReplicatedStorage:GetAttributeChangedSignal("BackroomsEvent"):Connect(updateVisibility)
	task.spawn(updateVisibility, true)
end

return BackroomsClient