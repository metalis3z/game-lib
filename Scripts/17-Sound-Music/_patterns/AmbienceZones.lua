--[[
	AmbienceZones  (client ModuleScript, e.g. ReplicatedStorage/Shared/AmbienceZones)

	Area-based ambience (or area music) plus reverb. Mark invisible zone parts
	with the CollectionService tag "AmbienceZone" and give them attributes:

	  SoundId   (string, required)  e.g. "rbxassetid://1234567890"
	  Volume    (number, optional)  default 0.5
	  Priority  (number, optional)  default 0. Higher wins when zones overlap;
	                                on a tie, the smaller zone wins (a room inside a building).
	  Reverb    (string, optional)  an Enum.ReverbType name, e.g. "Cave", "ConcertHall"

	The zone the player stands in crossfades in; leaving all zones fades back to
	the default ambience. Rotated parts work because the point test is done in
	the part's own space. Reverb is only written when it actually changes.

	Ideas taken from:
	  - street-life           Audios: per-zone Sound that fades in on enter, out on exit
	  - hiroshima-expressway  EchoSound: AmbientReverb switched by invisible zone parts, only on change
	  - smash-egg-for-animals ZoneBossRoarClient: CFrame:PointToObjectSpace box test
	  - work-at-a-pizza-place Music: music chosen by the zone the player is in

	Usage (from a LocalScript):
		local AmbienceZones = require(ReplicatedStorage.Shared.AmbienceZones)
		AmbienceZones.Start({
			SoundGroup = SoundService:FindFirstChild("Ambience"), -- optional
			DefaultSoundId = "rbxassetid://1234567890",            -- optional outdoor ambience
			DefaultVolume = 0.3,
			FadeTime = 2,
		})
		AmbienceZones.Changed:Connect(function(zonePart: BasePart?)
			print("Now in", zonePart and zonePart.Name or "no zone")
		end)
]]

local CollectionService = game:GetService("CollectionService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local SoundService = game:GetService("SoundService")
local TweenService = game:GetService("TweenService")

local TAG = "AmbienceZone"
local CHECK_INTERVAL = 0.25

local AmbienceZones = {}

local changedEvent = Instance.new("BindableEvent")
AmbienceZones.Changed = changedEvent.Event

local config = {
	SoundGroup = nil :: SoundGroup?,
	DefaultSoundId = nil :: string?,
	DefaultVolume = 0.3,
	DefaultReverb = Enum.ReverbType.NoReverb,
	FadeTime = 2,
}

local zones: { BasePart } = {}
local currentZone: BasePart? = nil
local currentSound: Sound? = nil
local currentReverb: Enum.ReverbType? = nil
local started = false

local function isInside(part: BasePart, worldPosition: Vector3): boolean
	local localPos = part.CFrame:PointToObjectSpace(worldPosition)
	local half = part.Size / 2
	return math.abs(localPos.X) <= half.X and math.abs(localPos.Y) <= half.Y and math.abs(localPos.Z) <= half.Z
end

local function volumeOf(part: BasePart): number
	return part.Size.X * part.Size.Y * part.Size.Z
end

local function findZone(position: Vector3): BasePart?
	local best: BasePart? = nil
	local bestPriority = -math.huge
	for _, part in ipairs(zones) do
		if part.Parent and isInside(part, position) then
			local priority = part:GetAttribute("Priority") or 0
			if
				best == nil
				or priority > bestPriority
				or (priority == bestPriority and volumeOf(part) < volumeOf(best))
			then
				best, bestPriority = part, priority
			end
		end
	end
	return best
end

local function setReverb(reverb: Enum.ReverbType)
	if currentReverb ~= reverb then
		currentReverb = reverb
		SoundService.AmbientReverb = reverb
	end
end

local function crossfadeTo(soundId: string?, volume: number)
	local old = currentSound
	currentSound = nil
	if old then
		local fadeOut = TweenService:Create(old, TweenInfo.new(config.FadeTime), { Volume = 0 })
		fadeOut.Completed:Once(function()
			old:Destroy()
		end)
		fadeOut:Play()
	end
	if not soundId or soundId == "" then
		return
	end
	local sound = Instance.new("Sound")
	sound.Name = "Ambience"
	sound.SoundId = soundId
	sound.Looped = true
	sound.Volume = 0
	sound.SoundGroup = config.SoundGroup
	sound.Parent = SoundService
	sound:Play()
	TweenService:Create(sound, TweenInfo.new(config.FadeTime), { Volume = volume }):Play()
	currentSound = sound
end

local function applyZone(zone: BasePart?)
	currentZone = zone
	if zone then
		crossfadeTo(zone:GetAttribute("SoundId"), zone:GetAttribute("Volume") or 0.5)
		local reverbName = zone:GetAttribute("Reverb")
		local ok, reverb = pcall(function()
			return (Enum.ReverbType :: any)[reverbName]
		end)
		setReverb(if ok and reverb then reverb else config.DefaultReverb)
	else
		crossfadeTo(config.DefaultSoundId, config.DefaultVolume)
		setReverb(config.DefaultReverb)
	end
	changedEvent:Fire(zone)
end

local function addZone(instance: Instance)
	if instance:IsA("BasePart") and not table.find(zones, instance) then
		table.insert(zones, instance)
	end
end

local function removeZone(instance: Instance)
	local index = table.find(zones, instance :: any)
	if index then
		table.remove(zones, index)
	end
end

export type StartOptions = {
	SoundGroup: SoundGroup?,
	DefaultSoundId: string?,
	DefaultVolume: number?,
	DefaultReverb: Enum.ReverbType?,
	FadeTime: number?,
}

function AmbienceZones.Start(options: StartOptions?)
	if started then
		return
	end
	started = true
	local opts = options or {}
	config.SoundGroup = opts.SoundGroup
	config.DefaultSoundId = opts.DefaultSoundId
	config.DefaultVolume = opts.DefaultVolume or config.DefaultVolume
	config.DefaultReverb = opts.DefaultReverb or config.DefaultReverb
	config.FadeTime = opts.FadeTime or config.FadeTime

	for _, instance in ipairs(CollectionService:GetTagged(TAG)) do
		addZone(instance)
	end
	CollectionService:GetInstanceAddedSignal(TAG):Connect(addZone)
	CollectionService:GetInstanceRemovedSignal(TAG):Connect(removeZone)

	applyZone(nil) -- start with the default ambience

	local player = Players.LocalPlayer
	local elapsed = 0
	RunService.Heartbeat:Connect(function(dt)
		elapsed += dt
		if elapsed < CHECK_INTERVAL then
			return
		end
		elapsed = 0

		local character = player.Character
		local root = character and character:FindFirstChild("HumanoidRootPart")
		if not root then
			return
		end
		local zone = findZone((root :: BasePart).Position)
		if zone ~= currentZone then
			applyZone(zone)
		end
	end)
end

function AmbienceZones.GetCurrentZone(): BasePart?
	return currentZone
end

return AmbienceZones
