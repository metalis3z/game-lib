local SINK_AMOUNT = 1.0
local HOLD_RADIUS = 3
local SINK_DURATION = 0.08

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local SoundService = game:GetService("SoundService")

local player = Players.LocalPlayer

-- Sound configuration
local SOUND_ID = "rbxassetid://90359576057190"
local SOUND_VOLUME = 0.8
local PITCH_MIN = 0.9
local PITCH_MAX = 1.1

-- Single shared Sound instance
local sharedSound = Instance.new("Sound")
sharedSound.Name = "KeycapClickSound"
sharedSound.SoundId = SOUND_ID
sharedSound.Volume = SOUND_VOLUME
sharedSound.PlaybackSpeed = 1.0
sharedSound.Parent = SoundService

-- Cache original CFrames so we can restore them
local originalCFrames = {}

-- Track which keycaps are currently pressed and their active tween
local pressedKeycaps = {}
local activeTweens = {}

local function isKeycap(obj)
	return obj:IsA("BasePart") and string.lower(obj.Name):find("keycap") ~= nil
end

local function pressKeycap(keycap)
	if pressedKeycaps[keycap] then return end
	pressedKeycaps[keycap] = true
	if not originalCFrames[keycap] then
		originalCFrames[keycap] = keycap.CFrame
	end

	-- Cancel any existing tween on this keycap
	if activeTweens[keycap] then
		activeTweens[keycap]:Cancel()
		activeTweens[keycap] = nil
	end

	-- Smooth sink animation like a real key press
	local tween = TweenService:Create(
		keycap,
		TweenInfo.new(SINK_DURATION, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
		{ CFrame = originalCFrames[keycap] * CFrame.new(0, -SINK_AMOUNT, 0) }
	)
	activeTweens[keycap] = tween
	tween:Play()
	tween.Completed:Connect(function()
		activeTweens[keycap] = nil
	end)

	-- Play click sound in sync with the key press
	sharedSound.PlaybackSpeed = PITCH_MIN + math.random() * (PITCH_MAX - PITCH_MIN)
	sharedSound:Play()
end

local function releaseKeycap(keycap)
	if not pressedKeycaps[keycap] then return end
	pressedKeycaps[keycap] = nil

	-- Cancel any active sink tween
	if activeTweens[keycap] then
		activeTweens[keycap]:Cancel()
		activeTweens[keycap] = nil
	end

	if originalCFrames[keycap] then
		-- Instant rise - zero delay
		keycap.CFrame = originalCFrames[keycap]
	end
end

-- Heartbeat: enforce sunk position + distance-based release
-- The keycap stays down as long as the player is above it.
-- It only rises when the player walks away (horizontal distance > HOLD_RADIUS).
-- This is much more reliable than TouchEnded which fires prematurely.
RunService.Heartbeat:Connect(function()
	local character = player.Character
	if not character then return end
	local hrp = character:FindFirstChild("HumanoidRootPart")
	if not hrp then return end

	local playerPos = hrp.Position
	local toRelease = {}

	for keycap in pairs(pressedKeycaps) do
		if keycap and keycap.Parent and originalCFrames[keycap] then
			local keycapPos = originalCFrames[keycap].Position
			local horizontalDist = (Vector3.new(playerPos.X, 0, playerPos.Z)
				- Vector3.new(keycapPos.X, 0, keycapPos.Z)).Magnitude

			if horizontalDist > HOLD_RADIUS then
				-- Player walked away - release the keycap
				table.insert(toRelease, keycap)
			end
		else
			-- Keycap was destroyed or removed
			table.insert(toRelease, keycap)
		end
	end

	for _, keycap in ipairs(toRelease) do
		releaseKeycap(keycap)
	end
end)

player.CharacterAdded:Connect(function(character)
	-- Release all keycaps from previous character
	for keycap in pairs(pressedKeycaps) do
		releaseKeycap(keycap)
	end

	local function connectPart(part)
		if not part:IsA("BasePart") then return end

		-- Touched: instant press (zero delay on sink)
		part.Touched:Connect(function(hit)
			if isKeycap(hit) then
				pressKeycap(hit)
			end
		end)

		-- TouchEnded is NOT used for release.
		-- Release is handled by Heartbeat distance check instead,
		-- which is far more reliable and prevents premature rising.
	end

	-- Connect to all existing character parts
	for _, part in character:GetChildren() do
		connectPart(part)
	end

	-- Connect to parts added later (accessories, tools, etc.)
	character.ChildAdded:Connect(connectPart)
end)