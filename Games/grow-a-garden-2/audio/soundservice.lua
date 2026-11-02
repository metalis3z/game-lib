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
		I[3] = new("Sound", I[2], "Click", { PlaybackSpeed = 0.85 }, nil, { "LazyLoadSound" })
		I[4] = new("Sound", I[2], "OfflineGrowthNormal", { RollOffMode = Enum.RollOffMode.InverseTapered, Volume = 2 })
		I[5] = new("Sound", I[2], "PlantSFX", { RollOffMode = Enum.RollOffMode.InverseTapered })
		I[6] = new("Sound", I[2], "Hover", { PlaybackSpeed = 1.02 })
		I[7] = new("Sound", I[2], "responseText", { PlaybackSpeed = 0.96 })
		I[8] = new("Sound", I[2], "Failed")
		I[9] = new("Sound", I[2], "Purchase")
		I[10] = new("Sound", I[2], "Happy", { Volume = 0 })
		I[11] = new("Sound", I[2], "Notification", { PlaybackSpeed = 0.99, RollOffMode = Enum.RollOffMode.InverseTapered }, nil, { "LazyLoadSound" })
		I[12] = new("Sound", I[2], "Hit_SFX")
		I[13] = new("Sound", I[2], "MenuOpenClose", { PlaybackSpeed = 0.97 })
		I[14] = new("Sound", I[2], "GrowComplete")
		I[15] = new("Sound", I[2], "Swing")
		I[16] = new("Sound", I[2], "Water")
		I[17] = new("Sound", I[2], "LaserBeam")
		I[18] = new("Sound", I[2], "DoorOpen")
		I[19] = new("Sound", I[2], "OfflineGrowthIntense", { RollOffMode = Enum.RollOffMode.InverseTapered, Volume = 2 })
		I[20] = new("Sound", I[2], "Werewolf Howl", { Volume = 0.05 })
		I[21] = new("Sound", I[2], "CrowbarSFX")
		I[22] = new("Sound", I[2], "FreezeRay", nil, nil, { "LazyLoadSound" })
		I[23] = new("Sound", I[2], "Freeze", nil, nil, { "LazyLoadSound" })
		I[24] = new("Sound", I[2], "PowerHose")
		I[25] = new("Sound", I[2], "RainbowPoof")
		I[26] = new("Sound", I[2], "Snap")
		I[27] = new("Sound", I[2], "ChainMove")
		I[28] = new("Sound", I[2], "ChainImpact", { TimePosition = 1 })
		I[29] = new("Sound", I[2], "Gear", { Looped = true, Volume = 0.25 })
		I[30] = new("Sound", I[2], "Forge")
		I[31] = new("Sound", I[2], "ChainBreak")
			I[32] = new("ReverbSoundEffect", I[31], "ReverbSoundEffect", { DecayTime = 0.5, Diffusion = 0, DryLevel = 0, WetLevel = 3 })
		I[33] = new("Sound", I[2], "ChainImpact2")
		I[34] = new("Sound", I[2], "ShakeLoop", { Looped = true, Volume = 0 }, nil, { "LazyLoadSound" })
		I[35] = new("Sound", I[2], "Restock")
		I[36] = new("Sound", I[2], "LevelUp", { TimePosition = 1 })
		I[37] = new("Sound", I[2], "Teleport")
		I[38] = new("Sound", I[2], "HoverSFX")
		I[39] = new("Sound", I[2], "WeedFreeze")
		I[40] = new("Sound", I[2], "SkillPointSFX", { Volume = 1 })
		I[41] = new("Sound", I[2], "Scroll")
		I[42] = new("Sound", I[2], "Gravity")
		I[43] = new("Sound", I[2], "ImpactTouch")
		I[44] = new("Sound", I[2], "RaccoonPickup")
		I[45] = new("Sound", I[2], "Whoosh", { Volume = 1 })
			I[46] = new("PitchShiftSoundEffect", I[45], "PitchShiftSoundEffect", { Octave = 0.9 })
		I[47] = new("Sound", I[2], "VineStrike", { Volume = 1 })
		I[48] = new("Sound", I[2], "Vine Cast", { Volume = 0.8 })
		I[49] = new("Sound", I[2], "VineCrumble", { Volume = 1 })
		I[50] = new("Sound", I[2], "StealSFX", nil, nil, { "LazyLoadSound" })
		I[51] = new("Sound", I[2], "CoinCollect")
		I[52] = new("Sound", I[2], "Dice_Roll", { Volume = 1 })
		I[53] = new("Sound", I[2], "burnEffect")
		I[54] = new("Sound", I[2], "Tick", nil, nil, { "LazyLoadSound" })
		I[55] = new("Sound", I[2], "RecordSale", { RollOffMode = Enum.RollOffMode.InverseTapered, Volume = 0.65 })
		I[56] = new("Folder", I[2], "CollectSFX")
			I[57] = new("Sound", I[56], "Bloodlit")
			I[58] = new("Sound", I[56], "Frozen")
			I[59] = new("Sound", I[56], "Electric")
			I[60] = new("Sound", I[56], "Rainbow")
			I[61] = new("Sound", I[56], "Gold")
			I[62] = new("Sound", I[56], "Collect")
			I[63] = new("Sound", I[56], "Starstruck")
		I[64] = new("Folder", I[2], "Sprinkler")
			I[65] = new("Sound", I[64], "Loop")
		I[66] = new("Folder", I[2], "CrateSFX")
			I[67] = new("Sound", I[66], "CrateLand", { RollOffMaxDistance = 200 })
			I[68] = new("Sound", I[66], "CrateCollect", { RollOffMaxDistance = 200 })
			I[69] = new("Sound", I[66], "CrateExplode", { RollOffMaxDistance = 200, Volume = 0.2 })
			I[70] = new("Sound", I[66], "CrateShake", { RollOffMaxDistance = 200 })
			I[71] = new("Sound", I[66], "CrateSpawn", { RollOffMaxDistance = 200 })
			I[72] = new("Sound", I[66], "CrateReward", { RollOffMaxDistance = 200 })
		I[73] = new("Folder", I[2], "Ambience")
		I[74] = new("Folder", I[2], "ChainAttacks")
			I[75] = new("Sound", I[74], "Chain")
		I[76] = new("Folder", I[2], "SeedpackSFX")
			I[77] = new("Sound", I[76], "SeedpackCollect")
			I[78] = new("Sound", I[76], "RainbowReward", nil, nil, { "LazyLoadSound" })
			I[79] = new("Sound", I[76], "SeedpackOpen")
			I[80] = new("Sound", I[76], "SeedpackClick", nil, nil, { "LazyLoadSound" })
			I[81] = new("Sound", I[76], "SeedpackReward")
			I[82] = new("Sound", I[76], "SeedpackSpawn", { RollOffMaxDistance = 200 })
		I[83] = new("Folder", I[2], "GrowSFX")
			I[84] = new("Sound", I[83], "Large")
			I[85] = new("Sound", I[83], "Medium")
			I[86] = new("Sound", I[83], "Small")
		I[87] = new("Folder", I[2], "FruitSFX")
			I[88] = new("Sound", I[87], "Electric")
			I[89] = new("Sound", I[87], "Frozen")
			I[90] = new("Sound", I[87], "Gold")
			I[91] = new("Sound", I[87], "Bloodlit")
			I[92] = new("Sound", I[87], "Rainbow")
			I[93] = new("Sound", I[87], "Default")
			I[94] = new("Sound", I[87], "Starstruck")
		I[95] = new("Folder", I[2], "Shovel_SFX")
			I[96] = new("Sound", I[95], "Equip")
			I[97] = new("Sound", I[95], "Unequip")
		I[98] = new("Folder", I[2], "Trowel_SFX")
			I[99] = new("Sound", I[98], "Equip")
			I[100] = new("Sound", I[98], "Unequip")
		I[101] = new("Folder", I[2], "BargainSFX")
			I[102] = new("Sound", I[101], "Decline")
			I[103] = new("Sound", I[101], "Accept")
		I[104] = new("Folder", I[2], "SellSFX")
			I[105] = new("Sound", I[104], "Rainbow", { TimePosition = 1 })
			I[106] = new("Sound", I[104], "Normal", { PlaybackSpeed = 1.02 })
		I[107] = new("Folder", I[2], "GearShopSFX")
			I[108] = new("Sound", I[107], "ItemUnequip")
			I[109] = new("Sound", I[107], "ItemEquip")
		I[110] = new("Folder", I[2], "Wateringcan_SFX")
			I[111] = new("Sound", I[110], "Equip")
			I[112] = new("Sound", I[110], "Unequip")
	I[113] = new("Folder", nil, "NPC_SFX")
		I[114] = new("Sound", I[113], "Sam", { PlaybackSpeed = 0.95 })
		I[115] = new("Sound", I[113], "Steven", { PlaybackSpeed = 0.97 })
		I[116] = new("Sound", I[113], "Rolf")
		I[117] = new("Sound", I[113], "NPC_Text")
	I[118] = new("Folder", nil, "WeatherSFX")
		I[119] = new("Sound", I[118], "Rain", { Looped = true })
		I[120] = new("Folder", I[118], "Lightning")
			I[121] = new("Sound", I[120], "SFX")
			I[122] = new("Sound", I[120], "SFX")
			I[123] = new("Sound", I[120], "SFX")
			I[124] = new("Sound", I[120], "SFX")
			I[125] = new("Sound", I[120], "SFX")
	I[126] = new("Folder", nil, "MusicTracks")
		I[127] = new("Folder", I[126], "Day")
			I[128] = new("Sound", I[127], "Track1", { Looped = true }, nil, { "LazyLoadSound" })
			I[129] = new("Sound", I[127], "Track2", nil, nil, { "LazyLoadSound" })
			I[130] = new("Sound", I[127], "Track4", nil, nil, { "LazyLoadSound" })
			I[131] = new("Sound", I[127], "Track3", nil, nil, { "LazyLoadSound" })
		I[132] = new("Folder", I[126], "Chained Moon")
			I[133] = new("Sound", I[132], "Track2")
			I[134] = new("Sound", I[132], "Track1")
		I[135] = new("Folder", I[126], "Bloodmoon")
			I[136] = new("Sound", I[135], "Track1", { Volume = 3 })
		I[137] = new("Folder", I[126], "Goldmoon")
			I[138] = new("Sound", I[137], "Track2")
			I[139] = new("Sound", I[137], "Track3")
			I[140] = new("Sound", I[137], "Track1")
		I[141] = new("Folder", I[126], "Moon")
			I[142] = new("Sound", I[141], "Track1")
		I[143] = new("Folder", I[126], "Pizza Moon")
			I[144] = new("Sound", I[143], "Track2")
			I[145] = new("Sound", I[143], "Track1")
		I[146] = new("Folder", I[126], "Rainbow")
			I[147] = new("Sound", I[146], "Track2")
			I[148] = new("Sound", I[146], "Track1")
		I[149] = new("Folder", I[126], "Rainbow Moon")
			I[150] = new("Sound", I[149], "Track2")
			I[151] = new("Sound", I[149], "Track1")
		I[152] = new("Folder", I[126], "Snowfall")
			I[153] = new("Sound", I[152], "Track1")
		I[154] = new("Folder", I[126], "Starfall")
			I[155] = new("Sound", I[154], "Track1")
		I[156] = new("Folder", I[126], "Sunset")
			I[157] = new("Sound", I[156], "SFX")
			I[158] = new("Sound", I[156], "SFX", { Playing = true, TimePosition = 549.675 })
			I[159] = new("Sound", I[156], "SFX")
	I[160] = new("SoundGroup", nil, "Master", { Volume = 1 })
		I[161] = new("EqualizerSoundEffect", I[160], "EqualizerSoundEffect", { Enabled = false, HighGain = -10, LowGain = 7 }, nil, { "UnderWater" })
		I[162] = new("PitchShiftSoundEffect", I[160], "PitchShiftSoundEffect", { Enabled = false, Octave = 1 }, nil, { "UnderWater" })
		I[163] = new("SoundGroup", I[160], "GameMusic", { Volume = 1 })
			I[164] = new("SoundGroup", I[163], "ClientMusic", { Volume = 1 })
	I[165] = new("SoundGroup", nil, "SFXGroup", { Volume = 1 })
	I[166] = new("Sound", nil, "Sound")
	I[167] = new("Sound", nil, "Sound")
	I[168] = new("Folder", nil, "EggOpenSoundCache")
		I[169] = new("Sound", I[168], "Sound")
		I[170] = new("Sound", I[168], "Sound")
		I[171] = new("Sound", I[168], "Sound")
		I[172] = new("Sound", I[168], "Sound")
		I[173] = new("Sound", I[168], "Sound")
		I[174] = new("Sound", I[168], "Sound")
		I[175] = new("Sound", I[168], "Sound")
		I[176] = new("Sound", I[168], "Sound")
		I[177] = new("Sound", I[168], "Sound")
		I[178] = new("Sound", I[168], "Sound")
		I[179] = new("Sound", I[168], "Sound")
		I[180] = new("Sound", I[168], "Sound")
		I[181] = new("Sound", I[168], "Sound")
		I[182] = new("Sound", I[168], "Sound")
	I[3].SoundGroup = I[165]
	I[4].SoundGroup = I[165]
	I[5].SoundGroup = I[165]
	I[6].SoundGroup = I[165]
	I[7].SoundGroup = I[165]
	I[8].SoundGroup = I[165]
	I[9].SoundGroup = I[165]
	I[10].SoundGroup = I[165]
	I[11].SoundGroup = I[165]
	I[12].SoundGroup = I[165]
	I[13].SoundGroup = I[165]
	I[14].SoundGroup = I[165]
	I[15].SoundGroup = I[165]
	I[16].SoundGroup = I[165]
	I[17].SoundGroup = I[165]
	I[18].SoundGroup = I[165]
	I[19].SoundGroup = I[165]
	I[20].SoundGroup = I[165]
	I[21].SoundGroup = I[165]
	I[22].SoundGroup = I[165]
	I[23].SoundGroup = I[165]
	I[24].SoundGroup = I[165]
	I[25].SoundGroup = I[165]
	I[26].SoundGroup = I[165]
	I[27].SoundGroup = I[165]
	I[28].SoundGroup = I[165]
	I[29].SoundGroup = I[165]
	I[30].SoundGroup = I[165]
	I[31].SoundGroup = I[165]
	I[33].SoundGroup = I[165]
	I[34].SoundGroup = I[165]
	I[35].SoundGroup = I[165]
	I[36].SoundGroup = I[165]
	I[37].SoundGroup = I[165]
	I[38].SoundGroup = I[165]
	I[39].SoundGroup = I[165]
	I[40].SoundGroup = I[165]
	I[41].SoundGroup = I[165]
	I[42].SoundGroup = I[165]
	I[43].SoundGroup = I[165]
	I[44].SoundGroup = I[165]
	I[45].SoundGroup = I[165]
	I[47].SoundGroup = I[165]
	I[48].SoundGroup = I[165]
	I[49].SoundGroup = I[165]
	I[50].SoundGroup = I[165]
	I[51].SoundGroup = I[165]
	I[52].SoundGroup = I[165]
	I[53].SoundGroup = I[165]
	I[54].SoundGroup = I[165]
	I[55].SoundGroup = I[165]
	I[57].SoundGroup = I[165]
	I[58].SoundGroup = I[165]
	I[59].SoundGroup = I[165]
	I[60].SoundGroup = I[165]
	I[61].SoundGroup = I[165]
	I[62].SoundGroup = I[165]
	I[63].SoundGroup = I[165]
	I[65].SoundGroup = I[165]
	I[67].SoundGroup = I[165]
	I[68].SoundGroup = I[165]
	I[69].SoundGroup = I[165]
	I[70].SoundGroup = I[165]
	I[71].SoundGroup = I[165]
	I[72].SoundGroup = I[165]
	I[75].SoundGroup = I[165]
	I[77].SoundGroup = I[165]
	I[78].SoundGroup = I[165]
	I[79].SoundGroup = I[165]
	I[80].SoundGroup = I[165]
	I[81].SoundGroup = I[165]
	I[82].SoundGroup = I[165]
	I[84].SoundGroup = I[165]
	I[85].SoundGroup = I[165]
	I[86].SoundGroup = I[165]
	I[88].SoundGroup = I[165]
	I[89].SoundGroup = I[165]
	I[90].SoundGroup = I[165]
	I[91].SoundGroup = I[165]
	I[92].SoundGroup = I[165]
	I[93].SoundGroup = I[165]
	I[94].SoundGroup = I[165]
	I[96].SoundGroup = I[165]
	I[97].SoundGroup = I[165]
	I[99].SoundGroup = I[165]
	I[100].SoundGroup = I[165]
	I[102].SoundGroup = I[165]
	I[103].SoundGroup = I[165]
	I[105].SoundGroup = I[165]
	I[106].SoundGroup = I[165]
	I[108].SoundGroup = I[165]
	I[109].SoundGroup = I[165]
	I[111].SoundGroup = I[165]
	I[112].SoundGroup = I[165]
	I[114].SoundGroup = I[165]
	I[115].SoundGroup = I[165]
	I[116].SoundGroup = I[165]
	I[117].SoundGroup = I[165]
	I[119].SoundGroup = I[165]
	I[121].SoundGroup = I[165]
	I[122].SoundGroup = I[165]
	I[123].SoundGroup = I[165]
	I[124].SoundGroup = I[165]
	I[125].SoundGroup = I[165]
	I[128].SoundGroup = I[163]
	I[166].SoundGroup = I[165]
	I[167].SoundGroup = I[165]
	I[169].SoundGroup = I[165]
	I[170].SoundGroup = I[165]
	I[171].SoundGroup = I[165]
	I[172].SoundGroup = I[165]
	I[173].SoundGroup = I[165]
	I[174].SoundGroup = I[165]
	I[175].SoundGroup = I[165]
	I[176].SoundGroup = I[165]
	I[177].SoundGroup = I[165]
	I[178].SoundGroup = I[165]
	I[179].SoundGroup = I[165]
	I[180].SoundGroup = I[165]
	I[181].SoundGroup = I[165]
	I[182].SoundGroup = I[165]
	return { I[1], I[2], I[113], I[118], I[126], I[160], I[165], I[166], I[167], I[168] }
end

return build
