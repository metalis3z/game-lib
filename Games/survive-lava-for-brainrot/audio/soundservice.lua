-- Generated from audio/soundservice.rbxm by _tools/rbxm2lua.luau
-- Audio pack: require(this)() returns the Sound / SoundGroup instances; parent them where you need them

local function new(class, parent, name, props, attrs, tags)
	local o = Instance.new(class)
	o.Name = name
	if props then
		for k, v in props do
			o[k] = v
		end
	end
	if attrs then
		for k, v in attrs do
			o:SetAttribute(k, v)
		end
	end
	if tags then
		for _, t in tags do
			o:AddTag(t)
		end
	end
	if parent then
		o.Parent = parent
	end
	return o
end

local function build()
	local I = {}
	I[1] = new("AudioDeviceOutput", nil, "AudioDeviceOutput")
	I[2] = new("Folder", nil, "SFX")
		I[3] = new("Sound", I[2], "Frame", { PlaybackSpeed = 1.125, RollOffMaxDistance = 100, RollOffMode = Enum.RollOffMode.Linear })
		I[4] = new("Sound", I[2], "OldCollect", { RollOffMaxDistance = 100, RollOffMode = Enum.RollOffMode.Linear })
		I[5] = new("Sound", I[2], "Error", { RollOffMaxDistance = 100, RollOffMode = Enum.RollOffMode.Linear })
		I[6] = new("Sound", I[2], "Button", { PlaybackSpeed = 1.2, RollOffMaxDistance = 100, RollOffMode = Enum.RollOffMode.Linear })
			I[7] = new("PitchShiftSoundEffect", I[6], "PitchShiftSoundEffect", { Octave = 1.1 })
		I[8] = new("Sound", I[2], "Purchase", { RollOffMaxDistance = 100, RollOffMode = Enum.RollOffMode.Linear })
		I[9] = new("Sound", I[2], "Collect", { RollOffMaxDistance = 100, RollOffMode = Enum.RollOffMode.Linear })
		I[10] = new("Sound", I[2], "FuseInsert", { RollOffMaxDistance = 100, RollOffMode = Enum.RollOffMode.Linear })
		I[11] = new("Sound", I[2], "FuseStart", { RollOffMaxDistance = 100, RollOffMode = Enum.RollOffMode.Linear })
		I[12] = new("Sound", I[2], "FuseRetrieveMutated", { RollOffMaxDistance = 100, RollOffMode = Enum.RollOffMode.Linear })
		I[13] = new("Sound", I[2], "FuseOff", { RollOffMaxDistance = 100, RollOffMode = Enum.RollOffMode.Linear })
		I[14] = new("Sound", I[2], "FuseStartUI", { RollOffMaxDistance = 100, RollOffMode = Enum.RollOffMode.Linear })
		I[15] = new("Sound", I[2], "FuseOnLoop", { Looped = true, RollOffMaxDistance = 100, RollOffMode = Enum.RollOffMode.Linear })
		I[16] = new("Sound", I[2], "FuseFinished", { RollOffMaxDistance = 100, RollOffMode = Enum.RollOffMode.Linear })
		I[17] = new("Sound", I[2], "FuseIdleLoop", { Looped = true, RollOffMaxDistance = 100, RollOffMode = Enum.RollOffMode.Linear })
		I[18] = new("Sound", I[2], "FuseRetrieve", { RollOffMaxDistance = 100, RollOffMode = Enum.RollOffMode.Linear })
		I[19] = new("Sound", I[2], "FuseGodly", { RollOffMaxDistance = 100, RollOffMode = Enum.RollOffMode.Linear, Volume = 1 })
	I[20] = new("Folder", nil, "Musics")
		I[21] = new("Sound", I[20], "Lobby", { Looped = true, Playing = true, TimePosition = 181.161 })
		I[22] = new("Sound", I[20], "Running", { Looped = true })
	I[23] = new("Folder", nil, "Game")
		I[24] = new("Sound", I[23], "Lava", { Looped = true, Playing = true, TimePosition = 32.306, Volume = 0 }, { ["Volume"] = 0 })
		I[25] = new("Sound", I[23], "Overflow")
		I[26] = new("Sound", I[23], "Celestial")
		I[27] = new("Sound", I[23], "Godly", { Volume = 1 })
		I[28] = new("Folder", I[23], "Deaths")
			I[29] = new("Sound", I[28], "Death3", { Volume = 1 })
			I[30] = new("Sound", I[28], "Death2", { Volume = 1 })
			I[31] = new("Sound", I[28], "Death1", { Volume = 1 })
	I[32] = new("Folder", nil, "Events")
		I[33] = new("Sound", I[32], "LowGravity", { Looped = true })
		I[34] = new("Sound", I[32], "Disco", { Looped = true })
		I[35] = new("Sound", I[32], "Valentines", { Looped = true })
	return { I[1], I[2], I[20], I[23], I[32] }
end

return build
