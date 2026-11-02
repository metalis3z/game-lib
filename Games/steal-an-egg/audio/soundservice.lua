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
	I[1] = new("Sound", nil, "Cash Register", { RollOffMode = Enum.RollOffMode.InverseTapered })
	I[2] = new("Sound", nil, "CashCollect", { RollOffMode = Enum.RollOffMode.InverseTapered, Volume = 0.7 })
	I[3] = new("Sound", nil, "Click")
	I[4] = new("Sound", nil, "Collect")
	I[5] = new("Sound", nil, "Hover", { PlaybackSpeed = 0.96, Volume = 5 })
	I[6] = new("Sound", nil, "Intro", { Looped = true, RollOffMode = Enum.RollOffMode.InverseTapered, TimePosition = 110.524, Volume = 0.38 })
		I[7] = new("EqualizerSoundEffect", I[6], "EQ", { Enabled = false, LowGain = -2, MidGain = 0 })
	I[8] = new("Sound", nil, "NPC_Text")
	I[9] = new("Sound", nil, "Response_Text")
	I[10] = new("Sound", nil, "SleepSound", { RollOffMaxDistance = 350, RollOffMode = Enum.RollOffMode.InverseTapered, Volume = 1 })
	I[11] = new("Sound", nil, "Song", { RollOffMode = Enum.RollOffMode.InverseTapered, Volume = 0.18 })
		I[12] = new("EqualizerSoundEffect", I[11], "EQ", { LowGain = 0, MidGain = 0 })
	I[13] = new("Sound", nil, "SparkleSound", { RollOffMode = Enum.RollOffMode.InverseTapered, TimePosition = 0.3, Volume = 0.1 })
	I[14] = new("Sound", nil, "StealChase", { Looped = true, RollOffMaxDistance = 100, RollOffMode = Enum.RollOffMode.InverseTapered, Volume = 0 })
	I[15] = new("AudioDeviceOutput", nil, "AudioDeviceOutput")
	I[16] = new("AudioDeviceOutput", nil, "AudioDeviceOutput")
	I[17] = new("Folder", nil, "GameMusics")
		I[18] = new("Sound", I[17], "Music2", { TimePosition = 75.449, Volume = 0 })
		I[19] = new("Sound", I[17], "Music1", { Volume = 0.2 })
		I[20] = new("Sound", I[17], "InStages", { Looped = true, Volume = 0.292 })
	I[21] = new("Folder", nil, "KeycapSounds")
	I[22] = new("Folder", nil, "NPC_SFX")
		I[23] = new("Sound", I[22], "Chippy")
		I[24] = new("Sound", I[22], "Raphael")
		I[25] = new("Sound", I[22], "Eloise")
		I[26] = new("Sound", I[22], "Rolf")
		I[27] = new("Sound", I[22], "Steven")
		I[28] = new("Sound", I[22], "Sam")
	I[29] = new("Folder", nil, "Packs")
		I[30] = new("Sound", I[29], "Sound", { RollOffMode = Enum.RollOffMode.InverseTapered })
		I[31] = new("Sound", I[29], "Open", { Volume = 2 })
		I[32] = new("Sound", I[29], "RainbowReward")
		I[33] = new("Sound", I[29], "NormalTick", { Volume = 4 })
		I[34] = new("Sound", I[29], "Reward")
		I[35] = new("Sound", I[29], "RainbowTick", { Volume = 4 })
	I[36] = new("SoundGroup", nil, "Default", { Volume = 1 })
	I[37] = new("SoundGroup", nil, "DefaultReverb", { Volume = 1 })
	I[38] = new("SoundGroup", nil, "Music", { Volume = 1 })
	I[39] = new("SoundGroup", nil, "SFX", { Volume = 1 })
	I[40] = new("SoundGroup", nil, "WorkspaceSounds", { Volume = 1 })
	return { I[1], I[2], I[3], I[4], I[5], I[6], I[8], I[9], I[10], I[11], I[13], I[14], I[15], I[16], I[17], I[21], I[22], I[29], I[36], I[37], I[38], I[39], I[40] }
end

return build
