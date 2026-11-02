--credit to leon games studio
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SoundService = game:GetService("SoundService")
local TweenService = game:GetService("TweenService")
local WeatherValues = ReplicatedStorage:WaitForChild("WeatherValues")
local SharedModules = ReplicatedStorage:WaitForChild("SharedModules")
local WeatherData = require(SharedModules:WaitForChild("WeatherData"))
local MusicTracks = SoundService:WaitForChild("MusicTracks")
local Day = MusicTracks:WaitForChild("Day")

local function dbg(...) --[[ dbg | Line: 18 ]] end

local t = {}
local t2 = {
	StartOrder = 2
}

for v1, v2 in WeatherData.Data do
	t[v2.Name] = if v2.AlwaysOn == true then true else false
end

local v5 = Random.new()
local v6 = setmetatable({}, {
	__mode = "k"
})
local v7 = Day
local v8 = nil
local t3 = {}
local v9 = 0
local v10 = nil
local v11 = nil
local v12 = 0
local v13 = nil
local v14 = nil
local v15 = nil
local v16 = nil
local v17 = nil
local v18 = false

local function getPlayableSounds(p1) --[[ getPlayableSounds | Line: 51 | Upvalues: v6 (copy) ]]
	local t = {}

	for v1, v2 in p1:GetChildren() do
		if v2:IsA("Sound") and v2.SoundId ~= "" then
			table.insert(t, v2)

			if v6[v2] == nil then
				v6[v2] = v2.Volume
			end
		end
	end

	return t
end

local function shuffleInPlace(p1) --[[ shuffleInPlace | Line: 64 | Upvalues: v5 (copy) ]]
	for i = #p1, 2, -1 do
		local v1 = v5:NextInteger(1, i)
		local v3 = p1[i]

		p1[i] = p1[v1]
		p1[v1] = v3
	end
end

local function rebuildPlaylist(p1, p2) --[[ rebuildPlaylist | Line: 71 | Upvalues: t3 (ref), getPlayableSounds (copy), v9 (ref), shuffleInPlace (copy), dbg (copy) ]]
	t3 = getPlayableSounds(p1)
	v9 = 0
	shuffleInPlace(t3)
	dbg("rebuildPlaylist for folder:", p1.Name, "| track count:", #t3)

	for v1, v2 in t3 do
		dbg("  playlist[" .. v1 .. "]:", v2.Name)
	end

	if not p2 or (not (#t3 > 1) or t3[1] ~= p2) then
		return
	end

	local v6 = t3[1]

	t3[1] = t3[2]
	t3[2] = v6
	dbg("  swapped first track to avoid repeat:", p2.Name)
end

local function nextTrackFromFolder(p1) --[[ nextTrackFromFolder | Line: 87 | Upvalues: dbg (copy), v7 (ref), v9 (ref), t3 (ref), rebuildPlaylist (copy), v10 (ref) ]]
	dbg("nextTrackFromFolder:", p1.Name, "| currentFolder:", v7.Name, "| playlistIndex:", v9, "| #playlist:", #t3)

	if p1 ~= v7 then
		dbg("  folder changed from", v7.Name, "-> rebuilding playlist")
		rebuildPlaylist(p1, v10)
	end

	if #t3 == 0 then
		dbg("  playlist empty, rebuilding")
		rebuildPlaylist(p1, v10)
	end

	if #t3 == 0 then
		dbg("  playlist STILL empty after rebuild, returning nil")

		return nil
	end

	v9 = v9 + 1

	if #t3 < v9 then
		dbg("  playlistIndex overflowed, reshuffling")
		rebuildPlaylist(p1, v10)
		v9 = 1
	end

	local v1 = t3[v9]

	v10 = v1
	dbg("  chose track:", v1.Name, "from folder:", p1.Name, "| index:", v9)

	return v1
end

local function cancelTweens() --[[ cancelTweens | Line: 118 | Upvalues: v13 (ref), dbg (copy), v14 (ref), v15 (ref), v16 (ref) ]]
	if v13 then
		dbg("cancelTweens: cancelling fadeInTween")
		v13:Cancel()
		v13 = nil
	end

	if v14 then
		dbg("cancelTweens: cancelling fadeOutTween")
		v14:Cancel()
		v14 = nil
	end

	if not v15 then
		return
	end

	dbg("cancelTweens: killing orphaned fadingOutSound:", v15.Name, "| IsPlaying:", v15.IsPlaying)
	v15:Stop()
	v15.TimePosition = 0
	v15.Volume = v16 or v15.Volume
	v15 = nil
	v16 = nil
end

local function disconnectEnded() --[[ disconnectEnded | Line: 140 | Upvalues: v11 (ref), dbg (copy) ]]
	if not v11 then
		return
	end

	dbg("disconnectEnded: disconnecting previous Ended connection")
	v11:Disconnect()
	v11 = nil
end

local function tweenVolume(p1, p2, p3) --[[ tweenVolume | Line: 148 | Upvalues: TweenService (copy) ]]
	local v1 = TweenService:Create(p1, TweenInfo.new(p3, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
		Volume = p2
	})

	v1:Play()

	return v1
end

local function stopAllExcept(p1) --[[ stopAllExcept | Line: 158 | Upvalues: MusicTracks (copy), dbg (copy), v6 (copy) ]]
	local v1 = p1 and p1.Name or "nil"

	for v2, v3 in MusicTracks:GetChildren() do
		if v3:IsA("Folder") then
			for v4, v5 in v3:GetChildren() do
				if v5:IsA("Sound") and (v5 ~= p1 and v5.IsPlaying) then
					dbg("stopAllExcept: STOPPING orphan:", v5.Name, "in folder:", v3.Name, "(keeping:", v1, ")")
					v5:Stop()
					v5.TimePosition = 0
					v5.Volume = v6[v5] or v5.Volume
				end
			end
		end
	end
end

function t2._CrossFadeTo(p1, p2) --[[ _CrossFadeTo | Line: 174 | Upvalues: v12 (ref), v8 (ref), dbg (copy), cancelTweens (copy), v11 (ref), v6 (copy), v13 (ref), tweenVolume (copy), stopAllExcept (copy), v15 (ref), v16 (ref), v14 (ref), MusicTracks (copy) ]]
	v12 = v12 + 1

	local v1 = v12

	dbg("=== _CrossFadeTo ===")
	dbg("  transitionId:", v1)
	dbg("  prev:", v8 and v8.Name or "nil", "(folder:", v8 and v8.Parent and v8.Parent.Name or "nil", ")")
	dbg("  next:", p2 and p2.Name or "nil", "(folder:", p2 and p2.Parent and p2.Parent.Name or "nil", ")")
	cancelTweens()

	if v11 then
		dbg("disconnectEnded: disconnecting previous Ended connection")
		v11:Disconnect()
		v11 = nil
	end

	local v62 = v8

	if v62 and (p2 and v62 == p2) then
		dbg("  same-sound restart:", v62.Name)

		local v7 = v6[v62] or v62.Volume

		v6[v62] = v7
		v62:Stop()
		v62.Looped = false
		v62.TimePosition = 0
		v62.Volume = 0
		v62:Play()
		v13 = tweenVolume(v62, v7, 2.25)
		v8 = v62
		stopAllExcept(v62)
		v11 = v62.Ended:Connect(function() --[[ Line: 209 | Upvalues: dbg (ref), v62 (copy), v1 (copy), v12 (ref), p1 (copy) ]]
			dbg("  Ended fired (same-sound) for:", v62.Name, "| myId:", v1, "| transitionId:", v12)

			if v12 == v1 then
				p1:_PlayNext()
			else
				dbg("  STALE transitionId, ignoring Ended")
			end
		end)
	else
		if v62 then
			dbg("  fading OUT:", v62.Name)

			local v82 = v6[v62] or v62.Volume

			v15 = v62
			v16 = v82
			v14 = tweenVolume(v62, 0, 2.25)
			v14.Completed:Connect(function(p1) --[[ Line: 229 | Upvalues: dbg (ref), v62 (copy), v1 (copy), v12 (ref), v82 (copy), v15 (ref), v16 (ref) ]]
				dbg("  fadeOut Completed for:", v62.Name, "| state:", tostring(p1), "| myId:", v1, "| transitionId:", v12)

				if v12 ~= v1 then
					dbg("  STALE transitionId on fadeOut Completed, ignoring")

					return
				end

				if p1 ~= Enum.PlaybackState.Completed then
					dbg("  fadeOut was NOT completed (cancelled?), ignoring")

					return
				end

				v62:Stop()
				v62.TimePosition = 0
				v62.Volume = v82
				dbg("  fadeOut cleanup done for:", v62.Name)

				if v15 ~= v62 then
					return
				end

				v15 = nil
				v16 = nil
			end)
		end

		if not p2 then
			dbg("  no nextSound, clearing currentSound")
			v8 = nil

			return
		end

		local v9 = v6[p2] or p2.Volume

		v6[p2] = v9
		dbg("  fading IN:", p2.Name, "| baseVol:", v9)
		p2.Looped = false
		p2.TimePosition = 0
		p2.Volume = 0
		p2:Play()
		v13 = tweenVolume(p2, v9, 2.25)
		v8 = p2

		for v10, v112 in MusicTracks:GetChildren() do
			if v112:IsA("Folder") then
				for v122, v132 in v112:GetChildren() do
					if v132:IsA("Sound") and (v132 ~= p2 and (v132 ~= v62 and v132.IsPlaying)) then
						dbg("  SAFETY SWEEP: stopping leaked sound:", v132.Name, "in folder:", v112.Name)
						v132:Stop()
						v132.TimePosition = 0
						v132.Volume = v6[v132] or v132.Volume
					end
				end
			end
		end

		v11 = p2.Ended:Connect(function() --[[ Line: 285 | Upvalues: dbg (ref), p2 (copy), v1 (copy), v12 (ref), p1 (copy) ]]
			dbg("  Ended fired for:", p2.Name, "| myId:", v1, "| transitionId:", v12)

			if v12 == v1 then
				p1:_PlayNext()
			else
				dbg("  STALE transitionId, ignoring Ended")
			end
		end)
	end
end
function t2._ResolveWeatherValuesName(p1) --[[ _ResolveWeatherValuesName | Line: 295 | Upvalues: dbg (copy), WeatherData (copy), WeatherValues (copy), t (copy) ]]
	dbg("_ResolveWeatherValuesName checking WeatherData.Data...")

	for v1, v2 in WeatherData.Data do
		if v2.AlwaysOn ~= true then
			local v3 = WeatherValues:FindFirstChild(v2.Name)

			if v3 and v3:IsA("Folder") then
				local Playing = v3:FindFirstChild("Playing")

				if Playing and Playing:IsA("BoolValue") then
					dbg("  WeatherData entry:", v2.Name, "| Playing:", Playing.Value)

					if Playing.Value then
						dbg("  >>> ACTIVE weather from WeatherData:", v2.Name)

						return v2.Name
					end
				end
			end
		end
	end

	dbg("  checking loose WeatherValues folders...")

	for v4, v5 in WeatherValues:GetChildren() do
		if v5:IsA("Folder") then
			local Playing = v5:FindFirstChild("Playing")

			if Playing and Playing:IsA("BoolValue") then
				dbg("  loose folder:", v5.Name, "| Playing:", Playing.Value, "| AlwaysOn:", t[v5.Name] or false)

				if Playing.Value and not t[v5.Name] then
					dbg("  >>> ACTIVE weather from loose folder:", v5.Name)

					return v5.Name
				end
			end
		end
	end

	dbg("  no active weather found")

	return nil
end
function t2._ResolveTargetFolder(p1) --[[ _ResolveTargetFolder | Line: 331 | Upvalues: dbg (copy), MusicTracks (copy), getPlayableSounds (copy), v17 (ref), Day (copy) ]]
	dbg("--- _ResolveTargetFolder ---")

	local v1 = p1:_ResolveWeatherValuesName()

	if v1 then
		local v2 = MusicTracks:FindFirstChild(v1)

		if v2 and v2:IsA("Folder") then
			local v3 = #getPlayableSounds(v2)

			dbg("  weatherValues folder:", v1, "| playable tracks:", v3)

			if v3 > 0 then
				dbg("  >>> using WeatherValues folder:", v1)

				return v2
			end
		else
			dbg("  WARNING: WeatherValues says", v1, "but no matching MusicTracks folder found!")
		end
	end

	if v17 then
		dbg("  timeCycleWeatherName:", v17)

		local v4 = MusicTracks:FindFirstChild(v17)

		if v4 and v4:IsA("Folder") then
			local v5 = #getPlayableSounds(v4)

			dbg("  timeCycle folder:", v17, "| playable tracks:", v5)

			if v5 > 0 then
				dbg("  >>> using TimeCycle folder:", v17)

				return v4
			end
		else
			dbg("  WARNING: timeCycle says", v17, "but no matching MusicTracks folder found!")
		end
	else
		dbg("  timeCycleWeatherName is nil")
	end

	dbg("  >>> falling back to Day folder")

	return Day
end
function t2._SetFolder(p1, p2) --[[ _SetFolder | Line: 373 | Upvalues: dbg (copy), v7 (ref), v8 (ref), rebuildPlaylist (copy), v10 (ref), nextTrackFromFolder (copy) ]]
	dbg("_SetFolder:", p2.Name, "| currentFolder:", v7.Name, "| currentSound:", v8 and v8.Name or "nil")

	if p2 == v7 and v8 then
		dbg("  same folder & has currentSound, skipping")

		return
	end

	if p2 ~= v7 then
		dbg("  folder CHANGED:", v7.Name, "->", p2.Name)
		v7 = p2
		rebuildPlaylist(p2, v10)
	end

	p1:_CrossFadeTo((nextTrackFromFolder(p2)))
end
function t2._PlayNext(p1) --[[ _PlayNext | Line: 391 | Upvalues: dbg (copy), v7 (ref), nextTrackFromFolder (copy) ]]
	dbg("=== _PlayNext ===")

	local v1 = p1:_ResolveTargetFolder()

	dbg("  resolved folder:", v1.Name, "| currentFolder:", v7.Name)

	if v1 == v7 then
		p1:_CrossFadeTo((nextTrackFromFolder(v7)))
	else
		dbg("  folder changed during _PlayNext, calling _SetFolder")
		p1:_SetFolder(v1)
	end
end
function t2._Refresh(p1) --[[ _Refresh | Line: 406 | Upvalues: dbg (copy), MusicTracks (copy) ]]
	dbg("=== _Refresh ===")

	for v1, v2 in MusicTracks:GetChildren() do
		if v2:IsA("Folder") then
			for v3, v4 in v2:GetChildren() do
				if v4:IsA("Sound") and v4.IsPlaying then
					dbg("  CURRENTLY PLAYING:", v4.Name, "in", v2.Name, "| vol:", string.format("%.3f", v4.Volume))
				end
			end
		end
	end

	p1:_SetFolder((p1:_ResolveTargetFolder()))
end
function t2._QueueRefresh(p1) --[[ _QueueRefresh | Line: 423 | Upvalues: dbg (copy), v18 (ref) ]]
	dbg("_QueueRefresh called | already queued:", v18)

	if not v18 then
		v18 = true
		task.defer(function() --[[ Line: 430 | Upvalues: dbg (ref), v18 (ref), p1 (copy) ]]
			dbg("_QueueRefresh deferred fire")
			v18 = false
			p1:_Refresh()
		end)
	end
end
function t2._HookWeatherFolder(p1, p2) --[[ _HookWeatherFolder | Line: 437 | Upvalues: dbg (copy) ]]
	local Playing = p2:FindFirstChild("Playing")

	if Playing and Playing:IsA("BoolValue") then
		dbg("Hooking weather folder:", p2.Name)
		Playing.Changed:Connect(function() --[[ Line: 444 | Upvalues: dbg (ref), p2 (copy), Playing (copy), p1 (copy) ]]
			dbg("Playing.Changed on weather folder:", p2.Name, "| new value:", Playing.Value)
			p1:_QueueRefresh()
		end)
	end
end
function t2.SetActiveWeather(p1, p2) --[[ SetActiveWeather | Line: 450 | Upvalues: dbg (copy), v17 (ref) ]]
	dbg("=== SetActiveWeather:", tostring(p2), "| previous timeCycle:", tostring(v17), "===")
	v17 = p2
	p1:_QueueRefresh()
end
function t2.Init(p1) --[[ Init | Line: 456 ]] end
function t2.Start(p1) --[[ Start | Line: 458 | Upvalues: dbg (copy), WeatherValues (copy), MusicTracks (copy) ]]
	dbg("=== MusicController:Start ===")

	for v1, v2 in WeatherValues:GetChildren() do
		if v2:IsA("Folder") then
			p1:_HookWeatherFolder(v2)
		end
	end

	WeatherValues.ChildAdded:Connect(function(p12) --[[ Line: 467 | Upvalues: dbg (ref), p1 (copy) ]]
		if not p12:IsA("Folder") then
			return
		end

		dbg("WeatherValues.ChildAdded:", p12.Name)
		p1:_HookWeatherFolder(p12)
		p1:_QueueRefresh()
	end)
	MusicTracks.ChildAdded:Connect(function(p12) --[[ Line: 475 | Upvalues: dbg (ref), p1 (copy) ]]
		dbg("MusicTracks.ChildAdded:", p12.Name)
		p1:_QueueRefresh()
	end)
	MusicTracks.ChildRemoved:Connect(function(p12) --[[ Line: 479 | Upvalues: dbg (ref), p1 (copy) ]]
		dbg("MusicTracks.ChildRemoved:", p12.Name)
		p1:_QueueRefresh()
	end)
end

return t2