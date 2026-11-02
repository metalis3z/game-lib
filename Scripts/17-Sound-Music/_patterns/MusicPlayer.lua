--[[
	MusicPlayer  (client ModuleScript, e.g. ReplicatedStorage/Shared/MusicPlayer)

	Background music with a playlist, shuffle (no back-to-back repeat when the
	list reshuffles), crossfades between tracks, and "override" layers for
	zones / bosses / events that sit on top of the playlist. When the last
	override is removed, the playlist track that was interrupted resumes from
	where it stopped.

	Ideas taken from:
	  - big-paintball         Audio.PlayMusic: fade the new track in, every old track out
	  - drill-and-mine        MusicController: drive music on the client, recover if it goes silent
	  - smash-egg-for-animals / casino-lvah: advance the playlist on Sound.Ended
	  - work-at-a-pizza-place Music: remember TimePosition and resume the outdoor song
	  - brainrot-lab          MusicController: state-driven crossfade

	Usage (from a LocalScript):
		local MusicPlayer = require(ReplicatedStorage.Shared.MusicPlayer)

		local music = MusicPlayer.new({
			SoundGroup = SoundService:WaitForChild("Music"), -- optional, lets a volume slider control it
			FadeTime = 1.5,
		})
		music:SetPlaylist({ 1234567890, 2345678901, 3456789012 }, true, 0.4) -- ids, shuffle, track volume
		music:Play()

		-- Zone / boss / event music on top of the playlist (highest Priority wins,
		-- equal priority -> the most recently pushed wins):
		music:PushOverride("Boss", 4567890123, { Priority = 10, Volume = 0.6 })
		music:PopOverride("Boss") -- the interrupted playlist track fades back in

		music:Next()          -- skip to the next playlist track
		music:SetVolume(0.5)  -- master multiplier for this player (0..1)
		music:Stop()
]]

local SoundService = game:GetService("SoundService")
local TweenService = game:GetService("TweenService")

local LOAD_TIMEOUT = 10 -- seconds before a track that never loads is skipped

local rng = Random.new()

local function toSoundId(id: any): string
	if typeof(id) == "number" then
		return "rbxassetid://" .. tostring(id)
	end
	local text = tostring(id)
	if string.find(text, "rbxasset", 1, true) then
		return text
	end
	return "rbxassetid://" .. text
end

-- Fisher-Yates shuffle of 1..n. If the first entry equals `avoidFirst`
-- (the track that just played) it is swapped away so it never repeats back-to-back.
local function shuffledOrder(n: number, avoidFirst: number?): { number }
	local order = table.create(n)
	for i = 1, n do
		order[i] = i
	end
	for i = n, 2, -1 do
		local j = rng:NextInteger(1, i)
		order[i], order[j] = order[j], order[i]
	end
	if avoidFirst and n > 1 and order[1] == avoidFirst then
		order[1], order[n] = order[n], order[1]
	end
	return order
end

local MusicPlayer = {}
MusicPlayer.__index = MusicPlayer

export type Options = {
	SoundGroup: SoundGroup?,
	FadeTime: number?,
	Volume: number?,
	Parent: Instance?,
}

function MusicPlayer.new(options: Options?)
	local opts = options or {}
	local self = setmetatable({}, MusicPlayer)

	self.FadeTime = opts.FadeTime or 1.5
	self.MasterVolume = opts.Volume or 1
	self.SoundGroup = opts.SoundGroup
	self.Parent = opts.Parent or SoundService

	self._playlist = {} -- { string }
	self._order = {} -- { number } indexes into _playlist
	self._index = 0
	self._shuffle = false
	self._trackVolume = 0.5

	self._overrides = {} -- [key] = { Id, Volume, Priority, Order }
	self._pushCounter = 0

	self._playing = false
	self._current = nil -- Sound currently fading in / playing
	self._currentKey = nil -- "playlist" or an override key
	self._currentBaseVolume = 0
	self._endedConn = nil
	self._resume = nil -- { Id, Time } of the interrupted playlist track

	return self
end

function MusicPlayer:SetPlaylist(ids: { any }, shuffle: boolean?, trackVolume: number?)
	self._playlist = {}
	for i, id in ipairs(ids) do
		self._playlist[i] = toSoundId(id)
	end
	self._shuffle = shuffle == true
	self._trackVolume = trackVolume or self._trackVolume
	self._order = {}
	self._index = 0
	self._resume = nil

	if self._playing and self._currentKey == "playlist" then
		self:_refresh(true)
	end
end

function MusicPlayer:_nextPlaylistId(): string?
	local n = #self._playlist
	if n == 0 then
		return nil
	end
	self._index += 1
	if self._index > #self._order then
		local last = self._order[#self._order]
		if self._shuffle then
			self._order = shuffledOrder(n, last)
		else
			self._order = table.create(n)
			for i = 1, n do
				self._order[i] = i
			end
		end
		self._index = 1
	end
	return self._playlist[self._order[self._index]]
end

-- Fades the current Sound out (then destroys it) and fades a new one in.
function MusicPlayer:_fadeTo(soundId: string?, baseVolume: number, looped: boolean, startTime: number?)
	if self._endedConn then
		self._endedConn:Disconnect()
		self._endedConn = nil
	end

	local old = self._current
	self._current = nil
	if old then
		local fadeOut = TweenService:Create(old, TweenInfo.new(self.FadeTime), { Volume = 0 })
		fadeOut.Completed:Once(function()
			old:Destroy()
		end)
		fadeOut:Play()
	end

	if not soundId then
		return
	end

	local sound = Instance.new("Sound")
	sound.Name = "Music"
	sound.SoundId = soundId
	sound.Looped = looped
	sound.Volume = 0
	sound.SoundGroup = self.SoundGroup
	sound.TimePosition = startTime or 0
	sound.Parent = self.Parent
	sound:Play()

	self._current = sound
	self._currentBaseVolume = baseVolume
	TweenService:Create(sound, TweenInfo.new(self.FadeTime), { Volume = baseVolume * self.MasterVolume }):Play()

	if not looped then
		self._endedConn = sound.Ended:Connect(function()
			if self._current == sound then
				self:_refresh(true)
			end
		end)
	end

	-- Watchdog: a track that never loads would never fire Ended, so skip it.
	task.delay(LOAD_TIMEOUT, function()
		if self._current == sound and not sound.IsLoaded and self._currentKey == "playlist" then
			warn("[MusicPlayer] Could not load " .. soundId .. ", skipping")
			self:_refresh(true)
		end
	end)
end

function MusicPlayer:_topOverride()
	local bestKey, best = nil, nil
	for key, entry in pairs(self._overrides) do
		if
			best == nil
			or entry.Priority > best.Priority
			or (entry.Priority == best.Priority and entry.Order > best.Order)
		then
			bestKey, best = key, entry
		end
	end
	return bestKey, best
end

-- Decides what should be playing right now and crossfades to it if needed.
function MusicPlayer:_refresh(advancePlaylist: boolean?)
	if not self._playing then
		return
	end

	local key, entry = self:_topOverride()
	if key and entry then
		if self._currentKey ~= key then
			-- Remember where the playlist track was so we can resume it later.
			if self._currentKey == "playlist" and self._current then
				self._resume = { Id = self._current.SoundId, Time = self._current.TimePosition }
			end
			self._currentKey = key
			self:_fadeTo(entry.Id, entry.Volume, true)
		end
		return
	end

	if self._currentKey ~= "playlist" or advancePlaylist or self._current == nil then
		self._currentKey = "playlist"
		local resume = self._resume
		self._resume = nil
		if resume and not advancePlaylist then
			self:_fadeTo(resume.Id, self._trackVolume, #self._playlist == 1, resume.Time)
		else
			self:_fadeTo(self:_nextPlaylistId(), self._trackVolume, #self._playlist == 1)
		end
	end
end

function MusicPlayer:Play()
	self._playing = true
	self:_refresh(false)
end

function MusicPlayer:Next()
	if self._currentKey == "playlist" then
		self:_refresh(true)
	end
end

function MusicPlayer:Stop()
	self._playing = false
	self._currentKey = nil
	self._resume = nil
	self:_fadeTo(nil, 0, false)
end

function MusicPlayer:PushOverride(key: string, id: any, options: { Volume: number?, Priority: number? }?)
	self._pushCounter += 1
	self._overrides[key] = {
		Id = toSoundId(id),
		Volume = (options and options.Volume) or 0.5,
		Priority = (options and options.Priority) or 0,
		Order = self._pushCounter,
	}
	if self._currentKey == key then
		self._currentKey = nil -- same key, new track: force a crossfade
	end
	self:_refresh(false)
end

function MusicPlayer:PopOverride(key: string)
	if self._overrides[key] == nil then
		return
	end
	self._overrides[key] = nil
	self:_refresh(false)
end

function MusicPlayer:SetVolume(volume: number)
	self.MasterVolume = math.clamp(volume, 0, 1)
	if self._current then
		TweenService:Create(self._current, TweenInfo.new(0.25), {
			Volume = self._currentBaseVolume * self.MasterVolume,
		}):Play()
	end
end

function MusicPlayer:GetCurrent(): Sound?
	return self._current
end

function MusicPlayer:Destroy()
	self:Stop()
	table.clear(self._overrides)
end

return MusicPlayer
