local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Lighting = game:GetService("Lighting")
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")

local ShakiraEventManager = {}

local isActive = false
local concertClone = nil
local eventSound = nil
local autoStopThread = nil
local savedLighting = {}
local savedGravity = nil

local PINK = Color3.fromRGB(255, 105, 180)
local PINK_TINT = Color3.fromRGB(255, 182, 193)
local EVENT_DURATION = 200 -- 3 minutes 20 secondes
local SOUND_ID = "rbxassetid://95676954356195"

-- Event effects constants
local LOW_GRAVITY = 50
local NORMAL_GRAVITY = 196.2
local DANCE_ANIM_ID = "rbxassetid://182435998"

-- Track applied effects per character and connections
local appliedCharacters = {}
local effectMonitorThread = nil
local playerAddedConn = nil
local characterConns = {}

local function saveLighting()
	savedLighting = {
		Ambient = Lighting.Ambient,
		OutdoorAmbient = Lighting.OutdoorAmbient,
		FogColor = Lighting.FogColor,
		FogEnd = Lighting.FogEnd,
		FogStart = Lighting.FogStart,
		Brightness = Lighting.Brightness,
		ClockTime = Lighting.ClockTime,
	}
end

local function restoreLighting()
	for prop, value in pairs(savedLighting) do
		Lighting[prop] = value
	end
	local cc = Lighting:FindFirstChild("ShakiraPinkEffect")
	if cc then
		cc:Destroy()
	end
end

local function applyPinkSky()
	saveLighting()
	Lighting.Ambient = PINK
	Lighting.OutdoorAmbient = PINK
	Lighting.FogColor = PINK
	Lighting.FogEnd = 400
	Lighting.FogStart = 0
	Lighting.Brightness = 2
	Lighting.ClockTime = 12

	local cc = Instance.new("ColorCorrectionEffect")
	cc.Name = "ShakiraPinkEffect"
	cc.TintColor = PINK_TINT
	cc.Brightness = 0.05
	cc.Parent = Lighting
end

local function removeEffectsFromCharacter(character)
	local effects = appliedCharacters[character]
	if not effects then return end

	if effects.danceTrack then
		pcall(function() effects.danceTrack:Stop() end)
		pcall(function() effects.danceTrack:Destroy() end)
	end
	if effects.anim then
		effects.anim:Destroy()
	end
	if effects.trail then
		effects.trail:Destroy()
	end
	if effects.att0 then
		effects.att0:Destroy()
	end
	if effects.att1 then
		effects.att1:Destroy()
	end

	appliedCharacters[character] = nil
end

local function applyEffectsToCharacter(character)
	if appliedCharacters[character] then return end
	if not character or not character.Parent then return end

	local hrp = character:FindFirstChild("HumanoidRootPart")
	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if not hrp or not humanoid then return end

	local effects = {}

	-- Pink trail at feet
	local att0 = Instance.new("Attachment")
	att0.Name = "ShakiraTrailAtt0"
	att0.Position = Vector3.new(-0.5, -3, 0)
	att0.Parent = hrp

	local att1 = Instance.new("Attachment")
	att1.Name = "ShakiraTrailAtt1"
	att1.Position = Vector3.new(0.5, -3, 0)
	att1.Parent = hrp

	local trail = Instance.new("Trail")
	trail.Name = "ShakiraPinkTrail"
	trail.Attachment0 = att0
	trail.Attachment1 = att1
	trail.Color = ColorSequence.new(PINK)
	trail.Transparency = NumberSequence.new({
		NumberSequenceKeypoint.new(0, 0),
		NumberSequenceKeypoint.new(1, 1),
	})
	trail.Lifetime = 0.8
	trail.MinLength = 0.05
	trail.MaxLength = 8
	trail.Enabled = true
	trail.Parent = hrp

	effects.trail = trail
	effects.att0 = att0
	effects.att1 = att1

	-- Dance animation (Action priority overrides the client Animate script's Core priority)
	local animator = humanoid:FindFirstChildOfClass("Animator")
	if animator then
		local anim = Instance.new("Animation")
		anim.AnimationId = DANCE_ANIM_ID
		effects.anim = anim

		local track = animator:LoadAnimation(anim)
		track.Priority = Enum.AnimationPriority.Action
		track:Play()
		effects.danceTrack = track
	end

	appliedCharacters[character] = effects

	-- Auto-clean when character is removed
	character.AncestryChanged:Connect(function(_, parent)
		if not parent then
			removeEffectsFromCharacter(character)
		end
	end)
end

local function handlePlayer(player)
	-- Apply to current character if it exists
	if player.Character then
		task.spawn(function()
			task.wait(0.5)
			if isActive then
				applyEffectsToCharacter(player.Character)
			end
		end)
	end

	-- Handle future respawns / new characters
	local conn = player.CharacterAdded:Connect(function(character)
		task.wait(0.5)
		if isActive then
			applyEffectsToCharacter(character)
		end
	end)
	characterConns[player] = conn
end

local function startEffectMonitor()
	effectMonitorThread = task.spawn(function()
		while isActive do
			task.wait(1)
			for _, player in ipairs(Players:GetPlayers()) do
				local char = player.Character
				if char and char.Parent then
					if not appliedCharacters[char] then
						applyEffectsToCharacter(char)
					else
						local effects = appliedCharacters[char]
						if effects.danceTrack and effects.danceTrack.IsPlaying == false then
							effects.danceTrack:Play()
						end
					end
				end
			end
		end
	end)
end

local function stopEffectMonitor()
	if effectMonitorThread then
		task.cancel(effectMonitorThread)
		effectMonitorThread = nil
	end
end

local function startPlayerTracking()
	for _, player in ipairs(Players:GetPlayers()) do
		handlePlayer(player)
	end
	playerAddedConn = Players.PlayerAdded:Connect(handlePlayer)
end

local function stopPlayerTracking()
	if playerAddedConn then
		playerAddedConn:Disconnect()
		playerAddedConn = nil
	end
	for player, conn in pairs(characterConns) do
		conn:Disconnect()
	end
	characterConns = {}
end

function ShakiraEventManager.Start(duration)
	if isActive then
		return false, "The Shakira concert event is already active!"
	end

	duration = duration or EVENT_DURATION

	local template = ReplicatedStorage:FindFirstChild("ConcertShakira")
	if not template then
		return false, "ConcertShakira model not found in ReplicatedStorage!"
	end

	-- Clone the concert map into workspace
	concertClone = template:Clone()
	concertClone.Parent = workspace

	-- Apply pink sky
	applyPinkSky()

	-- Lower gravity globally
	savedGravity = Workspace.Gravity
	Workspace.Gravity = LOW_GRAVITY

	-- Play the song globally (3D sound at origin, large range)
	eventSound = Instance.new("Sound")
	eventSound.Name = "ShakiraConcertSong"
	eventSound.SoundId = SOUND_ID
	eventSound.Volume = 1
	eventSound.Looped = false
	eventSound.RollOffMaxDistance = 100000
	eventSound.RollOffMinDistance = 0
	eventSound.RollOffMode = Enum.RollOffMode.Linear
	eventSound.Parent = workspace
	eventSound:Play()

	isActive = true

	-- Signal to clients that the event is active (for gravity enforcement)
	ReplicatedStorage:SetAttribute("ShakiraEventActive", true)

	-- Apply effects to all current and future players
	startPlayerTracking()
	startEffectMonitor()

	-- Auto-stop after duration
	autoStopThread = task.spawn(function()
		task.wait(duration)
		if isActive then
			ShakiraEventManager.Stop()
		end
	end)

	return true
end

function ShakiraEventManager.Stop()
	if not isActive then
		return false, "The Shakira concert event is not active!"
	end

	isActive = false

	-- Stop the song
	if eventSound then
		eventSound:Stop()
		eventSound:Destroy()
		eventSound = nil
	end

	-- Remove the concert map
	if concertClone then
		concertClone:Destroy()
		concertClone = nil
	end

	-- Restore sky
	restoreLighting()

	-- Restore gravity
	if savedGravity then
		Workspace.Gravity = savedGravity
		savedGravity = nil
	end

	-- Signal to clients that the event is over
	ReplicatedStorage:SetAttribute("ShakiraEventActive", false)

	-- Stop tracking players and monitoring
	stopPlayerTracking()
	stopEffectMonitor()

	-- Remove all effects from all characters
	for character, _ in pairs(appliedCharacters) do
		removeEffectsFromCharacter(character)
	end

	-- Cancel auto-stop thread
	if autoStopThread then
		task.cancel(autoStopThread)
		autoStopThread = nil
	end

	return true
end

function ShakiraEventManager.IsActive()
	return isActive
end

return ShakiraEventManager