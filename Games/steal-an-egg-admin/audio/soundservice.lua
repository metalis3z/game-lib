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
	I[1] = new("Sound", nil, "Cash Register", { RollOffMode = Enum.RollOffMode.InverseTapered }, { ["_lemonadeUniqueId"] = "e3D9BKTPe3D9" })
	I[2] = new("Sound", nil, "CashCollect", { RollOffMode = Enum.RollOffMode.InverseTapered, Volume = 0.7 }, { ["_lemonadeUniqueId"] = "Pymic0BpPymi" })
	I[3] = new("Sound", nil, "Click", nil, { ["_lemonadeUniqueId"] = "eEJ3QORneEJ3" })
	I[4] = new("Sound", nil, "Collect", nil, { ["_lemonadeUniqueId"] = "7d1iiiNh7d1i" })
	I[5] = new("Sound", nil, "Hover", { PlaybackSpeed = 0.96, Volume = 5 }, { ["_lemonadeUniqueId"] = "E9VPpaJ3E9VP" })
	I[6] = new("Sound", nil, "Intro", { Looped = true, RollOffMode = Enum.RollOffMode.InverseTapered, TimePosition = 110.524, Volume = 0.38 }, { ["_lemonadeUniqueId"] = "tsB1Zgq8tsB1" })
		I[7] = new("EqualizerSoundEffect", I[6], "EQ", { Enabled = false, LowGain = -2, MidGain = 0 }, { ["_lemonadeUniqueId"] = "VeFONrjTVeFO" })
	I[8] = new("Sound", nil, "NPC_Text", nil, { ["_lemonadeUniqueId"] = "p87dx9QUp87d" })
	I[9] = new("Sound", nil, "Response_Text", nil, { ["_lemonadeUniqueId"] = "aPf5ekjXaPf5" })
	I[10] = new("Sound", nil, "SleepSound", { RollOffMaxDistance = 350, RollOffMode = Enum.RollOffMode.InverseTapered, Volume = 1 }, { ["_lemonadeUniqueId"] = "SKeHur1hSKeH" }, { "SleepSound" })
	I[11] = new("Sound", nil, "Song", { RollOffMode = Enum.RollOffMode.InverseTapered, Volume = 0.18 }, { ["_lemonadeUniqueId"] = "jr1siIO0jr1s" })
		I[12] = new("EqualizerSoundEffect", I[11], "EQ", { LowGain = 0, MidGain = 0 }, { ["_lemonadeUniqueId"] = "Y5fTcRh9Y5fT" })
	I[13] = new("Sound", nil, "SparkleSound", { RollOffMode = Enum.RollOffMode.InverseTapered, TimePosition = 0.3, Volume = 0.1 }, { ["_lemonadeUniqueId"] = "tUqPGktltUqP" })
	I[14] = new("Sound", nil, "StealChase", { Looped = true, RollOffMaxDistance = 100, RollOffMode = Enum.RollOffMode.InverseTapered, Volume = 0 }, { ["_lemonadeUniqueId"] = "DdkWYnN3DdkW" })
	I[15] = new("Sound", nil, "Notification", nil, { ["_lemonadeUniqueId"] = "tGhaF7xptGha" })
	I[16] = new("Sound", nil, "NotificationLow", nil, { ["_lemonadeUniqueId"] = "CH7gByNPCH7g" })
	I[17] = new("AudioDeviceOutput", nil, "AudioDeviceOutput", nil, { ["_lemonadeUniqueId"] = "H8mBiC6UH8mB" })
	I[18] = new("AudioDeviceOutput", nil, "AudioDeviceOutput", nil, { ["_lemonadeUniqueId"] = "2Fj3gK132Fj3" })
	I[19] = new("AudioDeviceOutput", nil, "AudioDeviceOutput", nil, { ["_lemonadeUniqueId"] = "YOeoaNKAYOeo" })
	I[20] = new("Folder", nil, "GameMusics", nil, { ["_lemonadeUniqueId"] = "Vqi8vfcSVqi8" })
		I[21] = new("Sound", I[20], "Music2", { TimePosition = 75.449, Volume = 0 }, { ["_lemonadeUniqueId"] = "jQJACADRjQJA" })
		I[22] = new("Sound", I[20], "Music1", { Volume = 0.2 }, { ["_lemonadeUniqueId"] = "4pqN9sV74pqN" })
		I[23] = new("Sound", I[20], "InStages", { Looped = true, Volume = 0.292 }, { ["_lemonadeUniqueId"] = "y7bJcSvNy7bJ" })
	I[24] = new("Folder", nil, "KeycapSounds", nil, { ["_lemonadeUniqueId"] = "ZCrsWV5vZCrs" })
	I[25] = new("Folder", nil, "NPC_SFX", nil, { ["_lemonadeUniqueId"] = "RLeLycHTRLeL" })
		I[26] = new("Sound", I[25], "Chippy", nil, { ["_lemonadeUniqueId"] = "O99Atun5O99A" })
		I[27] = new("Sound", I[25], "Raphael", nil, { ["_lemonadeUniqueId"] = "uhuaZyQSuhua" })
		I[28] = new("Sound", I[25], "Eloise", nil, { ["_lemonadeUniqueId"] = "nOdeHbUgnOde" })
		I[29] = new("Sound", I[25], "Rolf", nil, { ["_lemonadeUniqueId"] = "JB9VMoK2JB9V" })
		I[30] = new("Sound", I[25], "Steven", nil, { ["_lemonadeUniqueId"] = "VDHlCrieVDHl" })
		I[31] = new("Sound", I[25], "Sam", nil, { ["_lemonadeUniqueId"] = "HNuvIa0mHNuv" })
	I[32] = new("Folder", nil, "Packs", nil, { ["_lemonadeUniqueId"] = "wTZChbT5wTZC" })
		I[33] = new("Sound", I[32], "Sound", { RollOffMode = Enum.RollOffMode.InverseTapered }, { ["_lemonadeUniqueId"] = "OkrCygY0OkrC" })
		I[34] = new("Sound", I[32], "Open", { Volume = 2 }, { ["_lemonadeUniqueId"] = "TRQcfHVZTRQc" })
		I[35] = new("Sound", I[32], "RainbowReward", nil, { ["_lemonadeUniqueId"] = "39Gk6CfB39Gk" })
		I[36] = new("Sound", I[32], "NormalTick", { Volume = 4 }, { ["_lemonadeUniqueId"] = "HUGmnfy6HUGm" })
		I[37] = new("Sound", I[32], "Reward", nil, { ["_lemonadeUniqueId"] = "eAP4JT9feAP4" })
		I[38] = new("Sound", I[32], "RainbowTick", { Volume = 4 }, { ["_lemonadeUniqueId"] = "pU3YTAZJpU3Y" })
	I[39] = new("SoundGroup", nil, "Default", { Volume = 1 }, { ["_lemonadeUniqueId"] = "y0OXxTCMy0OX" })
	I[40] = new("SoundGroup", nil, "DefaultReverb", { Volume = 1 }, { ["_lemonadeUniqueId"] = "MTiILuRPMTiI" })
	I[41] = new("SoundGroup", nil, "Music", { Volume = 1 }, { ["_lemonadeUniqueId"] = "uM5P01oyuM5P" })
		I[42] = new("SoundGroup", I[41], "AdminAbuseMusic", { Volume = 1 }, { ["_lemonadeUniqueId"] = "364lkGVd364l" })
		I[43] = new("SoundGroup", I[41], "GameMusic", { Volume = 1 }, { ["_lemonadeUniqueId"] = "nzA2JVcUnzA2" })
	I[44] = new("SoundGroup", nil, "SFX", { Volume = 1 }, { ["_lemonadeUniqueId"] = "xIljxWoexIlj" })
	I[45] = new("SoundGroup", nil, "WorkspaceSounds", { Volume = 1 }, { ["_lemonadeUniqueId"] = "Y6LKs6tzY6LK" })
	return { I[1], I[2], I[3], I[4], I[5], I[6], I[8], I[9], I[10], I[11], I[13], I[14], I[15], I[16], I[17], I[18], I[19], I[20], I[24], I[25], I[32], I[39], I[40], I[41], I[44], I[45] }
end

return build
