--[[

	This is essential to do for all sounds so that each client can
	customise them to their own preference (SFX Volume, SFX Pitch, Cmd Volume, etc)

--]]


-- Handlers for different sound settings
local SETTINGS_KEY = "YouSettings"
local SOUND_KEY = "Sound"
local HANDLERS = {
	["Volume"] = function(soundGroup: SoundGroup, value: number)
		soundGroup.Volume = value
	end,
	["Pitch"] = function(soundGroup: SoundGroup, value: number)
		local pitchShifter = soundGroup:FindFirstChildWhichIsA("PitchShiftSoundEffect")
		if not pitchShifter then
			pitchShifter = Instance.new("PitchShiftSoundEffect")
			pitchShifter.Parent = soundGroup
		end
		pitchShifter.Enabled = value <= 0.99 or value >= 1.01
		pitchShifter.Octave = value
	end,
}

-- Types
export type SoundType = "Music" | "Command" | "Interface"

-- Local
local TAG = "HDAdminSound"
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local isClient = RunService:IsClient()
local isServer = not isClient
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local CollectionService = game:GetService("CollectionService")

if isServer then
	task.spawn(function()
		local function createGroup(name, parent)
			local soundGroup = parent:FindFirstChild(name)
			if soundGroup then
				return soundGroup
			end
			soundGroup = Instance.new("SoundGroup")
			soundGroup.Name = name
			soundGroup.Parent = parent
			return soundGroup
		end
		local audio = Instance.new("Folder")
		audio.Name = "Audio"
		audio.Parent = modules.Parent
		local Config = require(modules.Parent.Services.Config)
		local soundSettings = Config.getSetting(SOUND_KEY)
		local soundGroups = createGroup("Groups", audio)
		for soundAction, details in soundSettings do
			for soundType, _ in details do
				createGroup(soundType, soundGroups)
			end
		end
	end)
end

if isClient then
	task.spawn(function()
		local clientUser = require(modules.References.clientUser)
		local userPerm = clientUser.perm
		local everyone = clientUser.everyone
		local audio = modules.Parent:WaitForChild("Audio", 999999)
		local soundGroups = audio:WaitForChild("Groups", 999999)
		local function bindSound(soundInstance)
			if not soundInstance:IsA("Sound") then
				return
			end
			local soundType = soundInstance:GetAttribute("HDAdminSoundType")
			if not soundType then
				return
			end
			local typeGroup = soundGroups:FindFirstChild(soundType)
			if not typeGroup then
				return
			end
			soundInstance.SoundGroup = typeGroup
		end
		CollectionService:GetInstanceAddedSignal(TAG):Connect(bindSound)
		for _, soundInstance in CollectionService:GetTagged(TAG) do
			bindSound(soundInstance)
		end
		everyone:fetch("GameSettings", "PlayerSettings", SOUND_KEY, function(soundSettings)
			for soundAction, details in soundSettings do
				local handler = HANDLERS[soundAction]
				if not handler then
					continue
				end
				for soundType, _ in details do
					local typeGroup = soundGroups[soundType]
					local function apply()
						local userVal = userPerm:get(SETTINGS_KEY, SOUND_KEY, soundAction, soundType)
						if userVal ~= nil then
							handler(typeGroup, userVal)
							return
						end
						local gameVal = everyone:get("GameSettings", "PlayerSettings", SOUND_KEY, soundAction, soundType)
						if gameVal ~= nil then
							handler(typeGroup, gameVal)
						end
					end
					userPerm:onBind(SETTINGS_KEY, SOUND_KEY, soundAction, soundType, apply)
					everyone:onChange("GameSettings", "PlayerSettings", SOUND_KEY, soundAction, soundType, apply)
				end
			end
		end)
	end)
end

-- Just tag sound and CollectionService handles replication
return function(sound: Sound, soundType: SoundType?)
	if not soundType then
		soundType = if isClient then "Interface" else "Command"
	end
	if not(typeof(sound) == "Instance" and sound:IsA("Sound")) then
		return error("Invalid sound provided")
	end
	sound:SetAttribute("HDAdminSoundType", soundType)
	CollectionService:AddTag(sound, TAG)
	return sound
end