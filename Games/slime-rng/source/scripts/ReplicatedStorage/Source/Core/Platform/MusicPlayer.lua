-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: MusicPlayer, time of decompilation: Sun May  3 10:10:55 2026 ]]
local SoundService = game:GetService("SoundService")

local function shuffleOrder(n1: number, p1) -- line: 17
	local t1 = table.create(n1)

	for i = 1, n1 do
		t1[i] = i
	end

	for i = n1, 2, -1 do
		local v9 = p1:NextInteger(1, i)
		local v10 = t1[v9]
		local v11 = t1[i]

		t1[i] = v10
		t1[v9] = v11
	end

	return t1
end

local t2 = {}

t2.__index = t2

function t2._prepareCurrentSong(p2) -- line: 99
	local v29 = p2.order[p2.orderPosition]

	if v29 == nil then
		return
	end

	p2.currentSongIndex = v29

	local v30 = p2.songs[v29]
	local sound = p2.sound

	sound.PlaybackRegionsEnabled = v30.PlaybackRegion ~= nil or v30.LoopRegion ~= nil
	sound.Looped = false

	for v32, v33 in v30 do
		sound[v32] = v33
	end

	p2.sound.TimePosition = not v30.PlaybackRegion and 0 or v30.PlaybackRegion.Min
end
function t2._reshuffle(p3, b1: boolean) -- line: 111
	-- upvalues: shuffleOrder (copy)
	local songs = p3.songs
	local random = p3.random
	local v38 = shuffleOrder(#songs, random)

	if b1 and (p3.currentSongIndex ~= nil and #v38 > 1 and v38[1] == p3.currentSongIndex) then
		local v39 = v38[2]
		local v40 = v38[1]

		v38[1] = v39
		v38[2] = v40
	end

	p3.order = v38
	p3.orderPosition = not (#v38 > 0) and 0 or 1
end
function t2._setOrderPosition(p4, n2: number) -- line: 121
	if #p4.songs == 0 then
		return
	end

	if n2 > #p4.order then
		p4:_reshuffle(true)
	else
		p4.orderPosition = n2
	end

	p4:_prepareCurrentSong()

	if p4.enabled then
		p4.sound:Play()
	end
end
function t2.new(t3: {[any]: any}, t4: {[any]: any}?) -- line: 139
	-- upvalues: SoundService (copy), shuffleOrder (copy), t2 (copy)
	local v45 = table.clone(t3)
	local random = Random.new()
	local v47 = if not t4 then nil else t4.StartingSong
	local g48 = nil

	if type(v47) == "number" then
		if v45[v47] ~= nil then
			g48 = true
		end
	elseif type(v47) == "string" then
		for v49, v50 in v45 do
			if v47 == v50.SoundId then
				v47 = v49
				g48 = true
			end

			if g48 then
				break
			end
		end
	end

	if not g48 then
		if not g48 then
			v47 = if not (#v45 > 0) then nil else 1
		end
	end

	g48 = false

	local Sound = Instance.new("Sound")

	Sound.Name = (not t4 or not t4.Name) and "MusicPlayer" or t4.Name
	Sound.Parent = if not t4 or not t4.Parent then SoundService else t4.Parent

	local t5 = {
		currentSongIndex = nil,
		enabled = false,
		endedConnection = nil,
		songs = v45
	}
	local v53 = shuffleOrder(#v45, random)

	if v47 == nil or #v53 <= 1 then
	else
		local v54 = table.find(v53, v47)

		if v54 ~= nil then
			local v55 = v53[v54]
			local v56 = v53[1]

			v53[1] = v55
			v53[v54] = v56
		end
	end

	t5.order = v53
	t5.orderPosition = not (#v45 > 0) and 0 or 1
	t5.random = random
	t5.sound = Sound

	local v57 = setmetatable(t5, t2)

	if v57.orderPosition > 0 then
		v57:_prepareCurrentSong()
	end

	v57.endedConnection = Sound.Ended:Connect(function() -- line: 162
		-- upvalues: v57 (copy)
		if not v57.enabled then
			return
		end

		v57:skip()
	end)

	return v57
end
function t2.setEnabled(p5, b2: boolean) -- line: 173
	if b2 then
		p5:resume()

		return
	end

	p5:pause()
end
function t2.resume(p6) -- line: 181
	p6.enabled = true

	if #p6.songs == 0 then
		return
	end

	if p6.sound.SoundId == "" then
		p6:_prepareCurrentSong()
	end

	if not p6.sound.IsPlaying then
		p6.sound:Play()
	end
end
function t2.pause(p7) -- line: 196
	p7.enabled = false

	if p7.sound.IsPlaying then
		p7.sound:Pause()
	end
end
function t2.skip(p8) -- line: 203
	if #p8.songs == 0 then
		return
	end

	if #p8.songs == 1 then
		p8.orderPosition = 1
		p8:_prepareCurrentSong()

		if p8.enabled then
			p8.sound:Play()
		end

		return
	end

	p8:_setOrderPosition(p8.orderPosition + 1)
end
function t2.back(p9) -- line: 220
	if #p9.songs == 0 or p9.orderPosition <= 0 then
		return
	end

	local v64 = p9.order[p9.orderPosition]

	if v64 == nil then
		return
	end

	local v65 = p9.songs[v64]
	local v66 = not v65.PlaybackRegion and 0 or v65.PlaybackRegion.Min

	if p9.orderPosition <= 1 or p9.sound.TimePosition - v66 > 3 then
		p9.sound.TimePosition = v66

		if p9.enabled and not p9.sound.IsPlaying then
			p9.sound:Play()
		end

		return
	end

	p9.orderPosition = p9.orderPosition - 1
	p9:_prepareCurrentSong()

	if p9.enabled then
		p9.sound:Play()
	end
end
function t2.destroy(p10) -- line: 247
	if p10.endedConnection then
		p10.endedConnection:Disconnect()
		p10.endedConnection = nil
	end

	p10.sound:Destroy()
end

return t2
