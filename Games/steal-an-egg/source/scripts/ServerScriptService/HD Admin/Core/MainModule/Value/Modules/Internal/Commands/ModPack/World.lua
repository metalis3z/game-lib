--!strict
-- LOCAL
local Lighting = game:GetService("Lighting")
local CommandAPI = require(script:FindFirstAncestor("HD Admin").Core.CommandAPI)
local getHRP = CommandAPI.getHRP
local isTableEmpty = CommandAPI.isTableEmpty
local activeSounds: {[Sound]: true} = {}


-- LOCAL FUNCTIONS
local function createClone(character: Model?): (Model?, {[string]: AnimationTrack}?)
	if not character then
		return nil, nil
	end
	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if not humanoid then
		return nil, nil
	end

	-- Set up the clone
	character.Archivable = true
	local clone = character:Clone()
	local cloneHumanoid = clone:FindFirstChildOfClass("Humanoid")
	local specialChar = false
	if clone:FindFirstChild("Chest") then
		specialChar = true
	end
	clone.Name = character.Name.."'s HDAdminClone"
	for _, instance in clone:GetDescendants() do
		local instanceParent = instance.Parent
		if instance:IsA("Humanoid") then
			instance.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
		elseif instance:IsA("BillboardGui") then
			instance:Destroy()
		elseif instance:IsA("Weld") and instance.Part1 ~= nil and instanceParent and instanceParent:IsA("BasePart") then
			instance.Part0 = instanceParent
			local part1 = instance.Part1
			local part1Name = (part1 and part1.Name) or ""
			if clone:FindFirstChild(part1Name) then
				instance.Part1 = (clone :: any)[part1Name]
			elseif not specialChar then
				instance:Destroy()
			end
		end
	end

	clone.Parent = workspace

	local tracks = {}
	local desc = humanoid:GetAppliedDescription()
	local animate = clone:FindFirstChild("Animate")
	if animate and cloneHumanoid then
		for _, instance in animate:GetChildren() do
			local anim = (instance:GetChildren()[1])
			if anim and anim:IsA("Animation") then
				tracks[instance.Name] = cloneHumanoid:LoadAnimation(anim)
			end
		end
		tracks.idle:Play()
	end

	return clone, tracks
end

local function validateSoundAsync(soundId: number): (boolean, string)
	local isTypeAsync = CommandAPI.isTypeAsync
	local success, warningOrInfo = isTypeAsync(soundId, Enum.AssetType.Audio)
	if not success or typeof(warningOrInfo) ~= "table" then
		return false, "Invalid SoundType"
	end
	local created = warningOrInfo.Created
	if created == "null" or not created then
		return false, "Invalid SoundId"
	end
	return true, warningOrInfo.Name
end

-- Top-of-screen hint shown to everyone when a track starts / changes
local function announceNowPlaying(task: CommandAPI.Task)
	local soundId = task:getArg("SoundId")
	for _, player in game:GetService("Players"):GetPlayers() do
		CommandAPI.prompt("hint", player, `Now playing '{task.extra.soundName}' ({soundId})`)
	end
end

local function playSoundId(task: CommandAPI.Task, sound: Sound, soundId: number): boolean
	if task.extra.validatedSoundId ~= soundId then
		local ok, nameOrReason = validateSoundAsync(soundId)
		if not ok then
			CommandAPI.prompt("warn", task.caller, nameOrReason)
			return false
		end
		task.extra.soundName = nameOrReason
		task.extra.validatedSoundId = soundId
	end
	sound.SoundId = "rbxassetid://" .. soundId
	sound:Play()
	if not task.isReplay or task.extra.hasPlayedOnce then
		announceNowPlaying(task)
	end
	task.extra.hasPlayedOnce = true
	return true
end


-- COMMANDS
local commands: CommandAPI.Commands = {

    --------------------
	{
		name = "Music",
		aliases	= {"Sound", "Audio"},
		args = {"SoundId", "MusicVolume", "MusicSpeed"},
		run = function(task: CommandAPI.Task)
			local sound = task:createSound("Music")
			sound.Looped = true
			sound.Name = "HDAdminSound"
			sound.Volume = task:getArg("MusicVolume")
			sound.PlaybackSpeed = task:getArg("MusicSpeed")
			sound.Parent = workspace
			if not playSoundId(task, sound, task:getArg("SoundId")) then
				sound:Destroy()
				return
			end
			task:keep("Indefinitely")
			activeSounds[sound] = true
			task.janitor:add(function()
				activeSounds[sound] = nil
				sound:Stop()
				sound:Destroy()
			end)
			local function applyMusic(changedArg: string?)
				if not sound.Parent then
					return
				end
				if changedArg == "SoundId" then
					playSoundId(task, sound, task:getArg("SoundId"))
					return
				end
				sound.Volume = task:getArg("MusicVolume")
				sound.PlaybackSpeed = task:getArg("MusicSpeed")
			end
			task:bindPrompt({
				audience = task.caller,
				args = {"SoundId", "MusicVolume", "MusicSpeed"},
				onChange = applyMusic,
			})
		end
	},

    --------------------
	{
		name = "Pitch",
		aliases	= {"PlaybackSpeed"},
		args = {
			{arg = "Number", display = "Pitch", default = 1.5, min = 0, max = 5, step = 0.1},
		},
		run = function(task: CommandAPI.Task)
			local number = task:getArg("Number")
			task:keep("Indefinitely")
			local originalSpeeds: {[Sound]: number} = {}
			for sound, _ in activeSounds do
				originalSpeeds[sound] = sound.PlaybackSpeed
				sound.PlaybackSpeed = number
			end
			task:onEnded(function()
				for sound, originalSpeed in originalSpeeds do
					if sound.Parent and activeSounds[sound] then
						sound.PlaybackSpeed = originalSpeed
					end
				end
			end)
		end
	},

    --------------------
	{
		name = "Volume",
		aliases	= {"Loudness"},
		args = {
			{arg = "Number", display = "Volume", default = 2, min = 0, max = 10, step = 0.1},
		},
		run = function(task: CommandAPI.Task)
			local number = task:getArg("Number")
			task:keep("Indefinitely")
			local originalVolumes: {[Sound]: number} = {}
			for sound, _ in activeSounds do
				originalVolumes[sound] = sound.Volume
				sound.Volume = number
			end
			task:onEnded(function()
				for sound, originalVolume in originalVolumes do
					if sound.Parent and activeSounds[sound] then
						sound.Volume = originalVolume
					end
				end
			end)
		end
	},

    --------------------
	{
		name = "Time",
		aliases	= {"ClockTime", "CT", "TimeOfDay", "TOD"},
		args = {"ClockTime"},
		run = function(task: CommandAPI.Task)
			local clockTime = task:getArg("ClockTime")
			local originalTime = Lighting.ClockTime
			task:keep("Indefinitely")
			Lighting.ClockTime = clockTime
			task:onEnded(function()
				Lighting.ClockTime = originalTime
			end)
			task:bindPrompt({
				audience = task.caller,
				args = {"ClockTime"},
				onChange = function(arg, value)
					Lighting.ClockTime = value
				end,
			})
		end
	},

    --------------------
	{
		name = "Fog",
		args = {
			{arg = "Number", display = "Distance", default = 100, min = 0, max = 10000, step = 1, logarithmic = true},
		},
		run = function(task: CommandAPI.Task)
			local fog = task:getArg("Number")
			local atmosphere = Lighting:FindFirstChildOfClass("Atmosphere")
			task:keep("Indefinitely")
			if atmosphere then
				atmosphere.Parent = nil
				task:onEnded(function()
					atmosphere.Parent = Lighting
				end)
			end
			task:tween(Lighting, TweenInfo.new(2), {
				FogEnd = fog
			})
			task:onEnded(function()
				Lighting.FogEnd = 100000
			end)
			task:bindPrompt({
				audience = task.caller,
				args = {"Number"},
				onChange = function(arg, value)
					Lighting.FogEnd = value
				end,
			})
		end
	},

    --------------------
	{
		name = "FogColor",
		args = {"Color"},
		run = function(task: CommandAPI.Task)
			local fogColor = task:getArg("Color")
			local originalColor = Lighting.FogColor
			task:keep("Indefinitely")
			task:tween(Lighting, TweenInfo.new(2), {
				FogColor = fogColor
			})
			task:onEnded(function()
				Lighting.FogColor = originalColor
			end)
			task:bindPrompt({
				audience = task.caller,
				args = {"Color"},
				onChange = function(arg, value)
					Lighting.FogColor = value
				end,
			})
		end
	},

    --------------------
	{
		name = "FieldOfView",
		aliases = {"FOV"},
		args = {
			"Player",
			{arg = "Number", default = 40, min = 1, max = 120, step = 1},
		},
		run = function(task: CommandAPI.Task)
			local target = task.target
			local fieldOfView = task:getArg("Number")
			task:keep("UntilTargetLeaves")
			task.client:run(target, fieldOfView)
		end
	},

    --------------------
	{
		name = "Disco",
		args = {},
		run = function(task: CommandAPI.Task)
			local TWEEN_INFO  = TweenInfo.new(1, Enum.EasingStyle.Linear)
			local propertiesToChange = {"Ambient", "OutdoorAmbient", "FogColor"}
			local targetHues = {3/3, 2/3, 1/3}
			if task.extra.discoOriginals == nil then
				local originals = {}
				for _, propertyName in propertiesToChange do
					originals[propertyName] = (Lighting :: any)[propertyName]
				end
				task.extra.discoOriginals = originals
			end
			task:keep("Indefinitely")
			task.spawn(function()
				while task.isActive and not task.deactivated do
					for hueIndex = 1, #targetHues do
						if not task.isActive or task.deactivated then
							break
						end
						local targetValue = targetHues[hueIndex]
						local newPropValues = {}
						for _, propertyName in propertiesToChange do
							newPropValues[propertyName] = Color3.fromHSV(targetValue, 1, 1)
						end
						local tween = task:tween(Lighting, TWEEN_INFO, newPropValues)
						tween.Completed:Wait()
						task.wait()
					end
				end
			end)
			task:onEnded(function()
				for propName, originalValue in (task.extra.discoOriginals :: {[string]: any}) do
					(Lighting :: any)[propName] = originalValue
				end
			end)
			task:bindPrompt({
				text = "Lighting cycles through colours",
				audience = task.caller,
			})
		end
	},

    --------------------
	{
		name = "Clone",
		stackable = true,
		args = {"Players"},
		description = "Creates a physical animated clone of the target player(s). Use ;clear <caller> to remove.",
		run = function(task: CommandAPI.Task)
			local poolOfTargets = task:getArg("Players")
			if isTableEmpty(task.qualifiers) then
				local caller = task.caller
				poolOfTargets = {}
				if caller then
					table.insert(poolOfTargets, caller)
				end
			end
			for _, target in poolOfTargets do
				local char = target.Character
				local hrp = getHRP(target)
				if not hrp or not char then return end
				local janitor = task.janitor
				local clone, tracks = createClone(char)
				if not clone then
					CommandAPI.prompt("error", task.caller, "Failed to clone character")
					return
				end
				task:keep("UntilCallerLeaves")
				if clone and tracks then
					janitor:add(function()
						for _, track in tracks do
							track:Stop()
							track:Destroy()
						end
						clone:Destroy()
					end)
				end
				local humanoid = clone:FindFirstChildOfClass("Humanoid")
				if humanoid then
					humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.Subject
					humanoid.HealthDisplayDistance = 25
					humanoid.NameDisplayDistance = 25
				end
				local cloneHRP = clone:WaitForChild("HumanoidRootPart", 3)
				if cloneHRP and cloneHRP:IsA("BasePart") then
					cloneHRP.CFrame = hrp.CFrame * CFrame.new(0, 5, 0)
				end
				clone.Name = target.Name.."'s Clone"
				clone.Parent = workspace
				task.defer(function()
					local MAKE_DENSE = PhysicalProperties.new(99, 0.5, 1, 0.3, 1)
					for _, part in clone:GetChildren() do
						if part:IsA("BasePart") then
							part.CustomPhysicalProperties = MAKE_DENSE
						end
					end
				end)
			end
		end
	},

    --------------------
	{
		name = "Clear",
		aliases = {"Clr"},
		description = "Clears all tasks without a target from the caller. For player-specific, use ;reset <player>.",
		args = {"Caller"},
		run = function(task: CommandAPI.Task)
			-- This clears all non-player specific tasks
			local callerToClear: Player = task.target
			local tasks = CommandAPI.getTasksByCallerId(callerToClear.UserId) :: {CommandAPI.Task}
			for _, targetTask: CommandAPI.Task in tasks do
				if not targetTask.target then
					targetTask:destroy()
				end
			end
		end
	},

    --------------------

}


return commands
