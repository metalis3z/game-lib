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
	I[1] = new("Folder", nil, "UI")
		I[2] = new("Folder", I[1], "Hover")
			I[3] = new("Sound", I[2], "Hover", { RollOffMode = Enum.RollOffMode.InverseTapered })
		I[4] = new("Folder", I[1], "Clicks")
			I[5] = new("Sound", I[4], "Click", { RollOffMode = Enum.RollOffMode.InverseTapered })
	I[6] = new("Folder", nil, "RoomAudioSounds")
		I[7] = new("Sound", I[6], "AmbientNoise", { Looped = true, Playing = true, TimePosition = 7.649, Volume = 0.35 })
		I[8] = new("Sound", I[6], "BigCreak", { PlaybackSpeed = 0.7, Volume = 0.15 })
		I[9] = new("Sound", I[6], "Scare", { PlaybackSpeed = 0.3, Volume = 0.08 })
		I[10] = new("Sound", I[6], "ScarySound", { PlaybackSpeed = 0.95, Volume = 0.15 })
		I[11] = new("Sound", I[6], "ScarySound2", { PlaybackSpeed = 0.3, Volume = 0.1 })
		I[12] = new("Sound", I[6], "Creak2", { PlaybackSpeed = 0.21, Volume = 0.25 })
		I[13] = new("Sound", I[6], "ScarySound3", { PlaybackSpeed = 0.5, Volume = 0.15 })
		I[14] = new("Sound", I[6], "ScarySound4", { PlaybackSpeed = 0.5, Volume = 0.25 })
	I[15] = new("SoundGroup", nil, "Master", { Volume = 1 })
		I[16] = new("AudioLimiter", I[15], "AudioLimiter", { MaxLevel = -1.5 })
		I[17] = new("SoundGroup", I[15], "MonsterCombat", { Volume = 0.9 })
		I[18] = new("SoundGroup", I[15], "MonsterState", { Volume = 0.85 })
			I[19] = new("CompressorSoundEffect", I[18], "CompressorSoundEffect", { Attack = 0.01, Ratio = 2, Release = 0.15, Threshold = -12 })
		I[20] = new("SoundGroup", I[15], "MonsterAmbient", { Volume = 0.75 })
			I[21] = new("CompressorSoundEffect", I[20], "CompressorSoundEffect", { Attack = 0.02, Ratio = 2.5, Release = 0.25, Threshold = -14 })
		I[22] = new("SoundGroup", I[15], "MonsterMusic", { Volume = 0.75 })
		I[23] = new("SoundGroup", I[15], "Monster", { Volume = 0.85 })
		I[24] = new("SoundGroup", I[15], "Footsteps", { Volume = 0.8 })
			I[25] = new("CompressorSoundEffect", I[24], "CompressorSoundEffect", { Attack = 0.01, Ratio = 2.5, Release = 0.15, Threshold = -14 })
		I[26] = new("SoundGroup", I[15], "SFX", { Volume = 0.8 })
			I[27] = new("CompressorSoundEffect", I[26], "CompressorSoundEffect", { Attack = 0.02, Ratio = 2.5, Release = 0.25, Threshold = -15 })
		I[28] = new("SoundGroup", I[15], "Ambience", { Volume = 0.6 })
			I[29] = new("CompressorSoundEffect", I[28], "CompressorSoundEffect", { Attack = 0.03, Ratio = 2, Release = 0.4, Threshold = -16 })
		I[30] = new("SoundGroup", I[15], "Music")
			I[31] = new("CompressorSoundEffect", I[30], "CompressorSoundEffect", { Attack = 0.04, Ratio = 2.5, Release = 0.6, Threshold = -18 })
		I[32] = new("SoundGroup", I[15], "UI", { Volume = 0.65 })
		I[33] = new("SoundGroup", I[15], "ItemUsage", { Volume = 0.75 })
			I[34] = new("CompressorSoundEffect", I[33], "CompressorSoundEffect", { Attack = 0.02, Ratio = 2, Release = 0.25, Threshold = -15 })
		I[35] = new("SoundGroup", I[15], "Environmental", { Volume = 0.7 })
			I[36] = new("CompressorSoundEffect", I[35], "CompressorSoundEffect", { Attack = 0.025, Ratio = 2, Release = 0.35, Threshold = -16 })
		I[37] = new("SoundGroup", I[15], "LevelEvents", { Volume = 0.85 })
			I[38] = new("CompressorSoundEffect", I[37], "CompressorSoundEffect", { Attack = 0.02, Ratio = 2, Release = 0.3, Threshold = -14 })
		I[39] = new("SoundGroup", I[15], "Elevator", { Volume = 0.75 })
			I[40] = new("CompressorSoundEffect", I[39], "CompressorSoundEffect", { Attack = 0.02, Ratio = 2, Release = 0.3, Threshold = -15 })
		I[41] = new("SoundGroup", I[15], "Machines", { Volume = 0.8 })
			I[42] = new("CompressorSoundEffect", I[41], "CompressorSoundEffect", { Attack = 0.02, Ratio = 2, Release = 0.25, Threshold = -14 })
	I[43] = new("Sound", nil, "Sound", { PlaybackSpeed = 1.2, Volume = 0.3 })
	I[44] = new("Sound", nil, "Sound", { PlaybackSpeed = 1.5, Volume = 0.4 })
	I[45] = new("Sound", nil, "Sound", { PlaybackSpeed = 2, Volume = 0.6 })
	I[46] = new("Sound", nil, "Sound", { PlaybackSpeed = 0.8 })
	I[47] = new("Sound", nil, "Sound", { PlaybackSpeed = 1.5, Volume = 0.2 })
	I[48] = new("Sound", nil, "Sound", { PlaybackSpeed = 1.5, Volume = 0.4 })
	I[49] = new("Sound", nil, "Sound", { PlaybackSpeed = 1.5, Volume = 0.4 })
	I[50] = new("Sound", nil, "Sound", { PlaybackSpeed = 1.5, Volume = 0.4 })
	I[51] = new("Sound", nil, "Sound", { PlaybackSpeed = 1.5, Volume = 0.4 })
	I[52] = new("Sound", nil, "Sound", { PlaybackSpeed = 1.5, Volume = 0.4 })
	I[53] = new("Sound", nil, "Sound", { PlaybackSpeed = 1.2, Volume = 0.3 })
	I[54] = new("Sound", nil, "Sound", { PlaybackSpeed = 1.2, Volume = 0.3 })
	I[55] = new("Sound", nil, "Sound", { PlaybackSpeed = 1.2, Volume = 0.3 })
	I[56] = new("Sound", nil, "Sound", { PlaybackSpeed = 1.2, Volume = 0.3 })
	I[57] = new("Sound", nil, "Sound", { PlaybackSpeed = 1.2, Volume = 0.3 })
	I[58] = new("Sound", nil, "Sound", { PlaybackSpeed = 2, Volume = 0.6 })
	I[59] = new("Sound", nil, "Sound", { PlaybackSpeed = 2, Volume = 0.6 })
	I[60] = new("Sound", nil, "Sound", { PlaybackSpeed = 2, Volume = 0.6 })
	I[61] = new("Sound", nil, "Sound", { PlaybackSpeed = 2, Volume = 0.6 })
	I[62] = new("Sound", nil, "Sound", { PlaybackSpeed = 2, Volume = 0.6 })
	I[63] = new("Sound", nil, "Sound", { PlaybackSpeed = 1.5, Volume = 0.2 })
	I[64] = new("Sound", nil, "Sound", { PlaybackSpeed = 1.5, Volume = 0.2 })
	I[65] = new("Sound", nil, "Sound", { PlaybackSpeed = 1.5, Volume = 0.2 })
	I[66] = new("Sound", nil, "Sound", { PlaybackSpeed = 1.5, Volume = 0.2 })
	I[67] = new("Sound", nil, "Sound", { PlaybackSpeed = 1.5, Volume = 0.2 })
	I[68] = new("Sound", nil, "Sound", { PlaybackSpeed = 1.5, Volume = 0.2 })
	I[69] = new("Sound", nil, "Sound", { PlaybackSpeed = 1.5, Volume = 0.2 })
	I[70] = new("Sound", nil, "Sound", { PlaybackSpeed = 1.5, Volume = 0.2 })
	I[71] = new("Sound", nil, "Sound", { PlaybackSpeed = 1.5, Volume = 0.2 })
	I[72] = new("Sound", nil, "Sound", { PlaybackSpeed = 1.5, Volume = 0.2 })
	I[73] = new("Sound", nil, "Sound", { PlaybackSpeed = 1.5, Volume = 0.2 })
	I[74] = new("Sound", nil, "Sound", { PlaybackSpeed = 1.5, Volume = 0.2 })
	I[75] = new("Sound", nil, "Sound", { PlaybackSpeed = 1.5, Volume = 0.2 })
	I[76] = new("Sound", nil, "Sound", { PlaybackSpeed = 1.5, Volume = 0.2 })
	I[77] = new("Sound", nil, "Sound", { PlaybackSpeed = 1.5, Volume = 0.2 })
	I[78] = new("Sound", nil, "Sound", { PlaybackSpeed = 1.5, Volume = 0.2 })
	I[79] = new("Sound", nil, "Sound", { PlaybackSpeed = 1.5, Volume = 0.2 })
	I[80] = new("Sound", nil, "Sound", { PlaybackSpeed = 1.5, Volume = 0.2 })
	I[81] = new("Sound", nil, "Sound", { PlaybackSpeed = 1.5, Volume = 0.2 })
	I[82] = new("Sound", nil, "Sound", { PlaybackSpeed = 1.5, Volume = 0.2 })
	I[83] = new("Sound", nil, "Sound", { PlaybackSpeed = 0.8 })
	I[84] = new("Sound", nil, "Sound", { PlaybackSpeed = 0.8 })
	I[85] = new("Sound", nil, "Sound", { PlaybackSpeed = 0.8 })
	I[86] = new("Sound", nil, "Sound", { PlaybackSpeed = 0.8 })
	I[87] = new("Sound", nil, "Sound", { PlaybackSpeed = 0.8 })
	I[88] = new("Sound", nil, "Sound", { PlaybackSpeed = 1.2, Volume = 0.3 })
	I[89] = new("Sound", nil, "Sound", { PlaybackSpeed = 1.3, Volume = 0.4 })
	I[90] = new("Sound", nil, "Sound", { PlaybackSpeed = 2, Volume = 0.6 })
	I[91] = new("Sound", nil, "Sound", { PlaybackSpeed = 1.7 })
	I[92] = new("Sound", nil, "Sound", { PlaybackSpeed = 0.8 })
	I[93] = new("Sound", nil, "Sound", { PlaybackSpeed = 1.5, Volume = 0.2 })
	I[94] = new("Sound", nil, "Sound", { PlaybackSpeed = 1.7 })
	I[95] = new("Sound", nil, "Sound", { PlaybackSpeed = 1.7 })
	I[96] = new("Sound", nil, "Sound", { PlaybackSpeed = 1.7 })
	I[97] = new("Sound", nil, "Sound", { PlaybackSpeed = 1.7 })
	I[98] = new("Sound", nil, "Sound", { PlaybackSpeed = 1.7 })
	I[99] = new("Sound", nil, "Sound", { PlaybackSpeed = 1.2, Volume = 0.3 })
	I[100] = new("Sound", nil, "Sound", { PlaybackSpeed = 1.2, Volume = 0.3 })
	I[101] = new("Sound", nil, "Sound", { PlaybackSpeed = 1.2, Volume = 0.3 })
	I[102] = new("Sound", nil, "Sound", { PlaybackSpeed = 1.2, Volume = 0.3 })
	I[103] = new("Sound", nil, "Sound", { PlaybackSpeed = 1.2, Volume = 0.3 })
	I[104] = new("Sound", nil, "Sound", { PlaybackSpeed = 2, Volume = 0.6 })
	I[105] = new("Sound", nil, "Sound", { PlaybackSpeed = 2, Volume = 0.6 })
	I[106] = new("Sound", nil, "Sound", { PlaybackSpeed = 2, Volume = 0.6 })
	I[107] = new("Sound", nil, "Sound", { PlaybackSpeed = 2, Volume = 0.6 })
	I[108] = new("Sound", nil, "Sound", { PlaybackSpeed = 2, Volume = 0.6 })
	I[109] = new("Sound", nil, "Sound", { PlaybackSpeed = 1.5, Volume = 0.2 })
	I[110] = new("Sound", nil, "Sound", { PlaybackSpeed = 1.5, Volume = 0.2 })
	I[111] = new("Sound", nil, "Sound", { PlaybackSpeed = 1.5, Volume = 0.2 })
	I[112] = new("Sound", nil, "Sound", { PlaybackSpeed = 1.5, Volume = 0.2 })
	I[113] = new("Sound", nil, "Sound", { PlaybackSpeed = 1.5, Volume = 0.2 })
	I[114] = new("Sound", nil, "Sound", { PlaybackSpeed = 1.5, Volume = 0.2 })
	I[115] = new("Sound", nil, "Sound", { PlaybackSpeed = 1.5, Volume = 0.2 })
	I[116] = new("Sound", nil, "Sound", { PlaybackSpeed = 1.5, Volume = 0.2 })
	I[117] = new("Sound", nil, "Sound", { PlaybackSpeed = 1.5, Volume = 0.2 })
	I[118] = new("Sound", nil, "Sound", { PlaybackSpeed = 1.5, Volume = 0.2 })
	I[119] = new("Sound", nil, "Sound", { PlaybackSpeed = 1.5, Volume = 0.2 })
	I[120] = new("Sound", nil, "Sound", { PlaybackSpeed = 1.5, Volume = 0.2 })
	I[121] = new("Sound", nil, "Sound", { PlaybackSpeed = 1.5, Volume = 0.2 })
	I[122] = new("Sound", nil, "Sound", { PlaybackSpeed = 1.5, Volume = 0.2 })
	I[123] = new("Sound", nil, "Sound", { PlaybackSpeed = 1.5, Volume = 0.2 })
	I[124] = new("Sound", nil, "Sound", { PlaybackSpeed = 0.8 })
	I[125] = new("Sound", nil, "Sound", { PlaybackSpeed = 0.8 })
	I[126] = new("Sound", nil, "Sound", { PlaybackSpeed = 0.8 })
	I[127] = new("Sound", nil, "Sound", { PlaybackSpeed = 0.8 })
	I[128] = new("Sound", nil, "Sound", { PlaybackSpeed = 0.8 })
	I[129] = new("Sound", nil, "Sound", { PlaybackSpeed = 1.3, Volume = 0.4 })
	I[130] = new("Sound", nil, "Sound", { PlaybackSpeed = 1.3, Volume = 0.4 })
	I[131] = new("Sound", nil, "Sound", { PlaybackSpeed = 1.3, Volume = 0.4 })
	I[132] = new("Sound", nil, "Sound", { PlaybackSpeed = 1.3, Volume = 0.4 })
	I[133] = new("Sound", nil, "Sound", { PlaybackSpeed = 1.3, Volume = 0.4 })
	I[134] = new("Sound", nil, "Sound", { PlaybackSpeed = 1.3, Volume = 0.4 })
	I[135] = new("Sound", nil, "Sound", { PlaybackSpeed = 1.3, Volume = 0.4 })
	I[136] = new("Sound", nil, "Sound", { PlaybackSpeed = 1.3, Volume = 0.4 })
	I[137] = new("Sound", nil, "Sound", { PlaybackSpeed = 1.3, Volume = 0.4 })
	I[138] = new("Sound", nil, "Sound", { PlaybackSpeed = 1.3, Volume = 0.4 })
	I[139] = new("Sound", nil, "Sound", { PlaybackSpeed = 1.3, Volume = 0.4 })
	I[140] = new("Sound", nil, "Sound", { PlaybackSpeed = 1.3, Volume = 0.4 })
	I[141] = new("Sound", nil, "Sound", { PlaybackSpeed = 1.3, Volume = 0.4 })
	I[142] = new("Sound", nil, "Sound", { PlaybackSpeed = 1.3, Volume = 0.4 })
	I[143] = new("Sound", nil, "Sound", { PlaybackSpeed = 1.3, Volume = 0.4 })
	I[144] = new("SoundGroup", nil, "Master", { Volume = 1 })
		I[145] = new("AudioLimiter", I[144], "AudioLimiter", { MaxLevel = -1.5 })
		I[146] = new("SoundGroup", I[144], "MonsterCombat", { Volume = 0.9 })
		I[147] = new("SoundGroup", I[144], "MonsterState", { Volume = 0.85 })
			I[148] = new("CompressorSoundEffect", I[147], "CompressorSoundEffect", { Attack = 0.01, Ratio = 2, Release = 0.15, Threshold = -12 })
		I[149] = new("SoundGroup", I[144], "MonsterAmbient", { Volume = 0.75 })
			I[150] = new("CompressorSoundEffect", I[149], "CompressorSoundEffect", { Attack = 0.02, Ratio = 2.5, Release = 0.25, Threshold = -14 })
		I[151] = new("SoundGroup", I[144], "MonsterMusic", { Volume = 0.75 })
		I[152] = new("SoundGroup", I[144], "Monster", { Volume = 0.85 })
		I[153] = new("SoundGroup", I[144], "Footsteps", { Volume = 0.8 })
			I[154] = new("CompressorSoundEffect", I[153], "CompressorSoundEffect", { Attack = 0.01, Ratio = 2.5, Release = 0.15, Threshold = -14 })
		I[155] = new("SoundGroup", I[144], "SFX", { Volume = 0.8 })
			I[156] = new("CompressorSoundEffect", I[155], "CompressorSoundEffect", { Attack = 0.02, Ratio = 2.5, Release = 0.25, Threshold = -15 })
		I[157] = new("SoundGroup", I[144], "Ambience", { Volume = 0.6 })
			I[158] = new("CompressorSoundEffect", I[157], "CompressorSoundEffect", { Attack = 0.03, Ratio = 2, Release = 0.4, Threshold = -16 })
		I[159] = new("SoundGroup", I[144], "Music")
			I[160] = new("CompressorSoundEffect", I[159], "CompressorSoundEffect", { Attack = 0.04, Ratio = 2.5, Release = 0.6, Threshold = -18 })
		I[161] = new("SoundGroup", I[144], "UI", { Volume = 0.65 })
		I[162] = new("SoundGroup", I[144], "ItemUsage", { Volume = 0.75 })
			I[163] = new("CompressorSoundEffect", I[162], "CompressorSoundEffect", { Attack = 0.02, Ratio = 2, Release = 0.25, Threshold = -15 })
		I[164] = new("SoundGroup", I[144], "Environmental", { Volume = 0.7 })
			I[165] = new("CompressorSoundEffect", I[164], "CompressorSoundEffect", { Attack = 0.025, Ratio = 2, Release = 0.35, Threshold = -16 })
		I[166] = new("SoundGroup", I[144], "LevelEvents", { Volume = 0.85 })
			I[167] = new("CompressorSoundEffect", I[166], "CompressorSoundEffect", { Attack = 0.02, Ratio = 2, Release = 0.3, Threshold = -14 })
		I[168] = new("SoundGroup", I[144], "Elevator", { Volume = 0.75 })
			I[169] = new("CompressorSoundEffect", I[168], "CompressorSoundEffect", { Attack = 0.02, Ratio = 2, Release = 0.3, Threshold = -15 })
		I[170] = new("SoundGroup", I[144], "Machines", { Volume = 0.8 })
			I[171] = new("CompressorSoundEffect", I[170], "CompressorSoundEffect", { Attack = 0.02, Ratio = 2, Release = 0.25, Threshold = -14 })
	I[7].SoundGroup = I[28]
	I[8].SoundGroup = I[28]
	I[9].SoundGroup = I[28]
	I[10].SoundGroup = I[28]
	I[11].SoundGroup = I[28]
	I[12].SoundGroup = I[28]
	I[13].SoundGroup = I[28]
	I[14].SoundGroup = I[28]
	I[19].SideChain = I[17]
	I[21].SideChain = I[18]
	I[25].SideChain = I[18]
	I[27].SideChain = I[17]
	I[29].SideChain = I[18]
	I[31].SideChain = I[17]
	I[34].SideChain = I[17]
	I[36].SideChain = I[17]
	I[38].SideChain = I[17]
	I[40].SideChain = I[17]
	I[42].SideChain = I[17]
	I[148].SideChain = I[146]
	I[150].SideChain = I[147]
	I[154].SideChain = I[147]
	I[156].SideChain = I[146]
	I[158].SideChain = I[147]
	I[160].SideChain = I[146]
	I[163].SideChain = I[146]
	I[165].SideChain = I[146]
	I[167].SideChain = I[146]
	I[169].SideChain = I[146]
	I[171].SideChain = I[146]
	return { I[1], I[6], I[15], I[43], I[44], I[45], I[46], I[47], I[48], I[49], I[50], I[51], I[52], I[53], I[54], I[55], I[56], I[57], I[58], I[59], I[60], I[61], I[62], I[63], I[64], I[65], I[66], I[67], I[68], I[69], I[70], I[71], I[72], I[73], I[74], I[75], I[76], I[77], I[78], I[79], I[80], I[81], I[82], I[83], I[84], I[85], I[86], I[87], I[88], I[89], I[90], I[91], I[92], I[93], I[94], I[95], I[96], I[97], I[98], I[99], I[100], I[101], I[102], I[103], I[104], I[105], I[106], I[107], I[108], I[109], I[110], I[111], I[112], I[113], I[114], I[115], I[116], I[117], I[118], I[119], I[120], I[121], I[122], I[123], I[124], I[125], I[126], I[127], I[128], I[129], I[130], I[131], I[132], I[133], I[134], I[135], I[136], I[137], I[138], I[139], I[140], I[141], I[142], I[143], I[144] }
end

return build
