--!strict
-- LOCATION: StarterPlayer/StarterPlayerScripts/BrainrotPickupClient
-- Detects E key press near conveyor brainrots and fires PickupBrainrot RemoteEvent

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")

local SoundService = game:GetService("SoundService")

local player = Players.LocalPlayer
local Events = ReplicatedStorage:WaitForChild("Events")
local pickupEvent = Events:WaitForChild("PickupBrainrot")
local playPickupSoundEvent = Events:WaitForChild("PlayPickupSound")

-- Plays the pickup sound sent by the server for this player only
playPickupSoundEvent.OnClientEvent:Connect(function(soundId: string)
	if not soundId or soundId == "" then return end

	local sound = Instance.new("Sound")
	sound.Name = "BrainrotPickupSound"
	sound.SoundId = soundId
	sound.Volume = 3
	sound.Parent = SoundService

	sound:Play()
	sound.Ended:Once(function()
		sound:Destroy()
	end)

	-- Safety cleanup in case Ended never fires (e.g. failed asset load)
	task.delay(10, function()
		if sound.Parent then
			sound:Destroy()
		end
	end)
end)

local PICKUP_RANGE = 10 -- studs, must match server
local HOLD_DURATION = 0.3 -- seconds to hold E before pickup

local isHolding = false
local holdStart = 0
local nearestBrainrot = nil

-- Find the nearest ConveyorBrainrot in Workspace
local function findNearestBrainrot(): Instance?
	local character = player.Character
	if not character then return nil end
	local hrp = character:FindFirstChild("HumanoidRootPart")
	if not hrp then return nil end

	local nearest = nil
	local nearestDist = PICKUP_RANGE

	for _, descendant in ipairs(Workspace:GetChildren()) do
		if descendant.Name == "ConveyorBrainrot" and descendant.Parent == Workspace then
			-- Get position from the inner Model if it's a Folder
			local pos
			if descendant:IsA("Model") then
				pos = descendant:GetPivot().Position
			elseif descendant:IsA("Folder") then
				local innerModel = descendant:FindFirstChildOfClass("Model")
				pos = innerModel and innerModel:GetPivot().Position or descendant:GetPivot().Position
			else
				continue
			end

			local dist = (hrp.Position - pos).Magnitude
			if dist < nearestDist then
				nearestDist = dist
				nearest = descendant
			end
		end
	end

	return nearest
end

-- Simple proximity prompt using ProximityPrompt
local function setupProximityPrompt(brainrot: Instance)
	-- Remove existing prompt if any
	local existing = brainrot:FindFirstChild("BrainrotPrompt")
	if existing then existing:Destroy() end

	local prompt = Instance.new("ProximityPrompt")
	prompt.Name = "BrainrotPrompt"
	prompt.ActionText = "Pegar"
	prompt.ObjectText = brainrot:GetAttribute("OriginalName") or "Brainrot"
	prompt.KeyboardKeyCode = Enum.KeyCode.E
	prompt.HoldDuration = HOLD_DURATION
	prompt.MaxActivationDistance = PICKUP_RANGE
	prompt.RequiresLineOfSight = false

	-- Parent to the inner model if Folder, so the prompt has a valid adornee
	if brainrot:IsA("Folder") then
		local innerModel = brainrot:FindFirstChildOfClass("Model")
		if innerModel then
			prompt.Parent = innerModel
		else
			prompt.Parent = brainrot
		end
	else
		prompt.Parent = brainrot
	end

	prompt.Triggered:Connect(function()
		pickupEvent:FireServer(brainrot)
	end)
end

-- Watch for new ConveyorBrainrots in Workspace
Workspace.ChildAdded:Connect(function(child)
	if child.Name == "ConveyorBrainrot" then
		task.wait(0.1) -- wait for it to be fully set up
		if child.Parent then
			setupProximityPrompt(child)
		end
	end
end)

-- Set up prompts for any existing brainrots
for _, child in ipairs(Workspace:GetChildren()) do
	if child.Name == "ConveyorBrainrot" then
		setupProximityPrompt(child)
	end
end

print("[BrainrotPickupClient] Initialized")