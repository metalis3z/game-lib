--[[
	AudioSettings  (ModuleScript in ReplicatedStorage, used by BOTH server and client)

	Music / SFX volume controlled through SoundGroups, saved per player.

	  - Server: loads saved volumes from a DataStore into player attributes,
	    accepts validated changes from the client, writes once when the player
	    leaves (and on shutdown).
	  - Client: creates the SoundGroups, routes every Sound in the game into
	    one of them, applies the saved values, and exposes SetVolume / GetVolume
	    plus a Changed signal for your slider UI. Saves are debounced so dragging
	    a slider does not spam the server.

	Routing rule for Sounds that have no SoundGroup yet: a Sound inside a folder
	named "Music", or a looped Sound at least 25 s long, goes to Music; everything
	else goes to SFX. Sounds already in another SoundGroup are left alone.

	Ideas taken from:
	  - smash-egg-for-animals SettingsHandler + SettingsServer: SoundGroups, auto-routing,
	    attributes as the sync channel, one DataStore write per session
	  - drill-and-mine        SettingsController: debounced save (cancel the pending task.delay)
	  - big-paintball         Audio: global mute that does not destroy per-sound volumes

	Usage:
		-- Server Script
		require(ReplicatedStorage.AudioSettings).StartServer()

		-- LocalScript
		local AudioSettings = require(ReplicatedStorage.AudioSettings)
		AudioSettings.StartClient()
		AudioSettings.Changed:Connect(function(category, volume)
			-- update your slider UI here
		end)
		slider.ValueChanged:Connect(function(v) AudioSettings.SetVolume("Music", v) end)
		print(AudioSettings.GetVolume("SFX"))
]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local SoundService = game:GetService("SoundService")

local CATEGORIES = { "Music", "SFX" }
local DEFAULT_VOLUME = 1
local DATASTORE_NAME = "AudioSettings_v1"
local MUSIC_MIN_LENGTH = 25 -- looped sounds at least this long count as music
local SAVE_DEBOUNCE = 0.5
local REMOTE_NAME = "AudioSettingsSave"

local AudioSettings = {}

local changedEvent = Instance.new("BindableEvent")
AudioSettings.Changed = changedEvent.Event -- (category: string, volume: number)

local function attributeName(category: string): string
	return "Volume_" .. category
end

local function isCategory(value: any): boolean
	return typeof(value) == "string" and table.find(CATEGORIES, value) ~= nil
end

local function cleanVolume(value: any): number?
	if typeof(value) ~= "number" or value ~= value then -- reject NaN
		return nil
	end
	return math.clamp(value, 0, 1)
end

------------------------------------------------------------------------ server

function AudioSettings.StartServer()
	assert(RunService:IsServer(), "StartServer must be called from the server")
	local DataStoreService = game:GetService("DataStoreService")

	local remote = Instance.new("RemoteEvent")
	remote.Name = REMOTE_NAME
	remote.Parent = script

	local okStore, store = pcall(function()
		return DataStoreService:GetDataStore(DATASTORE_NAME)
	end)
	local dirty: { [Player]: boolean } = {}

	local function onPlayerAdded(player: Player)
		for _, category in ipairs(CATEGORIES) do
			player:SetAttribute(attributeName(category), DEFAULT_VOLUME)
		end
		if not okStore then
			return
		end
		local ok, data = pcall(function()
			return store:GetAsync("u" .. player.UserId)
		end)
		if ok and typeof(data) == "table" and player.Parent then
			for _, category in ipairs(CATEGORIES) do
				local volume = cleanVolume(data[category])
				if volume then
					player:SetAttribute(attributeName(category), volume)
				end
			end
		end
	end

	remote.OnServerEvent:Connect(function(player, category, volume)
		if not isCategory(category) then
			return
		end
		local clean = cleanVolume(volume)
		if not clean then
			return
		end
		player:SetAttribute(attributeName(category), clean)
		dirty[player] = true
	end)

	local function flush(player: Player)
		if not dirty[player] then
			return
		end
		dirty[player] = nil
		if not okStore then
			return
		end
		local data = {}
		for _, category in ipairs(CATEGORIES) do
			data[category] = player:GetAttribute(attributeName(category)) or DEFAULT_VOLUME
		end
		pcall(function()
			store:SetAsync("u" .. player.UserId, data)
		end)
	end

	Players.PlayerAdded:Connect(onPlayerAdded)
	for _, player in ipairs(Players:GetPlayers()) do
		task.spawn(onPlayerAdded, player)
	end
	Players.PlayerRemoving:Connect(flush)
	game:BindToClose(function()
		for _, player in ipairs(Players:GetPlayers()) do
			task.spawn(flush, player)
		end
		task.wait(2)
	end)
end

------------------------------------------------------------------------ client

local groups: { [string]: SoundGroup } = {}
local volumes: { [string]: number } = {}
local pendingSave: { [string]: thread } = {}
local remote: RemoteEvent? = nil

local function getGroup(category: string): SoundGroup
	local group = SoundService:FindFirstChild(category)
	if not (group and group:IsA("SoundGroup")) then
		group = Instance.new("SoundGroup")
		group.Name = category
		group.Parent = SoundService
	end
	return group :: SoundGroup
end

local function isMusic(sound: Sound): boolean
	local parent = sound.Parent
	if parent and parent.Name == "Music" then
		return true
	end
	return sound.Looped and sound.TimeLength >= MUSIC_MIN_LENGTH
end

local function route(sound: Sound)
	local current = sound.SoundGroup
	if current and current ~= groups.Music and current ~= groups.SFX then
		return -- the game put it in its own group on purpose
	end
	sound.SoundGroup = if isMusic(sound) then groups.Music else groups.SFX
end

local function watch(instance: Instance)
	if not instance:IsA("Sound") then
		return
	end
	route(instance)
	-- TimeLength is only known after loading, and Looped can change later.
	instance.Loaded:Connect(function()
		route(instance)
	end)
	instance:GetPropertyChangedSignal("Looped"):Connect(function()
		route(instance)
	end)
end

local function apply(category: string, volume: number)
	volumes[category] = volume
	groups[category].Volume = volume
	changedEvent:Fire(category, volume)
end

function AudioSettings.StartClient()
	assert(RunService:IsClient(), "StartClient must be called from the client")
	local player = Players.LocalPlayer

	for _, category in ipairs(CATEGORIES) do
		groups[category] = getGroup(category)
		local saved = cleanVolume(player:GetAttribute(attributeName(category)))
		apply(category, saved or DEFAULT_VOLUME)

		-- The server sets the saved value a moment after join.
		player:GetAttributeChangedSignal(attributeName(category)):Connect(function()
			local value = cleanVolume(player:GetAttribute(attributeName(category)))
			if value and not pendingSave[category] and value ~= volumes[category] then
				apply(category, value)
			end
		end)
	end

	for _, root in ipairs({ workspace, SoundService, player:WaitForChild("PlayerGui") }) do
		for _, descendant in ipairs(root:GetDescendants()) do
			watch(descendant)
		end
		root.DescendantAdded:Connect(watch)
	end

	remote = script:WaitForChild(REMOTE_NAME) :: RemoteEvent
end

function AudioSettings.SetVolume(category: string, volume: number)
	assert(isCategory(category), "Unknown audio category: " .. tostring(category))
	local clean = cleanVolume(volume) or DEFAULT_VOLUME
	apply(category, clean)

	-- Debounce: only the last value of a slider drag is sent.
	local pending = pendingSave[category]
	if pending then
		task.cancel(pending)
	end
	pendingSave[category] = task.delay(SAVE_DEBOUNCE, function()
		pendingSave[category] = nil
		if remote then
			remote:FireServer(category, volumes[category])
		end
	end)
end

function AudioSettings.GetVolume(category: string): number
	return volumes[category] or DEFAULT_VOLUME
end

-- Quick mute toggle that remembers the previous value.
local beforeMute: { [string]: number } = {}
function AudioSettings.ToggleMute(category: string): boolean
	if (volumes[category] or 0) > 0 then
		beforeMute[category] = volumes[category]
		AudioSettings.SetVolume(category, 0)
		return true -- now muted
	end
	AudioSettings.SetVolume(category, beforeMute[category] or DEFAULT_VOLUME)
	return false
end

return AudioSettings
